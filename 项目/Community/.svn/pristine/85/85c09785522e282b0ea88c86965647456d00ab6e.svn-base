//
//  HWShopsDetailVC.m
//  Community
//
//  Created by lizhongqiang on 14-9-1.
//  Copyright (c) 2014年 caijingpeng. All rights reserved.
//

#import "HWShopsDetailVC.h"
#import "AppDelegate.h"

@interface HWShopsDetailVC ()
{
    UIView *foot;
    
    UIView *panelView;
    UIView *markView;
    UIScrollView *myScrollView;
    
    NSArray *arrImg;
    NSInteger currentIndex;
    UIButton *btn;
}
@end

@implementation HWShopsDetailVC
@synthesize shopId;
@synthesize tipAlert;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)rightItem
{
    [MobClick event:@"click_more"];
    UIActionSheet *actionSheet = [[UIActionSheet alloc] initWithTitle:nil delegate:self cancelButtonTitle:@"取消" destructiveButtonTitle:nil otherButtonTitles:@"认领商铺", nil];
    [actionSheet showInView:self.view];
}

-(void)actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex
{
    if (buttonIndex == 0)
    {
#warning 绑定手机号  认领商铺
        [MobClick event:@"click_claim_shop"];
        if ([HWUserLogin verifyBindMobileWithPopVC:self showAlert:YES])
        {
            HWShopManageViewController *shopManage = [[HWShopManageViewController alloc] init];
            shopManage.shopIdStr = shopId;
            shopManage.renlinFlag = YES;
            [self.navigationController pushViewController:shopManage animated:YES];

        }

    }
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    //shop_dynamic.png   shop_time.png
    
//    [self.view setBackgroundColor:UIColorFromRGB(0xf5f5eb)];
    self.navigationItem.titleView = [Utility navTitleView:@"商店详情"];
    self.navigationItem.leftBarButtonItem = [Utility navLeftBackBtn:self action:@selector(backMethod)];
    refrehHeadview.alpha = 0;
//    self.navigationItem.rightBarButtonItem = [Utility navWalletButton:self action:@selector(rightItem)];
    
  
    
    if (IOS7)
    {
        self.baseTableView.frame = CGRectMake(0, 0, kScreenWidth, self.view.frame.size.height - 64);
    }
    else
    {
        self.baseTableView.frame = CGRectMake(0, 0, kScreenWidth, self.view.frame.size.height - 44);
    }
    
    _currentPage = 0;
    self.isNeedHeadRefresh = YES;
    
    [self queryListData];
    
    
    btn = [UIButton buttonWithType:UIButtonTypeCustom];
    btn.alpha = 0;
    [btn setFrame:CGRectMake(kScreenWidth - 60, self.view.frame.size.height - 130, 44, 44)];
    [btn setBackgroundImage:[UIImage imageNamed:@"top"] forState:UIControlStateNormal];
    [btn addTarget:self action:@selector(btnClick:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:btn];
}

- (void)viewWillDisappear:(BOOL)animated
{
    [self removeCallStateNotification];
}

- (void)viewWillAppear:(BOOL)animated
{
    [self addCallStateNotification];
}

#pragma mark -
#pragma mark 数据请求
-(void)queryListData
{
    HWUserLogin *user = [HWUserLogin currentUserLogin];
    HWHTTPRequestOperationManager *manage = [HWHTTPRequestOperationManager manager];
    NSMutableDictionary *dict = [[NSMutableDictionary alloc] init];
    [dict setPObject:user.key forKey:@"key"];
    [dict setPObject:shopId forKey:@"shopId"];
//    [dict setPObject:[NSString stringWithFormat:@"%d",kPageCount] forKey:@"size"];
    [dict setPObject:@"0" forKey:@"page"];
//    [dict setPObject:[NSString stringWithFormat:@"%d",_currentPage] forKey:@"page"];//0全部动态
    [manage POST:kShopDetail parameters:dict queue:nil success:^(id responseObject) {
//        NSLog(@"%@",responseObject);
        NSDictionary *dic = (NSDictionary *)responseObject;
        HWStoreDetailClass *detail = [[HWStoreDetailClass alloc] initWithDictionary:[dic dictionaryObjectForKey:@"data"]];

//        NSLog(@"数据源长度 = %d",self.dataList.count);
        
        if (_currentPage == 0)
        {
            [self.dataList removeAllObjects];
            self.dataList = [[NSMutableArray alloc] initWithObjects:@"占位置", nil];
            [self.dataList addObjectsFromArray:detail.arrServiceTrack];
        }
        else
        {
            [self.dataList addObjectsFromArray:detail.arrServiceTrack];
        }
        
        isLastPage = YES;
        
//        if (detail.arrServiceTrack.count < kPageCount)
//        {
//            isLastPage = YES;
//        }
//        else
//        {
//            isLastPage = NO;
//        }
        
        [self initTableHeadView:detail];
        [self.baseTableView bringSubviewToFront:refrehHeadview];
        
        [self.baseTableView reloadData];
        [self doneLoadingTableViewData];
        
    } failure:^(NSString *code, NSString *error) {
        
        [Utility showToastWithMessage:error inView:self.view];
//        NSLog(@"%@",error);
        
    }];

}
#pragma mark -
- (void)btnClick:(id)sender
{
    [self.baseTableView setContentOffset:CGPointMake(0, 0) animated:YES];
}

- (void)initTableHeadView:(HWStoreDetailClass *)detail
{
    
    storeClass = detail;
    for (UIView *view in tableHeadView.subviews)
    {
        [view removeFromSuperview];
    }
    tableHeadView = [[UIView alloc] init];
    tableHeadView.layer.masksToBounds = NO;
    [tableHeadView setBackgroundColor:[UIColor clearColor]];
    height = 0;
    //商户大图
    UIImageView *shopBigImg = [[UIImageView alloc] initWithFrame:CGRectMake(0, 125 - kScreenWidth, kScreenWidth, kScreenWidth)];
//    [shopBigImg setBackgroundColor:THEME_COLOR_ORANGE];
    [shopBigImg setBackgroundColor:[UIColor colorWithRed:233.0/255.0 green:233.0/255.0 blue:233.0/255.0 alpha:1.0]];
    __weak UIImageView *blockImgV = shopBigImg;
    NSLog(@"%@",detail.bannerUrl);
    NSString *strUrl;
//    if (detail.picUrls.count > 0)
//    {
//        strUrl = [NSString stringWithFormat:@"%@/hw-sq-app-web/%@",kUrlBase,[detail.picUrls objectAtIndex:0]];
//    }
//    else
//    {
//        strUrl = [NSString stringWithFormat:@"%@/hw-sq-app-web/%@",kUrlBase,detail.bannerUrl];
//    }
    
    if (detail.bannerUrl.length != 0)//markby niedi
    {
        strUrl = [NSString stringWithFormat:@"%@/hw-sq-app-web/%@",kUrlBase,detail.bannerUrl];
    }
    else
    {
        if (detail.picUrls.count > 0)
        {
            strUrl = [NSString stringWithFormat:@"%@/hw-sq-app-web/%@",kUrlBase,[detail.picUrls objectAtIndex:0]];
        }
    }
    
    [shopBigImg setImageWithURL:[NSURL URLWithString:strUrl] placeholderImage:[UIImage imageNamed:@"shopTopDefault"] completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType) {
        if (error)
        {
            NSLog(@"Error : load image fail.");
            blockImgV.image = [UIImage imageNamed:@"shopTopDefault"];
        }
        else
        {
            blockImgV.image = image;
            if (cacheType == 0)
            { // request url
                CATransition *transition = [CATransition animation];
                transition.duration = 1.0f;
                transition.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut];
                transition.type = kCATransitionFade;
                [blockImgV.layer addAnimation:transition forKey:nil];
            }
        }
    }];
    
    [tableHeadView addSubview:shopBigImg];
    
