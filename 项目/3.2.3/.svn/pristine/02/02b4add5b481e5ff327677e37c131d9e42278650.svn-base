//
//  HWHouseTaxCalculatorViewController.m
//  HaoWuAgenciesEdition
//
//  Created by lizhongqiang on 14-7-4.
//  Copyright (c) 2014年 好屋中国. All rights reserved.
//
//  功能描述：房屋税费计算器，输入单价和面积，计算出结果并显示
//  修改记录：
//      李中强 2014-07-22 15:28:15 添加注释
//
//
//

#import "HWHouseTaxCalculatorViewController.h"
#import "Define-OC.h"
#import "Partner_Swift-Swift.h"

@interface HWHouseTaxCalculatorViewController ()
{
    BOOL firstHouse;        //首套房
}
@end

@implementation HWHouseTaxCalculatorViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor colorWithRed:245./255. green:245./255. blue:245./255. alpha:1.0f];
    
    firstHouse = YES;
    self.navigationItem.titleView = [Utility navTitleView:@"税费计算器"];
    self.navigationItem.leftBarButtonItem = [Utility navLeftBackBtn:self _selector:@selector(backBtn:)];
    
    
    _bigScrollView = [[UIScrollView alloc] init];
    [_bigScrollView setFrame:CGRectMake(0, 0, kScreenWidth, CONTENT_HEIGHT)];
    [_bigScrollView setContentSize:CGSizeMake(kScreenWidth, CONTENT_HEIGHT + 2)];
    _bigScrollView.scrollEnabled = YES;
    _bigScrollView.delegate = self;
    [self.view addSubview:_bigScrollView];
    
    UIView *topView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, 152)];
    [topView setBackgroundColor:[UIColor whiteColor]];
    [_bigScrollView addSubview:topView];
    
    
    for (int i = 0; i < 4; i ++)
    {
        UIView *line = [[UIView alloc] init];
        if (i == 0 || i == 3)
            line.frame = CGRectMake(0, 50.5 * i, kScreenWidth, 0.5);
        else
            line.frame = CGRectMake(10, 50.5 * i, kScreenWidth - 20, 0.5);
            
        [line setBackgroundColor:CD_LineColor];
        [topView addSubview:line];
    }
    
    NSArray *topLeftArr = [[NSArray alloc] initWithObjects:@"单价",@"面积",@"首套房", nil];
    for (int i = 0; i < topLeftArr.count; i ++)
    {
        UILabel *leftLabel = [[UILabel alloc] initWithFrame:CGRectMake(10, 10 + 50 * i, 100, 30)];
        [leftLabel setBackgroundColor:[UIColor clearColor]];
        [leftLabel setText:topLeftArr[i]];
        [leftLabel setFont:[UIFont fontWithName:FONTNAME size:14]];
        [topView addSubview:leftLabel];
    }
    
    _priceTextField = [[UITextField alloc] initWithFrame:CGRectMake(100, 5, kScreenWidth - 150, 40)];
    _priceTextField.placeholder = @"请输入单价";
    _priceTextField.font = [UIFont fontWithName:FONTNAME size:14];
    [topView addSubview:_priceTextField];
    
    _areaTextField = [[UITextField alloc] initWithFrame:CGRectMake(100, 5 + 50, kScreenWidth - 150, 40)];
    _areaTextField.placeholder = @"请输入面积";
    _areaTextField.font = [UIFont fontWithName:FONTNAME size:14];
    [topView addSubview:_areaTextField];
    
    NSArray *topRightArr = [[NSArray alloc] initWithObjects:@"元/m²",@"m²", nil];
    for (int i = 0; i < topRightArr.count; i ++)
    {
        UILabel *rightLabel = [[UILabel alloc] initWithFrame:CGRectMake(kScreenWidth - 100, 10 + 50 * i, 80, 30)];
        [rightLabel setBackgroundColor:[UIColor clearColor]];
        [rightLabel setText:topRightArr[i]];
        [rightLabel setTextAlignment:NSTextAlignmentRight];
        [rightLabel setFont:[UIFont fontWithName:FONTNAME size:14]];
        [topView addSubview:rightLabel];
    }
    
    _firstHouseBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    _firstHouseBtn.frame = CGRectMake(100, 5 + 100, kScreenWidth - 150, 40);
    _firstHouseBtn.backgroundColor = [UIColor clearColor];
    [_firstHouseBtn setTitle:@"是" forState:UIControlStateNormal];
    [_firstHouseBtn.titleLabel setFont:[UIFont fontWithName:FONTNAME size:14]];
    [_firstHouseBtn.titleLabel setTextAlignment:NSTextAlignmentLeft];
    [_firstHouseBtn setTitleEdgeInsets:UIEdgeInsetsMake(0, 0, 0, kScreenWidth - 170)];
    [_firstHouseBtn setTitleColor:TITLE_COLOR_99 forState:UIControlStateNormal];
    [_firstHouseBtn addTarget:self action:@selector(isFirstHouse:) forControlEvents:UIControlEventTouchUpInside];
    [topView addSubview:_firstHouseBtn];
    
    //arrow_next 16 28
    UIImageView *arrowImg = [[UIImageView alloc] initWithFrame:CGRectMake(kScreenWidth - 30, 120, 8, 14)];
    [arrowImg setImage:[UIImage imageNamed:@"arrow_next"]];
    [topView addSubview:arrowImg];
    
    _countButton = [UIButton buttonWithType:UIButtonTypeCustom];
    _countButton.frame = CGRectMake(10, 170, kScreenWidth - 20, 40);
