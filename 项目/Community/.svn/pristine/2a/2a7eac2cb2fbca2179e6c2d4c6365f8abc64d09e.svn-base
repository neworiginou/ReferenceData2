//
//  HWTreasureViewController.m
//  Community
//
//  Created by caijingpeng.haowu on 14-12-8.
//  Copyright (c) 2014年 caijingpeng. All rights reserved.
//

#import "HWTreasureViewController.h"
#import "HWInputBackView.h"
#import "HWTreatureCell.h"
#import "HWHistoryViewController.h"
#import "HWTreasureRuleViewController.h"
#import "HWRechargeViewController.h"
#import "HWSingleCustomAlertV.h"
#import "HWProductModel.h"
#import "HWRecordModel.h"
#import "HWCustomAlertView.h"
#import "HWPaySuccessViewController.h"
#import "HWForgotMoneyPasswordController.h"
#import "HWJoinedActivityModel.h"

#define GOODS_IMAGE_TAG     2001

#define ALERT_BUY_MONEY     3001
#define ALERT_PASSWORD      3002

@interface HWTreasureViewController ()<UIAlertViewDelegate, HWDAlertDelegate, UITextFieldDelegate>
{
    UIView *tableHeaderView;
    UIScrollView *goodsListSV;
    UITextField *_priceTF;
    int distanceTime;
    
    UILabel *coverTimeLab;
    UILabel *timeLab;
    NSTimer *timer;
    int totalTime;
    NSString *handlingFee;
}

@property (nonatomic, strong) NSMutableArray *goodsList;
@property (nonatomic, strong) HWProductModel *currentGoods;
@property (nonatomic, strong) NSMutableArray *priceList;

@end

@implementation HWTreasureViewController

@synthesize goodsList;
@synthesize currentGoods;
@synthesize priceList;
@synthesize preProductId;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self)
    {
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(cutAgainNotification:) name:CutAgainNotification object:nil];
    }
    return self;
}

- (void)cutAgainNotification:(NSNotification *)notify
{
    NSLog(@"%@", notify.userInfo);
    HWJoinedActivityModel *joinedItem = notify.object;
    int i;
    for (i = 0; i < goodsList.count; i++)
    {
        HWProductModel *product = [goodsList pObjectAtIndex:i];
        if ([product.productId isEqualToString:joinedItem.productId])
        {
            break;
        }
    }
    
    if (i < goodsList.count)
    {
        float itemSize = 65.0f;
        float gap = 10.0f;
        float marginLeft = kScreenWidth / 2.0f - itemSize / 2.0f;
        NSLog(@"%f",marginLeft);
        [goodsListSV setContentOffset:CGPointMake(i * (itemSize + gap), 0) animated:YES];
        
        self.currentGoods = [self.goodsList pObjectAtIndex:i];
//        [self queryListData];
    }
    
    self.isCustomAlertShowing = NO;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.navigationItem.titleView = [Utility navTitleView:@"无底线"];
    self.navigationItem.leftBarButtonItem = [Utility navLeftBackBtn:self action:@selector(backMethod)];
    self.navigationItem.rightBarButtonItem = [Utility navButton:self title:@"历史" action:@selector(toHistory:)];
//    tableHeaderView = [UITableView]
    self.baseTableView.frame = CGRectMake(0, 85, kScreenWidth, CONTENT_HEIGHT - 85.0f - 20);
    self.baseTableView.hidden = YES;
    [self showEmpty:@"暂无活动"];
    
    UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(0, CGRectGetMaxY(self.baseTableView.frame), kScreenWidth, 20)];
    label.textColor = THEME_COLOR_TEXT;
    label.backgroundColor = [UIColor clearColor];
    label.font = [UIFont fontWithName:FONTNAME size:THEME_FONT_SUPERSMALL];
    label.textAlignment = NSTextAlignmentRight;
    label.adjustsFontSizeToFitWidth = YES;
    label.text = @"苹果公司（Apple.Inc）并非活动赞助商，活动产生的任何影响均和苹果公司（Apple.Inc）无关。";
    [self.view addSubview:label];
}

- (void)viewWillAppear:(BOOL)animated
{
    [self queryListData];
    MLNavigationController *navigation = (MLNavigationController *)self.navigationController;
    navigation.canDragBack = NO;
}

- (void)viewWillDisappear:(BOOL)animated
{
    if (timer != nil)
    {
        [timer invalidate];
        timer = nil;
        totalTime = 0;
    }
    MLNavigationController *navigation = (MLNavigationController *)self.navigationController;
    navigation.canDragBack = YES;
}

/*
    获取商品列表
 */
