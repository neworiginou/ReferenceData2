//
//  HWPersonDynamicCell.m
//  Community
//
//  Created by hw500027 on 15/1/9.
//  Copyright (c) 2015年 caijingpeng. All rights reserved.
//
//  功能描述：我的动态首页cell
//  修改记录：
//	姓名   日期　　　　　　 修改内容
//  陆晓波  2015-01-15    新增未读信息图标，显示位置修正
//  陆晓波  2015-01-16    显示新增信息按钮_newsCountBtn属性修改
//  陆晓波  2015-01-29    UI调整

#import "HWPersonDynamicCell.h"

@implementation HWPersonDynamicCell


- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self)
    {
        _personDynamicImgV = [[UIImageView alloc]initWithFrame:CGRectMake(15, 10, 45, 45)];
        _personDynamicImgV.backgroundColor = [UIColor whiteColor];
        [self.contentView addSubview:_personDynamicImgV];
        
        _titleLab = [[UILabel alloc]initWithFrame:CGRectMake(CGRectGetMaxX(_personDynamicImgV.frame) + 10, 25, 200, THEME_FONT_SMALLTITLE)];
        _titleLab.backgroundColor = [UIColor whiteColor];
        _titleLab.textColor = THEME_COLOR_SMOKE;
        _titleLab.font = [UIFont systemFontOfSize:THEME_FONT_SMALLTITLE];
        [self.contentView addSubview:_titleLab];
        
        _newsCountBtn = [[HWPersonAddedCountBtn alloc]init];
        _newsCountBtn.frame = CGRectMake(kScreenWidth - 35 - _newsCountBtn.frame.size.width, _titleLab.frame.origin.y, _newsCountBtn.frame.size.width, _newsCountBtn.frame.size.height) ;
        _newsCountBtn.hidden = YES;
        [self.contentView addSubview:_newsCountBtn];
        
        _rightArrowImgV = [[UIImageView alloc]init];
        [_rightArrowImgV setImage:[UIImage imageNamed:@"个人中心－图标10"]];
        [_rightArrowImgV sizeToFit];
        _rightArrowImgV.frame = CGRectMake(kScreenWidth - 15 - _rightArrowImgV.frame.size.width, _titleLab.frame.origin.y, _rightArrowImgV.frame.size.width, _rightArrowImgV.frame.size.height);
        [self.contentView addSubview:_rightArrowImgV];
        
        _line = [[UIView alloc] initWithFrame:CGRectMake(0, 64.5, kScreenWidth, 0.5f)];
        _line.backgroundColor = THEME_COLOR_LINE;
        [self.contentView addSubview:_line];
    }
    return self;
}

- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
