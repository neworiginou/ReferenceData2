//
//  FangDaiViewController.m
//  FangDaiDemo
//
//  Created by baiteng-5 on 14-1-6.
//  Copyright (c) 2014年 org.baiteng. All rights reserved.
//

#import "HWFangDaiViewController.h"
#import "HWFangResultViewController.h"
#import "HWHouseLoanTableViewCell.h"
#import "HWAreaTableViewCell.h"
#import "HWClickTableViewReturnViewController.h"
#import "Partner_Swift-Swift.h"
#import "Define-OC.h"

@interface HWFangDaiViewController ()
@property (nonatomic, retain)NSString *rateStr;
@property (nonatomic, retain)NSString *accumulationStr;
@property (nonatomic, retain)NSString *lilvStr;
@property (nonatomic, retain) NSDictionary *dic_data;
@property (nonatomic, retain) NSString *yearStr;
@property (nonatomic, assign) NSInteger index,rateIndex;
@property (nonatomic, retain) UISegmentedControl *segmentControl;
@property (nonatomic, retain) UIScrollView * userContentView;
@property (nonatomic, retain) UIButton * shangDaiBtn;//商贷按钮
@property (nonatomic, retain) UIButton * gongBtn;//公积金贷款按钮
@property (nonatomic, retain) UIButton * zuHeBtn;//组合型贷款按钮

@property (nonatomic, retain) UIView * shangDaiView;//商贷背景视图
@property (nonatomic, retain) UIView * sonShangView_one;//商贷子视图一
@property (nonatomic, retain) UIView * sonShangView_two;//商贷子视图二
@property (nonatomic, retain) UIView * gongView;//公积金背景视图
@property (nonatomic, retain) UIView * sonGongView_one;//公积金贷款子视图一
@property (nonatomic, retain) UIView * sonGongView_two;//公积金贷款子视图二
@property (nonatomic, retain) UIView * sonGongView;//公积金贷款子视图
@property (nonatomic, retain) UIView * zuHeView;//组合背景视图
@property (nonatomic, retain) UIView * sonZuView;//组合贷款子视图

@property (nonatomic, retain) UIButton * oneBtn;//等额本息
@property (nonatomic, retain) UIButton * twoBtn;//等额本金

@property (nonatomic, retain) NSString *zuheNianStr;

@property (nonatomic, retain) NSString * jiSuanType;//算法类型
@property (nonatomic, retain) NSString * huanKuanType;//还款类型
@property (nonatomic, retain) NSString * suanType;//房价计算类型

@property (nonatomic, retain) UIButton * shangDanBtn;//商贷按单价计价按钮
@property (nonatomic, retain) UIButton * shangZongBtn;//商贷按总价计价按钮
@property (nonatomic, retain) UIButton * gongDanBtn;//公积金按单价计价按钮
@property (nonatomic, retain) UIButton * gongZongBtn;//公积金按总价计价按钮
@property (nonatomic, retain) NSString *accmulationSuanType;
@property (nonatomic, retain) UITableView *businessTableOneView;//商业贷款列表
@property (nonatomic, retain) UITableView *businessTableTwoView;//商业贷款列表
@property (nonatomic, retain) UITableView *accmulationTableOneView;//公积金贷款列表
@property (nonatomic, retain) UITableView *accmulationTableTwoView;//公积金贷款列表
@property (nonatomic, retain) UITableView *associationTableView;//组合列表
@property (nonatomic, retain) NSArray *businessOneArry;
@property (nonatomic, retain) NSArray *businessTwoArry;
@property (nonatomic, retain) NSArray *accmulationArry;
@property (nonatomic, retain) NSArray *associationArry;
@property (nonatomic, retain) NSArray *repaymentArry;
@property (nonatomic, retain) NSArray *caculateWayArry;

@property (nonatomic, retain) HWHouseLoanTableViewCell *rememberCell;
#pragma mark ---------商贷页面数据----------
/*
 *  按单价计算商贷所需要的数据框
 */
@property (nonatomic, retain) UITextField * shangJiaGe;//商贷单价
@property (nonatomic, retain) UITextField * shangMianJi;//商贷面积
@property (nonatomic, retain) UILabel * shangDanCheng;//商贷按揭成数
@property (nonatomic, retain) NSString *shangDanChengStr;
@property (nonatomic, retain) UILabel * shangDanNian;//商贷年数
@property (nonatomic, retain) NSString *shangDanNianStr;//
@property (nonatomic, retain) UILabel * shangDanLiLv;//商贷利率
/*
 *  按总价计算商贷所需要的数据框
 */
@property (nonatomic, retain) UITextField * shangZong;//商贷总额
@property (nonatomic, retain) UILabel * shangZongNian;//商贷总价按揭年数
@property (nonatomic, retain) NSString *shangZongNianStr;
@property (nonatomic, retain) UILabel * shangZongLiLv;//商贷总价利率

#pragma mark ---------公积金页面数据---------
/*
 *  按单价计算公积金所需要的数据框
 */
@property (nonatomic, retain) UITextField * gongJiaGe;//公积金单价
@property (nonatomic, retain) UITextField * gongMianJi;//公积金面积
@property (nonatomic, retain) UILabel * gongDanCheng;//公积金按揭成数
@property (nonatomic, retain) UILabel * gongDanNian;//公积金年数
@property (nonatomic, retain) UILabel * gongDanLiLv;//公积金利率
/*
 *  按总价计算公积金所需要的数据框
 */
@property (nonatomic, retain) UITextField * gongZong;//公积金总额
@property (nonatomic, retain) UILabel * gongZongNian;//公积金总价按揭年数
@property (nonatomic, retain) NSString *gongZongNianStr;
@property (nonatomic, retain) UILabel * gongZongLiLv;//公积金总价利率
@property (nonatomic, retain) NSString *gongZongLiLvStr;

#pragma mark ---------组合贷款页面数据---------
/*
 *  组合型贷款分类输入数据框
 */
@property (nonatomic, retain) UITextField * gongDai;//公积金贷款
@property (nonatomic, retain) UITextField * shangDai;//商业贷款
@property (nonatomic, retain) UILabel * zuHeNian;//组合贷款按揭年数
@property (nonatomic, retain) UILabel * zuHeLiLv;//组合贷款利率

//数组
@property (nonatomic, retain) NSArray * array_1;//成数数组
@property (nonatomic, retain) NSArray * array_2;//年数数组
@property (nonatomic, retain) NSArray * array_3;//按揭利率年份
@property (nonatomic, retain) NSArray * array_4;//商贷利率
@property (nonatomic, retain) NSArray * array_5;//公积金贷款利率
@property (nonatomic, retain) NSArray * array_6;//贷款年数

//弹出视图层
@property (nonatomic, retain) UIView * coverView;//黑色半透明遮盖层
@property (nonatomic, retain) UIImageView * popIMgview;//弹出列表背景
@property (nonatomic, retain) UITableView * popTableView;//弹出列表
@property (nonatomic, retain) UILabel * popLabel;//弹出视图标题
@property (nonatomic, retain) NSMutableArray * tabArray;//列表数组
@property (nonatomic, retain) NSString * popType;//弹出视图标识
@property (nonatomic, retain) NSString * xianString;//显示数据
@property (nonatomic, retain) NSString *gongDanNianStr;
@property (nonatomic, retain) NSString *gongDanChengStr;

//显示利率
@property (nonatomic, retain) UILabel * label_1;
@property (nonatomic, retain) UILabel * label_2;
@property (nonatomic, retain) UILabel * label_3;
@property (nonatomic, retain) UILabel * label_4;
@property (nonatomic, retain) UILabel * label_5;
@property (nonatomic, retain) UILabel * label_6;

@end

@implementation HWFangDaiViewController
@synthesize userContentView,gongZongLiLvStr,accumulationStr;
@synthesize shangDaiBtn,gongBtn,zuHeBtn;
@synthesize shangDaiView,gongView,zuHeView,sonShangView_one,sonShangView_two,sonGongView,sonZuView,sonGongView_one,sonGongView_two;
@synthesize jiSuanType,huanKuanType,suanType,accmulationSuanType;
@synthesize oneBtn,twoBtn;
@synthesize shangDanBtn,shangZongBtn,gongDanBtn,gongZongBtn,index,rateStr;

@synthesize shangJiaGe,shangMianJi,shangZong;
@synthesize gongJiaGe,gongMianJi,gongZong;
@synthesize gongDai,shangDai;
@synthesize shangDanCheng,shangDanNian,shangDanLiLv,shangZongNian,shangZongLiLv,zuheNianStr;
@synthesize gongDanCheng,gongDanChengStr,gongDanNian,gongDanNianStr,gongDanLiLv,gongZongNian,gongZongLiLv,rateIndex;
@synthesize zuHeNian,zuHeLiLv,lilvStr;
@synthesize array_1,array_2,array_3,array_4,array_5,array_6;
@synthesize coverView,popIMgview,popTableView,popLabel;
@synthesize tabArray,popType,xianString;
@synthesize label_1,label_2,label_3,label_4,label_5,label_6;
@synthesize businessTableOneView,businessTableTwoView,associationTableView,accmulationTableOneView,accmulationTableTwoView;
@synthesize businessOneArry,businessTwoArry,accmulationArry,associationArry,repaymentArry,caculateWayArry;
@synthesize rememberCell,shangDanNianStr,shangDanChengStr,shangZongNianStr,segmentControl,gongZongNianStr,dic_data,yearStr;

#define shangDefault @"15年3月1日基准利率"

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}
/**
 *	@brief	获取商贷和公积金利率
 *
 *	@return	 无
 */