//    detail.shopType
    
    //中间类型图
    UIImageView *shopTypeImg = [[UIImageView alloc] initWithFrame:CGRectMake((kScreenWidth - 80)/2, 125 - 40, 81, 81)];
    [shopTypeImg setBackgroundColor:[UIColor clearColor]];
    shopTypeImg.layer.borderWidth = 2.0f;
    shopTypeImg.layer.borderColor = [UIColor whiteColor].CGColor;
    shopTypeImg.layer.cornerRadius = 40.0f;
    shopTypeImg.layer.masksToBounds = YES;
//    [shopTypeImg setImage:[UIImage imageNamed:@"fruit"]];//店铺类型的图片
    [tableHeadView addSubview:shopTypeImg];
    
    __block NSString *strIconUrl;
    NSMutableDictionary *dict = [[NSMutableDictionary alloc] init];
    [dict setPObject:detail.shopType forKey:@"dictId"];
    [dict setPObject:[HWUserLogin currentUserLogin].key forKey:@"key"];
    HWHTTPRequestOperationManager *manage = [HWHTTPRequestOperationManager manager];
    [manage POST:kServiceBaseDataSingle parameters:dict queue:nil success:^(id responseObject) {
        NSLog(@"%@",responseObject);
        NSDictionary *dic = [responseObject dictionaryObjectForKey:@"data"];
        strIconUrl = [dic stringObjectForKey:@"iconMongodbUrl"];
        NSString *strUrl = [Utility imageDownloadUrl:strIconUrl];
        __weak UIImageView *blockTypeImage = shopTypeImg;
        //默认图
        [shopTypeImg setImageWithURL:[NSURL URLWithString:strUrl] placeholderImage:[UIImage imageNamed:@"shopDefault"] completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType) {
            if (error) {
                blockTypeImage.image = [UIImage imageNamed:@"shopDefault"];
            }
            else
            {
                blockTypeImage.image = image;
            }
        }];
    } failure:^(NSString *code, NSString *error) {
//        NSLog(@"%@",error);
    }];
    
    
    
    height = 125 + 40;
    //店名
    UILabel *labShopName = [[UILabel alloc] initWithFrame:CGRectMake(0, height, kScreenWidth, 30)];
    [labShopName setBackgroundColor:[UIColor clearColor]];
