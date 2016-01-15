//
//  HWCityListCell.m
//  Community
//
//  Created by caijingpeng.haowu on 14-9-6.
//  Copyright (c) 2014年 caijingpeng. All rights reserved.
//

#import "HWCityListCell.h"

#define CELL_HEIGHT     44

@implementation HWCityListCell
@synthesize titleLab;

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self)
    {
        // Initialization code
        
        titleLab = [[UILabel alloc] initWithFrame:CGRectMake(15, 7, kScreenWidth - 30, 30)];
        titleLab.backgroundColor = [UIColor clearColor];
        titleLab.textColor = UIColorFromRGB(0x333333);
        titleLab.font = [UIFont fontWithName:FONTNAME size:15.0f];
        [self.contentView addSubview:titleLab];
        
        UIView *line = [[UIView alloc] initWithFrame:CGRectMake(0, CELL_HEIGHT - 0.5f, kScreenWidth, 0.5f)];
        line.backgroundColor = THEME_COLOR_LINE;
        [self.contentView addSubview:line];
        
    }
    return self;
}

- (void)awakeFromNib
{
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
