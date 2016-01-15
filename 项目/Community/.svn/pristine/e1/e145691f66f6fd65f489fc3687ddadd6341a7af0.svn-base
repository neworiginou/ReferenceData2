//
//  HWCommissionDetailView.m
//  Community
//
//  Created by niedi on 15/1/20.
//  Copyright (c) 2015年 caijingpeng. All rights reserved.
//
//  功能描述：佣金详情View
//
//  修改记录：
//      姓名          日期                      修改内容
//      聂迪          2015-1-16                 创建文件
//

#import "HWCommissionDetailView.h"

@implementation HWCommissionDetailView

- (instancetype)initWithFrame:(CGRect)frame andGameId:(NSString *)gameId
{
    if (self = [super initWithFrame:frame]) {
        
        self.gameId = gameId;
        
        self.backgroundColor = [UIColor whiteColor];
        
        CGRect frame = self.baseTable.frame;
        frame.size.height = self.frame.size.height - 10;
        self.baseTable.frame = frame;
        self.baseTable.showsVerticalScrollIndicator = NO;
        
        [self queryListData];
        
        [self initTableViewHeaderView];
    }
    return self;
}

#pragma mark - 加载接口返回数据
- (void)loadDataForCommissionInfo
{
    _totalRMBCommissionLab.text = [NSString stringWithFormat:@"￥%@", self.commissionInfoModel.commissionCountRMB];
    _totalKoalaCommissionLab.text = [NSString stringWithFormat:@"%@", self.commissionInfoModel.commissionCountKLB];
    _totalActivateGamePeopleNumLab.text = [NSString stringWithFormat:@"%@人", self.commissionInfoModel.activateCount];
    _totalGameCostLab.text = [NSString stringWithFormat:@"￥%@", self.commissionInfoModel.consumeAmount.floatValue == 0 ? @"0": self.commissionInfoModel.consumeAmount];
}

/**
 *	@brief	佣金明细为空时 隐藏列表及标头
 *
 *	@return 默认隐藏
 */
- (void)showEmptyData
{
    _buttomTableViewUpView.hidden = YES;
    UILabel *lab = (UILabel *)[self viewWithTag:1114];
    lab.hidden = YES;
}

/**
 *	@brief	佣金明细不为空时 显示列表及标头
 *
 *	@return
 */
- (void)cancleShowEmptyView
{
    _buttomTableViewUpView.hidden = NO;
    UILabel *lab = (UILabel *)[self viewWithTag:1114];
    lab.hidden = NO;
}

#pragma mark - 网络请求
- (void)queryListData
{
    [self queryDataForCommissionInfo];              //请求佣金信息
    
    [self queryListDataForCommissionDetail];        //请求佣金明细
}

/**
 *	@brief	佣金明细 接口
 *
 *	@return
 */
