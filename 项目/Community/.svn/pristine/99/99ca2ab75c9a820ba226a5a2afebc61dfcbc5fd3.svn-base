//
//  HWTreasureJoinedCell.m
//  Community
//
//  Created by caijingpeng.haowu on 14-12-9.
//  Copyright (c) 2014年 caijingpeng. All rights reserved.
//

#import "HWTreasureJoinedCell.h"

#define MARGIN_LEFT     10
#define MARGIN_TOP      10

#define NORMAL_CELL_HEIGHT      65.0f

@implementation HWTreasureJoinedCell

@synthesize goodsImgV;
@synthesize titleLab;
@synthesize contentLab;
@synthesize dateLab;
@synthesize statusLab;

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self)
    {
        self.backgroundColor = [UIColor whiteColor];
        self.contentView.backgroundColor = [UIColor whiteColor];
        
        goodsImgV = [[UIImageView alloc] initWithFrame:CGRectMake(MARGIN_LEFT, MARGIN_TOP, 45, 45)];
        goodsImgV.layer.cornerRadius = 4;
        goodsImgV.layer.borderColor = THEME_COLOR_LINE.CGColor;
        goodsImgV.layer.borderWidth = 0.5f;
        goodsImgV.clipsToBounds = YES;
        goodsImgV.backgroundColor = [UIColor whiteColor];
        [self.contentView addSubview:goodsImgV];
        
        titleLab = [[UILabel alloc] initWithFrame:CGRectMake(CGRectGetMaxX(goodsImgV.frame) + 10,
                                                             MARGIN_TOP,
                                                             kScreenWidth - CGRectGetMaxX(goodsImgV.frame) - 70 - 20,
                                                             22)];
        titleLab.backgroundColor = [UIColor clearColor];
        titleLab.font = [UIFont fontWithName:FONTNAME size:THEME_FONT_BIG];
        titleLab.textColor = THEME_COLOR_SMOKE;
        [self.contentView addSubview:titleLab];
        
        contentLab = [[UILabel alloc] initWithFrame:CGRectMake(CGRectGetMinX(titleLab.frame), CGRectGetMaxY(titleLab.frame), CGRectGetWidth(titleLab.frame), 18)];
        contentLab.backgroundColor = [UIColor clearColor];
        contentLab.font = [UIFont fontWithName:FONTNAME size:THEME_FONT_SMALL ];
        contentLab.textColor = THEME_COLOR_SMOKE;
        [self.contentView addSubview:contentLab];
        
        dateLab = [[UILabel alloc] initWithFrame:CGRectMake(kScreenWidth - 70 - 15, MARGIN_TOP, 70, 20)];
        dateLab.backgroundColor = [UIColor clearColor];
        dateLab.font = [UIFont fontWithName:FONTNAME size:THEME_FONT_SMALL];
        dateLab.textColor = THEME_COLOR_TEXT;
        dateLab.textAlignment = NSTextAlignmentRight;
        dateLab.adjustsFontSizeToFitWidth = YES;
        [self.contentView addSubview:dateLab];
        
        statusLab = [[UILabel alloc] initWithFrame:CGRectMake(kScreenWidth - 70 - 15, CGRectGetMaxY(dateLab.frame), 70, 20)];
        statusLab.backgroundColor = [UIColor clearColor];
        statusLab.font = [UIFont fontWithName:FONTNAME size:THEME_FONT_SMALL];
        statusLab.textColor = THEME_COLOR_TEXT;
        statusLab.textAlignment = NSTextAlignmentRight;
        [self.contentView addSubview:statusLab];
        
        UIView *line = [[UIView alloc] initWithFrame:CGRectMake(0, NORMAL_CELL_HEIGHT - 0.5f, kScreenWidth, 0.5f)];
        line.backgroundColor = THEME_COLOR_LINE;
        [self.contentView addSubview:line];
    }
    return self;
}

- (void)setJoinedInfo:(HWJoinedActivityModel *)info
{
//    titleLab.text = @"iPhone5S (16G 黑)";
//    contentLab.text = @"砍价2次";
//    dateLab.text = @"12-09";
//    statusLab.text = @"等待开始";
    NSString *urlStr = [Utility imageDownloadUrl:info.smallImg];
    __weak UIImageView *weakGoodsImgV = goodsImgV;
    [goodsImgV setImageWithURL:[NSURL URLWithString:urlStr] placeholderImage:[UIImage imageNamed:IMAGE_PLACE] completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType) {
        
        if (error != nil)
        {
            weakGoodsImgV.image = [UIImage imageNamed:IMAGE_BREAK_CUBE];
        }
        else
        {
            weakGoodsImgV.image = image;
        }
        
    }];
    contentLab.text = [NSString stringWithFormat:@"砍价：%@次", info.guessCount];
    dateLab.text = info.startTimeStr;
    statusLab.text = [Utility parseProductStatus:info.productStatus];
    statusLab.textColor = [Utility parseProductStatusTextColor:info.productStatus];
    titleLab.text = info.productName;
    
    if (info.productStatus.intValue == 2)
    {
        self.contentView.backgroundColor = BACKGROUND_COLOR;
    }
    else
    {
        self.contentView.backgroundColor = [UIColor whiteColor];
    }
    
}

+ (float)getCellHeight:(HWJoinedActivityModel *)info
{
    return NORMAL_CELL_HEIGHT;
}

- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