- (void)queryListData
{
    
    HWUserLogin *user = [HWUserLogin currentUserLogin];
    HWHTTPRequestOperationManager *manage = [HWHTTPRequestOperationManager cutManager];
    
    NSMutableDictionary *param = [NSMutableDictionary dictionary];
    [param setPObject:user.key forKey:@"key"];
    [param setPObject:@"1" forKey:@"source"];
    if (self.currentGoods != nil)
    {
        [param setPObject:self.currentGoods.productId forKey:@"productId"];
    }
    
    [manage POST:kGoodsList parameters:param queue:nil success:^(id responseObject) {
        
        NSArray *array = [[responseObject dictionaryObjectForKey:@"data"] arrayObjectForKey:@"productDtoList"];
        self.goodsList = [NSMutableArray array];
        for (int i = 0; i < array.count; i++)
        {
            NSDictionary *dic = [array pObjectAtIndex:i];
            [self.goodsList addObject:[[HWProductModel alloc] initWithProductInfo:dic]];
        }
        
        if (self.goodsList.count > 0 && self.currentGoods == nil)
        {
            if (self.preProductId != nil)
            {
                for (int i = 0; i < self.goodsList.count; i++)
                {
                    HWProductModel *defaultGood = [self.goodsList pObjectAtIndex:i];
                    if ([defaultGood.productId isEqualToString:self.preProductId])
                    {
                        self.currentGoods = defaultGood;
                        break;
                    }
                }
            }
            
            if (self.currentGoods == nil)
            {
                self.currentGoods = [self.goodsList pObjectAtIndex:0];
            }
            
            [self initialTopScrollView];
        }
        
        if (self.goodsList.count > 0)
        {
            NSArray *recordArr = [[responseObject dictionaryObjectForKey:@"data"] arrayObjectForKey:@"cutLowGuessPriceAssembleDtoList"];
            self.priceList = [NSMutableArray array];
            
            for (int i = 0; i < recordArr.count; i++)
            {
                NSDictionary *dic = [recordArr pObjectAtIndex:i];
                [self.priceList addObject:[[HWRecordModel alloc] initWithRecord:dic]];
            }
            [self hideEmpty];
            
            self.baseTableView.hidden = NO;
            
            [self initialTableViewHeader];
            [self.baseTableView reloadData];
            
            [self queryActivityTime];
        }
        else
        {
            [self showEmpty:@"暂无活动"];
        }
        
    } failure:^(NSString *code, NSString *error) {
        
        NSLog(@"error %@",error);
    }];
    
//    [self queryGoodsDetailInfo];
}

- (void)queryActivityTime
{
    [Utility showMBProgress:self.view message:@"加载中"];
    
    HWUserLogin *user = [HWUserLogin currentUserLogin];
    HWHTTPRequestOperationManager *manage = [HWHTTPRequestOperationManager cutManager];
    
    NSMutableDictionary *param = [NSMutableDictionary dictionary];
    [param setPObject:user.key forKey:@"key"];
    [param setPObject:self.currentGoods.productId forKey:@"productId"];
    [param setPObject:@"1" forKey:@"source"];
    
    if (self.currentGoods.productStatus.intValue == 0)
    {
        // 未开始
        [manage POST:kStartDistance parameters:param queue:nil success:^(id responseObject) {
            
            NSLog(@"%@",responseObject);
            [Utility hideMBProgress:self.view];
            NSString *time = [responseObject stringObjectForKey:@"data"];
            distanceTime = time.intValue / 1000;
//            distanceTime = 5;
            
            if (distanceTime >= 0)
            {
                coverTimeLab.text = [Utility formatTimeDisplay:distanceTime];
                
                [self initialTableViewHeader];
                
                if (timer != nil)
                {
                    totalTime = 0;
                    [timer invalidate];
                    timer = nil;
                }
                [self countDown];
                timer = [NSTimer scheduledTimerWithTimeInterval:1.0f target:self selector:@selector(countDown) userInfo:nil repeats:YES];
            }
            
        } failure:^(NSString *code, NSString *error) {
            
            [Utility hideMBProgress:self.view];
            [Utility showToastWithMessage:error inView:self.view];
        }];
    }
    else if (self.currentGoods.productStatus.intValue == 1)
    {
        // 进行中
        [manage POST:kEndDistance parameters:param queue:nil success:^(id responseObject) {
            
            NSLog(@"%@",responseObject);
            [Utility hideMBProgress:self.view];
            NSString *time = [responseObject stringObjectForKey:@"data"];
            distanceTime = time.intValue / 1000;
//            distanceTime = 5;
            
            if (distanceTime >= 0)
            {
                timeLab.text = [Utility format2TimeDisplay:distanceTime];
                
                if (timer != nil)
                {
                    totalTime = 0;
                    [timer invalidate];
                    timer = nil;
                }
                [self initialTableViewHeader];
                
                [self countDown];
                timer = [NSTimer scheduledTimerWithTimeInterval:1.0f target:self selector:@selector(countDown) userInfo:nil repeats:YES];
            }
            
        } failure:^(NSString *code, NSString *error) {
            [Utility hideMBProgress:self.view];
            [Utility showToastWithMessage:error inView:self.view];
        }];
    }
    else
    {
        [Utility hideMBProgress:self.view];
    }
    
}

- (void)countDown
{
    totalTime++;
//    NSLog(@"total %d",distanceTime - totalTime);
    [Utility hideMBProgress:self.view];
    
    if (distanceTime - totalTime < 0)
    {
        totalTime = 0;
        [timer invalidate];
        timer = nil;
        if (![self.currentGoods.productStatus isEqualToString:@"1"])
        {
            self.currentGoods.productStatus = @"1";
            [self queryActivityTime];
        }
        else
        {// 进行中  活动结束
            self.currentGoods.productStatus = @"4";
            [self initialTableViewHeader];
            [self.baseTableView reloadData];
        }
        
    }
    
    if (self.currentGoods.productStatus.intValue == 0)
    {
        int time = distanceTime - totalTime;
        coverTimeLab.text = [Utility formatTimeDisplay:(time > 0 ? time : 0)];
    }
    else if (self.currentGoods.productStatus.intValue == 1)
    {
        int time = distanceTime - totalTime;
        timeLab.text = [Utility format2TimeDisplay:(time > 0 ? time : 0)];
    }
    
    
}

