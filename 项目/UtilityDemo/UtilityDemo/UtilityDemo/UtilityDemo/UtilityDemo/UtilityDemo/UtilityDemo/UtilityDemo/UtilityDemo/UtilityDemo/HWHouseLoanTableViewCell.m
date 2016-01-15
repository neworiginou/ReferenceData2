//
//  HWHouseLoanTableViewCell.m
//  UtilityDemo
//
//  Created by wuxiaohong on 15/3/31.
//  Copyright (c) 2015年 hw. All rights reserved.
//

#import "HWHouseLoanTableViewCell.h"

@implementation HWHouseLoanTableViewCell
-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self)
    {
        
        self.titleLabel = [[UILabel alloc]initWithFrame:CGRectMake(13, 10, 80, 34)];
        self.titleLabel.font = [UIFont fontWithName:FONTNAME size:14];
        self.titleLabel.textColor = TITLE_COLOR_33;
        [self addSubview:self.titleLabel];
        
        self.titleContentLabel = [[UILabel alloc]initWithFrame:CGRectMake(80+13+5, 16, 180, 21)];
        self.titleContentLabel.font = [UIFont fontWithName:FONTNAME size:14];
        self.titleContentLabel.textColor = TITLE_COLOR_99;
        [self addSubview:self.titleContentLabel];
        UIImageView *arrowImg = [[UIImageView alloc] initWithFrame:CGRectMake(kScreenWidth - 29, 18, 8, 14)];
        arrowImg.backgroundColor = [UIColor clearColor];
        arrowImg.image = [UIImage imageNamed:@"arrow_next"];
        [self.contentView addSubview:arrowImg];
        
        _rightImage = arrowImg;

    }
    
    return self;
}

- (void)awakeFromNib {
    // Initialization code
    }

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
