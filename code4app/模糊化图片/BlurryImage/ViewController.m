//
//  ViewController.m
//  BlurryImage
//
//  Created by guohu on 15/7/14.
//  Copyright (c) 2015年 idouzi.com. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    self.m_mainViewController = [[MainViewController alloc] init];
    self.m_mainViewController.view.frame = self.view.frame;
    [self.view addSubview:self.m_mainViewController.view];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
@end
