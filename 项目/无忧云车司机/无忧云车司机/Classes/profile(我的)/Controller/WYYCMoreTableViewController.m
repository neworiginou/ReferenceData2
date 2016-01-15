//
//  WYYCMoreTableViewController.m
//  无忧云车司机
//
//  Created by luosai19910103@163.com on 15/6/19.
//  Copyright (c) 2015年 wuyouyunche. All rights reserved.
//

#import "WYYCMoreTableViewController.h"

@interface WYYCMoreTableViewController ()

@end

@implementation WYYCMoreTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title = @"更多";
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {

    // Return the number of rows in the section.
    return 3;
}

- (void)viewWillAppear:(BOOL)animated
{
    self.tabBarController.tabBar.hidden=YES;

}

- (void)viewWillDisappear:(BOOL)animated
{
    self.tabBarController.tabBar.hidden=NO;

}
@end
