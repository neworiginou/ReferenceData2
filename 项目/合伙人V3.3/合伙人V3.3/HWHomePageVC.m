//
//  HWHomePageVC.m
//  合伙人V3.3
//
//  Created by lizhongqiang on 16/1/16.
//  Copyright © 2016年 lizhongqiang. All rights reserved.
//

#import "HWHomePageVC.h"
#import "HWHomePageView.h"
#define UIColorFromRGB(rgbValue)	    [UIColor colorWithRed:((float)((rgbValue & 0xFF0000) >> 16))/255.0 green:((float)((rgbValue & 0xFF00) >> 8))/255.0 blue:((float)(rgbValue & 0xFF))/255.0 alpha:1.0]

#define CD_MainColor UIColorFromRGB(0xff6600)
#define CD_BackGroundColor     UIColorFromRGB(0xf5f5f5)
@implementation HWHomePageVC
- (void)viewWillAppear:(BOOL)animated{
    self.navigationController.navigationBarHidden = YES;
}
- (void)loadView{
    self.view = [[HWHomePageView alloc]init];
}
-(void)viewDidLoad{
    self.view.backgroundColor = CD_BackGroundColor;
    self.automaticallyAdjustsScrollViewInsets = NO;
}
@end
