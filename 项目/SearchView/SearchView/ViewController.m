//
//  ViewController.m
//  SearchView
//
//  Created by lizhongqiang on 15/7/7.
//  Copyright (c) 2015年 lqq. All rights reserved.
//

#import "ViewController.h"

#import "SearchView.h"

#import "NewOldBtn.h"

@interface ViewController ()


@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self addSearchView];
}


- (void)addSearchView
{
    SearchView *searchView = [[SearchView alloc]init];
    
    searchView.frame = CGRectMake(0, 100, 0, 0);
    
    [self.view addSubview:searchView];

    searchView.clickButtomBtn = ^(NSString *string)
    {
        NSLog(@"%@",string);
    };
    searchView.clickTopBtn = ^(NSString *string)
    {
        NSLog(@"%@",string);
    };
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
