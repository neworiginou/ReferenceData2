//
//  HWOpenTimeViewController.h
//  Community
//
//  Created by caijingpeng.haowu on 14-9-7.
//  Copyright (c) 2014年 caijingpeng. All rights reserved.
//

#import "HWBaseViewController.h"

@interface HWOpenTimeViewController : HWBaseViewController
{
    NSString *openTimeStr;
    NSString *closeTimeStr;
}
@property(nonatomic,copy)void(^selectTime)(NSString *openTimeStr,NSString *closeTimeStr);

@end
