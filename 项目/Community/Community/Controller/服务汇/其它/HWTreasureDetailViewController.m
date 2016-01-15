//
//  HWTreasureDetailViewController.m
//  Community
//
//  Created by caijingpeng.haowu on 14-12-9.
//  Copyright (c) 2014年 caijingpeng. All rights reserved.
//
//  功能描述：发布页面
//
//  修改记录：
//      姓名         日期               修改内容
//     蔡景鹏     2015-05-12           添加
//     蔡景鹏     2015-01-16           添加相册管理类 将读取相册功能封装 HWAlbumManager
//

#import "HWTreasureDetailViewController.h"
#import "HWPriceRecordCell.h"
#import "HWGetPrizeCell.h"
#import "HWShowOrderViewController.h"
#import "HWRecordModel.h"
#import "HWWinnerModel.h"
#import "HWShowOrderModel.h"
#import "HWAddressModel.h"
#import "SurePayController.h"
#import "HWDetailOrderModel.h"
#import "HWGoodsDetailViewController.h"
#import "HWTopicListViewController.h"

@interface HWTreasureDetailViewController ()<HWGetPrizeCellDelegate, UIAlertViewDelegate>
{
    NSTimer *timer;
    int distanceTime;
    int totalTime;
//    UILabel *timeLab;
}

@property (nonatomic, strong) NSMutableArray *recordList;
@property (nonatomic, assign) ActivityMode activityMode;
@property (nonatomic, strong) HWWinnerModel *winnerModel;
@property (nonatomic, strong) HWShowOrderModel *showOrderModel;
@property (nonatomic, strong) HWAddressModel *addressModel;
@property (nonatomic, strong) NSString *mobileStr;
@property (nonatomic, strong) HWDetailOrderModel *orderModel;

@end

@implementation HWTreasureDetailViewController

@synthesize recordList;
@synthesize activityMode;
@synthesize joinedItem;

@synthesize winnerModel;
@synthesize showOrderModel;
@synthesize addressModel;
@synthesize orderModel;
@synthesize mobileStr;
@synthesize popToViewController;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self)
    {
        
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.navigationItem.titleView = [Utility navTitleView:@"详情"];
    self.navigationItem.leftBarButtonItem = [Utility navLeftBackBtn:self action:@selector(backMethod)];
    
//    [self initialTableViewHeader];
//    
//    recordList = [NSMutableArray arrayWithObjects:@"1",@"2", nil];
//    
//    activityMode = EndMode;
    self.baseTableView.hidden = YES;
    
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [self.navigationController setNavigationBarHidden:NO animated:NO];
    [self queryListData];
}