- (void)toHistory:(id)sender
{
    [MobClick event:@"click_view bargain history"];
    
    HWHistoryViewController *historyVC = [[HWHistoryViewController alloc] init];
    historyVC.popToViewController = self;
    [self.navigationController pushViewController:historyVC animated:YES];
}

- (void)toTreasureRule:(id)sender
{
    HWTreasureRuleViewController *ruleVC = [[HWTreasureRuleViewController alloc] init];
    ruleVC.isAgree = NO;
    [self.navigationController pushViewController:ruleVC animated:YES];
}

#warning 绑定手机号  砍价
- (void)toPay:(id)sender
{
    if ([HWUserLogin verifyBindMobileWithPopVC:self showAlert:YES])
    {
        [MobClick event:@"click_partake in bargain"];
        //  判断 余额是否充足
        if (_priceTF.text.length == 0)
        {
            [Utility showToastWithMessage:@"请输入砍价金额" inView:self.view];
            [_priceTF becomeFirstResponder];
            return;
        }
        
        if (_priceTF.text.floatValue <= 0)
        {
            [Utility showToastWithMessage:@"砍价金额应大于0" inView:self.view];
            [_priceTF becomeFirstResponder];
            return;
        }
        
        [self queryHandlingFee];
    }
    
}

/*
 获取出价列表
 */

//- (void)queryRecordList
//{
//    [Utility showMBProgress:self.view message:@"加载中"];
//    
//    HWUserLogin *user = [HWUserLogin currentUserLogin];
//    HWHTTPRequestOperationManager *manage = [HWHTTPRequestOperationManager manager];
//    NSMutableDictionary *dict = [[NSMutableDictionary alloc] init];
//    [dict setPObject:user.key forKey:@"key"];
//    [dict setPObject:@"1" forKey:@"source"];
//    [dict setPObject:self.currentGoods.productId forKey:@"productId"];
//    
//    [manage POST:kCutRecord parameters:dict queue:nil success:^(id responseObject) {
//        
//        [Utility hideMBProgress:self.view];
//        
//        
//    } failure:^(NSString *error) {
//        [Utility hideMBProgress:self.view];
//        [Utility showToastWithMessage:error inView:self.view];
//    }];
//}

- (void)queryRemaindMoney
{
    [Utility showMBProgress:self.view message:@"发送中"];
    [_priceTF resignFirstResponder];
    HWUserLogin *user = [HWUserLogin currentUserLogin];
    HWHTTPRequestOperationManager *manage = [HWHTTPRequestOperationManager accountManager];
    NSMutableDictionary *dict = [[NSMutableDictionary alloc] init];
    [dict setPObject:user.key forKey:@"key"];
    [dict setPObject:user.userId forKey:@"userId"];
    [dict setPObject:handlingFee forKey:@"payMoney"];
    
    [manage POST:kRemainMoney parameters:dict queue:nil success:^(id responseObject) {
        
        NSLog(@"response %@", responseObject);
        
        [Utility hideMBProgress:self.view];
        
        
        
        
        
        NSString *result = [responseObject stringObjectForKey:@"data"];
        /*
         0 : 账户余额充足
         1 : 账户余额不够
         2 : 您的考拉币账户被冻结
         3 : 您还没有考拉币账户
         */
        NSLog(@"%f",_priceTF.text.doubleValue);
        if (result.intValue == 0)
        {
            
            NSString *isSetPass = [responseObject stringObjectForKey:@"isSetPass"];
            if ([isSetPass isEqualToString:@"1"])
            {
                // 已设置提现密码
            }
            else
            {
                // 未设置提现密码
                UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"提示" message:@"未设置提现密码" delegate:self cancelButtonTitle:@"取消" otherButtonTitles:@"设置", nil];
                alert.tag = ALERT_PASSWORD;
                [alert show];
                
                return ;
            }
            
            if (!self.isCustomAlertShowing)
            {
                HWCustomAlertView *alert = [HWCustomAlertView alertWithMoneyAmount:_priceTF.text.doubleValue handleFee:handlingFee];
                alert.delegate = self;
                [alert show];
                self.isCustomAlertShowing = YES;
            }
        }
        else if (result.intValue == 1 || result.intValue == 3)
        {
            NSString *message = [NSString stringWithFormat:@"您的考拉币剩%@，\n手续费需要%@个考拉币",[responseObject stringObjectForKey:@"amount"],handlingFee];
            UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"考拉币不足" message:message delegate:self cancelButtonTitle:@"取消" otherButtonTitles:@"购买考拉币", nil];
            alert.tag = ALERT_BUY_MONEY;
            [alert show];
        }
        else if (result.intValue == 2)
        {
            [Utility showAlertWithMessage:@"您的考拉币账户被冻结"];
        }
        
        
    } failure:^(NSString *code, NSString *error) {
        [Utility hideMBProgress:self.view];
        [Utility showToastWithMessage:error inView:self.view];
        NSLog(@"error %@",error);
        
    }];
}

