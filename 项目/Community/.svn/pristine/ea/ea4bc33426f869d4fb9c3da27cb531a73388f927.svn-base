//
//  HWRedDetailViewController.h
//  HaoWu_4.0
//
//  Created by zhangxun on 14-8-1.
//  Copyright (c) 2014年 caijingpeng. All rights reserved.
//

#import "HWBaseViewController.h"
#import "HWRedPacketObject.h"
#import "STScratchView.h"

@interface HWRedDetailViewController : HWBaseViewController<STScratchViewDelegate,UIAlertViewDelegate>
{
    HWRedPacketObject *_theRedObject;
    NSInteger _theWaitTime;
    UILabel *_countDownLabel;
    NSTimer *_theTimer;
}
- (id)initWithRedObj:(HWRedPacketObject *)redObject waitTime:(NSInteger)time;

@end
