//
//  HWMsgShareViewModel.m
//  Partner-Swift
//
//  Created by hw500029 on 15/8/25.
//  Copyright (c) 2015年 caijingpeng.haowu. All rights reserved.
//

#import "HWMsgShareViewModel.h"
#import "MobClick.h"
#import "UMSocialData.h"
#import "UMSocialDataService.h"
#import "UMSocialSnsPlatformManager.h"
#import "Partner_Swift-Swift.h"
#import "WXApi.h"

@implementation HWMsgShareViewModel
@synthesize shareContent;
@synthesize shareImage;
@synthesize shareUrl;
@synthesize showView;
@synthesize presentController;
@synthesize projectId;


- (id)initWithShareContent:(NSString *)content image:(UIImage *)image shareUrl:(NSString *)url
{
    self = [super init];
    if (self)
    {
        self.shareUrl = url;
        //        self.shareUrl = @"www.baidu.com";
        self.shareContent = content;
        self.shareImage = image;
    }
    return self;
}

- (void)showInView:(UIView *)view presentController:(UIViewController *)controller
{    
    //MYP add v3.2修改
    actionSheet = [[MTCustomActionSheet alloc] initWithFrame:CGRectZero andImageArr:[NSArray arrayWithObjects:@"share_friend",@"share_weixin",@"share_sms", nil] nameArray:[NSArray arrayWithObjects:@"朋友圈",@"微信",@"短信",nil] orientation:0];
    if(![WXApi isWXAppInstalled])
    {
        actionSheet = [[MTCustomActionSheet alloc] initWithFrame:CGRectZero andImageArr:[NSArray arrayWithObjects:@"share_sms", nil] nameArray:[NSArray arrayWithObjects:@"短信",nil] orientation:0];
    }
    
    //@"wechat_moment"   @"微信朋友圈"
    actionSheet.delegate = self;
    [actionSheet showInView:view];
    
    self.showView = view;
    self.presentController = controller;
}

-(void)hideView
{
    [actionSheet doCancel:nil];
}

- (void)actionSheet:(MTCustomActionSheet *)actionSheet didClickButtonByIndex:(int)index
{
    if ([WXApi isWXAppInstalled])
    {
        if (index == 0)
        {
            // 朋友圈
            [self clickFriend];
        }
        else if (index == 1)
        {
            // 微信
            [self clickWeiXinShare];
        }
        else if (index == 2)
        {
            [self clickSMS];
        }
        
    }
    else
    {
        if (index == 0)
        {
            [self clickSMS];
        }
    }
    
}

- (void)clickSMS
{
    [UMSocialData defaultData].urlResource.url = self.shareUrl;
    [UMSocialData defaultData].extConfig.smsData.urlResource.url = self.shareUrl;
    [UMSocialData defaultData].extConfig.smsData.urlResource.resourceType = UMSocialUrlResourceTypeDefault;
    
    //[HWUserLogin currentUserLogin].brokerName
    NSString *contentStr = [NSString stringWithFormat:@"%@邀请您注册好屋合伙人，推荐客户买房，成交便可得高额佣金，注册地址:",[HWUserLogin currentUserLogin].brokerName] ;
    [[UMSocialDataService defaultDataService] postSNSWithTypes:@[UMShareToSms] content:[NSString stringWithFormat:@"%@,%@",contentStr,self.shareUrl] image:nil location:nil urlResource:nil presentedController:self.presentController completion:^(UMSocialResponseEntity *response) {
        if (response.responseCode == UMSResponseCodeSuccess)
        {
            [Utility showToastWithMessage:@"分享成功" _view:showView];
        }
        else
        {
            [Utility showToastWithMessage:@"分享失败" _view:showView];
        }
    }];
    
}

- (void)clickSinaShare
{
    [MobClick event:@"click_share_sinaweibo"];
    //    [Utility showMBProgress:showView message:@"分享中"];
    //微博的链接地址
    [UMSocialData defaultData].urlResource.url = self.shareUrl;
    [UMSocialData defaultData].extConfig.sinaData.urlResource.url = self.shareUrl;
    [UMSocialData defaultData].extConfig.sinaData.urlResource.resourceType = UMSocialUrlResourceTypeImage;
    
    [[UMSocialDataService defaultDataService] postSNSWithTypes:@[UMShareToSina] content:shareContent image:shareImage location:nil urlResource:nil presentedController:self.presentController completion:^(UMSocialResponseEntity *response){
        [Utility hideMBProgress:showView];
        if (response.responseCode == UMSResponseCodeSuccess)
        {
            [Utility showToastWithMessage:@"分享成功" _view:showView];
            //            if (self.projectId.length != 0)
            //            {
            //                [self requestSharedResultByWay:@"microblog"];
            //            }
        }
        else
        {
            [Utility showToastWithMessage:@"分享失败" _view:showView];
        }
    }];
}

