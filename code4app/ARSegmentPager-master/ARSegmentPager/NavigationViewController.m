//
//  NavigationViewController.m
//  ARSegmentPager
//
//  Created by August on 15/5/9.
//  Copyright (c) 2015年 August. All rights reserved.
//

#import "NavigationViewController.h"

@interface NavigationViewController ()

@end

@implementation NavigationViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    NSDictionary *navbarTitleTextAttributes = [NSDictionary dictionaryWithObjectsAndKeys:
                                               [UIColor whiteColor],NSForegroundColorAttributeName,
                                               [UIFont systemFontOfSize:18],
                                               NSFontAttributeName, nil];
#if 1
    [self.navigationBar setTitleTextAttributes:navbarTitleTextAttributes];//自定义navigationbar的title字体
    
    [self.navigationBar setBackgroundImage:[self createImageWithColor:[UIColor clearColor]] forBarMetrics:UIBarMetricsDefault];
    /*
     UIBarMetricsDefault：用竖着（拿手机）时UINavigationBar的标准的尺寸来显示UINavigationBar
     UIBarMetricsLandscapePhone：用横着时UINavigationBar的标准尺寸来显示UINavigationBar
     */
    
    [self.navigationBar setShadowImage:[self createImageWithColor:[UIColor clearColor]]];
    /*
     为了去除navigationBar下面的黑线，仅仅设置背景颜色是不够的，所以这里需要设置阴影图片
     */
#endif
    
    [self.navigationBar setTintColor:[UIColor whiteColor]];
    /*
     设置navigationBarItem的颜色
     */
    
    [self.navigationBar setTranslucent:YES];
    /*
     设置navigationBar是否透明
     如果setTranslucent=yes 默认的   则状态栏及导航栏底部为透明的
     */
}


-(UIImage *) createImageWithColor: (UIColor *) color
{
    CGRect rect=CGRectMake(0.0f, 0.0f, 1.0f, 1.0f);
    UIGraphicsBeginImageContext(rect.size);
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextSetFillColorWithColor(context, [color CGColor]);
    CGContextFillRect(context, rect);
    
    UIImage *theImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return theImage;
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
