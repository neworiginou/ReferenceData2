//
//  HWMyCardCell.m
//  HaoWu_4.0
//
//  Created by caijingpeng.haowu on 14-5-24.
//  Copyright (c) 2014年 caijingpeng. All rights reserved.
//

#import "HWMyCardCell.h"
#import "Define-OC.h"

#define MARGIN_LEFT 10
#define MARGIN_TOP 12.5f

#define HEADIMAGE_WIDTH 40
#define HEADIMAGE_HEIGHT 40

#define GAP 10

@implementation HWMyCardCell
@synthesize headImgV,titleLab,subTitleLab,defaultLab,delegate;

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        
        headImgV = [[UIImageView alloc] initWithFrame:CGRectMake(MARGIN_LEFT, MARGIN_TOP, HEADIMAGE_WIDTH, HEADIMAGE_HEIGHT)];
        headImgV.backgroundColor = [UIColor clearColor];
        [self.contentView addSubview:headImgV];
        
        titleLab = [[UILabel alloc] initWithFrame:CGRectMake(CGRectGetMaxX(headImgV.frame) + GAP, MARGIN_TOP+3, 200, 15)];
        titleLab.font = [UIFont fontWithName:FONTNAME size:15.0f];
#warning color
//        titleLab.textColor = THEME_COLOR_SMOKE;
        titleLab.backgroundColor = [UIColor clearColor];
        [self.contentView addSubview:titleLab];
        
        subTitleLab = [[UILabel alloc] initWithFrame:CGRectMake(CGRectGetMaxX(headImgV.frame) + GAP, CGRectGetMaxY(titleLab.frame) + 8, 200, 15)];
#warning color
//        subTitleLab.textColor = THEME_COLOR_TEXT;
        subTitleLab.font = [UIFont fontWithName:FONTNAME size:13.0f];
        subTitleLab.backgroundColor = [UIColor clearColor];
        [self.contentView addSubview:subTitleLab];
        
//        settingButton = [UIButton buttonWithType:UIButtonTypeCustom];
//        settingButton.frame = CGRectMake(320 - 66 - MARGIN_LEFT, (75-27)/2.0f, 66, 27);
//        settingButton.backgroundColor = [Utility customOrangeColor];
//        [settingButton setOrangeBorderStyle];
//        settingButton.layer.cornerRadius = 3;
//        settingButton.layer.masksToBounds = YES;
//        settingButton.titleLabel.font = [UIFont fontWithName:FONTNAME size:14.0f];
//        [settingButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
//        [settingButton addTarget:self action:@selector(clickSettingButton:) forControlEvents:UIControlEventTouchUpInside];
//        [self.contentView addSubview:settingButton];
        
        defaultLab = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 30, 15)];
        defaultLab.textColor = [UIColor whiteColor];
#warning color
        defaultLab.backgroundColor = THEME_COLOR_RED_NORMAL;
//        defaultLab.backgroundColor = THEME_COLOR_ORANGE;
        defaultLab.font = [UIFont fontWithName:FONTNAME size:9.0f];
        defaultLab.textAlignment = NSTextAlignmentCenter;
        defaultLab.layer.cornerRadius = 4.0f;
        defaultLab.layer.masksToBounds = YES;
        defaultLab.text = @"默认";
        defaultLab.center = CGPointMake(kScreenWidth - 50, 65/2.0f);
//        defaultLab.frame = CGRectMake(kScreenWidth - 100, (65 - 15) / 2 , 30, 15);
        [self.contentView addSubview:defaultLab];
        
        UIView *line = [[UIView alloc] initWithFrame:CGRectMake(0, 65 - 0.5f, kScreenWidth, 0.5f)];
        line.backgroundColor = CD_LineColor;
        [self.contentView addSubview:line];
        
        
    }
    return self;
}

- (void)clickSettingButton:(id)sender
{
    if (delegate && [delegate respondsToSelector:@selector(didClickSetDefaultWithCell:)]) {
        [delegate didClickSetDefaultWithCell:self];
    }
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
    // Drawing code
}
*/

@end
