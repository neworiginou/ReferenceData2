//
//  SearchView.m
//  SearchView
//
//  Created by lizhongqiang on 15/7/7.
//  Copyright (c) 2015年 lqq. All rights reserved.
//

#import "SearchView.h"

#import "SearchTextField.h"

#import "NewOldBtn.h"

#import "ButtomView.h"

#define kSpaceX 22/2.0

#define kSpaceY 88/2.0



#define UIColorFromRGB(rgbValue)	    [UIColor colorWithRed:((float)((rgbValue & 0xFF0000) >> 16))/255.0 green:((float)((rgbValue & 0xFF00) >> 8))/255.0 blue:((float)(rgbValue & 0xFF))/255.0 alpha:1.0]

@interface SearchView ()<UITextFieldDelegate,NewOldBtnDelegate>

@property (nonatomic, strong)SearchTextField *textField;

@property (nonatomic, strong)NewOldBtn *btn;

@property (nonatomic, strong)ButtomView *buttomView;

@end

@implementation SearchView

- (instancetype)init
{
    if(self = [super init])
    {
        self.backgroundColor = [UIColor colorWithRed:253/255.0 green:129/255.0 blue:57/255.0 alpha:1.0];
    
        _textField = [[SearchTextField alloc]init];
        
        _textField.delegate = self;
        
        [self addSubview:_textField];
        
        [self addSubviewForBtns];
        
        [self addSubViewForNewOldBtn];
        
    }
    return self;
}
- (void)addSubviewForBtns
{
    CGFloat x = kSpaceX;
    
    CGFloat y = 26/2.f;
    
   
    _buttomView = [[ButtomView alloc]initWithFrame:CGRectMake(0, 250/2.0f - 92/2.f, [UIScreen mainScreen].bounds.size.width, 92/2.f)];
    
    _buttomView.x = x;
    
    _buttomView.y = y;
    
    _buttomView.backgroundColor = [UIColor clearColor];
    
    [_buttomView addSubViews];
    
    __unsafe_unretained SearchView * weak = self;
    
    _buttomView.clickButtomBtn = ^(NSString *string)
    {
        weak.clickButtomBtn(string);
        
    };
    
    [self addSubview:_buttomView];
    
}
- (void)addSubViewForNewOldBtn
{
    NewOldBtn *btn1 = [[NewOldBtn alloc]initWithFrame:CGRectMake(20+kSpaceX, 5, 40, 40)];
    
    btn1.title = @"新房";
    
    btn1.temp = 1;
    
    btn1.delegate = self;
    
    btn1.backgroundColor = [UIColor clearColor];
    
    [self addSubview:btn1];
    
    NewOldBtn *btn2 = [[NewOldBtn alloc]initWithFrame:CGRectMake(20+kSpaceX+40+20, 5, 60, 40)];
    
    btn2.title = @"二手房";
    
    btn2.delegate = self;
    
    btn2.temp = 0;
    
    btn2.backgroundColor = [UIColor clearColor];
    
    [self addSubview:btn2];
    
    _btn = btn1;
}
- (void)setFrame:(CGRect)frame
{
    CGPoint point = CGPointMake(frame.origin.x, frame.origin.y);
    
    frame = CGRectMake(point.x, point.y, [UIScreen mainScreen].bounds.size.width, 250/2.0f);
    
    [super setFrame:frame];
    
    _textField.frame = CGRectMake(kSpaceX, kSpaceY, frame.size.width - 2*kSpaceX,  frame.size.height - 2*kSpaceY);
    
    
}

- (void)clickNewOldBtn:(NewOldBtn *)btn
{
    if([btn.title isEqualToString:_btn.title])
    {
        btn.temp = 1;
        
        [btn setNeedsDisplay];
        
        _btn = btn;
    }
    else
    {
        _btn.temp = 0;
        
        btn.temp = 1;
        
        [_btn setNeedsDisplay];
        
        [btn setNeedsDisplay];
        
        _btn = btn;
    }
    if([btn.title isEqualToString:@"新房"])
    {
        [_buttomView reloadSubViews:0];
    }
    else if([btn.title isEqualToString:@"二手房"])
    {
        [_buttomView reloadSubViews:1];
    }
    
}
- (BOOL)textFieldShouldBeginEditing:(UITextField *)textField
{
    if(self.clickTopBtn)
    {
        self.clickTopBtn(_btn.title);
    }
    
    return NO;
}
@end
