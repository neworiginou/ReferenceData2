//
//  HWNetWorkManager.m
//  Community
//
//  Created by zhangxun on 15/1/23.
//  Copyright (c) 2015年 caijingpeng. All rights reserved.
//
//      赞 评论 网络请求保存、读取
//   修改人            修改日期            操作
//  张迅                 1.23             创建
//
//  问题0127  单例类方法  限制存储数量  键名宏定义

#define REQUEST                 @"request"
#define REQUESTID               @"requestId"
#define POSTDICTIONARY          @"parameters"


#import "HWNetWorkManager.h"

static HWNetWorkManager *manager = nil;

@implementation HWNetWorkManager

+ (HWNetWorkManager *)currentManager
{
    if (!manager)
    {
        manager = [[HWNetWorkManager alloc] init];
    }
    return manager;
}

- (void)saveRequestWithParameters:(NSDictionary *)parameters requestId:(NSString *)requestId
{
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    NSMutableArray *array = [NSMutableArray arrayWithArray:[defaults objectForKey:REQUEST]];
    if (!array) {
        array = [NSMutableArray array];
    }
    NSString *sign = nil;
    for (int i = 0; i < array.count; i ++) {
        if ([[array[i] objectForKey:REQUESTID] isEqualToString:requestId]) {
            sign = [NSString stringWithFormat:@"%d",i];
        }
    }
    if (sign) {
        [array removeObjectAtIndex:[sign intValue]];
        [defaults setObject:array forKey:REQUEST];
        return;
    }
    
    if (array.count == 100) {
        [array removeObjectAtIndex:0];
    }
    
    NSMutableDictionary *dict = [NSMutableDictionary dictionary];
    [dict setObject:parameters forKey:POSTDICTIONARY];
    [dict setObject:requestId forKey:REQUESTID];
    [array addObject:dict];
    [defaults setObject:array forKey:REQUEST];
}

- (void)deleteRequestWithRequestId:(NSString *)requestId
{
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    NSString *sign = nil;
    NSMutableArray *array = [NSMutableArray arrayWithArray:[defaults objectForKey:REQUEST]];
    for (int i = 0; i < array.count; i ++)
    {
        NSDictionary *dict = [array objectAtIndex:i];
        if ([[dict objectForKey:REQUESTID] isEqualToString:REQUESTID]) {
            sign = [NSString stringWithFormat:@"%d",i];
        }
    }
    if (sign)
    {
        [array removeObjectAtIndex:[sign intValue]];
    }
    if (array.count > 0)
    {
        [defaults setObject:array forKey:REQUEST];
    }
    else
    {
        [defaults setObject:array forKey:REQUEST];
//        [[NSNotificationCenter defaultCenter] postNotificationName:HWNeighbourDragRefresh object:nil];
        
    }
    
}

- (NSArray *)loadRequest
{
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    NSMutableArray *array = [defaults objectForKey:REQUEST];
    if (array.count == 0)
    {
        return nil;
    }
    return array;
}

- (void)clearRequest
{
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    [defaults removeObjectForKey:REQUEST];
    [defaults synchronize];
}

- (void)postSavedZan
{
    NSMutableArray *postArr = nil;
    if ([self loadRequest])
    {
        postArr = [NSMutableArray arrayWithArray:[self loadRequest]];
        NSDictionary *postDict = nil;
        NSString *requestId = nil;
        NSString *userIdStr = [NSString stringWithFormat:@"userId=%@", [HWUserLogin currentUserLogin].userId];
        
        for (int i = 0; i < postArr.count; i++)
        {
            NSDictionary *tmpDict = [postArr pObjectAtIndex:i];
            postDict = tmpDict[POSTDICTIONARY];
            requestId = tmpDict[REQUESTID];
            
            if (![requestId isEqualToString:userIdStr])
            {
                HWHTTPRequestOperationManager *manager = [HWHTTPRequestOperationManager manager];
                [manager POST:kPraise parameters:postDict queue:nil success:^(id responese) {
                    
                    [self deleteRequestWithRequestId:requestId];
                    
                } failure:^(NSString *code, NSString *error) {
                    
                    
                }];
            }
        }
    }
}

- (void)commitIconChange
{
    NSMutableArray *postArr = nil;
    if ([self loadRequest])
    {
        postArr = [NSMutableArray arrayWithArray:[self loadRequest]];
        NSDictionary *postDict = nil;
        NSString *requestId = nil;
        NSString *userIdStr = [NSString stringWithFormat:@"userId=%@", [HWUserLogin currentUserLogin].userId];
        
        for (int i = 0; i < postArr.count; i++)
        {
            NSDictionary *tmpDict = [postArr pObjectAtIndex:i];
            postDict = tmpDict[POSTDICTIONARY];
            requestId = tmpDict[REQUESTID];
            
            if ([requestId isEqualToString:userIdStr])
            {
                HWHTTPRequestOperationManager *manager = [HWHTTPRequestOperationManager manager];
                [manager POST:KServiceIconUpdate parameters:postDict queue:nil success:^(id responese)
                 {
                     [self deleteRequestWithRequestId:requestId];
                     
                 } failure:^(NSString *code, NSString *error) {
                     
                 }];
            }
        }
    }
}


@end
