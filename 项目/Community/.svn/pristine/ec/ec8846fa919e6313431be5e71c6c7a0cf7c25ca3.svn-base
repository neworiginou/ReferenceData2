//
//  HWMessageCenterViewController.m
//  Community
//
//  Created by niedi on 15/6/4.
//  Copyright (c) 2015年 caijingpeng. All rights reserved.
//

#import "HWMessageCenterViewController.h"
#import "HWPersonDynamicCell.h"
#import "HWMyWuYeMViewController.h"
#import "HWPersonDynamicViewController.h"

@interface HWMessageCenterViewController ()
{
    NSArray *_myDynamicNameArr;
    NSArray *_myDynamicIconArr;
    UITableView *dymnamicTableView;
    NSInteger _neighbourCount;
    NSInteger _wuYeCount;
}
@end

@implementation HWMessageCenterViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.navigationItem.titleView = [Utility navTitleView:@"我的消息"];
    
    _myDynamicIconArr = [NSArray arrayWithObjects:@"messageCenter2", @"messageCenter1", nil];
    _myDynamicNameArr = [NSArray arrayWithObjects:@"我的物业", @"我的邻里", nil];
    [self createTableView];
    [self loadDynamicIndex];
}

-(void)viewWillAppear:(BOOL)animated
{
    if (dymnamicTableView != nil)
    {
        [self loadDynamicIndex];
    }
}

-(void)viewDidDisappear:(BOOL)animated
{
    //    [self refreshDynamicIndex];
}

-(void)refreshDynamicIndex
{
    if (_delegate && [_delegate respondsToSelector:@selector(didRefreshDynamicIndex)])
    {
        [_delegate didRefreshDynamicIndex];
    }
}

/**
 *	@brief	加载个人动态首页，获取新增信息数量
 *
 *	@return	N/A
 */
- (void)loadDynamicIndex
{
    NSMutableDictionary *parameters = [[NSMutableDictionary alloc]init];
    [parameters setPObject:[HWUserLogin currentUserLogin].key forKey:@"key"];
    
    HWHTTPRequestOperationManager *manager = [HWHTTPRequestOperationManager manager];
    [manager POST:kDynamicIndex parameters:parameters queue:nil success:^(id responese)
     {
         NSLog(@"新增信息数量%@",responese);
         NSDictionary *dict = [responese dictionaryObjectForKey:@"data"];
         
         _neighbourCount = [[dict stringObjectForKey:@"atCount"] integerValue] + [[dict stringObjectForKey:@"replyCount"] integerValue] + [[dict stringObjectForKey:@"praiseTopicCount"] integerValue] + [[dict stringObjectForKey:@"topicCount"] integerValue];
         _wuYeCount = [[dict stringObjectForKey:@"wyNoticeCount"] integerValue];
         
         [dymnamicTableView reloadData];
     } failure:^(NSString *code, NSString *error)
     {
         
     }];
}

-(void)createTableView
{
    dymnamicTableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, kScreenWidth, CONTENT_HEIGHT)];
    dymnamicTableView.delegate = self;
    dymnamicTableView.dataSource = self;
    dymnamicTableView.backgroundColor = BACKGROUND_COLOR;
    [dymnamicTableView setSeparatorStyle:UITableViewCellSeparatorStyleNone];
    [self.view addSubview:dymnamicTableView];
}

#pragma - mark tableview delegate method
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return _myDynamicNameArr.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSString* cellid = @"cellid";
    HWPersonDynamicCell *dynamicCell = [tableView dequeueReusableCellWithIdentifier:cellid];
    if (!dynamicCell)
    {
        dynamicCell = [[HWPersonDynamicCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellid];
    }
    dynamicCell.titleLab.text = [_myDynamicNameArr pObjectAtIndex:indexPath.row];
    [dynamicCell.personDynamicImgV setImage:[UIImage imageNamed:[_myDynamicIconArr pObjectAtIndex:indexPath.row]]];
    
    if (indexPath.row == 0)
    {
        if (_wuYeCount > 0)
        {
            [dynamicCell.newsCountBtn setTitle:[NSString stringWithFormat:@"%ld", _wuYeCount] forState:UIControlStateNormal];
            dynamicCell.newsCountBtn.hidden = NO;
        }
        else
        {
            dynamicCell.newsCountBtn.hidden = YES;
        }
    }
    else
    {
        if (_neighbourCount > 0)
        {
            [dynamicCell.newsCountBtn setTitle:[NSString stringWithFormat:@"%ld", _neighbourCount] forState:UIControlStateNormal];
            dynamicCell.newsCountBtn.hidden = NO;
        }
        else
        {
            dynamicCell.newsCountBtn.hidden = YES;
        }
    }
    
    
    if (indexPath.row == 0)
    {
        UIView *headLine = [[UIView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, 0.5f)];
        headLine.backgroundColor = THEME_COLOR_LINE;
        [dynamicCell addSubview:headLine];
    }
    dynamicCell.selectionStyle = UITableViewCellSelectionStyleNone;
    return dynamicCell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 65;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSInteger row = indexPath.row;
    if (row == 1)
    {
        HWPersonDynamicViewController *pVC = [[HWPersonDynamicViewController alloc] init];
        [self.navigationController pushViewController:pVC animated:YES];
    }
    else
    {
        HWMyWuYeMViewController *wyVC = [[HWMyWuYeMViewController alloc] init];
        wyVC.NavTitle = [_myDynamicNameArr pObjectAtIndex:indexPath.row];
        wyVC.type = indexPath.row;
        [self.navigationController pushViewController:wyVC animated:YES];
    }
}

- (void)didReceiveMemoryWarning
{
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
