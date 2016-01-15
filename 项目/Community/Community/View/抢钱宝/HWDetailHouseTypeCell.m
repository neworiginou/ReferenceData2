//
//  HWDetailTitleCell.m
//  HaoWu_4.0
//
//  Created by caijingpeng.haowu on 14-5-22.
//  Copyright (c) 2014年 caijingpeng. All rights reserved.
//

#import "HWDetailHouseTypeCell.h"

#define MARGIN_LEFT 15
#define MARGIN_TOP 12.5f

#define HEADIMAGE_WIDTH 65
#define HEADIMAGE_HEIGHT 65

#define GAP 7

@implementation HWDetailHouseTypeCell
@synthesize titleLab,subTitleLab,headImgV,accessoryImgV,secondSubLab;

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        // Initialization code
        
        headImgV = [[UIImageView alloc] initWithFrame:CGRectMake(MARGIN_LEFT, MARGIN_TOP, HEADIMAGE_WIDTH, HEADIMAGE_HEIGHT)];
        headImgV.backgroundColor = [UIColor whiteColor];
        headImgV.layer.cornerRadius = 5;
        headImgV.layer.masksToBounds = YES;
        [self.contentView addSubview:headImgV];
        
        titleLab = [[UILabel alloc] initWithFrame:CGRectMake(CGRectGetMaxX(headImgV.frame) + GAP, MARGIN_TOP + 3, 200, 15)];
        titleLab.font = [UIFont fontWithName:FONTNAME size:15.0f];
        [self.contentView addSubview:titleLab];
        
        subTitleLab = [[UILabel alloc] initWithFrame:CGRectMake(CGRectGetMaxX(headImgV.frame) + GAP, CGRectGetMaxY(titleLab.frame) + 8, 200, 15)];
        subTitleLab.font = [UIFont fontWithName:FONTNAME size:14.0f];
        subTitleLab.textColor = THEME_COLOR_TEXT;
        [self.contentView addSubview:subTitleLab];
        secondSubLab = [[UILabel alloc] initWithFrame:CGRectMake(CGRectGetMaxX(headImgV.frame) + GAP, CGRectGetMaxY(subTitleLab.frame)+5 , 200, 15)];
        secondSubLab.font = [UIFont fontWithName:FONTNAME size:14.0f];
        secondSubLab.textColor = THEME_COLOR_TEXT;
        [self.contentView addSubview:secondSubLab];
        
        accessoryImgV = [[UIImageView alloc] initWithFrame:CGRectMake(kScreenWidth - 25, (90-12.5f)/2.0f, 12.5, 12.5f)];
        accessoryImgV.image = [UIImage imageNamed:@"icon_jianotu"];
//        accessoryImgV.backgroundColor = [UIColor redColor];
        [self.contentView addSubview:accessoryImgV];
        
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
