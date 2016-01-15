//
//  ButtomView.h
//  SearchView
//
//  Created by lizhongqiang on 15/7/7.
//  Copyright (c) 2015年 lqq. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ButtomView : UIView

@property (nonatomic, assign)CGFloat x;

@property (nonatomic, assign)CGFloat y;

@property (nonatomic, copy)void (^clickButtomBtn)(NSString *string);

- (void)addSubViews;

- (void)reloadSubViews:(int)temp;

@end
