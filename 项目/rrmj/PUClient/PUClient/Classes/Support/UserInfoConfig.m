//
//  UserInfoConfig.m
//  PUClient
//
//  Created by RRLhy on 15/7/22.
//  Copyright (c) 2015年 RRLhy. All rights reserved.
//

#import "UserInfoConfig.h"
// 文件路径
#define kFile [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES)[0] stringByAppendingPathComponent:@"RRMJUser.plist"]
@implementation UserInfoConfig

 SINGLETON_GCD(UserInfoConfig)

- (id)init
{
    self = [super init];
    if (self) {
        
        self.userInfo =[NSKeyedUnarchiver unarchiveObjectWithFile:kFile];
        if ([NSKeyedUnarchiver unarchiveObjectWithFile:kFile]) {
            self.userInfo = [NSKeyedUnarchiver unarchiveObjectWithFile:kFile];
        }else
        {
            RrmjUser * user = [[RrmjUser alloc]init];
            [self saveRRMJUser:user];
        }
    }
    return self;
}

- (void)saveRRMJUser:(RrmjUser*)rrmjUser
{
    _userInfo = rrmjUser;
    
    [NSKeyedArchiver archiveRootObject:rrmjUser toFile:kFile];
}

@end
