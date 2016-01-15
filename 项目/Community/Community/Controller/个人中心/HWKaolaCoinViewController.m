//
//  HWKaolaCoinViewController.m
//  Community
//
//  Created by gusheng on 14-12-9.
//  Copyright (c) 2014年 caijingpeng. All rights reserved.
//

#import "HWKaolaCoinViewController.h"
#import "PurseTableViewCell.h"
#import "HWForgotMoneyPasswordController.h"
#import <CoreText/CoreText.h>
#import "HWMyCardViewController.h"
#import "HWMoneyPasswordManagerController.h"
#import "HWAddCardViewController.h"
#import "HWMoneyPasswordController.h"
#import "ExtractViewController.h"
#import "HWKaolaPurseTableViewCell.h"
#import "HWRechargeViewController.h"
#import "HWKaoLaCoinDetailViewController.h"
#import "HWKaoLaCoinInfoModel.h"
#define SELECT_VIEW_TAG         777
#define kBackHeight             120
#define kCalculateTime          15
#define kRedCountTag            999
#define ALERT_GETMONEY_TAG      1001
#define ALERT_BIND_TAG          1002
#define MONEY_TAG               1003
@interface HWKaolaCoinViewController ()
{
     NSString *typeStr;
}
@end

@implementation HWKaolaCoinViewController

@synthesize totalMoney;
- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self)
    {
    }
    return self;
}

- (void)viewWillAppear:(BOOL)animated
{
    [self queryListData];
}

- (void)viewWillDisappear:(BOOL)animated
{
}

/**
 *	@brief	添加红点
 *
 *	@return	N/A
 */
- (void)addRedPoint
{
    //    [(HWTabbarCtr *)self.tabBarController setBadgePoint];
}

/**
 *	@brief	移除红点
 *
 *	@return	N/A
 */
- (void)removeRedPoint
{
    if (!self.tabBarController) {
        return;
    }
    //    [(HWTabbarCtr *)self.tabBarController removeBadgePoint];
}


- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.navigationItem.titleView = [Utility navTitleView:@"我的考拉币"];
    
    self.navigationItem.leftBarButtonItem = [Utility navLeftBackBtn:self action:@selector(backMethod)];
    self.navigationItem.rightBarButtonItem = self.navigationItem.rightBarButtonItem = [Utility navButton:self title:@"充值" action:@selector(toRecharge:)];
    
    _backIV = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, kScreenWidth, kBackHeight)];
    UIImage *_backFitImage = [UIImage imageNamed:@"bg_color_green"];
    [_backFitImage resizableImageWithCapInsets:UIEdgeInsetsMake(10, 10, 50, 10)];
    _backIV.image = _backFitImage;
    [self.view addSubview:_backIV];
    
    UILabel *myMoneyLabel = [[UILabel alloc]initWithFrame:CGRectMake(10, 15, 150, 20)];
    myMoneyLabel.backgroundColor = [UIColor clearColor];
    myMoneyLabel.text = @"考拉币余额（个）";
    myMoneyLabel.textColor = [UIColor whiteColor];
    myMoneyLabel.font = [UIFont fontWithName:FONTNAME size:15];
    [_backIV addSubview:myMoneyLabel];
    
    _moneyLabel = [[UILabel alloc] init];
    if (IOS7) {
        _moneyLabel.frame = CGRectMake(10, CGRectGetMaxY(myMoneyLabel.frame)+15, kScreenWidth-2*10, _backIV.frame.size.height - 35-20);
        _moneyLabel.font = [UIFont fontWithName:@"Helvetica Neue LT Pro" size:60];
    } else {
        _moneyLabel.frame = CGRectMake(10, CGRectGetMaxY(myMoneyLabel.frame)+15, kScreenWidth-2*10, _backIV.frame.size.height - 30-20);
        _moneyLabel.font = [UIFont fontWithName:@"Helvetica Neue LT Pro" size:55];
    }
    _moneyLabel.text = @"0";
    _moneyLabel.adjustsFontSizeToFitWidth = YES;
    _moneyLabel.textColor = [UIColor whiteColor];
    _moneyLabel.backgroundColor = [UIColor clearColor];
    [_backIV addSubview:_moneyLabel];
    
    
    self.baseTableView.frame = CGRectMake(0, CGRectGetMaxY(_backIV.frame), kScreenWidth, CONTENT_HEIGHT - kBackHeight);
    UIView *view = [[UIView alloc]init];
    baseTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    self.baseTableView.tableFooterView = view;
    
    _isFirstTime = YES;
    _cashType = @"0";
    
    [self reCalculate];
    
     [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(refershKaolaCoinView) name:RELOAD_MONEYView object:nil];
}
-(void)refershKaolaCoinView
{
    [self queryListData];
    [self getKaolaCoinMoney];
}
#pragma - mark 获取考拉币余额

