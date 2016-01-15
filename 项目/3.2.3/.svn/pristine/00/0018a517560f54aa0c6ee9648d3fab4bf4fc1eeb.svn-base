//
//  HWCashSuccessViewController.m
//  HaoWu_4.0
//
//  Created by caijingpeng.haowu on 14-5-29.
//  Copyright (c) 2014年 caijingpeng. All rights reserved.
//

#import "HWCashSuccessViewController.h"
#import "HWDoubleLabelCell.h"
#import "WalletDetailViewController.h"
#import "Partner_Swift-Swift.h"
#import "Define-OC.h"

@interface HWCashSuccessViewController ()

@end

@implementation HWCashSuccessViewController
@synthesize bank,money,restMoney,cashDetailID;
@synthesize popToViewController;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.navigationItem.titleView =[Utility navTitleView:@"提现成功"];
    self.navigationItem.leftBarButtonItem = nil;
    self.navigationItem.hidesBackButton = YES;
    
    self.isNeedHeadRefresh = NO;
    
    self.baseTableView.frame = CGRectMake(0, 0, kScreenWidth, CONTENT_HEIGHT);
    self.baseTableView.separatorStyle = UITableViewCellSeparatorStyleSingleLine;
    
    UIView *footer = [[UIView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, 110)];
    
    UIView *line = [[UIView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, 1)];
    line.backgroundColor = CD_LineColor;
    [footer addSubview:line];
    
    
    UILabel *info = [[UILabel alloc] initWithFrame:CGRectMake(15, 5, kScreenWidth - 30, 20)];
    info.font = [UIFont fontWithName:FONTNAME size:11.0f];
#warning color
//    info.textColor = THEME_COLOR_TEXT;
    info.text = @"好屋中国会在5个工作日内（节假日除外），将款项转给你的银行卡。";
    CGSize infoSize = [info.text sizeWithFont:info.font constrainedToSize:CGSizeMake(kScreenWidth - 30, 40) lineBreakMode:NSLineBreakByWordWrapping];
    info.frame = CGRectMake(15, 5, kScreenWidth - 30, infoSize.height);
    [footer addSubview:info];
    
    for (int i = 0; i < 2; i++)
    {
        UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
        btn.frame = CGRectMake(15 + (15 + (kScreenWidth - 45) / 2.0f) * i, CGRectGetMaxY(info.frame) + 10, (kScreenWidth - 45) / 2.0f, 50);
        if (i == 0)
        {
            [btn setTitle:@"确认" forState:UIControlStateNormal];
            [btn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
#warning color
//            [btn setBackgroundColor:THEME_COLOR_ORANGE];
//            [btn setButtonOrangeStyle];
            [btn setButtonRedAndOrangeBorderStyle];
            [btn addTarget:self action:@selector(finishedCash:) forControlEvents:UIControlEventTouchUpInside];
        }
        else
        {
            [btn setTitle:@"查看详情" forState:UIControlStateNormal];
            [btn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
#warning color
//            [btn setButtonOrangeStyle];
            [btn setButtonRedAndOrangeBorderStyle];
            [btn addTarget:self action:@selector(showDetail:) forControlEvents:UIControlEventTouchUpInside];
        }
        
        [footer addSubview:btn];
    }
    
    self.baseTableView.tableFooterView = footer;
}



- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
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
    if (indexPath.row == 0)
    {
        cell.leftLabel.text = @"银行卡：";
        cell.rightLabel.text = [self.bank stringObjectForKey:@"bankName"];
        
    }
    else if (indexPath.row == 1)
    {
        cell.leftLabel.text = @"提现金额：";
        cell.rightLabel.text = self.money;
#warning color
//        cell.rightLabel.textColor = THEME_COLOR_ORANGE;
    }
    else if (indexPath.row == 2)
    {
        cell.leftLabel.text = @"账户余额：";
        cell.rightLabel.text = self.restMoney;
#warning color
//        cell.rightLabel.textColor = THEME_COLOR_ORANGE;
    }
    
    [cell frameToFit];
    
    return cell;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 50;
}

/**
 *	@brief	显示交易详情
 *
 *	@param 	sender
 *
 *	@return	N/A
 */
- (void)showDetail:(id)sender
{
    WalletDetailViewController *detailVC = [[WalletDetailViewController alloc] initWithDetailID:self.cashDetailID];
    detailVC.popToViewController = self.popToViewController;
    [self.navigationController pushViewController:detailVC animated:YES];
}

/**
 *	@brief	确认返回
 *
 *	@param 	sender
 *
 *	@return	N/A
 */
- (void)finishedCash:(id)sender
{
//    [self.navigationController popToViewController:self animated:<#(BOOL)#>];
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
