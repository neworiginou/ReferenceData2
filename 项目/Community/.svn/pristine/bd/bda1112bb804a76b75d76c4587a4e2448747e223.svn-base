//
//  HWGameSpreadRecordTBView.m
//  Community
//
//  Created by niedi on 15/1/15.
//  Copyright (c) 2015年 caijingpeng. All rights reserved.
//
//  功能描述：推广记录页面TableView
//
//  修改记录：
//      姓名          日期                      修改内容
//      聂迪          2015-1-16                 创建文件
//

#import "HWGameSpreadRecordTableView.h"

@implementation HWGameSpreadRecordTableView

- (instancetype)initWithFrame:(CGRect)frame {
    
    if (self = [super initWithFrame:frame])
    {
        
        [self loadUI];
        
        [self queryListData];
        [self queryMoneyAmountData];
    }
    return self;
}

/**
 *	@brief	加载总佣金接口
 *
 *	@return
 */
- (void)queryMoneyAmountData
{
    /*
     接口名称：查询推广历史记录--总佣金
     接口URL：/hw-game-app-web/commission/queryGeneralizeCommissionCount.do
     入参：
     userId(必填，推广员id)
     出参：
     {"status":"1","data":
     {"commissionCountRMB":5.8000,"commissionCountKLB":0,"activateCount":null,"consumeCount":null,"shareInfoPage":null}
     ,"detail":"请求数据成功!","key":null}
     */
    HWHTTPRequestOperationManager *manage = [HWHTTPRequestOperationManager gameManager];
    NSMutableDictionary *dict = [[NSMutableDictionary alloc] init];
    [dict setPObject:[HWUserLogin currentUserLogin].userId forKey:@"userId"];
    [dict setObject:@"0" forKey:@"gameType"];    //gameType参数，0：游戏应用；1：考拉社区应用
    
    [manage POST:KGameSpreadRecordMoneyNum parameters:dict queue:nil success:^(id responseObject)
    {
        NSDictionary *dataDic = [responseObject dictionaryObjectForKey:@"data"];
        
        NSString *moneyStr = [dataDic stringObjectForKey:@"commissionCountRMB"];
        moneyStr = moneyStr.floatValue == 0 ? @"0" : moneyStr;
        _moneyAmountsLab.text = [Utility conversionThousandth:moneyStr];
        
        NSString *koalaStr = [dataDic stringObjectForKey:@"commissionCountKLB"];
        koalaStr = koalaStr.floatValue == 0 ? @"0" : koalaStr;
        koalaStr = [Utility conversionThousandth:koalaStr];
        koalaStr = [koalaStr substringToIndex:koalaStr.length - 3];
        _koalaCoinAmountsLab.text = koalaStr;
        
    } failure:^(NSString *code, NSString *error) {
        
        NSLog(@"error %@",error);
    }];
}

/**
 *	@brief	加载推广记录接口
 *
 *	@return
 */
