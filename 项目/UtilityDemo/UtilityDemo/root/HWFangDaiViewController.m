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
#import "Define-OC.h"
#import "HWFangDaiBusiness.h"
#import "HWFangGongJiJin.h"
#import "HWFangeZuHeView.h"

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

//@property (nonatomic, retain) UIView * shangDaiView;//商贷背景视图
//@property (nonatomic, retain) UIView * sonShangView_one;//商贷子视图一
//@property (nonatomic, retain) UIView * sonShangView_two;//商贷子视图二
@property (nonatomic, retain)HWFangDaiBusiness *shangdaiView;

@property (nonatomic, retain) HWFangGongJiJin * gongJiView;//公积金背景视图
@property (nonatomic, retain) UIView * sonGongView_one;//公积金贷款子视图一
@property (nonatomic, retain) UIView * sonGongView_two;//公积金贷款子视图二
@property (nonatomic, retain) UIView * sonGongView;//公积金贷款子视图
@property (nonatomic, retain) HWFangeZuHeView * zuHeView;//组合背景视图


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
@synthesize zuHeView,sonGongView,sonGongView_one,sonGongView_two;
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

/**
 *	@brief	初始化数据
 *
 *	@return	 无
 */

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
            _shangdaiView.hidden = NO;
            _gongJiView.hidden = YES;
            zuHeView.hidden = YES;
            jiSuanType = @"商业贷款";
            huanKuanType = @"等额本息";
            break;
        case 1:
            rateStr = @"4.0%";
            self.rateIndex = 0;
            self.index = 19;
            lilvStr = shangDefault;
            _gongJiView.hidden = NO;
            _shangdaiView.hidden = YES;
            zuHeView.hidden = YES;
            jiSuanType = @"公积金贷款";
            huanKuanType = @"等额本息";

            break;
        case 2:
            rateStr = @"5.5675%";
            accumulationStr = @"3.825%";
            zuHeView.hidden = NO;
            _shangdaiView.hidden = YES;
            _gongJiView.hidden = YES;
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
    self.navigationItem.leftBarButtonItem = [Utility navLeftBackBtn:self action:@selector(backBtn:)];
    //创建数组
    //[self creatDataArray];
    //[self createDataDictory];
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
    _shangdaiView.hidden = NO;
    _gongJiView.hidden = YES;
    zuHeView.hidden = YES;
    jiSuanType = @"商业贷款";
    suanType = @"总价计算";
    accmulationSuanType = @"总价计算";

    tabArray = [[NSMutableArray alloc]initWithCapacity:0];
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

/**
 *	@brief	返回公积金年数，利率以及索引
 *
 *	@param 	year
 *	@param 	rate
 *	@param 	indexTemp
 *
 *	@return	 年数，利率以及索引
 */

/**
 *	@brief	确认以何种方式计算
 *
 *	@return	 无
 */


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
    self.shangdaiView = [[HWFangDaiBusiness alloc]init];
    
    self.shangdaiView.frame = CGRectMake(0, 48, kScreenWidth, 550);
    

    
    [userContentView addSubview:self.shangdaiView];
    
    
    __weak HWFangDaiViewController *weakSelf = self;
    
    self.shangdaiView.turnToNextVC = ^(NSInteger temp, NSInteger row)
    {
        
        [weakSelf.navigationController pushViewController:weakSelf.shangdaiView.cellSelectedVC animated:YES];
    };
    
    self.shangdaiView.turnToResultVC = ^(HWFangResultViewController *resultVC)
    {
        [weakSelf.navigationController pushViewController:resultVC animated:YES];
    };
    
}


/**
 *	@brief	绘制公积金页面
 *
 *	@return	 无
 */
-(void)creatAccumulation
{
    
    self.gongJiView = [[HWFangGongJiJin alloc]init];
    
    self.gongJiView.frame = CGRectMake(0, 48, kScreenWidth, 550);
    
    
    
    [userContentView addSubview:self.gongJiView];
    
    
    __weak HWFangDaiViewController *weakSelf = self;
    
    self.gongJiView.turnToNextVC = ^(NSInteger temp, NSInteger row)
    {
        
        
        
        [weakSelf.navigationController pushViewController:weakSelf.gongJiView.cellSelectedVC animated:YES];
    };
    
    self.gongJiView.turnToResultVC = ^(HWFangResultViewController *resultVC)
    {
        [weakSelf.navigationController pushViewController:resultVC animated:YES];
    };
    
}
/**
 *	@brief	绘制组合页面
 *
 *	@return	 无
 */
-(void)createAssociationView
{
    zuHeView = [[HWFangeZuHeView alloc]init];
    zuHeView.frame = CGRectMake(0, 48, kScreenWidth, 550);
    zuHeView.backgroundColor = [UIColor clearColor];
    [userContentView addSubview:zuHeView];

    
    __weak HWFangDaiViewController *weakSelf = self;
    
    zuHeView.turnToNextVC =  ^(NSInteger temp, NSInteger row)
    {
        
        [weakSelf.navigationController pushViewController:weakSelf.zuHeView.cellSelectedVC animated:YES];
    };
    
    self.zuHeView.turnToResultVC = ^(HWFangResultViewController *resultVC)
    {
        [weakSelf.navigationController pushViewController:resultVC animated:YES];
    };
        
}



- (void)turnToResultVC:(HWFangResultViewController *)resultVC
{
    [self.navigationController pushViewController:resultVC animated:YES];
}







@end