- (void)initialTableViewHeader
{
    NSString *goodsInfoStr = [NSString stringWithFormat:@"%@\n%@", self.joinedItem.productName, self.joinedItem.remark];
    NSString *goodsSourceStr = [NSString stringWithFormat:@"商品服务由 %@ 提供", self.joinedItem.service];
    
    UIFont *font = [UIFont fontWithName:FONTNAME size:THEME_FONT_BIG];
    CGSize infoSize = [Utility calculateStringHeight:goodsInfoStr font:font constrainedSize:CGSizeMake(kScreenWidth - 90 - 15, 10000)];
    
    UIView *headerView = [[UIView alloc] initWithFrame:CGRectMake(0,
                                                                  0,
                                                                kScreenWidth,
                                                                  MAX(65.0f + 20, 20 + infoSize.height + 5 + 20))];
    headerView.backgroundColor = [UIColor whiteColor];
    self.baseTableView.tableHeaderView = headerView;
    
    UIImageView *goodsImgV = [[UIImageView alloc] initWithFrame:CGRectMake(15, 10, 65.0f, 65.0f)];
    goodsImgV.layer.cornerRadius = 4.0f;
    goodsImgV.layer.borderColor = THEME_COLOR_LINE.CGColor;
    goodsImgV.clipsToBounds = YES;
    goodsImgV.layer.borderWidth = 0.5f;
    goodsImgV.backgroundColor = [UIColor clearColor];
    
    __weak UIImageView *weakImgV = goodsImgV;
    [goodsImgV setImageWithURL:[NSURL URLWithString:[Utility imageDownloadUrl:self.joinedItem.smallImg]] placeholderImage:[UIImage imageNamed:IMAGE_PLACE] completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType) {
       
        if (error != nil)
        {
            weakImgV.image = [UIImage imageNamed:IMAGE_BREAK_CUBE];
        }
        else
        {
            weakImgV.image = image;
        }
        
    }];
    [headerView addSubview:goodsImgV];
    
    UILabel *titleLab = [[UILabel alloc] initWithFrame:CGRectMake(CGRectGetMaxX(goodsImgV.frame) + 10,
                                                                  10,
                                                                  kScreenWidth - 90 - 15,
                                                                  infoSize.height)];
    titleLab.backgroundColor = [UIColor clearColor];
    titleLab.font = [UIFont fontWithName:FONTNAME size:THEME_FONT_BIG];
    titleLab.textColor = THEME_COLOR_SMOKE;
    titleLab.numberOfLines = 0;
    titleLab.lineBreakMode = NSLineBreakByWordWrapping;
    [headerView addSubview:titleLab];
    
    UILabel *contentLab = [[UILabel alloc] initWithFrame:CGRectMake(CGRectGetMinX(titleLab.frame), CGRectGetMaxY(titleLab.frame) + 5, CGRectGetWidth(titleLab.frame), 20)];
    contentLab.backgroundColor = [UIColor clearColor];
    contentLab.font = [UIFont fontWithName:FONTNAME size:THEME_FONT_SMALL];
    contentLab.textColor = THEME_COLOR_TEXT;
    [headerView addSubview:contentLab];
    
    UIView *line = [[UIView alloc] initWithFrame:CGRectMake(0, CGRectGetHeight(headerView.frame) - 0.5f, kScreenWidth, 0.5f)];
    line.backgroundColor = THEME_COLOR_LINE;
    [headerView addSubview:line];
    
    titleLab.text = goodsInfoStr;
    contentLab.text = goodsSourceStr;
}

- (void)toPayAgain:(id)sender
{
    //根据id直接跳转
    HWGoodsDetailViewController *detailVC = [[HWGoodsDetailViewController alloc] init];
    detailVC.productId = self.joinedItem.productId;
    [self.navigationController pushViewController:detailVC animated:YES];
    
    
//    [MobClick event:@"click_partake in again"];
//    [[NSNotificationCenter defaultCenter] postNotificationName:CutAgainNotification object:self.joinedItem];
//    [self.navigationController popToViewController:popToViewController animated:YES];
    
    
}

