//
//  HWHouseTaxCalculatorVC.h
//  CalculatorDemo
//
//  Created by wuxiaohong on 15/4/7.
//  Copyright (c) 2015年 hw. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface HWHouseTaxCalculatorVC : UIViewController<UIScrollViewDelegate,UITableViewDataSource,UITableViewDelegate>

{
    UIScrollView * _bigScrollView;
    UITableView * _calculatorTab;
    UITableView * _resultTab;
    NSArray * _calculatorArry;
    NSArray * _resultArry;
    UIButton *  _countButton;
    BOOL isDianJi;
    UILabel * _deedTaxLabel;
    UILabel * _stampDutyLabel;
    UILabel * _notarialFeesLabel;
    UILabel * _saleHouseTaxLabel;
   

    
}
@property (retain, nonatomic) UITextField *priceTextField;        //单价
@property (retain, nonatomic) UITextField *areaTextField;         //面积


@end
