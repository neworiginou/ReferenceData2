//
//  UIButton+UIButton_utily.m
//  UtilityDemo
//
//  Created by wuxiaohong on 15/3/31.
//  Copyright (c) 2015年 hw. All rights reserved.
//

#import "UIButton+UIButton_utily.h"

@implementation UIButton (UIButton_utily)
-(void)setButtonRedAndOrangeBorderStyle
{
    self.layer.borderWidth = 0;
    //self setTitleColor:CD_Txt_Color_ff   forState:<#(UIControlState)#>
    [self setTitleColor:[UIColor whiteColor]forState:UIControlStateNormal];
    self.layer.cornerRadius = 3.5;
    self.layer.masksToBounds = YES;
    self.titleLabel.font = [UIFont fontWithName:  FONTNAME size:20];
    [self setBackgroundImage:[Utility imageWithColor:CD_Btn andSize:self.frame.size] forState:UIControlStateNormal];
}

@end
