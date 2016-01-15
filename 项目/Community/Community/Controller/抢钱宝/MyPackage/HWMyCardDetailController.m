//
//  HWMyCardDetailController.m
//  HaoWu_4.0
//
//  Created by caijingpeng.haowu on 14-7-8.
//  Copyright (c) 2014年 caijingpeng. All rights reserved.
//
//  功能描述：银行卡详情，可解绑银行卡
//

#import "HWMyCardDetailController.h"
#import "HWMyCardCell.h"
#import "HWMoneyPasswordController.h"

@interface HWMyCardDetailController ()
{
    UITableView *_mainTV;
}

@end

@implementation HWMyCardDetailController
@synthesize cardInfo;
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
    // Do any additional setup after loading the view.
    
    self.navigationItem.titleView = [Utility navTitleView:@"银行卡详情"];
    self.navigationItem.leftBarButtonItem = [Utility navLeftBackBtn:self action:@selector(backMethod)];
    
    _mainTV = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, CONTENT_HEIGHT) style:UITableViewStylePlain];
    _mainTV.backgroundColor = [UIColor clearColor];
    _mainTV.delegate = self;
    _mainTV.dataSource = self;
    [self.view addSubview:_mainTV];
    
    
    UIView *footerView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, 140)];
    footerView.backgroundColor = [UIColor clearColor];
    
    NSString *isDefault = [NSString stringWithFormat:@"%@",[self.cardInfo stringObjectForKey:@"isDefaut"]];
    if ([isDefault isEqualToString:@"off"])
    {
        for (int i = 0; i < 2; i++)
        {
            UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
            button.frame = CGRectMake(15, 20 + i * (45+15), kScreenWidth - 30, 45);
            [button setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
            button.titleLabel.font = [UIFont fontWithName:FONTNAME size:17.0f];
            
            if (i == 0)
            {
                [button setTitle:@"设为默认" forState:UIControlStateNormal];
                [button setButtonOrangeStyle];
                [button addTarget:self action:@selector(clickSetDefaultButton:) forControlEvents:UIControlEventTouchUpInside];
            }
            else
            {
                [button setTitle:@"解除绑定" forState:UIControlStateNormal];
//                [button setBackgroundImage:[UIImage imageNamed:@"logoutBackground"] forState:UIControlStateNormal];
//                button.layer.cornerRadius = 3.0f;
//                button.layer.masksToBounds = YES;
                [button setButtonGrayStyle];
                [button addTarget:self action:@selector(clickDeleteCardButton:) forControlEvents:UIControlEventTouchUpInside];
            }
            
            [footerView addSubview:button];
        }
    }
    else
    {
        UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
        button.frame = CGRectMake(15, 20, self.view.frame.size.width - 30, 45);
        [button setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        button.titleLabel.font = [UIFont fontWithName:FONTNAME size:17.0f];
        button.layer.cornerRadius = 3.0f;
        button.layer.masksToBounds = YES;
        [button setTitle:@"解除绑定" forState:UIControlStateNormal];
//        [button setBackgroundImage:[UIImage imageNamed:@"logoutBackground"] forState:UIControlStateNormal];
        [button setButtonGrayStyle];
        [button addTarget:self action:@selector(clickDeleteCardButton:) forControlEvents:UIControlEventTouchUpInside];
        [footerView addSubview:button];
    }
    
    _mainTV.tableFooterView = footerView;
    
}

#pragma mark ------- private method -------------

/**
 *	@brief	银行卡详情
 *
 *	@return	x
 */
- (void)reloadCardInfo

{
    [self.cardInfo setValue:@"on" forKey:@"isDefaut"];
    [_mainTV reloadData];
    
    
    UIView *footerView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, 140)];
    footerView.backgroundColor = [UIColor whiteColor];
    
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    button.frame = CGRectMake(15, 25, self.view.frame.size.width - 30, 45);
    [button setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    button.titleLabel.font = [UIFont fontWithName:FONTNAME size:17.0f];
    [button setTitle:@"解除绑定" forState:UIControlStateNormal];
//    [button setBackgroundImage:[UIImage imageNamed:@"logoutBackground@2x"] forState:UIControlStateNormal];
    [button setButtonGrayStyle];
    [button addTarget:self action:@selector(clickDeleteCardButton:) forControlEvents:UIControlEventTouchUpInside];
    [footerView addSubview:button];
    
    _mainTV.tableFooterView = footerView;
}
- (void)clickSetDefaultButton:(id)sender
{
    [MobClick event:@"click_default_card"];
    // 设为默认
    [Utility showMBProgress:self.view message:@"发送数据"];
    HWHTTPRequestOperationManager *manager = [HWHTTPRequestOperationManager societyManager];
    
    NSMutableDictionary *dict = [NSMutableDictionary dictionary];
    [dict setPObject:[HWUserLogin currentUserLogin].key forKey:@"key"];
    [dict setPObject:[self.cardInfo stringObjectForKey:@"cardNo"] forKey:@"bankCardNo"];
    [dict setPObject:@"1" forKey:@"channel"];
    
    [manager POST:kSetDefaultCreditCard parameters:dict queue:nil success:^(id responseObject) {
        [Utility hideMBProgress:self.view];
        [Utility showToastWithMessage:@"设置成功" inView:self.view];
        // 刷新页面
        [self reloadCardInfo];
        
    } failure:^(NSString *code, NSString *error) {
        
        [Utility hideMBProgress:self.view];
        [Utility showToastWithMessage:error inView:self.view];
    }];
}
/**
 *	@brief	验证提现密码
 *
 *	@param 	sender
 *
 *	@return	x
 */
