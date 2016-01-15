//
//  HWFangeZuHeView.m
//  UtilityDemo
//
//  Created by lizhongqiang on 15/7/6.
//  Copyright (c) 2015年 hw. All rights reserved.
//

#import "HWFangeZuHeView.h"

#import "HWAreaTableViewCell.h"

#import "HWHouseLoanTableViewCell.h"

#import "Define-OC.h"


@interface HWFangeZuHeView ()<UITableViewDataSource,UITableViewDelegate>

@property (nonatomic, strong)UITableView *associationTableView;

@property (nonatomic, strong)NSArray *paymentMethod;

@property (nonatomic, strong)NSArray *anjieYear;

@property (nonatomic, strong)NSArray *rateArray;

@property (nonatomic, strong)UIView *cover;

@property (nonatomic, strong)NSArray *dataArray;

@property (nonatomic, strong)UILabel *gongJiRateLabel;

@property (nonatomic, strong)UILabel *shangRateLabel;

//----------
@property (nonatomic, copy)NSString *gongJiStrl;

@property (nonatomic, copy)NSString *shangYeStrl;

@end

@implementation HWFangeZuHeView

- (instancetype)init
{
    if(self = [super init])
    {
        _associationTableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, kScreenWidth, 330)];
        [self addSubview:_associationTableView];
        _associationTableView.delegate = self;
        _associationTableView.dataSource = self;
        
        for (int i = 0; i < 2; i++) {
            UIView *line = [[UIView alloc] initWithFrame:CGRectMake(0, 0+330*i, kScreenWidth, 0.5)];
            [line setBackgroundColor:[UIColor lightGrayColor]];
            [self addSubview:line];
        }
        
        //添加按钮
        UIButton * shangOneBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        
        shangOneBtn.frame = CGRectMake(10, 370, kScreenWidth - 20, 50);
        
        [shangOneBtn setButtonRedAndOrangeBorderStyle];
        
        [shangOneBtn setTitle:@"计算" forState:UIControlStateNormal];
        
        [shangOneBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        
        [shangOneBtn addTarget:self action:@selector(jiSuanAction:) forControlEvents:UIControlEventTouchUpInside];
        
        [self addSubview:shangOneBtn];
        
        
        UILabel *tempLabel  = [[UILabel alloc]initWithFrame:CGRectMake(10, 340, kScreenWidth - 20, 21)];
        tempLabel.font = [UIFont fontWithName:FONTNAME size:12];
        
        tempLabel.textColor = TITLE_COLOR_99;
        
        tempLabel.text = @"*等额本金还款额逐月减少，等额本息还款每月相同";
        
        tempLabel.textAlignment = NSTextAlignmentCenter;
        
        tempLabel.backgroundColor = [UIColor clearColor];
        
        [self addSubview:tempLabel];
        
        [self initDataArray];
        
        [self initCoverView];
        
        [self initCellSelectedVC];
        
        [self addObservers];
    }
    return self;
}
- (void)addObservers
{
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(gongJiJinDaiKuanE:) name:@"gongJiJinDaiKuanE" object:nil];
    
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(shangYeDaiKuanE:) name:@"shangYeDaiKuanE" object:nil];
}
- (void)dealloc
{
    [[NSNotificationCenter defaultCenter]removeObserver:self];
}

- (void)shangYeDaiKuanE:(NSNotification *)notfication
{
    _shangYeStrl = notfication.object;
}
- (void)gongJiJinDaiKuanE:(NSNotification *)notification
{
    _gongJiStrl = notification.object;
}


- (void)initCellSelectedVC
{
    _cellSelectedVC = [[HWFangZuHeVC alloc]init];
    
    __unsafe_unretained HWFangeZuHeView *weakSelf = self;
    
    _cellSelectedVC.reloadForTableView = ^(void)
    {
        
        [weakSelf.associationTableView reloadData];
    };
}

