//
//  WalletDetailViewController.m
//  HaoWu_4.0
//
//  Created by zhangxun on 14-5-24.
//  Copyright (c) 2014年 caijingpeng. All rights reserved.
//

#import "WalletDetailViewController.h"
#import "WalletView.h"
#import "HWDoubleLabelCell.h"
#import "Partner_Swift-Swift.h"
#import "Define-OC.h"

@interface WalletDetailViewController ()
{
    UITableView *_mainTV;
    NSDictionary *_dataDic;
}

@end

@implementation WalletDetailViewController
@synthesize popToViewController;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

/**
 *	@brief	初始化方法
 *
 *	@param 	theID 	详情流水号id
 *
 *	@return	N/A
 */
- (id)initWithDetailID:(NSString *)theID
{
    self = [super init];
    if (self)
    {
        _recordId = theID;
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];    
    self.navigationItem.titleView =[Utility navTitleView:@"详情"];
//    self.navigationItem.leftBarButtonItem = [Utility navLeftBackBtn:self action:@selector(backMethod)];
    self.navigationItem.leftBarButtonItem = [Utility navLeftBackBtn:self _selector:@selector(doConfirm:)];
    
    _mainTV = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, CONTENT_HEIGHT) style:UITableViewStylePlain];
    _mainTV.dataSource = self;
    _mainTV.delegate = self;
    _mainTV.separatorStyle = UITableViewCellSeparatorStyleSingleLine;
    _mainTV.backgroundColor = [UIColor clearColor];
    [self.view addSubview:_mainTV];
    
    UIView *headerView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, 10)];
    headerView.backgroundColor = [UIColor clearColor];
    UIView *line = [[UIView alloc] initWithFrame:CGRectMake(0, 9.5, kScreenWidth, 0.5f)];
    line.backgroundColor = CD_LineColor;
    [headerView addSubview:line];
    
    _mainTV.tableHeaderView = headerView;
    
    [self queryData];
    
}

/**
 *	@brief	加载详情信息
 *
 *	@return	N/A
 */
