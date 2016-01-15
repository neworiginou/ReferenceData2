//
//  HWChannelButton.m
//  Community
//
//  Created by zhangxun on 15/1/12.
//  Copyright (c) 2015年 caijingpeng. All rights reserved.
//

#import "HWChannelButton.h"
#define kTitleSize 14.0f
#define kChannelHeight 26.0f

@implementation HWChannelButton

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

- (id)init
{
    self = [HWChannelButton buttonWithType:UIButtonTypeCustom];
    self.layer.cornerRadius = 4.0f;
    self.clipsToBounds = YES;
    self.backgroundColor = [UIColor whiteColor];//[UIColor colorWithRed:242.0 / 255.0 green:242.0 / 255.0 blue:242.0 / 255.0 alpha:1];
    [self setBackgroundImage:[Utility imageWithColor:[UIColor whiteColor] andSize:CGSizeMake(10, 10)] forState:UIControlStateNormal];
    self.layer.borderWidth = 1.0f;
    self.layer.borderColor = THEME_COLOR_ORANGE.CGColor;
    [self setTitleColor:THEME_COLOR_ORANGE forState:UIControlStateNormal];
    [self.titleLabel setFont:[UIFont systemFontOfSize:kTitleSize]];
    return self;
}

- (void)setString:(NSString *)text
{
    NSString *str;
    if (text.length > 6)
    {
        str = [NSString stringWithFormat:@"%@...",[text substringWithRange:NSMakeRange(0, 5)]];
    }
    else
    {
        str = text;
    }
    if (IOS7)
    {
        NSDictionary *attribute = @{NSFontAttributeName: [UIFont systemFontOfSize:kTitleSize]};
        CGRect rect = [str boundingRectWithSize:CGSizeMake(100, 100) options:NSStringDrawingTruncatesLastVisibleLine attributes:attribute context:nil];
        [self setFrame:CGRectMake(0, 0, rect.size.width + 10, kChannelHeight)];
    }
    else
    {
        CGSize size = [str sizeWithFont:[UIFont systemFontOfSize:kTitleSize]];
        [self setFrame:CGRectMake(0, 0, size.width + 10, kChannelHeight)];
    }
    
    [self setTitle:str forState:UIControlStateNormal];
}

@end