-(void)createDataDictory
{
    NSString *plistPath = [[NSBundle mainBundle]pathForResource:@"RatePlist" ofType:@"plist"];
    dic_data = [[NSDictionary alloc]initWithContentsOfFile:plistPath];
//    NSLog(@"%@",dic_data);
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
//    self.array_3 = [NSArray arrayWithObjects:@"12年7月6日基准利率",@"12年7月6日利率下限(85折)",@"12年7月6日利率上限(1.1倍)", nil];
    self.array_3 = [NSArray arrayWithObjects:@"15年3月1日基准利率",@"15年3月1日利率上限(1.1倍)",@"15年3月1日利率下限(85折)", nil];
//    self.array_3 = [NSArray arrayWithObjects:@"15年3月1日利率下限(7折)",@"15年3月1日利率下限(85折)",@"15年3月1日上限(1.1倍)",@"15年3月1日基准利率",
//                    @"14年11月22日利率下限(7折)",@"14年11月22日利率下限(85折)",@"14年11月22日上限(1.1倍)",@"14年11月22日基准利率",
//                    @"12年7月6日利率下限(7折)",@"12年7月6日利率上限(1.1倍)",@"12年7月6日利率下限（85折)",@"12年7月6日基准利率",
//                    @"12年6月8日利率上限(1.1倍)",@"12年6月8日利率下限(85折)",@"12年6月8日基准利率",
//                    @"11年7月6日利率上限(1.1倍)",@"11年7月6日利率下限(85折)",@"11年7月6日基准利率",
//                    @"11年4月5日利率上限(1.1倍)",@"11年4月5日利率下限(85折)",@"11年4月5日利率下限(7折)",@"11年4月5日基准利率",
//                    @"11年2月9日利率上限(1.1倍)",@"11年2月9日利率下限(85折)",@"11年2月9日利率下限(7折)",@"11年2月9日基准利率",
//                    @"10年12月26日利率上限(1.1倍)",@"10年12月26日利率下限(85折)",@"10年12月26日利率下限(7折)",@"10年12月26日基准利率",
//                    @"10年10月20日利率上限(1.1倍)",@"10年10月20日基准利率",@"10年10月20日利率下限(85折)",@"10年10月20日利率下限(7折)",
//                    @"08年12月23日利率上限(1.1倍)",@"08年12月23日基准利率",@"08年12月23日利率下限(85折)",@"08年12月23日利率(7折)",
//                    nil];
//    self.array_4 = [NSArray arrayWithObjects:@"4.59%", @"5.57%", @"7.21%", @"6.55%", @"7.48%",
//                    @"5.78%", @"6.8%", @"7.75%", @"5.99%", @"7.05%", @"7.48%", @"5.78%",
//                    @"4.76%", @"6.8%", @"7.26%", @"5.61%", @"4.62%", @"6.6%", @"7.04%",
//                    @"5.44%", @"4.48%", @"6.4%", @"6.75%", @"6.14%", @"5.22%", @"4.3%",
//                    @"6.53%", @"5.94%", @"5.05%", @"4.16%",nil];
//    self.array_5 = [NSArray arrayWithObjects:@"4.5%", @"4.5%", @"4.5%", @"4.5%", @"4.7%",
//                    @"4.7%", @"4.7%", @"4.9%", @"4.9%", @"4.9%", @"4.7%", @"4.7%", @"4.7%",
//                    @"4.7%", @"4.5%", @"4.5%", @"4.5%", @"4.5%", @"4.3%", @"4.3%", @"4.3%",
//                    @"4.3%", @"4.05%", @"4.05%", @"4.05%", @"4.05%", @"3.87%", @"3.87%",
//                    @"3.87%", @"3.87%", nil];
    self.array_6 = [NSArray arrayWithObjects:@"1",@"2",@"3",@"4",@"5",@"6",@"7",@"8",@"9",@"10",@"11",@"12",@"13",@"14",@"15",@"16",@"17",@"18",@"19",@"20",@"21",@"22",@"23",@"24",@"25",@"26",@"27",@"28",@"29",@"30", nil];
    
    self.businessOneArry = [NSArray arrayWithObjects:@"还款方式",@"计算方式",@"贷款总额",@"按揭年数",@"利率",nil];
    self.businessTwoArry = [NSArray arrayWithObjects:@"还款方式",@"计算方式",@"单价",@"面积",@"按揭成数",@"按揭年数",@"利率",nil];
    self.associationArry = [NSArray arrayWithObjects:@"还款方式",@"公积金贷款",@"商业贷款",@"按揭年数",@"利率", nil];
    self.repaymentArry = [NSArray arrayWithObjects:@"等额本息",@"等额本金", nil];
    self.caculateWayArry = [NSArray arrayWithObjects:@"按单价计算",@"按总价计算", nil];
}
/**
 *	@brief	返回上一级
 *
 *	@param 	sender
 *
 *	@return	 无
 */
-(void)backBtn:(id)sender
{
    [self.navigationController popViewControllerAnimated:YES];
}

#define mark - 切换

/**
 *	@brief	商贷，公交金，组合之间的切换
 *
 *	@param 	sender
 *
 *	@return	 无
 */
-(void)clickSegment:(id)sender
{
    UISegmentedControl *temp = sender;
    NSInteger indexTemp = temp.selectedSegmentIndex;
    switch (indexTemp) {
        case 0:
            rateStr = @"5.9%";
            self.rateIndex = 0;
            self.index = 19;
            lilvStr = shangDefault;
            shangDaiView.hidden = NO;
            gongView.hidden = YES;
            zuHeView.hidden = YES;
            jiSuanType = @"商业贷款";
            huanKuanType = @"等额本息";
            break;
        case 1:
            rateStr = @"4.0%";
            self.rateIndex = 0;
            self.index = 19;
            lilvStr = shangDefault;
            gongView.hidden = NO;
            shangDaiView.hidden = YES;
            zuHeView.hidden = YES;
            jiSuanType = @"公积金贷款";
            huanKuanType = @"等额本息";

            break;
        case 2:
            rateStr = @"5.5675%";
            accumulationStr = @"3.825%";
            zuHeView.hidden = NO;
            shangDaiView.hidden = YES;
            gongView.hidden = YES;
            jiSuanType = @"组合型贷款";
            break;
            
        default:
            break;
    }
    
}
- (void)viewDidLoad
{
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    if (IOS7) {
        self.navigationController.edgesForExtendedLayout = UIRectEdgeNone;
    }
    self.navigationItem.titleView = [Utility navTitleView:@"房贷计算器"];
    self.navigationController.navigationBar.translucent = NO;
    self.navigationItem.leftBarButtonItem = [Utility navLeftBackBtn:self _selector:@selector(backBtn:)];
    //创建数组
    [self creatDataArray];
    [self createDataDictory];
    userContentView = [[UIScrollView alloc]initWithFrame:CGRectMake(0,0, kScreenWidth, self.view.frame.size.height)];
    userContentView.contentSize = CGSizeMake(kScreenWidth, 700);
    userContentView.backgroundColor = [UIColor colorWithRed:245./255. green:245./255. blue:245./255. alpha:1.0f];
    [self.view addSubview:userContentView];
    zuheNianStr = [array_2 objectAtIndex:19];
    //商业贷款
    //[self addShangyeView];
    [self createBusinessView];
    //公积金贷款
    //[self addGongjiView];
    [self creatAccumulation];
    //组合型贷款
    //[self addZuheView];
    [self createAssociationView];
    //添加类型按钮
    NSArray *segmentItems = [NSArray arrayWithObjects:@"商贷",@"公积金",@"组合",nil];
    
    segmentControl = [[UISegmentedControl alloc]initWithItems:segmentItems];
    segmentControl.frame = CGRectMake(15, 8, kScreenWidth - 30, 32);
    segmentControl.tintColor = CD_MainColor;
    segmentControl.selectedSegmentIndex = 0;
    [segmentControl addTarget:self action:@selector(clickSegment:) forControlEvents:UIControlEventValueChanged];
    [userContentView addSubview:segmentControl];
    
#warning 这里的默认值不正确
    rateStr = @"5.9%";
    accumulationStr = @"3.825%";   //????
    self.rateIndex = 0;
    self.index = 19;
    lilvStr = shangDefault;
    shangDaiView.hidden = NO;
    gongView.hidden = YES;
    zuHeView.hidden = YES;
    jiSuanType = @"商业贷款";
    suanType = @"总价计算";
    accmulationSuanType = @"总价计算";

    tabArray = [[NSMutableArray alloc]initWithCapacity:0];
}
#pragma mark -------Tab Dele-------
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (tableView == businessTableOneView) {
        return [self.businessOneArry count];
    }
    else if(tableView == businessTableTwoView)
    {
        return [self.businessTwoArry count];
    }
    else if(tableView == accmulationTableOneView)
    {
        return [self.businessOneArry count];
    }
    else if(tableView == accmulationTableTwoView)
    {
        return [self.businessTwoArry count];
    }
    else if(tableView == associationTableView)
    {
        return [self.associationArry count];
    }
    return tabArray.count;
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (tableView == businessTableOneView || tableView == businessTableTwoView ||tableView ==accmulationTableTwoView||tableView == accmulationTableOneView||tableView == associationTableView) {
        return 55.0f;
    }
    return 38;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