//    [labShopName setText:@"阿纳达的咖啡店"];
    labShopName.text = detail.shopName;
    [labShopName setFont:[UIFont boldSystemFontOfSize:18.0f]];
    [labShopName setTextAlignment:NSTextAlignmentCenter];
    [tableHeadView addSubview:labShopName];
    
    height += labShopName.frame.size.height + 5;
    
    UILabel *labelDoor = [[UILabel alloc] initWithFrame:CGRectMake(106, height, 60, 17)];
    [labelDoor setBackgroundColor:[UIColor clearColor]];
    [labelDoor setText:@"上门服务"];
    labelDoor.layer.borderColor = UIColorFromRGB(0xffa300).CGColor;
    labelDoor.layer.borderWidth = 1.0f;
    labelDoor.layer.cornerRadius = 17 / 2.0f;
    labelDoor.layer.masksToBounds = YES;
    [labelDoor setTextAlignment:NSTextAlignmentCenter];
    [labelDoor setTextColor:UIColorFromRGB(0xffa300)];
    [labelDoor setFont:[UIFont fontWithName:FONTNAME size:12.0f]];
    
    
    UILabel *labelApprove = [[UILabel alloc] initWithFrame:CGRectMake(172, height, 53, 17)];
    [labelApprove setBackgroundColor:[UIColor clearColor]];
    [labelApprove setTextAlignment:NSTextAlignmentCenter];
    labelApprove.layer.cornerRadius = 17 / 2.0f;
    labelApprove.layer.borderColor = THEME_COLOR_GREEN.CGColor;
    labelApprove.layer.borderWidth = 1.0f;
    [labelApprove setTextColor:[UIColor colorWithRed:108.0/255.0 green:189.0/255.0 blue:177.0/255.0 alpha:1.0f]];
//    [labelApprove setText:@"认证"];
    [labelApprove setFont:[UIFont fontWithName:FONTNAME size:12.0f]];
    
    
    //    住户ID
