//
//  HWBaseNavigationController.m
//  Community
//
//  Created by caijingpeng.haowu on 14-8-27.
//  Copyright (c) 2014年 caijingpeng. All rights reserved.
//

#import "HWBaseNavigationController.h"

@interface HWBaseNavigationController ()

@end

@implementation HWBaseNavigationController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

/*
- (UIStatusBarStyle)preferredStatusBarStyle
{
    return UIStatusBarStyleLightContent;
}
 */

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    if (IOS7)
    {
//        [self setNeedsStatusBarAppearanceUpdate];
        self.edgesForExtendedLayout = UIRectEdgeNone;
    }
    
    [self.navigationBar setBackgroundImage:[Utility imageWithColor:[UIColor whiteColor] andSize:CGSizeMake(kScreenWidth, (IOS7 ? 64 : 44))] forBarMetrics:UIBarMetricsDefault];
    // Do any additional setup after loading the view.
}

- (void)setNavigationBarBlackColor
{
    [self.navigationBar setBackgroundImage:[Utility imageWithColor:[UIColor blackColor] andSize:CGSizeMake(kScreenWidth, (IOS7 ? 64 : 44))] forBarMetrics:UIBarMetricsDefault];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*[self.navigationBar setBackgroundImage:[Utility imageWithColor:[UIColor colorWithWhite:1 alpha:0.9] andSize:CGSizeMake(kScreenWidth, (IOS7 ? 64 : 44))] forBarMetrics:UIBarMetricsDefault];
 
 self.navigationBar.translucent = YES;
 // Do any additional setup after loading the view.
 self.navigationController.delegate = self;*/

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
