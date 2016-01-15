//
//  HWGameNameModel.h
//  KaoLaSpread
//
//  Created by WeiYuanlin on 15/1/15.
//  Copyright (c) 2015年 hw. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface HWGameNameModel : NSObject

@property (nonatomic, strong) NSString *dimensionalCode;//二维码
@property (nonatomic, strong) NSString *downloadAddress;//下载地址
@property (nonatomic, strong) NSString *gameId;//游戏id
@property (nonatomic, strong) NSString *popularizeUserId;//推广员id
@property (nonatomic, strong) NSString *gameShareUrl;//复制的url

- (id)initWithDictionary:(NSDictionary *)dic;
@end
