//
//  HWNoFoundPicView.m
//  Community
//
//  Created by hw500029 on 15/1/23.
//  Copyright (c) 2015年 caijingpeng. All rights reserved.
//

#import "HWNoFoundPicView.h"

@implementation HWNoFoundPicView

-(id)initWithText:(NSString *)text
{
    self = [super initWithFrame:CGRectMake(0, 0, kScreenWidth, CONTENT_HEIGHT - (45 + 35) * kScreenRate)];
    if (self)
    {
        self.backgroundColor = BACKGROUND_COLOR;
        UIImageView *imgView = [[UIImageView alloc]initWithFrame:CGRectMake(kScreenWidth/2 - 285 / 2 * kScreenRate / 2, 125 * kScreenRate, 285 / 2 * kScreenRate, 211 / 2 * kScreenRate)];
        imgView.image = [UIImage imageNamed:@"no_found_pic"];
        imgView.backgroundColor = [UIColor clearColor];
        
        
        UILabel *textLabel = [[UILabel alloc]initWithFrame:CGRectMake(0, (125 + 211/2 + 30) * kScreenRate, kScreenWidth, 15)];
        textLabel.backgroundColor = [UIColor clearColor];
        textLabel.textAlignment = NSTextAlignmentCenter;
        textLabel.font = [UIFont fontWithName:FONTNAME size:15];
        textLabel.text = text;
        textLabel.textColor = THEME_COLOR_TEXT;
        
        [self addSubview:textLabel];
        [self addSubview:imgView];
        
    }
    return self;
}
@end