- (void)queryListDataForCommissionDetail
{
    /*接口描述：当前推广员推广的游戏日常佣金明细
     接口url：hw-game-app-web/commission/queryCommissionAmount.do
     入参：gameId 游戏id（必填）
     userId 用户id（必填）
     page:0（第一页）
     size：10（每页条数）
     出参：
     {"status":"1","data":{"content":[{"dealDay":"2015-01-08","commissionDayCountKLB":0,"commissionDayCountRMB":14.9750,"gameAmountDetailDtoList":[
     {"dealTime":"22:22:22","eventType":3,"commissionAmountRMB":0.8000,"proportion":1.5,"commissionAmountKLB":null}
     ]}],"size":0,"number":0,"firstPage":true,"totalPages":1,"lastPage":true,"sort":null,"numberOfElements":2,"totalElements":2},"detail":"请求数据成功!","key":null}
     */
    
    HWUserLogin *user = [HWUserLogin currentUserLogin];
    
    NSMutableDictionary *param = [[NSMutableDictionary alloc]init];
    [param setPObject:user.userId forKey:@"userId"];
    [param setPObject:self.gameId forKey:@"gameId"];
    [param setPObject:@(kPageCount) forKey:@"size"];
    [param setPObject:@(self.currentPage) forKey:@"page"];
    
    HWHTTPRequestOperationManager *manage = [HWHTTPRequestOperationManager gameManager];
    
    [manage POST:KDailyCommissionDetail parameters:param queue:nil success:^(id responseObject)
     {
         
         NSLog(@"%@", responseObject);
         
         NSDictionary *dataDic = [responseObject dictionaryObjectForKey:@"data"];
         NSArray *contents = [dataDic arrayObjectForKey:@"content"];
         NSMutableArray *tmpArr = [NSMutableArray array];
         
         for (NSDictionary *dict in contents)
         {
             HWCommissionDetailModel *model = [[HWCommissionDetailModel alloc] initWithDict:dict];
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
             self.sectionStatusArr = [NSMutableArray array];
         }
         else
         {
             [self.baseListArr addObjectsFromArray:tmpArr];
             
         }
         
         if (self.baseListArr.count != 0)
         {
             [self cancleShowEmptyView];
         }
         
         int i = 0;
         while (i++ < tmpArr.count) //添加分区状态数组
         {
             if (self.currentPage == 0 && i == 1)   //第一个section默认打开
             {
                 [self.sectionStatusArr addObject:@(YES)];
             }
             else
             {
                 [self.sectionStatusArr addObject:@(NO)];
             }
         }
         
         [self.baseTable reloadData];
         [self doneLoadingTableViewData];
         
         if (self.baseListArr.count == 0)
         {
//             [self showEmpty:@"暂无佣金明细" withOffset:0];
//             _tableViewHeaderView.hidden = YES;
         }
         else
         {
             [self hideEmptyView];
//             _tableViewHeaderView.hidden = NO;
         }
         
         
     }failure:^(NSString *code, NSString *error) {
         
         [Utility showToastWithMessage:error inView:self];
     }];
}

- (void)queryDataForCommissionInfo
{
    /*接口描述：当前用户分享的游戏消费金额统计
     接口url：hw-game-app-web/commission/queryCommissionInfo.do
     入参：gameId 游戏id（必填）
     userId 用户id（必填）
     出参：
     {"status":"1","data":
     {"activateCount":3,"consumeAmount":null,"commissionCurrency":null,"gameId":null,"dealTime":null,"commissionCountRMB":15.7750,"commissionCountKLB":0,"commissionAmount":null,"eventType":null}
     ,"detail":"请求数据成功!","key":null}*/
    
    HWHTTPRequestOperationManager *manage = [HWHTTPRequestOperationManager gameManager];
    
    NSMutableDictionary *dict = [[NSMutableDictionary alloc] init];
    [dict setPObject:[HWUserLogin currentUserLogin].key forKey:@"key"];
    [dict setPObject:self.gameId forKey:@"gameId"];
    [dict setPObject:[HWUserLogin currentUserLogin].userId forKey:@"userId"];
    [dict setObject:@"0" forKey:@"gameType"];    //gameType参数，0：游戏应用；1：考拉社区应用
    
    [manage POST:KCommissionInfo parameters:dict queue:nil success:^(id responseObject)
     {
         NSLog(@"%@",responseObject);
         
         NSDictionary *tmpDic = [responseObject dictionaryObjectForKey:@"data"];
         
         self.commissionInfoModel = [[HWCommissionInfoModel alloc] initWithDict:tmpDic];
         
         [self loadDataForCommissionInfo];
         
     } failure:^(NSString *code, NSString *error) {
         
         NSLog(@"error %@",error);
     }];
}


#pragma mark - cell展开按钮

/**
 *	@brief	展开按钮点击事件
 *
 *	@param 	btn 	展开按钮
 *
 *	@return	刷新tableView
 */
