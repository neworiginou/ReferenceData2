//
//  HWGameSpreadTableViewCell.m
//  KaoLa
//
//  Created by WeiYuanlin on 15/1/13.
//  Copyright (c) 2015年 WeiYuanlin. All rights reserved.
//  功能描述：游戏推广页面tableviewcell
//  修改记录
//      李中强 2015-01-17 添加头注释 相关人员补齐注释
//      姓名          日期                      修改内容
//      魏远林         2015-1-13               创建文件
//      魏远林         2015-1-19               规范代码
//

#import "HWGameSpreadTableViewCell.h"

#define CELL_HEIGHT     87.0f

@implementation HWGameSpreadTableViewCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        //
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
    self.headerImageView = [[UIImageView alloc]initWithFrame:CGRectMake(15.f, 12.f, 65.f, 65.f)];
    self.headerImageView.layer.cornerRadius = 10;
    self.headerImageView.layer.masksToBounds = YES;
    self.headerImageView.backgroundColor = [UIColor redColor];
    [self.contentView addSubview:self.headerImageView];
    
    self.titleLabel = [[UILabel alloc]initWithFrame:CGRectMake(180 / 2.f, 15.f, 60.f, 12.f)];
    self.titleLabel.backgroundColor = [UIColor clearColor];
    self.titleLabel.font = [UIFont fontWithName:FONTNAME size:THEME_FONT_BIG];
    [self.titleLabel setTextColor:THEME_COLOR_SMOKE];
    [self.contentView addSubview:self.titleLabel];
    
//    self.classLabel = [[UILabel alloc]initWithFrame:CGRectMake(90.f *kScreenRate, 24.f *kScreenRate, 112/2.f *kScreenRate, 12.f *kScreenRate)];
//    self.classLabel.backgroundColor = [UIColor clearColor];
//    self.classLabel.font = [UIFont fontWithName:FONTNAME size:THEME_FONT_SMALL];
//    [self.classLabel setTextColor:THEME_COLOR_TEXT];
//    [self.contentView addSubview:self.classLabel];
    

    self.peopleLabel = [[UILabel alloc]initWithFrame:CGRectMake(90.f, 24.f , 130.f, 12.f)];
    self.peopleLabel.backgroundColor = [UIColor clearColor];
    self.peopleLabel.font = [UIFont fontWithName:FONTNAME size:THEME_FONT_SMALL];
    self.peopleLabel.textColor = THEME_COLOR_TEXT;
    [self.contentView addSubview:self.peopleLabel];
    

    self.subTitleLabel = [[UILabel alloc]initWithFrame:CGRectMake(90.f, 24.f, 324/2.f, 12.f)];
    
    self.subTitleLabel.backgroundColor = [UIColor clearColor];
    self.subTitleLabel.font = [UIFont fontWithName:FONTNAME size:THEME_FONT_SMALL];
    [self.subTitleLabel setTextColor:THEME_COLOR_TEXT];
    //    self.subTitleLabel.numberOfLines = 0;
    //    self.subTitleLabel.lineBreakMode = NSLineBreakByCharWrapping;
    [self.contentView addSubview:self.subTitleLabel];
    
    self.spreadButton = [UIButton buttonWithType:UIButtonTypeCustom];
    self.spreadButton.frame = CGRectMake(kScreenWidth - (15 + 84 / 2.f), CELL_HEIGHT /2.f - 50 / 2 / 2.0f, 84 / 2.0f, 50 / 2.0f);
    [self.spreadButton setTitle:@"推广" forState:UIControlStateNormal];
    [self.spreadButton addTarget:self action:@selector(btnClick:) forControlEvents:UIControlEventTouchUpInside];
    self.spreadButton.backgroundColor = [UIColor clearColor];
    //设置边框颜色
    [self.spreadButton setGreenBorderStyle];
    [self.contentView addSubview:self.spreadButton];
    
    UIView *line = [[UIView alloc]initWithFrame:CGRectMake(0, CELL_HEIGHT - 0.5f, kScreenWidth, 0.5f)];
    line.backgroundColor = THEME_COLOR_LINE;
    [self.contentView addSubview:line];
    
}