//    [_countButton setButtonBackgroundShadowHighlight];
    [_countButton setButtonRedAndOrangeBorderStyle];
    [_countButton setTitle:@"计算" forState:UIControlStateNormal];
    [_countButton addTarget:self action:@selector(calculationTaxesAndFees) forControlEvents:UIControlEventTouchUpInside];
    [_bigScrollView addSubview:_countButton];
    
    UILabel *resultLabel = [[UILabel alloc] initWithFrame:CGRectMake(10, _countButton.frame.origin.y + _countButton.frame.size.height + 10, 100, 20)];
    [resultLabel setBackgroundColor:[UIColor clearColor]];
    [resultLabel setText:@"计算结果"];
    [resultLabel setFont:[UIFont fontWithName:FONTNAME size:14]];
    [_bigScrollView addSubview:resultLabel];
    
    UIView *bottomView = [[UIView alloc] initWithFrame:CGRectMake(0, resultLabel.frame.origin.y + resultLabel.frame.size.height + 10, kScreenWidth, 118)];
    [bottomView setBackgroundColor:[UIColor whiteColor]];
    [_bigScrollView addSubview:bottomView];
    
    for (int i = 0; i < 2; i ++)
    {
        UIView *line = [[UIView alloc] initWithFrame:CGRectMake(0, 118 * i, kScreenWidth, 0.5)];
        [line setBackgroundColor:CD_LineColor];
        [bottomView addSubview:line];
    }
    
    NSArray *bottomArr = [[NSArray alloc] initWithObjects:@"契税：",@"印花税：",@"公证费：",@"房屋买卖水续费：", nil];
    for (int i = 0; i < bottomArr.count; i ++)
    {
        UILabel *leftLabel = [[UILabel alloc] initWithFrame:CGRectMake(10, 15 + 25 * i, 200, 20)];
        [leftLabel setBackgroundColor:[UIColor clearColor]];
        [leftLabel setText:bottomArr[i]];
        [leftLabel setTextColor:TITLE_COLOR_33];
        [leftLabel setFont:[UIFont fontWithName:FONTNAME size:14]];
        [bottomView addSubview:leftLabel];
        [leftLabel sizeToFit];
    }
    
    _deedTaxLabel = [[UILabel alloc] init];
    [bottomView addSubview:_deedTaxLabel];
    
    _stampDutyLabel = [[UILabel alloc] init];
    [bottomView addSubview:_stampDutyLabel];
    
    _notarialFeesLabel = [[UILabel alloc] init];
    [bottomView addSubview:_notarialFeesLabel];
    
    _saleHouseTaxLabel = [[UILabel alloc] init];
    [bottomView addSubview:_saleHouseTaxLabel];
    
    _deedYuan = [[UILabel alloc] init];
    _deedYuan.text = @"元";
    [bottomView addSubview:_deedYuan];
    
    _stampYuan = [[UILabel alloc] init];
    _stampYuan.text = @"元";
    [bottomView addSubview:_stampYuan];
    
    _notarialYuan = [[UILabel alloc] init];
    _notarialYuan.text = @"元";
    [bottomView addSubview:_notarialYuan];
    
    _saleYuan = [[UILabel alloc] init];
    _saleYuan.text = @"元";
    [bottomView addSubview:_saleYuan];
    
    _priceTextField.delegate = self;
    _areaTextField.delegate = self;
    
    [self defaultSetting];
}
/***************************
 函数名：- (void)defaultSetting
 功能描述：设置label字体颜色
 输入参数：N/A
 输出参数：N/A
 备注：N/A
 **************************/
