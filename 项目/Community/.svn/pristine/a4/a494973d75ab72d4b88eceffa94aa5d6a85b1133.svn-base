//
//  HWPersonDymnamicViewController.m
//  Community
//
//  Created by hw500027 on 15/1/9.
//  Copyright (c) 2015年 caijingpeng. All rights reserved.
//
//  功能描述：显示我的动态首页
//  修改记录：
//	姓名     日期         修改内容
//  陆晓波   2015-01-14   代码优化
//  陆晓波   2015-01-15   增加请求个人动态首页接口方法
//  陆晓波   2015-01-16   调试个人动态首页接口
//  陆晓波   2015-01-22   新增未读信息 数组修改
//  陆晓波   2015-01-23   埋点；添加代理，点击leftBarButtonItem让个人首页刷新数据
//  陆晓波   2015-01-26   代理修改

#import "HWPersonDynamicViewController.h"
#import "HWPersonDynamicCell.h"
#import "HWPersonDynamicDetailVC.h"

@interface HWPersonDynamicViewController ()
{
    NSArray *_myDynamicNameArr;
    NSArray *_myDynamicIconArr;
    UITableView *dymnamicTableView;
    NSMutableArray *_countArr;
}
@end

@implementation HWPersonDynamicViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.navigationItem.titleView = [Utility navTitleView:@"我的动态"];
    self.navigationItem.leftBarButtonItem = [Utility navLeftBackBtn:self action:@selector(backMethod)];

    _myDynamicIconArr = [NSArray arrayWithObjects:@"my_activity01",@"my_activity02",@"my_activity03",@"my_activity04", nil];
    _myDynamicNameArr = [NSArray arrayWithObjects:@"@我的",@"评论",@"赞",@"主题", nil];
    [self createTableView];
}

-(void)viewWillAppear:(BOOL)animated
{
    [self loadDynamicIndex];
}

-(void)viewDidDisappear:(BOOL)animated
{
    [self refreshDynamicIndex];
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
    _countArr = [[NSMutableArray alloc]init];
    NSMutableDictionary *parameters = [[NSMutableDictionary alloc]init];
    [parameters setPObject:[HWUserLogin currentUserLogin].key forKey:@"key"];
    
    HWHTTPRequestOperationManager *manager = [HWHTTPRequestOperationManager manager];
    [manager POST:kDynamicIndex parameters:parameters queue:nil success:^(id responese)
    {
        NSLog(@"新增信息数量%@",responese);
        NSMutableDictionary *dict = [[NSMutableDictionary alloc]initWithDictionary:[responese dictionaryObjectForKey:@"data"]];
        
        [_countArr addObject:[dict stringObjectForKey:@"atCount"]];         //@我的
        [_countArr addObject:[dict stringObjectForKey:@"replyCount"]];      //评论
        [_countArr addObject:[dict stringObjectForKey:@"praiseTopicCount"]];//赞
        [_countArr addObject:[dict stringObjectForKey:@"topicCount"]];      //主题
        
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

    if ([[_countArr pObjectAtIndex:indexPath.row]integerValue] > 0)
    {
        [dynamicCell.newsCountBtn setTitle:[_countArr pObjectAtIndex:indexPath.row] forState:UIControlStateNormal];
        dynamicCell.newsCountBtn.hidden = NO;
    }
    else
    {
        dynamicCell.newsCountBtn.hidden = YES;
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
    /* 埋点
        个人动态列表>点击”@我的“ click_atme_messege
        个人动态列表>点击”评论“  click_notify_comment
        个人动态列表>点击”赞“    click_notify_like
        个人动态列表>点击”主题“  click_notify_feed
     */
    NSArray *mobClickArray = @[@"click_atme_messege",@"click_notify_comment",@"click_notify_like",@"click_notify_feed"];
    [MobClick event:[mobClickArray pObjectAtIndex:indexPath.row]];//maidian_1.2.1
    
    HWPersonDynamicDetailVC *dynamicDetail = [[HWPersonDynamicDetailVC alloc]init];
    dynamicDetail.navTitleName = [_myDynamicNameArr pObjectAtIndex:indexPath.row];
    dynamicDetail.dataType = indexPath.row;
    [self.navigationController pushViewController:dynamicDetail animated:YES];
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
