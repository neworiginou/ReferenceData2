//
//  HWDoubleLabelCell.m
//  HaoWu_4.0
//
//  Created by caijingpeng.haowu on 14-5-29.
//  Copyright (c) 2014年 caijingpeng. All rights reserved.
//

#import "HWDoubleLabelCell.h"
#import "Define-OC.h"

#define MARGIN_LEFT 15
#define MARGIN_TOP  15

@implementation HWDoubleLabelCell
@synthesize leftLabel,rightLabel;

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        
        leftLabel = [[UILabel alloc] initWithFrame:CGRectMake(MARGIN_LEFT, MARGIN_TOP, 200, 20)];
        leftLabel.font = [UIFont fontWithName:FONTNAME size:15.0f];
        leftLabel.text = @"";
#warning color
//        leftLabel.textColor = THEME_COLOR_SMOKE;
        leftLabel.backgroundColor = [UIColor clearColor];
        [self.contentView addSubview:leftLabel];
        
        rightLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 0, 20)];
        rightLabel.font = [UIFont fontWithName:FONTNAME size:14.0f];
#warning color
//        rightLabel.textColor = THEME_COLOR_TEXT;
        
        rightLabel.backgroundColor = [UIColor clearColor];
        [self.contentView addSubview:rightLabel];
        
    }
    return self;
}

- (void)frameToFit
{
    [leftLabel sizeToFit];
    rightLabel.frame = CGRectMake(CGRectGetMaxX(leftLabel.frame) + 5, leftLabel.center.y - 10, self.frame.size.width - CGRectGetMaxX(leftLabel.frame) - 5, rightLabel.frame.size.height);
}


@end
