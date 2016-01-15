//
//  WYYCNavViewController.m
//  无忧云车司机
//
//  Created by luosai19910103@163.com on 15/6/30.
//  Copyright (c) 2015年 wuyouyunche. All rights reserved.
//

//RGB颜色
#define WYColor(r,g,b)     [UIColor colorWithRed:(r)/255.0 green:(g)/255.0 blue:(b)/255.0 alpha:1.0]

#import "WYYCNavViewController.h"

@interface WYYCNavViewController ()

@end

@implementation WYYCNavViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    // Do any additional setup after loading the view.
}

+ (void)initialize{
    
    
    [[UINavigationBar appearance] setBarTintColor:WYColor(0, 179, 221)];
    //设置navigationbar
    NSDictionary *navbarTitleTextAttributes = @{NSForegroundColorAttributeName:[UIColor whiteColor]};
    [[UINavigationBar appearance] setTitleTextAttributes:navbarTitleTextAttributes];
    [[UINavigationBar appearance] setTintColor:[UIColor whiteColor]];
}
-(void)pushViewController:(UIViewController *)viewController animated:(BOOL)animated
{
    [super pushViewController:viewController animated:animated];
    if (viewController.navigationItem.leftBarButtonItem ==nil && self.viewControllers.count >1) {
        viewController.navigationItem.leftBarButtonItem = [self creatBackButton];
    }
}
-(UIBarButtonItem *)creatBackButton
{
    return [[UIBarButtonItem alloc]initWithImage:[UIImage imageNamed:@"navigation_back"]style:UIBarButtonItemStylePlain target:self action:@selector(popSelf) ];
}
-(void)popSelf
{
      [self popViewControllerAnimated:YES];

}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
