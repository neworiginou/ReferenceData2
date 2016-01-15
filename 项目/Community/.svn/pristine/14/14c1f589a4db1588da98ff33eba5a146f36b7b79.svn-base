//
//  HWDetailFirstRowCell.m
//  HaoWu_4.0
//
//  Created by caijingpeng.haowu on 14-5-22.
//  Copyright (c) 2014年 caijingpeng. All rights reserved.
//

#import "HWDetailFirstRowCell.h"

@implementation HWDetailFirstRowCell
@synthesize titleLab,subTitleLab,headImgV,accessaryImgV;

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        // Initialization code
        
        headImgV = [[UIImageView alloc] initWithFrame:CGRectMake(15, 15, 15, 16)];
        headImgV.backgroundColor = [UIColor clearColor];
        [self.contentView addSubview:headImgV];
        
        titleLab = [[UILabel alloc] initWithFrame:CGRectMake(CGRectGetMaxX(headImgV.frame) + 10, 15, 60, 20)];
        titleLab.font = [UIFont fontWithName:FONTNAME size:15.0f];
        titleLab.textColor = THEME_COLOR_SMOKE;
        [self.contentView addSubview:titleLab];
        
        subTitleLab = [[UILabel alloc] initWithFrame:CGRectMake(CGRectGetMaxX(titleLab.frame), 15, 180, 20)];
        subTitleLab.font = [UIFont fontWithName:FONTNAME size:14.0f];
        subTitleLab.textColor = THEME_COLOR_TEXT;
        [self.contentView addSubview:subTitleLab];
        
        accessaryImgV = [[UIImageView alloc] initWithFrame:CGRectMake(kScreenWidth - 25, (50 - 12.5f)/2.0f, 12.5f, 12.5f)];
//        accessaryImgV.backgroundColor = [UIColor redColor];
        accessaryImgV.image = [UIImage imageNamed:@"icon_jianotu"];
        [self.contentView addSubview:accessaryImgV];
        
    }
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
