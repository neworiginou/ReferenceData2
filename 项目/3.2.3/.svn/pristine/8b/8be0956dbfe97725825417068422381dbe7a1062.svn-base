//
//  HWMyCardViewController.m
//  HaoWu_4.0
//
//  Created by caijingpeng.haowu on 14-5-24.
//  Copyright (c) 2014年 caijingpeng. All rights reserved.
//
//  修改记录：
//      蔡景鹏  2014-7-8   添加银行卡前校验提现密码

#import "HWMyCardViewController.h"
#import "HWAddCardViewController.h"
#import "HWForgotMoneyPasswordController.h"
#import "HWMyCardDetailController.h"
#import "HWMoneyPasswordController.h"
#import "Partner_Swift-Swift.h"
#import "Define-OC.h"

@interface HWMyCardViewController ()

@end

@implementation HWMyCardViewController
@synthesize defaultDic,isSelectMode,delegate,selectedBank;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
        
        [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(queryListDataWithDelay) name:@"addCardOK" object:nil];
        
        isSelectMode = NO;
    }
    return self;
}
- (void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:YES];
    if (!isSelectMode)
    {
        self.navigationItem.rightBarButtonItem = nil;
    }
    
}
- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:YES];
    [self queryListData];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.navigationItem.titleView =[Utility navTitleView:@"我的银行卡"];
//    self.navigationItem.leftBarButtonItem = [Utility navLeftBackBtn:self action:@selector(backMethod)];
    self.navigationItem.leftBarButtonItem = [Utility navLeftBackBtn:self _selector:@selector(backMethod)];
    self.baseTableView.frame = CGRectMake(0, 0, self.view.bounds.size.width, self.view.bounds.size.height - 64);
    self.baseTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    self.isNeedHeadRefresh = YES;
    
    if (!isSelectMode)
    {
        UIView *footer = [[UIView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, 80)];
        
        UIButton *addButton = [UIButton buttonWithType:UIButtonTypeCustom];
        addButton.frame = CGRectMake(15, 15, kScreenWidth - 30, 50);
        [addButton setTitle:@"添加银行卡" forState:UIControlStateNormal];
#warning color
//        [addButton setButtonOrangeStyle];
        [addButton setButtonRedAndOrangeBorderStyle];
        [addButton addTarget:self action:@selector(addBankCard:) forControlEvents:UIControlEventTouchUpInside];
        [footer addSubview:addButton];
        
        self.baseTableView.tableFooterView = footer;
    }
    
    _selectIndex = 0;
    
}

- (void)queryListDataWithDelay
{
    [self performSelector:@selector(queryListData) withObject:nil afterDelay:1.0f];
}


