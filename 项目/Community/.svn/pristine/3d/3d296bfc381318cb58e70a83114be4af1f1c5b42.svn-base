//
//  HWDetailDoubleCell.m
//  HaoWu_4.0
//
//  Created by caijingpeng.haowu on 14-6-2.
//  Copyright (c) 2014年 caijingpeng. All rights reserved.
//

#import "HWDetailDoubleCell.h"
#define LEFT_MARGIN 10
#define TOP_MARGIN 10

@implementation HWDetailDoubleCell
@synthesize leftLabel,rightLabel,line;
- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        
        leftLabel = [[UILabel alloc] initWithFrame:CGRectMake(LEFT_MARGIN, 0, 60, 45)];
//        leftLabel.textAlignment = NSTextAlignmentRight;
        leftLabel.font = [UIFont fontWithName:FONTNAME size:13.0f];
        [self.contentView addSubview:leftLabel];
        
        rightLabel = [[UILabel alloc] initWithFrame:CGRectMake(CGRectGetMaxX(leftLabel.frame) + 10, 0, kScreenWidth - 100, 45)];
        rightLabel.font = [UIFont fontWithName:FONTNAME size:13.0f];
        rightLabel.textColor = THEME_COLOR_TEXT;
        [self.contentView addSubview:rightLabel];
        
        line = [[UIImageView alloc] initWithFrame:CGRectMake(0, 44.5, kScreenWidth, 0.5)];
        line.backgroundColor = THEME_COLOR_LINE;
        [self.contentView addSubview:line];
        
    }
    return self;
}



@end
