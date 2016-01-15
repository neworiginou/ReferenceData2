//
//  HWTreatureHistoryCell.m
//  Community
//
//  Created by caijingpeng.haowu on 14-12-9.
//  Copyright (c) 2014年 caijingpeng. All rights reserved.
//

#import "HWTreatureHistoryCell.h"

#define MARGIN_LEFT     10
#define MARGIN_TOP      10

#define SHOW_CELL_HEIGHT        285.0f
#define NORMAL_CELL_HEIGHT      65.0f

@implementation HWTreatureHistoryCell

@synthesize titleLab;
@synthesize contentLab;
@synthesize goodsImgV;
@synthesize dateLab;
@synthesize showImgV;
@synthesize headImgV;
@synthesize telephoneLab;
@synthesize showDateLab;
@synthesize line;
@synthesize showView;

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self)
    {
        self.backgroundColor = [UIColor whiteColor];
        self.contentView.backgroundColor = [UIColor whiteColor];
        
        goodsImgV = [[UIImageView alloc] initWithFrame:CGRectMake(MARGIN_LEFT, MARGIN_TOP, 45, 45)];
        goodsImgV.layer.cornerRadius = 4;
        goodsImgV.clipsToBounds = YES;
        goodsImgV.layer.borderColor = THEME_COLOR_LINE.CGColor;
        goodsImgV.layer.borderWidth = 0.5f;
//        goodsImgV.backgroundColor = THEME_COLOR_MONEY;
        [self.contentView addSubview:goodsImgV];
        
        titleLab = [[UILabel alloc] initWithFrame:CGRectMake(CGRectGetMaxX(goodsImgV.frame) + 10,
                                                            MARGIN_TOP,
                                                            kScreenWidth - CGRectGetMaxX(goodsImgV.frame) - 70 - 20 - 10,
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
        
        dateLab = [[UILabel alloc] initWithFrame:CGRectMake(kScreenWidth - 200 - 15, MARGIN_TOP, 200, 25)];
        dateLab.backgroundColor = [UIColor clearColor];
        dateLab.font = [UIFont fontWithName:FONTNAME size:THEME_FONT_SMALL];
        dateLab.textColor = THEME_COLOR_TEXT;
        dateLab.textAlignment = NSTextAlignmentRight;
        [self.contentView addSubview:dateLab];
        
        showView = [[UIView alloc] initWithFrame:CGRectMake(CGRectGetMinX(titleLab.frame),
                                                                   CGRectGetMaxY(contentLab.frame) + 10,
                                                                   240,
                                                                    213)];
        showView.backgroundColor = BACKGROUND_COLOR;
        [self.contentView addSubview:showView];
        
        showImgV = [[HWContentImageView alloc] initWithFrame:CGRectMake(0, 0, showView.frame.size.width, 175)];
        showImgV.contentMode = UIViewContentModeScaleAspectFit; 
        showImgV.backgroundColor = [UIColor clearColor];
        [showView addSubview:showImgV];
        
        headImgV = [[UIImageView alloc] initWithFrame:CGRectMake(35, (CGRectGetHeight(showView.frame) - CGRectGetHeight(showImgV.frame) - 25) / 2.0f + CGRectGetHeight(showImgV.frame), 25, 25)];
        headImgV.layer.cornerRadius = headImgV.frame.size.width / 2.0f;
        headImgV.layer.masksToBounds = YES;
        headImgV.backgroundColor = [UIColor clearColor];
        [showView addSubview:headImgV];
        
        telephoneLab = [[UILabel alloc] initWithFrame:CGRectMake(CGRectGetMaxX(headImgV.frame) + 5.0f, CGRectGetMinY(headImgV.frame), 70.0f, CGRectGetHeight(headImgV.frame))];
        telephoneLab.backgroundColor = [UIColor clearColor];
        telephoneLab.textColor = THEME_COLOR_TEXT;
        telephoneLab.font = [UIFont fontWithName:FONTNAME size:12.0f];
        [showView addSubview:telephoneLab];
        
        showDateLab = [[UILabel alloc] initWithFrame:CGRectMake(CGRectGetMaxX(telephoneLab.frame) + 3.0f,
                                                                CGRectGetMinY(headImgV.frame),
                                                                CGRectGetWidth(showView.frame) - CGRectGetMaxX(telephoneLab.frame) - 3.0f - 5,
                                                                CGRectGetHeight(headImgV.frame))];
        showDateLab.backgroundColor = [UIColor clearColor];
        showDateLab.textColor = THEME_COLOR_TEXT;
        showDateLab.font = [UIFont fontWithName:FONTNAME size:12.0f];
        showDateLab.textAlignment = NSTextAlignmentRight;
        [showView addSubview:showDateLab];
        
        line = [[UIView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, 0.5f)];
        line.backgroundColor = THEME_COLOR_LINE;
        [self.contentView addSubview:line];
    }
    return self;
}

- (void)setHistoryInfo:(HWActivityHistoryModel *)info
{
    titleLab.text = info.productName;
    
    if (info.productStatus.intValue == 2)
    {
        NSString *tmpStr = @"方案流标";
        NSMutableAttributedString *attributeStr = [[NSMutableAttributedString alloc] initWithString:tmpStr];
        [attributeStr addAttributes:@{NSForegroundColorAttributeName:(id)THEME_COLOR_MONEY} range:NSMakeRange(0, 4)];
        contentLab.attributedText = attributeStr;
    }
    else
    {
        NSString *tmpStr = [NSString stringWithFormat:@"最低唯一价：%@元",info.winPrice];
        NSMutableAttributedString *attributeStr = [[NSMutableAttributedString alloc] initWithString:tmpStr];
        [attributeStr addAttributes:@{NSForegroundColorAttributeName:(id)THEME_COLOR_MONEY} range:NSMakeRange(6, tmpStr.length - 6)];
        contentLab.attributedText = attributeStr;
    }
    
    //结束时间
    NSString *endTime =[Utility getTimeWithTimestamp:info.endTime];
//    endTime = [endTime substringWithRange:NSMakeRange(5, 5)];
//    showDateLab.text = endTime;
    dateLab.text = endTime;

    //时间
    NSString *datetime =[Utility getTimeWithTimestamp:info.showOrderTime];
//    datetime = [datetime substringWithRange:NSMakeRange(5, 5)];
    showDateLab.text = datetime;
    //电话
    telephoneLab.text = [Utility securePhoneNumber:info.mobile];
    NSString *goodsImgUrl = [Utility imageDownloadWithMongoDbKey:info.smallImg];
   
    __weak UIImageView *weakImagV = goodsImgV;
    [goodsImgV setImageWithURL:[NSURL URLWithString:goodsImgUrl] placeholderImage:[UIImage imageNamed:IMAGE_BREAK_CUBE] completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType) {
        if (error != nil) {
            weakImagV.image = [UIImage imageNamed:IMAGE_BREAK_CUBE];
        }
        else
        {
            weakImagV.image = image;
        }

    }];
//    [goodsImgV setImageWithURL:[NSURL URLWithString:goodsImgUrl] completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType) {
//        
//        }];

    if (info.showOrderId.length == 0) // 没有晒单
    {
        showView.hidden = YES;
        CGRect frame = line.frame;
        frame.origin.y = NORMAL_CELL_HEIGHT - 0.5f;
        line.frame = frame;
    }
    else
    {
        showView.hidden = NO;
        CGRect frame = line.frame;
        frame.origin.y = SHOW_CELL_HEIGHT - 0.5f;
        line.frame = frame;
    
        [showImgV setContentString:info.showContent];
        
        NSString *showViewUrl = [Utility imageDownloadUrl:info.showImg];
        __weak HWContentImageView *weakShowImgV = showImgV;
        [showImgV setImageWithURL:[NSURL URLWithString:showViewUrl] completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType) {
            if (image == nil)
            {
                weakShowImgV.image = [UIImage imageNamed:IMAGE_BREAK_CUBE];
            }
            else
            {
                weakShowImgV.image = image;
            
            }
        }];
        
        __weak UIImageView *weakImgV = headImgV;
        [headImgV setImageWithURL:[NSURL URLWithString:[Utility imageDownloadWithMongoDbKey:info.showHeadImg]] placeholderImage:[UIImage imageNamed:@"head_placeholder"] completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType) {
            
            if (error != nil)
            {
                weakImgV.image = [UIImage imageNamed:@"head_placeholder"];
            }
            else
            {
                weakImagV.image = image;
            }
            
        }];
        
    }
    
    
}

+ (float)getCellHeight:(HWActivityHistoryModel *)info
{
    if (info.showOrderId.length == 0) // 没有晒单
    {
        return NORMAL_CELL_HEIGHT;
    }
    else
    {
        return SHOW_CELL_HEIGHT;
    }
    return 0;
}

- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
