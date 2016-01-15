//
//  MyPageVC.m
//  PUClient
//
//  Created by RRLhy on 15/7/22.
//  Copyright (c) 2015年 RRLhy. All rights reserved.
//

#import "MyPageVC.h"
#import "NTParallaxView.h"
#import "InformationView.h"
#import "MyItemView.h"
#import "LoginOutApi.h"
#import "SignApi.h"

#define kSCNavBarImageTag 10
@interface MyPageVC ()<UITableViewDelegate,UITableViewDataSource,UINavigationControllerDelegate>
{
    InformationView * topView;
}
@property (weak, nonatomic) IBOutlet UITableView *myTableView;
@property (retain, nonatomic) NSArray * itemsArray;

@end

@implementation MyPageVC

- (void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    [MobClick endLogPageView:@"Page_我的"];
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [MobClick beginLogPageView:@"Page_我的"];
    self.navImage.backgroundColor = [UIColor clearColor];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.leftBtn.hidden = YES;
    self.navImage.image = nil;
    self.rightBtn.hidden = NO;

    if ([self.myTableView respondsToSelector:@selector(setSeparatorInset:)]) {
        
        [self.myTableView setSeparatorInset:UIEdgeInsetsZero];
    }
    
    if ([self.myTableView respondsToSelector:@selector(setLayoutMargins:)]) {
        
        [self.myTableView setLayoutMargins:UIEdgeInsetsZero];
    }
    
    topView = [[InformationView alloc]initWithFrame:CGRectMake(0, 0, Main_Screen_Width, 220)];
    topView.controller = self;
    self.myTableView.tableHeaderView = topView;
    
    [self reloadUIData];
}

- (void)reloadUIData
{
    RrmjUser * me = [UserInfoConfig sharedUserInfoConfig].userInfo;
    if (!me.token) {
        
        self.itemsArray =  @[ @[@{@"title":@"我的消息",@"image":@"icon_me_news"},
                                @{@"title":@"我的视频",@"image":@"icon_me_video"},
                                @{@"title":@"我的资料",@"image":@"icon_me_data"},
                                @{@"title":@"我的等级",@"image":@"icon_me_grade"},
                                @{@"title":@"我的任务",@"image":@"icon_me_character"}],
                              @[@{@"title":@"评价",@"image":@"icon_me_evaluation",@"segueIndetifier":@""},
                                @{@"title":@"设置",@"image":@"icon_me_set-up",@"segueIndetifier":@"mySetting"}]];
    }else{
        
        self.itemsArray =  @[@[@{@"title":@"我的通知",@"image":@"icon_me_news",@"segueIndetifier":@"myNotice"},
                               @{@"title":@"我的动态",@"image":@"icon_me_notice",@"segueIndetifier":@"myDynamic"}],
                             @[@{@"title":@"我的视频",@"image":@"icon_me_video",@"segueIndetifier":@"myVedio"},
                               @{@"title":@"我的资料",@"image":@"icon_me_data",@"segueIndetifier":@"userInformation"},
                               @{@"title":@"我的等级",@"image":@"icon_me_grade",@"segueIndetifier":@"myLevel"},
                               @{@"title":@"我的任务",@"image":@"icon_me_character",@"segueIndetifier":@"myCharacter"}],
                             @[@{@"title":@"评价",@"image":@"icon_me_evaluation",@"segueIndetifier":@""},
                               @{@"title":@"设置",@"image":@"icon_me_set-up",@"segueIndetifier":@"mySetting"}]];
    }
    
    if ([me.hasSignIn boolValue]) {
        [self.rightBtn setImage:IMAGENAME(@"icon_me_checked") forState:UIControlStateNormal];
    }else{
        [self.rightBtn setImage:IMAGENAME(@"icon_me_registration") forState:UIControlStateNormal];

    }
    
    
    _myTableView.tableFooterView = [self tableViewFooterView];
    [topView reloadinformation:[UserInfoConfig sharedUserInfoConfig].userInfo];
    [_myTableView reloadData];
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return  self.itemsArray.count;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [self.itemsArray[section] count];
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    return 0.1;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 40;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    float x = 200.0/1242.0;
    float height = x*Main_Screen_Width;
    if ([UserInfoConfig sharedUserInfoConfig].userInfo.token) {
        return  (section==0?height:0.0) + 17;
    }else{
        return  (section==0?height:0.0) + 30;
    }
}

static NSString * identifyCell = @"identify";
- (UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:identifyCell];
    if(!cell)
    {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault  reuseIdentifier:identifyCell];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    }
    cell.imageView.image = [UIImage imageNamed:self.itemsArray[indexPath.section][indexPath.row][@"image"]];
    cell.textLabel.text = self.itemsArray[indexPath.section][indexPath.row][@"title"];
    return cell;
}

- (UIView*)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    NSArray * indentifier = @[@"myReply",@"myPublish",@"myCollect",@"mySilver"];
    if (section ==0) {
        float x = 200.0/1242.0;
        float height = x*Main_Screen_Width;
        MyItemView * header =[[MyItemView alloc] initWithFrame:CGRectMake(0, 0, Main_Screen_Width, height + 30)];
        header.backgroundColor = [UIColor groupTableViewBackgroundColor];
        header.selectBlock = ^(NSInteger index){
            if ([UserInfoConfig sharedUserInfoConfig].userInfo.token) {
                [self performSegueWithIdentifier:indentifier[index] sender:self];
            }else{
                [self performSegueWithIdentifier:@"login" sender:self];
            }
            
        };
        return header;
    }else{
        
        return nil;
    }
}

