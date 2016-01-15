//
//  UserHeaderView.h
//  PUClient
//
//  Created by RRLhy on 15/7/31.
//  Copyright (c) 2015年 RRLhy. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef NS_ENUM(NSInteger, UserType) {
    User_Star      = -1,
    User_Vip       = 1,
    User_General  = 2,

};

@interface UserHeaderView : UIView

@property (nonatomic,assign)UserType type;

@property (nonatomic,copy)NSString * userUrl;


@end