- (void)queryHandlingFee
{
    [Utility showMBProgress:self.view message:@"发送中"];
    
    HWUserLogin *user = [HWUserLogin currentUserLogin];
    HWHTTPRequestOperationManager *manage = [HWHTTPRequestOperationManager cutManager];
    NSMutableDictionary *dict = [[NSMutableDictionary alloc] init];
    [dict setPObject:user.key forKey:@"key"];
    [dict setPObject:self.currentGoods.productId forKey:@"productId"];
    [dict setPObject:_priceTF.text forKey:@"cutPrice"];
    [dict setPObject:@"1" forKey:@"source"];
    
    [manage POST:kHandlingFee parameters:dict queue:nil success:^(id responseObject) {
        
        [Utility hideMBProgress:self.view];
        handlingFee = [responseObject stringObjectForKey:@"data"];
        
        [self queryRemaindMoney];
        
    } failure:^(NSString *code, NSString *error) {
        [Utility hideMBProgress:self.view];
        [Utility showAlertWithMessage:error];
//        [Utility showToastWithMessage:error inView:self.view];
    }];
}

- (void)scrollToGoodsItem:(UITapGestureRecognizer *)sender
{
    UIImageView *goodsItem = (UIImageView *)sender.view;
    
    [self scrollToGoodsByImgV:goodsItem];
    
    self.currentGoods = [self.goodsList pObjectAtIndex:(goodsItem.tag - GOODS_IMAGE_TAG)];
    [self queryListData];
}

- (void)scrollToGoodsByImgV:(UIImageView *)itemImgV
{
    float itemSize = 65.0f;
    float marginLeft = kScreenWidth / 2.0f - itemSize / 2.0f;
    [goodsListSV setContentOffset:CGPointMake(itemImgV.frame.origin.x - marginLeft, 0) animated:YES];
}

- (void)initialTableViewHeader
{
    tableHeaderView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, 340)];
    
    
    
//    if (self.goodsList.count != 0)
//    {
        [self initialGoodsInfoView];
//    }

    self.baseTableView.tableHeaderView = tableHeaderView;
}

- (void)initialGoodsInfoView
{
    UIView *infoBack = [[UIView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, 340)];
    infoBack.backgroundColor = [UIColor clearColor];
    [tableHeaderView addSubview:infoBack];
    
    UIView *imgBackView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, 150)];
    imgBackView.backgroundColor = UIColorFromRGB(0xf4f4f4);
//    imgBackView.backgroundColor = [UIColor redColor];
    [infoBack addSubview:imgBackView];
    
    UIImageView *imageView = [[UIImageView alloc] initWithFrame:imgBackView.bounds];
    imageView.contentMode = UIViewContentModeScaleAspectFit;
    imageView.backgroundColor = IMAGE_DEFAULT_COLOR;
