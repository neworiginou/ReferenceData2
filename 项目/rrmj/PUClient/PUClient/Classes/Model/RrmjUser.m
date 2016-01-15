//
//  RrmjUser.m
//  PUClient
//
//  Created by RRLhy on 15/7/22.
//  Copyright (c) 2015年 RRLhy. All rights reserved.
//

#import "RrmjUser.h"

#define RRUSER_NICK          @"nickName"
#define RRUSER_LOGINNAME     @"loginName"
#define RRUSER_SEX           @"sex"
#define RRUSER_BIRTHDAY      @"birthday"
#define RRUSER_CITY          @"city"
#define RRUSER_REGISTERFROM  @"registerFrom"
#define RRUSER_SILVERCOUNT   @"silverCount"
#define RRUSER_MOBILE        @"mobile"
#define RRUSER_HEADIMAGEURL  @"headImgUrl"
#define RRUSER_INTRO         @"intro"
#define RRUSER_CONFIRMINFO   @"confirmInfo"
#define RRUSER_BGIMGURL      @"bgImgUrl"
#define RRUSER_SIGN          @"sign"
#define RRUSER_TOKEN         @"token"
#define RRUSER_LEVELNAME     @"levelName"
#define RRUSER_LEVEL         @"level"
#define RRUSER_CREATETIMESTR @"createTimeStr"
#define RRUSER_ID            @"Id"

@implementation RrmjUser

// NSCoding实现
MJCodingImplementation
//- (id)initWithCoder:(NSCoder *)aDecoder
//{
//    self = [super init];
//    if (self) {
//        
//        [aDecoder decodeObjectForKey:RRUSER_NICK];
//        [aDecoder decodeObjectForKey:RRUSER_LOGINNAME];
//        [aDecoder decodeObjectForKey:RRUSER_SEX];
//        [aDecoder decodeObjectForKey:RRUSER_BIRTHDAY];
//        [aDecoder decodeObjectForKey:RRUSER_CITY];
//        [aDecoder decodeObjectForKey:RRUSER_REGISTERFROM];
//        [aDecoder decodeObjectForKey:RRUSER_SILVERCOUNT];
//        [aDecoder decodeObjectForKey:RRUSER_MOBILE];
//        [aDecoder decodeObjectForKey:RRUSER_HEADIMAGEURL];
//        [aDecoder decodeObjectForKey:RRUSER_INTRO];
//        [aDecoder decodeObjectForKey:RRUSER_CONFIRMINFO];
//        [aDecoder decodeObjectForKey:RRUSER_BGIMGURL];
//        [aDecoder decodeObjectForKey:RRUSER_SIGN];
//        [aDecoder decodeObjectForKey:RRUSER_TOKEN];
//        [aDecoder decodeObjectForKey:RRUSER_LEVELNAME];
//        [aDecoder decodeObjectForKey:RRUSER_LEVEL];
//        [aDecoder decodeObjectForKey:RRUSER_CREATETIMESTR];
//        [aDecoder decodeObjectForKey:RRUSER_ID];
//    }
//    return self;
//}

//- (void)encodeWithCoder:(NSCoder *)aCoder
//{
//    [aCoder encodeObject:self.nickName forKey:RRUSER_NICK];
//    [aCoder encodeObject:self.loginName forKey:RRUSER_LOGINNAME];
//    [aCoder encodeObject:self.sex forKey:RRUSER_SEX];
//    [aCoder encodeObject:self.birthday forKey:RRUSER_BIRTHDAY];
//    [aCoder encodeObject:self.city forKey:RRUSER_CITY];
//    [aCoder encodeObject:self.registerFrom forKey:RRUSER_REGISTERFROM];
//    [aCoder encodeObject:self.silverCount forKey:RRUSER_SILVERCOUNT];
//    [aCoder encodeObject:self.mobile forKey:RRUSER_MOBILE];
//    [aCoder encodeObject:self.headImgUrl forKey:RRUSER_HEADIMAGEURL];
//    [aCoder encodeObject:self.intro forKey:RRUSER_INTRO];
//    [aCoder encodeObject:self.confirmInfo forKey:RRUSER_CONFIRMINFO];
//    [aCoder encodeObject:self.bgImgUrl forKey:RRUSER_BGIMGURL];
//    [aCoder encodeObject:self.sign forKey:RRUSER_SIGN];
//    [aCoder encodeObject:self.token forKey:RRUSER_TOKEN];
//    [aCoder encodeObject:self.levelName forKey:RRUSER_LEVELNAME];
//    [aCoder encodeObject:self.level forKey:RRUSER_LEVEL];
//    [aCoder encodeObject:self.createTimeStr forKey:RRUSER_CREATETIMESTR];
//    [aCoder encodeObject:self.Id forKey:RRUSER_ID];
//}

- (void)setValue:(id)value forUndefinedKey:(NSString *)key
{
    
}

/**
 *  字典和模型不对应，手动写对应关系
 */
+ (NSDictionary *)replacedKeyFromPropertyName
{
    return @{@"Id" : @"id"};
}

@end
