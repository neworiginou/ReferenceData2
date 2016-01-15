//
//  HWAlertComplainView.h
//  Community
//
//  Created by niedi on 15/6/19.
//  Copyright (c) 2015年 caijingpeng. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol HWAlertComplainViewDelegate <NSObject>

- (void)evaluateBtnClickResult:(BOOL)isSatisfy;

@end

@interface HWAlertComplainView : UIView

@property (nonatomic , strong) id <HWAlertComplainViewDelegate> delegate;
- (void)show;
- (void)hidenView;


@end
