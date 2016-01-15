//
//  HWHistoryViewController.m
//  Community
//
//  Created by caijingpeng.haowu on 14-12-9.
//  Copyright (c) 2014年 caijingpeng. All rights reserved.
//

#import "HWHistoryViewController.h"
//#import "HWTreatureHistoryCell.h"
//#import "HWTreasureJoinedCell.h"
//#import "HWActivityHistoryModel.h"
#import "HWJoinedRefreshView.h"
#import "HWHistoryRefreshTableView.h"
#import "HWTreasureDetailViewController.h"
#import "HWActivityHistoryModel.h"
#import "HWGoodsDetailViewController.h"

@interface HWHistoryViewController ()<UITableViewDataSource, UITableViewDelegate, HWHistoryRefreshTableViewDelegate, HWJoinedRefreshViewDelegate>
{
    HWHistoryRefreshTableView *historyRefreshView;
    HWJoinedRefreshView *joinedRefreshView;
}


@end

@implementation HWHistoryViewController
@synthesize popToViewController;

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.navigationItem.titleView = [Utility navTitleViewSegmentCtrlWithItems:[NSArray arrayWithObjects:@"历史活动", @"我参与的", nil] target:self selector:@selector(segmentValueChanged:)];
    self.navigationItem.leftBarButtonItem = [Utility navLeftBackBtn:self action:@selector(backMethod)];
    self.view.backgroundColor = [UIColor whiteColor];
    
//    for (int i = 0; i < 2; i++)
//    {
//        UITableView *tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, CONTENT_HEIGHT) style:UITableViewStylePlain];
//        tableView.delegate = self;
//        tableView.dataSource = self;
//        tableView.backgroundColor = [UIColor clearColor];
//        tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
//        [self.view addSubview:tableView];
//        
//        if (i == 0)
//        {
//            joinTV = tableView;
//            joinTV.hidden = YES;
//        }
//        else
//        {
//            historyTV = tableView;
//        }
//    }
    
    historyRefreshView = [[HWHistoryRefreshTableView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, CONTENT_HEIGHT)];
    historyRefreshView.delegate = self;
    [self.view addSubview:historyRefreshView];
    
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [self.navigationController setNavigationBarHidden:NO animated:NO];
}

- (void)segmentValueChanged:(UISegmentedControl *)sender
{
    NSLog(@"%d",sender.selectedSegmentIndex);
    
    if (sender.selectedSegmentIndex == 0)
    {
        
        [MobClick event:@"click_all history logs"];
        
        if (historyRefreshView != nil)
        {
            historyRefreshView.hidden = NO;
            
        }
        
        if (joinedRefreshView != nil)
        {
            joinedRefreshView.hidden = YES;
        }
    }
    else
    {
        [MobClick event:@"click_my history logs"];

        if (joinedRefreshView != nil)
        {
            joinedRefreshView.hidden = NO;
        }
        else
        {
            joinedRefreshView = [[HWJoinedRefreshView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, CONTENT_HEIGHT)];
            joinedRefreshView.delegate = self;
            [self.view addSubview:joinedRefreshView];
        }
        
        if (historyRefreshView != nil)
        {
            historyRefreshView.hidden = YES;
        }
    }
    
}

- (void)didSelectHistoryTableItem:(HWActivityHistoryModel *)historyItem
{
    
}

#pragma mark - 商品历史
- (void)didSelectJoinedTableItem:(HWJoinedActivityModel *)JoinedItem
{
    HWTreasureDetailViewController *detailVC = [[HWTreasureDetailViewController alloc] init];
    detailVC.wuDiXianChannelId = self.wuDiXianChannelId;
    detailVC.joinedItem = JoinedItem;
//    detailVC.productId = JoinedItem.productId;
    detailVC.popToViewController = self.popToViewController;
    [self.navigationController pushViewController:detailVC animated:YES];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



@end
