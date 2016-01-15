//
//  BaseWhiteViewController.m
//  PUClient
//
//  Created by RRLhy on 15/8/9.
//  Copyright (c) 2015年 RRLhy. All rights reserved.
//

#import "BaseWhiteViewController.h"

@interface BaseWhiteViewController ()

@end

@implementation BaseWhiteViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.

    self.navImage.image = [UIImage stretchImageWithName:@"nav_bg_home"];

    [self.leftBtn setImage:[UIImage imageNamed:@"nav_back_me_n"] forState:UIControlStateNormal];
    [self.leftBtn setImage:[UIImage imageNamed:@"nav_back_me_h"] forState:UIControlStateHighlighted];
  
    self.titleLabel = [[UILabel alloc]initWithFrame:CGRectMake(80, 20, (Main_Screen_Width - 160), 44)];
    self.titleLabel.font = BOLDSYSTEMFONT(18);
    self.titleLabel.textAlignment = NSTextAlignmentCenter;
    [self.navImage addSubview:self.titleLabel];

}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (UIStatusBarStyle)preferredStatusBarStyle
{
    return UIStatusBarStyleDefault;
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
