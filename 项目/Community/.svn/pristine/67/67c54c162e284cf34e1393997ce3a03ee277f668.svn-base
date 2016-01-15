//
//  HWSearchBarCell.m
//  HaoWuAgenciesEdition
//
//  Created by lizhongqiang on 14-6-15.
//  Copyright (c) 2014年 ZhuMing. All rights reserved.
//

#import "HWSearchBarCell.h"

@implementation HWSearchBarCell
@synthesize labelCell;
- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self)
    {
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        
        UIView *line = [[UIView alloc] initWithFrame:CGRectMake(0, 42 - 0.5f, kScreenWidth, 0.5f)];
        line.backgroundColor = THEME_COLOR_LINE;
        [self.contentView addSubview:line];
        
        labelCell = [[UILabel alloc] initWithFrame:CGRectMake(10, 10, kScreenWidth - 20, 21)];
        [labelCell setTextAlignment:NSTextAlignmentLeft];
        [labelCell setBackgroundColor:[UIColor clearColor]];
        [labelCell setTextColor:[UIColor blackColor]];
        [labelCell setFont:[UIFont fontWithName:FONTNAME size:14.0f]];
        [self.contentView addSubview:labelCell];
        
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
