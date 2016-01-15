//
//  IUMIDComponent.h
//  SecurityGuardSDK
//
//  Created by lifengzhong on 14/8/13.
//  Copyright (c) 2014年 Li Fengzhong. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol IUMIDComponent <NSObject>

/**
 *  初始化 umid
 *
 *  @param resultHandler 初始化结果回调，本函数必须在主线程内完成（推荐在 appdelegate中，应用启动时调用）
 *
 *  @return 调用成功结果
 */
- (void) registerInitListener: (void (^) (NSString* securityToken, NSError* error)) listener;

/**
 *  返回UMID Token，长度为32的字符串
 *
 *  @return 如果失败，返回内容为24个0的字符串
 */
- (NSString*) getSecurityToken;

/**
 *  清空 umid 本地数据（mock接口，正常情况不要调用！）
 */
- (void) resetClientData;

/**
 *  获取 umid
 *
 *  @return umid版本号
 */
- (NSString*) getUMIDVersion;

@end