- (void)queryListData
{
    [Utility showMBProgress:self.view message:@"加载中..."];
    HWHTTPRequestOperationManager *manager = [HWHTTPRequestOperationManager cutManager];
    NSMutableDictionary *param = [NSMutableDictionary dictionary];
    [param setPObject:[HWUserLogin currentUserLogin].key forKey:@"key"];
    [param setPObject:@"1" forKey:@"source"];
    [param setPObject:self.joinedItem.productId forKey:@"productId"];

    [manager POST:kJoinedDetail parameters:param queue:nil success:^(id responseObject) {
        
        if (timer != nil)
        {
            totalTime = 0;
            [timer invalidate];
            timer = nil;
        }
        
        NSLog(@"%@",responseObject);
        [Utility hideMBProgress:self.view];
        NSDictionary *resultDic = [responseObject dictionaryObjectForKey:@"data"];
        
        NSArray *recordArr = [resultDic arrayObjectForKey:@"cutLowGuessPriceAssembleDtoList"];
        self.recordList = [NSMutableArray array];
        for (int i = 0; i < recordArr.count; i++)
        {
            NSDictionary *dic = [recordArr objectAtIndex:i];
            [self.recordList addObject:[[HWRecordModel alloc] initWithRecord:dic]];
        }
        
        //[resultDic dictionaryObjectForKey:@"cutShowOrderDto"] [resultDic dictionaryObjectForKey:@"addressDto"]
        self.winnerModel = [[HWWinnerModel alloc] initWithWinner:[resultDic dictionaryObjectForKey:@"winnerDto"]];
        self.showOrderModel = [[HWShowOrderModel alloc] initWithShowOrder:[resultDic dictionaryObjectForKey:@"cutShowOrderDto"]];
        self.addressModel = [[HWAddressModel alloc] initWithAddress:[resultDic dictionaryObjectForKey:@"addressDto"]];
        self.mobileStr = [resultDic stringObjectForKey:@"mobile"];
//        if (self.winnerModel.mobile.length != 0)
//        {
//            self.mobileStr = [Utility securePhoneNumber:self.winnerModel.mobile];
//        }
        self.orderModel = [[HWDetailOrderModel alloc] initWithDetailOrder:[resultDic dictionaryObjectForKey:@"orderDto"]];
        
        // 商品活动状态（商品状态：0未开始，1 进行中，2流标，3已开奖）
        if (self.joinedItem.productStatus.intValue == 1)
        {
            activityMode = ProceedMode;
            [self queryEndTime];
        }
        else if (self.joinedItem.productStatus.intValue == 2)
        {
            activityMode = EndMode;
        }
        else if (self.joinedItem.productStatus.intValue == 3)
        {
            // 已开奖
            activityMode = NormalEndMode;
        }
        else if (self.joinedItem.productStatus.intValue == 4)
        {
            activityMode = EndMode;
        }
        else if (self.joinedItem.productStatus.intValue == 5)
        {
            // 已中奖
            activityMode = PrizeMode;
            
            // 将唯一最低价从列表中删除
            
            for (int i = 0; i < self.recordList.count; i++)
            {
                HWRecordModel *record = [self.recordList objectAtIndex:i];
                if(record.samePriceTimes.intValue <= 1 && record.uniqueLowerTimes.intValue == 0)
                {
                    [self.recordList removeObjectAtIndex:i];
                    [self.recordList insertObject:record atIndex:0];
                    break;
                }
            }
        }
        
        self.baseTableView.hidden = NO;
        
        [self initialTableViewHeader];
        [self.baseTableView reloadData];
        
    } failure:^(NSString *code, NSString *error) {
        [Utility hideMBProgress:self.view];
        [Utility showToastWithMessage:error inView:self.view];
    }];
    
}

- (void)queryEndTime
{
    HWUserLogin *user = [HWUserLogin currentUserLogin];
    HWHTTPRequestOperationManager *manage = [HWHTTPRequestOperationManager cutManager];
    
    NSMutableDictionary *param = [NSMutableDictionary dictionary];
    [param setPObject:user.key forKey:@"key"];
    [param setPObject:self.joinedItem.productId forKey:@"productId"];
    [param setPObject:@"1" forKey:@"source"];
    
    [manage POST:kEndDistance parameters:param queue:nil success:^(id responseObject) {
        
        NSLog(@"%@",responseObject);
        [Utility hideMBProgress:self.view];
        NSString *time = [responseObject stringObjectForKey:@"data"];
        distanceTime = time.intValue / 1000;
        
        if (timer != nil)
        {
            totalTime = 0;
            [timer invalidate];
            timer = nil;
        }
        
        timer = [NSTimer scheduledTimerWithTimeInterval:1.0f target:self selector:@selector(countDown) userInfo:nil repeats:YES];
        
        [self.baseTableView reloadData];
        
    } failure:^(NSString *code, NSString *error) {
        [Utility hideMBProgress:self.view];
        [Utility showToastWithMessage:error inView:self.view];
    }];
}

