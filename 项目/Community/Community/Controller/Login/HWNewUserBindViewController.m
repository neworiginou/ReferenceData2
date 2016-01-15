//
//  HWNewUserBindViewController.m
//  Community
//
//  Created by caijingpeng.haowu on 15/1/9.
//  Copyright (c) 2015年 caijingpeng. All rights reserved.
//
//  功能描述：新用户绑定 填写手机号 或 跳过绑定页面
//
//  修改记录：
//      姓名         日期               修改内容
//     蔡景鹏     2015-01-14           创建文件
//     杨庆龙     2015-01-19           修改了bindView得初始化时机
//

#import "HWNewUserBindViewController.h"
#import "HWWeChatBindTelephoneView.h"
#import "HWNewUserVerifyViewController.h"
#import "HWLocationChangeViewController.h"
#import "HWOldUserBindViewController.h"
@interface HWNewUserBindViewController ()<HWWeChatBindTelephoneViewDelegate>
{
    HWTextField *_telephoneTF;
}
@end

@implementation HWNewUserBindViewController
@synthesize weChatAccount;
@synthesize telephoneNum;
@synthesize isBind;
@synthesize bindPopViewController;

- (instancetype)init
{
    self = [super init];
    if (self)
    {

    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.navigationItem.leftBarButtonItem = [Utility navLeftBackBtn:self action:@selector(backMethod)];
    self.navigationItem.titleView = [Utility navTitleView:@"绑定手机"];
    [self.navigationController setNavigationBarHidden:NO animated:NO];
    
    HWWeChatBindTelephoneView *bindView = [[HWWeChatBindTelephoneView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, CONTENT_HEIGHT)];
    bindView.isGuest = self.isGuest;
    bindView.weChatAccount = self.weChatAccount;
    bindView.delegate = self;
    bindView.telNumber = self.telephoneNum;
    bindView.isBind = self.isBind;
    [self.view addSubview:bindView];
}

#pragma mark -
#pragma mark        HWWeChatBindTelephoneViewDelegate

- (void)didSkipBindSelectVillage
{
    HWLocationChangeViewController *selectCommunityView = [[HWLocationChangeViewController alloc] init];
    selectCommunityView.isCheckIPBindVillageId = YES;
    selectCommunityView.locationChangeFlag = NO;
    selectCommunityView.isNickVCPush = YES;
    [self.navigationController pushViewController:selectCommunityView animated:YES];
}

- (void)didSendVerifyCodePhone:(NSString *)phoneNum shangxingNum:(NSString *)shangxingNum
{
    HWNewUserVerifyViewController *verifyVC = [[HWNewUserVerifyViewController alloc] init];
    verifyVC.telephoneStr = phoneNum;
    verifyVC.weChatAccount = self.weChatAccount;
    verifyVC.shangxingMessagePhone = shangxingNum;
    verifyVC.isBind = self.isBind;
    verifyVC.bindPopViewController = self.bindPopViewController;
    verifyVC.isGuest = self.isGuest;
    [self.navigationController pushViewController:verifyVC animated:YES];
}

- (void)didHaveRegister:(NSString *)telNumber
{
    HWOldUserBindViewController *oldUserBindCtrl = [[HWOldUserBindViewController alloc]init];
    oldUserBindCtrl.telphoneNum = telNumber;
    oldUserBindCtrl.weChatAccount = self.weChatAccount;
    oldUserBindCtrl.isGuest = self.isGuest;
    [self.navigationController pushViewController:oldUserBindCtrl animated:YES];
}

- (void)didReceiveMemoryWarning
{
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
