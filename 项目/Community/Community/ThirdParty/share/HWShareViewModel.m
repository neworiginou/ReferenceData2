//
//  HWShareViewModel.m
//  MoreHouse
//
//  Created by caijingpeng.haowu on 14-11-25.
//  Copyright (c) 2014年 lizhongqiang. All rights reserved.
//  1.3版 修改分享  只有QQ空间和微信朋友圈

#import "HWShareViewModel.h"
#import "MobClick.h"
#import "UMSocialData.h"
#import "UMSocialDataService.h"
#import "UMSocialSnsPlatformManager.h"
#import "WXApi.h"
#import "Utility.h"

@implementation HWShareViewModel
@synthesize shareContent;
@synthesize shareImage;
@synthesize shareUrl;
@synthesize showView;
@synthesize presentController;
@synthesize projectId;
@synthesize delegate;

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
    NSMutableArray *arrImage = [[NSMutableArray alloc] init];
    NSMutableArray *arrName = [[NSMutableArray alloc] init];
    
    if ([Utility isInstalledWX])
    {
        [arrImage addObject:@"share_weixin161"];
        [arrName addObject:@"朋友圈"];
    }
    
    if ([Utility isInstalledQQ])
    {
        [arrImage addObject:@"share_qzone161"];
        [arrName addObject:@"QQ空间"];
    }
    //@"wechat_moment"   @"微信朋友圈"
    
    actionSheet = [[MTCustomActionSheet alloc] initWithFrame:CGRectZero andImageArr:arrImage nameArray:arrName orientation:0];
    
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
    if ([Utility isInstalledQQAndInstalledWX])
    {
        if (index == 0)
        {
            // 朋友圈
            [self clickFriend];
        }
        else if (index == 1)
        {
            [self shareToQQ];
        }
    }
    else
    {
        //此时必定只有一个
        if ([Utility isInstalledQQ])
        {
            [self shareToQQ];
        }
        else if ([Utility isInstalledWX])
        {
            [self clickFriend];
        }
    }
    
    //    else if (index == 2)
    //    {
    //        // 微博
    //        [self clickSinaShare];
    //    }
    //    else if (index == 2)
    //    {
    //        [self clickSMS];
    //    }
}

- (void)clickSMS
{
    [UMSocialData defaultData].urlResource.url = self.shareUrl;
    [UMSocialData defaultData].extConfig.smsData.urlResource.url = self.shareUrl;
    [UMSocialData defaultData].extConfig.smsData.urlResource.resourceType = UMSocialUrlResourceTypeImage;
    
    [[UMSocialDataService defaultDataService] postSNSWithTypes:@[UMShareToSms] content:[NSString stringWithFormat:@"%@,%@",shareContent,self.shareUrl] image:shareImage location:nil urlResource:nil presentedController:self.presentController completion:^(UMSocialResponseEntity *response) {
        if (response.responseCode == UMSResponseCodeSuccess)
        {
            
            [Utility showToastWithMessage:@"分享成功" inView:showView];
        }
        else
        {
            [Utility showToastWithMessage:@"分享失败" inView:showView];
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
            [Utility showToastWithMessage:@"分享成功" inView:showView];
            //            if (self.projectId.length != 0)
            //            {
            //                [self requestSharedResultByWay:@"microblog"];
            //            }
        }
        else
        {
            [Utility showToastWithMessage:@"分享失败" inView:showView];
        }
    }];
}

//微信分享
- (void)clickWeiXinShare
{
    [MobClick event:@"click_share_wechatfriend"];
    
    [UMSocialData defaultData].extConfig.wxMessageType = UMSocialWXMessageTypeWeb;
    [UMSocialData defaultData].extConfig.wechatSessionData.url = self.shareUrl;
    [UMSocialData defaultData].extConfig.title = SHARE_TEXT;
    [UMSocialData defaultData].urlResource.url = self.shareUrl;
    
    [[UMSocialDataService defaultDataService] postSNSWithTypes:@[UMShareToWechatSession] content:shareContent image:shareImage location:nil urlResource:nil presentedController:self.presentController completion:^(UMSocialResponseEntity *response){
        if (response.responseCode == UMSResponseCodeSuccess)
        {
            [Utility showToastWithMessage:@"分享成功" inView:showView];
            //            [self requestSharedResultByWay:@"wechat"];
        }
        else
        {
            [Utility showToastWithMessage:@"分享失败" inView:showView];
        }
    }];
}