- (void)initDataArray
{
    _paymentMethod = @[@"等额本息",@"等额本金"];
    
    _anjieYear = @[@"1年(12期)",@"2年(24期)",@"3年(36期)",@"4年(48期)",@"5年(60期)",@"6年(72期)",@"7年(84期)",@"8年(96期)",@"9年(108期)",@"10年(120期)",@"11年(134期)",@"12年(144期)",@"13年(156期)",@"14年(168期)",@"15年(180期)",@"16年(192期)",@"17年(204期)",@"18年(216期)",@"19年(228期)",@"20年(240期)",@"21年(252期)",@"22年(264期)",@"23年(276期)",@"24年(288期)",@"25年(300期)",@"26年(312期)",@"27年(324期)",@"28年(336期)",@"29年(348期)",@"30年(360期)"];
    
    _rateArray = @[@"15年3月1日基准利率",@"15年3月1日利率上限(1.1倍)",@"15年3月1日利率下限(85折)"];
    
    _dataArray = @[@"还款方式",@"公积金贷款",@"商业贷款",@"按揭年数",@"利率"];
    
}

- (void)initCoverView
{
    _cover = [[UIView alloc]init];
    
    _cover.frame = [UIScreen mainScreen].bounds;
    
    [self addSubview:_cover];
    
    _cover.backgroundColor = [UIColor clearColor];
    
    _cover.hidden = YES;
    
    [_cover addGestureRecognizer:[[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(hideCover)]];
}

- (void)hideCover
{
    _cover.hidden = YES;
    
    [[NSNotificationCenter defaultCenter]postNotificationName:@"resignKeyword" object:nil];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return _dataArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if(indexPath.row == 1 || indexPath.row == 2)
    {
        static NSString *gongjiCell = @"gongjiCellId";
        
        HWAreaTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:gongjiCell];
        
        if(cell == nil)
        {
            cell = [[HWAreaTableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:gongjiCell];
        }
        
        cell.titleLabel.text = _dataArray[indexPath.row];
        
        switch (indexPath.row) {
            case 1:
                cell.textfield.attributedPlaceholder = [[NSMutableAttributedString alloc]initWithString:@"请输入公积金贷款额" attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:15]}];
                break;
                
            default:
                cell.textfield.attributedPlaceholder = [[NSMutableAttributedString alloc]initWithString:@"请输入商业贷款金额" attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:15]}];
                break;
        }
        
        cell.cover = _cover;
        
        cell.unitLabel.text = @"万元";
        
        return cell;
    }
    else
    {
        static NSString *shangyeCellId = @"shangyeCellId";
        
        HWHouseLoanTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:shangyeCellId];
        
        if(cell == nil)
        {
            cell = [[HWHouseLoanTableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:shangyeCellId];
        }
        cell.titleLabel.text = _dataArray[indexPath.row];
        
        switch (indexPath.row) {
            case 0:
                cell.titleContentLabel.text = _paymentMethod[_cellSelectedVC.paymentIndex];
                break;
                
            case 3:
                cell.titleContentLabel.text = _anjieYear[_cellSelectedVC.anjieYearIndex];
                break;
                
            case 4:
                cell.titleContentLabel.text = _rateArray[_cellSelectedVC.rateIndex];
                break;
                
            default:
                break;
        }
        return cell;
    }
}
- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section
{
    UIView *footView = [[UIView alloc]initWithFrame:CGRectMake(0, 17, kScreenWidth, 55)];
    //显示利率
    
    UILabel *tempLabel = [[UILabel alloc]initWithFrame:CGRectMake(29, 4, 170, 21)];
    
    tempLabel.font = [UIFont fontWithName:FONTNAME size:14];
    
    tempLabel.text = @"公积金贷款利率:";
    
    tempLabel.textAlignment = NSTextAlignmentRight;
    
    tempLabel.backgroundColor = [UIColor clearColor];
    
    tempLabel.textColor = TITLE_COLOR_99;
    
    [footView addSubview:tempLabel];
    
    UILabel *rateLabel = [[UILabel alloc]initWithFrame:CGRectMake(CGRectGetMaxX(tempLabel.frame), CGRectGetMinY(tempLabel.frame), 60, CGRectGetHeight(tempLabel.frame))];
    
    rateLabel.textColor = tempLabel.textColor;
    
    rateLabel.font = tempLabel.font;
    
    NSString *rateStr = [_rateArray[_cellSelectedVC.rateIndex] stringByAppendingString:@"-2"];
    
    rateLabel.text = [self returnRate:_anjieYear[_cellSelectedVC.anjieYearIndex] rate:rateStr index:_cellSelectedVC.anjieYearIndex];
    
    [footView addSubview:rateLabel];
    
    _gongJiRateLabel = rateLabel;
    
////-----------------------------------------
    
    UILabel *shangLabel = [[UILabel alloc]initWithFrame:CGRectMake(16, 28, 170, 21)];
    
    shangLabel.font = [UIFont fontWithName:FONTNAME size:14];
    
    shangLabel.text = @"商业贷款利率:";
    
    shangLabel.textAlignment = NSTextAlignmentRight;
    
    shangLabel.backgroundColor = [UIColor clearColor];
    
    shangLabel.textColor = TITLE_COLOR_99;
    
    [footView addSubview:shangLabel];
    
    UILabel *shangRateLabel = [[UILabel alloc]initWithFrame:CGRectMake(198, 28, 170, 21)];
    
    shangRateLabel.textColor = rateLabel.textColor;
    
    shangRateLabel.font = rateLabel.font;
    
    shangRateLabel.text = [self returnRate:_anjieYear[_cellSelectedVC.anjieYearIndex] rate:_rateArray[_cellSelectedVC.rateIndex ] index:_cellSelectedVC.anjieYearIndex];
    
    [footView addSubview:shangRateLabel];
    
    _shangRateLabel = shangRateLabel;
    
    return footView;

}
/**
 *	@brief	返回商贷年数，利率以及索引
 *
 *	@param 	year
 *	@param 	rate
 *	@param 	indexTemp
 *
 *	@return	 年数，利率以及索引
 */