- (void)getKaolaCoinMoney
{
    HWUserLogin *user = [HWUserLogin currentUserLogin];
    HWHTTPRequestOperationManager *manage = [HWHTTPRequestOperationManager accountManager];
    NSMutableDictionary *dict = [[NSMutableDictionary alloc] init];
    [dict setPObject:user.key forKey:@"key"];
    [dict setPObject:user.userId forKey:@"userId"];
    
    [manage POST:kKaolaRemain parameters:dict queue:nil success:^(id responseObject) {
        [Utility hideMBProgress:self.view];
        NSDictionary *respDic = (NSDictionary *)[responseObject dictionaryObjectForKey:@"data"];
        self.totalMoney = [respDic stringObjectForKey:@"amount"];
        [self reCalculate];
    } failure:^(NSString *code, NSString *error) {
        [Utility hideMBProgress:self.view];
        NSLog(@"error %@",error);
    }];
}
-(void)dealloc
{
//    [[NSNotificationCenter defaultCenter]removeObserver:self forKeyPath:RELOAD_MONEYView];
}
//充值
#warning 绑定手机号  充值
-(void)toRecharge:(id)sender
{
    if ([HWUserLogin verifyBindMobileWithPopVC:self showAlert:YES])
    {
        HWRechargeViewController *rechargeVC = [[HWRechargeViewController alloc]init];
        [self.navigationController pushViewController:rechargeVC animated:YES];
    }
}
/**
 *	@brief	刷新函数
 *
 *	@return	N/A
 */
- (void)getNewList
{
    _isFirstTime = YES;
    [self queryListData];
}

/**
 *	@brief	加载钱包数据
 *
 *	@return	N/A
 */
#pragma - mark 考拉币列表接口
- (void)queryListData
{
    [Utility hideMBProgress:self.view];
    [Utility showMBProgress:self.view message:@"请求数据"];

    HWHTTPRequestOperationManager *manage = [HWHTTPRequestOperationManager accountManager];
    NSMutableDictionary *param = [NSMutableDictionary dictionary];
    [param setPObject:[HWUserLogin currentUserLogin].key forKey:@"key"];
    [param setPObject:[HWUserLogin currentUserLogin].userId forKey:@"userId"];
//    [param setPObject:[Utility getLocalAppVersion] forKey:@"appUrlVersion"];  //后台去掉了
    [param setPObject:[NSString stringWithFormat:@"%d",_currentPage] forKey:@"page"];
    [param setPObject:[NSString stringWithFormat:@"%d",kPageCount] forKey:@"size"];
    
    [manage POST:kKaolaCoinList parameters:param queue:nil success:^(id responseObject)
     {
         NSLog(@"%@", responseObject);
         [Utility hideMBProgress:self.view];
         NSDictionary *dataDic = [responseObject dictionaryObjectForKey:@"data"];
         NSArray *contents = [dataDic arrayObjectForKey:@"content"];
         NSMutableArray *array = [NSMutableArray array];
         
         for (int i = 0; i < contents.count; i++)
         {
             HWKaoLaCoinInfoModel *shareItem = [[HWKaoLaCoinInfoModel alloc]initWithDic:[contents objectAtIndex:i]];
             [array addObject:shareItem];
         }
         
         if(array.count < kPageCount)
         {
             isLastPage = YES;
         }
         else
         {
             isLastPage = NO;
         }
         
         if (_currentPage == 0)
         {
             dataList = [NSMutableArray arrayWithArray:array];
             //保存数据库
             if (self.dataList != 0)
             {
//                 [HWCoreDataManager removeAllPriviledgeLsitItem];
//                 [HWCoreDataManager addPriviledgeListItem:self.dataList];
             }
         }
         else
         {
             [self.dataList addObjectsFromArray:array];
         }
         [baseTableView reloadData];
         
         if(self.dataList.count == 0)
         {
             [self showEmpty:@"暂无收支明细" withOffset:50];
         }else{
             [self hideEmpty];
         }
         
         [self doneLoadingTableViewData];
     } failure:^(NSString *code, NSString *error) {
         [Utility hideMBProgress:self.view];
         [Utility showToastWithMessage:error inView:self.view];
         [self doneLoadingTableViewData];
         NSLog(@"houselist error hwhttprequest:%@",error);
         if (self.dataList.count == 0)
         {
             [self showEmpty:@"暂无收支明细" withOffset:50];
         }else{
             [self hideEmpty];
         }
         
     }];
}