- (void)defaultSetting
{
    UIFont *font = [UIFont fontWithName:FONTNAME size:13];
    UIFont *fontLeft = [UIFont fontWithName:FONTNAME size:14];
    UIColor *color = UIColorFromRGB(0x666666);
    UIColor *colorRed = UIColorFromRGB(0xff6600);
    
    _deedLeft.font = fontLeft;
    _stampLeft.font = fontLeft;
    _notarialLeft.font = fontLeft;
    _saleLeft.font = fontLeft;
    
    _deedYuan.hidden = YES;
    _deedYuan.font = font;
    _deedYuan.textColor = color;
    _stampYuan.hidden = YES;
    _stampYuan.font = font;
    _stampYuan.textColor = color;
    _notarialYuan.hidden = YES;
    _notarialYuan.font = font;
    _notarialYuan.textColor = color;
    _saleYuan.hidden = YES;
    _saleYuan.font = font;
    _saleYuan.textColor = color;
    
    _deedTaxLabel.font = font;
    _deedTaxLabel.textColor = colorRed;
    _stampDutyLabel.font = font;
    _stampDutyLabel.textColor = colorRed;
    _notarialFeesLabel.font = font;
    _notarialFeesLabel.textColor = colorRed;
    _saleHouseTaxLabel.font = font;
    _saleHouseTaxLabel.textColor = colorRed;
}
/***************************
 函数名：- (void)backBtn:(id)sender
 功能描述：返回上一页
 输入参数：N/A
 输出参数：N/A
 备注：N/A
 **************************/
- (void)backBtn:(id)sender
{
    [self.navigationController popViewControllerAnimated:YES];
}

- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string
{
    //限制长度
    if (range.location >= 12) {
        return NO;
    }
    //限制小数点
    NSMutableString * futureString = [NSMutableString stringWithString:textField.text];
    if ([string isEqualToString:@""])//减
    {
        [futureString deleteCharactersInRange:range];
    }
    else//加
    {
        [futureString  insertString:string atIndex:range.location];
    }
    
    
    NSUInteger num = 0;
    for (int i = 0; i< futureString.length; i++) {
        unichar c = [futureString characterAtIndex:i];
        
        if (c == '.') {
            if (i == 0) {
                return NO;//第一次输入即为 .
            }
            num++;
            if (num > 1) {//输入超过1个 .
                return NO;
            }
        }
    }
    
    //只能输入两位小数
    NSInteger flag = 0;
    const NSInteger limited = 2;
    for (int i = futureString.length-1; i >= 0; i--) {
        if ([futureString characterAtIndex:i] == '.') {
            
            if (flag > limited)
            {
                return NO;
            }
            break;
        }
        flag++;
    }
    return YES;
    
}


/***************************
 函数名：- (IBAction)countBtn:(id)sender
 功能描述：点击计算按钮
 输入参数：N/A
 输出参数：N/A
 备注：N/A
 **************************/
- (IBAction)countBtn:(id)sender
{
    
    if ([_priceTextField.text isEqualToString:@""] || [_areaTextField.text isEqualToString:@""]) {//添加其他可能情况
        [Utility showToastWithMessage:@"请输入正确信息" _view:self.view];
    }
    else
    {
        [self calculationTaxesAndFees];
    }

}
/***************************
 函数名：- (IBAction)isFirstHouse:(id)sender
 功能描述：选择是否首套房
 输入参数：N/A
 输出参数：N/A
 备注：N/A
 **************************/