//    NSLog(@"== %@ ==",detail.residentId);
//
    
    if ([HWUserLogin currentUserLogin].shopId.length == 0)
    {
        self.navigationItem.rightBarButtonItem = [Utility navWalletButton:self action:@selector(rightItem)];
        
        if (detail.residentId.length == 0)
        {
            self.navigationItem.rightBarButtonItem = [Utility navWalletButton:self action:@selector(rightItem)];
        }
        else
        {
            self.navigationItem.rightBarButtonItem = nil;
        }
    }
    else
    {
        self.navigationItem.rightBarButtonItem = nil;
    }
    
    //0 未认证  1认证中  2 已认证        1 上门    0 不上门
    NSLog(@"%@",detail.authorize);
    if ([detail.authorize isEqualToString:@"0"])
    {
        labelApprove.text = @"未认证";
        labelApprove.layer.borderColor = THEME_COLOR_TEXT.CGColor;
        [labelApprove setTextColor:THEME_COLOR_TEXT];
    }
    else if ([detail.authorize isEqualToString:@"1"])
    {
        labelApprove.text = @"认证中";
        labelApprove.layer.borderColor = THEME_COLOR_TEXT.CGColor;
        [labelApprove setTextColor:THEME_COLOR_TEXT];
    }
    else if ([detail.authorize isEqualToString:@"2"])
    {
        labelApprove.text = @"已认证";
        labelApprove.layer.borderColor = THEME_COLOR_GREEN.CGColor;
        [labelApprove setTextColor:[UIColor colorWithRed:108.0/255.0 green:189.0/255.0 blue:177.0/255.0 alpha:1.0f]];
    }
    else
    {
        labelApprove.text = @"未认证";
        labelApprove.layer.borderColor = THEME_COLOR_TEXT.CGColor;
        [labelApprove setTextColor:THEME_COLOR_TEXT];
    }
    
    if ([detail.outSell isEqualToString:@"1"])
    {
        labelDoor.hidden = NO;
        
        labelDoor.frame = CGRectMake((kScreenWidth - 60 - 5 - 53) / 2.0f, height, 60, 17);
        labelApprove.frame = CGRectMake((kScreenWidth - 60 - 5 - 53) / 2.0f + 65, height, 53, 17);
        
    }
    else
    {
        labelDoor.hidden = YES;
        
        labelApprove.frame = CGRectMake((kScreenWidth - 53) / 2.0f, height, 53, 17);
//        labelApprove.center = CGPointMake(kScreenWidth / 2.0f, labelApprove.center.y);
    }
    
    [tableHeadView addSubview:labelDoor];
    [tableHeadView addSubview:labelApprove];
    height += 30;
    
    //接通率
    UILabel *labCall = [[UILabel alloc] initWithFrame:CGRectMake(0, height, kScreenWidth, 21)];
    [labCall setBackgroundColor:[UIColor clearColor]];
    [labCall setTextAlignment:NSTextAlignmentCenter];
    [labCall setTextColor:THEME_COLOR_TEXT];
    [labCall setFont:[UIFont fontWithName:FONTNAME size:THEME_FONT_SMALL]];
    if ([detail.connectionRate intValue] > 0)
    {
        labCall.text = [NSString stringWithFormat:@"接通率：%@%%",detail.connectionRate];
        height += labCall.frame.size.height + 5;
    }
    else
    {
        labCall.text = @"";
    }
    [tableHeadView addSubview:labCall];
    
    //拨打电话
    UIButton *btnCall = [UIButton buttonWithType:UIButtonTypeCustom];
    [btnCall setFrame:CGRectMake((kScreenWidth - 160)/2, height, 160, 36)];
    [btnCall setBackgroundImage:[UIImage imageNamed:@"phone_7"] forState:UIControlStateNormal];
    [btnCall addTarget:self action:@selector(callPhone:) forControlEvents:UIControlEventTouchUpInside];
    [tableHeadView addSubview:btnCall];
    height += btnCall.frame.size.height + 12;
    
    //
    UILabel *labLine = [[UILabel alloc] initWithFrame:CGRectMake(0, height, kScreenWidth, 0.5)];
    [labLine setBackgroundColor:THEME_COLOR_LINE];
    [tableHeadView addSubview:labLine];
    height += 0.5;
    
    //服务描述
    UIFont *leftFont = [UIFont fontWithName:FONTNAME size:THEME_FONT_BIG];
    UIFont *rightFont = [UIFont fontWithName:FONTNAME size:THEME_FONT_SMALL];
    
    UIView *serverView = [[UIView alloc] init];
    [serverView setBackgroundColor:[UIColor whiteColor]];
    
    UILabel *labServerLeft = [[UILabel alloc] initWithFrame:CGRectMake(15, 10, 75, 21)];
    [labServerLeft setBackgroundColor:[UIColor clearColor]];
    [labServerLeft setText:@"服务描述："];
    [labServerLeft setFont:leftFont];
    [serverView addSubview:labServerLeft];
    
    UILabel *labServerRight = [[UILabel alloc] initWithFrame:CGRectMake(CGRectGetMaxX(labServerLeft.frame), 13, 220, 21)];
    [labServerRight setBackgroundColor:[UIColor clearColor]];
    if (detail.serviceDetail.length == 0)
    {
        labServerRight.text = @"这个商店很懒，没有写描述~";
    }
    else
    {
        labServerRight.text = detail.serviceDetail;
    }
    
    [labServerRight setFont:rightFont];
    [labServerRight setTextColor:THEME_COLOR_TEXT];
    labServerRight.numberOfLines = 0;
    [labServerRight sizeToFit];
    [serverView addSubview:labServerRight];
    float serverHeight = labServerRight.frame.size.height;
    if (serverHeight < 31) {
        serverHeight = 31;
        [serverView setFrame:CGRectMake(0, height, kScreenWidth, serverHeight + 13)];
        height += serverHeight + 13;
    }
    else
    {
        [serverView setFrame:CGRectMake(0, height, kScreenWidth, serverHeight + 13 + 10)];
        height += serverHeight + 13 + 10;
    }
    
    [tableHeadView addSubview:serverView];
    

    UILabel *lineServer = [[UILabel alloc] initWithFrame:CGRectMake(0, height, kScreenWidth, 0.5)];
    [lineServer setBackgroundColor:THEME_COLOR_LINE];
    [tableHeadView addSubview:lineServer];
    
    height += 0.5;
    
    UILabel *labShopPhoto = [[UILabel alloc] initWithFrame:CGRectMake(15, height + 10, 100, 21)];
    [labShopPhoto setBackgroundColor:[UIColor clearColor]];
    [labShopPhoto setText:@"店铺相册"];
    [labShopPhoto setFont:leftFont];
    [tableHeadView addSubview:labShopPhoto];
    
    height += labShopPhoto.frame.size.height + 10;
    
    [self createStorePhoto];
    
    UILabel *photoLine = [[UILabel alloc] initWithFrame:CGRectMake(0, height, kScreenWidth, 0.5)];
    [photoLine setBackgroundColor:THEME_COLOR_LINE];
    [tableHeadView addSubview:photoLine];
    
    height += 0.5;
    
    [self initAddressTime:detail];
    
    
    [tableHeadView setFrame:CGRectMake(0, 0, kScreenWidth, height)];
    self.baseTableView.tableHeaderView = tableHeadView;
}

