//
//  HWHouseSourceCell.m
//  HaoWu_4.0
//
//  Created by caijingpeng.haowu on 14-5-21.
//  Copyright (c) 2014年 caijingpeng. All rights reserved.
//

#import "HWHouseSourceCell.h"

#define MARGIN_LEFT 15
#define MARGIN_TOP 8
#define HEAD_IMAGE_WIDTH 64
#define HEAD_IMAGE_HEIGHT 64
#define PADING 5

#define TITLE_LABEL_WIDTH 250
#define TYPE_IMAGE_TAG 222

#define TYPE_IMAGE_SIZE 18

@implementation HWHouseSourceCell
@synthesize titleLabel,msgLabel,youhuiLabel,spreadTag,headImgV,priceLabel,recommandBtn,delegate,thirdLineLabel;

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        
        headImgV = [[UIImageView alloc] initWithFrame:CGRectMake(MARGIN_LEFT, MARGIN_TOP, HEAD_IMAGE_WIDTH, HEAD_IMAGE_HEIGHT)];
        headImgV.backgroundColor = [UIColor clearColor];
        headImgV.layer.cornerRadius = 6;
        headImgV.layer.masksToBounds = YES;
        headImgV.contentMode = UIViewContentModeScaleAspectFill;
        [self.contentView addSubview:headImgV];
        
//        spreadTag = [[UIImageView alloc] initWithFrame:CGRectMake(CGRectGetMinX(headImgV.frame), CGRectGetMaxY(headImgV.frame)-15, HEAD_IMAGE_WIDTH, 15)];
//        spreadTag.backgroundColor = [UIColor blueColor];
//        [self.contentView addSubview:spreadTag];
        
        titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(CGRectGetMaxX(headImgV.frame) + 10, MARGIN_TOP, TITLE_LABEL_WIDTH, 20)];
        titleLabel.backgroundColor = [UIColor clearColor];
    
        titleLabel.font = [UIFont fontWithName:FONTNAME size:15.0f];
        titleLabel.textColor = THEME_COLOR_SMOKE;
        [self.contentView addSubview:titleLabel];
        
        msgLabel = [[UILabel alloc] initWithFrame:CGRectMake(CGRectGetMaxX(headImgV.frame) + 10, CGRectGetMaxY(titleLabel.frame) + PADING, TITLE_LABEL_WIDTH, 15)];
        msgLabel.backgroundColor = [UIColor clearColor];
        msgLabel.font = [UIFont fontWithName:FONTNAME size:14.0f];
        msgLabel.textColor = THEME_COLOR_GRAY_MIDDLE;
        [self.contentView addSubview:msgLabel];
        
        thirdLineLabel = [[UILabel alloc] initWithFrame:CGRectMake(CGRectGetMaxX(headImgV.frame) + 10, CGRectGetMaxY(msgLabel.frame) + PADING, 120, 15)];
        thirdLineLabel.font = [UIFont fontWithName:FONTNAME size:13.0f];
        thirdLineLabel.backgroundColor = [UIColor clearColor];
        thirdLineLabel.textColor = THEME_COLOR_TEXT;
        thirdLineLabel.text = @"推荐成功即得返现";
        [self.contentView addSubview:thirdLineLabel];
        
        youhuiLabel = [[UILabel alloc] initWithFrame:CGRectMake(CGRectGetMaxX(thirdLineLabel.frame), CGRectGetMaxY(msgLabel.frame) + PADING, 115, 15)];
        youhuiLabel.backgroundColor = [UIColor clearColor];
        youhuiLabel.font = [UIFont fontWithName:FONTNAME size:13.0f];
        youhuiLabel.textColor = THEME_COLOR_ORANGE;
        [self.contentView addSubview:youhuiLabel];
        
//        priceLabel = [[UILabel alloc] initWithFrame:CGRectMake(320 - 70, MARGIN_TOP, 60, 15)];
//        priceLabel.backgroundColor = [UIColor redColor];
//        [self.contentView addSubview:priceLabel];
        
        recommandBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [recommandBtn setTitle:@"立即推荐" forState:UIControlStateNormal];
