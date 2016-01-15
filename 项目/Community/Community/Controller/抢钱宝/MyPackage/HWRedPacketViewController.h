//
//  HWRedPacketViewController.h
//  HaoWu_4.0
//
//  Created by zhangxun on 14-7-31.
//  Copyright (c) 2014年 caijingpeng. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "HWRefreshBaseViewController.h"

@interface HWRedPacketViewController : HWRefreshBaseViewController<UIAlertViewDelegate>
{
    NSMutableArray *_redPacketArray;
    NSTimer *_theTimer;
    long time;
    NSIndexPath *_delIndex;
}



@end