//    imageView.image = [UIImage imageNamed:@"placeImage"];
    
    __weak UIImageView *weakImgV = imageView;
    [imageView setImageWithURL:[NSURL URLWithString:[Utility imageDownloadUrl:self.currentGoods.bigImg]] placeholderImage:[UIImage imageNamed:IMAGE_PLACE] completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType) {
        
        if (error != nil)
        {
            weakImgV.image = [UIImage imageNamed:IMAGE_BREAK_CUBE];
        }
        else
        {
            weakImgV.image = image;
        }
        
    }];
    [imgBackView addSubview:imageView];
    
    if (self.currentGoods.productStatus.intValue == 0)
    {
        // 未开始
        
        UIView *coverView = [[UIView alloc] initWithFrame:imgBackView.bounds];
        coverView.backgroundColor = [UIColor colorWithWhite:0 alpha:0.3f];
        [imgBackView addSubview:coverView];
        
        UILabel *coverTitLab = [[UILabel alloc] initWithFrame:CGRectMake(0, 45, coverView.frame.size.width, 20)];
        coverTitLab.backgroundColor = [UIColor clearColor];
        coverTitLab.font = [UIFont fontWithName:FONTNAME size:THEME_FONT_SMALL];
        coverTitLab.textColor = [UIColor whiteColor];
        coverTitLab.text = @"   活动开始倒计时";
        coverTitLab.textAlignment = NSTextAlignmentCenter;
        [imgBackView addSubview:coverTitLab];
        
        UIImageView *clockImgV = [[UIImageView alloc] initWithFrame:CGRectMake(kScreenWidth / 2.0f - 65.0f, CGRectGetMinY(coverTitLab.frame) + 3, 14, 14)];
        clockImgV.image = [UIImage imageNamed:@"countdown"];
        [imgBackView addSubview:clockImgV];
        
        coverTimeLab = [[UILabel alloc] initWithFrame:CGRectMake(0, CGRectGetMaxY(coverTitLab.frame) + 5, coverView.frame.size.width, 25)];
        coverTimeLab.backgroundColor = [UIColor clearColor];
        coverTimeLab.font = [UIFont fontWithName:FONTNAME size:THEME_FONT_SMALL + 3];
        coverTimeLab.textColor = [UIColor whiteColor];
        coverTimeLab.text = @"";
        coverTimeLab.textAlignment = NSTextAlignmentCenter;
        [imgBackView addSubview:coverTimeLab];
    }
    else if (self.currentGoods.productStatus.intValue == 1)
    {
        // 进行中
        
        UIView *timeView = [[UIView alloc] initWithFrame:CGRectMake(kScreenWidth - 125 - 15,
                                                                    CGRectGetHeight(imgBackView.frame) - 35,
                                                                    125,
                                                                    25)];
        timeView.layer.cornerRadius = 12.5f;
        timeView.layer.borderColor = THEME_COLOR_LINE.CGColor;
        timeView.layer.borderWidth = 0.5f;
        timeView.backgroundColor = UIColorFromRGB(0xfefefe);
        timeView.layer.shadowColor = [UIColor blackColor].CGColor;
        timeView.layer.shadowOffset = CGSizeMake(0, 3);
        timeView.layer.shadowRadius = 1;
        timeView.layer.shadowOpacity = 0.1f;
        [imgBackView addSubview:timeView];
        
        UIImageView *clockImgV = [[UIImageView alloc] initWithFrame:CGRectMake(10, (CGRectGetHeight(timeView.frame) - 14) / 2.0f, 14, 14)];
        clockImgV.image = [UIImage imageNamed:@"countdown"];
        [timeView addSubview:clockImgV];
        
        timeLab = [[UILabel alloc] initWithFrame:CGRectMake(CGRectGetMaxX(clockImgV.frame), 0, CGRectGetWidth(timeView.frame) - CGRectGetMaxX(clockImgV.frame) - 5, 23)];
        timeLab.backgroundColor = [UIColor clearColor];
        timeLab.textAlignment = NSTextAlignmentCenter;
        timeLab.textColor = THEME_COLOR_TEXT;
        timeLab.font = [UIFont fontWithName:FONTNAME size:12.0f];
        timeLab.text = @"0天 0：0：0";
        timeLab.text = [Utility format2TimeDisplay:distanceTime];
        [timeView addSubview:timeLab];
    }
    
    
    
    NSString *infoStr = [NSString stringWithFormat:@"%@\n%@", self.currentGoods.productName, self.currentGoods.remark];
    UIFont *font = [UIFont fontWithName:FONTNAME size:13];
    CGSize infoSize = [Utility calculateStringHeight:infoStr font:font constrainedSize:CGSizeMake(kScreenWidth - 15, 10000)];
    
    HWInputBackView *infoView = [[HWInputBackView alloc] initWithFrame:CGRectMake(0, CGRectGetMaxY(imgBackView.frame), kScreenWidth, infoSize.height + 20)];
    infoView.backgroundColor = [UIColor whiteColor];
    [infoBack addSubview:infoView];
    
    UILabel *infoLab = [[UILabel alloc] initWithFrame:CGRectMake(15, 10, kScreenWidth - 30, infoSize.height)];
    infoLab.numberOfLines = 0;
    infoLab.lineBreakMode = NSLineBreakByWordWrapping;
    infoLab.font = font;
    infoLab.textColor = THEME_COLOR_GRAY_MIDDLE;
    infoLab.backgroundColor = [UIColor clearColor];
    infoLab.text = infoStr;
    [infoView addSubview:infoLab];
    
    UIView *infoLine = [[UIView alloc] initWithFrame:CGRectMake(0, CGRectGetHeight(infoView.frame) - 0.5f, kScreenWidth, 0.5f)];
    infoLine.backgroundColor = THEME_COLOR_LINE;
    [infoView addSubview:infoLine];
    
    
    HWInputBackView *priceBackView = [[HWInputBackView alloc] initWithFrame:CGRectMake(0, CGRectGetMaxY(infoView.frame) + 10, kScreenWidth, 45.0f)];
    priceBackView.backgroundColor = [UIColor whiteColor];
    [infoBack addSubview:priceBackView];
    
    UILabel *priceTitLab = [[UILabel alloc] initWithFrame:CGRectMake(15, 0, 45.0f, 45.0f)];
    priceTitLab.backgroundColor = [UIColor clearColor];
    priceTitLab.font = [UIFont fontWithName:FONTNAME size:15.0f];
    priceTitLab.textColor = THEME_COLOR_SMOKE;
    priceTitLab.text = @"价格：";
    [priceBackView addSubview:priceTitLab];
    
    _priceTF = [[UITextField alloc] initWithFrame:CGRectMake(CGRectGetMaxX(priceTitLab.frame), 3, kScreenWidth - CGRectGetMaxX(priceTitLab.frame) - 50, 40)];
    //changed by niedi 20141218
    _priceTF.contentVerticalAlignment = UIControlContentVerticalAlignmentCenter;
    if (self.currentGoods.lowestPrice.floatValue == 0)
    {
        _priceTF.placeholder = [NSString stringWithFormat:@"输入最低夺宝价"];
    }
    else
    {
        _priceTF.placeholder = [NSString stringWithFormat:@"输入最低%.2f的夺宝价", self.currentGoods.lowestPrice.floatValue];
    }
    _priceTF.backgroundColor = [UIColor clearColor];
    _priceTF.font = [UIFont fontWithName:FONTNAME size:13];
    _priceTF.keyboardType = UIKeyboardTypeDecimalPad;
    _priceTF.delegate = self;
    [priceBackView addSubview:_priceTF];
    
    UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
    btn.frame = CGRectMake(kScreenWidth - 50, 0, 50, 45);
    btn.backgroundColor = [UIColor clearColor];
    [btn setImage:[UIImage imageNamed:@"doubt"] forState:UIControlStateNormal];
    [btn addTarget:self action:@selector(toTreasureRule:) forControlEvents:UIControlEventTouchUpInside];
    [priceBackView addSubview:btn];
    
    UIButton *priceBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [priceBtn setTitle:@"砍价" forState:UIControlStateNormal];
    priceBtn.frame = CGRectMake(15, CGRectGetMaxY(priceBackView.frame) + 15, kScreenWidth - 30, 45);
    
    [priceBtn addTarget:self action:@selector(toPay:) forControlEvents:UIControlEventTouchUpInside];
    [infoBack addSubview:priceBtn];
    
    if (self.currentGoods.productStatus.intValue == 1)
    {
        [priceBtn setButtonOrangeStyle];
        priceBtn.userInteractionEnabled = YES;
    }
    else
    {
        [priceBtn setButtonGrayStyle];
        priceBtn.userInteractionEnabled = NO;
    }
    
    
    CGRect infoBackFrame = infoBack.frame;
    infoBackFrame.size.height = CGRectGetMaxY(priceBtn.frame) + 15;
    infoBack.frame = infoBackFrame;
    
    tableHeaderView.frame = CGRectMake(0, 0, kScreenWidth, CGRectGetHeight(infoBack.frame));
}

