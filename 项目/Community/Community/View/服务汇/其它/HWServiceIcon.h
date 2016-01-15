//
//  HWServiceIcon.h
//  Community
//
//  Created by niedi on 15/6/9.
//  Copyright (c) 2015年 caijingpeng. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "HWServiceIconModel.h"

typedef NS_ENUM(NSInteger, iconEvent) {
    IconTap = 0,
    IconLongPressBegain,
    IconLongPressEnd,
    IconPanChange,
    IconPanEnd,
    iconDel,
};


@interface HWServiceIcon : UIView


@property (nonatomic, strong) HWServiceIconModel *model;
@property (nonatomic, strong) NSArray *iconModelArr;
@property (nonatomic, strong) NSArray *iconArr;
@property (nonatomic, assign) BOOL isDelBtnShow;

- (instancetype)initWithFrame:(CGRect)frame model:(HWServiceIconModel *)model isDelImg:(BOOL)isDelImg;

- (void)addTarget:(id)target action:(SEL)action forIconEvents:(iconEvent)iconEvent;

- (void)hideDelBtnAnimation;

- (void)longPressBegainAction:(CGPoint)begainCenter;

- (void)longPressEndAction:(CGPoint)endCenter;





@end
