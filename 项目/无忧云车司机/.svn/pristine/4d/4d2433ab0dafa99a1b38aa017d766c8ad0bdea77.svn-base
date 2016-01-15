//
//  WYYCCommentTableViewController.m
//  无忧云车司机
//
//  Created by luosai19910103@163.com on 15/6/19.
//  Copyright (c) 2015年 wuyouyunche. All rights reserved.
//

#import "WYYCCommentTableViewController.h"
#import "WYYCComment.h"
#import "WYYCCommentCell.h"
@interface WYYCCommentTableViewController ()
@property (strong,nonatomic) NSMutableArray *commentArray;
@end
static NSString *reuserable=@"cell";
@implementation WYYCCommentTableViewController

- (NSMutableArray *)commentArray
{
    if (!_commentArray) {
        self.commentArray=[[NSMutableArray alloc]init];
    }
    return _commentArray;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title =@"评价记录";
    for (int i=0; i<=10; i++) {
        WYYCComment *comment=[[WYYCComment alloc]init];
        comment.commentDate=@"2015-11-12 11:22";
        comment.commentScore=@(3.5);
        comment.commentContent=@"非常满意！赞一个！";
        comment.orderNum=@"13121211212111" ;
        [self.commentArray addObject:comment];
    }
    
    [self.tableView registerNib:[UINib nibWithNibName:@"WYYCCommentCell" bundle:nil] forCellReuseIdentifier:reuserable];
    self.tableView.tableFooterView =[[UIView alloc]initWithFrame:CGRectZero];
    
}


#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    NSLog(@"%ld",self.commentArray.count);
    return self.commentArray.count;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    WYYCCommentCell *cell = [tableView dequeueReusableCellWithIdentifier:reuserable forIndexPath:indexPath];
    
    // Configure the cell...
    cell.comment=self.commentArray[indexPath.row];
    return cell;
}


- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 70;
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