- (void)setGameSpreadInfo:(HWGameSpreadModel *)model
{
    _model = model;
    
    [self.headerImageView setImageWithURL:[NSURL URLWithString:[Utility imageDownloadWithMongoDbKey:model.iconMongodbKey]] placeholderImage:[UIImage imageNamed:IMAGE_PLACE]];
    self.titleLabel.text = model.gameName;
    NSString *peopleStr = model.shareCount;
    NSString *moneyStr = model.commissionCount;
    self.peopleLabel.text = [NSString stringWithFormat:@"共有%@人在推广",peopleStr];
    self.subTitleLabel.text = [NSString stringWithFormat:@"共获得￥%@佣金",moneyStr];
    //计算label的长度
    CGSize titleSize;//classSize/*,subTitleSize*/
    if (IOS7)
    {
        NSDictionary *titleAtt = @{NSFontAttributeName:self.titleLabel.font};
        titleSize = [self.titleLabel.text boundingRectWithSize:CGSizeMake(CGFLOAT_MAX, 21) options:NSStringDrawingTruncatesLastVisibleLine | NSStringDrawingUsesLineFragmentOrigin | NSStringDrawingUsesFontLeading attributes:titleAtt context:nil].size;
//        NSDictionary *classAtt = @{NSFontAttributeName:self.classLabel.font};
//        classSize = [self.classLabel.text boundingRectWithSize:CGSizeMake(CGFLOAT_MAX, 21) options:NSStringDrawingTruncatesLastVisibleLine | NSStringDrawingUsesLineFragmentOrigin | NSStringDrawingUsesFontLeading attributes:classAtt context:nil].size;
//        NSDictionary *subTitleAtt = @{NSFontAttributeName:self.subTitleLabel.font};
//        subTitleSize = [self.subTitleLabel.text boundingRectWithSize:CGSizeMake(CGFLOAT_MAX, 21) options:NSStringDrawingTruncatesLastVisibleLine | NSStringDrawingUsesLineFragmentOrigin | NSStringDrawingUsesFontLeading attributes:subTitleAtt context:nil].size;
    }
    else
    {
        titleSize = [self.titleLabel.text sizeWithFont:self.titleLabel.font constrainedToSize:CGSizeMake(CGFLOAT_MAX, 21) lineBreakMode:NSLineBreakByCharWrapping];
        //        classSize = [self.classLabel.text sizeWithFont:self.classLabel.font constrainedToSize:CGSizeMake(CGFLOAT_MAX, 21) lineBreakMode:NSLineBreakByCharWrapping];
        //        subTitleSize = [self.classLabel.text sizeWithFont:self.subTitleLabel.font constrainedToSize:CGSizeMake(CGFLOAT_MAX, 21) lineBreakMode:NSLineBreakByCharWrapping];
    }
    //重写坐标
    self.titleLabel.frame = CGRectMake(CGRectGetMaxX(self.headerImageView.frame) + 10.f, 15.f, titleSize.width, 12.f );
    
    [self.peopleLabel sizeToFit];
    self.peopleLabel.frame = CGRectMake(CGRectGetMaxX(self.headerImageView.frame) + 10.f, CGRectGetMaxY(self.titleLabel.frame) + 8.f , self.peopleLabel.frame.size.width, self.peopleLabel.frame.size.height);
    NSMutableAttributedString *attPeople = [[NSMutableAttributedString alloc]initWithString:self.peopleLabel.text];
    [attPeople addAttribute:NSForegroundColorAttributeName value:(id)UIColorFromRGB(0x525252) range:NSMakeRange(2, peopleStr.length)];
    self.peopleLabel.attributedText = attPeople;
    
    [self.subTitleLabel sizeToFit];
    self.subTitleLabel.frame = CGRectMake(CGRectGetMaxX(self.headerImageView.frame) + 10.f, CGRectGetMaxY(self.peopleLabel.frame) + 8.f, self.subTitleLabel.frame.size.width, self.subTitleLabel.frame.size.height);
    NSMutableAttributedString *attStr = [[NSMutableAttributedString alloc]initWithString:[NSString stringWithFormat:@"%@",self.subTitleLabel.text]];
    [attStr addAttribute:NSForegroundColorAttributeName value:(id)UIColorFromRGB(0xFDA229) range:NSMakeRange(3, moneyStr.length + 1)];
    self.subTitleLabel.attributedText = attStr;
}

- (void)btnClick:(HWGameSpreadModel *)model
{
    if (self.delegate && [self.delegate respondsToSelector:@selector(spreadBtnIsClicked:)]) {
        
        [self.delegate spreadBtnIsClicked:_model];
    }
}


//根据内容计算label自适应高度
- (float)calculateContentHeightByString:(NSString *)content withFontName:(NSString *)fontName withFontSize:(CGFloat)fontSize
{
    CGSize limitSize = CGSizeMake(160, 1000);
    UIFont *font = [UIFont fontWithName:fontName size:fontSize];
    if (IOS7)
    {
        NSDictionary *attribute = @{NSFontAttributeName: font};
        CGRect rect = [content boundingRectWithSize:limitSize options:NSStringDrawingTruncatesLastVisibleLine | NSStringDrawingUsesLineFragmentOrigin | NSStringDrawingUsesFontLeading attributes:attribute context:nil];
        return rect.size.height;
    }
    else
    {
        CGSize size = [content sizeWithFont:font constrainedToSize:limitSize lineBreakMode:NSLineBreakByWordWrapping];
        return size.height;
    }
    
    return 0;
}

+ (CGFloat)getCellHeight
{
    return CELL_HEIGHT;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