/**
 *	@brief	重新启动数字滚动动画
 *
 *	@return	N/A
 */
- (void)reCalculate
{
    _moneyLabel.text = @"0";
    if ([self.totalMoney floatValue] <= 0)
    {
        return;
    }
    _addMoney = 0;
    if ([_timer isValid])
    {
        [_timer invalidate];
        _timer = nil;
    }
    _timer = [NSTimer scheduledTimerWithTimeInterval:1.0f/20.f  target:self selector:@selector(calculateMoney) userInfo:nil repeats:YES];
}

/**
 *	@brief	金额滚动的幅度大小
 *
 *	@return	N/A
 */
- (void)calculateMoney
{
    float timeMoney = [self.totalMoney floatValue] / 15.0;
    _addMoney += timeMoney;
    
    NSNumberFormatter *formatter=[[NSNumberFormatter alloc]init];
    [formatter setGroupingSeparator:@","];
    [formatter setGroupingSize:3];
    [formatter setUsesGroupingSeparator:YES];
    NSNumber *num= [NSNumber numberWithFloat:_addMoney];
    NSString *str = [formatter stringFromNumber:num];
    _moneyLabel.text = str;
    if (_addMoney >= [self.totalMoney floatValue])
    {
        [_timer invalidate];
        _timer = nil;
//        _moneyLabel.text = [NSString stringWithFormat:@"%d",(int)self.totalMoney.floatValue];
        
        NSNumberFormatter *formatter=[[NSNumberFormatter alloc]init];
        [formatter setGroupingSeparator:@","];
        [formatter setGroupingSize:3];
        [formatter setUsesGroupingSeparator:YES];
        NSNumber *num= [NSNumber numberWithFloat:self.totalMoney.floatValue];
        NSString *str = [formatter stringFromNumber:num];
        _moneyLabel.text = str;
    }
    
}
- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    [super scrollViewDidScroll:scrollView];
    
    if ([scrollView isEqual:_selectTableView])
    {
        return;
    }
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 44;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    
    
    UIView *v = [[UIView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, 44)];
    v.backgroundColor = [UIColor clearColor];
    
    UILabel *label = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, kScreenWidth, 44)];
    label.userInteractionEnabled = YES;
    label.font = [UIFont fontWithName:FONTNAME size:16];
    label.backgroundColor = [UIColor whiteColor];
    label.textColor = THEME_COLOR_SMOKE;
    [v addSubview:label];
    label.text = @"   收支明细";
    UIView *line = [[UIView alloc] initWithFrame:CGRectMake(0, 44 - 0.5f, kScreenWidth, 0.5f)];
    line.backgroundColor = THEME_COLOR_LINE;
    [v addSubview:line];
    
    return v;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    
    return [dataList count];
    
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 62;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *cellIdentifier = @"cell";
    HWKaolaPurseTableViewCell * cell = (HWKaolaPurseTableViewCell *)[tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    if (!cell)
    {
        cell = [[HWKaolaPurseTableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdentifier];
    }
    
    [cell setNormalLine];
    if (indexPath.row == 0)
    {
        [cell setTodayValue];
        [cell setFirstLine];
    }
    else
    {
        cell._descriptionLabel.textColor = THEME_COLOR_GRAY_MIDDLE;
    }
    if (indexPath.row == ([dataList count] - 1))
    {
        [cell setFinalLine];
    }

    [cell addaptWithDictionary:[dataList objectAtIndex:indexPath.row]];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    
    return cell;
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    HWKaoLaCoinDetailViewController *coinDetailV = [[HWKaoLaCoinDetailViewController alloc]init];
    HWKaoLaCoinInfoModel *coinInfoModel = [self.dataList objectAtIndex:indexPath.row];
    NSString *moneyStr;
 //   if ([coinInfoModel.flowDirection isEqualToString:@"1"]) {
        moneyStr = [NSString stringWithFormat:@"%@个",coinInfoModel.flowMoney];
        
//    }
//    else
//    {
//        moneyStr = [NSString stringWithFormat:@"-￥%@",coinInfoModel.flowMoney];
//    }
    coinDetailV.accountFlowIdStr = coinInfoModel.accountFlowId;
    coinDetailV.moneyStr = moneyStr;
    
    [self.navigationController pushViewController:coinDetailV animated:YES];
}

@end
