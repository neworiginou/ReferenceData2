//
//  HWHouseTaxCalculatorVC.m
//  CalculatorDemo
//
//  Created by wuxiaohong on 15/4/7.
//  Copyright (c) 2015年 hw. All rights reserved.
//

#import "HWHouseTaxCalculatorVC.h"
#import "CalculatorTableViewCell.h"
@interface HWHouseTaxCalculatorVC ()

@end

@implementation HWHouseTaxCalculatorVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.navigationItem.title = @"税费计算器";
    self.view.backgroundColor =  THEME_COLOR_BACKGROUND_1;
    self.navigationItem.leftBarButtonItem = [Utility navLeftBackBtn:self action:@selector(backBtn)];
    _calculatorArry = [NSArray arrayWithObjects:@"单价",@"面积",@"首套房",nil];
    _resultArry =[NSArray arrayWithObjects:@"契税",@"印花税",@"公证费",@"房屋买卖手续费",nil];
    _bigScrollView = [[UIScrollView alloc] init];
    [_bigScrollView setFrame:CGRectMake(0, 0, kScreenWidth, CONTENT_HEIGHT)];
    [_bigScrollView setContentSize:CGSizeMake(kScreenWidth, CONTENT_HEIGHT + 2)];
    _bigScrollView.scrollEnabled = YES;
    _bigScrollView.delegate = self;
    [self.view addSubview:_bigScrollView];
    [self createTable];

}
-(void)createTable
{
    UIView * headView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, kScreenWidth, 10)];
    headView.backgroundColor =THEME_COLOR_BACKGROUND_1;
    _calculatorTab = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, kScreenWidth, 130)];
    _calculatorTab.delegate = self;
    _calculatorTab.dataSource = self;
    _calculatorTab.tableHeaderView = headView;
    //_calculatorTab.separatorStyle = UITableViewStylePlain;
    //[_calculatorTab.tableHeaderView drawTopLine];
    [_bigScrollView addSubview:_calculatorTab];
    
    //计算按钮
    _countButton = [UIButton buttonWithType:UIButtonTypeCustom];
    _countButton.frame = CGRectMake(10, CGRectGetMaxY(_calculatorTab.frame)+10, kScreenWidth - 20, 40);
    //    [_countButton setButtonBackgroundShadowHighlight];
    [_countButton setButtonRedAndOrangeBorderStyle];
    [_countButton setTitle:@"计算" forState:UIControlStateNormal];
    [_countButton addTarget:self action:@selector(countBtn:) forControlEvents:UIControlEventTouchUpInside];
    [_bigScrollView addSubview:_countButton];
    
    
    UILabel *resultLabel = [[UILabel alloc] initWithFrame:CGRectMake(10, _countButton.frame.origin.y + _countButton.frame.size.height + 10, 100, 20)];
    [resultLabel setBackgroundColor:[UIColor clearColor]];
    [resultLabel setText:@"计算结果"];
    [resultLabel setFont:[UIFont fontWithName:FONTNAME size:14]];
    [_bigScrollView addSubview:resultLabel];


    _resultTab = [[UITableView alloc]initWithFrame:CGRectMake(0, CGRectGetMaxY(resultLabel.frame)+10, kScreenWidth, 120)];
    _resultTab.delegate = self;
    _resultTab.dataSource = self;
    _resultTab.separatorStyle = UITableViewStylePlain;
    //[_calculatorTab.tableHeaderView drawTopLine];
    [_bigScrollView addSubview:_resultTab];

}
-(void)backBtn
{
    [self.navigationController popViewControllerAnimated:YES];
}
#pragma mark 表的代理
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (tableView==_calculatorTab) {
        return 3;
    }
    if (tableView == _resultTab) {
        return 4;
    }
    return 0;
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (tableView == _calculatorTab)
    {
        
    
    CalculatorTableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:@"cell"];

    if (!cell)
    {
        cell = [[CalculatorTableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"cell"];
        cell.textLabel.text = _calculatorArry[indexPath.row];
        cell.textLabel.font = [UIFont fontWithName:FONTNAME size:THEME_FONT_SMALL];
        
        NSArray * arr = [NSArray arrayWithObjects:@"元/m²",@"m²",nil];
        UILabel *rightLabel = [[UILabel alloc] init];
        [rightLabel setFont:[UIFont fontWithName:FONTNAME size:THEME_FONT_SMALL]];
        [cell.contentView addSubview:rightLabel];
       

        if (indexPath.row == 0)
        {
            self.priceTextField = cell.textFiled;
            cell.textFiled.placeholder = @"请输入单价";
            rightLabel.frame = CGRectMake(kScreenWidth - 38-15, 5, 40, 30);
            [rightLabel setText:arr[0]];
            
        }
        if (indexPath.row == 1)
        {
            self.areaTextField = cell.textFiled;
            cell.textFiled.placeholder = @"请输入面积";
            rightLabel.frame = CGRectMake(kScreenWidth -20-15, 5, 20, 30);
            [rightLabel setText:arr[1]];
        }
       
        if (indexPath.row == 2)
        {
            UIImageView *arrowImg = [[UIImageView alloc] initWithFrame:CGRectMake(kScreenWidth - 10-15,13, 10, 14)];
            [arrowImg setImage:[UIImage imageNamed:@"arrow_next"]];
            [cell.contentView addSubview:arrowImg];
            cell.textFiled.hidden = YES;
            UIButton * btn  = [UIButton buttonWithType:UIButtonTypeCustom];
            btn.frame = CGRectMake(80, 0, 80, 40);
            [btn setTitle:@"是" forState:UIControlStateNormal];
            isDianJi = YES;
            [btn setTitleColor:THEME_COLOR_BACKGROUND_1 forState:UIControlStateNormal];
            btn.titleLabel.font = [UIFont fontWithName:FONTNAME size:THEME_FONT_SMALL];
            [btn addTarget:self action:@selector(changeBtn:) forControlEvents:UIControlEventTouchUpInside];
            [cell.contentView addSubview:btn];
            
            
            
        }

      //  [cell drawButtomLine];
    }
    return cell;
        
    }
    
    else
    {
        UITableViewCell * cell  = [tableView dequeueReusableCellWithIdentifier:@"cell"];
        if (!cell)
        {
            cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"cell"];
        }
        
          NSArray *bottomArr = [[NSArray alloc] initWithObjects:@"契税：",@"印花税：",@"公证费：",@"房屋买卖水续费：", nil];
        cell.textLabel.text = bottomArr[indexPath.row];
        cell.textLabel.font =[UIFont fontWithName:FONTNAME size:THEME_FONT_SMALL];
        if (indexPath.row == 0)
        {
            _deedTaxLabel = [[UILabel alloc]initWithFrame:CGRectMake(50, 0, 100, 30)];
            _deedTaxLabel.textColor = THEME_COLOR_RED_NORMAL;
            _deedTaxLabel.font = [UIFont fontWithName:FONTNAME size:THEME_FONT_SMALL];
            [cell.contentView addSubview:_deedTaxLabel];
        }
        if (indexPath.row == 1)
        {
            _stampDutyLabel = [[UILabel alloc]initWithFrame:CGRectMake(65, 0, 100, 30)];
            _stampDutyLabel.textColor = THEME_COLOR_RED_NORMAL;

            _stampDutyLabel.font = [UIFont fontWithName:FONTNAME size:THEME_FONT_SMALL];
            [cell.contentView addSubview:_stampDutyLabel];
        }
        if (indexPath.row == 2)
        {
            _notarialFeesLabel = [[UILabel alloc]initWithFrame:CGRectMake(65, 0, 100, 30)];
            _notarialFeesLabel.textColor = THEME_COLOR_RED_NORMAL;

            _notarialFeesLabel.font = [UIFont fontWithName:FONTNAME size:THEME_FONT_SMALL];
            [cell.contentView addSubview:_notarialFeesLabel];
        }
        if (indexPath.row == 3)
        {
            _saleHouseTaxLabel = [[UILabel alloc]initWithFrame:CGRectMake(120, 0, 100, 30)];
            _saleHouseTaxLabel.font = [UIFont fontWithName:FONTNAME size:THEME_FONT_SMALL];
        
            _saleHouseTaxLabel.textColor = THEME_COLOR_RED_NORMAL;

            [cell.contentView addSubview:_saleHouseTaxLabel];
        }

        return cell;
    }
    
    return nil;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (tableView == _calculatorTab) {
        return 40;
    }
    if (tableView == _resultTab) {
        return 30;
    }
    return 0;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}