-(NSString *)returnRate:(NSString *)year rate:(NSString *)rate index:(NSInteger)indexTemp
{
    NSString *plistPath = [[NSBundle mainBundle]pathForResource:@"RatePlist" ofType:@"plist"];
    
    NSDictionary *dic_data = [NSDictionary dictionaryWithContentsOfFile:plistPath];
    
    NSArray *arry = [dic_data objectForKey:rate];
    
    NSDictionary* dic = [arry objectAtIndex:indexTemp];
    
    return [dic objectForKey:year];
}

//----------------------------------------------------------------------------------------
- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    return 55.f;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 55.f;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if(self.turnToNextVC)
    {
        
            switch (indexPath.row) {
                
            
                case 0:
                    _cellSelectedVC.dataArray = _paymentMethod;
                    
                    
                    break;
                    
                    
                case 3:
                    _cellSelectedVC.dataArray = _anjieYear;
                    break;
            
                case 4:
                    _cellSelectedVC.dataArray = _rateArray;
                    break;
                    
                default:
                    break;
            }
        
        _cellSelectedVC.selectedRow = indexPath.row;
        
        UITableViewCell *cell = [_associationTableView cellForRowAtIndexPath:indexPath];
        
        if(![cell isKindOfClass:[HWAreaTableViewCell class]])
        {
            self.turnToNextVC(0,indexPath.row);
        }
        
    }
}

