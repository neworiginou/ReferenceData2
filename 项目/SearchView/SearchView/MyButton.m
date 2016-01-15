//
//  MyButton.m
//  SearchView
//
//  Created by lizhongqiang on 15/7/7.
//  Copyright (c) 2015年 lqq. All rights reserved.
//

#import "MyButton.h"

#define kRadius 10.6f

#define kBtnWidth 106/2.0f

#define kBtnHeight 46/2.0f

#define UIColorFromRGB(rgbValue)	    [UIColor colorWithRed:((float)((rgbValue & 0xFF0000) >> 16))/255.0 green:((float)((rgbValue & 0xFF00) >> 8))/255.0 blue:((float)(rgbValue & 0xFF))/255.0 alpha:0.3]

@implementation MyButton


- (instancetype)initWithFrame:(CGRect)frame
{
    frame = CGRectMake(frame.origin.x, frame.origin.y, kBtnWidth, kBtnHeight);
    
    if(self = [super initWithFrame:frame])
    {
        self.layer.cornerRadius = kRadius;
        
        self.layer.borderWidth = 1;
        
        self.layer.borderColor = [UIColor colorWithRed:254/255.f green:213/255.0f blue:193/255.f alpha:1.0].CGColor;
        
        self.backgroundColor = [UIColor colorWithWhite:0xFFF/255.f alpha:0.1];
        
        self.layer.masksToBounds = YES;
        
        self.titleLabel.textColor = UIColorFromRGB(0xFFFFFFF);
        
        self.titleLabel.font = [UIFont boldSystemFontOfSize:24/2.f];
    }
    
    return self;
}


@end
