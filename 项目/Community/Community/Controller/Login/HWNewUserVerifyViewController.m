//
//  HWNewUserVerifyViewController.m
//  Community
//
//  Created by caijingpeng.haowu on 15/1/9.
//  Copyright (c) 2015年 caijingpeng. All rights reserved.
//
//  功能描述：新用户绑定微信 填写验证码
//
//  修改记录：
//      姓名         日期               修改内容
//     蔡景鹏     2015-01-14           创建文件
//
//

#import "HWNewUserVerifyViewController.h"
#import "HWRegisterThirdViewController.h"
#import "HWWeChatNewUserVerifyView.h"

@interface HWNewUserVerifyViewController ()<UITextFieldDelegate, HWWeChatNewUserVerifyViewDelegate>
{
    
}
@end

@implementation HWNewUserVerifyViewController
@synthesize telephoneStr;
@synthesize shangxingMessagePhone;
@synthesize weChatAccount;
@synthesize isBind;
@synthesize bindPopViewController;

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.navigationItem.titleView = [Utility navTitleView:@"关联考拉账号"];
    self.navigationItem.leftBarButtonItem = [Utility navLeftBackBtn:self action:@selector(backMethod)];
    
    HWWeChatNewUserVerifyView *verifyView = [[HWWeChatNewUserVerifyView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, CONTENT_HEIGHT) telephoneNum:self.telephoneStr];
    verifyView.weChatAccount = self.weChatAccount;
    verifyView.shangxingMessagePhone = self.shangxingMessagePhone;
    verifyView.delegate = self;
    [self.view addSubview:verifyView];
}

#pragma mark -
#pragma mark            HWWeChatNewUserVerifyView Delegate

/**
 *	@brief	确认发送 验证码 验证成功
 *
 *	@return
 */
- (void)didConfirmVerifyCode
{
    [MobClick event:@"click_submit"];
    
    HWRegisterThirdViewController *thirdVC = [[HWRegisterThirdViewController alloc] init];
    thirdVC.isWeChat = YES;
    thirdVC.weChatAccount = self.weChatAccount;
    thirdVC.telephoneNum = telephoneStr;
    thirdVC.isBind = self.isBind;
    thirdVC.bindPopViewController = self.bindPopViewController;
    thirdVC.isGuest = self.isGuest;
    [self.navigationController pushViewController:thirdVC animated:YES];
}

/**
 *	@brief	发送短信
 *
 *	@param 	bodyOfMessage 	发送内容
 *	@param 	recipients 	接收人
 *
 *	@return
 */
- (void)didSendSMS:(NSString *)bodyOfMessage recipientList:(NSArray *)recipients
{
    MFMessageComposeViewController *controller = [[MFMessageComposeViewController alloc] init];
    if([MFMessageComposeViewController canSendText])
    {
        controller.body = bodyOfMessage;
        
        controller.recipients = recipients;
        
        controller.messageComposeDelegate = self;
        
        [self presentViewController:controller animated:YES completion:nil];
    }
}

#pragma mark -
#pragma mark MFMessage delegate

- (void)messageComposeViewController:(MFMessageComposeViewController *)controller didFinishWithResult:(MessageComposeResult)result
{
    [controller dismissViewControllerAnimated:YES completion:nil];
    
    if (result == MessageComposeResultCancelled)
    {
        NSLog(@"Message cancelled");
        
    }
    else if (result == MessageComposeResultSent)
    {
        NSLog(@"Message sent");
        [self.navigationController popToRootViewControllerAnimated:YES];
    }
    else
    {
        NSLog(@"Message failed");
        // 提示发送失败
    }
    
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