//    if ([Utility isIOS7]) {
//        [tableView setSeparatorColor:[UIColor clearColor]];
//    }
    if (tableView == businessTableOneView) {
        NSInteger row = [indexPath row];
        if (row == 2) {
            static NSString * CellWithIdentifier = @"HWAreaTableViewCell";
            HWAreaTableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:CellWithIdentifier];
            if (!cell) {
                cell = [[HWAreaTableViewCell alloc]init];
            }
            shangZong = [[UITextField alloc]initWithFrame:CGRectMake(97, 17, 150, 20)];
            shangZong.delegate = self;
            shangZong.borderStyle = UITextBorderStyleNone;
            shangZong.placeholder = @"请输入贷款总额";
            shangZong.backgroundColor = [UIColor clearColor];
            shangZong.keyboardType = UIKeyboardTypeDecimalPad;
            shangZong.autocapitalizationType = UITextAutocapitalizationTypeNone;
            shangZong.font = [UIFont fontWithName:FONTNAME size:14];
//            shangZong.textColor = UIColorFromRGB(0xcccccc);
            shangZong.textAlignment = NSTextAlignmentLeft;
            [shangZong setUserInteractionEnabled:YES];
            shangZong.clearButtonMode = UITextFieldViewModeWhileEditing;
            [cell.contentView addSubview:shangZong];
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
            cell.titleLabel.text = self.businessOneArry[indexPath.row];
            cell.unitLabel.text = @"万元";
            return cell;
        }
        
        static NSString * CellWithIdentifier = @"HWHouseLoanTableViewCell";
        HWHouseLoanTableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:CellWithIdentifier];
        if (!cell) {
            cell = [[HWHouseLoanTableViewCell alloc]init];
        }
        if ([indexPath row]==1) {
            cell.titleContentLabel.text = @"按总价计算";
            suanType = @"总价计算";
        }
        else if(row == 0)
        {
            cell.titleContentLabel.text = @"等额本息";
            huanKuanType = @"等额本息";
        }
        else if(row == 3)
        {
            cell.titleContentLabel.text  = [array_2 objectAtIndex:19];
            shangDanNianStr = [array_2 objectAtIndex:19];
        }
        else if(row == 4)
        {
            cell.titleContentLabel.text = [array_3 objectAtIndex:0];
        }
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        cell.titleLabel.text = self.businessOneArry[indexPath.row];
        
        return cell;

    }
    else if(tableView == businessTableTwoView)
    {
        NSInteger row = [indexPath row];
        if (row == 2 || row == 3) {
            static NSString * CellWithIdentifier = @"HWAreaTableViewCell";
            HWAreaTableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:CellWithIdentifier];
            if (!cell) {
                cell = [[HWAreaTableViewCell alloc]init];
            }
            if (row == 2) {
                shangJiaGe = [[UITextField alloc]initWithFrame:CGRectMake(97, 17, 150, 20)];
                shangJiaGe.delegate = self;
                shangJiaGe.borderStyle = UITextBorderStyleNone;
                shangJiaGe.backgroundColor = [UIColor clearColor];
                shangJiaGe.keyboardType = UIKeyboardTypeDecimalPad;
                shangJiaGe.autocapitalizationType = UITextAutocapitalizationTypeNone;
                shangJiaGe.font = [UIFont fontWithName:FONTNAME size:14];
//                shangJiaGe.textColor = UIColorFromRGB(0xcccccc);
                shangJiaGe.textAlignment = NSTextAlignmentLeft;
                [shangJiaGe setUserInteractionEnabled:YES];
                shangJiaGe.placeholder = @"请输入单价";
                shangJiaGe.clearButtonMode = UITextFieldViewModeWhileEditing;
                [cell.contentView addSubview:shangJiaGe];
                cell.unitLabel.text = @"元/㎡";
            }
            else if(row == 3)
            {
                shangMianJi = [[UITextField alloc]initWithFrame:CGRectMake(97, 17, 150, 20)];
                shangMianJi.delegate = self;
                shangMianJi.borderStyle = UITextBorderStyleNone;
                shangMianJi.backgroundColor = [UIColor clearColor];
                shangMianJi.keyboardType = UIKeyboardTypeDecimalPad;
                shangMianJi.autocapitalizationType = UITextAutocapitalizationTypeNone;
                shangMianJi.font = [UIFont fontWithName:FONTNAME size:14];
//                shangMianJi.textColor = UIColorFromRGB(0xcccccc);
                shangMianJi.textAlignment = NSTextAlignmentLeft;
                shangMianJi.placeholder = @"请输入面积";
                [shangMianJi setUserInteractionEnabled:YES];
                shangMianJi.clearButtonMode = UITextFieldViewModeWhileEditing;
                [cell.contentView addSubview:shangMianJi];
                cell.unitLabel.text = @"㎡";
            }
            
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
            cell.titleLabel.text = self.businessTwoArry[indexPath.row];
            
            return cell;
        }
        static NSString * CellWithIdentifier = @"HWHouseLoanTableViewCell";
        HWHouseLoanTableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:CellWithIdentifier];
        if (!cell) {
            cell = [[HWHouseLoanTableViewCell alloc]init];
        }
        
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        cell.titleLabel.text = self.businessTwoArry[indexPath.row];
        
        if ([indexPath row]==1) {
            cell.titleContentLabel.text = @"按单价计算";
            suanType = @"单价计算";
        }
        else if(row == 0)
        {
            cell.titleContentLabel.text = @"等额本息";
            huanKuanType = @"等额本息";
        }
        else if(row == 4)
        {
            cell.titleContentLabel.text  = [array_1 objectAtIndex:2];
            shangDanChengStr =[array_1 objectAtIndex:2];;

        }
        else if(row == 5)
        {
            cell.titleContentLabel.text = [array_2 objectAtIndex:19];
            shangDanNianStr = [array_2 objectAtIndex:19];
        }
        else if (row == 6)
        {
            cell.titleContentLabel.text = [array_3 objectAtIndex:0];
        
        }
        return cell;
        

    }
    else if (tableView == accmulationTableOneView) {
        NSInteger row = [indexPath row];
        if (row == 2) {
            static NSString * CellWithIdentifier = @"HWAreaTableViewCell";
            HWAreaTableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:CellWithIdentifier];
            if (!cell) {
                cell = [[HWAreaTableViewCell alloc]init];
            }
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
            cell.titleLabel.text = self.businessOneArry[indexPath.row];
            cell.unitLabel.text = @"万元";
            gongZong = [[UITextField alloc]initWithFrame:CGRectMake(97, 17, 150, 20)];
            gongZong.delegate = self;
            gongZong.placeholder = @"请输入贷款总额";
            gongZong.delegate = self;
//            gongZong.textColor = UIColorFromRGB(0xcccccc);
            gongZong.borderStyle = UITextBorderStyleNone;
            gongZong.backgroundColor = [UIColor clearColor];
            gongZong.keyboardType = UIKeyboardTypeDecimalPad;
            gongZong.autocapitalizationType = UITextAutocapitalizationTypeNone;
            gongZong.font = [UIFont fontWithName:FONTNAME size:14];
            gongZong.textAlignment = NSTextAlignmentLeft;
            [gongZong setUserInteractionEnabled:YES];
            gongZong.clearButtonMode = UITextFieldViewModeWhileEditing;
            [cell.contentView addSubview:gongZong];
            return cell;
        }
        
        static NSString * CellWithIdentifier = @"HWHouseLoanTableViewCell";
        HWHouseLoanTableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:CellWithIdentifier];
        if (!cell) {
            cell = [[HWHouseLoanTableViewCell alloc]init];
        }
        if ([indexPath row]==1) {
            cell.titleContentLabel.text = @"按总价计算";
            accmulationSuanType = @"总价计算";
        }
        else if(row == 0)
        {
            cell.titleContentLabel.text = @"等额本息";
            huanKuanType = @"等额本息";
            
        }
        else if(row == 3)
        {
            cell.titleContentLabel.text  = [array_2 objectAtIndex:19];
            gongZongNianStr = [array_2 objectAtIndex:19];
        }
        else if(row == 4)
        {
            cell.titleContentLabel.text = [array_3 objectAtIndex:0];
            gongZongLiLvStr =[array_3 objectAtIndex:0];
        }
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        cell.titleLabel.text = self.businessOneArry[indexPath.row];
        return cell;
        
    }
    else if(tableView == accmulationTableTwoView)
    {
        NSInteger row = [indexPath row];
        if (row == 2 || row == 3) {
            static NSString * CellWithIdentifier = @"HWAreaTableViewCell";
            HWAreaTableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:CellWithIdentifier];
            if (!cell) {
                cell = [[HWAreaTableViewCell alloc]init];
            }
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
            cell.titleLabel.text = self.businessTwoArry[indexPath.row];
            if (row == 2) {
                gongJiaGe = [[UITextField alloc]initWithFrame:CGRectMake(97, 17, 150, 20)];
                gongJiaGe.delegate = self;
                gongJiaGe.borderStyle = UITextBorderStyleNone;
                gongJiaGe.backgroundColor = [UIColor clearColor];
                gongJiaGe.keyboardType = UIKeyboardTypeDecimalPad;
                gongJiaGe.placeholder = @"请输入单价";
                gongJiaGe.autocapitalizationType = UITextAutocapitalizationTypeNone;
                gongJiaGe.font = [UIFont fontWithName:FONTNAME size:14];
//                gongJiaGe.textColor = UIColorFromRGB(0xcccccc);
                gongJiaGe.textAlignment = NSTextAlignmentLeft;
                [gongJiaGe setUserInteractionEnabled:YES];
                gongJiaGe.clearButtonMode = UITextFieldViewModeWhileEditing;
                [cell.contentView addSubview:gongJiaGe];
                cell.unitLabel.text = @"元/㎡";
                
            }
            else if(row == 3)
            {
                gongMianJi = [[UITextField alloc]initWithFrame:CGRectMake(97, 17, 90, 20)];
                gongMianJi.delegate = self;
                gongMianJi.borderStyle = UITextBorderStyleNone;
                gongMianJi.backgroundColor = [UIColor clearColor];
                gongMianJi.placeholder = @"请输入面积";
                gongMianJi.keyboardType = UIKeyboardTypeDecimalPad;
                gongMianJi.autocapitalizationType = UITextAutocapitalizationTypeNone;
                gongMianJi.font = [UIFont fontWithName:FONTNAME size:14];
//                gongMianJi.textColor = UIColorFromRGB(0xcccccc);
                gongMianJi.textAlignment = NSTextAlignmentLeft;
                [gongMianJi setUserInteractionEnabled:YES];
                gongMianJi.clearButtonMode = UITextFieldViewModeWhileEditing;
                [cell.contentView addSubview:gongMianJi];
                cell.unitLabel.text = @"㎡";
                
            }
            
            
            return cell;
        }
        static NSString * CellWithIdentifier = @"HWHouseLoanTableViewCell";
        HWHouseLoanTableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:CellWithIdentifier];
        if (!cell) {
            cell = [[HWHouseLoanTableViewCell alloc]init];
        }
        if ([indexPath row]==1) {
            cell.titleContentLabel.text = @"按单价计算";
            accmulationSuanType = @"单价计算";
        }
        else if(row == 0)
        {
            cell.titleContentLabel.text = @"等额本息";
            huanKuanType = @"等额本息";
        }
        else if(row == 4)
        {
            cell.titleContentLabel.text  =[array_1 objectAtIndex:2];;
            gongDanChengStr = [array_1 objectAtIndex:2];
        }
        else if(row == 5)
        {
            cell.titleContentLabel.text = [array_2 objectAtIndex:19];
            gongDanNianStr =[array_2 objectAtIndex:19];
        }
        else if (row == 6)
        {
            cell.titleContentLabel.text = [array_3 objectAtIndex:0];
            
        }

        cell.titleLabel.text = self.businessTwoArry[indexPath.row];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        return cell;
    }
    else if(tableView == associationTableView)
    {
        NSInteger row = [indexPath row];
        if (row == 1 || row == 2) {
            static NSString * CellWithIdentifier = @"HWAreaTableViewCell";
            HWAreaTableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:CellWithIdentifier];
            if (!cell) {
                cell = [[HWAreaTableViewCell alloc]init];
            }
            if (row == 1) {
                gongDai = [[UITextField alloc]initWithFrame:CGRectMake(97, 17, 150, 20)];
                gongDai.delegate = self;
                gongDai.placeholder = @"请输入金额";
                gongDai.borderStyle = UITextBorderStyleNone;
                gongDai.backgroundColor = [UIColor clearColor];
                gongDai.userInteractionEnabled = YES;
                gongDai.keyboardType = UIKeyboardTypeDecimalPad;
                gongDai.autocapitalizationType = UITextAutocapitalizationTypeNone;
                gongDai.font = [UIFont fontWithName:FONTNAME size:14];
//                gongDai.textColor = UIColorFromRGB(0xcccccc);
                gongDai.textAlignment = NSTextAlignmentLeft;
                [gongDai setUserInteractionEnabled:YES];
                gongDai.clearButtonMode = UITextFieldViewModeWhileEditing;
                cell.selectionStyle = UITableViewCellSelectionStyleNone;
                [cell.contentView addSubview:gongDai];
            }
            else{
                shangDai = [[UITextField alloc]initWithFrame:CGRectMake(97, 17, 150, 20)];
                shangDai.delegate = self;
                shangDai.borderStyle = UITextBorderStyleNone;
                shangDai.backgroundColor = [UIColor clearColor];
                shangDai.keyboardType = UIKeyboardTypeDecimalPad;
                shangDai.placeholder = @"请输入金额";
                shangDai.autocapitalizationType = UITextAutocapitalizationTypeNone;
                shangDai.font = [UIFont fontWithName:FONTNAME size:14];
//                shangDai.textColor = UIColorFromRGB(0xcccccc);
                shangDai.textAlignment = NSTextAlignmentLeft;
                [shangDai setUserInteractionEnabled:YES];
                shangDai.clearButtonMode = UITextFieldViewModeWhileEditing;
                cell.selectionStyle = UITableViewCellSelectionStyleNone;
                [cell.contentView addSubview:shangDai];

            }
           
            
            cell.titleLabel.text = self.associationArry[indexPath.row];
            cell.unitLabel.text = @"万元";

            return cell;
        }
        static NSString * CellWithIdentifier = @"HWHouseLoanTableViewCell";
        HWHouseLoanTableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:CellWithIdentifier];
        if (!cell) {
            cell = [[HWHouseLoanTableViewCell alloc]init];
        }
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        cell.titleLabel.text = self.associationArry[indexPath.row];
        if (row == 0) {
            cell.titleContentLabel.text = @"等额本息";
            huanKuanType = @"等额本息";
        }
        else if(row == 3)
        {
            cell.titleContentLabel.text = [array_2 objectAtIndex:19];
            zuheNianStr =[array_2 objectAtIndex:19];
        }
        else if(row == 4)
        {
            cell.titleContentLabel.text = [array_3 objectAtIndex:0];
        }
        
        return cell;
    }
    else{
        tableView.separatorColor = [UIColor lightGrayColor];
        static NSString * CellWithIdentifier = @"Cell";
        UITableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:CellWithIdentifier];
        if (!cell) {
            cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellWithIdentifier];
        }
        cell.selectedBackgroundView = [[UIView alloc]initWithFrame:cell.frame];
        cell.selectedBackgroundView.backgroundColor = [UIColor colorWithRed:238/255.0 green:238/255.0 blue:238/255.0 alpha:1];
        cell.textLabel.text = self.tabArray[indexPath.row];
        cell.textLabel.font = [UIFont fontWithName:FONTNAME size:14];
        return cell;
    }
}
/**
 *	@brief	收起所有的Testfield
 *
 *	@return	 无
 */