- (void)spreadBtnClick:(UIView *)view
{
    int flag = view.tag - 3333;
    if (![[self.sectionStatusArr pObjectAtIndex:flag] boolValue])
    {
        [self.sectionStatusArr replaceObjectAtIndex:flag withObject:@(YES)];
    }
    else
    {
        [self.sectionStatusArr replaceObjectAtIndex:flag withObject:@(NO)];
    }

    [self.baseTable reloadData];
    [self doneLoadingTableViewData];
    
    if ([[self.sectionStatusArr pObjectAtIndex:flag] boolValue]) {
        
        [self.baseTable scrollToRowAtIndexPath:[NSIndexPath indexPathForRow:0 inSection:flag] atScrollPosition:UITableViewScrollPositionTop animated:YES];
    }
}

- (void)initTableViewHeaderView
{
    _tableViewHeaderView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, 242)];
    _tableViewHeaderView.backgroundColor = [UIColor clearColor];
    self.baseTable.tableHeaderView = _tableViewHeaderView;
    
    _belowSegmentViewForCommission = [[UIView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, 235)];
    _belowSegmentViewForCommission.backgroundColor = [UIColor whiteColor];
    [_tableViewHeaderView addSubview:_belowSegmentViewForCommission];
    
    UILabel *firstLTitleLab = [[UILabel alloc] initWithFrame:CGRectMake(15, 10, 80, 20)];
    firstLTitleLab.backgroundColor = [UIColor clearColor];
    firstLTitleLab.font = [UIFont fontWithName:FONTNAME size:THEME_FONT_BIG];
    firstLTitleLab.textColor = THEME_COLOR_TEXT;
    firstLTitleLab.text = @"总佣金";
    [_belowSegmentViewForCommission addSubview:firstLTitleLab];
    
    _totalRMBCommissionLab = [[UILabel alloc] initWithFrame:CGRectMake(35, CGRectGetMaxY(firstLTitleLab.frame) + 15, kScreenWidth / 2.0f - 50, 20)];
    _totalRMBCommissionLab.backgroundColor = [UIColor clearColor];
    _totalRMBCommissionLab.textColor = THEME_COLOR_MONEY;
    _totalRMBCommissionLab.font = [UIFont fontWithName:FONTNAME size:TITLE_BIG_SIZE];
    _totalRMBCommissionLab.text = @"￥0";
    [_belowSegmentViewForCommission addSubview:_totalRMBCommissionLab];
    
    _totalKoalaIconImg = [[UIImageView alloc] initWithFrame:CGRectMake(kScreenWidth / 2.0f + 20 * kScreenRate, _totalRMBCommissionLab.frame.origin.y, 20, 20)];
    _totalKoalaIconImg.image = [UIImage imageNamed:@"klb_new_01"];
    [_belowSegmentViewForCommission addSubview:_totalKoalaIconImg];
    
    _totalKoalaCommissionLab = [[UILabel alloc] initWithFrame:CGRectMake(kScreenWidth / 2.0f + 20 * kScreenRate + 25, _totalRMBCommissionLab.frame.origin.y, _totalRMBCommissionLab.frame.size.width, 20)];
    _totalKoalaCommissionLab.backgroundColor = [UIColor clearColor];
    _totalKoalaCommissionLab.textColor = THEME_COLOR_ORANGE;
    _totalKoalaCommissionLab.font = [UIFont fontWithName:FONTNAME size:TITLE_BIG_SIZE];
    _totalKoalaCommissionLab.text = @"0";
    [_belowSegmentViewForCommission addSubview:_totalKoalaCommissionLab];
    
    NSArray *titleArr = @[@"激活总量",@"用户总消费",@"收益明细"];
    for (int i = 0; i < 3; i++) {
        
        UILabel *lineLab = [[UILabel alloc] initWithFrame:CGRectMake(15, 75 + 45 * i, kScreenWidth - 2 * 15, 0.5)];
        lineLab.backgroundColor = THEME_COLOR_LINE;
        [_belowSegmentViewForCommission addSubview:lineLab];
        
        UILabel *titleLab = [[UILabel alloc] initWithFrame:CGRectMake(15, 75 + 12 + 45 * i, kScreenWidth - 2 * 30, 20)];
        titleLab.backgroundColor = [UIColor clearColor];
        titleLab.textColor = THEME_COLOR_TEXT;
        titleLab.font = [UIFont fontWithName:FONTNAME size:THEME_FONT_BIG];
        titleLab.text = titleArr[i];
        titleLab.tag = 1112 + i;
        [_belowSegmentViewForCommission addSubview:titleLab];
    }
    
    _totalActivateGamePeopleNumLab = [[UILabel alloc] initWithFrame:CGRectMake(15, 75 + 12, kScreenWidth - 2 * 15, 20)];
    _totalActivateGamePeopleNumLab.backgroundColor = [UIColor clearColor];
    _totalActivateGamePeopleNumLab.textColor = THEME_COLOR_SMOKE;
    _totalActivateGamePeopleNumLab.textAlignment = NSTextAlignmentRight;
    _totalActivateGamePeopleNumLab.font = [UIFont fontWithName:FONTNAME size:THEME_FONT_BIG];
    _totalActivateGamePeopleNumLab.text = @"0人";
    [_belowSegmentViewForCommission addSubview:_totalActivateGamePeopleNumLab];
    
    _totalGameCostLab = [[UILabel alloc] initWithFrame:CGRectMake(_totalActivateGamePeopleNumLab.frame.origin.x, _totalActivateGamePeopleNumLab.frame.origin.y + 45, kScreenWidth - 2 * 15, 20)];
    _totalGameCostLab.backgroundColor = [UIColor clearColor];
    _totalGameCostLab.textColor = THEME_COLOR_SMOKE;
    _totalGameCostLab.textAlignment = NSTextAlignmentRight;
    _totalGameCostLab.font = [UIFont fontWithName:FONTNAME size:THEME_FONT_BIG];
    _totalGameCostLab.text = @"￥0";
    [_belowSegmentViewForCommission addSubview:_totalGameCostLab];
    
    _buttomTableViewUpView = [[UIView alloc]initWithFrame:CGRectMake(15, CGRectGetMaxY(_totalGameCostLab.frame) + 45 + 10, kScreenWidth - 2 * 15, 35)];
    _buttomTableViewUpView.backgroundColor = THEME_COLOR_LINE;
    [_belowSegmentViewForCommission addSubview:_buttomTableViewUpView];
    
    UILabel * dateLab = [[UILabel alloc]initWithFrame:CGRectMake(20, 5, 50, 20)];
    dateLab.backgroundColor = [UIColor clearColor];
    dateLab.font = [UIFont fontWithName:FONTNAME size:THEME_FONT_BIG];
    dateLab.textColor = THEME_COLOR_SMOKE;
    dateLab.text = @"时间";
    [_buttomTableViewUpView addSubview:dateLab];
    
    UILabel * typeLab = [[UILabel alloc]initWithFrame:CGRectMake(0, 5, _buttomTableViewUpView.frame.size.width, 20)];
    typeLab.backgroundColor = [UIColor clearColor];
    typeLab.font = [UIFont fontWithName:FONTNAME size:THEME_FONT_BIG];
    typeLab.textColor = THEME_COLOR_SMOKE;
    typeLab.textAlignment = NSTextAlignmentCenter;
    typeLab.text = @"佣金获得方式";
    [_buttomTableViewUpView addSubview:typeLab];
    
    UILabel * moneyAmountsLab = [[UILabel alloc]initWithFrame:CGRectMake(_buttomTableViewUpView.frame.size.width - 15 - 50, 5, 50, 20)];
    moneyAmountsLab.backgroundColor = [UIColor clearColor];
    moneyAmountsLab.font = [UIFont fontWithName:FONTNAME size:THEME_FONT_BIG];
    moneyAmountsLab.textColor = THEME_COLOR_SMOKE;
    moneyAmountsLab.text = @"金额";
    moneyAmountsLab.textAlignment = NSTextAlignmentRight;
    [_buttomTableViewUpView addSubview:moneyAmountsLab];
    
    [self showEmptyData];
}

