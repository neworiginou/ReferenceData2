//
//  HWFangDaiBusiness.m
//  UtilityDemo
//
//  Created by lizhongqiang on 15/7/2.
//  Copyright (c) 2015年 hw. All rights reserved.
//

#import "HWFangDaiBusiness.h"

#import "HWAreaTableViewCell.h"

#import "HWHouseLoanTableViewCell.h"

#import "Define-OC.h"



@interface HWFangDaiBusiness ()<UITableViewDataSource,UITableViewDelegate>

@property (nonatomic, retain)NSArray *paymentMethod;

@property (nonatomic, strong)NSArray *computeMode;

@property (nonatomic, strong)NSArray *anjieArray;

@property (nonatomic, strong)NSArray *anjieYearArray;

@property (nonatomic, strong)NSArray *intersetRateArray;

@property (nonatomic, strong)NSArray *rateArray;

@property (nonatomic, strong)NSArray *oneDataArray;

@property (nonatomic, strong)NSArray *twoDataArray;



@property (nonatomic, assign)NSInteger temp;


@property (nonatomic, strong)UIView *contentView;

@property (nonatomic, strong)UIView *cover;

@property (nonatomic, strong)UILabel *rateLabel;


@end

@implementation HWFangDaiBusiness

- (instancetype)init
{
    if(self = [super init])
    {
        self.backgroundColor = [UIColor clearColor];
        
        _tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, kScreenWidth, 275+55)];
        
        _tableView.backgroundColor = [UIColor whiteColor];
        
        _tableView.delegate = self;
        
        _tableView.dataSource = self;
        
        [self addSubview:_tableView];
        
        UIView *line = [[UIView alloc] initWithFrame:CGRectMake(0, 0+330*0, kScreenWidth, 0.5)];
        [line setBackgroundColor:[UIColor lightGrayColor]];
        [self addSubview:line];
       
        
        
        _cellSelectedVC = [[HWFangSelectVC alloc]init];
        
        __unsafe_unretained HWFangDaiBusiness *weakSelf = self;
        
        _cellSelectedVC.reloadForTableView = ^(NSInteger temp)
        {
            weakSelf.temp = temp;
            
            [weakSelf.tableView reloadData];
        };
        
        
        [self initContentView];

        [self initDataArray];
        
        [self initCoverView];
        
        [self addObserVerForNews];
    }
    return self;
}
- (void)initContentView
{
    _contentView = [[UIView alloc]init];
    
    _contentView.frame = CGRectMake(0, CGRectGetMaxY(_tableView.frame), kScreenWidth, 100);
    
    _contentView.backgroundColor = [UIColor clearColor];
    
    [self addSubview:_contentView];
    //添加线
    UIView *line = [[UIView alloc] initWithFrame:CGRectMake(0, 0+330*0, kScreenWidth, 0.5)];
    [line setBackgroundColor:[UIColor lightGrayColor]];
    [_contentView addSubview:line];
    
    //添加按钮
    UIButton * shangOneBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    shangOneBtn.frame = CGRectMake(10, 40, kScreenWidth - 20, 50);
    [shangOneBtn setTitle:@"计算" forState:UIControlStateNormal];
    [shangOneBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    //    [shangOneBtn setButtonBackgroundShadowHighlight];
    [shangOneBtn setButtonRedAndOrangeBorderStyle];
    [shangOneBtn addTarget:self action:@selector(jiSuanAction:) forControlEvents:UIControlEventTouchUpInside];
    [self.contentView addSubview:shangOneBtn];
    
    UILabel *tempLabel  = [[UILabel alloc]initWithFrame:CGRectMake(10, 10, kScreenWidth - 20, 21)];
    tempLabel.font = [UIFont fontWithName:FONTNAME size:12];
    tempLabel.textColor = TITLE_COLOR_99;
    tempLabel.text = @"*等额本金还款额逐月减少，等额本息还款每月相同";
    tempLabel.textAlignment = NSTextAlignmentCenter;
    tempLabel.backgroundColor = [UIColor clearColor];
    [self.contentView addSubview:tempLabel];
}
- (void)initDataArray
{
    _paymentMethod = @[@"等额本息",@"等额本金"];
    
    _computeMode = @[@"按总价计算",@"按单价计算"];
    
    _anjieArray = @[@"9成",@"8成",@"7成",@"6成",@"5成",@"4成",@"3成",@"2成"];
    
    _anjieYearArray = @[@"1年(12期)",@"2年(24期)",@"3年(36期)",@"4年(48期)",@"5年(60期)",@"6年(72期)",@"7年(84期)",@"8年(96期)",@"9年(108期)",@"10年(120期)",@"11年(134期)",@"12年(144期)",@"13年(156期)",@"14年(168期)",@"15年(180期)",@"16年(192期)",@"17年(204期)",@"18年(216期)",@"19年(228期)",@"20年(240期)",@"21年(252期)",@"22年(264期)",@"23年(276期)",@"24年(288期)",@"25年(300期)",@"26年(312期)",@"27年(324期)",@"28年(336期)",@"29年(348期)",@"30年(360期)"];
    
    _intersetRateArray = @[@"15年3月1日基准利率",@"15年3月1日利率上限(1.1倍)",@"15年3月1日利率下限(85折)"];

    _oneDataArray = @[@"还款方式",@"计算方式",@"贷款总额",@"按揭年数",@"利率"];
    
    _twoDataArray = @[@"还款方式",@"计算方式",@"单价",@"面积",@"按揭成数",@"按揭年数",@"利率"];
    
    _temp = 0;
    
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

- (void)addObserVerForNews
{
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(zongEForValue:) name:@"shangdaiDaiKuanZongE" object:nil];
    
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(danJiaForValue:) name:@"shangdaiDanJia" object:nil];
    
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(mianJiForValue:) name:@"shangdaiMianJi" object:nil];
}

