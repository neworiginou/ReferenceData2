//
//  HWDetailBaseInfoViewController.m
//  HaoWu_4.0
//
//  Created by caijingpeng.haowu on 14-5-22.
//  Copyright (c) 2014年 caijingpeng. All rights reserved.
//

#import "HWDetailBaseInfoViewController.h"

#import "HWDetailDoubleCell.h"


#define BASEINFO_SCROLL_TAG 6001

#define INFO_TAG        6101
#define INTRO_TAG       6102
#define TRAFIC_TAG      6103
#define PEIZHI_TAG      6104
#define JIANCAI_TAG     6105
#define LOUCENG_TAG     6106
#define CHEWEI_TAG      6107

#define WEBVIEW_TAG     6666

@interface HWDetailBaseInfoViewController ()
{
    UITableView *_mainTV;
    NSMutableDictionary *_contentSizeDic;
}

@end

@implementation HWDetailBaseInfoViewController
@synthesize baseInfo;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        self.view.backgroundColor = [UIColor whiteColor];
        self.navigationItem.titleView = [Utility navTitleView:@"楼盘信息"];
        self.navigationItem.leftBarButtonItem = [Utility navLeftBackBtn:self action:@selector(backBtnClick)];
    }
    return self;
}

/**
 *	@brief	将楼盘信息参数传入本页面
 *
 *	@param 	_baseInfo 	楼盘信息
 *
 *	@return	N/A
 */