#pragma mark - TableView Delegate

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return self.baseListArr.count;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if ([self.sectionStatusArr[section] boolValue])
    {
        return [[self.baseListArr[section] gameAmountDetailDtoArray] count];
    }
    return 0;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *cellId = @"cellID";
    HWCommissionDetailCell *cell = [tableView dequeueReusableCellWithIdentifier:cellId];
    if (!cell)
    {
        cell = [[HWCommissionDetailCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellId];
    }
    [cell setCommissionDetailContent:[[[self.baseListArr pObjectAtIndex:indexPath.section] gameAmountDetailDtoArray] pObjectAtIndex:indexPath.row]];
    
    //上 下 划线
    if (indexPath.row == 0)
    {
        cell.topLineLab.hidden = YES;
    }
    else
    {
        cell.topLineLab.hidden = NO;
    }
    
    cell.buttomLab.hidden = YES;
    if (indexPath.section == self.baseListArr.count - 1 && indexPath.row == [[self.baseListArr[indexPath.section] gameAmountDetailDtoArray] count] - 1) {
        
        cell.buttomLab.hidden = NO;
    }
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return [HWCommissionDetailCell getCellHeight];
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 40.0f;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    return [self initSectionHeaderView:section];
}

- (UIView *)initSectionHeaderView:(NSInteger)section
{
    UIView *backView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, 40.0f)];
    backView.backgroundColor = [UIColor clearColor];
    
    UIControl *view = [[UIControl alloc] initWithFrame:CGRectMake(15, 0, kScreenWidth - 2 * 15, 40.0f)];
    view.backgroundColor = THEME_COLOR_TEXTBACKGROUND;
    view.tag = 3333 + section;
    [view addTarget:self action:@selector(spreadBtnClick:) forControlEvents:UIControlEventTouchUpInside];
    [backView addSubview:view];
    
    UILabel *leftLineLab = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 0.5, 40.0f)];
    leftLineLab.backgroundColor = THEME_COLOR_LINE;
    [view addSubview:leftLineLab];
    
    UILabel *rightLineLab = [[UILabel alloc] initWithFrame:CGRectMake(kScreenWidth - 2 * 15 - 0.5, 0, 0.5, 40.0f)];
    rightLineLab.backgroundColor = THEME_COLOR_LINE;
    [view addSubview:rightLineLab];
    
    UILabel *topLineLab = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, view.frame.size.width, 0.5f)];
    topLineLab.backgroundColor = THEME_COLOR_LINE;
    [view addSubview:topLineLab];
    
    UILabel *buttomLineLab = [[UILabel alloc] initWithFrame:CGRectMake(0, 39.5, view.frame.size.width, 0.5f)];
    buttomLineLab.backgroundColor = THEME_COLOR_LINE;
    [view addSubview:buttomLineLab];
    
    //按钮
    UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
    btn.frame = CGRectMake(5, 8, 20, 20);
