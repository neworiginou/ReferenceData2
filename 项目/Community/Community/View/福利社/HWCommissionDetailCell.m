//
//  HWCommissionDetailCell.m
//  Community
//
//  Created by niedi on 15/1/17.
//  Copyright (c) 2015年 caijingpeng. All rights reserved.
//
//  功能描述：佣金明细cell
//
//  修改记录：
//      姓名          日期                      修改内容
//      聂迪          2015-1-17                 创建文件
//

#import "HWCommissionDetailCell.h"

@implementation HWCommissionDetailCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier])
    {
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        
        UIView *backView = [[UIView alloc] initWithFrame:CGRectMake(15, 0, kScreenWidth - 2 * 15, 40.0f)];
        backView.backgroundColor = [UIColor clearColor];
        [self addSubview:backView];
        
        //时间
        self.commissionTimeLab = [[UILabel alloc] init];
        self.commissionTimeLab.frame = CGRectMake(15, 10, 90, 20);
        self.commissionTimeLab.backgroundColor = [UIColor clearColor];
        self.commissionTimeLab.font = [UIFont fontWithName:FONTNAME size:THEME_FONT_SMALL13];
        self.commissionTimeLab.textColor = THEME_COLOR_SMOKE;
        [backView addSubview:self.commissionTimeLab];
        
        //类型 消费或激活
        self.commissionTypeLab = [[UILabel alloc] init];
        self.commissionTypeLab.frame = CGRectMake(0, self.commissionTimeLab.frame.origin.y, backView.frame.size.width, self.commissionTimeLab.frame.size.height);
        self.commissionTypeLab.backgroundColor = [UIColor clearColor];
        self.commissionTypeLab.textColor = THEME_COLOR_SMOKE;
        self.commissionTypeLab.font = [UIFont fontWithName:FONTNAME size:THEME_FONT_BIG];
        self.commissionTypeLab.textAlignment = NSTextAlignmentLeft;
        [backView addSubview:self.commissionTypeLab];
        
        //金额
        self.commissionMoneyLab = [[UILabel alloc] init];
        self.commissionMoneyLab.frame = CGRectMake(130, self.commissionTimeLab.frame.origin.y, kScreenWidth - 130 - 15 - 30, self.commissionTimeLab.frame.size.height);
        self.commissionMoneyLab.backgroundColor = [UIColor clearColor];
        self.commissionMoneyLab.textColor = THEME_COLOR_MONEY;
        self.commissionMoneyLab.textAlignment = NSTextAlignmentRight;
        self.commissionMoneyLab.font = [UIFont fontWithName:FONTNAME size:THEME_FONT_SMALL13];
        [backView addSubview:self.commissionMoneyLab];
        
        //考拉币图片
        self.koalaCoinImg = [[UIImageView alloc] init];
        self.koalaCoinImg.frame = CGRectMake(self.commissionMoneyLab.frame.origin.x - 13, self.commissionTimeLab.frame.origin.y + 3, 13, 13);
        self.koalaCoinImg.image = [UIImage imageNamed:@"klb_new_01"];
        self.koalaCoinImg.backgroundColor = [UIColor clearColor];
        [backView addSubview:self.koalaCoinImg];
        
        //佣金比例
        self.commissionDetailLab = [[UILabel alloc] init];
        self.commissionDetailLab.frame = CGRectMake(15, CGRectGetMaxY(self.commissionMoneyLab.frame) - 8, kScreenWidth - 15 - 15 - 30, self.commissionTimeLab.frame.size.height);
        self.commissionDetailLab.backgroundColor = [UIColor clearColor];
        self.commissionDetailLab.textColor = THEME_COLOR_TEXT;
        self.commissionDetailLab.textAlignment = NSTextAlignmentRight;
        self.commissionDetailLab.font = [UIFont fontWithName:FONTNAME size:THEME_FONT_SUPERSMALL];
        [backView addSubview:self.commissionDetailLab];
        
        //下边界线
        self.topLineLab = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth - 2 * 15, 0.5f)];
        self.topLineLab.backgroundColor = THEME_COLOR_LINE;
        [backView addSubview:self.topLineLab];
        
        self.buttomLab = [[UILabel alloc] initWithFrame:CGRectMake(0, 39.5f, kScreenWidth - 2 * 15, 0.5f)];
        self.buttomLab.backgroundColor = THEME_COLOR_LINE;
        [backView addSubview:self.buttomLab];
        
        UILabel *leftLineLab = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 0.5f, 40)];
        leftLineLab.backgroundColor = THEME_COLOR_LINE;
        [backView addSubview:leftLineLab];
        
        UILabel *rightLineLab = [[UILabel alloc] initWithFrame:CGRectMake(kScreenWidth - 2 * 15 - 0.5f, 0, 0.5f, 40)];
        rightLineLab.backgroundColor = THEME_COLOR_LINE;
        [backView addSubview:rightLineLab];
        
    }
    return self;
}

- (void)setCommissionDetailContent:(HWCommissionDetailSubModel *)model
{
    if (model.dealTime.length != 0)
    {
        self.commissionTimeLab.text = [model.dealTime substringToIndex:5];
    }
    
    if (model.eventType.integerValue == 4)
    {
        self.commissionTypeLab.text = @"                        消费";
    }
    else if (model.eventType.integerValue == 2)
    {
        self.commissionTypeLab.text = @"                        激活";
    }
    
    self.commissionMoneyLab.text = @"";
    CGRect frame = self.commissionMoneyLab.frame;
    frame.origin.y = self.commissionTimeLab.frame.origin.y;
    self.commissionMoneyLab.frame = frame;
    if (model.commissionAmountRMB.length != 0)          //佣金有两种 激活、消费
    {
        if ([model.eventType isEqualToString:@"4"])     //消费时 按比率计算佣金
        {
            self.commissionMoneyLab.text = [NSString stringWithFormat:@"+￥%.2f", model.commissionAmountRMB.floatValue * model.proportion.floatValue];
        }
        else                                            //激活直接显示
        {
            self.commissionMoneyLab.text = [NSString stringWithFormat:@"+￥%@", model.commissionAmountRMB];
        }
        self.commissionMoneyLab.textColor = THEME_COLOR_MONEY;
    }
    
    
    if ([model.commissionAmountKLB isEqualToString:@"0"] || model.commissionAmountKLB.length == 0)
    {
        self.koalaCoinImg.hidden = YES;
    }
    else
    {
        self.commissionMoneyLab.text = [NSString stringWithFormat:@"+%@", model.commissionAmountKLB];
        self.commissionMoneyLab.textColor = THEME_COLOR_ORANGE;
        CGRect frame = self.koalaCoinImg.frame;
        frame.origin.x = kScreenWidth - 30 - 13 - 15 - 3 - [Utility calculateStringWidth:self.commissionMoneyLab.text font:[UIFont fontWithName:FONTNAME size:THEME_FONT_SMALL13] constrainedSize:CGSizeMake(10000, 20)].width;
        self.koalaCoinImg.frame = frame;
        self.koalaCoinImg.hidden = NO;
    }
    
    self.commissionDetailLab.text = @"";
    if ([model.eventType isEqualToString:@"4"]) {
        
        CGRect frame = self.commissionMoneyLab.frame;
        frame.origin.y = 5;
        self.commissionMoneyLab.frame = frame;
        
        self.commissionDetailLab.text = [NSString stringWithFormat:@"(消费金额￥%@x%.2f%%)",model.commissionAmountRMB, model.proportion.floatValue * 100];
    }
}
+ (float)getCellHeight
{
    return 40.0f;
}


@end