- (void)initialTopScrollView
{
    int goodsCount = self.goodsList.count;
    float itemSize = 65.0f;
    float marginLeft = kScreenWidth / 2.0f - itemSize / 2.0f;
    float gap = 10.0f;
    
    if (goodsListSV != nil)
    {
        [goodsListSV removeFromSuperview];
        goodsListSV = nil;
    }
    
    goodsListSV = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, 85)];
    goodsListSV.contentSize = CGSizeMake(itemSize * goodsCount + (goodsCount - 1) * gap + 2 * marginLeft, goodsListSV.frame.size.height);
    goodsListSV.backgroundColor = [UIColor whiteColor];
    goodsListSV.delegate = self;
    goodsListSV.showsHorizontalScrollIndicator = NO;
    [self.view addSubview:goodsListSV];
    
//    UIView *whiteView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, 80)];
//    whiteView.backgroundColor = [UIColor whiteColor];
//    [goodsListSV addSubview:whiteView];
    
    UIImageView *scrollToImgV;
    
    for (int i = 0; i < goodsCount; i++)
    {
        HWProductModel *product = [self.goodsList pObjectAtIndex:i];
        
        UIImageView *imgV = [[UIImageView alloc] initWithFrame:CGRectMake(marginLeft + (itemSize + gap) * i, gap, itemSize, itemSize)];
        imgV.backgroundColor = [UIColor whiteColor];
        imgV.layer.cornerRadius = 3.0f;
        imgV.layer.borderColor = THEME_COLOR_LINE.CGColor;
        imgV.layer.borderWidth = 0.5f;
        imgV.userInteractionEnabled = YES;
        [goodsListSV addSubview:imgV];
        
        imgV.tag = GOODS_IMAGE_TAG + i;
        
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(scrollToGoodsItem:)];
        [imgV addGestureRecognizer:tap];
        
        __weak UIImageView *weakImgV = imgV;
        
        NSLog(@"%@",[Utility imageDownloadUrl:product.smallImg]);
        
        [imgV setImageWithURL:[NSURL URLWithString:[Utility imageDownloadUrl:product.smallImg]] placeholderImage:[UIImage imageNamed:IMAGE_PLACE] completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType) {
            if (error != nil)
            {
                weakImgV.image = [UIImage imageNamed:IMAGE_BREAK_CUBE];
            }
            else
            {
                weakImgV.image = image;
            }
        }];
        
        int freezenTime = product.endTime.intValue - product.startTime.intValue;
//        NSString *freezenTime = [NSString stringWithFormat:@"%d",product.endTime.intValue - product.startTime.intValue];
        NSLog(@"%d",freezenTime);
        if (freezenTime > 0)
        {
            
        }
        else
        {
            
        }
        
        if ([product.productId isEqualToString:self.currentGoods.productId])
        {
            scrollToImgV = imgV;
        }
    }
    
    if (scrollToImgV != nil)
    {
        [self scrollToGoodsByImgV:scrollToImgV];
    }
    
    UIImageView *blockImgV = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, itemSize + 2.0f, itemSize + 2.0f)];
    blockImgV.center = goodsListSV.center;
    blockImgV.backgroundColor = [UIColor clearColor];
    blockImgV.layer.borderWidth = 2.0f;
    blockImgV.layer.borderColor = THEME_COLOR_ORANGE.CGColor;
    blockImgV.layer.cornerRadius = 3.0f;
    [self.view addSubview:blockImgV];
    
    // ***  新增 当前商品指引箭头
    
    UIView *arrowView = [[UIView alloc] initWithFrame:CGRectMake(0, CGRectGetMaxY(goodsListSV.frame), kScreenWidth, 7)];
    arrowView.backgroundColor = [UIColor clearColor];
    [self.view addSubview:arrowView];
    
    UIView *leftView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, (kScreenWidth - 13.0f) / 2.0f, 7)];
    leftView.backgroundColor = [UIColor whiteColor];
    leftView.layer.masksToBounds = NO;
    leftView.layer.shadowColor = [UIColor blackColor].CGColor;
    leftView.layer.shadowOffset = CGSizeMake(0.0f, 5.0f);
    leftView.layer.shadowOpacity = 0.2f;
    leftView.layer.shadowRadius = 3;
    [arrowView addSubview:leftView];
    
    UIView *rightView = [[UIView alloc] initWithFrame:CGRectMake((kScreenWidth + 13.5f) / 2.0f, 0, (kScreenWidth - 13.5f) / 2.0f, 7)];
    rightView.backgroundColor = [UIColor whiteColor];
    rightView.layer.masksToBounds = NO;
    rightView.layer.shadowColor = [UIColor blackColor].CGColor;
    rightView.layer.shadowOffset = CGSizeMake(0.0f, 5.0f);
    rightView.layer.shadowOpacity = 0.2f;
    rightView.layer.shadowRadius = 3;
    [arrowView addSubview:rightView];
    
    UIImageView *arrowImgV = [[UIImageView alloc] initWithFrame:CGRectMake((kScreenWidth - 13.5f) / 2.0f, 0, 13.5f, 7)];
    arrowImgV.image = [UIImage imageNamed:@"cutArrow"];
    arrowImgV.layer.masksToBounds = YES;
    [arrowView addSubview:arrowImgV];
    
    
}