- (void)queryListData
{
    self.defaultDic = nil;
    
    [Utility showMBProgress:self.view _message:@"获取数据"];
    HWHttpRequestOperationManager *manager = [HWHttpRequestOperationManager baseManager];
    NSMutableDictionary *dict = [NSMutableDictionary dictionary];
    [dict setPObject:[HWUserLogin currentUserLogin].key forKey:@"key"];
    [dict setPObject:@"1" forKey:@"channel"];
    
    [manager postHttpRequest:kCreditCardList parameters:dict queue:nil success:^(NSDictionary *responseObject) {
        [Utility hideMBProgress:self.view];
        
        if(_currentPage == 0)
            [self.dataList removeAllObjects];
        
        NSMutableArray *array = (NSMutableArray *)[[responseObject dictionaryObjectForKey:@"data"] arrayObjectForKey:@"content"];
        if(array.count < kPageCount)
        {
            isLastPage = YES;
        }
        else
        {
            isLastPage = NO;
        }
        //        [self.list addObjectsFromArray:array];
        
        // 将默认银行卡放在第一个
        for (int i = 0; i < array.count; i++)
        {
            NSDictionary *dic = [array objectAtIndex:i];
            if ([[dic objectForKey:@"isDefaut"] isEqualToString:@"on"])
            {
                self.defaultDic = dic;
                [array removeObject:dic];
                break;
            }
        }
        if (self.defaultDic!=nil)
        {
            [self.dataList addObject:self.defaultDic];
        }
        [self.dataList addObjectsFromArray:array];
        
        
        if (isSelectMode && self.selectedBank != nil)
        {
            for (int i = 0; i < self.dataList.count; i++)
            {
                NSDictionary *dic = [self.dataList objectAtIndex:i];
                NSString *cardNo = [NSString stringWithFormat:@"%@",[dic objectForKey:@"cardNo"]];
                if ([cardNo isEqualToString:[self.selectedBank objectForKey:@"cardNo"]])
                {
                    _selectIndex = i;
                    break;
                }
            }
        }
        
        
        [baseTableView reloadData];
        
        //        if(self.list.count==0) {
        //            [self showEmpty:@"暂无银行卡"];
        //        }
        [self doneLoadingTableViewData];
    } failure:^(NSString *code, NSString *error) {
        [Utility hideMBProgress:self.view];
        [self doneLoadingTableViewData];
        [baseTableView reloadData];
    }];
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
//    NSArray *tempArr = [self.list objectAtIndex:indexPath.section];
    NSDictionary *cellDict = (NSDictionary*)[self.dataList objectAtIndex:indexPath.row];
    HWMyCardCell *cell = (HWMyCardCell *)[tableView dequeueReusableCellWithIdentifier:@"cell"];
    if (!cell) {
        cell = [[HWMyCardCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"cell"];
    }
//    if (indexPath.section == 0 && self.defaultDic != nil)
//    {
//        cell.contentView.backgroundColor = UIColorFromRGB(0xfff3eb);
//    }
//    else
//    {
//        
//    }
    
    cell.titleLab.text = [NSString stringWithFormat:@"%@",[cellDict stringObjectForKey:@"bankName"]];
    [cell.headImgV setImageWithURL:[NSURL URLWithString:[cellDict stringObjectForKey:@"bankUrl"]] placeholderImage:[UIImage imageNamed:@"redDefault"]];
    
    NSMutableString *cardNo = [NSMutableString stringWithFormat:@"%@",[cellDict stringObjectForKey:@"cardNo"]];
    
    NSString *str;
    if (cardNo.length > 4)
    {
        str = [cardNo substringFromIndex:(cardNo.length - 4)];
    }
    else
    {
        str = cardNo;
    }
    
    cell.carNoStr = cardNo;
    cell.subTitleLab.text = [NSString stringWithFormat:@"尾号%@  %@",str,[cellDict stringObjectForKey:@"owerName"]];
    cell.delegate = self;
    NSString *isDefault = [NSString stringWithFormat:@"%@",[cellDict stringObjectForKey:@"isDefaut"]];
    if ([isDefault isEqualToString:@"off"])
    {
        cell.defaultLab.hidden = YES;
    }
    else
    {
        cell.defaultLab.hidden = NO;
    }
    cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    cell.accessoryView.backgroundColor = [UIColor clearColor];
    if (isSelectMode)
    {
        cell.defaultLab.hidden = YES;
        if (indexPath.row == _selectIndex)
        {
            UIImageView *imgV = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 22, 22)];
            imgV.image = [UIImage imageNamed:@"housecheck.png"];
            cell.accessoryView = imgV;
        }
        else
        {
            cell.accessoryView = nil;
        }
    }
    
    return cell;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.dataList.count;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 65.0f;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    if (isSelectMode)
    {
        _selectIndex = (int)indexPath.row;
        [tableView reloadData];
        
        if (delegate && [delegate respondsToSelector:@selector(selectedMyCardWithInfo:)])
        {
            if (_selectIndex == 0 && self.defaultDic != nil)
            {
                [delegate selectedMyCardWithInfo:self.defaultDic];
            }
            else
            {
                [delegate selectedMyCardWithInfo:[self.dataList objectAtIndex:indexPath.row]];
            }
        }

        [self backMethod];
    }
    else
    {
//        [MobClick event:@"click_card"];
        HWMyCardDetailController *cardDetailVC = [[HWMyCardDetailController alloc] init];
        NSMutableDictionary *card = [[NSMutableDictionary alloc] initWithDictionary:[self.dataList objectAtIndex:indexPath.row]];
        cardDetailVC.cardInfo = card;
        cardDetailVC.popToViewController = self;
        [self.navigationController pushViewController:cardDetailVC animated:YES];
    }
}
- (void)didClickSetDefaultWithCell:(HWMyCardCell *)cell
{
    
    [Utility showMBProgress:self.view _message:@"发送数据"];
    HWHttpRequestOperationManager *manager = [HWHttpRequestOperationManager baseManager];
    NSMutableDictionary *dict = [NSMutableDictionary dictionary];
    [dict setPObject:[HWUserLogin currentUserLogin].key forKey:@"key"];
    [dict setPObject:cell.carNoStr forKey:@"bankCardNo"];
    [dict setPObject:@"1" forKey:@"channel"];
    
    [manager postHttpRequest:kSetDefaultCreditCard parameters:dict queue:nil success:^(NSDictionary *responseObject) {
        [Utility hideMBProgress:self.view];
        [Utility showToastWithMessage:@"设置成功" _view:self.view];
        [self queryListData];
    } failure:^(NSString *code, NSString *error) {
        [Utility hideMBProgress:self.view];
        [Utility showToastWithMessage:error _view:self.view];
    }];
    
}

