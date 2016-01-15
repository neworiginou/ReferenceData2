//
//  BaseNav.m
//  BOSS刷新模拟
//
//  Created by lizhongqiang on 16/1/10.
//  Copyright © 2016年 lizhongqiang. All rights reserved.
//

#import "BaseNav.h"

@interface BaseNav ()

@end

@implementation BaseNav

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self.navigationBar setBackgroundImage:[self backImage:[UIColor colorWithRed:71/255.f green:192/255.f blue:182/255.f alpha:1.0]] forBarMetrics:UIBarMetricsDefault];
    [self.navigationBar setShadowImage:[self backImage:[UIColor clearColor]]];
    self.navigationBar.userInteractionEnabled = YES;
}
- (UIImage *)backImage:(UIColor *)color{
    UIImage *backImage = nil;
    UIGraphicsBeginImageContext(CGSizeMake(1, 1));
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextSetFillColorWithColor(context, color.CGColor);
    CGContextFillRect(context, CGRectMake(0, 0, 1, 1));
    CGContextDrawPath(context, kCGPathFill);
    backImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return backImage;
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
