//
//  SilverHeader.m
//  PUClient
//
//  Created by RRLhy on 15/8/3.
//  Copyright (c) 2015年 RRLhy. All rights reserved.
//

#import "SilverHeader.h"

@implementation SilverHeader

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        
        UIImageView * backImage = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, frame.size.width, frame.size.height)];
        backImage.image = [UIImage imageNamed:@"bg_me_silver"];
        [self addSubview:backImage];
        
        UIImageView * silverImg = [[UIImageView alloc]initWithFrame:CGRectMake((frame.size.width -73)/2, 82, 73, 43)];
        silverImg.image = [UIImage imageNamed:@"icon_me_silver"];
        [self addSubview:silverImg];
        
        _numLabel = [[UILabel alloc]initWithFrame:CGRectMake(0, 130, frame.size.width, 30)];
        _numLabel.textAlignment = NSTextAlignmentCenter;
        _numLabel.textColor = [UIColor whiteColor];
        [self addSubview:_numLabel];
    }
    return self;
}

- (void)upDateSilverCount:(NSString *)count
{
    NSString * str = [NSString stringWithFormat:@"%@银币",count];
    NSMutableAttributedString * attributeString = [[NSMutableAttributedString alloc]initWithString:str];
    [attributeString addAttributes:@{NSFontAttributeName:BOLDSYSTEMFONT(24)} range:NSMakeRange(0, count.length)];
    [attributeString addAttributes:@{NSFontAttributeName:SYSTEMFONT(17)} range:NSMakeRange(count.length, 2)];
    _numLabel.attributedText = attributeString;
}

@end
