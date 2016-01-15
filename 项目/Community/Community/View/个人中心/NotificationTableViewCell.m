//
//  NotificationTableViewCell.m
//  Community
//
//  Created by gusheng on 14-9-8.
//  Copyright (c) 2014年 caijingpeng. All rights reserved.
//

#import "NotificationTableViewCell.h"

@implementation NotificationTableViewCell
@synthesize selectBtn,titleLabel,tipONOrOffLabel,delegate;
- (void)awakeFromNib
{
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}
-(void)addLine:(float)orignHeigt isHide:(BOOL)flag
{
    UIImageView *lineView = [[UIImageView alloc]initWithFrame:CGRectMake(0, orignHeigt, kScreenWidth, 0.5)];
    lineView.backgroundColor = THEME_COLOR_LINE;
    lineView.hidden = flag;
    [self addSubview:lineView];
}

- (IBAction)toggleSwitch:(UISwitch *)sender
{
    if (delegate && [delegate respondsToSelector:@selector(notifyCell:switchValueChange:)])
    {
        [delegate notifyCell:self switchValueChange:sender.on];
    }
}

- (id)init
{
    id object = loadObjectFromNib(@"NotificationTableViewCell", [NotificationTableViewCell class], self);
    if (object)
    {
        self = (NotificationTableViewCell *)object;
    }
    else
    {
        self = [self init];
    }
    titleLabel.textColor = UIColorFromRGB(0x333333);
    [titleLabel setFont:[UIFont systemFontOfSize:15.0]];
    self.backgroundColor = THEME_COLOR_CELLCOLOR;
    return self;
}
@end
