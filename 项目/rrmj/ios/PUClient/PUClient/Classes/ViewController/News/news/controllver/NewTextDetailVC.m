//
//  NewTextDetailVC.m
//  PUClient
//
//  Created by RRLhy on 15/8/13.
//  Copyright (c) 2015年 RRLhy. All rights reserved.
//

#import "NewTextDetailVC.h"
#import "CommentVC.h"
#import "NewsDetailModel.h"
#import "NewsDetailTextApi.h"
#import "NewsDetailModel.h"
#import "RelateSeriesStarView.h"
#import "CotainView.h"
#import "PulishCommentApi.h"
#import "ReviewDetailApi.h"

@interface NewTextDetailVC ()
{
    RelateSeriesStarView * relateView;
    CotainView * containView;
}
@property (weak, nonatomic) IBOutlet UIButton *shareBtn;
@property (weak, nonatomic) IBOutlet UIButton *RelateBtn;
@property (weak, nonatomic) IBOutlet UITextField *inputTf;
@property (weak, nonatomic) IBOutlet UIImageView *inputBack;

@end

@implementation NewTextDetailVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.navImage.image = [UIImage stretchImageWithName:@"nav_bg_black"];
    [self.rightBtn setBackgroundImage:IMAGENAME(@"bg_nav_Review_9") forState:UIControlStateNormal];
    [self.rightBtn setContentMode:UIViewContentModeScaleAspectFit];
    [self.rightBtn setFrame:CGRectMake((Main_Screen_Width - 54), 30, 40, 25)];
    [self.rightBtn setHidden:NO];

    UIButton  * collectBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [collectBtn setImage:IMAGENAME(@"icon_news_collect_n") forState:UIControlStateNormal];
    [collectBtn setImage:IMAGENAME(@"icon_news_collect_n") forState:UIControlStateHighlighted];
    [collectBtn setFrame:CGRectMake(MaxX(self.rightBtn) - 54 - 38, 20, 44, 44)];
    [collectBtn addTarget:self action:@selector(collectInfo) forControlEvents:UIControlEventTouchUpInside];
    [self.navImage addSubview:collectBtn];
    
    [_shareBtn setImage:IMAGENAME(@"icon_news_share_h") forState:UIControlStateHighlighted];
    [_RelateBtn setImage:IMAGENAME(@"icon_news_star_h") forState:UIControlStateHighlighted];
    
    UIImageView * image = [[UIImageView alloc] initWithImage:IMAGENAME(@"icon_news_pen")];
    _inputTf.leftViewMode = UITextFieldViewModeAlways;
    _inputTf.leftView = image;
    _inputBack.image = [UIImage stretchImageWithName:@"btn_me_to-register_n"];
    
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
    [self showRelateView];

    containView = [[CotainView alloc]initWithFrame:CGRectMake(0, Main_Screen_Height, Main_Screen_Width, 80)];
    [containView.syncBtn addTarget:self action:@selector(syncToSeriesCycle:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:containView];
    
    [self requestData];
}

#pragma mark 评论输入框
- (void)showTextInPutView
{
    containView = [[CotainView alloc]initWithFrame:CGRectMake(0, Main_Screen_Height, Main_Screen_Width, 80)];
    [containView.syncBtn addTarget:self action:@selector(syncToSeriesCycle:) forControlEvents:UIControlEventTouchUpInside];
    [containView.sendBtn addTarget:self action:@selector(sendComment) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:containView];
}

#pragma  mark 底部相关美剧
- (void)showRelateView
{
    relateView = [[RelateSeriesStarView alloc]initWithFrame:CGRectZero seriesArray:nil starsArray:nil];
    relateView.seriesAction = ^(NSInteger index){
        
        NSLog(@"剧集id%ld",(long)index);
    };
    
    relateView.starAction = ^(NSInteger index){
        
         NSLog(@"明星id%ld",(long)index);
    };
    
    [self.view addSubview:relateView];
}

