//
//  HWHouseTaxCalculatorViewController.h
//  HaoWuAgenciesEdition
//
//  Created by lizhongqiang on 14-7-4.
//  Copyright (c) 2014年 ZhuMing. All rights reserved.
//

#import "HWBaseViewControllerOC.h"

@interface HWHouseTaxCalculatorViewController : HWBaseViewControllerOC<UITextFieldDelegate,UIScrollViewDelegate>
@property (retain, nonatomic) UIScrollView *bigScrollView;
@property (retain, nonatomic) UIButton *countButton;
@property (retain, nonatomic) UITextField *priceTextField;        //单价
@property (retain, nonatomic) UITextField *areaTextField;         //面积

@property (retain, nonatomic) UILabel *deedLeft;
@property (retain, nonatomic) UILabel *stampLeft;
@property (retain, nonatomic) UILabel *notarialLeft;
@property (retain, nonatomic) UILabel *saleLeft;


@property (retain, nonatomic) UILabel *deedTaxLabel;              //契税
@property (retain, nonatomic) UILabel *stampDutyLabel;            //印花税
@property (retain, nonatomic) UILabel *notarialFeesLabel;         //公证费
@property (retain, nonatomic) UILabel *saleHouseTaxLabel;         //买卖房屋手续费
@property (retain, nonatomic) UIButton *firstHouseBtn;           //是否首套房
@property (retain, nonatomic) UILabel *deedYuan;                 //契税 元
@property (retain, nonatomic) UILabel *stampYuan;                //印花税 元
@property (retain, nonatomic) UILabel *notarialYuan;             //公证费 元
@property (retain, nonatomic) UILabel *saleYuan;                 //买卖费 元

- (IBAction)countBtn:(id)sender;
- (IBAction)isFirstHouse:(id)sender;

@end
