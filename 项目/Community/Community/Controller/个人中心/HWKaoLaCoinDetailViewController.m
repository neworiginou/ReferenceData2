//
//  HWKaoLaCoinDetailViewController.m
//  Community
//
//  Created by gusheng on 14-12-12.
//  Copyright (c) 2014年 caijingpeng. All rights reserved.
//

#import "HWKaoLaCoinDetailViewController.h"
#import "HWCoinDetailModel.h"
#import "HWDoubleLabelCell.h"
#import "HWGeneralControl.h"
@interface HWKaoLaCoinDetailViewController ()

@end

@implementation HWKaoLaCoinDetailViewController
@synthesize moneyStr,accountFlowIdStr;
- (void)viewDidLoad {
    [super viewDidLoad];
    listData = [[NSMutableArray alloc]initWithObjects:@"",@"",@"",@"",@"",@"",@"",@"", nil];
    self.navigationItem.titleView =[Utility navTitleView:@"账单详情"];
    self.navigationItem.leftBarButtonItem = [Utility navLeftBackBtn:self action:@selector(backMethod)];
    _coinDetailTableV = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, CONTENT_HEIGHT) style:UITableViewStylePlain];
    _coinDetailTableV.dataSource = self;
    _coinDetailTableV.delegate = self;
    _coinDetailTableV.separatorStyle = UITableViewCellSeparatorStyleNone;
    _coinDetailTableV.backgroundColor = [UIColor clearColor];
    [self.view addSubview:_coinDetailTableV];
    
    UIView *headerView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, 10)];
    headerView.backgroundColor = [UIColor clearColor];
    UIView *line = [[UIView alloc] initWithFrame:CGRectMake(0, 9.5, kScreenWidth, 0.5f)];
    line.backgroundColor = THEME_COLOR_LINE;
    [headerView addSubview:line];
    
    _coinDetailTableV.tableHeaderView = headerView;
    titleData = @[@"交易类型  ",@"流水号  ",@"订单状态  ",@"考拉币  ",@"用户  ",@"支付项目  ",@"交易对象  ",@"交易时间  "];
    [self queryListData:accountFlowIdStr];
}
-(void)refershUI:(HWCoinDetailModel *)coinDetailModelTemp
{
    [listData removeAllObjects];
     NSString *tradeType;
    for (int i = 0; i < 8; i++)
    {
        switch (i) {
            case 0:
            {
                /*
                 考拉币目前就三种业务类型：1、考拉币充值；2、无底线消费；3、流标返还 4.佣金
                 */
                if ([coinDetailModelTemp.tradeType isEqualToString:@"1"])
                {
                    tradeType = @"考拉币充值";
                }
                else if([coinDetailModelTemp.tradeType isEqualToString:@"2"])
                {
                    tradeType = @"无底线消费";
                }
                else if([coinDetailModelTemp.tradeType isEqualToString:@"3"])
                {
                    tradeType = @"流标返还";
                }
                else if([coinDetailModelTemp.tradeType isEqualToString:@"4"])
                {
                    tradeType = @"游戏推广";
                }
                [listData addObject:tradeType];
                
            }
                
                break;
            case 1:
                [listData addObject:coinDetailModelTemp.orderNum];
                break;
            case 2:
            {
                //orderStatus	订单状态1、已付款；2、已返还
                NSString *orderStatus;
                if ([coinDetailModelTemp.orderStatus isEqualToString:@"1"])
                {
                    orderStatus = @"已付款";
                }
                else if([coinDetailModel.orderStatus isEqualToString:@"2"])
                {
                    orderStatus = @"已返还";
                }
                else if([coinDetailModel.orderStatus isEqualToString:@"3"])
                {
                    orderStatus = @"已付款";
                }
                [listData addObject:orderStatus];
                break;
            }
            case 3:
                if ([moneyStr length]!=0)
                {
                     [listData addObject:moneyStr];
                }
                else
                {
                    [listData addObject:coinDetailModel.money];
                }
               
                break;
            case 4:
                [listData addObject:coinDetailModel.user];
                break;
            case 5:
                [listData addObject:coinDetailModel.project];
                break;
            case 6:
                [listData addObject:coinDetailModel.tradeObject];
                break;
                
            case 7:
            {
                if ([coinDetailModelTemp.tradeTime length]!=0) {
                    [listData addObject:[Utility getDetailTimeWithTimestamp:coinDetailModel.tradeTime]];
                }
                else
                {
                    [listData addObject:@""];
                }
                break;
            }
            default:
                break;
        }
    }
    [_coinDetailTableV reloadData];
}
#pragma - mark 获取考拉币详情
- (void)queryListData:(NSString *)priviledgeIdStr
{
    [Utility hideMBProgress:self.view];
    [Utility showMBProgress:self.view message:@"请求数据"];
    HWHTTPRequestOperationManager *manage = [HWHTTPRequestOperationManager accountManager];
    HWUserLogin *user = [HWUserLogin currentUserLogin];
    NSMutableDictionary *dict = [[NSMutableDictionary alloc] init];
    [dict setPObject:user.key forKey:@"key"];
    [dict setPObject:priviledgeIdStr forKey:@"accountFlowId"];
    
    [manage POST:kCoinDetail parameters:dict queue:nil success:^(id responseObject) {
        [Utility hideMBProgress:self.view];
        NSDictionary *respDic = (NSDictionary *)[responseObject dictionaryObjectForKey:@"data"];
        coinDetailModel = [[HWCoinDetailModel alloc]initWithDic:respDic];
        [self refershUI:coinDetailModel];
    } failure:^(NSString *code, NSString *error) {
        [Utility showToastWithMessage:error inView:self.view];
        [Utility hideMBProgress:self.view];
        NSLog(@"error %@",error);
    }];
}
#pragma - mark
 #pragma - mark TableViewDelegate
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *cellIdentifier = @"CoinDetailIdentifier";
    HWDoubleLabelCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    if (!cell)
    {
        cell = [[HWDoubleLabelCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdentifier];
    }
    cell.backgroundColor = [UIColor whiteColor];
    int row = (int)indexPath.row;
    cell.leftLabel.text =  [titleData objectAtIndex:row];
    cell.rightLabel.text = [listData objectAtIndex:row];
    if(indexPath.row == 3)
    {
        [cell.rightLabel setTextColor:THEME_COLOR_ORANGE];
    }
    UIImageView *lineView = [HWGeneralControl createImageView:CGRectMake(10, 44-0.5, kScreenWidth-10, 0.5) image:@""];
    lineView.backgroundColor = THEME_COLOR_LINE;
    [cell addSubview:lineView];
    [cell frameToFit];
    return cell;
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    
}
-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    return nil;
}
-(UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section
{
    return nil;
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 44.0;
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [titleData count];
}
//changed by niedi 20141208
- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {
    return 0;
}
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    return 0;
}

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
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
