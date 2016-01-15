//
//  SearchTextField.m
//  SearchView
//
//  Created by lizhongqiang on 15/7/7.
//  Copyright (c) 2015年 lqq. All rights reserved.
//

#import "SearchTextField.h"

#define kPlaceholderX 29/2.0

#define kPlaceholderY 4.8

#define kSearchX 142/2.0

#define UIColorFromRGB(rgbValue)	    [UIColor colorWithRed:((float)((rgbValue & 0xFF0000) >> 16))/255.0 green:((float)((rgbValue & 0xFF00) >> 8))/255.0 blue:((float)(rgbValue & 0xFF))/255.0 alpha:1.0]

@interface SearchTextField ()

@property (nonatomic, strong)UIButton *rightBtn;

@end

@implementation SearchTextField


- (instancetype)init
{
    if(self = [super init])
    {
        self.backgroundColor = [UIColor whiteColor];
        
        self.attributedPlaceholder =  [[NSAttributedString alloc]initWithString:@"请输入楼盘名或区域" attributes:@{NSFontAttributeName:[UIFont boldSystemFontOfSize:26/2.0f],NSForegroundColorAttributeName:UIColorFromRGB(0x999999)}];
        
        self.borderStyle = UITextBorderStyleRoundedRect;
        
        
        UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
        
        [btn setTitle:@"搜索" forState:UIControlStateNormal];
        
        btn.backgroundColor = [UIColor greenColor];
        
        _rightBtn = btn;
        
        self.inputView = [[UIView alloc]initWithFrame:CGRectZero];
        
    }
    return self;
}

- (void)setFrame:(CGRect)frame
{
    _rightBtn.frame = CGRectMake(0, 0, kSearchX, frame.size.height);
    
    self.rightView = _rightBtn;
    
    self.layer.masksToBounds = YES;
    
    self.layer.cornerRadius = 4.0f;
    
    self.rightViewMode = UITextFieldViewModeAlways;
    
    [super setFrame:frame];
}


- (CGRect)placeholderRectForBounds:(CGRect)bounds
{
    return CGRectMake(kPlaceholderX, kPlaceholderY, 200, bounds.size.height - 2*kPlaceholderY);
}

@end
