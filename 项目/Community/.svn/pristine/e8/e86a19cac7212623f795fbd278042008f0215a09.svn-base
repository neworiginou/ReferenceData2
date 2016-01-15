//
//  HWAboutKoalaCommunityViewController.m
//  Community
//
//  Created by D on 14/12/10.
//  Copyright (c) 2014年 caijingpeng. All rights reserved.
//

#import "HWAboutKoalaCommunityViewController.h"
#import "HWAbtKalaCommunityFunctionIntroductionViewController.h"
#import "HWAbtKalaCommunityProductIntroductionViewController.h"

@interface HWAboutKoalaCommunityViewController ()<UITableViewDataSource, UITableViewDelegate>

@end

@implementation HWAboutKoalaCommunityViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.navigationItem.titleView = [Utility navTitleView:@"关于考拉社区"];
    self.navigationItem.leftBarButtonItem = [Utility navLeftBackBtn:self action:@selector(backMethod)];
    
    [self createDataSource];
    [self createMainView];
}

//创建展示页面的主视图
-(void)createMainView
{
    self.mainTabView = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, kScreenWidth, self.view.frame.size.height)];
    self.mainTabView.delegate = self;
    self.mainTabView.dataSource = self;
    self.mainTabView.separatorStyle = UITableViewCellSeparatorStyleNone;
    self.mainTabView.tableHeaderView = [self createHeadView];
    self.mainTabView.backgroundColor = [UIColor clearColor];
    [self.view addSubview:self.mainTabView];
}
//创建头视图
-(UIView *)createHeadView
{
    UIView *view = [[UIView alloc]initWithFrame:CGRectMake(0, 0, kScreenWidth, 215)];
    view.backgroundColor= UIColorFromRGB(0xf2f2f2);
    UIImageView * imgView = [[UIImageView alloc]initWithFrame:CGRectMake(90, 15, 130, 163)];
    imgView.center = CGPointMake(kScreenWidth/2.0f, imgView.center.y);
    imgView.image = [UIImage imageNamed:@"kaola_mobi"];
    [view addSubview:imgView];
    
    UILabel * lab = [[UILabel alloc] initWithFrame:CGRectMake(120, 185, 75, 22)];
    lab.center = CGPointMake(kScreenWidth/2.0f, lab.center.y);
    lab.text = [NSString stringWithFormat:@"V%@",[Utility getLocalAppVersion]];
    lab.textColor = THEME_COLOR_TEXT;
    lab.backgroundColor = THEME_COLOR_LINE;
    lab.font = [UIFont fontWithName:FONTNAME size:THEME_FONT_BIG];
    lab.textAlignment = NSTextAlignmentCenter;
    lab.layer.masksToBounds = YES;
    lab.layer.cornerRadius = 11;
    [view addSubview:lab];
    
    return view;
}


//创建数据源
-(void)createDataSource
{
    self.dataArr = @[@"去评分",@"产品简介",@"功能介绍"];
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 3;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString * cellId = @"cellId";
    UITableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:cellId];
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellId];
    }
    UIImageView *lineView = [[UIImageView alloc]initWithFrame:CGRectMake(0, 45.5, kScreenWidth, 0.5)];
    lineView.backgroundColor = THEME_COLOR_LINE;
    [cell addSubview:lineView];
    
    if (indexPath.row == 0)
    {
        UIImageView *lineView = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0.0, kScreenWidth, 0.5)];
        lineView.backgroundColor = THEME_COLOR_LINE;
        [cell addSubview:lineView];
    }
    cell.textLabel.text = self.dataArr[indexPath.row];
    cell.textLabel.font = [UIFont fontWithName:FONTNAME size:15.0f];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 45.5;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    switch (indexPath.row) {
        case 0:
        {
            [MobClick event:@"click_grading"];
            [[UIApplication sharedApplication] openURL:[NSURL URLWithString:ITUNSE_DOWNLOAD_URL]];
        }
            break;
        case 1:
        {
            [MobClick event:@"click_productIntroduction"];
            [self.navigationController pushViewController:[HWAbtKalaCommunityProductIntroductionViewController new] animated:YES];
        }
            break;
        case 2:
        {
            [MobClick event:@"click_FunctionIntroduction"];
            [self.navigationController pushViewController:[HWAbtKalaCommunityFunctionIntroductionViewController new] animated:YES];
        }
            break;
        default:
            break;
    }
}

- (void)didReceiveMemoryWarning {
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
