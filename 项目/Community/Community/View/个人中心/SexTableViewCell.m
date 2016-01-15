//
//  SexTableViewCell.m
//  Community
//
//  Created by gusheng on 14-9-6.
//  Copyright (c) 2014年 caijingpeng. All rights reserved.
//

#import "SexTableViewCell.h"

@implementation SexTableViewCell
@synthesize sexTitle,gouImageView;
- (void)awakeFromNib
{
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}
- (id)init
{
    id object = loadObjectFromNib(@"SexTableViewCell", [SexTableViewCell class], self);
    if (object)
    {
        self = (SexTableViewCell *)object;
    }
    else
    {
        self = [self init];
    }
    sexTitle.textColor = THEME_COLOR_SMOKE;
    sexTitle.font = [UIFont systemFontOfSize:THEME_FONT_BIG];
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
@end