- (void)initAddressTime:(HWStoreDetailClass *)detail
{
    UIFont *bigFont = [UIFont fontWithName:FONTNAME size:THEME_FONT_BIG];
    UIFont *smallFont = [UIFont fontWithName:FONTNAME size:THEME_FONT_SMALL];
    float rightY = 85;
    float whiteHeight = 0;
    
    UIView *whiteView = [[UIView alloc] initWithFrame:CGRectMake(0, height, kScreenWidth, 20)];
    [whiteView setBackgroundColor:[UIColor whiteColor]];
    [tableHeadView addSubview:whiteView];
    
    UILabel *labAddress = [[UILabel alloc] initWithFrame:CGRectMake(15, 10, 100, 21)];
    [labAddress setBackgroundColor:[UIColor clearColor]];
    [labAddress setFont:bigFont];
    [labAddress setText:@"店铺地址："];
    [whiteView addSubview:labAddress];
    
    UILabel *labAddressDetail = [[UILabel alloc] initWithFrame:CGRectMake(rightY, 14, kScreenWidth - 80 - 10, 21)];
    [labAddressDetail setBackgroundColor:[UIColor clearColor]];
    labAddressDetail.text = detail.shopAddress;
//    [labAddressDetail setText:@"一二三四五六七八九十一二三四五六七一二三四五六七八九十一二三四五六七"];
//    labAddressDetail.text = @"";
    [labAddressDetail setFont:smallFont];
    [labAddressDetail setTextColor:THEME_COLOR_TEXT];
    labAddressDetail.numberOfLines = 0;
    [labAddressDetail sizeToFit];
    [whiteView addSubview:labAddressDetail];
    float addressHeight = labAddressDetail.frame.size.height;
    if (addressHeight < 17)
    {
        addressHeight = 17;
    }
    whiteHeight += addressHeight + 15 + 13;
    
    UILabel *line1 = [[UILabel alloc] initWithFrame:CGRectMake(0, whiteHeight, kScreenWidth, 0.5)];
    [line1 setBackgroundColor:THEME_COLOR_LINE];
    [whiteView addSubview:line1];
    whiteHeight += 10;
    
    UILabel *labTime = [[UILabel alloc] initWithFrame:CGRectMake(15, whiteHeight, 100, 21)];
    [labTime setBackgroundColor:[UIColor clearColor]];
    [labTime setFont:bigFont];
    [labTime setText:@"营业时间："];
    [whiteView addSubview:labTime];
    
    whiteHeight += 3;
    UILabel *labTimeDetail = [[UILabel alloc] initWithFrame:CGRectMake(rightY, whiteHeight, kScreenWidth - 90, 21)];
    [labTimeDetail setBackgroundColor:[UIColor clearColor]];
//    [labTimeDetail setText:@"上午10：00 - 晚上22：00"];
    if ([detail.shopTime isEqualToString:@"null ~ null"])
    {
        labTimeDetail.text = @"";
    }
    else
    {
        labTimeDetail.text = detail.shopTime;
    }
//    labTimeDetail.text = @"";
    [labTimeDetail setTextColor:THEME_COLOR_TEXT];
    [labTimeDetail setFont:smallFont];
    labTimeDetail.numberOfLines = 0;
    [labTimeDetail sizeToFit];
    NSLog(@"%f",labTimeDetail.frame.size.height);
    float timeHeight = labTimeDetail.frame.size.height;
    if (timeHeight < 17)
    {
        timeHeight = 17;
    }
    else
    {
        timeHeight = labTimeDetail.frame.size.height;
    }
//    labTimeDetail.frame = CGRectMake(rightY, whiteHeight, kScreenWidth - 90, timeHeight);
    [whiteView addSubview:labTimeDetail];
    
    whiteHeight += timeHeight + 10 + 5;
    
    UILabel *line2 = [[UILabel alloc] initWithFrame:CGRectMake(0, whiteHeight, kScreenWidth, 0.5)];
    [line2 setBackgroundColor:THEME_COLOR_LINE];
    [whiteView addSubview:line2];
    whiteHeight += 10;
    
    UILabel *labServer = [[UILabel alloc] initWithFrame:CGRectMake(15, whiteHeight, 100, 21)];
    [labServer setBackgroundColor:[UIColor clearColor]];
    [labServer setFont:bigFont];
    [labServer setText:@"服务范围："];
    [whiteView addSubview:labServer];
    
    whiteHeight += 3;
    UILabel *labServerDetail = [[UILabel alloc] initWithFrame:CGRectMake(rightY, whiteHeight, kScreenWidth - 90, 21)];
    [labServerDetail setBackgroundColor:[UIColor clearColor]];
    [labServerDetail setFont:smallFont];
    [labServerDetail setTextColor:THEME_COLOR_TEXT];
//    [labServerDetail setText:@"呼兰三村，呼兰二村，呼兰一村，呼兰四村，通河一村，通河二村 萨科技等法律卡机是"];
    NSArray *arrRange = detail.arrServiceRange;
    NSMutableString *strRange = [[NSMutableString alloc] init];
    for (int i = 0; i < arrRange.count; i ++)
    {
        HWServiceRangeClass *range = (HWServiceRangeClass *)[arrRange objectAtIndex:i];
        NSString *str = [NSString stringWithFormat:@"%@ ",range.villageName];
        [strRange appendString:str];
    }
    [labServerDetail setText:strRange];
    labServerDetail.numberOfLines = 0;
    [labServerDetail sizeToFit];
    [whiteView addSubview:labServerDetail];
    float serviceHeight = labServerDetail.frame.size.height;
    if (serviceHeight < 10)
    {
        serviceHeight = 13.0f;
    }
    
    whiteHeight += serviceHeight + 18;
    
    
    UILabel *line3 = [[UILabel alloc] initWithFrame:CGRectMake(0, whiteHeight, kScreenWidth, 0.5)];
    [line3 setBackgroundColor:THEME_COLOR_LINE];
    [whiteView addSubview:line3];
    whiteHeight += 1;
    
    [whiteView setFrame:CGRectMake(0, height, kScreenWidth, whiteHeight)];
    height += whiteHeight;
}