//    [btn addTarget:self action:@selector(spreadBtnClick:) forControlEvents:UIControlEventTouchUpInside];
//    btn.tag = 2222 + section;
    btn.userInteractionEnabled = NO;
    [view addSubview:btn];
    
    //日期
    UILabel *commissionTimeLab = [[UILabel alloc] init];
    commissionTimeLab.frame = CGRectMake(30, 10, 200, 20);
    commissionTimeLab.backgroundColor = [UIColor clearColor];
    commissionTimeLab.font = [UIFont fontWithName:FONTNAME size:THEME_FONT_BIG];
    commissionTimeLab.textColor = THEME_COLOR_GRAY_MIDDLE;
    [view addSubview:commissionTimeLab];
    
    //金额
    UILabel *commissionMoneyLab = [[UILabel alloc] init];
    commissionMoneyLab.frame = CGRectMake(100, commissionTimeLab.frame.origin.y, kScreenWidth - 2 * 15 - 100 - 15, commissionTimeLab.frame.size.height);
    commissionMoneyLab.backgroundColor = [UIColor clearColor];
    commissionMoneyLab.textColor = THEME_COLOR_ORANGE;//THEME_COLOR_MONEY
    commissionMoneyLab.textAlignment = NSTextAlignmentRight;
    commissionMoneyLab.lineBreakMode = NSLineBreakByCharWrapping;
    commissionMoneyLab.font = [UIFont fontWithName:FONTNAME size:THEME_FONT_SMALL13];
    [view addSubview:commissionMoneyLab];
    
    //考拉币图片
    UIImageView *koalaCoinImg = [[UIImageView alloc] init];
    koalaCoinImg.frame = CGRectMake(0, commissionTimeLab.frame.origin.y + 3, 13, 13);
    koalaCoinImg.image = [UIImage imageNamed:@"klb_new_01"];
    koalaCoinImg.backgroundColor = [UIColor clearColor];
    [view addSubview:koalaCoinImg];
    
    
    
    //数据填充
    HWCommissionDetailModel *model = self.baseListArr[section];
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    formatter.dateFormat = @"yyyy-MM-dd";
    NSString *dateStr = [formatter stringFromDate:[NSDate date]];
    if ([model.dealDay isEqualToString:dateStr]) {
        
        commissionTimeLab.text = @"今天";
    }
    else
    {
        commissionTimeLab.text = [model.dealDay substringFromIndex:5];
    }
    
    NSMutableArray *moneyStrArr = [NSMutableArray array];
    if (![model.commissionDayCountKLB isEqualToString:@"0"]) {
        
        [moneyStrArr addObject:[NSString stringWithFormat:@"+%@", model.commissionDayCountKLB]];
        koalaCoinImg.hidden = NO;
    }
    else
    {
        [moneyStrArr addObject:@""];
        koalaCoinImg.hidden = YES;
    }
    
    if (!([model.commissionDayCountRMB isEqualToString:@"0"] || model.commissionDayCountRMB.length == 0) ) {
        
        [moneyStrArr addObject:[NSString stringWithFormat:@"+￥%@", model.commissionDayCountRMB]];
    }
    else
    {
        [moneyStrArr addObject:@""];
    }
    
    commissionMoneyLab.attributedText = [self getAttributedStr:moneyStrArr color:THEME_COLOR_MONEY];
    
    CGRect frame = koalaCoinImg.frame;
    frame.origin.x = kScreenWidth - 2 * 15 - 15 - 3 - 13 - [Utility calculateStringWidth:commissionMoneyLab.text font:[UIFont fontWithName:FONTNAME size:THEME_FONT_SMALL13] constrainedSize:CGSizeMake(10000, 20)].width;
    koalaCoinImg.frame = frame;
    
    if ([self.sectionStatusArr[section] boolValue]) {
        
        [btn setImage:[UIImage imageNamed:@"spread_icon01"] forState:UIControlStateNormal];
    }
    else
    {
        [btn setImage:[UIImage imageNamed:@"spread_icon02"] forState:UIControlStateNormal];
    }
    
    return backView;
}

#pragma mark - 其它工具类方法
/**
 *	@brief	返回 viewForHeaderInSection 的金额颜色
 *
 *	@param 	strArr 	字符串［考拉币，人民币］
 *	@param 	titleColor 	人民币的颜色
 *
 *	@return AttributedString
 */
- (NSMutableAttributedString *)getAttributedStr:(NSArray *)strArr color:(UIColor *)titleColor
{
    NSString *str = [strArr pObjectAtIndex:0];
    NSString *str1 = [strArr pObjectAtIndex:1];
    if (![str1 isEqualToString:@""]) {
        
        str = [NSString stringWithFormat:@"%@   ", str];
    }
    NSMutableAttributedString *attributeString = [[NSMutableAttributedString alloc]initWithString:[NSString stringWithFormat:@"%@%@", str, str1]];
    [attributeString addAttribute:NSFontAttributeName value:(id)[UIFont fontWithName:FONTNAME size:THEME_FONT_SMALL13] range:NSMakeRange([str length], [str1 length])];
    [attributeString addAttribute:NSForegroundColorAttributeName value:(id)titleColor range:NSMakeRange([str length], [str1 length])];
    return attributeString;
}


@end
