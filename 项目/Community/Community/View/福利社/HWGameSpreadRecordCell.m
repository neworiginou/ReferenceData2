//
//  HWGameSpreadRecordCell.m
//  Community
//
//  Created by niedi on 15/1/15.
//  Copyright (c) 2015年 caijingpeng. All rights reserved.
//
//  功能描述：推广记录页面TableViewCell
//
//  修改记录：
//      姓名          日期                      修改内容
//      聂迪          2015-1-16                 创建文件
//     

#import "HWGameSpreadRecordCell.h"

@implementation HWGameSpreadRecordCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier])
    {
        //头视图
        self.headImage = [[UIImageView alloc] init];
        self.headImage.frame = CGRectMake(15, 12, 65, 65);
        self.headImage.contentMode = UIViewContentModeScaleAspectFit;
        self.headImage.backgroundColor = IMAGE_DEFAULT_COLOR;
        self.headImage.layer.cornerRadius = 6;
        self.headImage.layer.masksToBounds = YES;
        [self addSubview:self.headImage];
        
        //标题
        self.firTitleLab = [[UILabel alloc] init];
        self.firTitleLab.frame = CGRectMake(CGRectGetMaxX(self.headImage.frame) + 5, 13, kScreenWidth - 15 - 65 - 5 - 15, 20);
        self.firTitleLab.backgroundColor = [UIColor clearColor];
        self.firTitleLab.font = [UIFont fontWithName:FONTNAME size:THEME_FONT_BIG];
        self.firTitleLab.textColor = THEME_COLOR_SMOKE;
        [self addSubview:self.firTitleLab];
        
        //副标题
        self.secTitleLab = [[UILabel alloc] init];
        self.secTitleLab.frame = CGRectMake(self.firTitleLab.frame.origin.x, CGRectGetMaxY(self.firTitleLab.frame) + 5, self.firTitleLab.frame.size.width, 15);
        self.secTitleLab.backgroundColor = [UIColor clearColor];
        self.secTitleLab.textColor = THEME_COLOR_SMOKE;
        self.secTitleLab.font = [UIFont fontWithName:FONTNAME size:THEME_FONT_SMALL13];
        [self addSubview:self.secTitleLab];
        
        //子标题
        self.thdTitleLab = [[UILabel alloc] init];
        self.thdTitleLab.frame = CGRectMake(self.firTitleLab.frame.origin.x, CGRectGetMaxY(self.secTitleLab.frame) + 5, self.firTitleLab.frame.size.width, 15);
        self.thdTitleLab.backgroundColor = [UIColor clearColor];
        self.thdTitleLab.textColor = THEME_COLOR_SMOKE;
        self.thdTitleLab.font = [UIFont fontWithName:FONTNAME size:THEME_FONT_SMALL13];
        [self addSubview:self.thdTitleLab];
        
        //上边界线
        self.topLineLab = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, 0.5)];
        self.topLineLab.backgroundColor = THEME_COLOR_LINE;
        [self addSubview:self.topLineLab];
        
        //下边界线
        self.buttomLineLab = [[UILabel alloc] initWithFrame:CGRectMake(0, 89.5f, kScreenWidth, 0.5)];
        self.buttomLineLab.backgroundColor = THEME_COLOR_LINE;
        [self addSubview:self.buttomLineLab];
        
    }
    return self;
}

- (void)setGaemSpreadRecordInfo:(HWGameSpreadRecordModel *)model {
    
    __weak UIImageView *weakImgV = self.headImage;
    [self.headImage setImageWithURL:[NSURL URLWithString:[Utility imageDownloadWithMongoDbKey:model.iconMongodbKey]] placeholderImage:[UIImage imageNamed:IMAGE_PLACE] completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType) {
        
        if (error != nil)
        {
            weakImgV.image = [UIImage imageNamed:IMAGE_BREAK_CUBE];
        }
        else
        {
            weakImgV.image = image;
        }
        
    }];
    
    self.firTitleLab.text = model.gameName;//@"我叫MT2"
    CGRect frame = self.firTitleLab.frame;
    frame.size.height = [Utility calculateStringHeight:model.gameName font:[UIFont fontWithName:FONTNAME size:THEME_FONT_BIG] constrainedSize:CGSizeMake(kScreenWidth - 15 - 65 - 5 - 15, 1000)].height;
    self.firTitleLab.frame = frame;
    
    frame = self.secTitleLab.frame;
    frame.origin.y = CGRectGetMaxY(self.firTitleLab.frame) + 5;
    self.secTitleLab.frame = frame;
    NSString *moneyStr = [Utility conversionThousandth:model.commissionRMB];//@"999999.99"
    self.secTitleLab.attributedText = [self getAttributedStr:@[@"总佣金(人民币)：", [NSString stringWithFormat:@"￥%@", moneyStr]] color:THEME_COLOR_MONEY];
    
    frame = self.thdTitleLab.frame;
    frame.origin.y = CGRectGetMaxY(self.secTitleLab.frame) + 5;
    self.thdTitleLab.frame = frame;
    NSString *koalaCoinStr = [Utility conversionThousandth:model.commissionKLB];
    koalaCoinStr = [koalaCoinStr substringToIndex:koalaCoinStr.length - 3];
    self.thdTitleLab.attributedText = [self getAttributedStr:@[@"总佣金(考拉币)：", koalaCoinStr] color:THEME_COLOR_ORANGE];
    
    frame = self.buttomLineLab.frame;
    frame.origin.y = [HWGameSpreadRecordCell getCellHeight:model] - 0.5f;
    self.buttomLineLab.frame = frame;
}



+ (float)getCellHeight:(HWGameSpreadRecordModel *)model {
    
    
    return 70.0f + [Utility calculateStringHeight:model.gameName font:[UIFont fontWithName:FONTNAME size:THEME_FONT_BIG] constrainedSize:CGSizeMake(kScreenWidth - 15 - 65 - 5 - 15, 10000)].height;
}

- (NSMutableAttributedString *)getAttributedStr:(NSArray *)strArr color:(UIColor *)titleColor
{
    NSMutableAttributedString *attributeString = [[NSMutableAttributedString alloc]initWithString:[NSString stringWithFormat:@"%@%@", strArr[0], strArr[1]]];
    [attributeString addAttribute:NSFontAttributeName value:(id)[UIFont fontWithName:FONTNAME size:THEME_FONT_SMALL] range:NSMakeRange(9, [strArr[1] length])];
    [attributeString addAttribute:NSForegroundColorAttributeName value:(id)titleColor range:NSMakeRange(9, [strArr[1] length])];
    return attributeString;
}
@end
