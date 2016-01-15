//
//  WYYCGrabOrderTableViewController.m
//  无忧云车司机
//
//  Created by luosai19910103@163.com on 15/6/23.
//  Copyright (c) 2015年 wuyouyunche. All rights reserved.
//

#import "WYYCGrabOrderTableViewController.h"
#import "WYYCGrabOrderCell.h"
#import "WYYCOrder.h"
#import "WYYCCustomerDetailViewController.h"
@interface WYYCGrabOrderTableViewController ()<WYYCGrabOrderCellDelegage>
@property (strong,nonatomic) NSMutableArray *orderArray;
@end

static NSString *reuserable=@"cell";
@implementation WYYCGrabOrderTableViewController

-(NSMutableArray *)orderArray
{
    if (!_orderArray) {
        self.orderArray=[[NSMutableArray alloc]initWithCapacity:0];
    }
    return _orderArray;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    
    for (NSInteger i= 0; i<10; i++) {
        WYYCOrder *order = [[WYYCOrder alloc]init];
        order.startPlace = @"浦东新区东方路818号";
        order.startTime = @"2015-08-11 22:11";
        order.customerName = @"张先生";
        order.customerId=[NSString stringWithFormat:@"%d",100+arc4random()/1000];
        order.estimatedCost = @(100);
        [self.orderArray addObject:order];
    }
    [self.tableView registerNib:[UINib nibWithNibName:@"WYYCGrabOrderCell" bundle:nil] forCellReuseIdentifier:reuserable];
    self.tableView.tableFooterView = [[UIView alloc]initWithFrame:CGRectZero];
    

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

    return self.orderArray.count;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    WYYCGrabOrderCell *cell = [tableView dequeueReusableCellWithIdentifier:reuserable forIndexPath:indexPath];
    
    cell.order=self.orderArray[indexPath.row];
    cell.delegate=self;
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath

{
    return 100;
}
- (void)clickToCustomerDetail:(NSString *)customerId
{
    NSLog(@"%@",customerId);
#warning TODO -- 通过客户ID请求客户详情。
    WYYCCustomerDetailViewController *customerDetailView=[[WYYCCustomerDetailViewController alloc]init];
    [self.navigationController pushViewController:customerDetailView animated:YES];
    
}

@end
