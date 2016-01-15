//
//  HWGameSpreadTableViewCell.m
//  KaoLa
//
//  Created by WeiYuanlin on 15/1/13.
//  Copyright (c) 2015年 WeiYuanlin. All rights reserved.
//
//  功能描述：游戏推广页面tableviewcell
//  修改记录
//      李中强 2015-01-17 添加头注释 相关人员补齐注释
//      姓名          日期                      修改内容
//      魏远林         2015-1-13               创建文件
//      魏远林         2015-1-19               规范代码
//      聂迪           2015-1－21              规范代码
//
#import "HWGameSpreadTableViewCell.h"

#define CELL_HEIGHT     87.0f

@implementation HWGameSpreadTableViewCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self)
    {
        [self initaViewOnCell];
    }
    return self;
}

/**
 *	@brief	初始化cell上的子视图，并赋值
 *
 *	@return	N/A
 */
- (void)initaViewOnCell
{
    self.selectionStyle = UITableViewCellSelectionStyleNone;
    self.headerImageView = [[UIImageView alloc]initWithFrame:CGRectMake(15.0f, 12.0f, 65.0f, 65.0f)];
    self.headerImageView.backgroundColor = IMAGE_DEFAULT_COLOR;
    self.headerImageView.contentMode = UIViewContentModeScaleAspectFit;
    self.headerImageView.layer.cornerRadius = 6.0f;
    self.headerImageView.layer.masksToBounds = YES;
    [self.contentView addSubview:self.headerImageView];
    
    self.titleLabel = [[UILabel alloc]initWithFrame:CGRectMake(CGRectGetMaxX(self.headerImageView.frame) + 5.0f, 15.0f, kScreenWidth - (CGRectGetMaxX(self.headerImageView.frame) + 5.0f) - 15.0f - 40.0f, 15.0f)];
    self.titleLabel.backgroundColor = [UIColor clearColor];
    self.titleLabel.font = [UIFont fontWithName:FONTNAME size:THEME_FONT_BIG];
    self.titleLabel.textColor = THEME_COLOR_SMOKE;
    [self.contentView addSubview:self.titleLabel];
    
//    self.classLabel = [[UILabel alloc]initWithFrame:CGRectMake(90.f *kScreenRate, 24.f *kScreenRate, 112/2.f *kScreenRate, 12.f *kScreenRate)];
//    self.classLabel.backgroundColor = [UIColor clearColor];
//    self.classLabel.font = [UIFont fontWithName:FONTNAME size:THEME_FONT_SMALL];
//    [self.classLabel setTextColor:THEME_COLOR_TEXT];
//    [self.contentView addSubview:self.classLabel];
    

    self.peopleLabel = [[UILabel alloc]initWithFrame:CGRectMake(self.titleLabel.frame.origin.x, CGRectGetMaxY(self.titleLabel.frame) + 5.0f, self.titleLabel.frame.size.width, 15.0f)];
    self.peopleLabel.backgroundColor = [UIColor clearColor];
    self.peopleLabel.font = [UIFont fontWithName:FONTNAME size:THEME_FONT_SMALL];
    self.peopleLabel.textColor = THEME_COLOR_TEXT;
    [self.contentView addSubview:self.peopleLabel];
    

    self.subTitleLabel = [[UILabel alloc]initWithFrame:CGRectMake(self.titleLabel.frame.origin.x, CGRectGetMaxY(self.peopleLabel.frame) + 5.0f, self.titleLabel.frame.size.width, 15.0f)];
    self.subTitleLabel.backgroundColor = [UIColor clearColor];
    self.subTitleLabel.font = [UIFont fontWithName:FONTNAME size:THEME_FONT_SMALL];
    [self.subTitleLabel setTextColor:THEME_COLOR_TEXT];
    [self.contentView addSubview:self.subTitleLabel];
    
    self.spreadButton = [UIButton buttonWithType:UIButtonTypeCustom];
    self.spreadButton.frame = CGRectMake(kScreenWidth - 70.0f, 0 , 70.0f, CELL_HEIGHT);
//    CGPoint btnCenter = self.spreadButton.center;
//    btnCenter.y = CELL_HEIGHT / 2.0f;
//    self.spreadButton.center = btnCenter;
    self.spreadButton.backgroundColor = [UIColor clearColor];
//    [self.spreadButton setGreenBorderStyle];
    [self.contentView addSubview:self.spreadButton];
    [self.spreadButton addTarget:self action:@selector(btnClick:) forControlEvents:UIControlEventTouchUpInside];
    
    UILabel *spreadLabel = [[UILabel alloc]initWithFrame:CGRectMake(15.0f, (CELL_HEIGHT - 25.0f) / 2, 45.0f, 25.0f)];
    spreadLabel.backgroundColor = [UIColor clearColor];
    spreadLabel.text = @"推广";
    spreadLabel.textAlignment = NSTextAlignmentCenter;
    spreadLabel.textColor = THEME_COLOR_ORANGE;
    spreadLabel.font = [UIFont fontWithName:FONTNAME size:THEME_FONT_SMALL];
    spreadLabel.layer.borderColor = THEME_COLOR_ORANGE.CGColor;
    spreadLabel.layer.borderWidth = 1.0f;
    spreadLabel.layer.cornerRadius = 3.5f;
    [self.spreadButton addSubview:spreadLabel];
    
    UIView *line = [[UIView alloc]initWithFrame:CGRectMake(0, CELL_HEIGHT - 0.5f, kScreenWidth, 0.5f)];
    line.backgroundColor = THEME_COLOR_LINE;
    [self.contentView addSubview:line];
}

+ (CGFloat)getCellHeight
{
    return CELL_HEIGHT;
}

- (void)setGameSpreadInfo:(HWGameSpreadModel *)model
{
    _model = model;
    
    __weak UIImageView *weakImgV = self.headerImageView;
    [self.headerImageView setImageWithURL:[NSURL URLWithString:[Utility imageDownloadWithMongoDbKey:model.iconMongodbKey]] placeholderImage:[UIImage imageNamed:IMAGE_PLACE] completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType)
    {
        if (error != nil)
        {
            weakImgV.image = [UIImage imageNamed:IMAGE_BREAK_CUBE];
        }
        else
        {
            weakImgV.image = image;
        }
    }];
    
    self.titleLabel.text = model.gameName;
    
    
    NSString *peopleStr = model.shareCount.intValue == 0 ? @"0" : model.shareCount;
    peopleStr = [NSString stringWithFormat:@"共有%@人在推广", peopleStr];
    
    NSMutableAttributedString *attPeople = [[NSMutableAttributedString alloc]initWithString: peopleStr];
    [attPeople addAttribute:NSForegroundColorAttributeName value:THEME_COLOR_SMOKE range:NSMakeRange(2, peopleStr.length - 6)];
    self.peopleLabel.attributedText = attPeople;
    
    
    NSString *moneyStr = model.commissionCount.floatValue == 0 ? @"0.00" : model.commissionCount;
    moneyStr = [NSString stringWithFormat:@"共获得￥%@佣金", moneyStr];
    
    NSMutableAttributedString *attStr = [[NSMutableAttributedString alloc]initWithString:moneyStr];
    [attStr addAttribute:NSForegroundColorAttributeName value:THEME_COLOR_MONEY range:NSMakeRange(3, moneyStr.length - 5)];
    self.subTitleLabel.attributedText = attStr;
}

- (void)btnClick:(HWGameSpreadModel *)model
{
    if (self.delegate && [self.delegate respondsToSelector:@selector(spreadBtnIsClicked:)])
    {
        [self.delegate spreadBtnIsClicked:_model];
    }
}


@end
