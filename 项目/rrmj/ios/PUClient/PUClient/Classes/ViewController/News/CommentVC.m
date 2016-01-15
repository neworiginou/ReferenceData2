//
//  CommentVC.m
//  PUClient
//
//  Created by RRLhy on 15/8/14.
//  Copyright (c) 2015年 RRLhy. All rights reserved.
//

#import "CommentVC.h"
#import "CotainView.h"
#import "NewsCommentApi.h"
#import "CommentListModel.h"
#import "AuthorModel.h"
#import "CommentCell.h"
#import "PulishCommentApi.h"

@interface CommentVC ()<UITableViewDataSource,UITableViewDelegate>
{
    CotainView * containView;
    NSInteger currentPage;
    BOOL isRefreshing;
}
@property (weak, nonatomic) IBOutlet UITableView *commentTableView;
@property (nonatomic,strong)NSMutableArray * sourceArray;
@property (weak, nonatomic) IBOutlet UIImageView *textBackGround;

@end

@implementation CommentVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.navImage.image = [UIImage stretchImageWithName:@"nav_bg_black"];
    self.titleLabel.text = @"评论";
    currentPage = 1;
    
    self.textBackGround.image = [UIImage stretchImageWithName:@"btn_me_to-register_n"];
    UITapGestureRecognizer * gesture = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(becomeResponder)];
    [self.textBackGround addGestureRecognizer:gesture];
    
    //注册键盘通知
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(keyboardWillShow:)
                                                 name:UIKeyboardWillShowNotification
                                               object:nil];
    
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(keyboardWillHide:)
                                                 name:UIKeyboardWillHideNotification
                                               object:nil];
    
    [self.view bringSubviewToFront:self.inputView];
    
    __weak CommentVC * weakself = self;
    self.commentTableView.header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
        currentPage = 1;
        isRefreshing = YES;
        [weakself requestData];
    }];
    
    self.commentTableView.footer = [MJRefreshAutoStateFooter footerWithRefreshingBlock:^{
        isRefreshing = NO;
        [weakself requestData];
    }];
    
    [self showTextInPutView];
    [IanAlert showloadingAllowUserInteraction:YES];
    [self requestData];
    
    UINib * nib = [UINib nibWithNibName:NSStringFromClass([CommentCell class]) bundle:nil];
    [self.commentTableView registerNib:nib forCellReuseIdentifier:[CommentCell cellIndentifier]];
}

- (NSMutableArray*)sourceArray
{
    if (!_sourceArray) {
        _sourceArray = [[NSMutableArray alloc]init];
    }
    return _sourceArray;
}

- (void)requestData
{
    NSString * infoId;
    if (self.reviewModel) {
        infoId = self.reviewModel.ID;
    }else{
        infoId = self.infoModel.ID;
    }
    NSString * page = [NSString stringWithFormat:@"%ld",(long)currentPage];
    NewsCommentApi * api = [[NewsCommentApi alloc]initWithNewsId:infoId commentPage:page];
    [api startWithCompletionBlockWithSuccess:^(YTKBaseRequest *request) {
        NSDictionary * dic = request.responseJSONObject;
        [_commentTableView.header endRefreshing];
        [_commentTableView.footer endRefreshing];
        NSLog(@"---评论列表--%@",dic);
        if (dic) {
            JsonModel * json = [JsonModel objectWithKeyValues:dic];
            
            if (json.code == SUCCESSCODE) {
                
                if (isRefreshing) {
                    [_sourceArray removeAllObjects];
                    isRefreshing = NO;
                }
                CommentListModel * list= [CommentListModel objectWithKeyValues:json.data];
                
                [self.sourceArray addObjectsFromArray:list.results];
                
                [_commentTableView reloadData];
                
                if (list.results.count>0) {
                    currentPage = [list.currentPage integerValue] + 1;
                }
                
                [IanAlert hideLoading];
                
            }else{
                
                [IanAlert alertError:json.msg length:TIMELENGTH];
            }
        }else{
            
            [IanAlert alertError:ERRORMSG1 length:TIMELENGTH];
        }
        
    } failure:^(YTKBaseRequest *request) {
        
        [_commentTableView.header endRefreshing];
        [_commentTableView.footer endRefreshing];
        [IanAlert alertError:ERRORMSG2 length:TIMELENGTH];
        
    }];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.sourceArray.count;
}

