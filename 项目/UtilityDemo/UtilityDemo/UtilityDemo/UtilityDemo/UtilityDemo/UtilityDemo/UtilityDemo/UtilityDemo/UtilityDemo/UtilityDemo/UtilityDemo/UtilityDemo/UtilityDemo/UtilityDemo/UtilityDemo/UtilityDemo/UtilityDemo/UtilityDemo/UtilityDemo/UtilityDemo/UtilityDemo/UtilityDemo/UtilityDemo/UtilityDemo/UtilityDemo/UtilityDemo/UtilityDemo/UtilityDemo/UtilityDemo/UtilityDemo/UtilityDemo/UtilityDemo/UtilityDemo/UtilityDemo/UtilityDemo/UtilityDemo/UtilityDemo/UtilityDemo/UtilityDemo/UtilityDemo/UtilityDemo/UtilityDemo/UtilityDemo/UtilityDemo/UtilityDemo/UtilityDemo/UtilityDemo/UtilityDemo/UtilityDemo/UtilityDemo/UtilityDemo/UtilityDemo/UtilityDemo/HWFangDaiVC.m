//
//  HWFangDaiVC.m
//  UtilityDemo
//
//  Created by wuxiaohong on 15/4/8.
//  Copyright (c) 2015年 hw. All rights reserved.
//

#import "HWFangDaiVC.h"
#import "HWClickTableViewReturnViewController.h"
#import "HWFangResultViewController.h"
#define shangDefault @"15年3月1日基准利率"
@interface HWFangDaiVC ()

@end

@implementation HWFangDaiVC
/**
 *	@brief	获取商贷和公积金利率
 *
 *	@return	 无
 */
-(void)createDataDictory
{
    NSString *plistPath = [[NSBundle mainBundle]pathForResource:@"RatePlist" ofType:@"plist"];
   self.dic_data = [[NSDictionary alloc]initWithContentsOfFile:plistPath];
    
}
/**
 *	@brief	初始化数据
 *
 *	@return	 无
 */
-(void)creatDataArray
{
    //按揭成数数组
    self.array_1 = [NSArray arrayWithObjects:@"9成",@"8成",@"7成",@"6成",@"5成",@"4成",@"3成",@"2成", nil];
    self.array_2 = [NSArray arrayWithObjects:@"1年(12期)",@"2年(24期)",@"3年(36期)",@"4年(48期)",@"5年(60期)",@"6年(72期)",@"7年(84期)",@"8年(96期)",@"9年(108期)",@"10年(120期)",@"11年(134期)",@"12年(144期)",@"13年(156期)",@"14年(168期)",@"15年(180期)",@"16年(192期)",@"17年(204期)",@"18年(216期)",@"19年(228期)",@"20年(240期)",@"21年(252期)",@"22年(264期)",@"23年(276期)",@"24年(288期)",@"25年(300期)",@"26年(312期)",@"27年(324期)",@"28年(336期)",@"29年(348期)",@"30年(360期)", nil];
    self.array_3 = [NSArray arrayWithObjects:@"15年3月1日基准利率",@"15年3月1日利率上限(1.1倍)",@"15年3月1日利率下限(85折)", nil];
    self.array_6 = [NSArray arrayWithObjects:@"1",@"2",@"3",@"4",@"5",@"6",@"7",@"8",@"9",@"10",@"11",@"12",@"13",@"14",@"15",@"16",@"17",@"18",@"19",@"20",@"21",@"22",@"23",@"24",@"25",@"26",@"27",@"28",@"29",@"30", nil];
    
    self.businessOneArry = [NSArray arrayWithObjects:@"还款方式",@"计算方式",@"贷款总额",@"按揭年数",@"利率",nil];
    self.businessTwoArry = [NSArray arrayWithObjects:@"还款方式",@"计算方式",@"单价",@"面积",@"按揭成数",@"按揭年数",@"利率",nil];
    self.associationArry = [NSArray arrayWithObjects:@"还款方式",@"公积金贷款",@"商业贷款",@"按揭年数",@"利率", nil];
    self.repaymentArry   = [NSArray arrayWithObjects:@"等额本息",@"等额本金", nil];
    self.caculateWayArry = [NSArray arrayWithObjects:@"按单价计算",@"按总价计算", nil];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    
    self.navigationItem.title = @"房贷计算器";
    _userContentView = [[UIScrollView alloc]initWithFrame:CGRectMake(0, 0, kScreenWidth, self.view.frame.size.height)];
    _userContentView.contentSize = CGSizeMake(kScreenWidth, 700);
    _userContentView.backgroundColor = THEME_COLOR_BACKGROUND_1;
    [self.view addSubview:_userContentView];
    [self createDataDictory];
    [self creatDataArray];
    //选项卡
    NSArray *segmentItems = [NSArray arrayWithObjects:@"商贷",@"公积金",@"组合",nil];
    
    _segmentControl = [[UISegmentedControl alloc]initWithItems:segmentItems];
    _segmentControl.frame = CGRectMake(15, 8, kScreenWidth - 30, 32);
    _segmentControl.tintColor = CD_MainColor;
    _segmentControl.selectedSegmentIndex = 0;
    [_segmentControl addTarget:self action:@selector(clickSegment:) forControlEvents:UIControlEventValueChanged];
    [_userContentView addSubview:_segmentControl];
    [self createDefults];
    //商业贷款
    [self createBusinessView];
    //公积金贷款
  //  [self creatAccumulation];
    //组合型贷款
    //[self createAssociationView];

    
}

-(void)createDefults
{
    UIImageView * line =  [Utility drawLine:CGPointMake(0, 49.5) width:kScreenWidth];
    [_userContentView addSubview:line];
    self.rateStr = @"5.9%";
    self.accumulationStr = @"3.825%";
    self.index = 19;
    self.rateIndex = 0;
    self.lilvStr = shangDefault;
    self.jiSuanType = @"商业贷款";
    self.suanType = @"总价计算";
    self.accmulationSuanType = @"总价计算";
    self.tabArray = [[NSMutableArray alloc]initWithCapacity:0];
    
}