- (void)countDown
{
    totalTime++;
    
    [self.baseTableView reloadData];
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 2;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (section == 0)
    {
        if (activityMode == ProceedMode)
        {
            return recordList.count + 1;
        }
        else
        {
            return recordList.count;
        }
    }
    else if (section == 1)
    {
        if (activityMode == EndMode)
        {
            return 1;
        }
        return 2;
    }
    return 0;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section == 0)
    {
        if (activityMode == ProceedMode)
        {
            if (indexPath.row != self.recordList.count)
            {
                HWPriceRecordCell *cell = (HWPriceRecordCell *)[tableView dequeueReusableCellWithIdentifier:@"pr_cell"];
                if (!cell)
                {
                    cell = [[HWPriceRecordCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"pr_cell"];
                }
                cell.selectionStyle = UITableViewCellSelectionStyleNone;
                [cell setPriceRecord:self.recordList[indexPath.row]];
                return cell;
            }
            else
            {
                UITableViewCell *cell = (UITableViewCell *)[tableView dequeueReusableCellWithIdentifier:@"button_cell"];
                if (!cell)
                {
                    cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"button_cell"];
                    
                    UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
                    btn.frame = CGRectMake(15, 10, kScreenWidth - 30, 45.0f);
                    [btn setTitle:@"再来一次" forState:UIControlStateNormal];
                    [btn setButtonOrangeStyle];
                    btn.tag = 999;
                    [btn addTarget:self action:@selector(toPayAgain:) forControlEvents:UIControlEventTouchUpInside];
                    [cell.contentView addSubview:btn];
                }
                
                UIButton *btn = (UIButton *)[cell.contentView viewWithTag:999];
                if (btn != nil)
                {
                    if (distanceTime - totalTime > 0)
                    {
                        [btn setButtonOrangeStyle];
                        btn.userInteractionEnabled = YES;
                    }
                    else
                    {
                        [btn setButtonGrayStyle];
                        btn.userInteractionEnabled = NO;
                    }
                }
                
                
                cell.selectionStyle = UITableViewCellSelectionStyleNone;
                
                return cell;
            }
        }
        else if (activityMode == EndMode || activityMode == NormalEndMode)
        {
            HWPriceRecordCell *cell = (HWPriceRecordCell *)[tableView dequeueReusableCellWithIdentifier:@"price_cell"];
            if (!cell)
            {
                cell = [[HWPriceRecordCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"price_cell"];
            }
            [cell setPriceRecord:self.recordList[indexPath.row]];
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
            return cell;
        }
        else if (activityMode == PrizeMode)
        {
            if (indexPath.row == 0)
            {
                HWGetPrizeCell *cell = (HWGetPrizeCell *)[tableView dequeueReusableCellWithIdentifier:@"cell"];
                if (!cell)
                {
                    cell = [[HWGetPrizeCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"cell"];
                }
                cell.delegate = self;
                cell.selectionStyle = UITableViewCellSelectionStyleNone;
                
                
                if (self.orderModel.orderId.length == 0)
                {
                    // 未生成订单 未领取
                    cell.itemPrizeStatus = NoPrizeStatus;
                }
                else
                {
                    if (self.showOrderModel.showOrderId.length == 0)
                    {
                        // 未晒单
                        cell.itemPrizeStatus = GetPrizeStatus;
                    }
                    else
                    {
                        // 已晒单
                        cell.itemPrizeStatus = ShowPrizeStatus;
                    }
                }
                [cell setWinner:self.winnerModel showOrder:self.showOrderModel address:self.addressModel order:self.orderModel];
                return cell;
            }
            else
            {
                HWPriceRecordCell *cell = (HWPriceRecordCell *)[tableView dequeueReusableCellWithIdentifier:@"record_cell"];
                if (!cell)
                {
                    cell = [[HWPriceRecordCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"record_cell"];
                }
                
                HWRecordModel *record = [self.recordList pObjectAtIndex:indexPath.row];
                
                [cell setPriceRecord:record];
                
//                if (record.cutPrice.floatValue < self.winnerModel.cutPrice.floatValue)
//                {
//                    [cell setSamePriceRecord:record];
//                }
                
                cell.selectionStyle = UITableViewCellSelectionStyleNone;
                return cell;
            }
        }
        
        
    }
    else if (indexPath.section == 1)
    {
        
        if (activityMode == ProceedMode)
        {
            if (indexPath.row == 0)
            {
                UITableViewCell *cell = (UITableViewCell *)[tableView dequeueReusableCellWithIdentifier:@"freezen_cell"];
                if (!cell)
                {
                    cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"freezen_cell"];
                    UILabel *timeLab = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, 50)];
                    timeLab.backgroundColor = [UIColor clearColor];
                    timeLab.font = [UIFont fontWithName:FONTNAME size:THEME_FONT_BIG];
                    timeLab.textColor = THEME_COLOR_TEXT;
                    timeLab.textAlignment = NSTextAlignmentCenter;
                    timeLab.tag = 9999;
                    timeLab.text = @"0 天 0 时 0 分 0 秒";
                    [cell.contentView addSubview:timeLab];
                    
                    UIImageView *clockImgV = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"alarmClock"]];
                    clockImgV.center = CGPointMake(65.0f, timeLab.frame.size.height / 2.0f);
                    [cell.contentView addSubview:clockImgV];
                    
                    UIView *line =[[UIView alloc] initWithFrame:CGRectMake(0, 50 - 0.5f, kScreenWidth, 0.5f)];
                    line.backgroundColor = THEME_COLOR_LINE;
                    [cell.contentView addSubview:line];
                }
                UILabel *label = (UILabel *)[cell.contentView viewWithTag:9999];
                
                if (distanceTime > 0)
                {
                    if ((distanceTime - totalTime) > 0)
                    {
                        label.text = [Utility formatTimeDisplay:distanceTime - totalTime];
                    }
                    else if (distanceTime)
                    {
                        [timer invalidate];
                        timer = nil;
                        [self queryListData];
                    }
                }
                else
                {
                    label.text = @"正在开奖中";
                }
                
                
                cell.selectionStyle = UITableViewCellSelectionStyleNone;
                
                return cell;
            }
            else if (indexPath.row == 1)
            {
                UITableViewCell *cell = (UITableViewCell *)[tableView dequeueReusableCellWithIdentifier:@"price_cell22"];
                if (!cell)
                {
                    cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"price_cell22"];
                    
                    UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, 40)];
                    label.backgroundColor = UIColorFromRGB(0xd4d3d1);
                    label.font = [UIFont fontWithName:FONTNAME size:THEME_FONT_BIG - 2];
                    label.textColor = THEME_COLOR_SMOKE;
                    label.tag = 8888;
                    label.textAlignment = NSTextAlignmentCenter;
                    [cell.contentView addSubview:label];
                    
                }
                UILabel *label = (UILabel *)[cell.contentView viewWithTag:8888];
                label.text = [NSString stringWithFormat:@"最新最低唯一价：%@", (self.mobileStr.length == 0 ? @"无" : self.mobileStr)];
                
                cell.selectionStyle = UITableViewCellSelectionStyleNone;
                
                return cell;
            }
        }
        else if (activityMode == EndMode)
        {
            UITableViewCell *cell = (UITableViewCell *)[tableView dequeueReusableCellWithIdentifier:@"liupai_cell"];
            if (!cell)
            {
                cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"liupai_cell"];
                UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, 50)];
                label.backgroundColor = [UIColor clearColor];
                label.font = [UIFont fontWithName:FONTNAME size:THEME_FONT_BIG - 2];
                label.textColor = THEME_COLOR_SMOKE;
                label.textAlignment = NSTextAlignmentCenter;
                label.text = @"没有最低唯一价，该方案流标，已返还手续费";
                [cell.contentView addSubview:label];
                
            }
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
            
            return cell;
        }
        else if (activityMode == NormalEndMode || activityMode == PrizeMode)
        {
            if (indexPath.row == 0)
            {
                UITableViewCell *cell = (UITableViewCell *)[tableView dequeueReusableCellWithIdentifier:@"winner_cell"];
                if (!cell)
                {
                    cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"winner_cell"];
                    UILabel *timeLab = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, 50)];
                    timeLab.backgroundColor = [UIColor clearColor];
                    timeLab.font = [UIFont fontWithName:FONTNAME size:THEME_FONT_BIG];
                    timeLab.textColor = THEME_COLOR_MONEY;
                    timeLab.textAlignment = NSTextAlignmentCenter;
                    timeLab.tag = 9999;
