//
//  HWHaiwaiBaseInfoViewController.m
//  HaoWu_4.0
//
//  Created by caijingpeng.haowu on 14-6-5.
//  Copyright (c) 2014年 caijingpeng. All rights reserved.
//

#import "HWHaiwaiBaseInfoViewController.h"

#define WEBVIEW_TAG 888

@interface HWHaiwaiBaseInfoViewController ()
{
    UITableView *_mainTV;
    NSArray *_firstSecTitle;
    NSArray *_secondSecTitle;
    NSMutableDictionary *_contentSizeDic;
}

@end

@implementation HWHaiwaiBaseInfoViewController
@synthesize baseInfo;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

/**
 *	@brief	返回事件
 *
 *	@return	N/A
 */
- (void)backBtnClick
{
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.navigationItem.titleView = [Utility navTitleView:@"项目详情"];
    self.navigationItem.leftBarButtonItem = [Utility navLeftBackBtn:self action:@selector(backBtnClick)];
    
    _mainTV = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, CONTENT_HEIGHT) style:UITableViewStylePlain];
    _mainTV.dataSource = self;
    _mainTV.delegate = self;
    [self.view addSubview:_mainTV];
    
    _firstSecTitle = [NSArray arrayWithObjects:@"装修：",@"冷暖气设备：",@"窗户类型：",@"地板类型：",@"厨房设备：",@"卧室：",@"其他特征：", nil];
    _secondSecTitle = [NSArray arrayWithObjects:@"园林区域：",@"娱乐设施：",@"配套设施：",@"车道：", nil];
    
    
    // 初始化 webview高度
    _contentSizeDic = [NSMutableDictionary dictionaryWithObjectsAndKeys:
                       @"1",@"0",
                       @"1",@"1",//indexpath section + row
                       @"1",@"2",
                       @"1",@"3",
                       @"1",@"4",
                       @"1",@"5",
                       @"1",@"6",
                       @"1",@"7",
                       @"1",@"8",
                       @"1",@"9",
                       @"1",@"10",
                       @"1",@"11",nil];
    
    
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 40;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    
    UIView *v = [[UIView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, 40)];
    v.backgroundColor = [UIColor whiteColor];
    UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(15, 0, kScreenWidth - 30, 40)];
    label.font = [UIFont fontWithName:FONTNAME size:16.0f];
    label.textColor = THEME_COLOR_ORANGE;
    
    if (section == 0)
    {
        label.text = @"内部空间特色";
    }
    else if (section == 1)
    {
        label.text = @"外围配套";
    }
    else
    {
        label.text = @"周边环境";
    }
    [v addSubview:label];
    
    UIView *line = [[UIView alloc] initWithFrame:CGRectMake(0, 40 - 0.5f, kScreenWidth, 0.5f)];
    line.backgroundColor = THEME_COLOR_LINE;
    [v addSubview:line];
    
    return v;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 3;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (section == 0)
    {
        return 7;
    }
    else if (section == 1)
    {
        return 4;
    }
    return 1;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSString *identifier = [NSString stringWithFormat:@"cell%d",indexPath.section];
    HWHaiwaiBaseInfoCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    if (!cell) {
        cell = [[HWHaiwaiBaseInfoCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier];
    }
    
    int height = 0;
    if (indexPath.section == 0)
    {
        
        cell.leftLabel.text = [_firstSecTitle objectAtIndex:indexPath.row];
        if (indexPath.row == 0)
        {
            NSString *str = [NSString stringWithFormat:@"<FONT style='font-size:13px;font-family:Microsoft YaHei;'>%@</FONT>",[[self.baseInfo objectForKey:@"haiwai"] stringObjectForKey:@"decoration"]];
            if (cell.webView.scrollView.contentSize.height <= 1)
            {
                [cell.webView loadHTMLString:str baseURL:nil];
            }
        }
        else if (indexPath.row == 1)
        {
            NSString *str = [NSString stringWithFormat:@"<FONT style='font-size:13px;font-family:Microsoft YaHei;'>%@</FONT>",[[self.baseInfo objectForKey:@"haiwai"] stringObjectForKey:@"airConditioning"]];
            if (cell.webView.scrollView.contentSize.height <= 1)
            {
                [cell.webView loadHTMLString:str baseURL:nil];
            }
        }
        else if (indexPath.row == 2)
        {
            NSString *str = [NSString stringWithFormat:@"<FONT style='font-size:13px;font-family:Microsoft YaHei;'>%@</FONT>",[[self.baseInfo objectForKey:@"haiwai"] stringObjectForKey:@"windowType"]];
            if (cell.webView.scrollView.contentSize.height <= 1)
            {
                [cell.webView loadHTMLString:str baseURL:nil];
            }
        }
        else if (indexPath.row == 3)
        {
            NSString *str = [NSString stringWithFormat:@"<FONT style='font-size:13px;font-family:Microsoft YaHei;'>%@</FONT>",[[self.baseInfo objectForKey:@"haiwai"] stringObjectForKey:@"flooringType"]];
            if (cell.webView.scrollView.contentSize.height <= 1)
            {
                [cell.webView loadHTMLString:str baseURL:nil];
            }
        }
        else if (indexPath.row == 4)
        {
            NSString *str = [NSString stringWithFormat:@"<FONT style='font-size:13px;font-family:Microsoft YaHei;'>%@</FONT>",[[self.baseInfo objectForKey:@"haiwai"] stringObjectForKey:@"kitchenEquipment"]];
            if (cell.webView.scrollView.contentSize.height <= 1)
            {
                [cell.webView loadHTMLString:str baseURL:nil];
            }
        }
        else if (indexPath.row == 5)
        {
            NSString *str = [NSString stringWithFormat:@"<FONT style='font-size:13px;font-family:Microsoft YaHei;'>%@</FONT>",[[self.baseInfo objectForKey:@"haiwai"] stringObjectForKey:@"bedroom"]];
            if (cell.webView.scrollView.contentSize.height <= 1)
            {
                [cell.webView loadHTMLString:str baseURL:nil];
            }
        }
        else if (indexPath.row == 6)
        {
            NSString *str = [NSString stringWithFormat:@"<FONT style='font-size:13px;font-family:Microsoft YaHei;'>%@</FONT>",[[self.baseInfo objectForKey:@"haiwai"] stringObjectForKey:@"otherFeatures"]];
            if (cell.webView.scrollView.contentSize.height <= 1)
            {
                [cell.webView loadHTMLString:str baseURL:nil];
            }
        }
        height = [[_contentSizeDic objectForKey:[NSString stringWithFormat:@"%d",indexPath.section*7 + indexPath.row]] intValue];
        cell.webView.tag = WEBVIEW_TAG + indexPath.section*7 + indexPath.row ;
        cell.webView.frame = CGRectMake(80, 10, kScreenWidth - 90, height);
    }
    else if (indexPath.section == 1)
    {
        cell.leftLabel.text = [_secondSecTitle objectAtIndex:indexPath.row];
        if (indexPath.row == 0)
        {
            NSString *str = [NSString stringWithFormat:@"<FONT style='font-size:13px;font-family:Microsoft YaHei;'>%@</FONT>",[[self.baseInfo objectForKey:@"haiwai"] stringObjectForKey:@"garden"]];
            if (cell.webView.scrollView.contentSize.height <= 1) {
                [cell.webView loadHTMLString:str baseURL:nil];
            }
        }
        else if (indexPath.row == 1)
        {
            NSString *str = [NSString stringWithFormat:@"<FONT style='font-size:13px;font-family:Microsoft YaHei;'>%@</FONT>",[[self.baseInfo objectForKey:@"haiwai"] stringObjectForKey:@"recreationalFacilities"]];
            if (cell.webView.scrollView.contentSize.height <= 1)
            {
                [cell.webView loadHTMLString:str baseURL:nil];
            }
        }
        else if (indexPath.row == 2)
        {
            NSString *str = [NSString stringWithFormat:@"<FONT style='font-size:13px;font-family:Microsoft YaHei;'>%@</FONT>",[[self.baseInfo objectForKey:@"haiwai"] stringObjectForKey:@"facilities"]];
            if (cell.webView.scrollView.contentSize.height <= 1)
            {
                [cell.webView loadHTMLString:str baseURL:nil];
            }
        }
        else if (indexPath.row == 3)
        {
            NSString *str = [NSString stringWithFormat:@"<FONT style='font-size:13px;font-family:Microsoft YaHei;'>%@</FONT>",[[self.baseInfo objectForKey:@"haiwai"] stringObjectForKey:@"propertyNumbers"]];
            if (cell.webView.scrollView.contentSize.height <= 1)
            {
                [cell.webView loadHTMLString:str baseURL:nil];
            }
        }
        height = [[_contentSizeDic objectForKey:[NSString stringWithFormat:@"%d",indexPath.section*7 + indexPath.row]] intValue];
        cell.webView.tag = WEBVIEW_TAG + indexPath.section*7 + indexPath.row ;
        cell.webView.frame = CGRectMake(80, 10, kScreenWidth - 90, height);
    }
    else if (indexPath.section == 2)
    {
        cell.leftLabel.text = [_secondSecTitle objectAtIndex:indexPath.row];
        NSString *str = [NSString stringWithFormat:@"<FONT style='font-size:13px;font-family:Microsoft YaHei;'>%@</FONT>",[[self.baseInfo objectForKey:@"haiwai"] stringObjectForKey:@"surrounding"]];
        if (cell.webView.scrollView.contentSize.height <= 1)
        {
            [cell.webView loadHTMLString:str baseURL:nil];
        }
        height = [[_contentSizeDic objectForKey:@"11"] intValue];
        cell.webView.tag = WEBVIEW_TAG + 11 ;
        cell.webView.frame = CGRectMake(10, 10, kScreenWidth - 20, height);
    }
    
    cell.delegate = self;
    
    return cell;
}

/**
 *	@brief	webview 加载完成回调方法
 *
 *	@param 	webview
 *
 *	@return	N/A
 */
- (void)didFinishedHaiwaiWebview:(UIWebView *)webview
{
//    //NSLog(@"%f",webview.scrollView.contentSize.height);
    NSString *key = [NSString stringWithFormat:@"%d",webview.tag % WEBVIEW_TAG];
    NSString *obj = [NSString stringWithFormat:@"%f",webview.scrollView.contentSize.height];
    
    [_contentSizeDic setObject:obj forKey:key];
    [_mainTV reloadData];
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section == 0 || indexPath.section == 1)
    {
        int height = [[_contentSizeDic objectForKey:[NSString stringWithFormat:@"%d",indexPath.section*7+indexPath.row]] intValue];
        return MAX((height + 20), 50);
    }
    else
    {
        int height = [[_contentSizeDic objectForKey:@"11"] intValue];
        return MAX((height + 20), 50) ;
    }
    
    return 0;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
