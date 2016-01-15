//
//  LoginBottomView.m
//  PUClient
//
//  Created by RRLhy on 15/7/19.
//  Copyright (c) 2015年 RRLhy. All rights reserved.
//

#import "LoginBottomView.h"

@implementation LoginBottomView

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

- (instancetype)initWithFrame:(CGRect)frame item:(NSArray*)itemArray
{
    self = [super initWithFrame:frame];
    if (self) {
        
        UILabel * label = [[UILabel alloc]initWithFrame:CGRectMake(0, 12, frame.size.width, 16)];
        label.textAlignment = NSTextAlignmentCenter;
        label.font = SYSTEMFONT(16);
        label.text = @"第三方登陆";
        [self addSubview:label];
        
        UIImageView * sepator = [[UIImageView alloc]initWithFrame:CGRectMake(0, MaxY(label) + 10, frame.size.width, 0.5)];
        sepator.backgroundColor = [UIColor lightGrayColor];
        [self addSubview:sepator];
        
        NSArray * imageN = itemArray[0];
        NSArray * imageH = itemArray[1];
        NSArray * title = itemArray[2];
        float space = (frame.size.width - 47*3)/4;
        
        for (int i = 0; i<itemArray.count; i++) {
            UIButton * button = [UIButton buttonWithType:UIButtonTypeCustom];
            [button setFrame:CGRectMake(space + (47 + space)*i , MaxY(sepator) + 30, 47, 47)];
            [button setImage:IMAGENAME(imageN[i]) forState:UIControlStateNormal];
            [button setImage:IMAGENAME(imageH[i]) forState:UIControlStateHighlighted];
            [button addTarget:self action:@selector(buttonClick:) forControlEvents:UIControlEventTouchUpInside];
            [button setTag:i];
            [self addSubview:button];
            
            UILabel * titleLab = [[UILabel alloc]initWithFrame:CGRectMake(button.frame.origin.x, CGRectGetMaxY(button.frame)+10, WIDTH(button), 15)];
            titleLab.textAlignment = NSTextAlignmentCenter;
            titleLab.font = SYSTEMFONT(12);
            titleLab.text = title[i];
            [self addSubview:titleLab];
        }
        
    }
    return self;
}

- (void)buttonClick:(UIButton*)sender
{
    ThirdIndexBlock block = self.thirdIndex;
    
    if (block) {
        block(sender.tag);
    }
}

@end