#pragma mark 加载数据
- (void)requestData
{
    if (self.type == InfoTypeReview) {
        
        [IanAlert alertSuccess:@"剧评详情" length:TIMELENGTH];
        [self reviewDetail];
        
    }else if(self.type == InfoTypeRating){
        
        [IanAlert alertSuccess:@"收视详情" length:TIMELENGTH];
        [self reviewDetail];
        
    }else{
        
        [IanAlert alertSuccess:@"资讯详情" length:TIMELENGTH];
        [self newsDetail];
    }
}

#pragma mark 资讯详情
- (void)newsDetail
{
    NSString * userId = [UserInfoConfig sharedUserInfoConfig].userInfo.Id;
    NewsDetailTextApi * api = [[NewsDetailTextApi alloc]initWithNewsId:self.infoModel.ID userId:userId];
    [api startWithCompletionBlockWithSuccess:^(YTKBaseRequest *request) {
        
        NSDictionary * dic = request.responseJSONObject;
        NSLog(@"资讯详情 %@",dic);
        if (dic) {
            JsonModel * json = [JsonModel objectWithKeyValues:dic];
            
            if (json.code == SUCCESSCODE) {
                
                NSDictionary * info = json.data[@"info"];
                NewsDetailModel * model = [NewsDetailModel objectWithKeyValues:info];
                
                [relateView configureWithSeries:model.seriesViewList stars:model.actorViewList];
            }else{
                
                [IanAlert alertError:json.msg length:TIMELENGTH];
            }
            
        }else{
            
            [IanAlert alertError:ERRORMSG1 length:TIMELENGTH];
        }
        
        
    } failure:^(YTKBaseRequest *request) {
        
        [IanAlert alertError:ERRORMSG2 length:TIMELENGTH];
        
    }];

}
#pragma mark 剧评/收视详情
- (void)reviewDetail
{
    NSString * userId = [UserInfoConfig sharedUserInfoConfig].userInfo.Id;
    ReviewDetailApi * api = [[ReviewDetailApi alloc]initWithReviewId:self.reviewModel.ID userId:userId];
    [api startWithCompletionBlockWithSuccess:^(YTKBaseRequest *request) {
        
        NSDictionary * dic = request.responseJSONObject;
        NSLog(@" 剧评详情  %@",dic);
        if (dic) {
            JsonModel * json = [JsonModel objectWithKeyValues:dic];
            
            if (json.code == SUCCESSCODE) {
                
                NSDictionary * info = json.data[@"report"];
                NewsDetailModel * model = [NewsDetailModel objectWithKeyValues:info];
                
                [relateView configureWithSeries:model.seriesViewList stars:model.actorViewList];
            }else{
                
                [IanAlert alertError:json.msg length:TIMELENGTH];
            }
            
        }else{
            
            [IanAlert alertError:ERRORMSG1 length:TIMELENGTH];
        }
        
        
    } failure:^(YTKBaseRequest *request) {
        
        [IanAlert alertError:ERRORMSG2 length:TIMELENGTH];
        
    }];

}

#pragma mark 进入评论列表
- (void)rightBtnClick
{
    UIStoryboard * storyboard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
    CommentVC * comment = [storyboard instantiateViewControllerWithIdentifier:@"CommentVC"];
    
    if (self.type == InfoTypeReview) {
        comment.reviewModel = self.reviewModel;
    }else if(self.type == InfoTypeRating){
        comment.reviewModel = self.reviewModel;
    }else{
        comment.infoModel = self.infoModel;
    }
    [self.navigationController pushViewController:comment animated:YES];
}

#pragma mark 收藏
- (void)collectInfo
{
    [self requestData];
}

#pragma mark 相关明星剧集
- (IBAction)relatedSeriesAndStar:(UIButton *)sender {
    
    [relateView showForAnimation];
}

#pragma mark 分享按钮
- (IBAction)shareNewsInfo:(id)sender {
    
    
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

- (void)resignTextView
{
    [self.view endEditing:YES];
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
