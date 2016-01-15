//
//  HeadView.h
//  AlertView
//
//  Created by lizhongqiang on 15/7/7.
//  Copyright (c) 2015年 lqq. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface HeadView : UIView

@property (nonatomic, assign)CGFloat spaceX;

@property (nonatomic, assign)CGFloat width;

@property (nonatomic, copy)void(^cancelAction)(void);

@end