- (void)jiSuanAction:(UIButton *)btn
{
    /*
     * 组合型贷款数据的计算
     */
    _resultType = _paymentMethod[_cellSelectedVC.paymentIndex];
    
    if ([_resultType isEqualToString:@"等额本息"]) {
        if (_gongJiStrl.length==0 && _shangYeStrl.length>0) {
            UIAlertView * alert = [[UIAlertView alloc]initWithTitle:nil message:@"请输入公积金贷款金额" delegate:self cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
            [alert show];
        }
        else if (_shangYeStrl.length==0 && _gongJiStrl.length>0){
            UIAlertView * alert = [[UIAlertView alloc]initWithTitle:nil message:@"请输入商业贷款金额" delegate:self cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
            [alert show];
        }
        else if (_gongJiStrl.length==0 && _shangYeStrl.length==0){
            UIAlertView * alert = [[UIAlertView alloc]initWithTitle:nil message:@"请输入公积金贷款金额" delegate:self cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
            [alert show];
        }
        else{
            //add by gusheng
            [self zuheUnitPrice:_gongJiRateLabel.text  shangStr:_shangRateLabel.text];
            //end
        }
    }
    if ([_resultType isEqualToString:@"等额本金"]) {
        if (_gongJiStrl.length==0 && _shangYeStrl.length>0) {
            UIAlertView * alert = [[UIAlertView alloc]initWithTitle:nil message:@"请输入公积金贷款金额" delegate:self cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
            [alert show];
        }
        else if (_shangYeStrl.length==0 && _gongJiStrl.length>0){
            UIAlertView * alert = [[UIAlertView alloc]initWithTitle:nil message:@"请输入商业贷款金额" delegate:self cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
            [alert show];
        }
        else if (_gongJiStrl.length==0 && _shangYeStrl.length==0){
            UIAlertView * alert = [[UIAlertView alloc]initWithTitle:nil message:@"请输入公积金贷款金额" delegate:self cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
            [alert show];
        }
        else{
            [self zuheTotalPrice:_gongJiRateLabel.text shangStr:_shangRateLabel.text];
            
        }
    }
}
//组合的计算方式
//等额本息
/**
 *	@brief	组合等额本息
 *
 *	@param 	gongDaiStr
 *	@param 	shangDailv
 *
 *	@return	 无
 */
-(void)zuheUnitPrice:(NSString *)gongDaiStr shangStr:(NSString *)shangDailv

{
    //add by gusheng
    float gongKuan = [_gongJiStrl floatValue]*10000;//公积金贷款
    float shangKuan = [_shangYeStrl floatValue]*10000;//商业贷款
    NSDecimalNumber *gongKuanNumber = [NSDecimalNumber decimalNumberWithString:[NSString stringWithFormat:@"%f",gongKuan]];
    NSDecimalNumber *shangKuanNumber = [NSDecimalNumber decimalNumberWithString:[NSString stringWithFormat:@"%f",shangKuan]];
    int yueShu = (int)(_cellSelectedVC.anjieYearIndex+1)*12;//贷款月数
    NSDecimalNumber *yueShuNumber = [NSDecimalNumber decimalNumberWithString:[NSString stringWithFormat:@"%d",yueShu]];
    NSString * gongStr = gongDaiStr;//label_5
    NSString * shangStr = shangDailv;//label_6
    NSDecimalNumber *gongNumber = [NSDecimalNumber decimalNumberWithString:gongStr];
    NSDecimalNumber *shangNumber = [NSDecimalNumber decimalNumberWithString:shangStr];
    NSDecimalNumber *gongLilvNumber = [gongNumber decimalNumberByDividingBy:[NSDecimalNumber decimalNumberWithString:@"100"]];//公积金贷款利率
    gongLilvNumber = [gongLilvNumber decimalNumberByDividingBy:[NSDecimalNumber decimalNumberWithString:@"12"]];
    NSDecimalNumber *shangLilvNumber = [shangNumber decimalNumberByDividingBy:[NSDecimalNumber decimalNumberWithString:@"100"]];
    shangLilvNumber = [shangLilvNumber decimalNumberByDividingBy:[NSDecimalNumber decimalNumberWithString:@"12"]];//商业贷款利率
    NSDecimalNumber *zongDaiNumber = [gongKuanNumber decimalNumberByAdding:shangKuanNumber];
    NSString *zongDaiStr = [zongDaiNumber stringValue];
    
    //add by gusheng test
    NSDecimalNumber *yueHuanNumberOne = [gongKuanNumber decimalNumberByMultiplyingBy:gongLilvNumber];
    NSDecimalNumber *xNumber = [NSDecimalNumber decimalNumberWithString:@"1"];
    NSDecimalNumber *yNumber = gongLilvNumber;
    xNumber = [xNumber decimalNumberByAdding:yNumber];
    NSDecimalNumber *objectOneNumber = [xNumber decimalNumberByRaisingToPower:yueShu];
    NSDecimalNumber *objectTwoNumber = [objectOneNumber decimalNumberByAdding:[NSDecimalNumber decimalNumberWithString:@"-1"]];
    yueHuanNumberOne = [yueHuanNumberOne decimalNumberByMultiplyingBy:objectOneNumber];
    yueHuanNumberOne = [yueHuanNumberOne decimalNumberByDividingBy:objectTwoNumber];
    
    //add by gusheng test
    NSDecimalNumber *yueHuanNumberTwo = [shangKuanNumber decimalNumberByMultiplyingBy:shangLilvNumber];
    NSDecimalNumber *xNumberTwo = [NSDecimalNumber decimalNumberWithString:@"1"];
    NSDecimalNumber *yNumberTwo = shangLilvNumber;
    xNumberTwo = [xNumberTwo decimalNumberByAdding:yNumberTwo];
    NSDecimalNumber *objectOneNumberTemp = [xNumberTwo decimalNumberByRaisingToPower:yueShu];
    NSDecimalNumber *objectTwoNumberTemp = [objectOneNumberTemp decimalNumberByAdding:[NSDecimalNumber decimalNumberWithString:@"-1"]];
    yueHuanNumberTwo = [yueHuanNumberTwo decimalNumberByMultiplyingBy:objectOneNumberTemp];
    yueHuanNumberTwo = [yueHuanNumberTwo decimalNumberByDividingBy:objectTwoNumberTemp];
    
    NSDecimalNumber *yueHuanNumber = [yueHuanNumberOne decimalNumberByAdding:yueHuanNumberTwo];////每月还款
    NSString *yueHuanStr = [yueHuanNumber stringValue];
    
    NSDecimalNumber *zongHuanNumber = [yueHuanNumber decimalNumberByMultiplyingBy:yueShuNumber];//还款总额
    NSString *zongHuanStr = [zongHuanNumber stringValue];
    
    NSDecimalNumber *zhiliNumber = [zongHuanNumber decimalNumberByAdding:[zongDaiNumber decimalNumberByMultiplyingBy:[NSDecimalNumber decimalNumberWithString:@"-1"]]];//支付利息
    NSString *zhiliStr = [zhiliNumber stringValue];
    
    //end
    NSArray * array1 = [NSArray arrayWithObjects:@"贷款总额",@"还款总额",@"支付利息",@"贷款月数",@"月均还款", nil];
    NSString * str1 = [NSString stringWithFormat:@"%.2f 元",[zongDaiStr doubleValue]];
    NSString * str2 = [NSString stringWithFormat:@"%.2f 元",[zongHuanStr doubleValue]];
    NSString * str3 = [NSString stringWithFormat:@"%.2f 元",[zhiliStr doubleValue]];
    NSString * str4 = [NSString stringWithFormat:@"%d 月",yueShu];
    NSString * str5 = [NSString stringWithFormat:@"%.2f 元",[yueHuanStr doubleValue]];
    NSArray * array2 = [NSArray arrayWithObjects:str1,str2,str3,str4,str5, nil];
    HWFangResultViewController * fvc = [[HWFangResultViewController alloc]init];
    fvc.nameArray_1 = array1;
    fvc.dataArray_1 = array2;
    fvc.xianType = @"1";
    
    if(self.turnToResultVC)
    {
        self.turnToResultVC(fvc);
    }
    
}
//等额本金
/**
 *	@brief	组合等额本金
 *
 *	@param 	gongDaiStr
 *	@param 	shangDailv
 *
 *	@return	 无
 */
-(void)zuheTotalPrice:(NSString *)gongDaiStr shangStr:(NSString *)shangDailv

{
    //add by gusheng
    //每月还款数组
    NSMutableArray * array4 = [[NSMutableArray alloc]initWithCapacity:0];
    //月数数组
    NSMutableArray * array3 = [[NSMutableArray alloc]initWithCapacity:0];
    float gongKuan = [_gongJiStrl floatValue]*10000;//公积金贷款
    float shangKuan = [_shangYeStrl floatValue]*10000;//商业贷款
    NSDecimalNumber *gongKuanNumber = [NSDecimalNumber decimalNumberWithString:[NSString stringWithFormat:@"%f",gongKuan]];
    NSDecimalNumber *shangKuanNumber = [NSDecimalNumber decimalNumberWithString:[NSString stringWithFormat:@"%f",shangKuan]];
    int yueShu = (int)(_cellSelectedVC.anjieYearIndex+1)*12;//贷款月数
    NSDecimalNumber *yueShuNumber = [NSDecimalNumber decimalNumberWithString:[NSString stringWithFormat:@"%d",yueShu]];
    NSString * gongStr = gongDaiStr;//label_5
    NSString * shangStr = shangDailv;//label_6
    NSDecimalNumber *gongNumber = [NSDecimalNumber decimalNumberWithString:gongStr];
    NSDecimalNumber *shangNumber = [NSDecimalNumber decimalNumberWithString:shangStr];
    NSDecimalNumber *gongLilvNumber = [gongNumber decimalNumberByDividingBy:[NSDecimalNumber decimalNumberWithString:@"100"]];//公积金贷款利率
    gongLilvNumber = [gongLilvNumber decimalNumberByDividingBy:[NSDecimalNumber decimalNumberWithString:@"12"]];
    NSDecimalNumber *shangLilvNumber = [shangNumber decimalNumberByDividingBy:[NSDecimalNumber decimalNumberWithString:@"100"]];
    shangLilvNumber = [shangLilvNumber decimalNumberByDividingBy:[NSDecimalNumber decimalNumberWithString:@"12"]];//商业贷款利率
    NSDecimalNumber *zongDaiNumber = [gongKuanNumber decimalNumberByAdding:shangKuanNumber];
    NSString *zongDaiStr = [zongDaiNumber stringValue];
    NSDecimalNumber *gongJunNumber = [gongKuanNumber decimalNumberByDividingBy:yueShuNumber];//公积金贷款每月所还本金
    NSDecimalNumber *shangJunNumber = [shangKuanNumber decimalNumberByDividingBy:yueShuNumber];//商业贷款每月所还本金
    NSDecimalNumber *zongHuanNumber = [NSDecimalNumber decimalNumberWithString:@"0.0"];//还款总额
    //add by gusheng
    for (int i=0; i<yueShu; i++) {
        NSDecimalNumber *yueHuanNumber;
        
        NSDecimalNumber *gongYueHuanNumber;
        NSDecimalNumber *shangHuanNumber;
        NSDecimalNumber *tempNumberOne = [gongJunNumber decimalNumberByMultiplyingBy:[NSDecimalNumber decimalNumberWithString:[NSString stringWithFormat:@"%d",i]]];
        NSDecimalNumber *tempNumberTwo = [tempNumberOne decimalNumberByMultiplyingBy:[NSDecimalNumber decimalNumberWithString:@"-1"]];
        
        NSDecimalNumber *tempNumberThree = [gongKuanNumber decimalNumberByAdding:tempNumberTwo];
        
        NSDecimalNumber *tempNumberFour = [tempNumberThree decimalNumberByMultiplyingBy:gongLilvNumber];
        
        gongYueHuanNumber = [gongJunNumber decimalNumberByAdding:tempNumberFour];
        NSString *yueHuanStr = [gongYueHuanNumber stringValue];
        //end
        NSDecimalNumber *tempNumberOne1 = [shangJunNumber decimalNumberByMultiplyingBy:[NSDecimalNumber decimalNumberWithString:[NSString stringWithFormat:@"%d",i]]];
        NSDecimalNumber *tempNumberTwo1 = [tempNumberOne1 decimalNumberByMultiplyingBy:[NSDecimalNumber decimalNumberWithString:@"-1"]];
        
        NSDecimalNumber *tempNumberThree1 = [shangKuanNumber decimalNumberByAdding:tempNumberTwo1];
        
        NSDecimalNumber *tempNumberFour1 = [tempNumberThree1 decimalNumberByMultiplyingBy:shangLilvNumber];
        
        shangHuanNumber = [shangJunNumber decimalNumberByAdding:tempNumberFour1];
        
        //
        yueHuanNumber = [gongYueHuanNumber decimalNumberByAdding:shangHuanNumber];
        
        NSString * strKuan = [NSString stringWithFormat:@"%.2f 元",[yueHuanStr doubleValue]];
        NSString * strYue = [NSString stringWithFormat:@"第%d月",i+1];
        [array4 addObject:strKuan];
        [array3 addObject:strYue];
        zongHuanNumber= [zongHuanNumber decimalNumberByAdding:yueHuanNumber];
    }
    NSString *zongHuanStr = [zongHuanNumber stringValue];
    NSDecimalNumber *zhiLiNumber = [zongHuanNumber decimalNumberByAdding:[zongDaiNumber decimalNumberByMultiplyingBy:[NSDecimalNumber decimalNumberWithString:@"-1"]]];
    NSString *zhiLiStr = [zhiLiNumber stringValue];
    //end
    NSArray * array1 = [NSArray arrayWithObjects:@"贷款总额",@"还款总额",@"支付利息",@"贷款月数", nil];
    NSString * str1 = [NSString stringWithFormat:@"%.2f 元",[zongDaiStr doubleValue]];
    NSString * str2 = [NSString stringWithFormat:@"%.2f 元",[zongHuanStr doubleValue]];
    NSString * str3 = [NSString stringWithFormat:@"%.2f 元",[zhiLiStr doubleValue]];
    NSString * str4 = [NSString stringWithFormat:@"%d 月",yueShu];
    NSArray * array2 = [NSArray arrayWithObjects:str1,str2,str3,str4, nil];
    HWFangResultViewController * fvc = [[HWFangResultViewController alloc]init];
    fvc.nameArray_1 = array1;
    fvc.dataArray_1 = array2;
    fvc.nameArray_2 = array3;
    fvc.dataArray_2 = array4;
    fvc.xianType = @"2";
    
    if(self.turnToResultVC)
    {
        self.turnToResultVC(fvc);
    }
}
@end
