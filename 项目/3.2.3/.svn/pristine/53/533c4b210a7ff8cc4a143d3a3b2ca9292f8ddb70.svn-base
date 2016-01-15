//
//  HWStreamLabelView.h
//  MoreHouse
//
//  Created by caijingpeng.haowu on 14-11-26.
//  Copyright (c) 2014年 lizhongqiang. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface HWStreamLabelView : UIView
{
    CGRect constrainedFrame;
    CGSize constrainedItemSize;
}

@property (nonatomic, strong) NSArray *itemArray;
@property (nonatomic, assign) float itemBorderWidth;
@property (nonatomic, assign) CGColorRef itemBorderColor;
@property (nonatomic, assign) float itemCornerRadius;
@property (nonatomic, strong) UIColor *itemTitleColor;
@property (nonatomic, strong) UIColor *itemBackgroundColor;
@property (nonatomic, strong) UIFont *itemFont;

@property (nonatomic, assign) float betweenMargin;  // 间距
@property (nonatomic, assign) float lineMargin;     // 行间距
@property (nonatomic, assign) int rows;//行数

- (id)initWithItem:(NSArray *)itemArr constrainedFrame:(CGRect)frame constrainedItemSize:(CGSize)size;

@end