//微信分享
- (void)clickWeiXinShare
{
    [MobClick event:@"click_share_wechatfriend"];
    
    [UMSocialData defaultData].extConfig.wxMessageType = UMSocialWXMessageTypeWeb;
    [UMSocialData defaultData].extConfig.wechatSessionData.url = self.shareUrl;
    [UMSocialData defaultData].extConfig.title = self.shareContent;
    [UMSocialData defaultData].urlResource.url = self.shareUrl;
    
    [[UMSocialDataService defaultDataService] postSNSWithTypes:@[UMShareToWechatSession] content:shareContent image:shareImage location:nil urlResource:nil presentedController:self.presentController completion:^(UMSocialResponseEntity *response){
        if (response.responseCode == UMSResponseCodeSuccess)
        {
            [Utility showToastWithMessage:@"分享成功" _view:showView];
            if (self.shareSuccess) {
                self.shareSuccess(@"1");
            }
            //            [self requestSharedResultByWay:@"wechat"];
        }
        else
        {
            [Utility showToastWithMessage:@"分享失败" _view:showView];
        }
    }];
}

//朋友圈分享
- (void)clickFriend
{
    [MobClick event:@"click_share_wechatcircle"];
    
    //TODO:微信分享内容点击后跳转到链接地址
    
    [UMSocialData defaultData].extConfig.wxMessageType = UMSocialWXMessageTypeWeb;
    [UMSocialData defaultData].extConfig.wechatTimelineData.url = self.shareUrl;
    [UMSocialData defaultData].extConfig.title = self.shareContent;
    [UMSocialData defaultData].urlResource.url = self.shareUrl;
    
    [[UMSocialDataService defaultDataService]  postSNSWithTypes:@[UMShareToWechatTimeline] content:shareContent image:self.shareImage location:nil urlResource:nil presentedController:self.presentController completion:^(UMSocialResponseEntity *response){
        if (response.responseCode == UMSResponseCodeSuccess)
        {
            [Utility showToastWithMessage:@"分享成功" _view:showView];
            if (self.shareSuccess) {
                self.shareSuccess(@"6");
            }
            
            //            if (self.projectId.length != 0)
            //            {
            //                [self requestSharedResultByWay:@"wechat"];
            //            }
        }
        else
        {
            [Utility showToastWithMessage:@"分享失败" _view:showView];
        }
    }];
}

- (void)shareToSMS
{
    //分享数据，平台设置   UMSocialQzoneData
    [[UMSocialDataService defaultDataService]  postSNSWithTypes:@[UMShareToSms] content:shareContent image:shareImage location:nil urlResource:nil presentedController:self.presentController completion:^(UMSocialResponseEntity *response)
     {
         if (response.responseCode == UMSResponseCodeSuccess)
         {
             [Utility showToastWithMessage:@"分享成功" _view:showView];
             if (self.shareSuccess) {
                 self.shareSuccess(@"7");
             }
             
         }
         else
         {
             [Utility showToastWithMessage:@"分享失败" _view:showView];
         }
     }];
    
}

- (void)shareToQQ
{
    if (shareUrl)
    {
        [UMSocialData defaultData].extConfig.qzoneData.url = shareUrl;
    }
    if (shareContent)
    {
        [UMSocialData defaultData].extConfig.qzoneData.title = shareContent;
        [UMSocialData defaultData].extConfig.qzoneData.shareText = shareContent;
    }
    if (shareImage)
    {
        [UMSocialData defaultData].extConfig.qzoneData.shareImage = UIImageJPEGRepresentation(shareImage,0.1f);
        
    }
    //分享数据，平台设置   UMSocialQzoneData
    [[UMSocialDataService defaultDataService]  postSNSWithTypes:@[UMShareToQzone] content:shareContent image:nil location:nil urlResource:nil presentedController:self.presentController completion:^(UMSocialResponseEntity *response)
     {
         if (response.responseCode == UMSResponseCodeSuccess)
         {
             [Utility showToastWithMessage:@"分享成功" _view:showView];
             if (self.shareSuccess) {
                 self.shareSuccess(@"4");
             }
             
             //             [self requestSharedResultByWay:@"qq"];
         }
         else
         {
             [Utility showToastWithMessage:@"分享失败" _view:showView];
         }
     }];
}
- (void)requestSharedResultByWay:(NSString *)way
{
    HWHttpRequestOperationManager *manager = [HWHttpRequestOperationManager baseManager];
    //    HWHTTPRequestOperationManager *manager = [HWHTTPRequestOperationManager manager];
    NSMutableDictionary *param = [NSMutableDictionary dictionary];
    [param setPObject:self.projectId forKey:@"projectId"];
    [param setPObject:way forKey:@"way"];
    //    [manager POST:@"" parameters:param queue:nil success:^(id responseObject) {
    //        
    //    } failure:^(NSString *error) {
    //        
    //    }];
    [manager postHttpRequest:@"" parameters:param queue:nil success:^(NSDictionary *responseObject) {
        
    } failure:^(NSString *error,NSString *aaa) {
        
    }];
}

@end