- (void)setBaseInfo:(NSDictionary *)_baseInfo
{
    if([_baseInfo isKindOfClass:[NSNull class]]||_baseInfo==nil)
        return;
    baseInfo = _baseInfo;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    _mainTV = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, CONTENT_HEIGHT) style:UITableViewStylePlain];
    _mainTV.dataSource = self;
    _mainTV.delegate = self;
    _mainTV.separatorStyle = UITableViewCellSeparatorStyleNone;
    [self.view addSubview:_mainTV];
    
    _contentSizeDic = [NSMutableDictionary dictionaryWithObjectsAndKeys:
                       @"1",@"1",
                       @"1",@"2",
                       @"1",@"3",
                       @"1",@"4",
                       @"1",@"5",
                       @"1",@"6",
                       @"1",@"7",nil];
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 8;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (section == 0)
    {
        return 8;
    }
    return 1;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section == 0) {
        HWDetailDoubleCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell"];
        if (!cell)
        {
            cell = [[HWDetailDoubleCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"cell"];
        }
        
        if (indexPath.row == 0)
        {
            cell.leftLabel.text = @"物业类型: ";
            cell.rightLabel.text = [self.baseInfo stringObjectForKey:@"houseProperty"];
        }
        else if (indexPath.row == 1)
        {
            cell.leftLabel.text = @"项目位置: ";
            cell.rightLabel.text = [NSString stringWithFormat:@"%@",[self.baseInfo stringObjectForKey:@"houseAddress"]];
        }
        else if (indexPath.row == 2)
        {
            cell.leftLabel.text = @"面积段: ";
            cell.rightLabel.text = [NSString stringWithFormat:@"%@",[self.baseInfo stringObjectForKey:@"infoArea"]];
        }
        else if (indexPath.row == 3)
        {
            cell.leftLabel.text = @"开盘时间: ";
            cell.rightLabel.text = [NSString stringWithFormat:@"%@",[self.baseInfo stringObjectForKey:@"infoOpentime"]];
        }
        else if (indexPath.row == 4)
        {
            cell.leftLabel.text = @"入住时间: ";
            cell.rightLabel.text = [NSString stringWithFormat:@"%@",[self.baseInfo stringObjectForKey:@"infoChecktime"]];
        }
        else if (indexPath.row == 5)
        {
            cell.leftLabel.text = @"物业费: ";
            cell.rightLabel.text = [NSString stringWithFormat:@"%@",[self.baseInfo stringObjectForKey:@"infoFees"]];
        }
        else if (indexPath.row == 6)
        {
            cell.leftLabel.text = @"销售地址: ";
            cell.rightLabel.text = [NSString stringWithFormat:@"%@",[self.baseInfo stringObjectForKey:@"salesAddress"]];
        }
        else if (indexPath.row == 7)
        {
            cell.leftLabel.text = @"开发商: ";
            cell.rightLabel.text = [NSString stringWithFormat:@"%@",[self.baseInfo stringObjectForKey:@"houseDevelopers"]];
        }
        
        return cell;
    }
    else
    {
        NSString *identifier = [NSString stringWithFormat:@"cell%d",indexPath.section];
        HWDetailBaseInfoCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
        if (!cell)
        {
            cell = [[HWDetailBaseInfoCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier];
        }
        
        NSString *str;
        
        if (indexPath.section == 1)
        {  //项目介绍
            str = [NSString stringWithFormat:@"<FONT style='font-size:13px;font-family:Microsoft YaHei; color:#999999'>%@</FONT>",[self.baseInfo objectForKey:@"houseDesc"]];
            if (cell.webView.scrollView.contentSize.height <= 1)
            {
                [cell.webView loadHTMLString:str baseURL:nil];
            }
        }
        else if (indexPath.section == 2)
        { // 项目配套
            str = [NSString stringWithFormat:@"<FONT style='font-size:13px;font-family:Microsoft YaHei;color:#999999'>%@</FONT>",[self.baseInfo objectForKey:@"housePt"]];
            if (cell.webView.scrollView.contentSize.height <= 1)
            {
                [cell.webView loadHTMLString:str baseURL:nil];
                
            }
        }
        else if (indexPath.section == 3)
        { // 交通状况
            str = [NSString stringWithFormat:@"<FONT style='font-size:13px;font-family:Microsoft YaHei;color:#999999'>%@</FONT>",[self.baseInfo objectForKey:@"infoTraffic"]];
            if (cell.webView.scrollView.contentSize.height <= 1)
            {
                [cell.webView loadHTMLString:str baseURL:nil];
            }
        }
        else if (indexPath.section == 4)
        { // 建材装修
            str = [NSString stringWithFormat:@"<FONT style='font-size:13px;font-family:Microsoft YaHei;color:#999999'>%@</FONT>",[self.baseInfo objectForKey:@"infoMaterials"]];
            if (cell.webView.scrollView.contentSize.height <= 1)
            {
                [cell.webView loadHTMLString:str baseURL:nil];
            }
        }
        else if (indexPath.section == 5)
        { // 楼层状况
            str = [NSString stringWithFormat:@"<FONT style='font-size:13px;font-family:Microsoft YaHei;color:#999999'>%@</FONT>",[self.baseInfo objectForKey:@"infoBloor"]];
            if (cell.webView.scrollView.contentSize.height <= 1)
            {
                [cell.webView loadHTMLString:str baseURL:nil];
            }
        }
        else if (indexPath.section == 6)
        { // 车位信息
            str = [NSString stringWithFormat:@"<FONT style='font-size:13px;font-family:Microsoft YaHei;color:#999999'>%@</FONT>",[self.baseInfo objectForKey:@"infoCar"]];
            if (cell.webView.scrollView.contentSize.height <= 1)
            {
                [cell.webView loadHTMLString:str baseURL:nil];
            }
        }
        else if (indexPath.section == 7)
        { // 相关信息
            str = [NSString stringWithFormat:@"<FONT style='font-size:13px;font-family:Microsoft YaHei;color:#999999'>%@</FONT>",[self.baseInfo objectForKey:@"infoOther"]];
            if (cell.webView.scrollView.contentSize.height <= 1)
            {
                [cell.webView loadHTMLString:str baseURL:nil];
            }
            
        }
        
        // _contentSizeDic 中保存webview加载完成后的高度
        int height = [[_contentSizeDic objectForKey:[NSString stringWithFormat:@"%d",indexPath.section]] intValue];
        cell.webView.frame = CGRectMake(10, 10, 300, height);
        cell.webView.tag = WEBVIEW_TAG + indexPath.section;
        cell.delegate = self;
        
        return cell;
    }
    
    return nil;
    
}

/**
 *	@brief	webview加载完成后代理方法，保存加载后webview的内容高度，刷新tableview
 *
 *	@param 	webview
 *
 *	@return	N/A
 */
- (void)didFinishedWebview:(UIWebView *)webview
{
//    //NSLog(@"%f",webview.scrollView.contentSize.height);
    NSString *key = [NSString stringWithFormat:@"%d",webview.tag % WEBVIEW_TAG];
    NSString *obj = [NSString stringWithFormat:@"%f",webview.scrollView.contentSize.height];
    
    [_contentSizeDic setObject:obj forKey:key];
    [_mainTV reloadData];
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section == 0)
    {
        return 45;
    }
    else
    {
        // _contentSizeDic 中保存webview加载完成后的高度
        int height = [[_contentSizeDic objectForKey:[NSString stringWithFormat:@"%d",indexPath.section]] intValue];
        return MAX((height + 20), 50) ;
    }
    
    return 0;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    NSArray *arr = @[@"物业特色",@"项目介绍",@"项目配套",@"交通状况",@"建材装修",@"楼层状况",@"车位信息",@"相关信息"];
    UIView *headerView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, 30)];
    headerView.backgroundColor = UIColorFromRGB(0xf5f5f5);
    
    if (section == 0)
    {
        UIView *topLine = [[UIView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, 0.5f)];
        topLine.backgroundColor = THEME_COLOR_LINE;
        [headerView addSubview:topLine];
    }
 
    UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(15, 1, 250, 28)];
    label.backgroundColor = [UIColor clearColor ];
    label.text = arr[section];
    label.font = [UIFont fontWithName:FONTNAME size:15.0f];
    [headerView addSubview:label];
    
    UIView *downLine = [[UIView alloc] initWithFrame:CGRectMake(0, 30 - 0.5f, kScreenWidth, 0.5f)];
    downLine.backgroundColor = THEME_COLOR_LINE;
    [headerView addSubview:downLine];
    
    return headerView;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 30;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/**
 *	@brief	返回按钮点击事件
 *
 *	@return	N/A
 */
- (void)backBtnClick
{
    [self.navigationController popViewControllerAnimated:YES];
}



@end