-(void)pickUpAllTexfield
{
    //回收键盘
    [shangJiaGe resignFirstResponder];
    [shangMianJi resignFirstResponder];
    [shangZong resignFirstResponder];
    [gongJiaGe resignFirstResponder];
    [gongMianJi resignFirstResponder];
    [gongZong resignFirstResponder];
    [shangDai resignFirstResponder];
    [gongDai resignFirstResponder];
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    //弹起所有的uitextField
    [self pickUpAllTexfield];
    //
    HWClickTableViewReturnViewController *returnTableView = [[HWClickTableViewReturnViewController alloc]init];
    __weak HWFangDaiViewController *weakSelf = self;
     NSInteger row = [indexPath row];
    if (tableView == businessTableOneView) {
        rememberCell =(HWHouseLoanTableViewCell*) [tableView cellForRowAtIndexPath:indexPath];
        switch (row) {
            case 0:
                if (tabArray.count>0) {
                    [tabArray removeAllObjects];
                    [tabArray addObjectsFromArray:self.repaymentArry];
                }
                else{
                    [tabArray addObjectsFromArray:self.repaymentArry];
                }
                popType = @"还款方式";
                popLabel.text = @"还款方式";
                break;
            case 1:
                if (tabArray.count>0) {
                    [tabArray removeAllObjects];
                    [tabArray addObjectsFromArray:self.caculateWayArry];
                }
                else{
                    [tabArray addObjectsFromArray:self.caculateWayArry];
                }
                popType = @"计算方式";
                popLabel.text = @"计算方式";
                
                
                break;
            case 3:
                if (tabArray.count>0) {
                    [tabArray removeAllObjects];
                    [tabArray addObjectsFromArray:array_2];
                }
                else{
                    [tabArray addObjectsFromArray:array_2];
                }
                popType = @"商贷总价按揭年数";
                popLabel.text = @"按揭年数";
                break;
                
            case 4:
                if (tabArray.count>0) {
                    [tabArray removeAllObjects];
                    [tabArray addObjectsFromArray:array_3];
                }
                else{
                    [tabArray addObjectsFromArray:array_3];
                }
                popType = @"商贷总价按揭利率";
                popLabel.text = @"按揭利率";
                break;
            default:
                break;
        }
        if (row == 1 || row == 0 || row ==3 || row ==4)
        {
            returnTableView.dataArry = tabArray;
            
            [returnTableView setReturnSelectedResult:^(NSString *result,NSInteger indexTemp)
             {
//                 NSLog(@"the result is %@",result);
                 weakSelf.xianString = result;
                 weakSelf.rememberCell.titleContentLabel.text = result;
                 if (row == 3) {
                     weakSelf.index = indexTemp;
                 }
                 else if(row == 4)
                 {
                     weakSelf.rateIndex = indexTemp;
                 }
                 [weakSelf sure];
             }];
            HWHouseLoanTableViewCell *cell = (HWHouseLoanTableViewCell *)[tableView cellForRowAtIndexPath:indexPath];
            returnTableView.typeStr = cell.titleContentLabel.text;
            [self.navigationController pushViewController:returnTableView animated:YES];
        }
    }
    else if(tableView == businessTableTwoView)
    {
        rememberCell =(HWHouseLoanTableViewCell*)[tableView cellForRowAtIndexPath:indexPath];
        switch (row) {
            case 0:
                if (tabArray.count>0) {
                    [tabArray removeAllObjects];
                    [tabArray addObjectsFromArray:self.repaymentArry];
                }
                else{
                    [tabArray addObjectsFromArray:self.repaymentArry];
                }
                popType = @"还款方式";
                popLabel.text = @"还款方式";
                break;
             case 1:
                if (tabArray.count>0) {
                    [tabArray removeAllObjects];
                    [tabArray addObjectsFromArray:self.caculateWayArry];
                }
                else{
                    [tabArray addObjectsFromArray:self.caculateWayArry];
                }
                popType = @"计算方式";
                popLabel.text = @"计算方式";
                break;
                
            case 4:
                if (tabArray.count>0) {
                    [tabArray removeAllObjects];
                    [tabArray addObjectsFromArray:array_1];
                }
                else{
                    [tabArray addObjectsFromArray:array_1];
                }
                popType = @"商贷按揭成数";
                popLabel.text = @"按揭成数";
                break;
                
                
            case 5:
                if (tabArray.count>0) {
                    [tabArray removeAllObjects];
                    [tabArray addObjectsFromArray:array_2];
                }
                else{
                    [tabArray addObjectsFromArray:array_2];
                }
                popType = @"商贷按揭年数";
                popLabel.text = @"按揭年数";
                break;
                
            case 6:
                if (tabArray.count>0) {
                    [tabArray removeAllObjects];
                    [tabArray addObjectsFromArray:array_3];
                }
                else{
                    [tabArray addObjectsFromArray:array_3];
                }
                popType = @"商贷按揭利率";
                popLabel.text = @"按揭利率";
                break;
            default:
                break;
        }
        if (row == 1 || row == 0 || row ==5 || row ==4 || row == 6)
        {
            returnTableView.dataArry = tabArray;
            
            [returnTableView setReturnSelectedResult:^(NSString *result,NSInteger indexTemp)
             {
//                 NSLog(@"the result is %@",result);
                 weakSelf.xianString = result;
                 weakSelf.rememberCell.titleContentLabel.text = result;
                 if (row == 5) {
                     weakSelf.index = indexTemp;
                 }
                 else if(row == 6)
                 {
                     weakSelf.rateIndex = indexTemp;
                 }
                 [weakSelf sure];
                 
             }];
            HWHouseLoanTableViewCell *cell = (HWHouseLoanTableViewCell *)[tableView cellForRowAtIndexPath:indexPath];
            returnTableView.typeStr = cell.titleContentLabel.text;
            [self.navigationController pushViewController:returnTableView animated:YES];
        }
    }
    else if (tableView == accmulationTableOneView) {
        rememberCell =(HWHouseLoanTableViewCell*) [tableView cellForRowAtIndexPath:indexPath];
        switch (row) {
            case 0:
                if (tabArray.count>0) {
                    [tabArray removeAllObjects];
                    [tabArray addObjectsFromArray:self.repaymentArry];
                }
                else{
                    [tabArray addObjectsFromArray:self.repaymentArry];
                }
                popType = @"还款方式";
                popLabel.text = @"还款方式";
                break;
            case 1:
                if (tabArray.count>0) {
                    [tabArray removeAllObjects];
                    [tabArray addObjectsFromArray:self.caculateWayArry];
                }
                else{
                    [tabArray addObjectsFromArray:self.caculateWayArry];
                }
                popType = @"计算方式";
                popLabel.text = @"计算方式";
                break;
            case 3:
                if (tabArray.count>0) {
                    [tabArray removeAllObjects];
                    [tabArray addObjectsFromArray:array_2];
                }
                else{
                    [tabArray addObjectsFromArray:array_2];
                }
                popType = @"公积金总价按揭年数";
                popLabel.text = @"按揭年数";
                break;
                
            case 4:
                if (tabArray.count>0) {
                    [tabArray removeAllObjects];
                    [tabArray addObjectsFromArray:array_3];
                }
                else{
                    [tabArray addObjectsFromArray:array_3];
                }
                popType = @"公积金总价按揭利率";
                popLabel.text = @"按揭利率";
                break;
            default:
                break;
        }
        if (row == 1 || row == 0 || row ==3 || row ==4 )
        {
            returnTableView.dataArry = tabArray;
            
            [returnTableView setReturnSelectedResult:^(NSString *result,NSInteger indexTemp)
             {
//                 NSLog(@"the result is %@",result);
                 weakSelf.xianString = result;
                 weakSelf.rememberCell.titleContentLabel.text = result;
                 if (row == 3) {
                     weakSelf.index = indexTemp;
                 }
                 else if(row == 4)
                 {
                     weakSelf.rateIndex = indexTemp;
                 }

                 [weakSelf sure];
                 
             }];
            HWHouseLoanTableViewCell *cell = (HWHouseLoanTableViewCell *)[tableView cellForRowAtIndexPath:indexPath];
            returnTableView.typeStr = cell.titleContentLabel.text;
            [self.navigationController pushViewController:returnTableView animated:YES];
        }
    }
    else if(tableView == accmulationTableTwoView)
    {
        rememberCell =(HWHouseLoanTableViewCell*)[tableView cellForRowAtIndexPath:indexPath];
        switch (row) {
            case 0:
                if (tabArray.count>0) {
                    [tabArray removeAllObjects];
                    [tabArray addObjectsFromArray:self.repaymentArry];
                }
                else{
                    [tabArray addObjectsFromArray:self.repaymentArry];
                }
                popType = @"还款方式";
                popLabel.text = @"还款方式";
                break;
            case 1:
                if (tabArray.count>0) {
                    [tabArray removeAllObjects];
                    [tabArray addObjectsFromArray:self.caculateWayArry];
                }
                else{
                    [tabArray addObjectsFromArray:self.caculateWayArry];
                }
                popType = @"计算方式";
                popLabel.text = @"计算方式";
                break;
                
            case 4:
                if (tabArray.count>0) {
                    [tabArray removeAllObjects];
                    [tabArray addObjectsFromArray:array_1];
                }
                else{
                    [tabArray addObjectsFromArray:array_1];
                }
                popType = @"公积金按揭成数";
                popLabel.text = @"按揭成数";
                break;
                
                
            case 5:
                if (tabArray.count>0) {
                    [tabArray removeAllObjects];
                    [tabArray addObjectsFromArray:array_2];
                }
                else{
                    [tabArray addObjectsFromArray:array_2];
                }
                popType = @"公积金按揭年数";
                popLabel.text = @"按揭年数";
                break;
                
            case 6:
                if (tabArray.count>0) {
                    [tabArray removeAllObjects];
                    [tabArray addObjectsFromArray:array_3];
                }
                else{
                    [tabArray addObjectsFromArray:array_3];
                }
                popType = @"公积金按揭利率";
                popLabel.text = @"按揭利率";
                break;
            default:
                break;
        }
        if (row == 1 || row == 0 || row ==5 || row ==4 || row == 6)
        {
            returnTableView.dataArry = tabArray;
            
            [returnTableView setReturnSelectedResult:^(NSString *result,NSInteger indexTemp)
             {
//                 NSLog(@"the result is %@",result);
                 weakSelf.xianString = result;
                 weakSelf.rememberCell.titleContentLabel.text = result;
                 if (row == 5) {
                     weakSelf.index = indexTemp;
                 }
                 else if(row == 6)
                 {
                     weakSelf.rateIndex = indexTemp;
                 }

                 [weakSelf sure];
                 
             }];
            HWHouseLoanTableViewCell *cell = (HWHouseLoanTableViewCell *)[tableView cellForRowAtIndexPath:indexPath];
            returnTableView.typeStr = cell.titleContentLabel.text;
            [self.navigationController pushViewController:returnTableView animated:YES];
        }
        
    }
    if (tableView == associationTableView) {
        rememberCell =(HWHouseLoanTableViewCell*) [tableView cellForRowAtIndexPath:indexPath];
        switch (row) {
            case 0:
                if (tabArray.count>0) {
                    [tabArray removeAllObjects];
                    [tabArray addObjectsFromArray:self.repaymentArry];
                }
                else{
                    [tabArray addObjectsFromArray:self.repaymentArry];
                }
                popType = @"还款方式";
                popLabel.text = @"还款方式";
                break;
            
            case 3:
                if (tabArray.count>0) {
                    [tabArray removeAllObjects];
                    [tabArray addObjectsFromArray:array_2];
                }
                else{
                    [tabArray addObjectsFromArray:array_2];
                }
                popType = @"组合型按揭年数";
                popLabel.text = @"按揭年数";
                break;
                
            case 4:
                if (tabArray.count>0) {
                    [tabArray removeAllObjects];
                    [tabArray addObjectsFromArray:array_3];
                }
                else{
                    [tabArray addObjectsFromArray:array_3];
                }
                popType = @"组合型按揭利率";
                popLabel.text = @"按揭利率";
                break;
            default:
                break;
        }
        if (row == 0 || row ==3 || row ==4)
        {
            returnTableView.dataArry = tabArray;
            
            [returnTableView setReturnSelectedResult:^(NSString *result,NSInteger indexTemp)
             {
//                 NSLog(@"the result is %@",result);
                 weakSelf.xianString = result;
                 weakSelf.rememberCell.titleContentLabel.text = result;
                 if (row == 3) {
                     weakSelf.index = indexTemp;
                 }
                 else if(row == 4)
                 {
                     weakSelf.rateIndex = indexTemp;
                 }

                 [weakSelf sure];
                 
             }];
            HWHouseLoanTableViewCell *cell = (HWHouseLoanTableViewCell *)[tableView cellForRowAtIndexPath:indexPath];
            returnTableView.typeStr = cell.titleContentLabel.text;
            [self.navigationController pushViewController:returnTableView animated:YES];
        }
      
    }
  

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
    NSArray *arry = [dic_data objectForKey:rate];
    NSDictionary* dic = [arry objectAtIndex:indexTemp];
    return [dic objectForKey:year];
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
    NSArray *arry = [dic_data objectForKey:tempStr];
    NSDictionary* dic = [arry objectAtIndex:indexTemp];
    return [dic objectForKey:year];
}
/**
 *	@brief	确认以何种方式计算
 *
 *	@return	 无
 */