//                    timeLab.text = @"0 天 0 时 0 分 0 秒";
                    [cell.contentView addSubview:timeLab];
                    
                    UIView *line =[[UIView alloc] initWithFrame:CGRectMake(0, 50 - 0.5f, kScreenWidth, 0.5f)];
                    line.backgroundColor = THEME_COLOR_LINE;
                    [cell.contentView addSubview:line];
                }
                UILabel *label = (UILabel *)[cell.contentView viewWithTag:9999];
                
                label.text = [NSString stringWithFormat:@"￥%.2f", self.winnerModel.cutPrice.floatValue];
                cell.selectionStyle = UITableViewCellSelectionStyleNone;
                
                return cell;
            }
            else if (indexPath.row == 1)
            {
                UITableViewCell *cell = (UITableViewCell *)[tableView dequeueReusableCellWithIdentifier:@"user_cell"];
                if (!cell)
                {
                    cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"user_cell"];
                    
                    UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(15, 0, kScreenWidth / 2.0f - 15 - 30, 40)];
                    label.backgroundColor = [UIColor clearColor];
                    label.font = [UIFont fontWithName:FONTNAME size:THEME_FONT_BIG - 2];
                    label.textColor = THEME_COLOR_SMOKE;
                    label.tag = 8888;
                    label.textAlignment = NSTextAlignmentLeft;
                    [cell.contentView addSubview:label];
                    
                    UILabel *timelabel = [[UILabel alloc] initWithFrame:CGRectMake(kScreenWidth / 2.0 - 30, 0, kScreenWidth / 2.0f - 15 + 30, 40)];
                    timelabel.backgroundColor = [UIColor clearColor];
                    timelabel.font = [UIFont fontWithName:FONTNAME size:THEME_FONT_BIG - 2];
                    timelabel.textColor = THEME_COLOR_SMOKE;
                    timelabel.tag = 7777;
                    timelabel.textAlignment = NSTextAlignmentRight;
                    timelabel.adjustsFontSizeToFitWidth = YES;
                    [cell.contentView addSubview:timelabel];
                    
                }
                UILabel *label = (UILabel *)[cell.contentView viewWithTag:8888];
                label.text = [NSString stringWithFormat:@"用户：%@", [Utility securePhoneNumber:self.winnerModel.mobile]];
                
                UILabel *timelabel = (UILabel *)[cell.contentView viewWithTag:7777];
                timelabel.text = [NSString stringWithFormat:@"砍价时间：%@", [Utility getDetailTimeWithTimestamp:self.winnerModel.createTime]];
                
                cell.selectionStyle = UITableViewCellSelectionStyleNone;
                return cell;
            }
        }
    }
    
    return nil;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section == 0)
    {
        if (activityMode == ProceedMode || activityMode == EndMode || activityMode == NormalEndMode)
        {
            if (indexPath.row != self.recordList.count)
            {
                return [HWPriceRecordCell getCellHeight:nil];
            }
            else
            {
                return 65.0f;
            }
        }
        else
        {
            if (indexPath.row == 0)
            {
                PrizeStatus status;
                if (self.orderModel.orderId.length == 0)
                {
                    // 未生成订单 未领取
                    status = NoPrizeStatus;
                }
                else
                {
                    if (self.showOrderModel.showOrderId.length == 0)
                    {
                        // 未晒单
                        status = GetPrizeStatus;
                    }
                    else
                    {
                        // 已晒单
                        status = ShowPrizeStatus;
                    }
                }
                return [HWGetPrizeCell getWinner:self.winnerModel showOrder:self.showOrderModel address:self.addressModel order:self.orderModel prizeStatus:status];
            }
            return [HWPriceRecordCell getCellHeight:nil];
        }
        
    }
    else if (indexPath.section == 1)
    {
        if (indexPath.row == 0)
        {
            return 50;
        }
        else
        {
            return 40;
        }
    }
    return 0;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 30.0f;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, 30.0f)];
    view.backgroundColor = BACKGROUND_COLOR;
    
    UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(15, 0, kScreenWidth - 30, 30.0f)];
    label.textColor = THEME_COLOR_TEXT;
    label.font = [UIFont fontWithName:FONTNAME size:THEME_FONT_SMALL];
    label.backgroundColor = [UIColor clearColor];
    [view addSubview:label];
    
    UIView *line = [[UIView alloc] initWithFrame:CGRectMake(0, 30 - 0.5f, kScreenWidth, 0.5f)];
    line.backgroundColor = THEME_COLOR_LINE;
    [view addSubview:line];
    
    if (section == 0)
    {
        label.text = @"我的出价记录";
    }
    else if (section == 1)
    {
        label.text = @"中奖结果";
    }
    return view;
}

