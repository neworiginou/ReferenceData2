//
//  HWServiceCatoryTableViewCell.m
//  Community
//
//  Created by gusheng on 14-9-15.
//  Copyright (c) 2014年 caijingpeng. All rights reserved.
//

#import "HWServiceCatoryTableViewCell.h"

@implementation HWServiceCatoryTableViewCell
@synthesize avatarImageView,titleLabel;
- (void)awakeFromNib
{
    
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}
- (id)init
{
    id object = loadObjectFromNib(@"HWServiceCatoryTableViewCell", [HWServiceCatoryTableViewCell class], self);
    if (object)
    {
        self = (HWServiceCatoryTableViewCell *)object;
    }
    else
    {
        self = [self init];
    }
    titleLabel.textColor = THEME_COLOR_TEXT;
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