- (UIImage *)getBankImageByName:(NSString *)bankName
{
    //*问题* tianjia tubiao
    return nil;
}

- (void)addBankCard:(id)sender
{
    // 验证是否设置提现密码
//    [MobClick event:@"click_add_card"];
    
    [Utility showMBProgress:self.view _message:@"获取数据"];
    HWHttpRequestOperationManager *manager = [HWHttpRequestOperationManager baseManager];
    NSMutableDictionary *dict = [NSMutableDictionary dictionary];
    [dict setPObject:[HWUserLogin currentUserLogin].key forKey:@"key"];
    //    [dict setPObject:@"1" forKey:@"key"];
    [dict setPObject:@"1" forKey:@"channel"];
    
    [manager postHttpRequest:kAddCreditCardValidate parameters:dict queue:nil success:^(NSDictionary *responseObject) {
        [Utility hideMBProgress:self.view];
        NSDictionary *dataDic = [responseObject dictionaryObjectForKey:@"data"];
        
        NSString *state = [NSString stringWithFormat:@"%@",[dataDic objectForKey:@"state"]];
        if ([state isEqualToString:@"101"])
        {
            //未设置提现密码
            UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"提示" message:@"设置提现密码可有效保护您的资产安全，是否现在设置？" delegate:self cancelButtonTitle:@"暂不设置" otherButtonTitles:@"现在设置", nil];
            //             alert.tag = ALERT_GETMONEY_TAG;
            [alert show];
            
        }
        else if ([state isEqualToString:@"102"]) // 需要验证提现密码
        {
            //需要验证提现密码
            HWMoneyPasswordController *confirmPwdVC = [[HWMoneyPasswordController alloc] init];
            confirmPwdVC.pwdModel = Confirm_Password;
            confirmPwdVC.logic = LogicLine_BindCard;
            confirmPwdVC.popToViewController = self;
            [self.navigationController pushViewController:confirmPwdVC animated:YES];
        }
        else
        {
            HWAddCardViewController *addCardVC = [[HWAddCardViewController alloc] init];
            [self.navigationController pushViewController:addCardVC animated:YES];
        }
    } failure:^(NSString *code, NSString *error) {
        [Utility hideMBProgress:self.view];
        [Utility showToastWithMessage:error _view:self.view];
    }];
    
}
- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    if (buttonIndex == 1) {
        // 设置提现密码
        HWForgotMoneyPasswordController *setMoneyPwdVC = [[HWForgotMoneyPasswordController alloc] init];
        setMoneyPwdVC.logic = LogicLine_BindCard;
        setMoneyPwdVC.navigationItem.titleView = [Utility navTitleView:@"设置提现密码"];
        setMoneyPwdVC.popToController = self;
        [self.navigationController pushViewController:setMoneyPwdVC animated:YES];
    }
}


-(void)dealloc
{
    [[NSNotificationCenter defaultCenter]removeObserver:self];
}


@end