- (UIView*)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section
{
    return nil;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if ([UserInfoConfig sharedUserInfoConfig].userInfo.token) {
        
        NSString * indentifier = self.itemsArray[indexPath.section][indexPath.row][@"segueIndetifier"];
        if (indentifier.length) {
           
            [self performSegueWithIdentifier:indentifier sender:self];
        }else{
            //评价
        }
        
    }else{
        
        if (indexPath.section==0) {
            
            [self performSegueWithIdentifier:@"login" sender:self];
            
        }else{
            NSString * indentifier = self.itemsArray[indexPath.section][indexPath.row][@"segueIndetifier"];
            if (indentifier.length) {
                
                [self performSegueWithIdentifier:indentifier sender:self];
            }else{
                //评价
            }
        }
    }

}

- (void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath
{
    if ([cell respondsToSelector:@selector(setSeparatorInset:)]) {
        
        [cell setSeparatorInset:UIEdgeInsetsZero];
    }
    
    if ([cell respondsToSelector:@selector(setLayoutMargins:)]) {
        
        [cell setLayoutMargins:UIEdgeInsetsZero];
    }
}

#pragma mark 退出登录
- (UIView*)tableViewFooterView
{
    if ([UserInfoConfig sharedUserInfoConfig].userInfo.token) {
        
        UIView * view = [[UIView alloc]initWithFrame:CGRectMake(0, 0, Main_Screen_Width, 84)];
        UIImage * bgN = [UIImage stretchImageWithName:@"btn_me_to-register_n"];
        UIImage * bgH = [UIImage stretchImageWithName:@"btn_me_to-register_h"];
        UIButton * loginOutBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [loginOutBtn setFrame:CGRectMake(10, 27, Main_Screen_Width - 20, 30)];
        [loginOutBtn setTitle:@"退出" forState:UIControlStateNormal];
        [loginOutBtn setTitleColor:BLACKCOLOR forState:UIControlStateNormal];
        [loginOutBtn addTarget:self action:@selector(loginOut) forControlEvents:UIControlEventTouchUpInside];
        [loginOutBtn setBackgroundImage:bgN forState:UIControlStateNormal];
        [loginOutBtn setBackgroundImage:bgH forState:UIControlStateHighlighted];
        [view addSubview:loginOutBtn];
        return view;
    }
    
    return nil;
}

- (void)loginOut
{
    [IanAlert showloading];
    LoginOutApi * api = [[LoginOutApi alloc]initWithUserToken:[UserInfoConfig sharedUserInfoConfig].userInfo.token];
    [api startWithCompletionBlockWithSuccess:^(YTKBaseRequest *request) {
        NSDictionary * dic = request.responseJSONObject;
        NSLog(@"%@",dic);
        if (dic) {
            JsonModel * json = [JsonModel objectWithKeyValues:dic];

            if (json.code == SUCCESSCODE) {
                
                RrmjUser * user = [[RrmjUser alloc]init];
                [[UserInfoConfig sharedUserInfoConfig] saveRRMJUser:user];
                [self reloadUIData];
                [IanAlert alertSuccess:@"退出成功" length:1];
            }else{
                
                [IanAlert alertError:json.msg length:1];
            }
        }else{
            
            [IanAlert alertError:ERRORMSG1 length:1];
        }
        
    } failure:^(YTKBaseRequest *request) {
        
        [IanAlert alertError:ERRORMSG2 length:1];
    }];
}
- (void)rightBtnClick {
    
    RrmjUser * me = [UserInfoConfig sharedUserInfoConfig].userInfo;
    if (!me.token) {
        [self skipToLoginVc];
        return;
    }
    if ([me.hasSignIn boolValue]) {
        return;
    }
    SignApi * sign = [[SignApi alloc]initWithUserToken:[UserInfoConfig sharedUserInfoConfig].userInfo.token];
    [sign startWithCompletionBlockWithSuccess:^(YTKBaseRequest *request) {
        NSDictionary * dic = request.responseJSONObject;
        NSLog(@"%@",dic);
        JsonModel * json = [JsonModel objectWithKeyValues:dic];
        if (dic) {
            if (json.code == SUCCESSCODE) {
                
                [self.rightBtn setImage:IMAGENAME(@"icon_me_checked") forState:UIControlStateNormal];
                [IanAlert alertSuccess:[NSString stringWithFormat:@"连续签到%@天",json.data[@"days"]] length:1];
                
            }else{
                
                [IanAlert alertError:json.msg length:1];
            }

        }else{
            
            [IanAlert alertError:ERRORMSG1 length:1];
        }
        
    } failure:^(YTKBaseRequest *request) {
     
        [IanAlert alertError:ERRORMSG2 length:1];
    }];
    
    [self performSegueWithIdentifier:@"mySign" sender:self];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}


@end