#pragma mark -
#pragma mark            HWGetPrizeCellDelegate

// 领取商品
- (void)didClickGetButton
{
    // &&&&&&
    float total = self.winnerModel.cutPrice.floatValue + self.joinedItem.tax.floatValue * self.joinedItem.marketPrice.floatValue;
    NSString *msg = [NSString stringWithFormat:@"出价%@元\n税费%.2f元（%@*%.0f%%）\n总计：%.2f元",self.winnerModel.cutPrice, (self.joinedItem.tax.floatValue * self.joinedItem.marketPrice.floatValue) ,self.joinedItem.marketPrice, self.joinedItem.tax.floatValue * 100 , total];
    
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"领取商品费用确认" message:msg delegate:self cancelButtonTitle:@"取消" otherButtonTitles:@"确定", nil];
    [alert show];
}

//  晒单
- (void)didCLickShowButton
{
    HWShowOrderViewController *showOrderVC = [[HWShowOrderViewController alloc] init];
    showOrderVC.productID = self.joinedItem.productId;
    [self.navigationController pushViewController:showOrderVC animated:YES];
}

- (void)showToWuDiXianChannel
{
    HWTopicListViewController *topicList = [[HWTopicListViewController alloc] init];
    HWChannelModel *channelModel = [[HWChannelModel alloc]init];
    channelModel.channelId = self.wuDiXianChannelId;
    channelModel.channelName = @"一起无底线";
    channelModel.channelIcon = nil;
    topicList.channelModel = channelModel;
    [self.navigationController pushViewController:topicList animated:YES];
}