- (IBAction)isFirstHouse:(id)sender
{
    if (firstHouse) {
        [_firstHouseBtn setTitle:@"否" forState:UIControlStateNormal];
        firstHouse = NO;
    }else{
        [_firstHouseBtn setTitle:@"是" forState:UIControlStateNormal];
        firstHouse = YES;
    }
}

/***************************
 函数名：- (float)notarialFees50:(float)price
 功能描述：50W以下 公证费计算
 输入参数：float price
 输出参数：float
 备注：N/A
 **************************/
- (float)notarialFees50:(float)price
{
    float notarialFees = 0;
    notarialFees = price * 0.003;
    if (notarialFees <= 200) {
        notarialFees = 200;
    }
    return notarialFees;
}

/***************************
 函数名：- (float)notarialFees500:(float)price
 功能描述：50W————500W   公证费计算
 输入参数：float price
 输出参数：float
 备注：N/A
 **************************/
- (float)notarialFees500:(float)price
{
    return price * 0.0025;
}

/***************************
 函数名：- (float)notarialFees1000:(float)price
 功能描述：500W————1000W 公证费计算
 输入参数：float price
 输出参数：float
 备注：N/A
 **************************/
- (float)notarialFees1000:(float)price
{
    return price * 0.002;
}

/***************************
 函数名：- (float)notarialFees2000:(float)price
 功能描述：1000W————2000W    公证费计算
 输入参数：float price
 输出参数：float
 备注：N/A
 **************************/
- (float)notarialFees2000:(float)price
{
    return price * 0.0015;
}

/***************************
 函数名：- (float)notarialFees5000:(float)price
 功能描述：2000W————5000W    公证费计算
 输入参数：float price
 输出参数：float
 备注：N/A
 **************************/
- (float)notarialFees5000:(float)price
{
    return price * 0.001;
}

/***************************
 函数名：- (float)notarialFees100000:(float)price
 功能描述：5000W————10000W   公证费计算
 输入参数：float price
 输出参数：float
 备注：N/A
 **************************/
- (float)notarialFees100000:(float)price
{
    return price * 0.0005;
}

/***************************
 函数名：- (float)notarialFeesMax:(float)price
 功能描述：10000W以上  公证费计算
 输入参数：float price
 输出参数：float
 备注：N/A
 **************************/
- (float)notarialFeesMax:(float)price
{
    return price * 0.0001;
}

/***************************
 函数名：- (void)calculationTaxesAndFees
 功能描述：计算税费
 输入参数：N/A
 输出参数：N/A
 备注：N/A
 **************************/
- (void)calculationTaxesAndFees
{
    [_priceTextField resignFirstResponder];
    [_areaTextField resignFirstResponder];
    
    //房屋总价
    float countPrice = [_priceTextField.text floatValue] * [_areaTextField.text floatValue];
    //印花税
    float stampDuty = countPrice * 0.05/100;
    //买卖房屋手续费
    float saleHouse = [_areaTextField.text floatValue] * 3;
    //公证费
    float notarialFees = 0;
    
    if (countPrice <= 500000)
    {
        notarialFees = [self notarialFees50:countPrice];
    }
    else if (countPrice > 500000 && countPrice <= 5000000)
    {
        notarialFees = [self notarialFees50:500000] + [self notarialFees500:countPrice-500000];
    }
    else if (countPrice > 5000000 && countPrice <= 10000000)
    {
        notarialFees = [self notarialFees50:500000] + [self notarialFees500:5000000 - 500000] + [self notarialFees1000:countPrice - 5000000];
    }
    else if (countPrice > 10000000 && countPrice <= 20000000)
    {
        notarialFees = [self notarialFees50:500000] + [self notarialFees500:5000000 - 500000] + [self notarialFees1000:10000000 - 5000000] + [self notarialFees2000:countPrice - 10000000];
    }
    else if (countPrice >20000000 && countPrice <= 50000000)
    {
        notarialFees = [self notarialFees50:500000] + [self notarialFees500:5000000 - 500000] + [self notarialFees1000:10000000 - 5000000] + [self notarialFees2000:20000000 - 10000000] + [self notarialFees5000:countPrice - 20000000];
    }
    else if (countPrice > 50000000 && countPrice <= 100000000)
    {
        notarialFees = [self notarialFees50:500000] + [self notarialFees500:5000000 - 500000] + [self notarialFees1000:10000000 - 5000000] + [self notarialFees2000:20000000 - 10000000] + [self notarialFees5000:50000000 - 20000000] + [self notarialFees100000:countPrice - 50000000];
    }
    else if (countPrice > 100000000)
    {
        notarialFees = [self notarialFees50:500000] + [self notarialFees500:5000000 - 500000] + [self notarialFees1000:10000000 - 5000000] + [self notarialFees2000:20000000 - 10000000] + [self notarialFees5000:50000000 - 20000000] + [self notarialFees100000:100000000 - 50000000] + [self notarialFeesMax:countPrice - 100000000];
    }
    //契税
    float area = [_areaTextField.text floatValue];
    float deedTax;
    
    if (firstHouse == NO) {
        deedTax = countPrice * 0.03;
    }else{
        if (area <= 90) {
            deedTax = countPrice * 0.01;
        }else if (area > 90 && area <= 144){
            deedTax = countPrice * 0.015;
        }else if (area > 144){
            deedTax = countPrice * 0.03;
        }
    }
    
    
    [self refreshViewDeedTax:deedTax stampDuty:stampDuty notarialFees:notarialFees saleHouse:saleHouse];
}