- (void)zongEForValue:(NSNotification *)notification
{
    _zongEValue = notification.object;

}

- (void)danJiaForValue:(NSNotification *)notification
{
    _danJiaValue = notification.object;

}

- (void)mianJiForValue:(NSNotification *)notification
{
    _mianJiValue = notification.object;

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

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if(_temp == 0 )
    {
        _tableView.frame = CGRectMake(_tableView.frame.origin.x, _tableView.frame.origin.y, _tableView.frame.size.width , 275+55);
        
        _contentView.frame = CGRectMake(_contentView.frame.origin.x, CGRectGetMaxY(_tableView.frame), _contentView.frame.size.width, _contentView.frame.size.height);
        
        return _oneDataArray.count;
    }
    else if(_temp == 1)
    {
        _tableView.frame = CGRectMake(_tableView.frame.origin.x, _tableView.frame.origin.y, _tableView.frame.size.width , 275+55+55*2);
        
        _contentView.frame = CGRectMake(_contentView.frame.origin.x, CGRectGetMaxY(_tableView.frame), _contentView.frame.size.width, _contentView.frame.size.height);
        
        return _twoDataArray.count;
    }
    return 0;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if(_temp == 0)
    {
        if(indexPath.row == 2)
        {
            static NSString *areaCellId = @"areaCellId";
            
            HWAreaTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:areaCellId];
            
            if(cell == nil)
            {
                cell = [[HWAreaTableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:areaCellId];
            }
            
            cell.cover = self.cover;
            
            cell.titleLabel.text = _oneDataArray[indexPath.row];
            
            cell.unitLabel.text = @"万元";
            
            cell.textfield.attributedPlaceholder = [[NSMutableAttributedString alloc]initWithString:@"请输入贷款总额" attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:15]}];
            
            return cell;
            
        }
        else
        {
            static NSString *loanCellId = @"LoanCellID";
            
            HWHouseLoanTableViewCell *loanCell = [tableView dequeueReusableCellWithIdentifier:loanCellId];
            
            if(loanCell == nil)
            {
                loanCell = [[HWHouseLoanTableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:loanCellId];
            }
            
            loanCell.titleLabel.text = _oneDataArray[indexPath.row];
            
            switch (indexPath.row) {
                case 0:
                    loanCell.titleContentLabel.text = _paymentMethod[_cellSelectedVC.paymentIndex];
                    break;
                case 1:
                    loanCell.titleContentLabel.text = _computeMode[_cellSelectedVC.compentIndex];
                    break;
                case 3:
                    loanCell.titleContentLabel.text = _anjieYearArray[_cellSelectedVC.anjieYearIndex];
                    break;
                case 4:
                    loanCell.titleContentLabel.text = _intersetRateArray[_cellSelectedVC.rateIndex];
                    break;
                default:
                    break;
            }
            
            return loanCell;
        }
        
    }
    else
    {
        if(indexPath.row == 2|| indexPath.row == 3)
        {
            
            static NSString *areaCellId = @"areaCellId";
            
            HWAreaTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:areaCellId];
            
            if(cell == nil)
            {
                cell = [[HWAreaTableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:areaCellId];
            }
            
            cell.cover = self.cover;
            
            cell.titleLabel.text = _twoDataArray[indexPath.row];
            
            switch (indexPath.row) {
                case 2:
                    
                    cell.textfield.attributedPlaceholder = [[NSMutableAttributedString alloc]initWithString:@"请输入单价" attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:15]}];
                    
                    cell.unitLabel.text = @"元/㎡";
                    
                    break;
                case 3:
                    
                    cell.textfield.attributedPlaceholder = [[NSMutableAttributedString alloc]initWithString:@"请输入面积" attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:15]}];
                    
                    cell.unitLabel.text = @"㎡";
                    
                    break;
                default:
                    break;
            }
            
            return cell;
        }
        else
        {
            static NSString *loanCellId = @"LoanCellID";
            
            HWHouseLoanTableViewCell *loanCell = [tableView dequeueReusableCellWithIdentifier:loanCellId];
            
            if(loanCell == nil)
            {
                loanCell = [[HWHouseLoanTableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:loanCellId];
            }
            
            loanCell.titleLabel.text = _twoDataArray[indexPath.row];
            
            loanCell.rightImage.hidden = NO;
            
            switch (indexPath.row) {
                case 0:
                    loanCell.titleContentLabel.text = _paymentMethod[_cellSelectedVC.paymentIndex];
                    
                    break;
                case 1:
                    loanCell.titleContentLabel.text = _computeMode[_cellSelectedVC.compentIndex];
                    
                    break;
                case 4:
                    loanCell.titleContentLabel.text = _anjieArray[_cellSelectedVC.anjieCountIndex];
                    
                    break;
                case 5:
                    loanCell.titleContentLabel.text = _anjieYearArray[_cellSelectedVC.anjieYearIndex];
                    
                    break;
                case 6:
                    loanCell.titleContentLabel.text = _intersetRateArray[_cellSelectedVC.rateIndex];
                    
                    break;
                
                default:
                    break;
            }
            
            return loanCell;
        }
    }
}
- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    return 55;
}
- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section
{
    UIView *footView = [[UIView alloc]initWithFrame:CGRectMake(0, 17, kScreenWidth, 20)];
    //显示利率
    
    UILabel *tempLabel = [[UILabel alloc]initWithFrame:CGRectMake(13, 17, 170, 21)];
   
    tempLabel.font = [UIFont fontWithName:FONTNAME size:14];
   
    tempLabel.text = @"商业贷款利率:";
    
    tempLabel.textAlignment = NSTextAlignmentRight;
    
    tempLabel.backgroundColor = [UIColor clearColor];
   
    tempLabel.textColor = TITLE_COLOR_99;
    
    [footView addSubview:tempLabel];
    
    UILabel *rateLabel = [[UILabel alloc]initWithFrame:CGRectMake(CGRectGetMaxX(tempLabel.frame), CGRectGetMinY(tempLabel.frame), 60, CGRectGetHeight(tempLabel.frame))];
    
    rateLabel.textColor = tempLabel.textColor;
    
    rateLabel.font = tempLabel.font;
    
    rateLabel.text = [self returnRate:_anjieYearArray[_cellSelectedVC.anjieYearIndex] rate:_intersetRateArray[_cellSelectedVC.rateIndex ] index:_cellSelectedVC.anjieYearIndex];
    
  //  NSLog(@"%@--%@---%ld",_anjieYearArray[_cellSelectedVC.anjieYearIndex],_intersetRateArray[_cellSelectedVC.rateIndex ],_cellSelectedVC.anjieYearIndex);
    
    [footView addSubview:rateLabel];
    
    _rateLabel = rateLabel;
    
    return footView;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 55.f;
}
#pragma mark 跳转
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if(self.turnToNextVC)
    {
        _temp = _cellSelectedVC.compentIndex;
        
        if(indexPath.row == 0)
        {
            _cellSelectedVC.dataArray = _paymentMethod;
        }
        else if(indexPath.row == 1)
        {
            _cellSelectedVC.dataArray = _computeMode;
        }
        else
        {
        switch (_temp) {
            case 0:
                if(indexPath.row == 3)
                {
                    _cellSelectedVC.dataArray = _anjieYearArray;
                }
                else if(indexPath.row == 4)
                {
                    _cellSelectedVC.dataArray = _intersetRateArray;
                }
                    
                
                break;
            case 1:
                if(indexPath.row == 4)
                {
                    _cellSelectedVC.dataArray = _anjieArray;
                    
                }else if(indexPath.row == 5)
                {
                    _cellSelectedVC.dataArray = _anjieYearArray;
                }
                else if(indexPath.row == 6)
                {
                    _cellSelectedVC.dataArray = _intersetRateArray;
                }
                
                break;
                
            default:
                break;
        }
        }
        
        _cellSelectedVC.selectedRow = indexPath.row;
        
        UITableViewCell *cell = [_tableView cellForRowAtIndexPath:indexPath];
        
        if(![cell isKindOfClass:[HWAreaTableViewCell class]])
        {
            self.turnToNextVC(_cellSelectedVC.compentIndex,indexPath.row);
        }
        
    }
}
- (void)jiSuanAction:(UIButton *)btn
{
    _resultType = [NSString stringWithFormat:@"%@%@",_paymentMethod[_cellSelectedVC.paymentIndex],_computeMode[_cellSelectedVC.compentIndex]
                  ];

    if ([_resultType isEqualToString:@"等额本息按单价计算"]) {
        if (_danJiaValue.length==0 && _mianJiValue.length>0) {
            UIAlertView * alert = [[UIAlertView alloc]initWithTitle:nil message:@"请输入单价" delegate:self cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
            [alert show];
        }
        else if (_mianJiValue.length==0 && _danJiaValue.length>0) {
            UIAlertView * alert = [[UIAlertView alloc]initWithTitle:nil message:@"请输入房屋面积" delegate:self cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
            [alert show];
        }
        else if (_danJiaValue.length==0 && _mianJiValue.length==0){
            UIAlertView * alert = [[UIAlertView alloc]initWithTitle:nil message:@"请输入单价" delegate:self cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
            [alert show];
        }
        else{
            //add by gusheng
            [self unitPrice:_rateLabel.text];
        }
    }

    if ([_resultType isEqualToString:@"等额本金按单价计算"]) {
        if (_danJiaValue.length==0 && _mianJiValue.length>0) {
            UIAlertView * alert = [[UIAlertView alloc]initWithTitle:nil message:@"请输入单价" delegate:self cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
            [alert show];
        }
        else if (_danJiaValue.length==0 && _mianJiValue.length>0) {
            UIAlertView * alert = [[UIAlertView alloc]initWithTitle:nil message:@"请输入房屋面积" delegate:self cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
            [alert show];
        }
        else if (_danJiaValue.length==0 && _mianJiValue.length==0){
            UIAlertView * alert = [[UIAlertView alloc]initWithTitle:nil message:@"请输入单价" delegate:self cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
            [alert show];
        }
        else{
            //add by gusheng
            [self unitBasePrice:_rateLabel.text];
        }
    }

    if ([_resultType isEqualToString:@"等额本息按总价计算"]) {
        if (_zongEValue.length==0) {
            UIAlertView * alert = [[UIAlertView alloc]initWithTitle:nil message:@"请输入贷款总额" delegate:self cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
            [alert show];
        }
        else{
            //add by gusheng
            [self totalPric:_rateLabel.text];
            //end
            
        }
    }

    if ([_resultType isEqualToString:@"等额本金按总价计算"]) {
        if (_zongEValue.length==0) {
            UIAlertView * alert = [[UIAlertView alloc]initWithTitle:nil message:@"请输入贷款总额" delegate:self cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
            [alert show];
        }
        else{
            //add by gusheng
            [self totalPrincSameBase:_rateLabel.text];
        }
    }

    
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
    NSDecimalNumber *jiaGeNumber = [NSDecimalNumber decimalNumberWithString:_danJiaValue];
    NSDecimalNumber *mianJiNumber = [NSDecimalNumber decimalNumberWithString:_mianJiValue];
    int nian = (int)_cellSelectedVC.anjieYearIndex+1;
    float cheng = [[_anjieArray[_cellSelectedVC.anjieCountIndex] substringWithRange:NSMakeRange(0, 1)] floatValue]/10;
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
    
    if(self.turnToResultVC)
    {
        self.turnToResultVC(fvc);
    }
}
-(void)unitBasePrice:(NSString *)lilvStrTemp
{
    ////每月还款数组
    NSMutableArray * array4 = [[NSMutableArray alloc]initWithCapacity:0];
    //月数数组
    NSMutableArray * array3 = [[NSMutableArray alloc]initWithCapacity:0];
    NSDecimalNumber *jiaGeNumber = [NSDecimalNumber decimalNumberWithString:_danJiaValue];
    NSDecimalNumber *mianJiNumber = [NSDecimalNumber decimalNumberWithString:_mianJiValue];
    NSDecimalNumber *ZongJiaNumber = [jiaGeNumber decimalNumberByMultiplyingBy:mianJiNumber];
    NSString *zongJiaStr = [ZongJiaNumber stringValue];
    // int nian = [[array_6 objectAtIndex:[array_2 indexOfObject:shangDanNianStr]] intValue];
    float cheng = [[_anjieArray[_cellSelectedVC.anjieCountIndex] substringWithRange:NSMakeRange(0, 1)] floatValue]/10;
    NSDecimalNumber *chengNumber = [NSDecimalNumber decimalNumberWithString:[NSString stringWithFormat:@"%f",cheng]];
    
    int yueShu = (int)(_cellSelectedVC.anjieYearIndex+1)*12;//贷款月数
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
    
    if(self.turnToResultVC)
    {
        self.turnToResultVC(fvc);
    }
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
    NSDecimalNumber *daiZongNumber = [NSDecimalNumber decimalNumberWithString:_zongEValue];
    daiZongNumber = [daiZongNumber decimalNumberByMultiplyingBy:[NSDecimalNumber decimalNumberWithString:@"10000"]];
    NSString *daiZongStr = [daiZongNumber stringValue];
    int yueShu = (int)(_cellSelectedVC.anjieYearIndex+1)*12;//贷款月数
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
    
    if(self.turnToResultVC)
    {
        self.turnToResultVC(fvc);
    }
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
    NSDecimalNumber *daiZongNumber = [NSDecimalNumber decimalNumberWithString:_zongEValue];
    daiZongNumber = [daiZongNumber decimalNumberByMultiplyingBy:[NSDecimalNumber decimalNumberWithString:@"10000"]];
    NSString *daiZongStr = [daiZongNumber stringValue];
    
    int yueShu = (int)(_cellSelectedVC.anjieYearIndex+1)*12;//贷款月数
    NSDecimalNumber *yueShuNumber = [NSDecimalNumber decimalNumberWithString:[NSString stringWithFormat:@"%d",yueShu]];//贷款月数
    NSDecimalNumber *lilvNumber = [NSDecimalNumber decimalNumberWithString:_rateLabel.text];
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
    
    fvc.xianType = @"2";if(self.turnToResultVC)
    {
        self.turnToResultVC(fvc);
    }
}

@end