- (void)scrollViewWillBeginDragging:(UIScrollView *)scrollView{

    [_priceTF resignFirstResponder];
}

- (void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate
{
    [super scrollViewDidEndDragging:scrollView willDecelerate:YES];
    if (scrollView == goodsListSV)
    {
        if (!decelerate)
        {
            [self scrollToItem:scrollView];
        }
    }
    
}

- (void)scrollToItem:(UIScrollView *)scrollView
{
//    int goodsCount = 10;
    float itemSize = 65.0f;
//    float marginLeft = kScreenWidth / 2.0f - itemSize / 2.0f;
    float gap = 10.0f;
    
    float step = 0;
    
    do{
        if (step >= scrollView.contentOffset.x)
        {
            break;
        }
        
    }while (step += itemSize + gap);
    
    if ((step - scrollView.contentOffset.x) > itemSize / 2.0f)
    {
        step -= itemSize + gap;
    }
    
    [scrollView setContentOffset:CGPointMake(step, 0) animated:YES];
    
    self.currentGoods = [self.goodsList pObjectAtIndex:(step / (itemSize + gap))];
    [self queryListData];
}

- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView
{
    if (scrollView == goodsListSV)
    {
        [self scrollToItem:scrollView];
    }
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return (self.priceList.count + 1);
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.row == 0)
    {
        return 38.0f;
    }
    else
        return [HWTreatureCell getCellHeight:[self.priceList pObjectAtIndex:(indexPath.row - 1)]];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.row == 0)
    {
        UITableViewCell *sysCell = [tableView dequeueReusableCellWithIdentifier:@"sysCell"];
        if (!sysCell)
        {
            
            sysCell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"sysCell"];
            sysCell.backgroundColor = THEME_COLOR_TEXTBACKGROUND;
            UIImageView *imgShop = [[UIImageView alloc] initWithFrame:CGRectMake(15, 0, 21, 21)];
            [imgShop setImage:[UIImage imageNamed:@"history"]];
            [sysCell.contentView addSubview:imgShop];
            
            UILabel *labShop = [[UILabel alloc] initWithFrame:CGRectMake(40, 0, 200, 21)];
            [labShop setBackgroundColor:[UIColor clearColor]];
            [labShop setText:@"我的砍价记录"];
            [labShop setTextColor:THEME_COLOR_SMOKE];
            [labShop setFont:[UIFont fontWithName:FONTNAME size:THEME_FONT_SMALL]];
            labShop.tag = 999;
            [sysCell.contentView addSubview:labShop];
            
            UILabel *line = [[UILabel alloc] initWithFrame:CGRectMake(25, CGRectGetMaxY(imgShop.frame), 1, 38 - CGRectGetMaxY(imgShop.frame))];
            [line setBackgroundColor:THEME_COLOR_LINE];
            [sysCell.contentView addSubview:line];
            sysCell.userInteractionEnabled = NO;
        }
        
        UILabel *labShop = (UILabel *)[sysCell.contentView viewWithTag:999];
        if (labShop != nil)
        {
            if (self.priceList.count == 0)
            {
                //change by NieDi
                [labShop setText:@"无砍价记录~"];
                //            if (![sysCell.contentView viewWithTag:888])
                //            {
                //                UILabel *labUnRecord = [[UILabel alloc] initWithFrame:CGRectMake(labShop.frame.origin.x, CGRectGetMaxY(labShop.frame), 200, 21)];
                //                [labUnRecord setBackgroundColor:[UIColor clearColor]];
                //                [labUnRecord setText:@"无砍价记录~"];
                //                [labUnRecord setTag:888];
                //                [labUnRecord setTextColor:THEME_COLOR_SMOKE];
                //                [labUnRecord setFont:[UIFont fontWithName:FONTNAME size:THEME_FONT_SMALL]];
                //                [sysCell.contentView addSubview:labUnRecord];
                //            }
            }
            else
            {
                [labShop setText:@"我的砍价记录"];
                //            UILabel *labUnRecord = (UILabel *)[sysCell.contentView viewWithTag:888];
                //            if (labUnRecord) {
                //                [labUnRecord removeFromSuperview];
                //            }
            }
        }
        return sysCell;
    }
    else
    {
        HWTreatureCell *cell = (HWTreatureCell *)[tableView dequeueReusableCellWithIdentifier:@"cell"];
        if (!cell)
        {
            cell = [[HWTreatureCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"cell"];
        }
        [cell setTreatureInfo:[self.priceList pObjectAtIndex:(indexPath.row - 1)]];
        cell.userInteractionEnabled = NO;
        return cell;
    }
    return nil;
}