- (void)clickDeleteCardButton:(id)sender
{
    
    [MobClick event:@"click_delete_card"];
    // 解绑前 验证提现密码
    HWMoneyPasswordController *confirmPwdVC = [[HWMoneyPasswordController alloc] init];
    confirmPwdVC.pwdModel = Confirm_Password;
    confirmPwdVC.logic = LoginLine_UnBindCard;
    confirmPwdVC.popToViewController = self.popToViewController;
    NSMutableDictionary *dict = [NSMutableDictionary dictionary];
    [dict setPObject:[HWUserLogin currentUserLogin].key forKey:@"key"];
    [dict setPObject:[self.cardInfo stringObjectForKey:@"brokerBankId"] forKey:@"brokerBankId"];
    confirmPwdVC.unBindCardInfo = dict;
    [self.navigationController pushViewController:confirmPwdVC animated:YES];
    
}

#pragma mark ------- tableview delegate datasource --------
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 65.0f;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 1;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    HWMyCardCell *cell = (HWMyCardCell *)[tableView dequeueReusableCellWithIdentifier:@"cell"];
    if (!cell)
    {
        cell = [[HWMyCardCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"cell"];
    }
    cell.titleLab.text = [NSString stringWithFormat:@"%@",[self.cardInfo stringObjectForKey:@"bankName"]];
    
    [cell.headImgV setImageWithURL:[NSURL URLWithString:[self.cardInfo stringObjectForKey:@"bankUrl"]] placeholderImage:[UIImage imageNamed:@"redDefault"]];
    
    NSMutableString *cardNo = [NSMutableString stringWithFormat:@"%@",[self.cardInfo stringObjectForKey:@"cardNo"]];
    
    NSString *str;
    if (cardNo.length > 8)
    {
        str = [NSString stringWithFormat:@"%@ **** **** %@",[cardNo substringToIndex:4],[cardNo substringFromIndex:cardNo.length - 4]];
    }
    else
    {
        str = cardNo;
    }
    cell.carNoStr = cardNo;
    cell.subTitleLab.text = [NSString stringWithFormat:@"%@  %@", str, [self.cardInfo stringObjectForKey:@"owerName"]];
    NSString *isDefault = [NSString stringWithFormat:@"%@", [self.cardInfo stringObjectForKey:@"isDefaut"]];
    if ([isDefault isEqualToString:@"off"])
    {
        cell.defaultLab.hidden = YES;
        
    }
    else
    {
        cell.defaultLab.hidden = NO;
        cell.defaultLab.center = CGPointMake(kScreenWidth - 25, cell.defaultLab.center.y);
    }
    
    cell.backgroundColor = [UIColor whiteColor];
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
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