-(void)sure

{
    
    if ([popType isEqualToString:@"还款方式"]) {
        if (xianString.length>0) {
            huanKuanType = xianString;
            return;
        }
    }
    if ([popType isEqualToString:@"计算方式"]) {
        if (xianString.length>0) {
            rateStr = @"5.9%";
            self.rateIndex = 0;
            self.index = 19;
            lilvStr = shangDefault;
            if ([xianString isEqualToString:@"按单价计算"]) {
                if (segmentControl.selectedSegmentIndex == 0) {
                    sonShangView_two.hidden = NO;
                    sonShangView_one.hidden = YES;
                    [businessTableTwoView reloadData];
                }
                else if(segmentControl.selectedSegmentIndex == 1)
                {
                    sonGongView_one.hidden = YES;
                    sonGongView_two.hidden = NO;
                    [accmulationTableTwoView reloadData];
                    
                }
                return;
                
            }
            else if ([xianString isEqualToString:@"按总价计算"])
            {
                if (segmentControl.selectedSegmentIndex == 0) {
                    sonShangView_two.hidden = YES;
                    sonShangView_one.hidden = NO;
                    [businessTableOneView reloadData];
                }
                else if(segmentControl.selectedSegmentIndex == 1)
                {
                    
                    sonGongView_one.hidden = NO;
                    sonGongView_two.hidden = YES;
                    [accmulationTableOneView reloadData];
                    
                }
                return;
            }
        }
    }
    if ([popType isEqualToString:@"商贷按揭成数"]) {
        if (xianString.length>0) {
            shangDanChengStr = xianString;
            return;
            
        }
    }
    if ([popType isEqualToString:@"商贷按揭年数"]) {
        if (xianString.length>0) {
            shangDanNianStr = xianString;
            rateStr = [self returnRate:shangDanNianStr rate:lilvStr index:self.index];
            label_1.text = rateStr;
            return;
            
        }
    }
    if ([popType isEqualToString:@"商贷总价按揭年数"]) {
        if (xianString.length>0) {
            shangDanNianStr = xianString;
            rateStr = [self returnRate:shangDanNianStr rate:lilvStr index:self.index];
            label_2.text = rateStr;
            return;
            
        }
    }
    
    if ([popType isEqualToString:@"商贷按揭利率"]) {
        if (xianString.length>0) {
            rateStr = [self returnRate:shangDanNianStr rate:self.xianString index:self.index];
            lilvStr = self.xianString;
            label_1.text = rateStr;
            return;
        }
    }
    if ([popType isEqualToString:@"商贷总价按揭成数"]) {
        if (xianString.length>0) {
            
            shangDanChengStr = xianString;
            return;
        }
    }
    if ([popType isEqualToString:@"商贷总价按揭利率"]) {
        if (xianString.length>0) {
            
            rateStr = [self returnRate:shangDanNianStr rate:self.xianString index:self.index];
            lilvStr = self.xianString;
            label_2.text = rateStr;
            return;
        }
    }
    if ([popType isEqualToString:@"公积金按揭成数"]) {
        if (xianString.length>0) {
            
            gongDanChengStr = xianString;
            return;
        }
    }
    if ([popType isEqualToString:@"公积金按揭年数"]) {
        if (xianString.length>0) {
            
            gongDanNianStr = xianString;
            rateStr = [self returnAccumulation:gongDanNianStr rate:lilvStr index:self.index];
            label_3.text = rateStr;
            return;
        }
    }
    if ([popType isEqualToString:@"公积金按揭利率"]) {
        if (xianString.length>0) {
            lilvStr = self.xianString;
            rateStr = [self returnAccumulation:gongDanNianStr rate:lilvStr index:self.index];
            
            label_3.text = rateStr;
            return;
        }
    }
    if ([popType isEqualToString:@"公积金总价按揭年数"]) {
        if (xianString.length>0) {
            gongDanNianStr = xianString;
            rateStr = [self returnAccumulation:gongDanNianStr rate:lilvStr index:self.index];
            label_4.text = rateStr;
            return;
        }
    }
    if ([popType isEqualToString:@"公积金总价按揭利率"]) {
        if (xianString.length>0) {
            lilvStr = self.xianString;
            rateStr = [self returnAccumulation:gongDanNianStr rate:lilvStr index:self.index];
            label_4.text = rateStr;
            return;
        }
    }
    if ([popType isEqualToString:@"组合型按揭年数"]) {
        if (xianString.length>0) {
            zuheNianStr = xianString;
            rateStr = [self returnRate:zuheNianStr rate:lilvStr index:self.index];
            accumulationStr = [self returnAccumulation:zuheNianStr rate:lilvStr index:self.index];
            label_5.text = accumulationStr;
            label_6.text = rateStr;
            
            return;
        }
    }
    if ([popType isEqualToString:@"组合型按揭利率"]) {
        if (xianString.length>0) {
            lilvStr = self.xianString;
            rateStr = [self returnRate:zuheNianStr rate:lilvStr index:self.index];
            accumulationStr = [self returnAccumulation:zuheNianStr rate:lilvStr index:self.index];
            label_5.text = [NSString stringWithFormat:@"%@",accumulationStr];
            label_6.text = [NSString stringWithFormat:@"%@",rateStr  ];
            return;
        }
    }
}

//计算结果
/**
 *	@brief	计算结果
 *
 *	@param 	btn
 *
 *	@return	 无
 */