#pragma mark -
#pragma mark zoom image

- (void)createStorePhoto
{
    arrImg = storeClass.picIconUrls;
    height += 15;
    UIScrollView *scroll = [[UIScrollView alloc] initWithFrame:CGRectMake(15, height, kScreenWidth - 30, 80)];
    for (int i = 0; i < arrImg.count; i ++)
    {
        UIImageView *storeImg = [[UIImageView alloc] initWithFrame:CGRectMake(90 * i, 0, 80, 80)];
        storeImg.layer.cornerRadius = 10.0f;
        storeImg.layer.masksToBounds = YES;
        __weak UIImageView *blockImage = storeImg;
        NSString *strUrl = [NSString stringWithFormat:@"%@/hw-sq-app-web/%@",kUrlBase,arrImg[i]];
        [storeImg setImageWithURL:[NSURL URLWithString:strUrl] placeholderImage:[UIImage imageNamed:@"photoDefault"] completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType) {
            if (error)
            {
                blockImage.image = [UIImage imageNamed:@"photoDefault"];
            }
            else
            {
                blockImage.image = image;
            }
        }];
        storeImg.tag = 10000 + i;
        storeImg.userInteractionEnabled = YES;
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapPhoto:)];
        [storeImg addGestureRecognizer:tap];
        [scroll addSubview:storeImg];
    }
    CGFloat width = (320 > 90 * arrImg.count) ? 320 : 90 * arrImg.count;
    
    [scroll setContentSize:CGSizeMake(width, 80)];
    [scroll setShowsHorizontalScrollIndicator:NO];
    
    UILabel *labImageTip = [[UILabel alloc] initWithFrame:CGRectMake(0, height - 10, kScreenWidth, 15)];
    [labImageTip setBackgroundColor:[UIColor clearColor]];
    [labImageTip setTextColor:THEME_COLOR_TEXT];
    [labImageTip setTextAlignment:NSTextAlignmentCenter];
    [labImageTip setText:@"这个商店还没有照片~"];
    labImageTip.hidden = YES;
    [labImageTip setFont:[UIFont fontWithName:FONTNAME size:THEME_FONT_SMALL]];
    [tableHeadView addSubview:labImageTip];
    [tableHeadView addSubview:scroll];
    if (arrImg.count == 0)
    {
        labImageTip.hidden = NO;
        height += labImageTip.frame.size.height + 10;
    }
    else
    {
        labImageTip.hidden = YES;
        height += 95;
    }
    
}

