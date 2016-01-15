//
//  UserHeaderView.m
//  PUClient
//
//  Created by RRLhy on 15/7/31.
//  Copyright (c) 2015年 RRLhy. All rights reserved.
//

#import "UserHeaderView.h"

@implementation UserHeaderView
{
    UIImageView * userImg;
    UIImageView * userMark;
}
- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    
    if (self) {
        userImg = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, frame.size.width, frame.size.height)];
        userImg.layer.cornerRadius = frame.size.width/2;
        userImg.layer.masksToBounds = YES;
        [self addSubview:userImg];
        
        userMark = [[UIImageView alloc]initWithFrame:CGRectMake(frame.size.width*3/4, frame.size.width*3/4, frame.size.width/4, frame.size.width/4)];
        [self addSubview:userMark];
    }
    
    return self;
}

- (void)setUserUrl:(NSString *)userUrl
{
//    if (_userUrl == userUrl) {
//        return;
//    }
    _userUrl = userUrl;
    
    [userImg sd_setImageWithURL:URL(userUrl) placeholderImage:IMAGENAME(@"login_me_user-no")];
}

- (void)setType:(UserType)type
{
    if (_type == type) {
        return;
    }
    _type = type;
    
    if (type == User_General) {
        //普通用户
        userMark.image = nil;
    }else if (type == User_Vip){
        //认证用户
        userMark.image = IMAGENAME(@"icon_user_vmini");
    }else if(type == User_Star){
        //明星用户
        userMark.image = IMAGENAME(@"icon_user_vmini");
    }
}

@end
