//
//  HWShareManager.h
//  SwiftTest
//
//  Created by caijingpeng.haowu on 15/2/9.
//  Copyright (c) 2015年 caijingpeng.haowu. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "UMSocial.h"

@interface HWShareManager : NSObject

/**
 发送微博内容到多个微博平台
 
 @param types    分享到的平台，数组的元素是`UMSocialSnsPlatformManager.h`定义的平台名的常量字符串，例如`UMShareToSina`，`UMShareToTencent`等。
 @param content          分享的文字内容
 @param image            分享的图片,可以传入UIImage类型或者NSData类型
 @param urlStr           分享的链接地址
 @param completion       发送完成执行的block对象
 @param presentedController 如果发送的平台微博只有一个并且没有授权，传入要授权的viewController，将弹出授权页面，进行授权。可以传nil，将不进行授权。
 @pram  socialUrlResourceType 分享内容的类型枚举值  例如:"图片":UMSocialUrlResourceTypeImage
 */
+ (void)shareMessageToWeiBoWithURL:(NSString *)urlStr
             socialUrlResourceType:(UMSocialUrlResourceType)socialUrlResourceType
                           content:(NSString *)content
                             image:(id)image
               presentedController:(UIViewController *)presentController
                        completion:(void(^)(UMSocialResponseEntity * respose))completion;

/**
 *  发送内容到微信
 *
 *  @param urlStrl             分享的链接地址
 *  @param SocialWXMessageType 分享内容的类型枚举值  例如:"图片":UMSocialWXMessageTypeImage
 *  @param types               分享到的平台，数组的元素是`UMSocialSnsPlatformManager.h`定义的平台名的常量字符串，例如`UMShareToSina`，`UMShareToTencent`等。
 *  @param content             分享的文字内容
 *  @param image               分享的图片,可以传入UIImage类型或者NSData类型
 *  @param presentedController 如果发送的平台微博只有一个并且没有授权，传入要授权的viewController，将弹出授权页面，进行授权。可以传nil，将不进行授权
 *  @param completion          发送完成执行的block对象
 */
+ (void)shareMessageToWeiXinWIthURL:(NSString *)urlStrl
                SocialWXMessageType:(UMSocialWXMessageType)SocialWXMessageType
                              title:(NSString *)title
                            content:(NSString *)content
                              image:(id)image
                presentedController:(UIViewController *)presentedController
                         completion:(void (^)(UMSocialResponseEntity *))completion;

/**
 *  发送内容到微信
 *
 *  @param urlStr              微信分享内容点击后跳转到链接地址
 *  @param SocialWXMessageType 分享内容的类型枚举值  例如:"图片":UMSocialWXMessageTypeImage
 *  @param content             分享的文字内容
 *  @param image               分享的图片,可以传入UIImage类型或者NSData类型
 *  @param presentController   如果发送的平台微博只有一个并且没有授权，传入要授权的viewController，将弹出授权页面，进行授权。可以传nil，将不进行授权
 *  @param completion          发送完成执行的block对象
 */
+ (void)shareMessageToWeixinFriendsWithURL:(NSString *)urlStr
                       SocialWXMessageType:(UMSocialWXMessageType)SocialWXMessageType
                                   content:(NSString *)content
                                     image:(id)image
                         presentController:(UIViewController *)presentController
                                completion:(void (^)(UMSocialResponseEntity *))completion;

/**
 *  发送内容到qq空间
 *
 *  @param urlStr              微信分享内容点击后跳转到链接地址
 *  @param SocialWXMessageType 分享内容的类型枚举值  例如:"图片":UMSocialWXMessageTypeImage
 *  @param title               分享的文字标题
 *  @param content             分享的文字内容
 *  @param image               分享的图片,可以传入UIImage类型或者NSData类型
 *  @param presentController   如果发送的平台微博只有一个并且没有授权，传入要授权的viewController，将弹出授权页面，进行授权。可以传nil，将不进行授权
 *  @param completion          发送完成执行的block对象
 */
+ (void)shareMessageToQZoneWithURL:(NSString *)urlStr
               SocialWXMessageType:(UMSocialWXMessageType)SocialWXMessageType
                             title:(NSString *)titleStr
                           content:(NSString *)content
                             image:(id)image
                 presentController:(UIViewController *)presentController
                        completion:(void (^)(UMSocialResponseEntity *))completion;


@end
