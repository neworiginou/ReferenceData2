//
//  HWShareMessage.m
//  Community
//
//  Created by hw500028 on 15/1/17.
//  Copyright (c) 2015年 caijingpeng. All rights reserved.
//

#import "HWShareMessage.h"

@interface HWShareMessage()

@property (nonatomic, strong) UMSocialResponseEntity * response;


@end

@implementation HWShareMessage
single_implementation(HWShareMessage)
//微博分享
- (void)shareMessageToWeiBoWithURL:(NSString *)urlStr socialUrlResourceType:(UMSocialUrlResourceType)socialUrlResourceType content:(NSString *)content image:(UIImage *)image presentedController:(UIViewController *)presentController completion:(void (^)(UMSocialResponseEntity *))completion{
    content = content.length > 0 ? content : DEFAULTSHARECONTENT;
    [UMSocialData defaultData].urlResource.url = urlStr;
    [UMSocialData defaultData].extConfig.sinaData.urlResource.url = urlStr;
    [UMSocialData defaultData].extConfig.sinaData.urlResource.resourceType = socialUrlResourceType;
    [[UMSocialDataService defaultDataService] postSNSWithTypes:@[UMShareToSina] content:content image:nil location:nil urlResource:nil presentedController:presentController completion:^(UMSocialResponseEntity *response) {
        if (completion) {
            completion(response);
        }
        
    }];

}

//微信分享
- (void)shareMessageToWeiXinWIthURL:(NSString *)urlStrl SocialWXMessageType:(UMSocialWXMessageType)SocialWXMessageType content:(NSString *)content image:(id)image presentedController:(UIViewController *)presentedController completion:(void (^)(UMSocialResponseEntity *))completion
{
    content = content.length > 0 ? content : DEFAULTSHARECONTENT;
    [UMSocialData defaultData].extConfig.wxMessageType = SocialWXMessageType;
    [UMSocialData defaultData].extConfig.wechatSessionData.url = urlStrl;
    [UMSocialData defaultData].extConfig.title = content;
    [UMSocialData defaultData].urlResource.url = urlStrl;
    [[UMSocialDataService defaultDataService]postSNSWithTypes:@[UMShareToWechatSession] content:content image:image location:nil urlResource:nil presentedController:presentedController completion:^(UMSocialResponseEntity *response)
    {
        if (completion)
        {
            completion(response);
        }
    }];
}
//分享到微信朋友圈
- (void)shareMessageToWeixinFriendsWithURL:(NSString *)urlStr SocialWXMessageType:(UMSocialWXMessageType)SocialWXMessageType  content:(NSString *)content image:(id)image presentController:(UIViewController *)presentController completion:(void (^)(UMSocialResponseEntity *))completion
{
    content = content.length > 0 ? content : DEFAULTSHARECONTENT;
    [UMSocialData defaultData].extConfig.wxMessageType = SocialWXMessageType;
    [UMSocialData defaultData].extConfig.wechatTimelineData.url = urlStr;
    [UMSocialData defaultData].urlResource.url = urlStr;
    [[UMSocialDataService defaultDataService] postSNSWithTypes:@[UMShareToWechatTimeline] content:content image:image location:nil urlResource:nil presentedController:presentController completion:^(UMSocialResponseEntity *response)
    {
        if (completion)
        {
            completion(response);
        }
    }];
}

- (void)shareMessageToQZoneWithURL:(NSString *)urlStr SocialWXMessageType:(UMSocialWXMessageType)SocialWXMessageType title:(NSString *)titleStr content:(NSString *)content image:(id)image presentController:(UIViewController *)presentController completion:(void (^)(UMSocialResponseEntity *))completion
{
    content = content.length > 0 ? content : DEFAULTSHARECONTENT;
    titleStr = titleStr.length > 0 ? titleStr : DEFAULTSHARECONTENT;
    [UMSocialData defaultData].extConfig.qzoneData.url = urlStr;
    [UMSocialData defaultData].extConfig.qzoneData.title = titleStr;
    [UMSocialData defaultData].extConfig.qzoneData.shareText = content;
    [UMSocialData defaultData].extConfig.qzoneData.shareImage = UIImageJPEGRepresentation(image, 0.1f);
    //分享数据，平台设置   UMSocialQzoneData
    [[UMSocialDataService defaultDataService] postSNSWithTypes:@[UMShareToQzone] content:content image:nil location:nil urlResource:nil presentedController:presentController completion:^(UMSocialResponseEntity *response)
     {
         if (completion)
         {
             completion(response);
         }
     }];
}



@end
