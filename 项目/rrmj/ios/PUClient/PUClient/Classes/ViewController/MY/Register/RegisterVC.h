//
//  RegisterVC.h
//  PUClient
//
//  Created by RRLhy on 15/7/20.
//  Copyright (c) 2015年 RRLhy. All rights reserved.
//

#import "BaseWhiteViewController.h"
typedef NS_ENUM(NSInteger, VcType) {
    Register     = 0,
    FindPsd      = 1,
    BoundMobile  = 2,
};
@interface RegisterVC : BaseWhiteViewController

@property (nonatomic, assign)VcType type;

@end
