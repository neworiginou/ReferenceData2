//
//  WalletView.m
//  HaoWu_4.0
//
//  Created by zhangxun on 14-5-24.
//  Copyright (c) 2014年 caijingpeng. All rights reserved.
//

#import "WalletView.h"

@implementation WalletView

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
    }
    
    return self;
}

- (id)initWithFrame:(CGRect)frame title:(NSString *)theTitle detail:(NSString *)theDetail isMoney:(BOOL)isMony{
    self = [super initWithFrame:frame];
    if (self) {
        _titleLabel = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, 100, 30)];
        _titleLabel.text = theTitle;
        _titleLabel.textAlignment = NSTextAlignmentRight;
        [self addSubview:_titleLabel];
        
        _detailLabe = [[UILabel alloc]initWithFrame:CGRectMake(110, 0, 200, 30)];
        _detailLabe.numberOfLines = 2;
        if (isMony) {
            _detailLabe.textColor = [UIColor redColor];
            _detailLabe.font = [UIFont fontWithName:FONTNAME size:14];
        }
        
        [self addSubview:_detailLabe];
    }
    return self;
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
    // Drawing code
}
*/

@end
