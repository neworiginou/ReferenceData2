//
//  HWGameAllNameModel.h
//  Community
//
//  Created by WeiYuanlin on 15/1/17.
//  Copyright (c) 2015年 caijingpeng. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface HWGameAllNameModel : NSObject

@property (nonatomic, strong) NSString *gameName;//游戏名称
@property (nonatomic, strong) NSString *gameImg;//游戏图片
@property (nonatomic, strong) NSString *gameId;//游戏id
@property (nonatomic, strong) NSString *appNumber; //app编号
@property (nonatomic, strong) NSString *channelNumber;//话题编号
@property (nonatomic, strong) NSString *gameShareUrl;//分享url
@property (nonatomic, strong) NSString *shortUrl;//复制的url

- (id)initWithDictionary:(NSDictionary *)dic;

@end