#pragma mark - 朋友圈分享
- (void)clickFriend
{
    [MobClick event:@"click_share_wechatcircle"];
    if (![WXApi isWXAppInstalled]) {
        return;
    }
    //TODO:微信分享内容点击后跳转到链接地址
    //分享渠道  1 微信朋友圈  2 QQ空间
    [UMSocialData defaultData].extConfig.wxMessageType = UMSocialWXMessageTypeWeb;
    if (shareUrl.length != 0)
    {
        [UMSocialData defaultData].extConfig.wechatTimelineData.url = self.shareUrl;
        [UMSocialData defaultData].urlResource.url = self.shareUrl;
    }
    if (shareContent.length == 0)
    {
        shareContent = SHARE_TEXT;
    }
    [UMSocialData defaultData].extConfig.title = shareContent;
    
    [[UMSocialDataService defaultDataService]  postSNSWithTypes:@[UMShareToWechatTimeline] content:shareContent image:self.shareImage location:nil urlResource:nil presentedController:self.presentController completion:^(UMSocialResponseEntity *response){
        if (response.responseCode == UMSResponseCodeSuccess)
        {
            [Utility showToastWithMessage:@"分享成功" inView:showView];
            if (self.delegate && [delegate respondsToSelector:@selector(shareSuccessByWay:)]) {
                [delegate shareSuccessByWay:@"1"];
            }
        }
        else
        {
            [Utility showToastWithMessage:@"分享失败" inView:showView];
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
             [Utility showToastWithMessage:@"分享成功" inView:showView];
         }
         else
         {
             [Utility showToastWithMessage:@"分享失败" inView:showView];
         }
     }];
    
}
#pragma mark - 分享QQ空间
- (void)shareToQQ
{
    if (shareUrl.length != 0)
    {
        [UMSocialData defaultData].extConfig.qzoneData.url = shareUrl;
    }
    if (shareContent.length == 0)
    {
        shareContent = DEFAULTSHARECONTENT;
    }
    [UMSocialData defaultData].extConfig.qzoneData.title = SHARE_TEXT;
    [UMSocialData defaultData].extConfig.qzoneData.shareText = shareContent;
    if (shareImage == nil)
    {
        [UMSocialData defaultData].extConfig.qzoneData.shareImage = UIImageJPEGRepresentation([UIImage imageNamed:@"Icon"],0.1f);
    }
    else
    {
        [UMSocialData defaultData].extConfig.qzoneData.shareImage = UIImageJPEGRepresentation(shareImage,0.1f);
    }
    //分享数据，平台设置   UMSocialQzoneData
    [[UMSocialDataService defaultDataService]  postSNSWithTypes:@[UMShareToQzone] content:shareContent image:nil location:nil urlResource:nil presentedController:self.presentController completion:^(UMSocialResponseEntity *response)
     {
         if (response.responseCode == UMSResponseCodeSuccess)
         {
             [Utility showToastWithMessage:@"分享成功" inView:showView];
             if (self.delegate && [delegate respondsToSelector:@selector(shareSuccessByWay:)]) {
                 [delegate shareSuccessByWay:@"2"];
             }
         }
         else
         {
             [Utility showToastWithMessage:@"分享失败" inView:showView];
         }
     }];
}
- (void)requestSharedResultByWay:(NSString *)way
{
    //    HWHttpRequestOperationManager *manager = [HWHttpRequestOperationManager baseManager];
    HWHTTPRequestOperationManager *manager = [HWHTTPRequestOperationManager manager];
    NSMutableDictionary *param = [NSMutableDictionary dictionary];
    [param setPObject:self.projectId forKey:@"projectId"];
    [param setPObject:way forKey:@"way"];
    //    [manager POST:@"" parameters:param queue:nil success:^(id responseObject) {
    //
    //    } failure:^(NSString *error) {
    //
    //    }];
    [manager POST:@"" parameters:param queue:nil success:^(id responese) {
        
    } failure:^(NSString *code, NSString *error) {
        
    }];
    //    [manager postHttpRequest:@"" parameters:param queue:nil success:^(NSDictionary *responseObject) {
    //        
    //    } failure:^(NSString *error,NSString *aaa) {
    //        
    //    }];
}

@end