-(void)jiSuanAction:(UIButton *)btn
{
    NSString * resultType;
    if ([jiSuanType isEqualToString:@"组合型贷款"]) {
        resultType = [NSString stringWithFormat:@"%@%@",jiSuanType,huanKuanType];
    }
    else if([jiSuanType isEqualToString:@"商业贷款"])
    {
        resultType = [NSString stringWithFormat:@"%@%@%@",jiSuanType,huanKuanType,
     suanType];
    }
    else if([jiSuanType isEqualToString:@"公积金贷款"])
    {
        resultType = [NSString stringWithFormat:@"%@%@%@",jiSuanType,huanKuanType,accmulationSuanType];
    }
    /*
     * 商业贷款数据的计算
     */
    if ([resultType isEqualToString:@"商业贷款等额本息单价计算"]) {
        if (shangJiaGe.text.length==0 && shangMianJi.text.length>0) {
            UIAlertView * alert = [[UIAlertView alloc]initWithTitle:nil message:@"请输入单价" delegate:self cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
            [alert show];
        }
        else if (shangMianJi.text.length==0 && shangJiaGe.text.length>0) {
            UIAlertView * alert = [[UIAlertView alloc]initWithTitle:nil message:@"请输入房屋面积" delegate:self cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
            [alert show];
        }
        else if (shangJiaGe.text.length==0 && shangMianJi.text.length==0){
            UIAlertView * alert = [[UIAlertView alloc]initWithTitle:nil message:@"请输入单价" delegate:self cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
            [alert show];
        }
        else{
            //add by gusheng
            [self unitPrice:label_1.text];
        }
    }
    if ([resultType isEqualToString:@"商业贷款等额本金单价计算"]) {
        if (shangJiaGe.text.length==0 && shangMianJi.text.length>0) {
            UIAlertView * alert = [[UIAlertView alloc]initWithTitle:nil message:@"请输入单价" delegate:self cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
            [alert show];
        }
        else if (shangMianJi.text.length==0 && shangJiaGe.text.length>0) {
            UIAlertView * alert = [[UIAlertView alloc]initWithTitle:nil message:@"请输入房屋面积" delegate:self cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
            [alert show];
        }
        else if (shangJiaGe.text.length==0 && shangMianJi.text.length==0){
            UIAlertView * alert = [[UIAlertView alloc]initWithTitle:nil message:@"请输入单价" delegate:self cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
            [alert show];
        }
        else{
            //add by gusheng
            [self unitBasePrice:label_1.text];
        }
    }
    if ([resultType isEqualToString:@"商业贷款等额本息总价计算"]) {
        if (shangZong.text.length==0) {
            UIAlertView * alert = [[UIAlertView alloc]initWithTitle:nil message:@"请输入贷款总额" delegate:self cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
            [alert show];
        }
        else{
            //add by gusheng
            [self totalPric:label_2.text];
            //end
            
        }
    }
    if ([resultType isEqualToString:@"商业贷款等额本金总价计算"]) {
        if (shangZong.text.length==0) {
            UIAlertView * alert = [[UIAlertView alloc]initWithTitle:nil message:@"请输入贷款总额" delegate:self cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
            [alert show];
        }
        else{
            //add by gusheng
            [self totalPrincSameBase:label_2.text];
        }
    }
    /*
     * 公积金贷款数据的计算
     */
    if ([resultType isEqualToString:@"公积金贷款等额本息单价计算"]) {
        if (gongJiaGe.text.length==0 && gongMianJi.text.length>0) {
            UIAlertView * alert = [[UIAlertView alloc]initWithTitle:nil message:@"请输入单价" delegate:self cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
            [alert show];
        }
        else if (gongMianJi.text.length==0 && gongJiaGe.text.length>0) {
            UIAlertView * alert = [[UIAlertView alloc]initWithTitle:nil message:@"请输入房屋面积" delegate:self cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
            [alert show];
        }
        else if (gongJiaGe.text.length==0 && gongMianJi.text.length==0){
            UIAlertView * alert = [[UIAlertView alloc]initWithTitle:nil message:@"请输入单价" delegate:self cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
            [alert show];
        }
        else{
            //add by gusheng
            [self acumulationUnitPrice:label_3.text];
            //
        }
    }
    if ([resultType isEqualToString:@"公积金贷款等额本金单价计算"]) {
        if (gongJiaGe.text.length==0 && gongMianJi.text.length>0) {
            UIAlertView * alert = [[UIAlertView alloc]initWithTitle:nil message:@"请输入单价" delegate:self cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
            [alert show];
        }
        else if (gongMianJi.text.length==0 && gongJiaGe.text.length>0) {
            UIAlertView * alert = [[UIAlertView alloc]initWithTitle:nil message:@"请输入房屋面积" delegate:self cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
            [alert show];
        }
        else if (gongJiaGe.text.length==0 && gongMianJi.text.length==0){
            UIAlertView * alert = [[UIAlertView alloc]initWithTitle:nil message:@"请输入单价" delegate:self cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
            [alert show];
        }
        else{
            [self acumulationUnitBasePrice:label_3.text];
        }
    }
    if ([resultType isEqualToString:@"公积金贷款等额本息总价计算"]) {
        if (gongZong.text.length==0) {
            UIAlertView * alert = [[UIAlertView alloc]initWithTitle:nil message:@"请输入贷款总额" delegate:self cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
            [alert show];
        }
        else{
            //add by gusheng
            [self acumulationTotalPric:label_4.text];
            
        }
    }
    if ([resultType isEqualToString:@"公积金贷款等额本金总价计算"]) {
        if (gongZong.text.length==0) {
            UIAlertView * alert = [[UIAlertView alloc]initWithTitle:nil message:@"请输入贷款总额" delegate:self cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
            [alert show];
        }
        else{
            
            [self acumulationTotalPrincSameBase:label_4.text];
        }
    }
    /*
     * 组合型贷款数据的计算
     */
    if ([resultType isEqualToString:@"组合型贷款等额本息"]) {
        if (gongDai.text.length==0 && shangDai.text.length>0) {
            UIAlertView * alert = [[UIAlertView alloc]initWithTitle:nil message:@"请输入公积金贷款总额" delegate:self cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
            [alert show];
        }
        else if (shangDai.text.length==0 && gongDai.text.length>0){
            UIAlertView * alert = [[UIAlertView alloc]initWithTitle:nil message:@"请输入商业贷款总额" delegate:self cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
            [alert show];
        }
        else if (gongDai.text.length==0 && shangDai.text.length==0){
            UIAlertView * alert = [[UIAlertView alloc]initWithTitle:nil message:@"请输入公积金贷款总额" delegate:self cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
            [alert show];
        }
        else{
            //add by gusheng
            [self zuheUnitPrice:label_5.text  shangStr:label_6.text];
            //end
        }
    }
    if ([resultType isEqualToString:@"组合型贷款等额本金"]) {
        if (gongDai.text.length==0 && shangDai.text.length>0) {
            UIAlertView * alert = [[UIAlertView alloc]initWithTitle:nil message:@"请输入公积金贷款总额" delegate:self cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
            [alert show];
        }
        else if (shangDai.text.length==0 && gongDai.text.length>0){
            UIAlertView * alert = [[UIAlertView alloc]initWithTitle:nil message:@"请输入商业贷款总额" delegate:self cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
            [alert show];
        }
        else if (gongDai.text.length==0 && shangDai.text.length==0){
            UIAlertView * alert = [[UIAlertView alloc]initWithTitle:nil message:@"请输入公积金贷款总额" delegate:self cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
            [alert show];
        }
        else{
            [self zuheTotalPrice:label_5.text shangStr:label_6.text];
            
        }
    }
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
//add by gusheng at 2014.7.9

#pragma mark - 绘制商贷页面
/**
 *	@brief	绘制商贷的页面
 *
 *	@return	 无
 */
-(void)createBusinessView

{
    shangDaiView = [[UIView alloc]init];
    shangDaiView.frame = CGRectMake(0, 48, kScreenWidth, 550);
    shangDaiView.backgroundColor = [UIColor clearColor];
    [userContentView addSubview:shangDaiView];
    
    sonShangView_one = [[UIView alloc]initWithFrame:CGRectMake(0, 0, kScreenWidth, 385+55+70)];
    sonShangView_one.backgroundColor = [UIColor clearColor];
    sonShangView_one.hidden = NO;
    [shangDaiView addSubview:sonShangView_one];
    
    businessTableOneView = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, kScreenWidth, 275+55)];
    //[businessTableOneView setBackgroundColor:[UIColor whiteColor]];
    [sonShangView_one addSubview:businessTableOneView];
    businessTableOneView.scrollEnabled= NO;
    businessTableOneView.delegate = self;
    businessTableOneView.dataSource = self;
    
    for (int i = 0; i < 2; i++) {
        UIView *line = [[UIView alloc] initWithFrame:CGRectMake(0, 0+330*i, kScreenWidth, 0.5)];
        [line setBackgroundColor:[UIColor lightGrayColor]];
        [sonShangView_one addSubview:line];
    }
    
    
    //添加按钮
    UIButton * shangOneBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    shangOneBtn.frame = CGRectMake(10, 380, kScreenWidth - 20, 50);
    [shangOneBtn setTitle:@"计算" forState:UIControlStateNormal];
    [shangOneBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
//    [shangOneBtn setButtonBackgroundShadowHighlight];
    [shangOneBtn setButtonRedAndOrangeBorderStyle];
    [shangOneBtn addTarget:self action:@selector(jiSuanAction:) forControlEvents:UIControlEventTouchUpInside];
    [sonShangView_one addSubview:shangOneBtn];
   
    UILabel *tempLabel  = [[UILabel alloc]initWithFrame:CGRectMake(10, 340, kScreenWidth - 20, 21)];
    tempLabel.font = [UIFont fontWithName:FONTNAME size:12];
    tempLabel.textColor = UIColorFromRGB(0x999999);
    tempLabel.text = @"*等额本金还款额逐月减少，等额本息还款每月相同";
    tempLabel.textAlignment = NSTextAlignmentCenter;
    tempLabel.backgroundColor = [UIColor clearColor];
    [sonShangView_one addSubview:tempLabel];
    
    sonShangView_two = [[UIView alloc]initWithFrame:CGRectMake(0, 0, kScreenWidth, 385+55+70+20+40)];
    sonShangView_two.backgroundColor = [UIColor clearColor];
    sonShangView_two.userInteractionEnabled = YES;
    sonShangView_two.hidden = YES;
    [shangDaiView addSubview:sonShangView_two];
    
    businessTableTwoView = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, kScreenWidth, 440)];
    [sonShangView_two addSubview:businessTableTwoView];
    businessTableTwoView.scrollEnabled = NO;
    businessTableTwoView.delegate = self;
    businessTableTwoView.dataSource = self;

    for (int i = 0; i < 2; i++) {
        UIView *line = [[UIView alloc] initWithFrame:CGRectMake(0, 0+440*i, kScreenWidth, 0.5)];
        [line setBackgroundColor:[UIColor lightGrayColor]];
        [sonShangView_two addSubview:line];
    }
    
    UILabel *tempTwoLabel  = [[UILabel alloc]initWithFrame:CGRectMake(10, 450, kScreenWidth - 20, 21)];
    tempTwoLabel.font = [UIFont fontWithName:FONTNAME size:12];
    tempTwoLabel.textColor = UIColorFromRGB(0x999999);
    tempTwoLabel.text = @"*等额本金还款额逐月减少，等额本息还款每月相同";
    tempTwoLabel.textAlignment = NSTextAlignmentCenter;
    tempTwoLabel.backgroundColor = [UIColor clearColor];
    [sonShangView_two addSubview:tempTwoLabel];
    
    //添加按钮
    UIButton * shangTwoBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    shangTwoBtn.userInteractionEnabled = YES;
    shangTwoBtn.frame = CGRectMake(10, 490, kScreenWidth - 20, 50);
//    [shangTwoBtn setButtonBackgroundShadowHighlight];
    [shangTwoBtn setButtonRedAndOrangeBorderStyle];
    [shangTwoBtn setTitle:@"计算" forState:UIControlStateNormal];
    [shangTwoBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [shangTwoBtn addTarget:self action:@selector(jiSuanAction:) forControlEvents:UIControlEventTouchUpInside];
    [sonShangView_two addSubview:shangTwoBtn];
    
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
    NSDecimalNumber *jiaGeNumber = [NSDecimalNumber decimalNumberWithString:shangJiaGe.text];
    NSDecimalNumber *mianJiNumber = [NSDecimalNumber decimalNumberWithString:shangMianJi.text];
    NSDecimalNumber *ZongJiaNumber = [jiaGeNumber decimalNumberByMultiplyingBy:mianJiNumber];
    NSString *zongJiaStr = [ZongJiaNumber stringValue];
   // int nian = [[array_6 objectAtIndex:[array_2 indexOfObject:shangDanNianStr]] intValue];
    float cheng = [[shangDanChengStr substringWithRange:NSMakeRange(0, 1)] floatValue]/10;
    NSDecimalNumber *chengNumber = [NSDecimalNumber decimalNumberWithString:[NSString stringWithFormat:@"%f",cheng]];
    
    int yueShu = [[array_6 objectAtIndex:[array_2 indexOfObject:shangDanNianStr]] intValue]*12;//贷款月数
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
    NSDecimalNumber *jiaGeNumber = [NSDecimalNumber decimalNumberWithString:shangJiaGe.text];
    NSDecimalNumber *mianJiNumber = [NSDecimalNumber decimalNumberWithString:shangMianJi.text];
    int nian = [[array_6 objectAtIndex:[array_2 indexOfObject:shangDanNianStr]] intValue];
    float cheng = [[shangDanChengStr substringWithRange:NSMakeRange(0, 1)] floatValue]/10;
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
    NSDecimalNumber *daiZongNumber = [NSDecimalNumber decimalNumberWithString:shangZong.text];
    daiZongNumber = [daiZongNumber decimalNumberByMultiplyingBy:[NSDecimalNumber decimalNumberWithString:@"10000"]];
    NSString *daiZongStr = [daiZongNumber stringValue];
    
    int yueShu = [[array_6 objectAtIndex:[array_2 indexOfObject:shangDanNianStr]] intValue]*12;//贷款月数
    NSDecimalNumber *yueShuNumber = [NSDecimalNumber decimalNumberWithString:[NSString stringWithFormat:@"%d",yueShu]];//贷款月数
    NSDecimalNumber *lilvNumber = [NSDecimalNumber decimalNumberWithString:label_2.text];
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
    NSDecimalNumber *daiZongNumber = [NSDecimalNumber decimalNumberWithString:shangZong.text];
    daiZongNumber = [daiZongNumber decimalNumberByMultiplyingBy:[NSDecimalNumber decimalNumberWithString:@"10000"]];
    NSString *daiZongStr = [daiZongNumber stringValue];
    int yueShu = [[array_6 objectAtIndex:[array_2 indexOfObject:shangDanNianStr]] intValue]*12;//贷款月数
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
    NSDecimalNumber *jiaGeNumber = [NSDecimalNumber decimalNumberWithString:gongJiaGe.text];
    NSDecimalNumber *mianJiNumber = [NSDecimalNumber decimalNumberWithString:gongMianJi.text];
    NSDecimalNumber *ZongJiaNumber = [jiaGeNumber decimalNumberByMultiplyingBy:mianJiNumber];
    NSString *zongJiaStr = [ZongJiaNumber stringValue];
    //int nian = [[array_6 objectAtIndex:[array_2 indexOfObject:gongDanNianStr]] intValue];
    float cheng = [[gongDanChengStr substringWithRange:NSMakeRange(0, 1)] floatValue]/10;
    NSDecimalNumber *chengNumber = [NSDecimalNumber decimalNumberWithString:[NSString stringWithFormat:@"%f",cheng]];
    
    int yueShu = [[array_6 objectAtIndex:[array_2 indexOfObject:gongDanNianStr]] intValue]*12;//贷款月数
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
    NSDecimalNumber *jiaGeNumber = [NSDecimalNumber decimalNumberWithString:gongJiaGe.text];
    NSDecimalNumber *mianJiNumber = [NSDecimalNumber decimalNumberWithString:gongMianJi.text];
    int nian = [[array_6 objectAtIndex:[array_2 indexOfObject:gongDanNianStr]] intValue];
    float cheng = [[gongDanChengStr substringWithRange:NSMakeRange(0, 1)] floatValue]/10;
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
    NSDecimalNumber *daiZongNumber = [NSDecimalNumber decimalNumberWithString:gongZong.text];
    daiZongNumber = [daiZongNumber decimalNumberByMultiplyingBy:[NSDecimalNumber decimalNumberWithString:@"10000"]];
    NSString *daiZongStr = [daiZongNumber stringValue];
    
    int yueShu = [[array_6 objectAtIndex:[array_2 indexOfObject:gongDanNianStr]] intValue]*12;//贷款月数
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
    NSDecimalNumber *daiZongNumber = [NSDecimalNumber decimalNumberWithString:gongZong.text];
    daiZongNumber = [daiZongNumber decimalNumberByMultiplyingBy:[NSDecimalNumber decimalNumberWithString:@"10000"]];
    NSString *daiZongStr = [daiZongNumber stringValue];
    int yueShu = [[array_6 objectAtIndex:[array_2 indexOfObject:gongDanNianStr]] intValue]*12;//贷款月数
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
    float gongKuan = [gongDai.text floatValue]*10000;//公积金贷款
    float shangKuan = [shangDai.text floatValue]*10000;//商业贷款
    NSDecimalNumber *gongKuanNumber = [NSDecimalNumber decimalNumberWithString:[NSString stringWithFormat:@"%f",gongKuan]];
    NSDecimalNumber *shangKuanNumber = [NSDecimalNumber decimalNumberWithString:[NSString stringWithFormat:@"%f",shangKuan]];
    int yueShu = [[array_6 objectAtIndex:[array_2 indexOfObject:zuheNianStr]] intValue]*12;//贷款月数
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
    float gongKuan = [gongDai.text floatValue]*10000;//公积金贷款
    float shangKuan = [shangDai.text floatValue]*10000;//商业贷款
    NSDecimalNumber *gongKuanNumber = [NSDecimalNumber decimalNumberWithString:[NSString stringWithFormat:@"%f",gongKuan]];
    NSDecimalNumber *shangKuanNumber = [NSDecimalNumber decimalNumberWithString:[NSString stringWithFormat:@"%f",shangKuan]];
    int yueShu = [[array_6 objectAtIndex:[array_2 indexOfObject:zuheNianStr]] intValue]*12;//贷款月数
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
/**
 *	@brief	绘制公积金页面
 *
 *	@return	 无
 */
-(void)creatAccumulation
{
    gongView = [[UIView alloc]init];
    gongView.frame = CGRectMake(0, 48, kScreenWidth, 550);
    gongView.backgroundColor = [UIColor clearColor];
    [userContentView addSubview:gongView];
    
    sonGongView_one = [[UIView alloc]initWithFrame:CGRectMake(0, 0, kScreenWidth, 385+55+70)];
    sonGongView_one.backgroundColor = [UIColor clearColor];
    sonGongView_one.hidden = NO;
    [gongView addSubview:sonGongView_one];
    
    accmulationTableOneView = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, kScreenWidth, 275+55)];
    [sonGongView_one addSubview:accmulationTableOneView];
    accmulationTableOneView.delegate = self;
    accmulationTableOneView.dataSource = self;
    for (int i = 0; i < 2; i++) {
        UIView *line = [[UIView alloc] initWithFrame:CGRectMake(0, 0+330*i, kScreenWidth, 0.5)];
        [line setBackgroundColor:[UIColor lightGrayColor]];
        [sonGongView_one addSubview:line];
    }
    //添加按钮
    UIButton * shangOneBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    shangOneBtn.frame = CGRectMake(10, 380, kScreenWidth - 20, 50);
//    [shangOneBtn setButtonBackgroundShadowHighlight];
    [shangOneBtn setButtonRedAndOrangeBorderStyle];
    [shangOneBtn setTitle:@"计算" forState:UIControlStateNormal];
    [shangOneBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [shangOneBtn addTarget:self action:@selector(jiSuanAction:) forControlEvents:UIControlEventTouchUpInside];
    [sonGongView_one addSubview:shangOneBtn];
    
    UILabel *tempLabel  = [[UILabel alloc]initWithFrame:CGRectMake(10, 340, kScreenWidth - 20, 21)];
    tempLabel.font = [UIFont fontWithName:FONTNAME size:12];
    tempLabel.textColor = UIColorFromRGB(0x999999);
    tempLabel.text = @"*等额本金还款额逐月减少，等额本息还款每月相同";
    tempLabel.textAlignment = NSTextAlignmentCenter;
    tempLabel.backgroundColor = [UIColor clearColor];
    [sonGongView_one addSubview:tempLabel];
    
    
    
    sonGongView_two = [[UIView alloc]initWithFrame:CGRectMake(0, 0, kScreenWidth, 385+55+70+20+40)];
    sonGongView.clipsToBounds = YES;
    sonGongView_two.backgroundColor = [UIColor clearColor];
    sonGongView_two.hidden = YES;
    [gongView  addSubview:sonGongView_two];
    
    accmulationTableTwoView = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, kScreenWidth, 385+55)];
    [sonGongView_two addSubview:accmulationTableTwoView];
    accmulationTableTwoView.delegate = self;
    accmulationTableTwoView.dataSource = self;
    
    for (int i = 0; i < 2; i++) {
        UIView *line = [[UIView alloc] initWithFrame:CGRectMake(0, 0+440*i, kScreenWidth, 0.5)];
        [line setBackgroundColor:[UIColor lightGrayColor]];
        [sonGongView_two addSubview:line];
    }
    
    //添加按钮
    UIButton * shangTwoBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    shangTwoBtn.frame = CGRectMake(42, 490, 216, 50);
//    [shangTwoBtn setButtonBackgroundShadowHighlight];
    [shangTwoBtn setButtonRedAndOrangeBorderStyle];
    [shangTwoBtn setTitle:@"计算" forState:UIControlStateNormal];
    [shangTwoBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [shangTwoBtn addTarget:self action:@selector(jiSuanAction:) forControlEvents:UIControlEventTouchUpInside];
    [sonGongView_two addSubview:shangTwoBtn];
    
    UILabel *tempTwoLabel  = [[UILabel alloc]initWithFrame:CGRectMake(10, 450, kScreenWidth - 20, 21)];
    tempTwoLabel.font = [UIFont fontWithName:FONTNAME size:12];
    tempTwoLabel.textColor = UIColorFromRGB(0x999999);
    tempTwoLabel.text = @"*等额本金还款额逐月减少，等额本息还款每月相同";
    tempTwoLabel.textAlignment = NSTextAlignmentCenter;
    tempTwoLabel.backgroundColor = [UIColor clearColor];
    [sonGongView_two addSubview:tempTwoLabel];
}
/**
 *	@brief	绘制组合页面
 *
 *	@return	 无
 */
-(void)createAssociationView
{
    zuHeView = [[UIView alloc]init];
    zuHeView.frame = CGRectMake(0, 48, kScreenWidth, 550);
    zuHeView.backgroundColor = [UIColor clearColor];
    [userContentView addSubview:zuHeView];
    associationTableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, kScreenWidth, 330)];
    [zuHeView addSubview:associationTableView];
    associationTableView.delegate = self;
    associationTableView.dataSource = self;
    
    for (int i = 0; i < 2; i++) {
        UIView *line = [[UIView alloc] initWithFrame:CGRectMake(0, 0+330*i, kScreenWidth, 0.5)];
        [line setBackgroundColor:[UIColor lightGrayColor]];
        [zuHeView addSubview:line];
    }
    
    //添加按钮
    UIButton * shangOneBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    shangOneBtn.frame = CGRectMake(10, 380, kScreenWidth - 20, 50);
//    [shangOneBtn setButtonBackgroundShadowHighlight];
    [shangOneBtn setButtonRedAndOrangeBorderStyle];
    [shangOneBtn setTitle:@"计算" forState:UIControlStateNormal];
    [shangOneBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [shangOneBtn addTarget:self action:@selector(jiSuanAction:) forControlEvents:UIControlEventTouchUpInside];
    [zuHeView addSubview:shangOneBtn];
    
    UILabel *tempLabel  = [[UILabel alloc]initWithFrame:CGRectMake(10, 340, kScreenWidth - 20, 21)];
    tempLabel.font = [UIFont fontWithName:FONTNAME size:12];
    tempLabel.textColor = UIColorFromRGB(0x999999);
    tempLabel.text = @"*等额本金还款额逐月减少，等额本息还款每月相同";
    
    tempLabel.textAlignment = NSTextAlignmentCenter;
    tempLabel.backgroundColor = [UIColor clearColor];
    [zuHeView addSubview:tempLabel];
}
#pragma mark - table foot
-(UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section
{
    
    if (tableView == businessTableOneView) {
        UIView *footView = [[UIView alloc]initWithFrame:CGRectMake(0, 17, kScreenWidth, 20)];
        //显示利率
        label_2 = [[UILabel alloc]initWithFrame:CGRectMake(182, 17, 100, 21)];
        label_2.font = [UIFont fontWithName:FONTNAME size:14];
        label_2.text = @"5.9%";
        label_2.textAlignment = NSTextAlignmentLeft;
        label_2.backgroundColor = [UIColor clearColor];
        label_2.textColor = UIColorFromRGB(0x999999);
        [footView addSubview:label_2];
        
        UILabel *tempLabel = [[UILabel alloc]initWithFrame:CGRectMake(13, 17, 170, 21)];
        tempLabel.font = [UIFont fontWithName:FONTNAME size:14];
        tempLabel.text = @"商业贷款利率:";
        tempLabel.textAlignment = NSTextAlignmentRight;
        tempLabel.backgroundColor = [UIColor clearColor];
        tempLabel.textColor = UIColorFromRGB(0x999999);
        [footView addSubview:tempLabel];
        return footView;
    }
    else if(tableView == businessTableTwoView)
    {
        UIView *footView = [[UIView alloc]initWithFrame:CGRectMake(0, 17, kScreenWidth, 20)];
        footView.backgroundColor = [UIColor clearColor];
        //显示利率
        label_1 = [[UILabel alloc]initWithFrame:CGRectMake(182, 17, 100, 21)];
        label_1.font = [UIFont fontWithName:FONTNAME size:14];
        label_1.textAlignment = NSTextAlignmentLeft;
        label_1.backgroundColor = [UIColor clearColor];
        [footView addSubview:label_1];
        label_1.textColor = UIColorFromRGB(0x999999);
        label_1.text =@"5.9%";
        
        
        UILabel *tempLabel = [[UILabel alloc]initWithFrame:CGRectMake(13, 17, 170, 21)];
        tempLabel.font = [UIFont fontWithName:FONTNAME size:14];
        tempLabel.text = @"商业贷款利率:";
        tempLabel.textAlignment = NSTextAlignmentRight;
        tempLabel.backgroundColor = [UIColor clearColor];
        tempLabel.textColor = UIColorFromRGB(0x999999);
        [footView addSubview:tempLabel];
        return footView;
    }
    else if(tableView == accmulationTableOneView)
    {
        UIView *footView = [[UIView alloc]initWithFrame:CGRectMake(0, 17, kScreenWidth, 20)];
        //显示利率
        label_4 = [[UILabel alloc]initWithFrame:CGRectMake(200, 17, 100, 20)];
        label_4.font = [UIFont fontWithName:FONTNAME size:14];
        label_4.text = @"4.0%";
        label_4.textAlignment = NSTextAlignmentLeft;
        label_4.backgroundColor = [UIColor clearColor];
        label_4.textColor = UIColorFromRGB(0x999999);
        [footView addSubview:label_4];
        
        
        UILabel *tempLabel = [[UILabel alloc]initWithFrame:CGRectMake(9, 17, 190, 21)];
        tempLabel.font = [UIFont fontWithName:FONTNAME size:14];
        tempLabel.text = @"公积金贷款利率:";
        tempLabel.textAlignment = NSTextAlignmentRight;
        tempLabel.backgroundColor = [UIColor clearColor];
        tempLabel.textColor = UIColorFromRGB(0x999999);
        [footView addSubview:tempLabel];
        return footView;
    }
    else if(tableView == accmulationTableTwoView)
    {
        UIView *footView = [[UIView alloc]initWithFrame:CGRectMake(0, 17, kScreenWidth, 20)];
        //显示利率
        label_3 = [[UILabel alloc]initWithFrame:CGRectMake(200, 17, 100, 20)];
        label_3.font = [UIFont fontWithName:FONTNAME size:14];
        label_3.text = @"4.0%";
        label_3.textAlignment = NSTextAlignmentLeft;
        label_3.backgroundColor = [UIColor clearColor];
        label_3.textColor = UIColorFromRGB(0x999999);
        [footView addSubview:label_3];
        
        UILabel *tempLabel = [[UILabel alloc]initWithFrame:CGRectMake(9, 17, 190, 21)];
        tempLabel.font = [UIFont fontWithName:FONTNAME size:14];
        tempLabel.text = @"公积金贷款利率:";
        tempLabel.textAlignment = NSTextAlignmentRight;
        tempLabel.backgroundColor = [UIColor clearColor];
        tempLabel.textColor = UIColorFromRGB(0x999999);
        [footView addSubview:tempLabel];
        return footView;
    }
    else if(tableView == associationTableView)
    {

        UIView *footView = [[UIView alloc]initWithFrame:CGRectMake(0, 17, kScreenWidth, 20)];
        UILabel *tempLabelOne = [[UILabel alloc]initWithFrame:CGRectMake(68, 5, 130, 21)];
        tempLabelOne.font = [UIFont fontWithName:FONTNAME size:14];
        tempLabelOne.text = @"公积金贷款利率:";
        tempLabelOne.textAlignment = NSTextAlignmentRight;
        tempLabelOne.backgroundColor = [UIColor clearColor];
        tempLabelOne.textColor = UIColorFromRGB(0x999999);
        [footView addSubview:tempLabelOne];
        //显示利率
        label_5 = [[UILabel alloc]initWithFrame:CGRectMake(200, 5, 100, 20)];
        label_5.font = [UIFont fontWithName:FONTNAME size:14];
        label_5.text = @"4.0%";
        label_5.textAlignment = NSTextAlignmentLeft;
        label_5.backgroundColor = [UIColor clearColor];
        label_5.textColor = UIColorFromRGB(0x999999);
        [footView addSubview:label_5];
        
        
        UILabel *tempLabel = [[UILabel alloc]initWithFrame:CGRectMake(84, 30, 100, 21)];
        tempLabel.font = [UIFont fontWithName:FONTNAME size:14];
        tempLabel.text = @"商业贷款利率:";
        tempLabel.textAlignment = NSTextAlignmentRight;
        tempLabel.backgroundColor = [UIColor clearColor];
        tempLabel.textColor = UIColorFromRGB(0x999999);
        [footView addSubview:tempLabel];
        
        
        label_6 = [[UILabel alloc]initWithFrame:CGRectMake(168, 30, 100, 20)];
        label_6.font = [UIFont fontWithName:FONTNAME size:14];
        label_6.text = @"5.9%";
        label_6.textAlignment = NSTextAlignmentCenter;
        label_6.backgroundColor = [UIColor clearColor];
        label_6.textColor = UIColorFromRGB(0x999999);
        [footView addSubview:label_6];
        return footView;
    }
    
    return nil;
}
- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    if (tableView == businessTableOneView || tableView == businessTableTwoView || tableView == accmulationTableOneView||tableView == accmulationTableTwoView) {
        return 55.0f;
    }
    else if(tableView == associationTableView)
    {
        return 55.0f;
    }
    else{
        return 0.0f;
    }
}

#pragma mark textfield delegate
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
    [businessTableOneView setContentOffset:CGPointMake(0, 0) animated:YES];
    [businessTableTwoView setContentOffset:CGPointMake(0, 0) animated:YES];
    [accmulationTableOneView setContentOffset:CGPointMake(0, 0) animated:YES];
    [accmulationTableTwoView setContentOffset:CGPointMake(0, 0) animated:YES];
    [associationTableView setContentOffset:CGPointMake(0, 0) animated:YES];
    
}
@end
