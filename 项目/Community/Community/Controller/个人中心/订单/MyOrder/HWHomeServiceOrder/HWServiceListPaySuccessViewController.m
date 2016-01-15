//
//  HWServiceListPaySuccessViewController.m
//  Community
//
//  Created by hw500027 on 15/6/25.
//  Copyright (c) 2015年 caijingpeng. All rights reserved.
//

#import "HWServiceListPaySuccessViewController.h"
#import "HWServiceEvaluateVC.h"

@interface HWServiceListPaySuccessViewController ()

@end

@implementation HWServiceListPaySuccessViewController

- (void)viewDidAppear:(BOOL)animated
{
    [self.navigationController setNavigationBarHidden:YES animated:NO];
    
    MLNavigationController *navigation = (MLNavigationController *)self.navigationController;
    navigation.canDragBack = NO;
}

- (void)viewDidDisappear:(BOOL)animated
{
    [self.navigationController setNavigationBarHidden:NO animated:NO];
    
    MLNavigationController *navigation = (MLNavigationController *)self.navigationController;
    navigation.canDragBack = YES;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    [self configUI];
}

- (void)didClickBtn:(UIButton *)btn
{
    if (btn.tag == 123)
    {
        NSLog(@"评价服务");
        HWServiceEvaluateVC *vc = [[HWServiceEvaluateVC alloc] init];
        vc.currentOrderId = _orderId;
        
        if (self.pushType == pushPaySuccessTypeWY)
        {
            vc.pushType = pushEvaluateTypeWYPayEvlaute;
        }
        else if (self.pushType == pushPaySuccessTypeList)
        {
            vc.pushType = pushEvaluateTypeListPayEvlaute;
        }
        else if (self.pushType == pushPaySuccessTypeDetail)
        {
            vc.pushType = pushEvaluateTypeDetailPayEvlaute;
        }
        else
        {
            vc.pushType = pushEvaluateTypeDetailPayEvlaute;
        }
        [self.navigationController pushViewController:vc animated:YES];
    }
    else
    {
        NSLog(@"返回物业");
        if (self.pushType == pushPaySuccessTypeList)
        {
            NSArray *vcArr = self.navigationController.viewControllers;
            UIViewController *lastScdVC = [vcArr pObjectAtIndex:vcArr.count - 3];
            [self.navigationController popToViewController:lastScdVC animated:YES];
        }
        else if (self.pushType == pushPaySuccessTypeDetail)
        {
            NSArray *vcArr = self.navigationController.viewControllers;
            UIViewController *lastScdVC = [vcArr pObjectAtIndex:vcArr.count - 3];
            [self.navigationController popToViewController:lastScdVC animated:YES];
        }
        else if (self.pushType == pushPaySuccessTypeWY)
        {
            NSArray *vcArr = self.navigationController.viewControllers;
            UIViewController *lastScdVC = [vcArr pObjectAtIndex:vcArr.count - 3];
            [self.navigationController popToViewController:lastScdVC animated:YES];
        }
        else
        {
            [self.navigationController popViewControllerAnimated:YES];
        }
    }
}

- (void)configUI
{
    UIImage *img = [UIImage imageNamed:@"icon_success"];
    UIImageView *imgV = [UIImageView newAutoLayoutView];
    imgV.image = img;
    [self.view addSubview:imgV];
    [imgV autoAlignAxis:ALAxisVertical toSameAxisOfView:self.view];
    [imgV autoPinEdge:ALEdgeTop toEdge:ALEdgeTop ofView:self.view withOffset:108 / 2];
    
    UILabel *successLabel = [UILabel newAutoLayoutView];
    [self.view addSubview:successLabel];
    successLabel.text = @"支付成功！";
    successLabel.font = FONT(18);
    successLabel.textAlignment = NSTextAlignmentCenter;
    [successLabel autoPinEdge:ALEdgeTop toEdge:ALEdgeBottom ofView:imgV withOffset:15];
    [successLabel autoAlignAxis:ALAxisVertical toSameAxisOfView:self.view];
    
    CGSize btnSize = CGSizeMake(270 / 2 * kScreenRate, 45);
    for (int i = 0; i < 2; i ++)
    {
        UIButton *btn = [UIButton newAutoLayoutView];
        [self.view addSubview:btn];
        btn.tag = 123 + i;
        btn.layer.masksToBounds = YES;
        btn.layer.cornerRadius = 3;
        if (i == 0)
        {
            [btn setTitle:@"评价服务" forState:UIControlStateNormal];
            [btn autoPinEdge:ALEdgeLeft toEdge:ALEdgeLeft ofView:self.view withOffset:15];
            [btn setBackgroundImage:[Utility imageWithColor:THEBUTTON_GREEN_NORMAL andSize:btnSize] forState:UIControlStateNormal];
            [btn setBackgroundImage:[Utility imageWithColor:THEBUTTON_GREEN_HIGHLIGHT andSize:btnSize] forState:UIControlStateHighlighted];
        }
        else
        {
            NSString *btnTitle;
            if (self.pushType == pushPaySuccessTypeList)
            {
                btnTitle = @"返回列表";
            }
            else if (self.pushType == pushPaySuccessTypeDetail)
            {
                btnTitle = @"返回详情";
            }
            else if (self.pushType == pushPaySuccessTypeWY)
            {
                btnTitle = @"返回物业";
            }
            else
            {
                btnTitle = @"返回物业";
            }
            
            [btn setTitle:btnTitle forState:UIControlStateNormal];
            [btn autoPinEdge:ALEdgeRight toEdge:ALEdgeRight ofView:self.view withOffset:- 15];
            [btn setBackgroundImage:[Utility imageWithColor:THEBUTTON_YELLOW_NORMAL andSize:btnSize] forState:UIControlStateNormal];
            [btn setBackgroundImage:[Utility imageWithColor:THEBUTTON_YELLOW_HIGHLIGHT andSize:btnSize] forState:UIControlStateHighlighted];
        }
        [btn autoPinEdge:ALEdgeTop toEdge:ALEdgeBottom ofView:successLabel withOffset:110 / 2];
        [btn addTarget:self action:@selector(didClickBtn:) forControlEvents:UIControlEventTouchUpInside];
    }
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