-(void)createFootView
{
   
    UIView * footView = [[UIView alloc]initWithFrame:CGRectMake(0, CGRectGetMaxY(_fangDaiTab.frame), kScreenWidth, 110)];
    footView.backgroundColor = THEME_COLOR_BACKGROUND_1;
    [_userContentView addSubview:footView];
    UILabel *tempLabel  = [[UILabel alloc]initWithFrame:CGRectMake(10, 10, kScreenWidth - 20, 21)];
    tempLabel.font = [UIFont fontWithName:FONTNAME size:12];
    tempLabel.textColor = THEME_COLOR_GREEN_NORMAL;
    tempLabel.text = @"*等额本金还款额逐月减少，等额本息还款每月相同";
    tempLabel.textAlignment = NSTextAlignmentCenter;
    tempLabel.backgroundColor = [UIColor clearColor];
    [footView addSubview:tempLabel];
    
    UIButton * shangOneBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    shangOneBtn.frame = CGRectMake(10, CGRectGetMaxY(tempLabel.frame)+20, kScreenWidth - 20, 50);
    [shangOneBtn setTitle:@"计算" forState:UIControlStateNormal];
    [shangOneBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    //    [shangOneBtn setButtonBackgroundShadowHighlight];
    [shangOneBtn setButtonRedAndOrangeBorderStyle];
    [shangOneBtn addTarget:self action:@selector(jiSuanAction:) forControlEvents:UIControlEventTouchUpInside];
    [footView addSubview:shangOneBtn];
    


    
}
#pragma mark - 选项卡
-(void)clickSegment:(id)sender
{
    UISegmentedControl *temp = sender;
    NSInteger indexTemp = temp.selectedSegmentIndex;
    
    switch (indexTemp) {
        case 0:
            self.rateStr = @"5.9%";
            self.rateIndex = 0;
            self.index = 19;
            self.lilvStr = shangDefault;
            _shangDaiView.hidden = NO;
            _gongView.hidden = YES;
            _zuHeView.hidden = YES;
            _jiSuanType = @"商业贷款";
            _huanKuanType = @"等额本息";
            break;
        case 1:
            self.rateStr = @"4.0%";
            self.rateIndex = 0;
            self.index = 19;
            self.lilvStr = shangDefault;
            _gongView.hidden = NO;
            _shangDaiView.hidden = YES;
            _zuHeView.hidden = YES;
            _jiSuanType = @"公积金贷款";
            _huanKuanType = @"等额本息";
            
            break;
        case 2:
            _rateStr = @"5.5675%";
            _accumulationStr = @"3.825%";
            _zuHeView.hidden = NO;
            _shangDaiView.hidden = YES;
            _gongView.hidden = YES;
            _jiSuanType = @"组合型贷款";
            break;
            
        default:
            break;
    }

}
#pragma mark - 计算按钮
-(void)jiSuanAction:(UIButton * )sender
{
    NSString * resultType;
    if ([_jiSuanType isEqualToString:@"组合型贷款"]) {
        resultType = [NSString stringWithFormat:@"%@%@",_jiSuanType,_huanKuanType];
    }
    else if([_jiSuanType isEqualToString:@"商业贷款"])
    {
        resultType = [NSString stringWithFormat:@"%@%@%@",_jiSuanType,_huanKuanType,
                      _suanType];
    }
    else if([_jiSuanType isEqualToString:@"公积金贷款"])
    {
        resultType = [NSString stringWithFormat:@"%@%@%@",_jiSuanType,_huanKuanType,_accmulationSuanType];
    }
    /*
     * 商业贷款数据的计算
     */
    if ([resultType isEqualToString:@"商业贷款等额本息单价计算"]) {
        if (_shangJiaGe.text.length==0 && _shangMianJi.text.length>0) {
            UIAlertView * alert = [[UIAlertView alloc]initWithTitle:nil message:@"请输入单价" delegate:self cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
            [alert show];
        }
        else if (_shangMianJi.text.length==0 && _shangJiaGe.text.length>0) {
            UIAlertView * alert = [[UIAlertView alloc]initWithTitle:nil message:@"请输入房屋面积" delegate:self cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
            [alert show];
        }
        else if (_shangJiaGe.text.length==0 && _shangMianJi.text.length==0){
            UIAlertView * alert = [[UIAlertView alloc]initWithTitle:nil message:@"请输入单价" delegate:self cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
            [alert show];
        }
        else{
            //add by gusheng
            [self unitPrice:_label_1.text];
        }
    }
    if ([resultType isEqualToString:@"商业贷款等额本金单价计算"]) {
        if (_shangJiaGe.text.length==0 && _shangMianJi.text.length>0) {
            UIAlertView * alert = [[UIAlertView alloc]initWithTitle:nil message:@"请输入单价" delegate:self cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
            [alert show];
        }
        else if (_shangMianJi.text.length==0 && _shangJiaGe.text.length>0) {
            UIAlertView * alert = [[UIAlertView alloc]initWithTitle:nil message:@"请输入房屋面积" delegate:self cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
            [alert show];
        }
        else if (_shangJiaGe.text.length==0 && _shangMianJi.text.length==0){
            UIAlertView * alert = [[UIAlertView alloc]initWithTitle:nil message:@"请输入单价" delegate:self cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
            [alert show];
        }
        else{
            //add by gusheng
            [self unitBasePrice:_label_1.text];
        }
    }
    if ([resultType isEqualToString:@"商业贷款等额本息总价计算"]) {
        if (_shangZong.text.length==0) {
            UIAlertView * alert = [[UIAlertView alloc]initWithTitle:nil message:@"请输入贷款总额" delegate:self cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
            [alert show];
        }
        else{
            //add by gusheng
            [self totalPric:_label_2.text];
            //end
            
        }
    }
    if ([resultType isEqualToString:@"商业贷款等额本金总价计算"]) {
        if (_shangZong.text.length==0) {
            UIAlertView * alert = [[UIAlertView alloc]initWithTitle:nil message:@"请输入贷款总额" delegate:self cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
            [alert show];
        }
        else{
            //add by gusheng
            [self totalPrincSameBase:_label_2.text];
        }
    }
    /*
     * 公积金贷款数据的计算
     */
    if ([resultType isEqualToString:@"公积金贷款等额本息单价计算"]) {
        if (_gongJiaGe.text.length==0 && _gongMianJi.text.length>0) {
            UIAlertView * alert = [[UIAlertView alloc]initWithTitle:nil message:@"请输入单价" delegate:self cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
            [alert show];
        }
        else if (_gongMianJi.text.length==0 && _gongJiaGe.text.length>0) {
            UIAlertView * alert = [[UIAlertView alloc]initWithTitle:nil message:@"请输入房屋面积" delegate:self cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
            [alert show];
        }
        else if (_gongJiaGe.text.length==0 && _gongMianJi.text.length==0){
            UIAlertView * alert = [[UIAlertView alloc]initWithTitle:nil message:@"请输入单价" delegate:self cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
            [alert show];
        }
        else{
            //add by gusheng
            [self acumulationUnitPrice:_label_3.text];
            //
        }
    }
    if ([resultType isEqualToString:@"公积金贷款等额本金单价计算"]) {
        if (_gongJiaGe.text.length==0 && _gongMianJi.text.length>0) {
            UIAlertView * alert = [[UIAlertView alloc]initWithTitle:nil message:@"请输入单价" delegate:self cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
            [alert show];
        }
        else if (_gongMianJi.text.length==0 && _gongJiaGe.text.length>0) {
            UIAlertView * alert = [[UIAlertView alloc]initWithTitle:nil message:@"请输入房屋面积" delegate:self cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
            [alert show];
        }
        else if (_gongJiaGe.text.length==0 && _gongMianJi.text.length==0){
            UIAlertView * alert = [[UIAlertView alloc]initWithTitle:nil message:@"请输入单价" delegate:self cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
            [alert show];
        }
        else{
            [self acumulationUnitBasePrice:_label_3.text];
        }
    }
    if ([resultType isEqualToString:@"公积金贷款等额本息总价计算"]) {
        if (_gongZong.text.length==0) {
            UIAlertView * alert = [[UIAlertView alloc]initWithTitle:nil message:@"请输入贷款总额" delegate:self cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
            [alert show];
        }
        else{
            //add by gusheng
            [self acumulationTotalPric:_label_4.text];
            
        }
    }
    if ([resultType isEqualToString:@"公积金贷款等额本金总价计算"]) {
        if (_gongZong.text.length==0) {
            UIAlertView * alert = [[UIAlertView alloc]initWithTitle:nil message:@"请输入贷款总额" delegate:self cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
            [alert show];
        }
        else{
            
            [self acumulationTotalPrincSameBase:_label_4.text];
        }
    }
    /*
     * 组合型贷款数据的计算
     */
    if ([resultType isEqualToString:@"组合型贷款等额本息"]) {
        if (_gongDai.text.length==0 && _shangDai.text.length>0) {
            UIAlertView * alert = [[UIAlertView alloc]initWithTitle:nil message:@"请输入公积金贷款总额" delegate:self cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
            [alert show];
        }
        else if (_shangDai.text.length==0 && _gongDai.text.length>0){
            UIAlertView * alert = [[UIAlertView alloc]initWithTitle:nil message:@"请输入商业贷款总额" delegate:self cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
            [alert show];
        }
        else if (_gongDai.text.length==0 && _shangDai.text.length==0){
            UIAlertView * alert = [[UIAlertView alloc]initWithTitle:nil message:@"请输入公积金贷款总额" delegate:self cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
            [alert show];
        }
        else{
            //add by gusheng
            [self zuheUnitPrice:_label_5.text  shangStr:_label_6.text];
            //end
        }
    }
    if ([resultType isEqualToString:@"组合型贷款等额本金"]) {
        if (_gongDai.text.length==0 && _shangDai.text.length>0) {
            UIAlertView * alert = [[UIAlertView alloc]initWithTitle:nil message:@"请输入公积金贷款总额" delegate:self cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
            [alert show];
        }
        else if (_shangDai.text.length==0 && _gongDai.text.length>0){
            UIAlertView * alert = [[UIAlertView alloc]initWithTitle:nil message:@"请输入商业贷款总额" delegate:self cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
            [alert show];
        }
        else if (_gongDai.text.length==0 && _shangDai.text.length==0){
            UIAlertView * alert = [[UIAlertView alloc]initWithTitle:nil message:@"请输入公积金贷款总额" delegate:self cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
            [alert show];
        }
        else{
            [self zuheTotalPrice:_label_5.text shangStr:_label_6.text];
            
        }
    }
 
}
//房贷计算方法
//单价还款等本金
/**
 *	@brief	单价等额本金还款
 *
 *	@param 	lilvStrTemp
 *
 *	@return	  无
 */
-(void)unitBasePrice:(NSString *)lilvStrTemp
{
    ////每月还款数组
    NSMutableArray * array4 = [[NSMutableArray alloc]initWithCapacity:0];
    //月数数组
    NSMutableArray * array3 = [[NSMutableArray alloc]initWithCapacity:0];
    NSDecimalNumber *jiaGeNumber = [NSDecimalNumber decimalNumberWithString:_shangJiaGe.text];
    NSDecimalNumber *mianJiNumber = [NSDecimalNumber decimalNumberWithString:_shangMianJi.text];
    NSDecimalNumber *ZongJiaNumber = [jiaGeNumber decimalNumberByMultiplyingBy:mianJiNumber];
    NSString *zongJiaStr = [ZongJiaNumber stringValue];
    // int nian = [[array_6 objectAtIndex:[array_2 indexOfObject:shangDanNianStr]] intValue];
    float cheng = [[_shangDanChengStr substringWithRange:NSMakeRange(0, 1)] floatValue]/10;
    NSDecimalNumber *chengNumber = [NSDecimalNumber decimalNumberWithString:[NSString stringWithFormat:@"%f",cheng]];
    
    int yueShu = [[_array_6 objectAtIndex:[_array_2 indexOfObject:_shangDanNianStr]] intValue]*12;//贷款月数
    NSDecimalNumber *yueShuNumber = [NSDecimalNumber decimalNumberWithString:[NSString stringWithFormat:@"%d",yueShu]];//贷款月数
    NSDecimalNumber *lilvNumber = [NSDecimalNumber decimalNumberWithString:lilvStrTemp];
    lilvNumber = [lilvNumber decimalNumberByDividingBy:[NSDecimalNumber decimalNumberWithString:@"100"]];
    
    NSDecimalNumber *yueLilvNumber = [lilvNumber decimalNumberByDividingBy:[NSDecimalNumber decimalNumberWithString:@"12"]];//月利率
    
    NSDecimalNumber *yueJunNumber = [[ZongJiaNumber decimalNumberByDividingBy:yueShuNumber]decimalNumberByMultiplyingBy:chengNumber];
    NSDecimalNumber *zongHuanNumber = [NSDecimalNumber decimalNumberWithString:@"0"];//还款总额
    NSDecimalNumber *daiZongNumber = [ZongJiaNumber decimalNumberByMultiplyingBy:chengNumber];
    NSString *daiZongStr = [daiZongNumber stringValue];
    for (int i=0; i<yueShu; i++) {
        NSDecimalNumber *yueHuanNumber;
        NSDecimalNumber *tempNumberOne = [yueJunNumber decimalNumberByMultiplyingBy:[NSDecimalNumber decimalNumberWithString:[NSString stringWithFormat:@"%d",i]]];
        NSDecimalNumber *tempNumberTwo = [tempNumberOne decimalNumberByMultiplyingBy:[NSDecimalNumber decimalNumberWithString:@"-1"]];
        
        NSDecimalNumber *tempNumberThree = [daiZongNumber decimalNumberByAdding:tempNumberTwo];
        
        NSDecimalNumber *tempNumberFour = [tempNumberThree decimalNumberByMultiplyingBy:yueLilvNumber];
        
        yueHuanNumber = [yueJunNumber decimalNumberByAdding:tempNumberFour];
        NSString *yueHuanStr = [yueHuanNumber stringValue];
        NSString * strKuan = [NSString stringWithFormat:@"%.2f 元",[yueHuanStr doubleValue]];
        NSString * strYue = [NSString stringWithFormat:@"第%d月",i+1];
        [array4 addObject:strKuan];
        [array3 addObject:strYue];
        zongHuanNumber= [zongHuanNumber decimalNumberByAdding:yueHuanNumber];
    }
    
    NSString *zongHuanStr = [zongHuanNumber stringValue];
    NSDecimalNumber *zhiLiNumber = [zongHuanNumber decimalNumberByAdding:[ daiZongNumber decimalNumberByMultiplyingBy:[NSDecimalNumber decimalNumberWithString:@"-1"]]];
    NSString *zhiLiStr = [zhiLiNumber stringValue];
    
    NSDecimalNumber *shouFuNumber = [zongHuanNumber decimalNumberByAdding:[daiZongNumber decimalNumberByMultiplyingBy:[NSDecimalNumber decimalNumberWithString:@"-1"]]];
    
    NSString *shouFuStr = [shouFuNumber stringValue];
    NSArray * array1 = [NSArray arrayWithObjects:@"房款总额",@"贷款总额",@"还款总额",@"支付利息",@"首期付款",@"还款月数", nil];
    NSString * str1 = [NSString stringWithFormat:@"%.2f 元",[zongJiaStr doubleValue]];
    NSString * str2 = [NSString stringWithFormat:@"%.2f 元",[daiZongStr doubleValue]];
    NSString * str3 = [NSString stringWithFormat:@"%.2f 元",[zongHuanStr doubleValue]];
    NSString * str4 = [NSString stringWithFormat:@"%.2f 元",[zhiLiStr doubleValue]];
    NSString * str5 = [NSString stringWithFormat:@"%.2f 元",[shouFuStr doubleValue]];
    NSString * str6 = [NSString stringWithFormat:@"%d 月",yueShu];
    NSArray * array2 = [NSArray arrayWithObjects:str1,str2,str3,str4,str5,str6,nil];
    HWFangResultViewController * fvc = [[HWFangResultViewController alloc]init];
    fvc.nameArray_1 = array1;
    fvc.dataArray_1 = array2;
    fvc.nameArray_2 = array3;
    fvc.dataArray_2 = array4;
    fvc.xianType = @"2";
    [self.navigationController pushViewController:fvc animated:YES];
}
//单价单价月利率月均还款算法等额本息
/**
 *	@brief	单价单价月利率月均还款算法等额本息
 *
 *	@param 	lilvStrTemp
 *
 *	@return	 无
 */
-(void)unitPrice:(NSString*)lilvStrTemp
{
    NSDecimalNumber *jiaGeNumber = [NSDecimalNumber decimalNumberWithString:_shangJiaGe.text];
    NSDecimalNumber *mianJiNumber = [NSDecimalNumber decimalNumberWithString:_shangMianJi.text];
    int nian = [[_array_6 objectAtIndex:[_array_2 indexOfObject:_shangDanNianStr]] intValue];
    float cheng = [[_shangDanChengStr substringWithRange:NSMakeRange(0, 1)] floatValue]/10;
    NSDecimalNumber *chengNumber = [NSDecimalNumber decimalNumberWithString:[NSString stringWithFormat:@"%f",cheng]];
    NSDecimalNumber *liLvNumebr = [[NSDecimalNumber decimalNumberWithString:lilvStrTemp]decimalNumberByDividingBy:[NSDecimalNumber decimalNumberWithString:@"100"]];//利率
    NSDecimalNumber *zongJiaNumber = [jiaGeNumber decimalNumberByMultiplyingBy:mianJiNumber];//房屋总价
    NSString *zongJiaStr = [zongJiaNumber stringValue];
    NSDecimalNumber *daiKuanNumber = [zongJiaNumber decimalNumberByMultiplyingBy:chengNumber];//贷款总额
    NSString *daiKuanStr = [daiKuanNumber stringValue];
    NSDecimalNumber *shouYueNumber = [zongJiaNumber decimalNumberByAdding:[daiKuanNumber decimalNumberByMultiplyingBy:[NSDecimalNumber decimalNumberWithString:@"-1"]]];//首月还款
    NSString *shouYueStr = [shouYueNumber stringValue];
    int yueShu = nian*12;//贷款月数
    NSDecimalNumber *yueShuNumber = [NSDecimalNumber decimalNumberWithString:[NSString stringWithFormat:@"%d",yueShu]];
    NSDecimalNumber *yueLilvNumber = [liLvNumebr decimalNumberByDividingBy:[NSDecimalNumber decimalNumberWithString:@"12"]];
    NSDecimalNumber *yueHuanNumber = [daiKuanNumber decimalNumberByMultiplyingBy:yueLilvNumber];
    NSDecimalNumber *xNumber = [NSDecimalNumber decimalNumberWithString:@"1"];
    NSDecimalNumber *yNumber = yueLilvNumber;
    xNumber = [xNumber decimalNumberByAdding:yNumber];
    NSDecimalNumber *objectOneNumber = [xNumber decimalNumberByRaisingToPower:yueShu];
    NSDecimalNumber *objectTwoNumber = [objectOneNumber decimalNumberByAdding:[NSDecimalNumber decimalNumberWithString:@"-1"]];
    yueHuanNumber = [yueHuanNumber decimalNumberByMultiplyingBy:objectOneNumber];
    
    yueHuanNumber = [yueHuanNumber decimalNumberByDividingBy:objectTwoNumber];
    NSString *yueHuanStr = [yueHuanNumber stringValue];
    NSDecimalNumber *zongHuanNumber = [yueHuanNumber decimalNumberByMultiplyingBy:yueShuNumber];//还款总额
    NSString *zongHuanStr = [zongHuanNumber stringValue];
    NSDecimalNumber *huanLiNumber = [zongHuanNumber decimalNumberByAdding:[daiKuanNumber decimalNumberByMultiplyingBy:[NSDecimalNumber decimalNumberWithString:@"-1"]]];//支付利息
    NSString *huanLiStr = [huanLiNumber stringValue];
    
    //end
    NSArray * array1 = [NSArray arrayWithObjects:@"房款总额",@"贷款总额",@"还款总额",@"支付利息",@"首月还款",@"贷款月数",@"月均还款", nil];
    NSString * str1 = [NSString stringWithFormat:@"%.2f 元",[zongJiaStr doubleValue]];
    NSString * str2 = [NSString stringWithFormat:@"%.2f 元",[daiKuanStr doubleValue]];
    NSString * str3 = [NSString stringWithFormat:@"%.2f 元",[zongHuanStr doubleValue]];
    NSString * str4 = [NSString stringWithFormat:@"%.2f 元",[huanLiStr doubleValue]];
    NSString * str5 = [NSString stringWithFormat:@"%.2f 元",[shouYueStr doubleValue]];
    NSString * str6 = [NSString stringWithFormat:@"%d 月",yueShu];
    NSString * str7 = [NSString stringWithFormat:@"%.2f 元",[yueHuanStr doubleValue]];
    NSArray * array2 = [NSArray arrayWithObjects:str1,str2,str3,str4,str5,str6,str7, nil];
    HWFangResultViewController * fvc = [[HWFangResultViewController alloc]init];
    fvc.nameArray_1 = array1;
    fvc.dataArray_1 = array2;
    fvc.xianType = @"1";
    [self.navigationController pushViewController:fvc animated:YES];
}
//总价月利率月均还款算法等额本金
/**
 *	@brief	总价月利率月均还款算法等额本金
 *
 *	@param 	lilvStrTemp
 *
 *	@return	 无
 */
-(void)totalPrincSameBase:(NSString *)lilvStrTemp
{
    ////每月还款数组
    NSMutableArray * array4 = [[NSMutableArray alloc]initWithCapacity:0];
    //月数数组
    NSMutableArray * array3 = [[NSMutableArray alloc]initWithCapacity:0];
    NSDecimalNumber *daiZongNumber = [NSDecimalNumber decimalNumberWithString:_shangZong.text];
    daiZongNumber = [daiZongNumber decimalNumberByMultiplyingBy:[NSDecimalNumber decimalNumberWithString:@"10000"]];
    NSString *daiZongStr = [daiZongNumber stringValue];
    
    int yueShu = [[_array_6 objectAtIndex:[_array_2 indexOfObject:_shangDanNianStr]] intValue]*12;//贷款月数
    NSDecimalNumber *yueShuNumber = [NSDecimalNumber decimalNumberWithString:[NSString stringWithFormat:@"%d",yueShu]];//贷款月数
    NSDecimalNumber *lilvNumber = [NSDecimalNumber decimalNumberWithString:_label_2.text];
    lilvNumber = [lilvNumber decimalNumberByDividingBy:[NSDecimalNumber decimalNumberWithString:@"100"]];
    
    NSDecimalNumber *yueLilvNumber = [lilvNumber decimalNumberByDividingBy:[NSDecimalNumber decimalNumberWithString:@"12"]];//月利率
    
    NSDecimalNumber *yueJunNumber = [daiZongNumber decimalNumberByDividingBy:yueShuNumber];
    NSDecimalNumber *zongHuanNumber = [NSDecimalNumber decimalNumberWithString:@"0"];//还款总额
    
    for (int i=0; i<yueShu; i++) {
        NSDecimalNumber *yueHuanNumber;
        NSDecimalNumber *tempNumberOne = [yueJunNumber decimalNumberByMultiplyingBy:[NSDecimalNumber decimalNumberWithString:[NSString stringWithFormat:@"%d",i]]];
        NSDecimalNumber *tempNumberTwo = [tempNumberOne decimalNumberByMultiplyingBy:[NSDecimalNumber decimalNumberWithString:@"-1"]];
        
        NSDecimalNumber *tempNumberThree = [daiZongNumber decimalNumberByAdding:tempNumberTwo];
        
        
        NSDecimalNumber *tempNumberFour = [tempNumberThree decimalNumberByMultiplyingBy:yueLilvNumber];
        yueHuanNumber = [yueJunNumber decimalNumberByAdding:tempNumberFour];
        NSString *yueHuanStr = [yueHuanNumber stringValue];
        NSString * strKuan = [NSString stringWithFormat:@"%.2f 元",[yueHuanStr doubleValue]];
        NSString * strYue = [NSString stringWithFormat:@"第%d月",i+1];
        [array4 addObject:strKuan];
        [array3 addObject:strYue];
        zongHuanNumber= [zongHuanNumber decimalNumberByAdding:yueHuanNumber];
    }
    NSString *zongHuanStr = [zongHuanNumber stringValue];
    NSDecimalNumber *zhiLiNumber = [zongHuanNumber decimalNumberByAdding:[daiZongNumber decimalNumberByMultiplyingBy:[NSDecimalNumber decimalNumberWithString:@"-1"]]];
    NSString *zhiLiStr = [zhiLiNumber stringValue];
    
    NSArray * array1 = [NSArray arrayWithObjects:@"贷款总额",@"还款总额",@"支付利息",@"贷款月数",nil];
    NSString * str1 = [NSString stringWithFormat:@"%.2f 元",[daiZongStr doubleValue]];
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
    [self.navigationController pushViewController:fvc animated:YES];
}
//总价月利率月均还款算法等额本息
/**
 *	@brief	总价月利率月均还款算法等额本息
 *
 *	@param 	lilvStrTemp
 *
 *	@return	  无
 */
-(void)totalPric:(NSString *)lilvStrTemp
{
    NSDecimalNumber *daiZongNumber = [NSDecimalNumber decimalNumberWithString:_shangZong.text];
    daiZongNumber = [daiZongNumber decimalNumberByMultiplyingBy:[NSDecimalNumber decimalNumberWithString:@"10000"]];
    NSString *daiZongStr = [daiZongNumber stringValue];
    int yueShu = [[_array_6 objectAtIndex:[_array_2 indexOfObject:_shangDanNianStr]] intValue]*12;//贷款月数
    NSDecimalNumber *yueShuNumber = [NSDecimalNumber decimalNumberWithString:[NSString stringWithFormat:@"%d",yueShu]];
    NSDecimalNumber *liLvNumber = [NSDecimalNumber decimalNumberWithString:lilvStrTemp];
    liLvNumber = [liLvNumber decimalNumberByDividingBy:[NSDecimalNumber decimalNumberWithString:@"100"]];
    NSDecimalNumber *yueLilvNumber = [liLvNumber decimalNumberByDividingBy:[NSDecimalNumber decimalNumberWithString:@"12"]];
    NSDecimalNumber *yueHuanNumber = [daiZongNumber decimalNumberByMultiplyingBy:yueLilvNumber];
    NSDecimalNumber *xNumber = [NSDecimalNumber decimalNumberWithString:@"1"];
    NSDecimalNumber *yNumber = yueLilvNumber;
    xNumber = [xNumber decimalNumberByAdding:yNumber];
    NSDecimalNumber *objectOneNumber = [xNumber decimalNumberByRaisingToPower:yueShu];
    NSDecimalNumber *objectTwoNumber = [objectOneNumber decimalNumberByAdding:[NSDecimalNumber decimalNumberWithString:@"-1"]];
    yueHuanNumber = [yueHuanNumber decimalNumberByMultiplyingBy:objectOneNumber];
    
    yueHuanNumber = [yueHuanNumber decimalNumberByDividingBy:objectTwoNumber];
    NSString *yueHuanStr = [yueHuanNumber stringValue];
    NSDecimalNumber *zongHuanNumber = [yueHuanNumber decimalNumberByMultiplyingBy:yueShuNumber];
    NSString *zongHuanStr = [zongHuanNumber stringValue];
    NSDecimalNumber *huanLiNumber = [zongHuanNumber decimalNumberByAdding:[[NSDecimalNumber decimalNumberWithString:@"-1"]decimalNumberByMultiplyingBy:daiZongNumber]];
    NSString *huanLiStr = [huanLiNumber stringValue];
    ;
    
    NSArray * array1 = [NSArray arrayWithObjects:@"贷款总额",@"还款总额",@"支付利息",@"贷款月数",@"月均还款", nil];
    NSString * str1 = [NSString stringWithFormat:@"%.2lf 元",[daiZongStr doubleValue]];
    NSString * str2 = [NSString stringWithFormat:@"%.2lf 元",[zongHuanStr doubleValue]];
    NSString * str3 = [NSString stringWithFormat:@"%.2lf 元",[huanLiStr doubleValue]];
    NSString * str4 = [NSString stringWithFormat:@"%d 月",yueShu];
    NSString * str5 = [NSString stringWithFormat:@"%.2lf 元",[yueHuanStr doubleValue]];
    NSArray * array2 = [NSArray arrayWithObjects:str1,str2,str3,str4,str5, nil];
    HWFangResultViewController * fvc = [[HWFangResultViewController alloc]init];
    fvc.nameArray_1 = array1;
    fvc.dataArray_1 = array2;
    fvc.xianType = @"1";
    [self.navigationController pushViewController:fvc animated:YES];
}

//公积金计算方式
//单价还款等本金
/**
 *	@brief	公积金单价还款等本金
 *
 *	@param 	lilvStrTemp
 *
 *	@return	 无
 */
-(void)acumulationUnitBasePrice:(NSString *)lilvStrTemp
{
    ////每月还款数组
    NSMutableArray * array4 = [[NSMutableArray alloc]initWithCapacity:0];
    //月数数组
    NSMutableArray * array3 = [[NSMutableArray alloc]initWithCapacity:0];
    NSDecimalNumber *jiaGeNumber = [NSDecimalNumber decimalNumberWithString:_gongJiaGe.text];
    NSDecimalNumber *mianJiNumber = [NSDecimalNumber decimalNumberWithString:_gongMianJi.text];
    NSDecimalNumber *ZongJiaNumber = [jiaGeNumber decimalNumberByMultiplyingBy:mianJiNumber];
    NSString *zongJiaStr = [ZongJiaNumber stringValue];
    //int nian = [[array_6 objectAtIndex:[array_2 indexOfObject:gongDanNianStr]] intValue];
    float cheng = [[_gongDanChengStr substringWithRange:NSMakeRange(0, 1)] floatValue]/10;
    NSDecimalNumber *chengNumber = [NSDecimalNumber decimalNumberWithString:[NSString stringWithFormat:@"%f",cheng]];
    
    int yueShu = [[_array_6 objectAtIndex:[_array_2 indexOfObject:_gongDanNianStr]] intValue]*12;//贷款月数
    NSDecimalNumber *yueShuNumber = [NSDecimalNumber decimalNumberWithString:[NSString stringWithFormat:@"%d",yueShu]];//贷款月数
    NSDecimalNumber *lilvNumber = [NSDecimalNumber decimalNumberWithString:lilvStrTemp];
    lilvNumber = [lilvNumber decimalNumberByDividingBy:[NSDecimalNumber decimalNumberWithString:@"100"]];
    
    NSDecimalNumber *yueLilvNumber = [lilvNumber decimalNumberByDividingBy:[NSDecimalNumber decimalNumberWithString:@"12"]];//月利率
    
    NSDecimalNumber *yueJunNumber = [[ZongJiaNumber decimalNumberByDividingBy:yueShuNumber]decimalNumberByMultiplyingBy:chengNumber];
    NSDecimalNumber *zongHuanNumber = [NSDecimalNumber decimalNumberWithString:@"0"];//还款总额
    NSDecimalNumber *daiZongNumber = [ZongJiaNumber decimalNumberByMultiplyingBy:chengNumber];
    NSString *daiZongStr = [daiZongNumber stringValue];
    for (int i=0; i<yueShu; i++) {
        NSDecimalNumber *yueHuanNumber;
        NSDecimalNumber *tempNumberOne = [yueJunNumber decimalNumberByMultiplyingBy:[NSDecimalNumber decimalNumberWithString:[NSString stringWithFormat:@"%d",i]]];
        NSDecimalNumber *tempNumberTwo = [tempNumberOne decimalNumberByMultiplyingBy:[NSDecimalNumber decimalNumberWithString:@"-1"]];
        
        NSDecimalNumber *tempNumberThree = [daiZongNumber decimalNumberByAdding:tempNumberTwo];
        
        NSDecimalNumber *tempNumberFour = [tempNumberThree decimalNumberByMultiplyingBy:yueLilvNumber];
        
        yueHuanNumber = [yueJunNumber decimalNumberByAdding:tempNumberFour];
        NSString *yueHuanStr = [yueHuanNumber stringValue];
        NSString * strKuan = [NSString stringWithFormat:@"%.2f 元",[yueHuanStr doubleValue]];
        NSString * strYue = [NSString stringWithFormat:@"第%d月",i+1];
        [array4 addObject:strKuan];
        [array3 addObject:strYue];
        zongHuanNumber= [zongHuanNumber decimalNumberByAdding:yueHuanNumber];
    }
    
    NSString *zongHuanStr = [zongHuanNumber stringValue];
    NSDecimalNumber *zhiLiNumber = [zongHuanNumber decimalNumberByAdding:[ daiZongNumber decimalNumberByMultiplyingBy:[NSDecimalNumber decimalNumberWithString:@"-1"]]];
    NSString *zhiLiStr = [zhiLiNumber stringValue];
    
    NSDecimalNumber *shouFuNumber = [zongHuanNumber decimalNumberByAdding:[daiZongNumber decimalNumberByMultiplyingBy:[NSDecimalNumber decimalNumberWithString:@"-1"]]];
    
    NSString *shouFuStr = [shouFuNumber stringValue];
    NSArray * array1 = [NSArray arrayWithObjects:@"房款总额",@"贷款总额",@"还款总额",@"支付利息",@"首期付款",@"还款月数", nil];
    NSString * str1 = [NSString stringWithFormat:@"%.2f 元",[zongJiaStr doubleValue]];
    NSString * str2 = [NSString stringWithFormat:@"%.2f 元",[daiZongStr doubleValue]];
    NSString * str3 = [NSString stringWithFormat:@"%.2f 元",[zongHuanStr doubleValue]];
    NSString * str4 = [NSString stringWithFormat:@"%.2f 元",[zhiLiStr doubleValue]];
    NSString * str5 = [NSString stringWithFormat:@"%.2f 元",[shouFuStr doubleValue]];
    NSString * str6 = [NSString stringWithFormat:@"%d 月",yueShu];
    NSArray * array2 = [NSArray arrayWithObjects:str1,str2,str3,str4,str5,str6,nil];
    HWFangResultViewController * fvc = [[HWFangResultViewController alloc]init];
    fvc.nameArray_1 = array1;
    fvc.dataArray_1 = array2;
    fvc.nameArray_2 = array3;
    fvc.dataArray_2 = array4;
    fvc.xianType = @"2";
    [self.navigationController pushViewController:fvc animated:YES];
}

//单价单价月利率月均还款算法等额本息
/**
 *	@brief	公积金单价月利率月均还款算法等额本息
 *
 *	@param 	lilvStrTemp
 *
 *	@return	 无
 */
-(void)acumulationUnitPrice:(NSString*)lilvStrTemp
{
    NSDecimalNumber *jiaGeNumber = [NSDecimalNumber decimalNumberWithString:_gongJiaGe.text];
    NSDecimalNumber *mianJiNumber = [NSDecimalNumber decimalNumberWithString:_gongMianJi.text];
    int nian = [[_array_6 objectAtIndex:[_array_2 indexOfObject:_gongDanNianStr]] intValue];
    float cheng = [[_gongDanChengStr substringWithRange:NSMakeRange(0, 1)] floatValue]/10;
    NSDecimalNumber *chengNumber = [NSDecimalNumber decimalNumberWithString:[NSString stringWithFormat:@"%f",cheng]];
    NSDecimalNumber *liLvNumebr = [[NSDecimalNumber decimalNumberWithString:lilvStrTemp]decimalNumberByDividingBy:[NSDecimalNumber decimalNumberWithString:@"100"]];//利率
    NSDecimalNumber *zongJiaNumber = [jiaGeNumber decimalNumberByMultiplyingBy:mianJiNumber];//房屋总价
    NSString *zongJiaStr = [zongJiaNumber stringValue];
    NSDecimalNumber *daiKuanNumber = [zongJiaNumber decimalNumberByMultiplyingBy:chengNumber];//贷款总额
    NSString *daiKuanStr = [daiKuanNumber stringValue];
    NSDecimalNumber *shouYueNumber = [zongJiaNumber decimalNumberByAdding:[daiKuanNumber decimalNumberByMultiplyingBy:[NSDecimalNumber decimalNumberWithString:@"-1"]]];//首月还款
    NSString *shouYueStr = [shouYueNumber stringValue];
    int yueShu = nian*12;//贷款月数
    NSDecimalNumber *yueShuNumber = [NSDecimalNumber decimalNumberWithString:[NSString stringWithFormat:@"%d",yueShu]];
    NSDecimalNumber *yueLilvNumber = [liLvNumebr decimalNumberByDividingBy:[NSDecimalNumber decimalNumberWithString:@"12"]];
    NSDecimalNumber *yueHuanNumber = [daiKuanNumber decimalNumberByMultiplyingBy:yueLilvNumber];
    NSDecimalNumber *xNumber = [NSDecimalNumber decimalNumberWithString:@"1"];
    NSDecimalNumber *yNumber = yueLilvNumber;
    xNumber = [xNumber decimalNumberByAdding:yNumber];
    NSDecimalNumber *objectOneNumber = [xNumber decimalNumberByRaisingToPower:yueShu];
    NSDecimalNumber *objectTwoNumber = [objectOneNumber decimalNumberByAdding:[NSDecimalNumber decimalNumberWithString:@"-1"]];
    yueHuanNumber = [yueHuanNumber decimalNumberByMultiplyingBy:objectOneNumber];
    
    yueHuanNumber = [yueHuanNumber decimalNumberByDividingBy:objectTwoNumber];
    NSString *yueHuanStr = [yueHuanNumber stringValue];
    NSDecimalNumber *zongHuanNumber = [yueHuanNumber decimalNumberByMultiplyingBy:yueShuNumber];//还款总额
    NSString *zongHuanStr = [zongHuanNumber stringValue];
    NSDecimalNumber *huanLiNumber = [zongHuanNumber decimalNumberByAdding:[daiKuanNumber decimalNumberByMultiplyingBy:[NSDecimalNumber decimalNumberWithString:@"-1"]]];//支付利息
    NSString *huanLiStr = [huanLiNumber stringValue];
    
    //end
    NSArray * array1 = [NSArray arrayWithObjects:@"房款总额",@"贷款总额",@"还款总额",@"支付利息",@"首月还款",@"贷款月数",@"月均还款", nil];
    NSString * str1 = [NSString stringWithFormat:@"%.2f 元",[zongJiaStr doubleValue]];
    NSString * str2 = [NSString stringWithFormat:@"%.2f 元",[daiKuanStr doubleValue]];
    NSString * str3 = [NSString stringWithFormat:@"%.2f 元",[zongHuanStr doubleValue]];
    NSString * str4 = [NSString stringWithFormat:@"%.2f 元",[huanLiStr doubleValue]];
    NSString * str5 = [NSString stringWithFormat:@"%.2f 元",[shouYueStr doubleValue]];
    NSString * str6 = [NSString stringWithFormat:@"%d 月",yueShu];
    NSString * str7 = [NSString stringWithFormat:@"%.2f 元",[yueHuanStr doubleValue]];
    NSArray * array2 = [NSArray arrayWithObjects:str1,str2,str3,str4,str5,str6,str7, nil];
    HWFangResultViewController * fvc = [[HWFangResultViewController alloc]init];
    fvc.nameArray_1 = array1;
    fvc.dataArray_1 = array2;
    fvc.xianType = @"1";
    [self.navigationController pushViewController:fvc animated:YES];
}
//总价月利率月均还款算法等额本金
/**
 *	@brief	公积金总价月利率月均还款算法等额本金
 *
 *	@param 	lilvStrTemp
 *
 *	@return	 无
 */
-(void)acumulationTotalPrincSameBase:(NSString *)lilvStrTemp
{
    ////每月还款数组
    NSMutableArray * array4 = [[NSMutableArray alloc]initWithCapacity:0];
    //月数数组
    NSMutableArray * array3 = [[NSMutableArray alloc]initWithCapacity:0];
    NSDecimalNumber *daiZongNumber = [NSDecimalNumber decimalNumberWithString:_gongZong.text];
    daiZongNumber = [daiZongNumber decimalNumberByMultiplyingBy:[NSDecimalNumber decimalNumberWithString:@"10000"]];
    NSString *daiZongStr = [daiZongNumber stringValue];
    
    int yueShu = [[_array_6 objectAtIndex:[_array_2 indexOfObject:_gongDanNianStr]] intValue]*12;//贷款月数
    NSDecimalNumber *yueShuNumber = [NSDecimalNumber decimalNumberWithString:[NSString stringWithFormat:@"%d",yueShu]];//贷款月数
    NSDecimalNumber *lilvNumber = [NSDecimalNumber decimalNumberWithString:lilvStrTemp];
    lilvNumber = [lilvNumber decimalNumberByDividingBy:[NSDecimalNumber decimalNumberWithString:@"100"]];
    
    NSDecimalNumber *yueLilvNumber = [lilvNumber decimalNumberByDividingBy:[NSDecimalNumber decimalNumberWithString:@"12"]];//月利率
    
    NSDecimalNumber *yueJunNumber = [daiZongNumber decimalNumberByDividingBy:yueShuNumber];
    NSDecimalNumber *zongHuanNumber = [NSDecimalNumber decimalNumberWithString:@"0"];//还款总额
    
    for (int i=0; i<yueShu; i++) {
        NSDecimalNumber *yueHuanNumber;
        NSDecimalNumber *tempNumberOne = [yueJunNumber decimalNumberByMultiplyingBy:[NSDecimalNumber decimalNumberWithString:[NSString stringWithFormat:@"%d",i]]];
        NSDecimalNumber *tempNumberTwo = [tempNumberOne decimalNumberByMultiplyingBy:[NSDecimalNumber decimalNumberWithString:@"-1"]];
        
        NSDecimalNumber *tempNumberThree = [daiZongNumber decimalNumberByAdding:tempNumberTwo];
        
        
        NSDecimalNumber *tempNumberFour = [tempNumberThree decimalNumberByMultiplyingBy:yueLilvNumber];
        
        yueHuanNumber = [yueJunNumber decimalNumberByAdding:tempNumberFour];
        NSString *yueHuanStr = [yueHuanNumber stringValue];
        NSString * strKuan = [NSString stringWithFormat:@"%.2f 元",[yueHuanStr doubleValue]];
        NSString * strYue = [NSString stringWithFormat:@"第%d月",i+1];
        [array4 addObject:strKuan];
        [array3 addObject:strYue];
        zongHuanNumber= [zongHuanNumber decimalNumberByAdding:yueHuanNumber];
    }
    NSString *zongHuanStr = [zongHuanNumber stringValue];
    NSDecimalNumber *zhiLiNumber = [zongHuanNumber decimalNumberByAdding:[daiZongNumber decimalNumberByMultiplyingBy:[NSDecimalNumber decimalNumberWithString:@"-1"]]];
    NSString *zhiLiStr = [zhiLiNumber stringValue];
    
    NSArray * array1 = [NSArray arrayWithObjects:@"贷款总额",@"还款总额",@"支付利息",@"贷款月数",nil];
    NSString * str1 = [NSString stringWithFormat:@"%.2f 元",[daiZongStr doubleValue]];
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
    [self.navigationController pushViewController:fvc animated:YES];
}
//总价月利率月均还款算法等额本息
/**
 *	@brief	公积金总价月利率月均还款算法等额本息
 *
 *	@param 	lilvStrTemp
 *
 *	@return	 无
 */
-(void)acumulationTotalPric:(NSString *)lilvStrTemp
{
    NSDecimalNumber *daiZongNumber = [NSDecimalNumber decimalNumberWithString:_gongZong.text];
    daiZongNumber = [daiZongNumber decimalNumberByMultiplyingBy:[NSDecimalNumber decimalNumberWithString:@"10000"]];
    NSString *daiZongStr = [daiZongNumber stringValue];
    int yueShu = [[_array_6 objectAtIndex:[_array_2 indexOfObject:_gongDanNianStr]] intValue]*12;//贷款月数
    NSDecimalNumber *yueShuNumber = [NSDecimalNumber decimalNumberWithString:[NSString stringWithFormat:@"%d",yueShu]];
    NSDecimalNumber *liLvNumber = [NSDecimalNumber decimalNumberWithString:lilvStrTemp];
    liLvNumber = [liLvNumber decimalNumberByDividingBy:[NSDecimalNumber decimalNumberWithString:@"100"]];
    NSDecimalNumber *yueLilvNumber = [liLvNumber decimalNumberByDividingBy:[NSDecimalNumber decimalNumberWithString:@"12"]];
    NSDecimalNumber *yueHuanNumber = [daiZongNumber decimalNumberByMultiplyingBy:yueLilvNumber];
    NSDecimalNumber *xNumber = [NSDecimalNumber decimalNumberWithString:@"1"];
    NSDecimalNumber *yNumber = yueLilvNumber;
    xNumber = [xNumber decimalNumberByAdding:yNumber];
    NSDecimalNumber *objectOneNumber = [xNumber decimalNumberByRaisingToPower:yueShu];
    NSDecimalNumber *objectTwoNumber = [objectOneNumber decimalNumberByAdding:[NSDecimalNumber decimalNumberWithString:@"-1"]];
    yueHuanNumber = [yueHuanNumber decimalNumberByMultiplyingBy:objectOneNumber];
    
    yueHuanNumber = [yueHuanNumber decimalNumberByDividingBy:objectTwoNumber];
    NSString *yueHuanStr = [yueHuanNumber stringValue];
    NSDecimalNumber *zongHuanNumber = [yueHuanNumber decimalNumberByMultiplyingBy:yueShuNumber];
    NSString *zongHuanStr = [zongHuanNumber stringValue];
    NSDecimalNumber *huanLiNumber = [zongHuanNumber decimalNumberByAdding:[[NSDecimalNumber decimalNumberWithString:@"-1"]decimalNumberByMultiplyingBy:daiZongNumber]];
    NSString *huanLiStr = [huanLiNumber stringValue];
    ;
    
    NSArray * array1 = [NSArray arrayWithObjects:@"贷款总额",@"还款总额",@"支付利息",@"贷款月数",@"月均还款", nil];
    NSString * str1 = [NSString stringWithFormat:@"%.2lf 元",[daiZongStr doubleValue]];
    NSString * str2 = [NSString stringWithFormat:@"%.2lf 元",[zongHuanStr doubleValue]];
    NSString * str3 = [NSString stringWithFormat:@"%.2lf 元",[huanLiStr doubleValue]];
    NSString * str4 = [NSString stringWithFormat:@"%d 月",yueShu];
    NSString * str5 = [NSString stringWithFormat:@"%.2lf 元",[yueHuanStr doubleValue]];
    NSArray * array2 = [NSArray arrayWithObjects:str1,str2,str3,str4,str5, nil];
    HWFangResultViewController * fvc = [[HWFangResultViewController alloc]init];
    fvc.nameArray_1 = array1;
    fvc.dataArray_1 = array2;
    fvc.xianType = @"1";
    [self.navigationController pushViewController:fvc animated:YES];
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
    float gongKuan = [_gongDai.text floatValue]*10000;//公积金贷款
    float shangKuan = [_shangDai.text floatValue]*10000;//商业贷款
    NSDecimalNumber *gongKuanNumber = [NSDecimalNumber decimalNumberWithString:[NSString stringWithFormat:@"%f",gongKuan]];
    NSDecimalNumber *shangKuanNumber = [NSDecimalNumber decimalNumberWithString:[NSString stringWithFormat:@"%f",shangKuan]];
    int yueShu = [[_array_6 objectAtIndex:[_array_2 indexOfObject:_zuheNianStr]] intValue]*12;//贷款月数
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
    [self.navigationController pushViewController:fvc animated:YES];
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
    float gongKuan = [_gongDai.text floatValue]*10000;//公积金贷款
    float shangKuan = [_shangDai.text floatValue]*10000;//商业贷款
    NSDecimalNumber *gongKuanNumber = [NSDecimalNumber decimalNumberWithString:[NSString stringWithFormat:@"%f",gongKuan]];
    NSDecimalNumber *shangKuanNumber = [NSDecimalNumber decimalNumberWithString:[NSString stringWithFormat:@"%f",shangKuan]];
    int yueShu = [[_array_6 objectAtIndex:[_array_2 indexOfObject:_zuheNianStr]] intValue]*12;//贷款月数
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
    [self.navigationController pushViewController:fvc animated:YES];
}

#pragma mark - 绘制商贷页面
/**
 *	@brief	绘制商贷的页面
 *
 *	@return	 无
 */
-(void)createBusinessView
    
{
    self.fangDaiTab = [[UITableView alloc]initWithFrame:CGRectMake(0, 50, kScreenWidth, 275+50)];
    self.fangDaiTab.delegate = self;
    self.fangDaiTab.dataSource = self;
    self.fangDaiTab.separatorStyle = UITableViewCellSeparatorStyleNone;
    [_userContentView addSubview:self.fangDaiTab];
    
    _fangDaiOneTab = [[UITableView alloc]initWithFrame:CGRectMake(0, 50, kScreenWidth,275+110+50)];
    [_userContentView addSubview:_fangDaiOneTab];
    _fangDaiOneTab.scrollEnabled = NO;
    _fangDaiOneTab.delegate = self;
    _fangDaiOneTab.dataSource = self;
    _fangDaiOneTab.dataSource = self;
    [_userContentView addSubview:_fangDaiOneTab];
    [self createFootView];

}
/**
 *	@brief	绘制公积金页面
 *
 *	@return	 无
 */
-(void)creatAccumulation
{
    _gongJiJingTab = [[UITableView alloc]initWithFrame:CGRectMake(0, 50, kScreenWidth, 275+21)];
    _gongJiJingTab.delegate = self;
    _gongJiJingTab.dataSource = self;
    _gongJiJingTab.separatorStyle = UITableViewCellSeparatorStyleNone;
    [_userContentView addSubview:_gongJiJingTab];
    
    _gongJiJingOneTab = [[UITableView alloc]initWithFrame:CGRectMake(0, 50, kScreenWidth, 275+110+21)];
    _gongJiJingOneTab.delegate = self;
    _gongJiJingOneTab.dataSource = self;
    _gongJiJingOneTab.separatorStyle = UITableViewCellSeparatorStyleNone;
    [_userContentView addSubview:_gongJiJingOneTab];
    [self createFootView];

}
/**
 *	@brief	绘制组合页面
 *
 *	@return	 无
 */
-(void)createAssociationView

{
    _zuHeTab = [[UITableView alloc]initWithFrame:CGRectMake(0, 50, kScreenWidth, 250)];
    _zuHeTab.delegate = self;
    _zuHeTab.dataSource = self;
    _zuHeTab.separatorStyle = UITableViewCellSeparatorStyleNone;
    [_userContentView addSubview:_zuHeTab];
    [self createFootView];

}
#pragma mark - tab代理
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (tableView == _fangDaiOneTab || tableView == _fangDaiTab || tableView == _zuHeTab || tableView == _gongJiJingOneTab || tableView == _gongJiJingTab)
    {
    return 55;
    }
    
    return 38;
}
-(void)pickUpAllTextfiled
{
    //回收键盘
    [_shangJiaGe resignFirstResponder];
    [_shangMianJi resignFirstResponder];
    [_shangZong resignFirstResponder];
    [_gongJiaGe resignFirstResponder];
    [_gongMianJi resignFirstResponder];
    [_gongZong resignFirstResponder];
    [_shangDai resignFirstResponder];
    [_gongDai resignFirstResponder];
}

/**
 *	@brief	返回公积金年数，利率以及索引
 *
 *	@param 	year
 *	@param 	rate
 *	@param 	indexTemp
 *
 *	@return	 年数，利率以及索引
 */
-(NSString *)returnAccumulation:(NSString *)year rate:(NSString *)rate index:(NSInteger)indexTemp
{
    NSString *tempStr = [NSString stringWithFormat:@"%@-2",rate];
    NSArray *arry = [_dic_data objectForKey:tempStr];
    NSDictionary* dic = [arry objectAtIndex:indexTemp];
    return [dic objectForKey:year];
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
    NSArray *arry = [_dic_data objectForKey:rate];
    NSDictionary* dic = [arry objectAtIndex:indexTemp];
    return [dic objectForKey:year];
}
- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    if (tableView == _fangDaiTab || tableView == _fangDaiOneTab || tableView == _gongJiJingTab||tableView == _gongJiJingOneTab) {
        return 55.0f;
    }
    else if(tableView == _zuHeTab)
    {
        return 55.0f;
    }
    else{
        return 0.0f;
    }
}


-(UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section
{
    
    if (tableView == _fangDaiTab) {
        UIView *footView = [[UIView alloc]initWithFrame:CGRectMake(0, 17, kScreenWidth, 20)];
        //显示利率
        _label_2 = [[UILabel alloc]initWithFrame:CGRectMake(182, 17, 100, 21)];
        _label_2.font = [UIFont fontWithName:FONTNAME size:14];
        _label_2.text = @"5.9%";
        _label_2.textAlignment = NSTextAlignmentLeft;
        _label_2.backgroundColor = [UIColor clearColor];
        _label_2.textColor = TITLE_COLOR_99;
        [footView addSubview:_label_2];
        
        UILabel *tempLabel = [[UILabel alloc]initWithFrame:CGRectMake(13, 17, 170, 21)];
        tempLabel.font = [UIFont fontWithName:FONTNAME size:14];
        tempLabel.text = @"商业贷款利率:";
        tempLabel.textAlignment = NSTextAlignmentRight;
        tempLabel.backgroundColor = [UIColor clearColor];
        tempLabel.textColor = TITLE_COLOR_99;
        [footView addSubview:tempLabel];
        return footView;
    }
    else if(tableView == _fangDaiOneTab)
    {
        UIView *footView = [[UIView alloc]initWithFrame:CGRectMake(0, 17, kScreenWidth, 20)];
        footView.backgroundColor = [UIColor clearColor];
        //显示利率
        _label_1 = [[UILabel alloc]initWithFrame:CGRectMake(182, 17, 100, 21)];
        _label_1.font = [UIFont fontWithName:FONTNAME size:14];
        _label_1.textAlignment = NSTextAlignmentLeft;
        _label_1.backgroundColor = [UIColor clearColor];
        [footView addSubview:_label_1];
        _label_1.textColor = TITLE_COLOR_99;
        _label_1.text =@"5.9%";
        
        
        UILabel *tempLabel = [[UILabel alloc]initWithFrame:CGRectMake(13, 17, 170, 21)];
        tempLabel.font = [UIFont fontWithName:FONTNAME size:14];
        tempLabel.text = @"商业贷款利率:";
        tempLabel.textAlignment = NSTextAlignmentRight;
        tempLabel.backgroundColor = [UIColor clearColor];
        tempLabel.textColor = UIColorFromRGB(0x999999);
        [footView addSubview:tempLabel];
        return footView;
    }
    else if(tableView == _gongJiJingTab)
    {
        UIView *footView = [[UIView alloc]initWithFrame:CGRectMake(0, 17, kScreenWidth, 20)];
        //显示利率
        _label_4 = [[UILabel alloc]initWithFrame:CGRectMake(200, 17, 100, 20)];
        _label_4.font = [UIFont fontWithName:FONTNAME size:14];
        _label_4.text = @"4.0%";
        _label_4.textAlignment = NSTextAlignmentLeft;
        _label_4.backgroundColor = [UIColor clearColor];
        _label_4.textColor = TITLE_COLOR_99;
        [footView addSubview:_label_4];
        
        
        UILabel *tempLabel = [[UILabel alloc]initWithFrame:CGRectMake(9, 17, 190, 21)];
        tempLabel.font = [UIFont fontWithName:FONTNAME size:14];
        tempLabel.text = @"公积金贷款利率:";
        tempLabel.textAlignment = NSTextAlignmentRight;
        tempLabel.backgroundColor = [UIColor clearColor];
        tempLabel.textColor = TITLE_COLOR_99;
        [footView addSubview:tempLabel];
        return footView;
    }
    else if(tableView == _gongJiJingOneTab)
    {
        UIView *footView = [[UIView alloc]initWithFrame:CGRectMake(0, 17, kScreenWidth, 20)];
        //显示利率
        _label_3 = [[UILabel alloc]initWithFrame:CGRectMake(200, 17, 100, 20)];
        _label_3.font = [UIFont fontWithName:FONTNAME size:14];
        _label_3.text = @"4.0%";
        _label_3.textAlignment = NSTextAlignmentLeft;
        _label_3.backgroundColor = [UIColor clearColor];
        _label_3.textColor = TITLE_COLOR_99;
        [footView addSubview:_label_3];
        
        UILabel *tempLabel = [[UILabel alloc]initWithFrame:CGRectMake(9, 17, 190, 21)];
        tempLabel.font = [UIFont fontWithName:FONTNAME size:14];
        tempLabel.text = @"公积金贷款利率:";
        tempLabel.textAlignment = NSTextAlignmentRight;
        tempLabel.backgroundColor = [UIColor clearColor];
        tempLabel.textColor = TITLE_COLOR_99;
        [footView addSubview:tempLabel];
        return footView;
    }
    else if(tableView == _zuHeTab)
    {
        
        UIView *footView = [[UIView alloc]initWithFrame:CGRectMake(0, 17, kScreenWidth, 20)];
        UILabel *tempLabelOne = [[UILabel alloc]initWithFrame:CGRectMake(68, 5, 130, 21)];
        tempLabelOne.font = [UIFont fontWithName:FONTNAME size:14];
        tempLabelOne.text = @"公积金贷款利率:";
        tempLabelOne.textAlignment = NSTextAlignmentRight;
        tempLabelOne.backgroundColor = [UIColor clearColor];
        tempLabelOne.textColor = TITLE_COLOR_99;
        [footView addSubview:tempLabelOne];
        //显示利率
        _label_5 = [[UILabel alloc]initWithFrame:CGRectMake(200, 5, 100, 20)];
        _label_5.font = [UIFont fontWithName:FONTNAME size:14];
        _label_5.text = @"4.0%";
        _label_5.textAlignment = NSTextAlignmentLeft;
        _label_5.backgroundColor = [UIColor clearColor];
        _label_5.textColor = TITLE_COLOR_99;
        [footView addSubview:_label_5];
        
        
        UILabel *tempLabel = [[UILabel alloc]initWithFrame:CGRectMake(84, 30, 100, 21)];
        tempLabel.font = [UIFont fontWithName:FONTNAME size:14];
        tempLabel.text = @"商业贷款利率:";
        tempLabel.textAlignment = NSTextAlignmentRight;
        tempLabel.backgroundColor = [UIColor clearColor];
        tempLabel.textColor = TITLE_COLOR_99;
        [footView addSubview:tempLabel];
        
        
        _label_6 = [[UILabel alloc]initWithFrame:CGRectMake(168, 30, 100, 20)];
        _label_6.font = [UIFont fontWithName:FONTNAME size:14];
        _label_6.text = @"5.9%";
        _label_6.textAlignment = NSTextAlignmentCenter;
        _label_6.backgroundColor = [UIColor clearColor];
        _label_6.textColor = TITLE_COLOR_99;
        [footView addSubview:_label_6];
        return footView;
    }
    
    return nil;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [self pickUpAllTextfiled];
    HWClickTableViewReturnViewController *returnTableView = [[HWClickTableViewReturnViewController alloc]init];
    __weak HWFangDaiVC * weakSelf = self;
    
    if (tableView == _fangDaiOneTab) {
        _rememberCell =(HWAreasTableViewCell*) [tableView cellForRowAtIndexPath:indexPath];
        switch (indexPath.row) {
            case 0:
                if (_tabArray.count>0) {
                    [_tabArray removeAllObjects];
                    [_tabArray addObjectsFromArray:self.repaymentArry];
                }
                else{
                    [_tabArray addObjectsFromArray:self.repaymentArry];
                }
                _popType = @"还款方式";
                _popLabel.text = @"还款方式";
                break;
            case 1:
                if (_tabArray.count>0) {
                    [_tabArray removeAllObjects];
                    [_tabArray addObjectsFromArray:self.caculateWayArry];
                }
                else{
                    [_tabArray addObjectsFromArray:self.caculateWayArry];
                }
                _popType = @"计算方式";
                _popLabel.text = @"计算方式";
                
                
                break;
            case 3:
                if (_tabArray.count>0) {
                    [_tabArray removeAllObjects];
                    [_tabArray addObjectsFromArray:_array_2];
                }
                else{
                    [_tabArray addObjectsFromArray:_array_2];
                }
                _popType = @"商贷总价按揭年数";
                _popLabel.text = @"按揭年数";
                break;
                
            case 4:
                if (_tabArray.count>0) {
                    [_tabArray removeAllObjects];
                    [_tabArray addObjectsFromArray:_array_3];
                }
                else{
                    [_tabArray addObjectsFromArray:_array_3];
                }
                _popType = @"商贷总价按揭利率";
                _popLabel.text = @"按揭利率";
                break;
            default:
                break;
        }

    
        if (indexPath.row == 1 ||indexPath.row == 0 ||indexPath.row ==3 ||indexPath.row ==4)
        {
            returnTableView.dataArry = _tabArray;
            
            [returnTableView setReturnSelectedResult:^(NSString *result,NSInteger indexTemp)
             {
                 NSLog(@"the result is %@",result);
                 weakSelf.xianString = result;
                 weakSelf.rememberCell.textFiled.text = result;
                 if (indexPath.row == 3) {
                     weakSelf.index = indexTemp;
                 }
                 else if(indexPath.row == 4)
                 {
                     weakSelf.rateIndex = indexTemp;
                 }
                 [weakSelf sure];
             }];
            HWAreasTableViewCell *cell = (HWAreasTableViewCell *)[tableView cellForRowAtIndexPath:indexPath];
            returnTableView.typeStr = cell.textFiled.text;
            [self.navigationController pushViewController:returnTableView animated:YES];
        }
    }
    else if(tableView == _fangDaiOneTab)
    {
        _rememberCell =(HWAreasTableViewCell*)[tableView cellForRowAtIndexPath:indexPath];
        switch (indexPath.row) {
            case 0:
                if (_tabArray.count>0) {
                    [_tabArray removeAllObjects];
                    [_tabArray addObjectsFromArray:self.repaymentArry];
                }
                else{
                    [_tabArray addObjectsFromArray:self.repaymentArry];
                }
                _popType = @"还款方式";
                _popLabel.text = @"还款方式";
                break;
            case 1:
                if (_tabArray.count>0) {
                    [_tabArray removeAllObjects];
                    [_tabArray addObjectsFromArray:self.caculateWayArry];
                }
                else{
                    [_tabArray addObjectsFromArray:self.caculateWayArry];
                }
                _popType = @"计算方式";
                _popLabel.text = @"计算方式";
                break;
                
            case 4:
                if (_tabArray.count>0) {
                    [_tabArray removeAllObjects];
                    [_tabArray addObjectsFromArray:_array_1];
                }
                else{
                    [_tabArray addObjectsFromArray:_array_1];
                }
                _popType = @"商贷按揭成数";
                _popLabel.text = @"按揭成数";
                break;
                
                
            case 5:
                if (_tabArray.count>0) {
                    [_tabArray removeAllObjects];
                    [_tabArray addObjectsFromArray:_array_2];
                }
                else{
                    [_tabArray addObjectsFromArray:_array_2];
                }
                _popType = @"商贷按揭年数";
                _popLabel.text = @"按揭年数";
                break;
                
            case 6:
                if (_tabArray.count>0) {
                    [_tabArray removeAllObjects];
                    [_tabArray addObjectsFromArray:_array_3];
                }
                else{
                    [_tabArray addObjectsFromArray:_array_3];
                }
                _popType = @"商贷按揭利率";
                _popLabel.text = @"按揭利率";
                break;
            default:
                break;
        }
        if (indexPath.row == 1 ||indexPath.row == 0 ||indexPath.row ==5 ||indexPath.row ==4 ||indexPath.row == 6)
        {
            returnTableView.dataArry = _tabArray;
            
            [returnTableView setReturnSelectedResult:^(NSString *result,NSInteger indexTemp)
             {
                 NSLog(@"the result is %@",result);
                 weakSelf.xianString = result;
                 weakSelf.rememberCell.textFiled.text = result;
                 if (indexPath.row == 5) {
                     weakSelf.index = indexTemp;
                 }
                 else if(indexPath.row == 6)
                 {
                     weakSelf.rateIndex = indexTemp;
                 }
                 [weakSelf sure];
                 
             }];
            HWAreasTableViewCell *cell = (HWAreasTableViewCell *)[tableView cellForRowAtIndexPath:indexPath];
            returnTableView.typeStr = cell.textFiled.text;
            [self.navigationController pushViewController:returnTableView animated:YES];
        }
    }
    else if (tableView == _gongJiJingTab) {
        _rememberCell =(HWAreasTableViewCell*) [tableView cellForRowAtIndexPath:indexPath];
        switch (indexPath.row) {
            case 0:
                if (_tabArray.count>0) {
                    [_tabArray removeAllObjects];
                    [_tabArray addObjectsFromArray:self.repaymentArry];
                }
                else{
                    [_tabArray addObjectsFromArray:self.repaymentArry];
                }
                _popType = @"还款方式";
                _popLabel.text = @"还款方式";
                break;
            case 1:
                if (_tabArray.count>0) {
                    [_tabArray removeAllObjects];
                    [_tabArray addObjectsFromArray:self.caculateWayArry];
                }
                else{
                    [_tabArray addObjectsFromArray:self.caculateWayArry];
                }
                _popType = @"计算方式";
                _popLabel.text = @"计算方式";
                break;
            case 3:
                if (_tabArray.count>0) {
                    [_tabArray removeAllObjects];
                    [_tabArray addObjectsFromArray:_array_2];
                }
                else{
                    [_tabArray addObjectsFromArray:_array_2];
                }
                _popType = @"公积金总价按揭年数";
                _popLabel.text = @"按揭年数";
                break;
                
            case 4:
                if (_tabArray.count>0) {
                    [_tabArray removeAllObjects];
                    [_tabArray addObjectsFromArray:_array_3];
                }
                else{
                    [_tabArray addObjectsFromArray:_array_3];
                }
                _popType = @"公积金总价按揭利率";
                _popLabel.text = @"按揭利率";
                break;
            default:
                break;
        }
        if (indexPath.row == 1 ||indexPath.row == 0 ||indexPath.row ==3 ||indexPath.row ==4 )
        {
            returnTableView.dataArry = _tabArray;
            
            [returnTableView setReturnSelectedResult:^(NSString *result,NSInteger indexTemp)
             {
                 NSLog(@"the result is %@",result);
                 weakSelf.xianString = result;
                 weakSelf.rememberCell.textFiled.text = result;
                 if (indexPath.row == 3) {
                     weakSelf.index = indexTemp;
                 }
                 else if(indexPath.row == 4)
                 {
                     weakSelf.rateIndex = indexTemp;
                 }
                 
                 [weakSelf sure];
                 
             }];
            HWAreasTableViewCell *cell = (HWAreasTableViewCell *)[tableView cellForRowAtIndexPath:indexPath];
            returnTableView.typeStr = cell.textFiled.text;
            [self.navigationController pushViewController:returnTableView animated:YES];
        }
    }
    else if(tableView == _gongJiJingOneTab)
    {
        _rememberCell =(HWAreasTableViewCell*)[tableView cellForRowAtIndexPath:indexPath];
        switch (indexPath.row) {
            case 0:
                if (_tabArray.count>0) {
                    [_tabArray removeAllObjects];
                    [_tabArray addObjectsFromArray:self.repaymentArry];
                }
                else{
                    [_tabArray addObjectsFromArray:self.repaymentArry];
                }
                _popType = @"还款方式";
                _popLabel.text = @"还款方式";
                break;
            case 1:
                if (_tabArray.count>0) {
                    [_tabArray removeAllObjects];
                    [_tabArray addObjectsFromArray:self.caculateWayArry];
                }
                else{
                    [_tabArray addObjectsFromArray:self.caculateWayArry];
                }
                _popType = @"计算方式";
                _popLabel.text = @"计算方式";
                break;
                
            case 4:
                if (_tabArray.count>0) {
                    [_tabArray removeAllObjects];
                    [_tabArray addObjectsFromArray:_array_1];
                }
                else{
                    [_tabArray addObjectsFromArray:_array_1];
                }
                _popType = @"公积金按揭成数";
                _popLabel.text = @"按揭成数";
                break;
                
                
            case 5:
                if (_tabArray.count>0) {
                    [_tabArray removeAllObjects];
                    [_tabArray addObjectsFromArray:_array_2];
                }
                else{
                    [_tabArray addObjectsFromArray:_array_2];
                }
                _popType = @"公积金按揭年数";
                _popLabel.text = @"按揭年数";
                break;
                
            case 6:
                if (_tabArray.count>0) {
                    [_tabArray removeAllObjects];
                    [_tabArray addObjectsFromArray:_array_3];
                }
                else{
                    [_tabArray addObjectsFromArray:_array_3];
                }
                _popType = @"公积金按揭利率";
                _popLabel.text = @"按揭利率";
                break;
            default:
                break;
        }
        if  (indexPath.row == 1 ||indexPath.row == 0 ||indexPath.row ==5 ||indexPath.row ==4 ||indexPath.row == 6)
        {
            returnTableView.dataArry = _tabArray;
            
            [returnTableView setReturnSelectedResult:^(NSString *result,NSInteger indexTemp)
             {
                 NSLog(@"the result is %@",result);
                 weakSelf.xianString = result;
                 weakSelf.rememberCell.textFiled.text = result;
                 if (indexPath.row == 5) {
                     weakSelf.index = indexTemp;
                 }
                 else if(indexPath.row == 6)
                 {
                     weakSelf.rateIndex = indexTemp;
                 }
                 
                 [weakSelf sure];
                 
             }];
            HWAreasTableViewCell *cell = (HWAreasTableViewCell *)[tableView cellForRowAtIndexPath:indexPath];
            returnTableView.typeStr = cell.textFiled.text;
            [self.navigationController pushViewController:returnTableView animated:YES];
        }
        
    }
    if (tableView == _zuHeTab) {
        _rememberCell =(HWAreasTableViewCell*) [tableView cellForRowAtIndexPath:indexPath];
        switch (indexPath.row) {
            case 0:
                if (_tabArray.count>0) {
                    [_tabArray removeAllObjects];
                    [_tabArray addObjectsFromArray:self.repaymentArry];
                }
                else{
                    [_tabArray addObjectsFromArray:self.repaymentArry];
                }
                _popType = @"还款方式";
                _popLabel.text = @"还款方式";
                break;
                
            case 3:
                if (_tabArray.count>0) {
                    [_tabArray removeAllObjects];
                    [_tabArray addObjectsFromArray:_array_2];
                }
                else{
                    [_tabArray addObjectsFromArray:_array_2];
                }
                _popType = @"组合型按揭年数";
                _popLabel.text = @"按揭年数";
                break;
                
            case 4:
                if (_tabArray.count>0) {
                    [_tabArray removeAllObjects];
                    [_tabArray addObjectsFromArray:_array_3];
                }
                else{
                    [_tabArray addObjectsFromArray:_array_3];
                }
                _popType = @"组合型按揭利率";
                _popLabel.text = @"按揭利率";
                break;
            default:
                break;
        }
        if (indexPath.row == 0 ||indexPath.row ==3 ||indexPath.row ==4)
        {
            returnTableView.dataArry = _tabArray;
            
            [returnTableView setReturnSelectedResult:^(NSString *result,NSInteger indexTemp)
             {
                 NSLog(@"the result is %@",result);
                 weakSelf.xianString = result;
                 weakSelf.rememberCell.textFiled.text = result;
                 if (indexPath.row == 3) {
                     weakSelf.index = indexTemp;
                 }
                 else if(indexPath.row == 4)
                 {
                     weakSelf.rateIndex = indexTemp;
                 }
                 
                 [weakSelf sure];
                 
             }];
            HWAreasTableViewCell *cell = (HWAreasTableViewCell *)[tableView cellForRowAtIndexPath:indexPath];
            returnTableView.typeStr = cell.textFiled.text;
            [self.navigationController pushViewController:returnTableView animated:YES];
        }
        
    }

}
/**
 *	@brief	确认以何种方式计算
 *
 *	@return	 无
 */
-(void)sure

{
    
    if ([_popType isEqualToString:@"还款方式"]) {
        if (_xianString.length>0) {
            _huanKuanType = _xianString;
            return;
        }
    }
    if ([_popType isEqualToString:@"计算方式"]) {
        if (_xianString.length>0) {
            _rateStr = @"5.9%";
            self.rateIndex = 0;
            self.index = 19;
            _lilvStr = shangDefault;
            if ([_xianString isEqualToString:@"按单价计算"]) {
                if (_segmentControl.selectedSegmentIndex == 0) {
                    _fangDaiOneTab.hidden = NO;
                    _fangDaiTab.hidden = YES;
                    [_fangDaiOneTab reloadData];
                }
                else if(_segmentControl.selectedSegmentIndex == 1)
                {
                    _gongJiJingTab.hidden = YES;
                    _gongJiJingOneTab.hidden = NO;
                    [_gongJiJingOneTab reloadData];
                    
                }
                return;
                
            }
            else if ([_xianString isEqualToString:@"按总价计算"])
            {
                if (_segmentControl.selectedSegmentIndex == 0) {
                    _fangDaiOneTab.hidden = YES;
                    _fangDaiTab.hidden = NO;
                    [_fangDaiTab reloadData];
                }
                else if(_segmentControl.selectedSegmentIndex == 1)
                {
                    
                    _gongJiJingTab.hidden = NO;
                    _gongJiJingOneTab.hidden = YES;
                    [_gongJiJingTab reloadData];
                    
                }
                return;
            }
        }
    }
    if ([_popType isEqualToString:@"商贷按揭成数"]) {
        if (_xianString.length>0) {
            _shangDanChengStr = _xianString;
            return;
            
        }
    }
    if ([_popType isEqualToString:@"商贷按揭年数"]) {
        if (_xianString.length>0) {
            _shangDanNianStr = _xianString;
            _rateStr = [self returnRate:_shangDanNianStr rate:_lilvStr index:self.index];
            _label_1.text = _rateStr;
            return;
            
        }
    }
    if ([_popType isEqualToString:@"商贷总价按揭年数"]) {
        if (_xianString.length>0) {
            _shangDanNianStr = _xianString;
            _rateStr = [self returnRate:_shangDanNianStr rate:_lilvStr index:self.index];
            _label_2.text = _rateStr;
            return;
            
        }
    }
    
    if ([_popType isEqualToString:@"商贷按揭利率"]) {
        if (_xianString.length>0) {
            _rateStr = [self returnRate:_shangDanNianStr rate:self.xianString index:self.index];
            _lilvStr = self.xianString;
            _label_1.text = _rateStr;
            return;
        }
    }
    if ([_popType isEqualToString:@"商贷总价按揭成数"]) {
        if (_xianString.length>0) {
            
            _shangDanChengStr = _xianString;
            return;
        }
    }
    if ([_popType isEqualToString:@"商贷总价按揭利率"]) {
        if (_xianString.length>0) {
            
            _rateStr = [self returnRate:_shangDanNianStr rate:self.xianString index:self.index];
            _lilvStr = self.xianString;
            _label_2.text = _rateStr;
            return;
        }
    }
    if ([_popType isEqualToString:@"公积金按揭成数"]) {
        if (_xianString.length>0) {
            
            _gongDanChengStr = _xianString;
            return;
        }
    }
    if ([_popType isEqualToString:@"公积金按揭年数"]) {
        if (_xianString.length>0) {
            
            _gongDanNianStr = _xianString;
            _rateStr = [self returnAccumulation:_gongDanNianStr rate:_lilvStr index:self.index];
            _label_3.text = _rateStr;
            return;
        }
    }
    if ([_popType isEqualToString:@"公积金按揭利率"]) {
        if (_xianString.length>0) {
            _lilvStr = self.xianString;
            _rateStr = [self returnAccumulation:_gongDanNianStr rate:_lilvStr index:self.index];
            
            _label_3.text = _rateStr;
            return;
        }
    }
    if ([_popType isEqualToString:@"公积金总价按揭年数"]) {
        if (_xianString.length>0) {
            _gongDanNianStr = _xianString;
            _rateStr = [self returnAccumulation:_gongDanNianStr rate:_lilvStr index:self.index];
            _label_4.text = _rateStr;
            return;
        }
    }
    if ([_popType isEqualToString:@"公积金总价按揭利率"]) {
        if (_xianString.length>0) {
            _lilvStr = self.xianString;
            _rateStr = [self returnAccumulation:_gongDanNianStr rate:_lilvStr index:self.index];
            _label_4.text = _rateStr;
            return;
        }
    }
    if ([_popType isEqualToString:@"组合型按揭年数"]) {
        if (_xianString.length>0) {
            _zuheNianStr = _xianString;
            _rateStr = [self returnRate:_zuheNianStr rate:_lilvStr index:self.index];
            _accumulationStr = [self returnAccumulation:_zuheNianStr rate:_lilvStr index:self.index];
            _label_5.text = _accumulationStr;
            _label_6.text = _rateStr;
            
            return;
        }
    }
    if ([_popType isEqualToString:@"组合型按揭利率"]) {
        if (_xianString.length>0) {
            _lilvStr = self.xianString;
            _rateStr = [self returnRate:_zuheNianStr rate:_lilvStr index:self.index];
            _accumulationStr = [self returnAccumulation:_zuheNianStr rate:_lilvStr index:self.index];
            _label_5.text = [NSString stringWithFormat:@"%@",_accumulationStr];
            _label_6.text = [NSString stringWithFormat:@"%@",_rateStr  ];
            return;
        }
    }
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (tableView == _fangDaiTab)
    {
        return self.businessOneArry.count;
    }
    else if (tableView == _fangDaiOneTab)
    {
        return self.businessTwoArry.count;
    }
    else if (tableView == _gongJiJingTab)
        
    {
        return self.businessOneArry.count;
    }
    else if(tableView == _gongJiJingOneTab)
    {
        return self.businessOneArry.count;
    }
    else if (tableView == _zuHeTab)
    {
        return self.associationArry.count;
    }
    else
    {
    return _tabArray.count;
    }
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (tableView == self.fangDaiTab)
    {
        HWAreasTableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:@"cell"];
        if (!cell)
        {
            cell = [[HWAreasTableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"cell"];
            
        }

        NSInteger row = indexPath.row;
        cell.textFiled.userInteractionEnabled = NO;
        if (indexPath.row == 0)
        {
            cell.textFiled.text = @"等额本息";
            
            _suanType = @"等额本息";
            
        }

        if (indexPath.row == 1)
        {
            cell.textFiled.text = @"按总价计算";
            _suanType = @"总价计算";
            
        }

        if (row == 2)
        {
            cell.textFiled.userInteractionEnabled = YES;
            cell.textFiled.placeholder = @"请输入贷款金额";
            cell.unitLabel.text = @"万元";
            
        }
        if (indexPath.row == 3) {
            cell.textFiled.text = [_array_2 objectAtIndex:19];
        }
        
        if (indexPath.row == 4) {
            cell.textFiled.text = [_array_3 objectAtIndex:0];
            
        }
        cell.textLabel.text = self.businessOneArry[indexPath.row];
        [cell drawButtomLine];
        return cell;
    }
    else if (tableView == _fangDaiOneTab)
    {
        HWAreasTableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:@"cell"];
        if (!cell)
        {
            cell = [[HWAreasTableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"cell"];
            
        }
        if (indexPath.row == 0) {
            cell.textFiled.text = @"等额本息";
            _huanKuanType = @"单价计算";
            
        }
        else if (indexPath.row == 1)
        {
            cell.textFiled.text = @"按单价计算";
            _suanType = @"dan";
        }
       else if (indexPath.row == 2 )
        {
            cell.textFiled.placeholder = @"请输入单价";
            cell.unitLabel.text = @"元/㎡";
        }
        else if (indexPath.row == 3)
        {
            cell.textFiled.placeholder = @"请输入面积";
            cell.unitLabel.text = @"㎡";

        }
        else if (indexPath.row == 4)
        {
            cell.textFiled.text = [_array_1 objectAtIndex:2];
            _gongDanChengStr = [_array_2 objectAtIndex:19];
        }
        else if (indexPath.row == 5)
        {
            cell.textFiled.text = [_array_2 objectAtIndex:19];
            _gongDanNianStr  = [_array_2 objectAtIndex:19];
        }
        else if (indexPath.row == 6)
        {
            cell.textFiled.text = [_array_3 objectAtIndex:0];
        }
        cell.titleLabel.text = self.businessTwoArry[indexPath.row];
        return cell;
    }
    else if (tableView == _gongJiJingTab)
    {
        HWAreasTableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:@"cell"];
        if (!cell)
        {
            cell = [[HWAreasTableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"cell"];
            
        }
        if (indexPath.row == 0) {
            cell.textFiled.text = @"等额本息";
            _huanKuanType = @"等额本息";
            
        }
        if (indexPath.row == 1) {
            cell.textFiled.text = @"按总价计算";
            _accmulationSuanType = @"总价计算";
            
        }
        if (indexPath.row == 2) {
            cell.unitLabel.text = @"万元";
            cell.textFiled.placeholder = @"请输入贷款总额";
        }
        if (indexPath.row == 3) {
            cell.textFiled.text = [_array_2 objectAtIndex:19];
            _gongZongNianStr = [_array_2 objectAtIndex:19];
        }
        if (indexPath.row == 4) {
            cell.textFiled.text = [_array_3 objectAtIndex:0];
            _gongZongLiLvStr = [_array_3 objectAtIndex:0];
        }
        cell.textLabel.text = self.businessOneArry[indexPath.row];
        
        return cell;
    }
    
    
    else if (tableView == _gongJiJingOneTab)
    {
        HWAreasTableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:@"cell"];
        if (!cell)
        {
            cell = [[HWAreasTableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"cell"];
            
        }
        if (indexPath.row == 0) {
            cell.textFiled.text = @"等额本息";
            _huanKuanType = @"单价计算";
            
        }
        else if (indexPath.row == 1)
        {
            cell.textFiled.text = @"按单价计算";
            _suanType = @"dan";
        }
        else if (indexPath.row == 2 )
        {
            cell.textFiled.placeholder = @"请输入单价";
            cell.unitLabel.text = @"元/㎡";
        }
        else if (indexPath.row == 3)
        {
            cell.textFiled.placeholder = @"请输入面积";
            cell.unitLabel.text = @"㎡";
            
        }
        else if (indexPath.row == 4)
        {
            cell.textFiled.text = [_array_1 objectAtIndex:2];
            _gongDanChengStr = [_array_1 objectAtIndex:2];
        }
        else if (indexPath.row == 5)
        {
            cell.textFiled.text = [_array_2 objectAtIndex:19];
            _gongDanNianStr  = [_array_2 objectAtIndex:19];
        }
        else if (indexPath.row == 6)
        {
            cell.textFiled.text = [_array_3 objectAtIndex:0];
        }
        cell.titleLabel.text = self.businessTwoArry[indexPath.row];
        return cell;
    }
    else if (tableView == _zuHeTab)
    {
        HWAreasTableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:@"cell"];
        if (!cell)
        {
            cell = [[HWAreasTableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"cell"];
            
        }
        if (indexPath.row == 0) {
            cell.textFiled.text = @"等额本息";
            _huanKuanType = @"等额本息";
        }
        if (indexPath.row == 1 || indexPath.row == 2) {
            cell.textFiled.placeholder = @"请输入金额";
            cell.unitLabel.text = @"万元";
        }
        if (indexPath.row == 3) {
            cell.textFiled.text = [_array_2 objectAtIndex:19];
            _zuheNianStr = [_array_2 objectAtIndex:19];
        }
        if (indexPath.row == 4) {
            cell.textFiled.text  = [_array_3 objectAtIndex:0];
        }
        cell.titleLabel.text = self.associationArry[indexPath.row];
        
        return cell;
    }
    else
    {
        tableView.separatorColor = [UIColor lightGrayColor];
        static NSString * CellWithIdentifier = @"Cell";
        UITableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:CellWithIdentifier];
        if (!cell) {
            cell = [[UITableViewCell alloc]init];
        }
        cell.selectedBackgroundView = [[UIView alloc]initWithFrame:cell.frame];
        cell.selectedBackgroundView.backgroundColor = [UIColor colorWithRed:238/255.0 green:238/255.0 blue:238/255.0 alpha:1];
        cell.textLabel.text = self.tabArray[indexPath.row];
        cell.textLabel.font = [UIFont fontWithName:FONTNAME size:14];
        return cell;

    }
}
-(BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string
{
    if (range.location >= 10) {
        return NO;
    }
    
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
-(void)textFieldDidEndEditing:(UITextField *)textField
{
    [_fangDaiTab setContentOffset:CGPointMake(0, 0) animated:YES];
    [_fangDaiOneTab setContentOffset:CGPointMake(0, 0) animated:YES];
    [_gongJiJingTab setContentOffset:CGPointMake(0, 0) animated:YES];
    [_gongJiJingOneTab setContentOffset:CGPointMake(0, 0) animated:YES];
    [_zuHeTab setContentOffset:CGPointMake(0, 0) animated:YES];
    
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
