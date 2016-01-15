//
//  HWBargainButton.h
//  Community
//
//  Created by niedi on 15/4/28.
//  Copyright (c) 2015年 caijingpeng. All rights reserved.
//

#import <UIKit/UIKit.h>

@class HWBargainButton;
@protocol HWBargainButtonDelegate <NSObject>

@optional
- (void)bargainButtonClick:(HWBargainButton *)bargainBtn;

@end



@interface HWBargainButton : UIButton
{
    int _remainTimes;
}

@property (nonatomic, assign) int reaminTimes;
@property (nonatomic, strong) UILabel *remainNumLab;
@property (nonatomic, weak) id<HWBargainButtonDelegate> delegate;

+ (instancetype)buttonWithFrame:(CGRect)frame remainTimes:(int)remainTimes delegate:(id<HWBargainButtonDelegate>)delegate;

- (void)setBargainButtonRemainTime:(int)remainTimes;

- (void)setBargainButtonMainColor;

- (void)setBargainButtonGrayColor;


@end
