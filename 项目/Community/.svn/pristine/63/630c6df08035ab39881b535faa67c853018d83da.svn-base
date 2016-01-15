//
//  TaeRPC.h
//  TAESDK
//
//  Created by xinghanwork on 15/1/5.
//  Copyright (c) 2015年 alibaba. All rights reserved.
//


#import <Foundation/Foundation.h>


@interface TaeRPC : NSObject

typedef void (^rpcOpenSuccessCallBack) (NSData *rpcResult);
typedef void (^rpcOpenFailureCallBack) (NSError *rpcError);
/**
 *   同步 Call RPC
 */
+(NSData *)callRPC:(CCPURLRequest *) req;
/**
 *   异步 Call RPC
 */
+(void) asyncCallRPC:(CCPURLRequest *) request
  rpcOpenSuccessCallBack:(rpcOpenSuccessCallBack)rpcOpenSuccessCallBack
  rpcOpenFailureCallBack:(rpcOpenFailureCallBack)rpcOpenFailureCallBack;

@end