- (void)queryListData
{
    /*接口名称：查询推广历史记录--游戏列表
     接口URL：/hw-game-app-web/game/queryGeneralizeRecord.do
     入参：
     userId(必填，推广员id)
     page 分页，第page页，第一页从0开始
     size 每页数据条数
     出参：
     {"status":"1","data":{"commissionCountRMB":5.8000,"commissionCountKLB":0,"activateCount":null,"consumeCount":null,"shareInfoPage":{"content":[
     {"gameId":1,"gameName":"地狱边境","iconMongodbKey":"3423424sdfsfgfdg","activateCount":1,"consumeCount":null,"status":1,"commissionRMB":0.8000,"commissionKLB":null,"commissionCurrency":null,"commissionAmount":null}
     ,
     {"gameId":2,"gameName":"虚无荣耀","iconMongodbKey":"21sdf565wr22343","activateCount":0,"consumeCount":50.0000,"status":1,"commissionRMB":5.0000,"commissionKLB":null,"commissionCurrency":null,"commissionAmount":null}
     ],"size":10,"number":0,"sort":null,"firstPage":true,"totalPages":1,"lastPage":true,"numberOfElements":2,"totalElements":2}},"detail":"请求数据成功!","key":null}*/
    
    [Utility showMBProgress:self message:@"加载中..."];
    
    HWUserLogin *user = [HWUserLogin currentUserLogin];
    
    NSMutableDictionary *param = [[NSMutableDictionary alloc]init];
    [param setPObject:user.userId forKey:@"userId"];
    [param setPObject:@(kPageCount) forKey:@"size"];
    [param setPObject:@(self.currentPage) forKey:@"page"];
    [param setObject:@"0" forKey:@"gameType"];      //gameType参数，0：游戏应用；1：考拉社区应用
    HWHTTPRequestOperationManager *manage = [HWHTTPRequestOperationManager gameManager];
    
    [manage POST:KGameSpreadRecordList parameters:param queue:nil success:^(id responseObject)
    {
        
        [Utility hideMBProgress:self];
        
        NSLog(@"%@", responseObject);
        
        NSDictionary *dataDic = [responseObject dictionaryObjectForKey:@"data"];
        NSDictionary *pageDic = [dataDic dictionaryObjectForKey:@"shareInfoPage"];
        NSArray *contents = [pageDic arrayObjectForKey:@"content"];
        NSMutableArray *tmpArr = [NSMutableArray array];
        
        for (NSDictionary *dict in contents) {
            
            HWGameSpreadRecordModel *model = [[HWGameSpreadRecordModel alloc] initWithDict:dict];
            [tmpArr addObject:model];
        }
        
        if(tmpArr.count < kPageCount)
        {
            isLastPage = YES;
        }
        else
        {
            isLastPage = NO;
        }
        
        if (self.currentPage == 0)
        {
            self.baseListArr = [NSMutableArray arrayWithArray:tmpArr];
        }
        else
        {
            [self.baseListArr addObjectsFromArray:tmpArr];
        }
        
        [self addTableViewFootView];
        [self.baseTable reloadData];
        [self doneLoadingTableViewData];
        
        if (self.baseListArr.count == 0)
        {
            [self showEmpty:@"还没有推广过游戏" withOffset:140];
            
            UIButton *spreadBtn = [UIButton buttonWithType:UIButtonTypeCustom];
            spreadBtn.frame = CGRectMake(15, 190 + (CONTENT_HEIGHT - 190) / 2.0f * 1.3f, kScreenWidth - 2 * 15, 45.0f);
            spreadBtn.backgroundColor = THEME_COLOR_ORANGE;
            spreadBtn.layer.cornerRadius = 3.5f;
            spreadBtn.layer.masksToBounds = YES;
            [spreadBtn setTitle:@"去推广" forState:UIControlStateNormal];
            spreadBtn.titleLabel.font = [UIFont fontWithName:FONTNAME size:TITLE_BIG_SIZE];
            [spreadBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
            [spreadBtn addTarget:self action:@selector(popViewController) forControlEvents:UIControlEventTouchUpInside];
            spreadBtn.tag = 9993;
            [self addSubview:spreadBtn];
        }
        else
        {
            [self hideEmptyView];
            UIButton *btn = (UIButton *)[self viewWithTag:9993];
            btn.hidden = YES;
        }
        
    }failure:^(NSString *code, NSString *error) {
        
        [Utility hideMBProgress:self];
        [Utility showToastWithMessage:error inView:self];
    }];
    
}

- (void)loadUI
{
    _tableViewHeadView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, 190)];
    _tableViewHeadView.backgroundColor = [UIColor whiteColor];
    self.baseTable.tableHeaderView = _tableViewHeadView;
    
    //人民币总佣金
    _rmbHeadView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, 95)];
    _rmbHeadView.backgroundColor = [UIColor clearColor];
    [_tableViewHeadView addSubview:_rmbHeadView];
    
    UILabel *moneyTitleLab = [[UILabel alloc] initWithFrame:CGRectMake(15, 10, 200, 20)];
    moneyTitleLab.backgroundColor = [UIColor clearColor];
    moneyTitleLab.textColor = THEME_COLOR_SMOKE;
    moneyTitleLab.font = [UIFont fontWithName:FONTNAME size:THEME_FONT_SMALL];
    moneyTitleLab.text = @"总佣金(人民币)";
    [_rmbHeadView addSubview:moneyTitleLab];
    
    _moneyAmountsLab = [[UILabel alloc] init];
    _moneyAmountsLab.backgroundColor = [UIColor clearColor];
    if (IOS7)
    {
        
        _moneyAmountsLab.frame = CGRectMake(15, CGRectGetMaxY(moneyTitleLab.frame) + 4, kScreenWidth - 15, 50);
        _moneyAmountsLab.font = [UIFont fontWithName:FONTNAME size:44];
    }
    else
    {
        _moneyAmountsLab.frame = CGRectMake(15, CGRectGetMaxY(moneyTitleLab.frame) + 4, kScreenWidth - 15, 50);
        _moneyAmountsLab.font = [UIFont fontWithName:FONTNAME size:40];
    }
    _moneyAmountsLab.text = @"0";
    _moneyAmountsLab.textColor = THEME_COLOR_MONEY;
    [_rmbHeadView addSubview:_moneyAmountsLab];
    
    //考拉币总佣金
    _KoalaCoinHeadView = [[UIView alloc] initWithFrame:CGRectMake(0, CGRectGetMaxY(_rmbHeadView.frame), kScreenWidth, _rmbHeadView.frame.size.height)];
    _KoalaCoinHeadView.backgroundColor = [UIColor clearColor];
    [_tableViewHeadView addSubview:_KoalaCoinHeadView];
    
    UILabel *KoalaCoinTitleLab = [[UILabel alloc] initWithFrame:CGRectMake(15, 10, 200, 20)];
    KoalaCoinTitleLab.backgroundColor = [UIColor clearColor];
    KoalaCoinTitleLab.textColor = THEME_COLOR_SMOKE;
    KoalaCoinTitleLab.font = [UIFont fontWithName:FONTNAME size:THEME_FONT_SMALL];
    KoalaCoinTitleLab.text = @"总佣金(考拉币)";
    [_KoalaCoinHeadView addSubview:KoalaCoinTitleLab];
    
    _koalaCoinAmountsLab = [[UILabel alloc] init];
    _koalaCoinAmountsLab.backgroundColor = [UIColor clearColor];
    if (IOS7)
    {
        
        _koalaCoinAmountsLab.frame = CGRectMake(15, CGRectGetMaxY(moneyTitleLab.frame) + 4, kScreenWidth - 15, 50);
        _koalaCoinAmountsLab.font = [UIFont fontWithName:FONTNAME size:44];//@"Helvetica Neue LT Pro"
    }
    else
    {
        _koalaCoinAmountsLab.frame = CGRectMake(15, CGRectGetMaxY(moneyTitleLab.frame) + 4, kScreenWidth - 15, 50);
        _koalaCoinAmountsLab.font = [UIFont fontWithName:FONTNAME size:40];
    }
    _koalaCoinAmountsLab.text = @"0";
    _koalaCoinAmountsLab.textColor = THEME_COLOR_ORANGE;
    [_KoalaCoinHeadView addSubview:_koalaCoinAmountsLab];
    
    //佣金说明 btn
    UIButton *yongJinDescriptionBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    yongJinDescriptionBtn.frame = CGRectMake(kScreenWidth - 15 - 30, 0, 40, 40);
    yongJinDescriptionBtn.backgroundColor = [UIColor clearColor];
    [yongJinDescriptionBtn setImage:[UIImage imageNamed:@"game_icon3"] forState:UIControlStateNormal];
    yongJinDescriptionBtn.layer.masksToBounds = YES;
    yongJinDescriptionBtn.layer.cornerRadius = 10;
    [yongJinDescriptionBtn addTarget:self action:@selector(pushToYongJinDescriptionViewController) forControlEvents:UIControlEventTouchUpInside];
    [_rmbHeadView addSubview:yongJinDescriptionBtn];
    
    //下划线
    for (int i = 0; i < 3; i++)
    {
        
        UILabel *lineLab = [[UILabel alloc] initWithFrame:CGRectMake(0, 0 + 95.0f * i, kScreenWidth, 0.5)];
        lineLab.backgroundColor = THEME_COLOR_LINE;
        [_tableViewHeadView addSubview:lineLab];
    }
    
}

