//
//  WYYCMessageCenterTableViewController.m
//  无忧云车司机
//
//  Created by luosai19910103@163.com on 15/6/23.
//  Copyright (c) 2015年 wuyouyunche. All rights reserved.
//

#import "WYYCMessageCenterTableViewController.h"
#import "WYYCMessage.h"
#import "WYYCMessageCenterCell.h"
@interface WYYCMessageCenterTableViewController ()
@property (strong ,nonatomic)NSMutableArray *messageArray;
@end

static NSString * reuserable=@"message";
@implementation WYYCMessageCenterTableViewController

- (NSMutableArray *)messageArray
{
    if (!_messageArray) {
        self.messageArray=[[NSMutableArray alloc]initWithCapacity:0];
    }
    return _messageArray;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    
    for (NSInteger i=0; i<5; i++) {
        WYYCMessage *message = [[WYYCMessage alloc]init];
        message.title = @"您有一代驾订单";
        message.startPlace = @"东方路818号";
        message.destination = @"张杨路1221号";
        message.startTime = @"2015-11-22 11:22（星期五）";
        message.passengerName = @"张先生";
        message.orderStatusCode = @"已经付款";
        message.startOrEndWorkingTime = @"2015-11-22 10:22";
        message.workingStatus = @"上线";
        [self.messageArray addObject:message];
    }
    for (NSInteger i=5; i<10; i++) {
        WYYCMessage *message = [[WYYCMessage alloc]init];
        message.startOrEndWorkingTime = @"2015-11-22 10:22";
        message.workingStatus = @"上线";
        [self.messageArray addObject:message];
    }
    
    [self.tableView registerNib:[UINib nibWithNibName:@"WYYCMessageCenterCell" bundle:nil] forCellReuseIdentifier:reuserable];
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
    
    return self.messageArray.count;
}


- (WYYCMessageCenterCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    WYYCMessageCenterCell *cell = [tableView dequeueReusableCellWithIdentifier:reuserable forIndexPath:indexPath];
    
    // Configure the cell...
    cell.message=self.messageArray[indexPath.row];
    
    return cell;
}


- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    WYYCMessage *message=self.messageArray[indexPath.row];
    if (message.title) {
        return 120;
    }
    return 70;
}

@end
