//
//  houseLoanTableViewCell.m
//  HaoWuAgenciesEdition
//
//  Created by gusheng on 14-7-8.
//  Copyright (c) 2014年 ZhuMing. All rights reserved.
//

#import "HWHouseLoanTableViewCell.h"
#import "Partner_Swift-Swift.h"
#import "Define-OC.h"


@implementation HWHouseLoanTableViewCell
@synthesize titleContentLabel;
@synthesize titleLabel;
-(instancetype)init
{
    id object = loadObjectFromNib(@"HWHouseLoanTableViewCell", [HWHouseLoanTableViewCell class], self);
    if (object) {
        self = (HWHouseLoanTableViewCell *)object;
    }
    else
    {
        self = [self init];
    }
    titleLabel.font = [UIFont fontWithName:FONTNAME size:14];
    titleLabel.textColor = UIColorFromRGB(0x333333);
    
    titleContentLabel.font = [UIFont fontWithName:FONTNAME size:14];
    titleContentLabel.textColor = UIColorFromRGB(0x999999);
    
    UIImageView *arrowImg = [[UIImageView alloc] initWithFrame:CGRectMake(kScreenWidth - 29, 18, 8, 14)];
    arrowImg.backgroundColor = [UIColor clearColor];
    arrowImg.image = [UIImage imageNamed:@"arrow_next"];
    [self.contentView addSubview:arrowImg];
    
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