/**
 *	@brief	添加tableView footView
 *
 *	@return
 */
- (void)addTableViewFootView
{
    
    if (isLastPage)
    {
        if (self.baseListArr.count == 0)
        {
            self.baseTable.tableFooterView = nil;
            return;
        }
        UIView *footView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, 35)];
        footView.backgroundColor = [UIColor clearColor];
        
        UILabel *totalRecordLab = [[UILabel alloc] initWithFrame:CGRectMake(0, 10, kScreenWidth, 15)];
        totalRecordLab.backgroundColor = [UIColor clearColor];
        totalRecordLab.textColor = THEME_COLOR_TEXT;
        totalRecordLab.textAlignment = NSTextAlignmentCenter;
        totalRecordLab.font = [UIFont fontWithName:FONTNAME size:THEME_FONT_SMALL];
        totalRecordLab.text = [NSString stringWithFormat:@"共%d个推广历史", self.baseListArr.count];
        [footView addSubview:totalRecordLab];
        
        self.baseTable.tableFooterView = footView;
    }
    else
    {
        self.baseTable.tableFooterView = nil;
    }
}

/**
 *	@brief	跳转到佣金说明页面
 *
 *	@return	void
 */
- (void)pushToYongJinDescriptionViewController
{
    
    if (self.delegate && [self.delegate respondsToSelector:@selector(pushToYongJinDescriptionViewController)])
    {
        [self.delegate pushToYongJinDescriptionViewController];
    }
}

- (void)popViewController
{
    if (self.delegate && [self.delegate respondsToSelector:@selector(popViewController)]) {
        
        [self.delegate popViewController];
    }
}

#pragma mark - tableViewDelegate
- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, 10)];
    view.backgroundColor = [UIColor clearColor];
    return view;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 10.0f;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.baseListArr.count;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *cellId = @"cellId";
    HWGameSpreadRecordCell *cell = [tableView dequeueReusableCellWithIdentifier:cellId];
    if (!cell)
    {
        cell = [[HWGameSpreadRecordCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellId];
    }
    
    [cell setGaemSpreadRecordInfo:self.baseListArr[indexPath.row]];
    
    if (indexPath.row == 0)
    {
        cell.topLineLab.hidden = NO;
    }
    else
    {
        cell.topLineLab.hidden = YES;
    }
    
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return [HWGameSpreadRecordCell getCellHeight:self.baseListArr[indexPath.row]];
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [MobClick event:@"click_commissiondetail"]; //maidian_1.2.1
    
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    if (self.delegate && [self.delegate respondsToSelector:@selector(pushToGameDetailViewController:)])
    {
        [self.delegate pushToGameDetailViewController:self.baseListArr[indexPath.row]];
    }
}


@end
