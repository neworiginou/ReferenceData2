//
//  SCHttpClient.h
//  SoapWebServices
//
//  Created by SC2 on 14-2-28.
//  Copyright (c) 2014年 北京士昌信息技术有限公司. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef void(^SCHttpSuccessBlock)(NSString *soapResults);

@interface SCHttpClient : NSObject<NSURLConnectionDelegate>{
    NSMutableData *soapData;
}
-(void)postRequestWithPhoneNumber:(NSString *)number;
@end
