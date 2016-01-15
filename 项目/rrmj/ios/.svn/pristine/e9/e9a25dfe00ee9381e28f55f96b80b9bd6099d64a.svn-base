//
//  TopSegMentrol.m
//  PUClient
//
//  Created by RRLhy on 15/7/23.
//  Copyright (c) 2015年 RRLhy. All rights reserved.
//

#import "TopSegMentrol.h"

@implementation TopSegMentrol
{
    NSArray * _itemArray;
    UIScrollView * _scrollView;
}

- (instancetype)initWithFrame:(CGRect)frame itemsTitleArray:(NSArray*)titleArray
{
    self = [super initWithFrame:frame];
    
    if (self) {
        
        _itemArray = titleArray;
        
        [self addScrollView];
        [self initilizer];
        
    }
    return self;
}

- (void)addScrollView
{
    if (!_scrollView) {
        _scrollView = [[UIScrollView alloc]initWithFrame:CGRectMake(0, 0, WIDTH(self), HEIGHT(self))];
        [self addSubview:_scrollView];
    }
}

- (void)initilizer
{
    float itemW = 80;
    float itemH = 26;
    float tSpace = 37;
    float mSpace = (Main_Screen_Width - 4*80 - tSpace*2)/3;
    
    for (int i = 0; i < _itemArray.count; i++) {
        
        UIButton * itemButton = [UIButton buttonWithType:UIButtonTypeCustom];
        
        [itemButton setFrame:CGRectMake(tSpace + (itemW + mSpace)*i, (HEIGHT(self)-itemH)/2, itemW, itemH)];
        
        [itemButton setTitle:_itemArray[i] forState:UIControlStateNormal];
        
        [itemButton setTitleColor:[UIColor whiteColor] forState:UIControlStateSelected];
        
        [itemButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        
        [itemButton setBackgroundImage:[UIImage stretchImageWithName:@"bg_navbar_9"] forState:UIControlStateSelected];
        
        [itemButton.imageView setContentMode:UIViewContentModeScaleAspectFit];
        
        [itemButton.titleLabel setFont:SYSTEMFONT(16)];
        
        [itemButton setTag:i + 10];
        
        [itemButton addTarget:self action:@selector(segmentIndex:) forControlEvents:UIControlEventTouchUpInside];
        
        [_scrollView addSubview:itemButton];
        if (i==0) {
            itemButton.selected = YES;
            _currentBtn = itemButton;
        }
        
    }
}

- (void)segmentIndex:(UIButton*)sender
{
    if (_currentIndex == sender.tag) {
        return;
    }

    _currentIndex = sender.tag;
    
    _currentBtn.selected = NO;
    
    sender.selected = YES;
    
    _currentBtn = sender;
    
    SelectBlock block = self.itemBlock;
    
    if (block) {
        
        self.itemBlock(_currentIndex);
    }
}

- (void)setCurrentIndex:(NSInteger)currentIndex
{
    NSInteger num = currentIndex + 10;
    if (_currentIndex == num) {
        return;
    }
    _currentIndex = num;
    
    _currentBtn.selected = NO;
   
    UIButton * btn = (UIButton*)[self viewWithTag:num];
    
    btn.selected = YES;
    
    _currentBtn = btn;
}

@end