#pragma mark 每一行怎样显示cell
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
   
    CommentCell * cell = [tableView dequeueReusableCellWithIdentifier:[CommentCell cellIndentifier]];
    if (cell == nil) {
        cell = [CommentCell commentCellAtIndex:0];
    }
    
    cell = [cell cellWithComment:self.sourceArray[indexPath.row]];
    
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return [tableView fd_heightForCellWithIdentifier:[CommentCell cellIndentifier] configuration:^(id cell) {
  
        CommentCell * commentCell = cell;
        commentCell = [commentCell cellWithComment:self.sourceArray[indexPath.row]];
       
    }];
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    
}

#pragma mark 评论输入框
- (void)showTextInPutView
{
    containView = [[CotainView alloc]initWithFrame:CGRectMake(0, Main_Screen_Height, Main_Screen_Width, 80)];
    [containView.syncBtn addTarget:self action:@selector(syncToSeriesCycle:) forControlEvents:UIControlEventTouchUpInside];
    [containView.sendBtn addTarget:self action:@selector(sendComment) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:containView];
}

#pragma mark 同步转发
- (void)syncToSeriesCycle:(UIButton*)sender
{
    sender.selected = !sender.selected;
    if (sender.selected) {
        //同步
    }
}
#pragma mark 发表评论
- (void)sendComment
{
    [containView.textTf resignFirstResponder];
    
    if (![UserInfoConfig sharedUserInfoConfig].userInfo.token) {
        [IanAlert alertError:@"还未登录" length:TIMELENGTH];
        return;
    }
    PulishCommentApi * comment = [[PulishCommentApi alloc]initWithInfoId:self.infoModel.ID infoContent:containView.textTf.text parentCommentId:@"1" parentContent:@"你是一个大傻瓜" parentAuthorId:@"1" copy2Active:@"0"];
    [comment startWithCompletionBlockWithSuccess:^(YTKBaseRequest *request) {
        
        NSLog(@"%@",request.responseJSONObject);
        NSDictionary * dic = request.responseJSONObject;
        if (dic) {
            JsonModel * json = [JsonModel objectWithKeyValues:dic];
            if (json.code == SUCCESSCODE) {
                
                [IanAlert alertSuccess:@"评论成功" length:TIMELENGTH];
                
            }else{
                
                [IanAlert alertError:json.msg length:TIMELENGTH];
            }
        }else
        {
            [IanAlert alertError:ERRORMSG1 length:TIMELENGTH];
        }
        
    } failure:^(YTKBaseRequest *request) {
        
        [IanAlert alertError:ERRORMSG2 length:TIMELENGTH];
    
    }];

}

//Code from Brett Schumann
- (void)keyboardWillShow:(NSNotification *)note{
    // get keyboard size and loctaion
    CGRect keyboardBounds;
    [[note.userInfo valueForKey:UIKeyboardFrameEndUserInfoKey] getValue: &keyboardBounds];
    NSNumber *duration = [note.userInfo objectForKey:UIKeyboardAnimationDurationUserInfoKey];
    NSNumber *curve = [note.userInfo objectForKey:UIKeyboardAnimationCurveUserInfoKey];
    
    // Need to translate the bounds to account for rotation.
    keyboardBounds = [self.view convertRect:keyboardBounds toView:nil];
    
    // get a rect for the textView frame
    CGRect containerFrame = containView.frame;
    containerFrame.origin.y = self.view.bounds.size.height - (keyboardBounds.size.height + containerFrame.size.height);
    // animations settings
    [UIView beginAnimations:nil context:NULL];
    [UIView setAnimationBeginsFromCurrentState:YES];
    [UIView setAnimationDuration:[duration doubleValue]];
    [UIView setAnimationCurve:[curve intValue]];
    
    // set views with new info
    containView.frame = containerFrame;
    
    // commit animations
    [UIView commitAnimations];
}

- (void)keyboardWillHide:(NSNotification *)note{
    
    NSNumber *duration = [note.userInfo objectForKey:UIKeyboardAnimationDurationUserInfoKey];
    NSNumber *curve = [note.userInfo objectForKey:UIKeyboardAnimationCurveUserInfoKey];
    
    // get a rect for the textView frame
    CGRect containerFrame = containView.frame;
    containerFrame.origin.y = self.view.bounds.size.height ;
    
    // animations settings
    [UIView beginAnimations:nil context:NULL];
    [UIView setAnimationBeginsFromCurrentState:YES];
    [UIView setAnimationDuration:[duration doubleValue]];
    [UIView setAnimationCurve:[curve intValue]];
    
    // set views with new info
    containView.frame = containerFrame;
    
    // commit animations
    [UIView commitAnimations];
}

- (void)becomeResponder
{
    [containView.textTf becomeFirstResponder];
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    [containView.textTf resignFirstResponder];
}

-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    [self.view.subviews enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop) {
        [((UIView*)obj) resignFirstResponder];
    }];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
