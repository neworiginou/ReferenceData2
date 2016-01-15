//
//  ModifyPersonInfoTableViewCell.m
//  Community
//
//  Created by gusheng on 14-9-1.
//  Copyright (c) 2014年 caijingpeng. All rights reserved.
//

#import "ModifyPersonInfoTableViewCell.h"
#import "Utility.h"
@implementation ModifyPersonInfoTableViewCell
@synthesize catoryLabel,catroryContentLabel;
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
    id object = loadObjectFromNib(@"ModifyPersonInfoTableViewCell", [ModifyPersonInfoTableViewCell class], self);
    if (object)
    {
        self = (ModifyPersonInfoTableViewCell *)object;
    }
    else
    {
        self = [self init];
    }
    
    catoryLabel.textColor = THEME_COLOR_SMOKE;
    [catoryLabel setFont:[UIFont fontWithName:FONTNAME size:THEME_FONT_BIG]];
    catroryContentLabel.textColor =  THEME_COLOR_TEXT;
    [catroryContentLabel setFont:[UIFont fontWithName:FONTNAME size:THEME_FONT_BIG]];
    
    UIImageView *lineView = [[UIImageView alloc]initWithFrame:CGRectMake(0, 50 - 0.5f, kScreenWidth, 0.5)];
    lineView.backgroundColor = THEME_COLOR_LINE;
    [self addSubview:lineView];
    
    return self;
}

@end
