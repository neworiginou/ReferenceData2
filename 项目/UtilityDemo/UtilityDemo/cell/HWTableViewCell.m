//
//  HWTableViewCell.m
//  UtilityDemo
//
//  Created by lizhongqiang on 15/7/6.
//  Copyright (c) 2015年 hw. All rights reserved.
//

#import "HWTableViewCell.h"

@implementation HWTableViewCell

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        
        
        self.textLabel.textColor = UIColorFromRGB(0xbfbfbf);
        
        self.textLabel.font = [UIFont systemFontOfSize:14];
        
    }
    
    return self;
}

@end