#pragma mark -

- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    if (buttonIndex == 1)
    {
        [Utility showMBProgress:self.view message:@"创建订单"];
        HWHTTPRequestOperationManager *manager = [HWHTTPRequestOperationManager cutManager];
        NSMutableDictionary *param = [NSMutableDictionary dictionary];
        [param setPObject:[HWUserLogin currentUserLogin].key forKey:@"key"];
        [param setPObject:@"1" forKey:@"source"];
        [param setPObject:self.joinedItem.productId forKey:@"productId"];
        [param setPObject:self.winnerModel.cutPrice forKey:@"winPrice"];
        [param setPObject:self.joinedItem.tax forKey:@"tax"];
        
        [manager POST:kCreateOrder parameters:param queue:nil success:^(id responseObject) {
            
            NSLog(@"%@",responseObject);
            [Utility hideMBProgress:self.view];
            
            float total = self.winnerModel.cutPrice.floatValue + self.joinedItem.tax.floatValue * self.joinedItem.marketPrice.floatValue;
            
            SurePayController *surePayVC = [[SurePayController alloc] init];
            surePayVC.orderTypeStr = @"1";//1代表商品支付
            if([[HWUserLogin currentUserLogin].totalMoney floatValue] > total)
            {
                surePayVC.isSelectedWalletFlag = @"0";//0代表余额支付
            }
            else
            {
                surePayVC.isSelectedWalletFlag = @"1";//1代表支付宝支付
            }
            NSDictionary *data = [responseObject dictionaryObjectForKey:@"data"];
            if (self.addressModel.addressId.length == 0)
            {
                surePayVC.methodType = noAddressMethod;
            }
            else
            {
                surePayVC.methodType = haveAddressMethod;
            }
            surePayVC.addressModel = self.addressModel;
            surePayVC.objectStr = @"订单支付";
            surePayVC.subObjectStr  = @"订单支付";
            surePayVC.orderId = [data stringObjectForKey:@"id"];
            surePayVC.payMoney = [NSString stringWithFormat:@"%.2f",total];
            [self.navigationController pushViewController:surePayVC animated:YES];
            
        } failure:^(NSString *code, NSString *error) {
            [Utility showToastWithMessage:error inView:self.view];
            [Utility hideMBProgress:self.view];
        }];
    }
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