- (void)tapPhoto:(UITapGestureRecognizer *)tap
{
    NSMutableArray *photos = [[NSMutableArray alloc] init];
    NSArray *arrBigImage = storeClass.picUrls;
    for (int i = 0; i < arrBigImage.count; i ++)
    {
        NSString *strUrl = [NSString stringWithFormat:@"%@/hw-sq-app-web/%@",kUrlBase,arrBigImage[i]];
        MJPhoto *photo = [[MJPhoto alloc] init];
        photo.url = [NSURL URLWithString:strUrl];
        UIImageView *imgView = (UIImageView *)[self.view viewWithTag:tap.view.tag];
        photo.srcImageView = imgView;
        [photos addObject:photo];
    }
    
    MJPhotoBrowser *browser = [[MJPhotoBrowser alloc] init];
    browser.currentPhotoIndex = tap.view.tag - 10000;
    browser.photos = photos;
    [browser show];
}

- (void) scrollViewDidEndDecelerating:(UIScrollView *)scrollView
{
    
    NSLog(@"停止时 y = %f",scrollView.contentOffset.y);
    if (scrollView.contentOffset.y == 0)
    {
        return;
    }
    if (btn.alpha == 0) {
        [UIView animateWithDuration:1.0f animations:^{
            btn.alpha = 1;
        }];
    }
}

#pragma mark -
-(void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    CGFloat yOffset = scrollView.contentOffset.y;
    if (yOffset < 125 - kScreenWidth) {
        scrollView.contentOffset = CGPointMake(0, 125 - kScreenWidth);
    }
    [super scrollViewDidScroll:scrollView];
    [UIView animateWithDuration:1.0f animations:^{
        btn.alpha = 0;
    }];
    
}


#pragma mark -
#pragma mark tableview delegate
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.dataList.count;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.row == 0) {
        return 57.0f;
    }else
        return [HWShopNewsTableViewCell getCellHeight:(HWStoreNewsClass *)[self.dataList objectAtIndex:indexPath.row]];

}


