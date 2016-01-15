//
//  DateSelectView.m
//  PUClient
//
//  Created by RRLhy on 15/8/15.
//  Copyright (c) 2015年 RRLhy. All rights reserved.
//

#import "DateSelectView.h"

@interface DateSelectView ()

@property (nonatomic, retain)UISegmentedControl *segmentedCtrl;

@end

@implementation DateSelectView


- (id)initWithFrame:(CGRect)frame items:(NSArray*)titles complete:(TouchActionBlock)block
{
    self = [super initWithFrame:frame];
    if (self == nil) {
        return nil  ;
    }
    self.itemBlock = block;
    
    self.titleArray = titles;
    
    CGRect rect = CGRectMake(0, 0, frame.size.width/titles.count, frame.size.height);
    
    UIButton * titleBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    titleBtn.frame = rect;
    titleBtn.tag = 1;
    titleBtn.titleLabel.font = [UIFont boldSystemFontOfSize:16];
    [titleBtn setTitle:[titles objectAtIndex:0] forState:UIControlStateNormal];
    [titleBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [titleBtn setTitleColor:[UIColor blackColor] forState:UIControlStateSelected];
    [titleBtn setBackgroundImage:[UIImage stretchImageWithName:@"nav_news_ranking_l_n.9"] forState:UIControlStateNormal];
    [titleBtn setBackgroundImage:[UIImage stretchImageWithName:@"nav_news_ranking_l_h.9"] forState:UIControlStateSelected];
    [titleBtn addTarget:self action:@selector(btnClick:) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:titleBtn];
    
    _currentBtn = titleBtn;
    _currentBtn.selected = YES;
    titleBtn = _currentBtn;

    UIButton * titleBtn1 = [UIButton buttonWithType:UIButtonTypeCustom];
    rect.origin.x = frame.size.width/2;
    titleBtn1.frame = rect;
    titleBtn1.tag = 2;
    titleBtn1.titleLabel.font = [UIFont boldSystemFontOfSize:16];
    [titleBtn1 setTitle:[titles objectAtIndex:1] forState:UIControlStateNormal];
    [titleBtn1 setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [titleBtn1 setTitleColor:[UIColor blackColor] forState:UIControlStateSelected];
    [titleBtn1 setBackgroundImage:[UIImage stretchImageWithName:@"nav_news_ranking_r_n.9"] forState:UIControlStateNormal];
    [titleBtn1 setBackgroundImage:[UIImage stretchImageWithName:@"nav_news_ranking_r_h.9"] forState:UIControlStateSelected];
    [titleBtn1 addTarget:self action:@selector(btnClick:) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:titleBtn1];
    
    return self;
}

- (void)btnClick:(UIButton*)sender
{
    if (_currentIndex == sender.tag) {
        return;
    }
    self.currentIndex = sender.tag;
    self.itemBlock(_currentIndex);
    
    _currentBtn.selected = NO;
    _currentBtn = sender;
    sender.selected = YES;
}

- (void)setCurrentIndex:(NSInteger)currentIndex
{
    _currentIndex = currentIndex;
    UIButton * btn = (UIButton*)[self viewWithTag:currentIndex + 1];
    
    _currentBtn.selected = NO;
    _currentBtn = btn;
    btn.selected = YES;
}

#if 0
#define kSegmentX (20)

#define kSegmentY (7.5)

- (instancetype)initWithFrame:(CGRect)frame items:(NSArray *)titles
{
    if(self = [super initWithFrame:frame])
    {
        _segmentedCtrl = [[UISegmentedControl alloc]initWithItems:titles];
        
        _segmentedCtrl.selectedSegmentIndex = 0;
        
        
 
        _segmentedCtrl.frame = CGRectMake(kSegmentX, kSegmentY, frame.size.width - 2*kSegmentX, frame.size.height - 2*kSegmentY);
        
        [_segmentedCtrl addTarget:self action:@selector(clickSegemented:) forControlEvents:UIControlEventValueChanged];
        
//        _segmentedCtrl.backgroundColor = [UIColor colorWithRed:0.05 green:0.33 blue:0.71 alpha:1.0];
        _segmentedCtrl.backgroundColor = [UIColor blackColor];
        
//        _segmentedCtrl.tintColor = [UIColor colorWithRed:84/255.0 green:131/255.0 blue:202/255.0 alpha:1.0];
        _segmentedCtrl.tintColor = [UIColor whiteColor];
        //[UIColor colorWithRed:1.0 green:1.0 blue:1.0 alpha:1.0];
        
        NSMutableDictionary *dict = [NSMutableDictionary dictionary];
        dict[NSForegroundColorAttributeName] = [UIColor whiteColor];
        [_segmentedCtrl setTitleTextAttributes:dict forState:UIControlStateNormal];
        [_segmentedCtrl setTitleTextAttributes:dict forState:UIControlStateSelected];
        
        [self addSubview:_segmentedCtrl];
        
        
    }
    return self;
}

- (void)clickSegemented:(UISegmentedControl *)sender
{
    NSInteger index = sender.selectedSegmentIndex;
    if(self.itemBlock)
    {
        self.itemBlock(index);
    }
}

- (void)setCurrentIndex:(NSInteger)currentIndex
{
    _currentIndex = currentIndex;
    _segmentedCtrl.selectedSegmentIndex = currentIndex;
}
#endif
@end