//        [recommandBtn setOrangeBorderStyle];
        recommandBtn.titleLabel.font = [UIFont fontWithName:FONTNAME size:13.0f];
//        [recommandBtn setFrame:CGRectMake(320 - 65 - MARGIN_LEFT, (80 - 25)/2.0f, 65, 30)];
        recommandBtn.frame = CGRectMake(kScreenWidth - 15 - 63, (80 - 27)/2.0f, 66, 27);
        recommandBtn.layer.cornerRadius = 3;
        [recommandBtn addTarget:self action:@selector(clickRecommand:) forControlEvents:UIControlEventTouchUpInside];
//        [self.contentView addSubview:recommandBtn];
        
        UIView *line = [[UIView alloc] initWithFrame:CGRectMake(MARGIN_LEFT, 80-0.5, kScreenWidth - 2*MARGIN_LEFT, 0.5)];
        line.backgroundColor = THEME_COLOR_LINE;
        [self.contentView addSubview:line];
        
        
        for (int i = 0; i < 3; i++)
        {
            UILabel *typeLab = [[UILabel alloc] initWithFrame:CGRectZero];
//            typeLab.backgroundColor = [UIColor redColor];
            typeLab.tag = TYPE_IMAGE_TAG + i;
            typeLab.layer.cornerRadius = 5;
            typeLab.layer.masksToBounds = YES;
            typeLab.font = [UIFont fontWithName:FONTNAME size:11.0f];
            typeLab.textColor = [UIColor whiteColor];
            [self.contentView addSubview:typeLab];
        }
        
        
    }
    return self;
}
- (void)clickRecommand:(id)sender
{
    if (delegate && [delegate respondsToSelector:@selector(didClickRecommandBtnWithCell:)]) {
        [delegate didClickRecommandBtnWithCell:self];
    }
}

- (void)setType:(id)typeArr
{
    //【分组类别,0:好屋推广,1:本市,2:全国旅游,3:海外】
    NSArray *arr;
    if ([typeArr isKindOfClass:[NSString class]]) {
        arr = [NSArray arrayWithObject:typeArr];
    }
    else{
        arr = typeArr;
    }
    
    for (int i = 0; i < 3; i++) {
        
        UILabel *typeLab = (UILabel *)[self.contentView viewWithTag:TYPE_IMAGE_TAG + i];
        if (i < arr.count) {
            
            NSString *str = [NSString stringWithFormat:@"%@",[arr objectAtIndex:i]];
            
            typeLab.frame = CGRectMake(CGRectGetMaxX(self.headImgV.frame) - TYPE_IMAGE_SIZE*(i+1), CGRectGetMaxY(self.headImgV.frame) - TYPE_IMAGE_SIZE, TYPE_IMAGE_SIZE, TYPE_IMAGE_SIZE);
            typeLab.textAlignment = NSTextAlignmentCenter;
            
            if ([str isEqualToString:@"0"]) {
                typeLab.backgroundColor = [UIColor colorWithRed:238/255.0f green:167/255.0f blue:45/255.0f alpha:0.8f];
                typeLab.text = @"推";
            }
            else if ([str isEqualToString:@"1"]) {
//                typeLab.backgroundColor = [UIColor colorWithRed:238/255.0f green:167/255.0f blue:45/255.0f alpha:0.8f];
//                typeLab.text = @"推";
                typeLab.frame = CGRectZero;
            }
            else if ([str isEqualToString:@"2"]) {
                typeLab.backgroundColor = [UIColor colorWithRed:109/255.0f green:152/255.0f blue:34/255.0f alpha:0.8f];
                typeLab.text = @"旅";
            }
            else if ([str isEqualToString:@"3"]) {
                typeLab.backgroundColor = [UIColor colorWithRed:31/255.0f green:127/255.0f blue:174/255.0f alpha:0.8f];
                typeLab.text = @"海";
            }
            
        }
        
        else
        {
            typeLab.frame = CGRectZero;
        }
    }
}


@end