- (void)queryData
{
    
//    入参：recordId="【记录的id】" key="UUID"(手机端传入)
//    出参：
//    { type:"类型",// ID:"流水号", status:"状态" projectName:"项目名称",money:"金额",customer"客户",dealopt:"交易方"dealtime:"交易时间"}
    
//    [Utility showMBProgress:self.view message:LOADING_TEXT];
    HWHttpRequestOperationManager *manager = [HWHttpRequestOperationManager baseManager];
    NSMutableDictionary *param = [NSMutableDictionary dictionary];
    [param setPObject:[HWUserLogin currentUserLogin].key forKey:@"key"];
//    [param setPObject:@"1" forKey:@"key"];
    [param setPObject:_recordId forKey:@"recordId"];
//    [param setPObject:@"1" forKey:@"channel"];

    [manager postHttpRequest:kRecordDetail parameters:param queue:nil success:^(NSDictionary *responseObject) {
        [Utility hideMBProgress:self.view];
        _dataDic = [responseObject dictionaryObjectForKey:@"data"];
        [_mainTV reloadData];
    } failure:^(NSString *code, NSString *error) {
        [Utility hideMBProgress:self.view];
    }];
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 3;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (section == 2)
    {
        return 2;
    }
    return 3;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *cellIdentifier = @"cell";
    HWDoubleLabelCell * cell = (HWDoubleLabelCell *)[tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    if (!cell)
    {
        cell = [[HWDoubleLabelCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdentifier];
    }
    cell.backgroundColor = [UIColor whiteColor];
    
    if (indexPath.section == 0)
    {
        if (indexPath.row == 0)
        {
            cell.leftLabel.text = @"类型：";
            if (_dataDic == nil)
            {
                cell.rightLabel.text = @"";
            }
            else
            {
                cell.rightLabel.text = [NSString stringWithFormat:@"%@",[_dataDic stringObjectForKey:@"type"]];
            }
#warning color
//            cell.rightLabel.textColor = THEME_COLOR_TEXT;
        }
        else if (indexPath.row == 1)
        {
            cell.leftLabel.text = @"流水号：";
            if (_dataDic == nil)
            {
                cell.rightLabel.text = @"";
            }
            else
            {
                cell.rightLabel.text = [NSString stringWithFormat:@"%@",[_dataDic stringObjectForKey:@"id"]];
            }
            
        }
        else if (indexPath.row == 2)
        {
            cell.leftLabel.text = @"状态：";
            if (_dataDic == nil)
            {
                cell.rightLabel.text = @"";
            }
            else
            {
                cell.rightLabel.text = [NSString stringWithFormat:@"%@",[_dataDic stringObjectForKey:@"status"]];
            }
#warning color
//            cell.rightLabel.textColor = THEME_COLOR_TEXT;
        }
    }
    else if (indexPath.section == 1)
    {
        if (indexPath.row == 0)
        {
            cell.leftLabel.text = @"项目名称：";
            if (_dataDic == nil)
            {
                cell.rightLabel.text = @"";
            }
            else
            {
                cell.rightLabel.text = [NSString stringWithFormat:@"%@",[_dataDic stringObjectForKey:@"projectName"]];
            }
#warning color
//            cell.rightLabel.textColor = THEME_COLOR_TEXT;
        }
        else if (indexPath.row == 1)
        {
            cell.leftLabel.text = @"金额：";
            if (_dataDic == nil || [[_dataDic objectForKey:@"money"] isKindOfClass:[NSNull class]])
            {
                cell.rightLabel.text = @"0";
            }
            else
            {
                cell.rightLabel.text = [NSString stringWithFormat:@"%@",[_dataDic objectForKey:@"money"]];
            }
#warning color
//            cell.rightLabel.textColor = THEME_COLOR_ORANGE;
            
        }
        else if (indexPath.row == 2)
        {
            cell.leftLabel.text = @"客户：";
            if (_dataDic == nil)
            {
                cell.rightLabel.text = @"";
            }
            else
            {
                cell.rightLabel.text = [NSString stringWithFormat:@"%@",[_dataDic objectForKey:@"customer"]];
            }
#warning color
//            cell.rightLabel.textColor = THEME_COLOR_TEXT;
            
        }
    }
    else
    {
        if (indexPath.row == 0)
        {
            cell.leftLabel.text = @"交易对方：";
            if (_dataDic == nil)
            {
                cell.rightLabel.text = @"";
            }
            else
            {
                cell.rightLabel.text = [NSString stringWithFormat:@"%@",[_dataDic stringObjectForKey:@"dealopt"]];
            }
#warning color
//            cell.rightLabel.textColor = THEME_COLOR_TEXT;
        }
        else if (indexPath.row == 1)
        {
            cell.leftLabel.text = @"交易日期：";
            if (_dataDic == nil)
            {
                cell.rightLabel.text = @"";
            }
            else
            {
                cell.rightLabel.text = [NSString stringWithFormat:@"%@",[_dataDic stringObjectForKey:@"dealtime"]];
            }
#warning color
//            cell.rightLabel.textColor = THEME_COLOR_TEXT;
        }
    }
    [cell frameToFit];
    
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    return 10;
}
- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section
{
    UIView *v = [[UIView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, 10)];
    v.backgroundColor = [UIColor clearColor];
    if (section != 2)
    {
        UIView *line = [[UIView alloc] initWithFrame:CGRectMake(0, 9.5, kScreenWidth, 0.5f)];
        line.backgroundColor = CD_LineColor;
        [v addSubview:line];
    }
    return v;
}

/**
 *	@brief	确认返回
 *
 *	@param 	sender
 *
 *	@return	N/A
 */
- (void)doConfirm:(id)sender
{
    //[self.navigationController popToViewController:self.popToViewController animated:YES];
//    [self.navigationController popToRootViewControllerAnimated:YES];
    
    //MYP add v3.2返回我得钱包
    AppDelegate * dele = (AppDelegate *)[UIApplication sharedApplication].delegate;
    if (dele.myPurseVC == nil) {
        [self.navigationController popViewControllerAnimated:YES];
    }
    else
    {
        [self.navigationController popToViewController:dele.myPurseVC animated:YES];
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
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