-(void)changeBtn:(UIButton *)sender
{
    UIButton * btn = (UIButton * )sender;
     isDianJi = !isDianJi;
    if (isDianJi == NO)
    {
        [btn setTitle:@"否" forState:UIControlStateNormal];
        
    }
    else
    {
        [btn setTitle:@"是" forState:UIControlStateNormal];
        
    }
   
    
}
-(void)countBtn:(UIButton *)sender
{
    
      if ([_priceTextField.text isEqualToString:@""] || [_areaTextField.text isEqualToString:@""]) {//添加其他可能情况
        
        [Utility showToastWithMessage:@"请输入正确信息" inView:self.view];
    }
    else
    {
        [self calculationTaxesAndFees];
    }

}
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
    
    if (isDianJi == NO) {
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
- (void)refreshViewDeedTax:(float)deedTax stampDuty:(float)stampDuty notarialFees:(float)notarialFees saleHouse:(float)saleHouse
{
    _deedTaxLabel.text = @"";
    _stampDutyLabel.text = @"";
    _notarialFeesLabel.text = @"";
    _saleHouseTaxLabel.text = @"";
    

    
    _deedTaxLabel.text = [NSString stringWithFormat:@"%.2f元",deedTax];
  
    _stampDutyLabel.text = [NSString stringWithFormat:@"%.2f元",stampDuty];
    _notarialFeesLabel.text = [NSString stringWithFormat:@"%.2f元",notarialFees];
    _saleHouseTaxLabel.text = [NSString stringWithFormat:@"%.2f元",saleHouse];
   // [_resultTab reloadData];
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

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
