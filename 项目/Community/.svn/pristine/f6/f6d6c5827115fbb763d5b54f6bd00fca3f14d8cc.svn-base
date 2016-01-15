//
//  SystemInfoTableViewCell.m
//  Community
//
//  Created by gusheng on 14-9-7.
//  Copyright (c) 2014年 caijingpeng. All rights reserved.
//

#import "SystemInfoTableViewCell.h"

@implementation SystemInfoTableViewCell
@synthesize titleLabel;
- (void)awakeFromNib
{
    // Initialization code
}
- (id)init
{
    id object = loadObjectFromNib(@"SystemInfoTableViewCell", [SystemInfoTableViewCell class], self);
    if (object)
    {
        self = (SystemInfoTableViewCell *)object;
    }
    else
    {
        self = [self init];
    }
    self.backgroundColor = THEME_COLOR_CELLCOLOR;
    return self;
}

-(void)addLine:(float)orignHeigt isHide:(BOOL)flag
{
    UIImageView *lineView = [[UIImageView alloc]initWithFrame:CGRectMake(0, orignHeigt, kScreenWidth, 0.5)];
    lineView.backgroundColor = THEME_COLOR_LINE;
    lineView.hidden = flag;
    [self addSubview:lineView];
}
- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
