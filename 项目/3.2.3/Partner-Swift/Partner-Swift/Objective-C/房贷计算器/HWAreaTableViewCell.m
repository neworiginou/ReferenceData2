//
//  HWAreaTableViewCell.m
//  HaoWuAgenciesEdition
//
//  Created by gusheng on 14-7-9.
//  Copyright (c) 2014年 ZhuMing. All rights reserved.
//

#import "HWAreaTableViewCell.h"
#import "Partner_Swift-Swift.h"
#import "Define-OC.h"

@implementation HWAreaTableViewCell
@synthesize titleLabel,unitLabel;

-(instancetype)init
{
    id object = loadObjectFromNib(@"HWAreaTableViewCell", [HWAreaTableViewCell class], self);
    if (object) {
        self = (HWAreaTableViewCell *)object;
    }
    else
    {
        self = [self init];
    }
    return self;
}
- (void)awakeFromNib
{
    
    titleLabel.font = [UIFont fontWithName:FONTNAME size:14];
    titleLabel.textColor = UIColorFromRGB(0x333333);
    
    unitLabel.font = [UIFont fontWithName:FONTNAME size:14];
    unitLabel.textColor = UIColorFromRGB(0x333333);
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
