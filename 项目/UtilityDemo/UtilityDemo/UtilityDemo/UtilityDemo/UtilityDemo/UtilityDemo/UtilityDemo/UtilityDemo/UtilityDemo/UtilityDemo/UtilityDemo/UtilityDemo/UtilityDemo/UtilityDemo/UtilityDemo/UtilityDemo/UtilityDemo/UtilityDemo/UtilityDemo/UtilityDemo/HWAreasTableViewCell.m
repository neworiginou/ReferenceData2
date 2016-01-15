//
//  HWAreasTableViewCell.m
//  UtilityDemo
//
//  Created by wuxiaohong on 15/4/17.
//  Copyright (c) 2015年 hw. All rights reserved.
//

#import "HWAreasTableViewCell.h"

@implementation HWAreasTableViewCell

- (void)awakeFromNib {
    // Initialization code
}
- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self)
    {
        self.titleLabel = [[UILabel alloc]initWithFrame:CGRectMake(13, 10, 80, 34)];
        self.titleLabel.font = [UIFont fontWithName:FONTNAME size:14];
        
        self.titleLabel.textColor =  TITLE_COLOR_33;
        [self addSubview:self.titleLabel];
        
        self.unitLabel = [[UILabel alloc]initWithFrame:CGRectMake(kScreenWidth-15-47, 16, 47, 21)];
        self.unitLabel.font = [UIFont fontWithName:FONTNAME size:14];
        self.unitLabel.textColor =  TITLE_COLOR_33;
        [self addSubview:self.unitLabel];
        
        self.textFiled = [[UITextField alloc]initWithFrame:CGRectMake(97, 17, 150, 20)];
        self.textFiled.textColor = TITLE_COLOR_99;
        [self addSubview:self.textFiled];
        UIImageView *arrowImg = [[UIImageView alloc] initWithFrame:CGRectMake(kScreenWidth - 29, 18, 8, 14)];
        arrowImg.backgroundColor = [UIColor clearColor];
        arrowImg.image = [UIImage imageNamed:@"arrow_next"];
        [self.contentView addSubview:arrowImg];

    }
    
    return self;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
