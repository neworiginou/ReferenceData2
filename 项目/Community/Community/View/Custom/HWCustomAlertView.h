//
//  HWCustomAlertView.h
//  HWCustomAlertView
//
//  Created by D on 14/12/15.
//  Copyright (c) 2014年 D. All rights reserved.
//

#import "HWDAlert.h"

@interface HWCustomAlertView : HWDAlert
{
    UITextView * secretTV;
}

@property (nonatomic,strong) UILabel *coustMoneyLab;
@property (nonatomic, strong) NSString *handlingFee;


+ (id)alertWithMoneyAmount:(double)amount handleFee:(NSString *)fee;

@end
