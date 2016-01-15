//
//  HWSubmitOrderViewController.m
//  Community
//
//  Created by ryder on 7/30/15.
//  Copyright (c) 2015 caijingpeng. All rights reserved.
//

#import "HWSubmitOrderViewController.h"
#import "HWConfirmPaymentViewController.h"

@interface HWSubmitOrderViewController ()

@end

@implementation HWSubmitOrderViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.submitOrderView = [HWSubmitOrderView new];
    [self.view addSubview:self.submitOrderView];
    self.submitOrderView.delegate = self;
    self.navigationItem.title = @"天天团";
    
    UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 80, 30)];
    label.text = @"33:33";
    
    UIBarButtonItem *timer = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"倒计时"]
                                                              style:UIBarButtonItemStylePlain
                                                             target:self
                                                             action:@selector(timer)];
    timer.tintColor = THEME_COLOR_ORANGE;
    UIBarButtonItem *timerString = [[UIBarButtonItem alloc] initWithTitle:@"33:33"
                                                                    style:UIBarButtonItemStylePlain
                                                                   target:self action:nil];
    self.navigationItem.rightBarButtonItems = @[timer,timerString];
    timerString.tintColor = THEME_COLOR_ORANGE;
}

- (void)timer
{
    
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

- (void)didSubmitOrder
{
    dispatch_async(dispatch_get_main_queue(), ^{
        HWConfirmPaymentViewController *controller = [[HWConfirmPaymentViewController alloc] init];
        [self.navigationController pushViewController:controller animated:YES];
    });
}

@end
