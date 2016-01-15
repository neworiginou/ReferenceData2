//
//  HWSingleCustomAlertV.m
//  HWCustomAlertView
//
//  Created by D on 14/12/15.
//  Copyright (c) 2014年 D. All rights reserved.
//

#import "HWSingleCustomAlertV.h"

#define OtherSubViewHeight 180

@implementation HWSingleCustomAlertV
@synthesize titleLab;
+ (id)alertWithMoneyAmount:(float)amount {
    return [[self alloc] initWithOtherViewHight:OtherSubViewHeight MoneyAmount:amount];
}

- (instancetype)initWithOtherViewHight:(CGFloat)height MoneyAmount:(float)amount{
    if (self = [super initWithOtherViewHight:height])
    {
        self.isSingleCustomView = YES;
        self.isShowing = NO;
        self.money = amount;
        [self loadUI];
        
    }
    return self;
}

- (void)loadUI {
    [super loadUI];
    
    //大标题 Lab
    titleLab = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, self.handleView.frame.size.width, 40)];
    titleLab.text = @"考拉币余额支付";
    titleLab.textColor = THEME_COLOR_SMOKE;
    titleLab.backgroundColor = [UIColor clearColor];
    titleLab.textAlignment = NSTextAlignmentCenter;
    titleLab.font = [UIFont fontWithName:FONTNAME size:THEME_FONT_BIG];
    [self.handleView addSubview:titleLab];
    
    //分割线Lab
    for (int i = 0; i < 2; i++) {
        UILabel * lineLab = [[UILabel alloc] initWithFrame:CGRectMake(15, 40 * (i + 1), self.handleView.frame.size.width - 2 * 15, 0.5)];
        lineLab.backgroundColor = [UIColor colorWithWhite:0.3 alpha:0.1];
        [self.handleView addSubview:lineLab];
    }
    
    //第二行左侧 "支出金额" Lab
    UILabel * costTitleLab = [[UILabel alloc] initWithFrame:CGRectMake(20, titleLab.frame.origin.y + titleLab.frame.size.height, 80, 40)];
    costTitleLab.text = @"支出金额";
    costTitleLab.textColor = THEME_COLOR_SMOKE;
    costTitleLab.backgroundColor = [UIColor clearColor];
    costTitleLab.textAlignment = NSTextAlignmentLeft;
    costTitleLab.font = [UIFont fontWithName:FONTNAME size:THEME_FONT_SMALL];
    [self.handleView addSubview:costTitleLab];
    
    //第二行 金额Lab
    UILabel * coustMoneyLab = [[UILabel alloc] initWithFrame:CGRectMake(self.handleView.frame.size.width - 20 - 400, costTitleLab.frame.origin.y, 400, 40)];
    coustMoneyLab.text = [NSString stringWithFormat:@"￥%.2f",self.money];
    coustMoneyLab.textAlignment = NSTextAlignmentRight;
    coustMoneyLab.textColor = THEME_COLOR_MONEY;
    coustMoneyLab.backgroundColor = [UIColor clearColor];
    coustMoneyLab.font = [UIFont fontWithName:FONTNAME size:THEME_FONT_SMALL];
    [self.handleView addSubview:coustMoneyLab];
    
    
    //第三行 提示信息
    UILabel * infoLab = [[UILabel alloc] initWithFrame:CGRectMake(20, costTitleLab.frame.origin.y + costTitleLab.frame.size.height, self.handleView.frame.size.width - 20 * 2, 40)];
    infoLab.text = @"请输入支付密码（原钱包提现密码）";
    infoLab.textColor = THEME_COLOR_SMOKE;
    infoLab.textAlignment = NSTextAlignmentLeft;
    infoLab.backgroundColor = [UIColor clearColor];
    infoLab.font = [UIFont fontWithName:FONTNAME size:THEME_FONT_SMALL];
    [self.handleView addSubview:infoLab];
    
    //密码框 图片
    for (int i = 0; i < 6; i++)
    {
        float width = (self.handleView.frame.size.width - 2 * 20)/7.0f;
        UIImageView *imgV = [[UIImageView alloc] initWithFrame:CGRectMake(20 + width/5.0 * 6.0f * i, infoLab.frame.origin.y + infoLab.frame.size.height, width, width)];
        imgV.backgroundColor = [UIColor whiteColor];
        imgV.image = [UIImage imageNamed:@"passwordBlock"];
        imgV.tag = 111 + i;
        [self.handleView addSubview:imgV];
    }
    
    //最下方按钮
    for (int i = 0; i < 2; i++) {
        float width = (self.handleView.frame.size.width - 2 * 20 - 13)/2.0f;
        UIButton *payOrCancleBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [payOrCancleBtn setFrame:CGRectMake(20 + (width + 13)* i, self.handleView.frame.size.height - 48, width, 35)];
        if (i == 0) {
            [payOrCancleBtn setTitle:@"取消" forState:UIControlStateNormal];
            [payOrCancleBtn setTitleColor:THEME_COLOR_SMOKE forState:UIControlStateNormal];
            [payOrCancleBtn setBackgroundImage:[HWSingleCustomAlertV imageWithColor:UIColorFromRGB(0xf7f7f7) andSize:CGSizeMake(width, 40)] forState:UIControlStateNormal];
        } else if (i == 1) {
            [payOrCancleBtn setTitle:@"确认支付" forState:UIControlStateNormal];
            [payOrCancleBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
            [payOrCancleBtn setBackgroundImage:[HWSingleCustomAlertV imageWithColor:THEME_COLOR_ORANGE andSize:CGSizeMake(width, 40)] forState:UIControlStateNormal];
        }
        payOrCancleBtn.layer.borderColor = THEME_COLOR_LINE.CGColor;
        payOrCancleBtn.layer.borderWidth = 0.5f;
        payOrCancleBtn.tag = 202 + i;
        payOrCancleBtn.layer.cornerRadius = 5;
        payOrCancleBtn.layer.masksToBounds = YES;
        payOrCancleBtn.titleLabel.font = [UIFont fontWithName:FONTNAME size:THEME_FONT_SMALL];
        [payOrCancleBtn addTarget:self action:@selector(btnClick:) forControlEvents:UIControlEventTouchUpInside];
        [self.handleView addSubview:payOrCancleBtn];
    }
    
    //隐藏的文本框
    UITextView * secretTV = [[UITextView alloc] initWithFrame:CGRectMake(0, 0, 100, 100)];
    secretTV.hidden = YES;
    secretTV.delegate = self;
    secretTV.keyboardType = UIKeyboardTypeNumberPad;
    secretTV.tag = 555;
    [secretTV becomeFirstResponder];
    [self.handleView addSubview:secretTV];
}


- (void)show {
    [MobClick event:@"click_qianbaozhifumima"];
    if (self.isShowing == NO)
    {
        [super show];
    }
    self.isShowing = YES;
    
}
@end
