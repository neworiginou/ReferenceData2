//
//  WYYCCustomerDetailViewController.m
//  无忧云车司机
//
//  Created by luosai19910103@163.com on 15/6/24.
//  Copyright (c) 2015年 wuyouyunche. All rights reserved.
//

#import "WYYCCustomerDetailViewController.h"
#import "WYYCComment.h"
#import "WYYCCustomerDetailCell.h"
@interface WYYCCustomerDetailViewController ()<UITableViewDelegate,UITableViewDataSource>
@property (strong,nonatomic) NSMutableArray *commentsArray;
@property (weak, nonatomic) IBOutlet UITableView *tableView;

@end
static NSString * reuserable=@"cell";
@implementation WYYCCustomerDetailViewController


- (void)viewDidLoad {
    [super viewDidLoad];
     self.title=@"客户详情";
    for (int i=0; i<5; i++) {
        WYYCComment *comment=[WYYCComment new];
        comment.commentDate=@"2015-11-12 12:22";
        comment.commentScore=@4;
        comment.commentContent=@"非常好，赞一个!";
        comment.orderNum=@"1212121212";
        [self.commentsArray addObject:comment];
    }
    [self.tableView registerNib:[UINib nibWithNibName:@"WYYCCustomerDetailCell" bundle:nil] forCellReuseIdentifier:reuserable];
    self.tableView.tableFooterView=[[UIView alloc]initWithFrame:CGRectZero];
    
}
- (NSMutableArray *)commentsArray
{
    if (!_commentsArray) {
        _commentsArray=[[NSMutableArray alloc]initWithCapacity:0];
    }
    return _commentsArray;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.commentsArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    WYYCCustomerDetailCell *cell=[tableView dequeueReusableCellWithIdentifier:reuserable forIndexPath:indexPath];
    cell.comment=self.commentsArray[indexPath.row];
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 75;
}

@end