/***************************
 函数名：- (void)refreshViewDeedTax:(float)deedTax stampDuty:(float)stampDuty notarialFees:(float)notarialFees saleHouse:(float)saleHouse
 功能描述：用计算结果 刷新界面
 输入参数：float deedTax     契税
         float  stampDuty   印花税
         float  notarialFees    公证费
         float  saleHouse       房屋买卖手续费
 输出参数：N/A
 备注：N/A
 **************************/
- (void)refreshViewDeedTax:(float)deedTax stampDuty:(float)stampDuty notarialFees:(float)notarialFees saleHouse:(float)saleHouse
{
    //更新界面
    _deedTaxLabel.text = [NSString stringWithFormat:@"%.2f",deedTax];
    _stampDutyLabel.text = [NSString stringWithFormat:@"%.2f",stampDuty];
    _notarialFeesLabel.text = [NSString stringWithFormat:@"%.2f",notarialFees];
    _saleHouseTaxLabel.text = [NSString stringWithFormat:@"%.2f",saleHouse];
    //宽度
    _deedYuan.hidden = NO;
    _stampYuan.hidden = NO;
    _notarialYuan.hidden = NO;
    _saleYuan.hidden = NO;
    
    CGSize deedSize = [self getLabelMaxWidth:_deedTaxLabel];
    [_deedTaxLabel setFrame:CGRectMake(53, 12, deedSize.width, 21)];
    [_deedYuan setFrame:CGRectMake(CGRectGetMaxX(_deedTaxLabel.frame) + 3, 12, 60, 21)];
    
    CGSize stampSize = [self getLabelMaxWidth:_stampDutyLabel];
    [_stampDutyLabel setFrame:CGRectMake(65, 37, stampSize.width, 21)];
    [_stampYuan setFrame:CGRectMake(CGRectGetMaxX(_stampDutyLabel.frame) + 3, 37, 60, 21)];
    
    CGSize notarialSize = [self getLabelMaxWidth:_notarialFeesLabel];
    [_notarialFeesLabel setFrame:CGRectMake(65, 62, notarialSize.width, 21)];
    [_notarialYuan setFrame:CGRectMake(CGRectGetMaxX(_notarialFeesLabel.frame) + 3, 62, 60, 21)];
    
    CGSize saleSize = [self getLabelMaxWidth:_saleHouseTaxLabel];
    [_saleHouseTaxLabel setFrame:CGRectMake(123, 87, saleSize.width, 21)];
    [_saleYuan setFrame:CGRectMake(CGRectGetMaxX(_saleHouseTaxLabel.frame) + 3, 87, 60, 21)];
    
}

/***************************
 函数名：- (CGSize)getLabelMaxWidth:(UILabel *)label
 功能描述：计算label需要的最大的宽度
 输入参数：UILabel *label
 输出参数：CGSize size
 备注：N/A
 **************************/
- (CGSize)getLabelMaxWidth:(UILabel *)label
{
    CGSize size = [label.text sizeWithFont:label.font constrainedToSize:CGSizeMake(CGFLOAT_MAX, 21)];
    return size;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
