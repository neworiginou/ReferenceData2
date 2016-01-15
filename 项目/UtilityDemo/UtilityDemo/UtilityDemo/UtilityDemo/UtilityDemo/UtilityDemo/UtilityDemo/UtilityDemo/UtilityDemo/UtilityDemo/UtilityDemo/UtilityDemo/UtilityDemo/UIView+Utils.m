//
//  UIView+Utils.m
//  Template-OC
//
//  Created by wuxiaohong on 15/4/3.
//  Copyright (c) 2015年 caijingpeng.haowu. All rights reserved.
//

#import "UIView+Utils.h"
#import "UIView+AutoLayout.h"
int  topLineTag = 1000000;
int bottomLineTag = 1000001;
@implementation UIView (Utils)
/**
 * 画顶部的线
 */
-(void)drawTopLine
{
    if ([self viewWithTag:topLineTag] != nil) {
        [[self viewWithTag:topLineTag] removeFromSuperview];
        
    }
    UIImageView * line =(UIImageView *)[self initForAutoLayout];
    line.tag = topLineTag;
    [self addSubview:line];
    line.layer.masksToBounds = true;
    [line autoPinEdgesToSuperviewEdgesWithInsets:UIEdgeInsetsMake(0, 0, 0, 0) excludingEdge:ALEdgeBottom];
    [line autoSetDimension:ALDimensionHeight toSize:lineHeight];
    CGSize size = CGSizeMake(1, 1);
    line.image = [Utility imageWithColor:[UIColor whiteColor] andSize:size];
    
}
//画底部的线
-(void)drawButtomLine
{
    if ([self viewWithTag:bottomLineTag] != nil) {
        [[self viewWithTag:bottomLineTag] removeFromSuperview];
        
    }
    UIImageView * line =  [UIImageView newAutoLayoutView];
    
    line.tag = bottomLineTag;
    [self addSubview:line];
    line.layer.masksToBounds = true;
    [line autoPinEdgesToSuperviewEdgesWithInsets:UIEdgeInsetsMake(0, 0, 0, 0) excludingEdge:ALEdgeTop];
    [line autoSetDimension:ALDimensionHeight toSize:lineHeight];
    CGSize size = CGSizeMake(1, 1);
    line.image = [Utility imageWithColor:CD_LineColor andSize:size];
    

}
@end
