//
//  HWCustomAlertView.m
//  HWCustomAlertView
//
//  Created by D on 14/12/15.
//  Copyright (c) 2014年 D. All rights reserved.
//

#import "HWCustomAlertView.h"
#import <LocalAuthentication/LocalAuthentication.h>

#define OtherSubViewHeight 243

@implementation HWCustomAlertView

@synthesize handlingFee;
@synthesize coustMoneyLab;

+ (id)alertWithMoneyAmount:(double)amount handleFee:(NSString *)fee
{
    return [[self alloc] initWithOtherViewHight:OtherSubViewHeight MoneyAmount:amount handleFee:fee];
}

- (instancetype)initWithOtherViewHight:(CGFloat)height MoneyAmount:(double)amount handleFee:(NSString *)fee{
    if (self = [super initWithOtherViewHight:height])
    {
        self.isSingleCustomView = NO;
        self.isShowing = NO;
        self.money = amount;
        self.handlingFee = fee;
        [self loadUI];
    }
    return self;
}
#pragma mark -
#pragma mark - UI
- (void)loadUI
{
    [super loadUI];
//    [self addTouchIDBtn];
    
    //大标题 Lab
    UILabel * titleLab = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, self.handleView.frame.size.width, 45)];
    titleLab.text = @"考拉币余额支付";
    titleLab.textColor = THEME_COLOR_SMOKE;
    titleLab.backgroundColor = [UIColor clearColor];
    titleLab.textAlignment = NSTextAlignmentCenter;
    titleLab.font = [UIFont fontWithName:FONTNAME size:THEME_FONT_BIG];
    [self.handleView addSubview:titleLab];
    
    //分割线Lab
    for (int i = 0; i < 3; i++)
    {
        UILabel * lineLab = [[UILabel alloc] initWithFrame:CGRectMake(15, 45 * (i + 1), self.handleView.frame.size.width - 2 * 15, 0.5)];
        lineLab.backgroundColor = [UIColor colorWithWhite:0.3 alpha:0.1];
        [self.handleView addSubview:lineLab];
    }
    
    //第一行左侧Lab
    UILabel * lineOnePayLab = [[UILabel alloc] initWithFrame:CGRectMake(20, titleLab.frame.origin.y + titleLab.frame.size.height, 40, 45)];
    lineOnePayLab.text = @"出价";
    lineOnePayLab.textColor = THEME_COLOR_SMOKE;
    lineOnePayLab.backgroundColor = [UIColor clearColor];
    lineOnePayLab.textAlignment = NSTextAlignmentCenter;
    lineOnePayLab.font = [UIFont fontWithName:FONTNAME size:THEME_FONT_SMALL];
    [self.handleView addSubview:lineOnePayLab];
    
    //第一行 金额Lab
    coustMoneyLab = [[UILabel alloc] initWithFrame:CGRectMake(lineOnePayLab.frame.origin.x + 40, titleLab.frame.origin.y + titleLab.frame.size.height, self.handleView.frame.size.width - 20 * 2 - 40 - 20, 45)];
    coustMoneyLab.text = [NSString stringWithFormat:@"%.2f",self.money];
    coustMoneyLab.textAlignment = NSTextAlignmentRight;
    coustMoneyLab.textColor = THEME_COLOR_MONEY;
    coustMoneyLab.backgroundColor = [UIColor clearColor];
    coustMoneyLab.font = [UIFont fontWithName:FONTNAME size:THEME_FONT_SMALL];
    [self.handleView addSubview:coustMoneyLab];
    
    //第一行 ”元“ Lab
    UILabel * lineOneYuanLab = [[UILabel alloc] initWithFrame:CGRectMake(self.handleView.frame.size.width - 20 - 20, titleLab.frame.origin.y + titleLab.frame.size.height, 20, 45)];
    lineOneYuanLab.text = @"元";
    lineOneYuanLab.textColor = THEME_COLOR_SMOKE;
    lineOneYuanLab.textAlignment = NSTextAlignmentCenter;
    lineOneYuanLab.backgroundColor = [UIColor clearColor];
    lineOneYuanLab.font = [UIFont fontWithName:FONTNAME size:THEME_FONT_SMALL];
    [self.handleView addSubview:lineOneYuanLab];
    
    //第二行 手续费Lab
    UILabel * lineTwoChargeLab = [[UILabel alloc] initWithFrame:CGRectMake(20, lineOnePayLab.frame.origin.y + lineOnePayLab.frame.size.height, 55, 45)];
    lineTwoChargeLab.text = @"手续费";
    lineTwoChargeLab.textColor = THEME_COLOR_SMOKE;
    lineTwoChargeLab.textAlignment = NSTextAlignmentCenter;
    lineTwoChargeLab.backgroundColor = [UIColor clearColor];
    lineTwoChargeLab.font = [UIFont fontWithName:FONTNAME size:THEME_FONT_SMALL];
    [self.handleView addSubview:lineTwoChargeLab];
    
    //第二行 “考拉币”Lab
    UILabel * lineTwoKoalaCoinLab = [[UILabel alloc] initWithFrame:CGRectMake(self.handleView.frame.size.width - 20 - [self cacluteWidth] - 20 - 40 - 25, lineOnePayLab.frame.origin.y + lineOnePayLab.frame.size.height, 55, 45)];
    lineTwoKoalaCoinLab.text = @"考拉币";
    lineTwoKoalaCoinLab.textColor = THEME_COLOR_SMOKE;
    lineTwoKoalaCoinLab.backgroundColor = [UIColor clearColor];
    lineTwoKoalaCoinLab.textAlignment = NSTextAlignmentRight;
    lineTwoKoalaCoinLab.font = [UIFont fontWithName:FONTNAME size:THEME_FONT_SMALL];
    [self.handleView addSubview:lineTwoKoalaCoinLab];
    
    //第二行 考拉币图标
    UIImageView * img = [[UIImageView alloc] initWithFrame:CGRectMake(self.handleView.frame.size.width - 20 - [self cacluteWidth] - 25, lineOnePayLab.frame.origin.y + lineOnePayLab.frame.size.height + 13, 20, 20)];
    img.image = [UIImage imageNamed:@"KLB_small"];
    img.backgroundColor = [UIColor clearColor];
    [self.handleView addSubview:img];
    
    //第二行 考拉币金额
    UILabel *koalaCoinLab = [[UILabel alloc] initWithFrame:CGRectMake(self.handleView.frame.size.width - 20 - [self cacluteWidth], lineOnePayLab.frame.origin.y + lineOnePayLab.frame.size.height, [self cacluteWidth], 45)];
    koalaCoinLab.text = [NSString stringWithFormat:@"%@",self.handlingFee];
    koalaCoinLab.font = [UIFont fontWithName:FONTNAME size:18];
    koalaCoinLab.backgroundColor = [UIColor clearColor];
    koalaCoinLab.textColor = UIColorFromRGB(0x8ACF1C);
    koalaCoinLab.textAlignment = NSTextAlignmentRight;
    [self.handleView addSubview:koalaCoinLab];
    
    [koalaCoinLab sizeToFit];
    CGRect frame = koalaCoinLab.frame;
    frame.origin.x = self.handleView.frame.size.width - 20 - frame.size.width;
    frame.origin.y = lineTwoKoalaCoinLab.center.y - frame.size.height / 2.0f;
    koalaCoinLab.frame = frame;
    
    //第三行 提示信息
    UILabel * lineThreeInfoLab = [[UILabel alloc] initWithFrame:CGRectMake(20, lineTwoKoalaCoinLab.frame.origin.y + lineTwoKoalaCoinLab.frame.size.height, self.handleView.frame.size.width - 20 * 2, 40)];
    lineThreeInfoLab.text = @"请输入支付密码（原钱包提现密码）";
    lineThreeInfoLab.textColor = THEME_COLOR_SMOKE;
    lineThreeInfoLab.textAlignment = NSTextAlignmentLeft;
    lineThreeInfoLab.backgroundColor = [UIColor clearColor];
    lineThreeInfoLab.font = [UIFont fontWithName:FONTNAME size:THEME_FONT_SMALL];
    lineThreeInfoLab.adjustsFontSizeToFitWidth = YES;
    [self.handleView addSubview:lineThreeInfoLab];
    
    //密码框 图片
    for (int i = 0; i < 6; i++)
    {
        float width = (self.handleView.frame.size.width - 2 * 20)/7.0f;
        UIImageView *imgV = [[UIImageView alloc] initWithFrame:CGRectMake(20 + width/5.0 * 6.0f * i, lineThreeInfoLab.frame.origin.y + lineThreeInfoLab.frame.size.height, width, width)];
        imgV.backgroundColor = [UIColor whiteColor];
        imgV.image = [UIImage imageNamed:@"passwordBlock"];
        imgV.tag = 111 + i;
        [self.handleView addSubview:imgV];
    }
    
    //最下方按钮
    for (int i = 0; i < 2; i++)
    {
        float width = (self.handleView.frame.size.width - 2 * 20 - 13)/2.0f;
        UIButton *btnConfirm = [UIButton buttonWithType:UIButtonTypeCustom];
        [btnConfirm setFrame:CGRectMake(20 + (width + 13)* i, self.handleView.frame.size.height - 55, width, 40)];
        if (i == 0)
        {
            [btnConfirm setTitle:@"取消" forState:UIControlStateNormal];
            [btnConfirm setTitleColor:THEME_COLOR_SMOKE forState:UIControlStateNormal];
            [btnConfirm setBackgroundImage:[HWCustomAlertView imageWithColor:UIColorFromRGB(0xf7f7f7) andSize:CGSizeMake(self.handleView.frame.size.width - 2 * 20 - 10, 40)] forState:UIControlStateNormal];
        }
        else if (i == 1)
        {
            [btnConfirm setTitle:@"确认支付" forState:UIControlStateNormal];
            [btnConfirm setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
            [btnConfirm setBackgroundImage:[HWCustomAlertView imageWithColor:THEME_COLOR_ORANGE andSize:CGSizeMake(self.handleView.frame.size.width - 2 * 20 - 10, 40)] forState:UIControlStateNormal];
        }
        btnConfirm.layer.borderColor = THEME_COLOR_LINE.CGColor;
        btnConfirm.layer.borderWidth = 0.5f;
        btnConfirm.tag = 202 + i;
        btnConfirm.layer.cornerRadius = 5;
        btnConfirm.layer.masksToBounds = YES;
        btnConfirm.titleLabel.font = [UIFont fontWithName:FONTNAME size:THEME_FONT_SMALL];
        [btnConfirm addTarget:self action:@selector(btnClick:) forControlEvents:UIControlEventTouchUpInside];
        [self.handleView addSubview:btnConfirm];
    }
    
    //隐藏的文本框
    secretTV = [[UITextView alloc] initWithFrame:CGRectMake(0, 0, 100, 100)];
    secretTV.hidden = YES;
    secretTV.delegate = self;
    secretTV.keyboardType = UIKeyboardTypeNumberPad;
    secretTV.tag = 555;
    [secretTV becomeFirstResponder];
    [self.handleView addSubview:secretTV];
}
- (void)addTouchIDBtn
{
    UIButton *btnConfirm = [UIButton buttonWithType:UIButtonTypeCustom];
    [btnConfirm setFrame:CGRectMake(kScreenWidth - 80 - 30, 20, 80, 40)];
    [btnConfirm setTitle:@"TouchID" forState:UIControlStateNormal];
    [btnConfirm setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [btnConfirm setBackgroundImage:[HWCustomAlertView imageWithColor:THEME_COLOR_ORANGE andSize:CGSizeMake(self.handleView.frame.size.width - 2 * 20 - 10, 40)] forState:UIControlStateNormal];
    btnConfirm.layer.borderColor = THEME_COLOR_LINE.CGColor;
    btnConfirm.layer.borderWidth = 0.5f;
    btnConfirm.tag = 204;
    btnConfirm.layer.cornerRadius = 5;
    btnConfirm.layer.masksToBounds = YES;
    [btnConfirm addTarget:self action:@selector(touchIDClick) forControlEvents:UIControlEventTouchUpInside];
    [self.handleView addSubview:btnConfirm];
}

- (void)touchIDClick {//touchID验证
    // 初始化验证上下文
    LAContext *context = [[LAContext alloc] init];
    NSError *error = nil;
    // 验证的原因, 应该会显示在会话窗中
    NSString *reason = @"考拉币余额支付确认";
    // 判断是否能够进行验证
    if ([context canEvaluatePolicy:LAPolicyDeviceOwnerAuthenticationWithBiometrics error:&error]) {
        [context evaluatePolicy:LAPolicyDeviceOwnerAuthenticationWithBiometrics localizedReason:reason reply:^(BOOL succes, NSError *error)
        {
            if (succes)
            {
                if (self.delegate && [self.delegate respondsToSelector:@selector(alertView:secretStr:)])
                {
                    [self.delegate alertView:self secretStr:self.secretStr];
                }
            }
        }];
    }
    else
    {
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"提示" message:@"您的设备不支持TouchID" delegate:nil cancelButtonTitle:@"确定" otherButtonTitles: nil];
        [alert performSelectorOnMainThread:@selector(show) withObject:nil waitUntilDone:YES];
    }
}

- (CGFloat)cacluteWidth
{
    return [HWCustomAlertView calculateStringHeight:[NSString stringWithFormat:@"%@",self.handlingFee] font:[UIFont fontWithName:FONTNAME size:18] constrainedSize:CGSizeMake(1000, 45)].width;
}

- (void)show
{
    if (self.isShowing == NO)
    {
        [super show];
    }
    self.isShowing = YES;
}
@end
