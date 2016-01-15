//
//  EveryDayRecordTableViewCell.m
//  TEST
//
//  Created by gusheng on 14-8-29.
//  Copyright (c) 2014年 gusheng. All rights reserved.
//

#import "EveryDayRecordTableViewCell.h"
#import "Utility.h"
@implementation EveryDayRecordTableViewCell
@synthesize phoneStyle,scanMonthAndDay,activeMonthAndDay,registerTime;
- (void)awakeFromNib
{
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}
-(instancetype)init{
    id object = loadObjectFromNib(@"EveryDayRecordTableViewCell", [EveryDayRecordTableViewCell class], self);
    if (object)
    {
        self = (EveryDayRecordTableViewCell *)object;
    }
    else
    {
        self = [self init];
    }
//    self.backgroundColor = UIColorFromRGB(0xf2f2f2);
//    phoneStyle.textColor = UIColorFromRGB(0x666666);
//    scanMonthAndDay.textColor = UIColorFromRGB(0x999999);
//    activeMonthAndDay.textColor = UIColorFromRGB(0x999999);
//    activeStatus.textColor = UIColorFromRGB(0x999999);
    return self;
}

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self)
    {
        CGFloat potx = 0.0;
        phoneStyle = [[UILabel alloc]initWithFrame:CGRectMake(15, 0, 95 * kScreenRate, 50)];
        phoneStyle.backgroundColor = [UIColor clearColor];
        phoneStyle.lineBreakMode = NSLineBreakByWordWrapping;
        phoneStyle.numberOfLines = 2;
        phoneStyle.textColor = UIColorFromRGB(0x333333);
        phoneStyle.font = [UIFont fontWithName:FONTNAME size:11];
        [self.contentView addSubview:phoneStyle];
        potx +=phoneStyle.frame.size.width + phoneStyle.frame.origin.x;
        
        scanMonthAndDay = [[UILabel alloc]initWithFrame:CGRectMake(potx, 0, 65 *kScreenRate, 50)];
        scanMonthAndDay.backgroundColor = [UIColor clearColor];
        scanMonthAndDay.lineBreakMode = NSLineBreakByWordWrapping;
        scanMonthAndDay.numberOfLines = 2;
        scanMonthAndDay.font = [UIFont fontWithName:FONTNAME size:10];
        scanMonthAndDay.textColor = UIColorFromRGB(0x999999);
        scanMonthAndDay.textAlignment = NSTextAlignmentCenter;
        [self.contentView addSubview:scanMonthAndDay];
        potx += scanMonthAndDay.frame.size.width;
        
        activeMonthAndDay = [[UILabel alloc]initWithFrame:CGRectMake(potx,0, 65 * kScreenRate, 50)];
        activeMonthAndDay.backgroundColor = [UIColor clearColor];
        activeMonthAndDay.lineBreakMode = NSLineBreakByWordWrapping;
        activeMonthAndDay.numberOfLines = 2;
        activeMonthAndDay.font = [UIFont fontWithName:FONTNAME size:10];
        activeMonthAndDay.textColor = UIColorFromRGB(0x999999);
        activeMonthAndDay.textAlignment = NSTextAlignmentCenter;
        [self.contentView addSubview:activeMonthAndDay];
        potx += activeMonthAndDay.frame.size.width;
        
        registerTime = [[UILabel alloc]initWithFrame:CGRectMake(potx, 0, 65 * kScreenRate, 50)];
        registerTime.backgroundColor = [UIColor clearColor];
        registerTime.lineBreakMode = NSLineBreakByWordWrapping;
        registerTime.numberOfLines = 2;
        registerTime.font = [UIFont fontWithName:FONTNAME size:10];
        registerTime.textColor = UIColorFromRGB(0x999999);
        registerTime.textAlignment = NSTextAlignmentCenter;
        [self.contentView addSubview:registerTime];
    }
    return self;
}


@end
