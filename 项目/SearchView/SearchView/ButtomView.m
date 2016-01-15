//
//  ButtomView.m
//  SearchView
//
//  Created by lizhongqiang on 15/7/7.
//  Copyright (c) 2015年 lqq. All rights reserved.
//

#import "ButtomView.h"

#import "MyButton.h"

#define kBtnWidth 106/2.0f

@interface ButtomView ()

@property (nonatomic, assign)int temp;

@property (nonatomic, strong)NSArray *arr1;

@property (nonatomic, strong)NSArray *arr2;

@property (nonatomic, assign)BOOL isFirstEnter;

@end

@implementation ButtomView

- (instancetype)initWithFrame:(CGRect)frame
{
    if(self = [super initWithFrame:frame])
    {
        _isFirstEnter = YES;
        
        
        [self initDataArray];
        
        
    
    }
    return self;
}
- (void)initDataArray
{
    _arr1 = @[@"学区房",@"轨交房",@"精装房"];
    
    _arr2 = @[@"满三年"];

}
- (void)addSubViews
{
    if(_temp == 0)
    {

        [self.subviews enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop) {
            
            MyButton *btn = (MyButton *)obj;
            
            if([self.subviews indexOfObject:btn] < _arr1.count)
            {
                NSInteger index = [self.subviews indexOfObject:btn];
                
                [btn setTitle:_arr1[index] forState:UIControlStateNormal];
                
                btn.hidden = NO;
            }
            else
            {
                btn.hidden = YES;
            }
            
            
        }];

        if(!_isFirstEnter)
        {
            return;
        }
    
        for(int i=0; i<_arr1.count; i++)
        {
            MyButton *btn = [[MyButton alloc]initWithFrame:CGRectMake(_x, _y, 0, 0)];
            
            [self addSubview:btn];
            
            [btn setTitle:_arr1[i] forState:UIControlStateNormal];
            
            [btn addTarget:self action:@selector(clickMyButton:) forControlEvents:UIControlEventTouchUpInside];
            
            _x += 6.f+kBtnWidth;
        }
    }
    else if(_temp == 1)
    {
        [self.subviews enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop) {
           
            MyButton *btn = (MyButton *)obj;
            
            if(self.subviews.count < _arr2.count)
            {
                for(NSInteger i = self.subviews.count; i<_arr2.count; i++)
                {
                    MyButton *btn = [[MyButton alloc]initWithFrame:CGRectMake(_x, _y, 0, 0)];
                    
                    [self addSubview:btn];
                    
                    [btn setTitle:_arr2[i] forState:UIControlStateNormal];
                    
                    [btn addTarget:self action:@selector(clickMyButton:) forControlEvents:UIControlEventTouchUpInside];
                    
                    _x += 6.f+kBtnWidth;
                }
            }
            
            if([self.subviews indexOfObject:btn] < _arr2.count)
            {
                NSInteger index = [self.subviews indexOfObject:btn];
                
                [btn setTitle:_arr2[index] forState:UIControlStateNormal];
                
                btn.hidden = NO;
            }
            else
            {
                btn.hidden = YES;
            }
            
            
        }];
    }
        
    
}
- (void)reloadSubViews:(int)temp
{
    _temp = temp;
    
    _isFirstEnter = NO;
    
    [self addSubViews];
}
- (void)clickMyButton:(MyButton *)btn
{
    if(self.clickButtomBtn)
    {
        self.clickButtomBtn(btn.titleLabel.text);
    }
}

@end
