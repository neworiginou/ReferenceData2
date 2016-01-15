//
//  HWFangDaiVC.h
//  UtilityDemo
//
//  Created by wuxiaohong on 15/4/8.
//  Copyright (c) 2015年 hw. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "HWAreasTableViewCell.h"
@interface HWFangDaiVC : UIViewController<UITableViewDelegate,UITableViewDataSource>
{
    UIScrollView * _userContentView;
    UISegmentedControl * _segmentControl;
    //UITableView * _fangDaiTab;
    UITableView * _fangDaiOneTab;
    UITableView * _gongJiJingTab;
    UITableView * _gongJiJingOneTab;
    UITableView * _zuHeTab;
}
@property (nonatomic, retain) HWAreasTableViewCell *rememberCell;
@property(nonatomic,retain)UITableView * fangDaiTab;
//字典
@property (nonatomic, retain) NSDictionary *dic_data;
//数组
@property (nonatomic, retain) NSArray * array_1;//成数数组
@property (nonatomic, retain) NSArray * array_2;//年数数组
@property (nonatomic, retain) NSArray * array_3;//按揭利率年份
@property (nonatomic, retain) NSArray * array_6;//贷款年数
@property (nonatomic, retain) NSArray *businessOneArry;
@property (nonatomic, retain) NSArray *businessTwoArry;
@property (nonatomic, retain) NSArray *accmulationArry;
@property (nonatomic, retain) NSArray *associationArry;
@property (nonatomic, retain) NSArray *repaymentArry;
@property (nonatomic, retain) NSArray *caculateWayArry;
@property (nonatomic, retain) NSMutableArray *tabArray;
//字符串
@property (nonatomic, retain)NSString *rateStr;
@property (nonatomic, retain)NSString *accumulationStr;
@property (nonatomic, retain)NSString *lilvStr;

@property (nonatomic, retain) NSString * jiSuanType;//算法类型
@property (nonatomic, retain) NSString * huanKuanType;//还款类型
@property (nonatomic, retain) NSString * suanType;//房价计算类型
@property (nonatomic, retain) NSString * accmulationSuanType;//总价计算类型
@property (nonatomic,retain)  NSString * gongDanChengStr;
@property (nonatomic,retain)  NSString * gongDanNianStr;
@property (nonatomic,retain)  NSString * gongZongNianStr;
@property (nonatomic,retain)  NSString * gongZongLiLvStr;
@property (nonatomic,retain)  NSString * zuheNianStr;
//int
@property (nonatomic, assign) NSInteger index,rateIndex;
//view
@property (nonatomic, retain) UIView * shangDaiView;//商贷背景视图
@property (nonatomic, retain) UIView * sonShangView_one;//商贷子视图一
@property (nonatomic, retain) UIView * sonShangView_two;//商贷子视图二
@property (nonatomic, retain) UIView * gongView;//公积金背景视图
@property (nonatomic, retain) UIView * sonGongView_one;//公积金贷款子视图一
@property (nonatomic, retain) UIView * sonGongView_two;//公积金贷款子视图二
@property (nonatomic, retain) UIView * sonGongView;//公积金贷款子视图
@property (nonatomic, retain) UIView * zuHeView;//组合背景视图
@property (nonatomic, retain) UIView * sonZuView;//组合贷款子视图

@property (nonatomic, retain) UITextField * shangZong;//商贷总额
@property (nonatomic, retain) UILabel * shangZongNian;//商贷总价按揭年数
@property (nonatomic, retain) NSString *shangZongNianStr;
@property (nonatomic, retain) UILabel * shangZongLiLv;//商贷总价利率
@property (nonatomic, retain) UITextField * shangJiaGe;//商贷单价
@property (nonatomic, retain) UITextField * shangMianJi;//商贷面积
@property (nonatomic, retain) UILabel * shangDanCheng;//商贷按揭成数
@property (nonatomic, retain) NSString *shangDanChengStr;
@property (nonatomic, retain) UILabel * shangDanNian;//商贷年数
@property (nonatomic, retain) NSString *shangDanNianStr;//
@property (nonatomic, retain) UILabel * shangDanLiLv;//商贷利率
@property (nonatomic, retain) UILabel * gongZongLiLv;//公积金总价利率
@property (nonatomic, retain) UITextField * gongZong;//公积金总额
@property (nonatomic, retain) UILabel * gongZongNian;//公积金总价按揭年数
@property (nonatomic, retain) UITextField * gongJiaGe;//公积金单价
@property (nonatomic, retain) UITextField * gongMianJi;//公积金面积
@property (nonatomic, retain) UILabel * gongDanCheng;//公积金按揭成数
@property (nonatomic, retain) UILabel * gongDanNian;//公积金年数
@property (nonatomic, retain) UILabel * gongDanLiLv;//公积金利率
@property (nonatomic, retain) UITextField * shangDai;//商业贷款
@property (nonatomic, retain) UITextField * gongDai;//公积金贷款
@property (nonatomic, retain) UILabel * zuHeNian;//组合贷款按揭年数
@property (nonatomic, retain) UILabel * zuHeLiLv;//组合贷款利率

@property (nonatomic, retain) UIView * coverView;//黑色半透明遮盖层
@property (nonatomic, retain) UIImageView * popIMgview;//弹出列表背景
@property (nonatomic, retain) UITableView * popTableView;//弹出列表
@property (nonatomic, retain) UILabel * popLabel;//弹出视图标题
@property (nonatomic, retain) NSString * popType;//弹出视图标识
@property (nonatomic, retain) NSString * xianString;//显示数据

//显示利率
@property (nonatomic, retain) UILabel * label_1;
@property (nonatomic, retain) UILabel * label_2;
@property (nonatomic, retain) UILabel * label_3;
@property (nonatomic, retain) UILabel * label_4;
@property (nonatomic, retain) UILabel * label_5;
@property (nonatomic, retain) UILabel * label_6;
@end
