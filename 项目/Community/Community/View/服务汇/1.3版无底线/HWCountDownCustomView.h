//
//  HWCountDownCustomView.h
//  customCount
//
//  Created by hw500028 on 4/2/15.
//  Copyright (c) 2015 YL. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface HWCountDownCustomView : UIView

@property (nonatomic, copy) void (^afterSureBtnBlock)(float constant);
@property (nonatomic, copy) void (^sureBtnBlock)(NSInteger time);
- (instancetype)initWithFrame:(CGRect)frame WithType:(NSString *)strType;
- (void)show;
- (void)resetSlideViewWithMinutes:(NSString *)minutes withConstant:(float)constant;
@end