#pragma mark -
#pragma mark        UITextFieldDelegate

- (BOOL)textFieldShouldBeginEditing:(UITextField *)textField
{
    [self.baseTableView setContentOffset:CGPointMake(0, 150)];
    return YES;
}

- (BOOL)textFieldShouldEndEditing:(UITextField *)textField
{
    [self.baseTableView setContentOffset:CGPointMake(0, 0)];
    return YES;
}

- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string
{
    NSMutableString *text = [textField.text mutableCopy];
    [text replaceCharactersInRange:range withString:string];
    
    NSString *decimal = [[text componentsSeparatedByString:@"."] pObjectAtIndex:1];
    if (text.length > 9 && range.length == 0)
    {
        return NO;
    }
    else if(decimal.length > 2 || [text componentsSeparatedByString:@"."].count > 2)
    {
        return NO;
    }
    else if ([text hasPrefix:@"."])
    {
        return NO;
    }
        
    
    return YES;
}

#pragma mark -
#pragma mark        UIAlertViewDelegate

- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    
    if (alertView.tag == ALERT_BUY_MONEY)
    {
        if (buttonIndex == 1)
        {
            // 购买考拉币
            
            HWRechargeViewController *rechargeVC = [[HWRechargeViewController alloc] init];
            [self.navigationController pushViewController:rechargeVC animated:YES];
        }
    }
    else if (alertView.tag == ALERT_PASSWORD)
    {
        if (buttonIndex == 1)
        {
            HWForgotMoneyPasswordController *setMoneyPwdVC = [[HWForgotMoneyPasswordController alloc] init];
            setMoneyPwdVC.navigationItem.titleView = [Utility navTitleView:@"设置提现密码"];
            setMoneyPwdVC.popToController = self;
            [self.navigationController pushViewController:setMoneyPwdVC animated:YES];
        }
    }
}

#pragma mark -
#pragma mark        HWCustomAlertViewDelegate
- (void)alertView:(HWDAlert *)alertView secretStr:(NSString *)secret
{
    // 核对密码 跳转支付 已知 secret.length == 6;
    
    /*
     Url:cutLow/guess.do?
     入参:
     amt=猜价
     productId=商品ID
     ae=加密的支付密码
     mobileNumber=手机号码
     source=用户来源
     userId=用户ID
     fee=手续费
     key=43bb4024-fa39-49d0-8138-6c05f17d3307
     返回结果:
     {"status":"1","data":
     {"productId":商品ID,"cutPrice":砍价,"createTime":1418571380000,"samePriceTimes":相同次数,"isLowest":1是否最低,"uniqueLowerTimes":更低唯一价次数}
     ,"detail":"请求数据成功!","key":"43bb4024-fa39-49d0-8138-6c05f17d3307"}
     */
    
    self.isCustomAlertShowing = NO;
    if (!secret)    //nil 返回
    {
        return;
    }
    
    [Utility showMBProgress:self.view message:@"支付中"];
    
    HWUserLogin *user = [HWUserLogin currentUserLogin];
    HWHTTPRequestOperationManager *manage = [HWHTTPRequestOperationManager cutManager];
    NSMutableDictionary *param = [NSMutableDictionary dictionary];
    [param setPObject:[secret md5:secret] forKey:@"ae"];
    [param setPObject:self.currentGoods.productId forKey:@"productId"];
    [param setPObject:_priceTF.text forKey:@"amt"];
    [param setPObject:user.telephoneNum forKey:@"mobileNumber"];
    [param setPObject:@"1" forKey:@"source"];
    [param setPObject:user.userId forKey:@"userId"];
    [param setPObject:handlingFee forKey:@"fee"];
    [param setPObject:user.key forKey:@"key"];
    
    [manage POST:kCutProduct parameters:param queue:nil success:^(id responseObject) {
        
        NSLog(@"%@",responseObject);
        [Utility hideMBProgress:self.view];
//        [Utility showToastWithMessage:@"出价完成" inView:self.view];
        
        NSDictionary *dic = [responseObject dictionaryObjectForKey:@"data"];
        
        HWPayResultModel *payResult = [[HWPayResultModel alloc] initWithPayResult:dic];
        
        HWPaySuccessViewController *paySuccessVC = [[HWPaySuccessViewController alloc] init];
        paySuccessVC.payResult = payResult;
        
        [self.navigationController pushViewController:paySuccessVC animated:YES];
        
        
    } failure:^(NSString *code, NSString *error) {
        NSLog(@"%@", error);
        [Utility hideMBProgress:self.view];
        [Utility showToastWithMessage:error inView:self.view];
    }];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)dealloc
{
    [[NSNotificationCenter defaultCenter] removeObserver:self name:CutAgainNotification object:nil];
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
