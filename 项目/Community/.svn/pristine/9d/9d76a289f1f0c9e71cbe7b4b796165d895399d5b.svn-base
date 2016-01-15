//
//  MineExtendRecordTableViewCell.m
//  TEST
//
//  Created by gusheng on 14-8-29.
//  Copyright (c) 2014年 gusheng. All rights reserved.
//

#import "MineExtendRecordTableViewCell.h"
#import "Utility.h"

@implementation MineExtendRecordTableViewCell
@synthesize commissionLabel,scanLabel,activeLabel,dateLabel,registerLabel;

- (void)awakeFromNib
{
    // Initialization code

}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        self.contentView.backgroundColor = [UIColor clearColor];
        
        UIView *backV = [[UIView alloc]initWithFrame:CGRectMake(0, 0, kScreenWidth, 90)];
        backV.backgroundColor = [UIColor whiteColor];
        [self.contentView addSubview:backV];
        
        self.dateLabel = [[UILabel alloc]initWithFrame:CGRectMake(15, 0, kScreenWidth - 30, 40)];
        dateLabel.textColor = UIColorFromRGB(0x999999);
        dateLabel.backgroundColor = [UIColor clearColor];
        dateLabel.font = [UIFont fontWithName:FONTNAME size:THEME_FONT_SMALL];
        [self.contentView addSubview:dateLabel];
        
        UIImageView *lineV1 = [[UIImageView alloc]initWithFrame:CGRectMake(0, 40, kScreenWidth, 0.5f)];
        lineV1.clipsToBounds = YES;
        lineV1.image = [Utility imageWithColor:THEME_COLOR_LINE andSize:CGSizeMake(1, 1)];
        [self.contentView addSubview:lineV1];
        NSArray *arr = [NSArray arrayWithObjects:@"佣金",@"扫描",@"激活",@"注册", nil];
        
        for (int i = 0; i < 4; i++) {
            UILabel *label = [[UILabel alloc]initWithFrame:CGRectMake(i * (kScreenWidth / 4.0f), 43, kScreenWidth / 4, 20)];
            label.backgroundColor = [UIColor clearColor];
            label.textAlignment = NSTextAlignmentCenter;
            label.textColor = UIColorFromRGB(0x666666);
            label.text = arr[i];
            label.font = [UIFont fontWithName:FONTNAME size:THEME_FONT_SMALL13];
            [self.contentView addSubview:label];
            if (i < 3) {
                UIImageView *imageV = [[UIImageView alloc]initWithImage:[Utility imageWithColor:THEME_COLOR_LINE andSize:CGSizeMake(1, 1)]];
                imageV.frame = CGRectMake((i + 1) * (kScreenWidth / 4.0), 40, 0.5f, 50);
                imageV.clipsToBounds = YES;
                [self.contentView addSubview:imageV];
            }
        }
        
        commissionLabel = [[UILabel alloc]initWithFrame:CGRectMake(0, 60, kScreenWidth / 4.0, 30)];
        commissionLabel.textColor = THEME_COLOR_ORANGE;
        commissionLabel.backgroundColor = [UIColor clearColor];
        commissionLabel.textAlignment = NSTextAlignmentCenter;
        [self.contentView addSubview:commissionLabel];
        
        scanLabel = [[UILabel alloc]initWithFrame:CGRectMake(kScreenWidth / 4.0f, 60, kScreenWidth / 4.0, 30)];
        scanLabel.textColor = THEME_COLOR_ORANGE;
        scanLabel.backgroundColor = [UIColor clearColor];
        scanLabel.textAlignment = NSTextAlignmentCenter;
        [self.contentView addSubview:scanLabel];
        
        activeLabel = [[UILabel alloc]initWithFrame:CGRectMake(kScreenWidth / 4.0f * 2, 60, kScreenWidth / 4.0, 30)];
        activeLabel.textColor = THEME_COLOR_ORANGE;
        activeLabel.backgroundColor = [UIColor clearColor];
        activeLabel.textAlignment = NSTextAlignmentCenter;
        [self.contentView addSubview:activeLabel];
        
        registerLabel = [[UILabel alloc]initWithFrame:CGRectMake(kScreenWidth / 4.0f * 3, 60, kScreenWidth / 4.0, 30)];
        registerLabel.textColor = THEME_COLOR_ORANGE;
        registerLabel.backgroundColor = [UIColor clearColor];
        registerLabel.textAlignment = NSTextAlignmentCenter;
        [self.contentView addSubview:registerLabel];
        
        
        UIImageView *lineV2 = [[UIImageView alloc]initWithFrame:CGRectMake(0, 89.5f, kScreenWidth, 0.5f)];
        lineV2.image = [Utility imageWithColor:THEME_COLOR_LINE andSize:CGSizeMake(1.0f, 1.0f)];
        lineV2.clipsToBounds = YES;
        [self.contentView addSubview:lineV2];
        
        UIImageView *lineV3 = [[UIImageView alloc]initWithFrame:CGRectMake(0, 90, kScreenWidth, 10)];
        lineV3.image = [Utility imageWithColor:BACKGROUND_COLOR andSize:CGSizeMake(1, 1)];
        [self.contentView addSubview:lineV3];
        
    }
    return self;
}
@end
