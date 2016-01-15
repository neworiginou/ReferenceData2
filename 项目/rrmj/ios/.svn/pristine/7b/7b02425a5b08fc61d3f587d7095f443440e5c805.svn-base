//
//  LoginTopView.m
//  PUClient
//
//  Created by RRLhy on 15/7/17.
//  Copyright (c) 2015年 RRLhy. All rights reserved.
//

#import "LoginTopView.h"

@interface LoginTopView ()
{
    UIImageView * selectImage;
}
@property (nonatomic,weak)NSArray * titleArray;

@end
@implementation LoginTopView

- (instancetype)initWithFrame:(CGRect)frame items:(NSArray *)titleArray
{
    if (self = [super initWithFrame:frame]) {
        
        UIImageView * backgroundImage = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, frame.size.width, frame.size.height)];
        backgroundImage.image = [UIImage stretchImageWithName:@"nav_me_btn_bg"];
        [self addSubview:backgroundImage];
        
        self.titleArray = titleArray;
        float width = frame.size.width/titleArray.count;
        float height = frame.size.height - 2;

        selectImage = [[UIImageView alloc]initWithFrame:CGRectMake(1, 1, width, height)];
        selectImage.image = [UIImage stretchImageWithName:@"nav_me_btn_h"];
        [self addSubview:selectImage];
        
        for (int i = 0; i< titleArray.count; i++) {
            
            UIButton * btn = [UIButton buttonWithType:UIButtonTypeCustom];
            btn.titleLabel.textAlignment = NSTextAlignmentCenter;
            btn.frame = CGRectMake(width*i, 1, width, height);
            [btn addTarget:self action:@selector(buttonClick:) forControlEvents:UIControlEventTouchUpInside];
            [btn setTitle:[titleArray objectAtIndex:i] forState:UIControlStateNormal];
            [btn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];//设置title在一般情况下为白色字体
            [btn.titleLabel setFont:SYSTEMFONT(14)];
            [btn setTag:i];
            [self addSubview:btn];

        }
        
    }
    
    return self;
}

- (void)buttonClick:(UIButton*)sender
{
    if (_currentIndex == sender.tag) {
        return;
    }
    self.currentIndex = sender.tag;
    
    LoginIndexBlock block = self.indexBlock;
    
    if (block) {
        block(sender.tag);
    }
}

- (void)setCurrentIndex:(NSInteger)currentIndex
{
    _currentIndex = currentIndex;
    
    [self selectAnimation:currentIndex];
}

- (void)selectAnimation:(NSInteger)index
{
    
    float width = self.frame.size.width/2 - 2;
    float height = self.frame.size.height - 2;
    
    [UIView animateWithDuration:0.3 animations:^{
        
        selectImage.frame = CGRectMake(1 + (width + 2)*index, 1, width, height);
        
    } completion:^(BOOL finished) {
        
    }];
    
}

@end
