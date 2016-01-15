//
//  HWFulLiSheTableViewCell.m
//  KaoLa
//
//  Created by hw on 15/1/12.
//  Copyright (c) 2015年 hw. All rights reserved.
//
//  功能描述： 福利社首页
//
//  修改记录：
//      姓名:     日期 :       修改内容:
//      吴晓红    2015/1/13    创建文件及ui
//      李中强    2015-01-17   添加头注释 相关人员补齐注释
//

#import "HWFulLiSheTableViewCell.h"

@implementation HWFulLiSheTableViewCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self)
    {
        self.headImageView = [[UIImageView alloc] initWithFrame:CGRectMake(15, ([HWFulLiSheTableViewCell getCellHeight] - 56.0f) / 2.0f, 56.0f, 56.0f)];
        self.headImageView.backgroundColor = [UIColor clearColor];
        self.headImageView.layer.cornerRadius = 56.0f / 2.0f;
        [self.contentView addSubview:self.headImageView];
        
        self.nameLable = [[UILabel alloc]initWithFrame:CGRectMake(CGRectGetMaxX(self.headImageView.frame) + 10, 25, 200, 25)];
        self.nameLable.backgroundColor = [UIColor clearColor];
        self.nameLable.textColor = THEME_COLOR_SMOKE;
        self.nameLable.font = [UIFont fontWithName:FONTNAME size:THEME_FONT_SMALLTITLE];
        [self.contentView addSubview:self.nameLable];
        
        self.detailLable = [[UILabel alloc] initWithFrame:CGRectMake(CGRectGetMaxX(self.headImageView.frame) + 10, CGRectGetMaxY(self.nameLable.frame), 200, 20)];
        self.detailLable.backgroundColor = [UIColor clearColor];
        self.detailLable.textColor = THEME_COLOR_TEXT;
        self.detailLable.font = [UIFont fontWithName:FONTNAME size:THEME_FONT_SMALL];
        [self.contentView addSubview:self.detailLable];
        
        //右跳转图标
        self.rightJumpView = [[UIImageView alloc] initWithFrame:CGRectMake(kScreenWidth - 15 - 8, 0, 8, 14)];
        CGPoint centerPoint = self.rightJumpView.center;
        centerPoint.y = 95.0f/2.0f;
        self.rightJumpView.center = centerPoint;
        self.rightJumpView.image = [UIImage imageNamed:@"个人中心－图标10"];
        [self addSubview:self.rightJumpView];
        
        UIView *line =[[UIView alloc]initWithFrame:CGRectMake(0, [HWFulLiSheTableViewCell getCellHeight] - 0.5, kScreenWidth, 0.5)];
        [line setBackgroundColor:THEME_COLOR_LINE];
        [self.contentView addSubview:line];
        
    }
    return self;
}

+ (CGFloat)getCellHeight
{
    return 95.0f;
}

@end
