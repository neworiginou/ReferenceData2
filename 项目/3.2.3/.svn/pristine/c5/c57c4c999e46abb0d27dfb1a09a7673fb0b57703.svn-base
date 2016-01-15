//
//  HWBaseViewController-OC.m
//  Partner-Swift
//
//  Created by lizhongqiang on 15/3/3.
//  Copyright (c) 2015年 caijingpeng.haowu. All rights reserved.
//

#import "HWBaseViewControllerOC.h"
#import "Define-OC.h"

@interface HWBaseViewControllerOC ()

@end

@implementation HWBaseViewControllerOC

- (void)viewDidLoad {
    [super viewDidLoad];
    
    if (IOS7) {
        self.edgesForExtendedLayout = UIRectEdgeNone;
    }
    self.view.backgroundColor = CD_BackGroundColor;
    self.navigationItem.hidesBackButton = YES;
    // Do any additional setup after loading the view.
}

- (void)backMethod
{
    [self.navigationController popViewControllerAnimated:YES];
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