-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    [tableView setSeparatorStyle:UITableViewCellSeparatorStyleNone];
    [tableView setSeparatorColor:[UIColor clearColor]];

    
    if (indexPath.row == 0)
    {
        UITableViewCell *sysCell = [tableView dequeueReusableCellWithIdentifier:@"sysCell"];
        if (!sysCell)
        {
            
            sysCell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"sysCell"];
            sysCell.backgroundColor = THEME_COLOR_TEXTBACKGROUND;
            UIImageView *imgShop = [[UIImageView alloc] initWithFrame:CGRectMake(15, 17, 21, 21)];
            [imgShop setImage:[UIImage imageNamed:@"property_dynamic"]];
            [sysCell.contentView addSubview:imgShop];
            
            UILabel *labShop = [[UILabel alloc] initWithFrame:CGRectMake(45, 20, 200, 21)];
            [labShop setBackgroundColor:[UIColor clearColor]];
            [labShop setText:@"商铺动态"];
            [labShop setTextColor:THEME_COLOR_SMOKE];
            [labShop setFont:[UIFont fontWithName:FONTNAME size:THEME_FONT_BIG]];
            [sysCell.contentView addSubview:labShop];
            
            UILabel *line = [[UILabel alloc] initWithFrame:CGRectMake(25, 38, 1, 21)];
            [line setBackgroundColor:THEME_COLOR_LINE];
            [sysCell.contentView addSubview:line];
            sysCell.userInteractionEnabled = NO;
            
            if (dataList.count == 1)
            {
                [labShop setText:@"这个商店还没有动态~"];
            }
            else
            {
                [labShop setText:@"商铺动态"];
            }
        }
        
        
        return sysCell;
    }
    else
    {
        HWShopNewsTableViewCell *cell = (HWShopNewsTableViewCell *)[tableView dequeueReusableCellWithIdentifier:@"cell"];
        if (!cell)
        {
            cell = [[HWShopNewsTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"cell"];
            
        }
        cell.storeNews = (HWStoreNewsClass *)[self.dataList objectAtIndex:indexPath.row];
        cell.userInteractionEnabled = NO;
        return cell;
    }
    
    
}

#pragma mark -
- (void)addCallStateNotification
{
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(dialingNotify:) name:HWCallDetectCenterStateDialingNotification object:nil];
}

- (void)removeCallStateNotification
{
    [[NSNotificationCenter defaultCenter] removeObserver:self name:HWCallDetectCenterStateDialingNotification object:nil];
}

//拨打店铺电话
- (void)callPhone:(id)sender
{
    [MobClick event:@"click_call_commerce"];
    // *** 拨打电话
    if (callWebview == nil)
    {
        callWebview = [[UIWebView alloc] init];
        [self.view addSubview:callWebview];
    }
    
//    storeClass.shopPhone      //店铺电话
//    NSString *strPhone = storeClass.shopPhone;
    NSString *strPhone = storeClass.mobile;
    
    if (strPhone.length > 0)
    {
        strShopPhone = strPhone;
    }
    else
    {
        strPhone = storeClass.shopPhone;
//        strShopPhone = storeClass.shopPhone;
        if (strPhone.length > 0)
        {
            strShopPhone = strPhone;
        }
        else
        {
            [Utility showToastWithMessage:@"这个商店还没有电话哦~" inView:self.view];
            return;
        }
        
    }
    
    
    
    NSURL *telURL =[NSURL URLWithString:[NSString stringWithFormat:@"tel:%@",strPhone]];
    [callWebview loadRequest:[NSURLRequest requestWithURL:telURL]];
}

- (void)dialingNotify:(NSNotification *)notification
{
    NSUserDefaults *userDefault = [NSUserDefaults standardUserDefaults];
    [userDefault setObject:@"1" forKey:kHaveDialing];
    
    // *** 发送接口
    NSMutableDictionary *param = [NSMutableDictionary dictionary];
    [param setPObject:[HWUserLogin currentUserLogin].key forKey:@"key"];
    [param setPObject:@"0" forKey:@"type"];         //0:拨打给店铺,1是拨打给物业
    [param setPObject:strShopPhone forKey:@"phoneCalled"];
    [param setPObject:storeClass.shopId forKey:@"toId"];
    [param setPObject:[HWUserLogin currentUserLogin].residendId forKey:@"residentId"];
    
    HWHTTPRequestOperationManager *manage = [HWHTTPRequestOperationManager manager];
    [manage POST:kMakeTelContent parameters:param queue:nil success:^(id responseObject) {
        
        NSLog(@"%@", responseObject);
//        [Utility showToastWithMessage:@"cheng gong" inView:self.view];
    } failure:^(NSString *code, NSString *error) {
        NSLog(@"%@", error);
//        [Utility showToastWithMessage:@"shi bai" inView:self.view];
    }];
}




- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



@end
