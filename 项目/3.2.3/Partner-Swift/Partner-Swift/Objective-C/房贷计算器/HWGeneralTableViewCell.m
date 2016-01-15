//
//  HWGeneralTableViewCell.m
//  HaoWuAgenciesEdition
//
//  Created by gusheng on 14-7-11.
//  Copyright (c) 2014年 ZhuMing. All rights reserved.
//

#import "HWGeneralTableViewCell.h"
#import "Partner_Swift-Swift.h"
#import "Define-OC.h"

@implementation HWGeneralTableViewCell
@synthesize lineImage,imgV;
- (void)awakeFromNib
{
    // Initialization code
}
-(instancetype)init{
    id object = loadObjectFromNib(@"HWGeneralTableViewCell", [HWGeneralTableViewCell class], self);
    if (object) {
        self = (HWGeneralTableViewCell *)object;
    }
    else
    {
        self = [self init];
    }
    
    lineImage = [[UIImageView alloc]initWithFrame:CGRectMake(10, 39.5, kScreenWidth - 10, 0.5)];
    [lineImage setBackgroundColor:UIColorFromRGB(0xbfbfbf)];
    [self addSubview:lineImage];
    
    
    imgV = [[UIImageView alloc] initWithFrame:CGRectMake(kScreenWidth - 30, 9, 14, 11)];
    imgV.image = [UIImage imageNamed:@"gou"];
    self.accessoryView = imgV;
    return self;
}
- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
