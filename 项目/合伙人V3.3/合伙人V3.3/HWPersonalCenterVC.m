//
//  HWPersonalCenterVC.m
//  合伙人V3.3
//
//  Created by lizhongqiang on 16/1/15.
//  Copyright © 2016年 lizhongqiang. All rights reserved.
//
#define UIColorFromRGB(rgbValue)	    [UIColor colorWithRed:((float)((rgbValue & 0xFF0000) >> 16))/255.0 green:((float)((rgbValue & 0xFF00) >> 8))/255.0 blue:((float)(rgbValue & 0xFF))/255.0 alpha:1.0]

#define CD_MainColor UIColorFromRGB(0xff6600)
#define CD_BackGroundColor     UIColorFromRGB(0xf5f5f5)

#import "HWPersonalCenterVC.h"
#import "HWPersonalHeadView.h"
#import "HWAlertView.h"
@interface HWPersonalCenterVC ()
@property (nonatomic, strong)HWPersonalHeadView *headView;
@end

@implementation HWPersonalCenterVC
- (HWPersonalHeadView *)headView{
    if(_headView == nil){
        _headView = [[HWPersonalHeadView alloc]init];
    }
    return _headView;
}
- (void)viewWillAppear:(BOOL)animated{
    self.navigationController.navigationBarHidden = YES;
    [self.view addSubview:self.headView];
    
    UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
    btn.frame = CGRectMake(30, CGRectGetMaxY(self.headView.frame)+50, 50, 30);
    [btn setTitle:@"点我" forState:UIControlStateNormal];
    btn.backgroundColor = [UIColor whiteColor];
    [btn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [self.view addSubview:btn];
    [btn addTarget:self action:@selector(showAction) forControlEvents:UIControlEventTouchUpInside];
}
- (void)showAction{
    HWAlertView *alert = [[HWAlertView alloc]init];
    [alert show];
}
-(void)viewDidLoad{
    self.view.backgroundColor = CD_BackGroundColor;
}
@end
