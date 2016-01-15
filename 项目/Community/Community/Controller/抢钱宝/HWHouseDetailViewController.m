//
//  HWHouseDetailViewController.m
//  HaoWu_4.0
//
//  Created by caijingpeng.haowu on 14-5-22.
//  Copyright (c) 2014年 caijingpeng. All rights reserved.
//

#import "HWHouseDetailViewController.h"
#import "AppDelegate.h"
#import "HWDetailBaseInfoViewController.h"
#import "ScanImageViewCtr.h"
#import "HWDetailFirstRowCell.h"
#import "HWDetailHouseTypeCell.h"
#import "UIImageView+WebCache.h"
#import "EmptyControl.h"
#import "GoogleMapViewCtr.h"

#define DETAIL_IMG_HEIGHT   435
#define TOP_IMAGESCROLL_TAG 6101
#define TOP_PAGECONTROL_TAG 7777

@interface HWHouseDetailViewController ()<UIAlertViewDelegate>
{
    int _collectState; // 收藏状态 // 1 已收藏 2 未收藏 0 还未登录
    BOOL _isExpand;     // 控制主力户型展开更多
    UITableView *_mainTV;
    
    UILabel *_countLabel;
    UILabel *_houseName;
    UILabel *_areaLab;
    UILabel *_priceLab;
    UILabel *_youhuiLab;
    UILabel *_recommendLab;
    UILabel *_dateLab;
    UILabel *_typeLab;
    UILabel *_tagLab;
    
    NSString *shareWapUrl;
    NSString *shareWeiboUrl;
    NSString *houseDesc;
    NSString *houseName;
    
    UILabel *_yongjinLab;
    UILabel *_yongjinTitle;
    
    UIWebView *_webView;
    UIView *_recommandView;
}

@property (nonatomic,strong) NSOperationQueue *queue;
@property (nonatomic, strong) NSDictionary *detailDict;

@property (nonatomic, strong) NSArray *hxArr;//主力户型
@property (nonatomic, strong) NSArray *likeArr;//可能喜欢
//@property (nonatomic, strong) NSArray *samePriceArr;//同价楼盘
@end

@implementation HWHouseDetailViewController
@synthesize houseId,queue,detailDict,hxArr,likeArr,houseGroup;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

/**
 *	@brief	返回按钮点击事件
 *
 *	@return	N/A
 */
- (void)back
{
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.navigationItem.titleView = [Utility navTitleView:@"房源详情"];
    self.navigationItem.leftBarButtonItem = [Utility navLeftBackBtn:self action:@selector(back)];
    self.view.backgroundColor = [UIColor whiteColor];
    
    CGRect rect = CGRectMake(0, 0, kScreenWidth, CONTENT_HEIGHT - 50);
    
    _mainTV = [[UITableView alloc] initWithFrame:rect style:UITableViewStylePlain];
    _mainTV.separatorStyle = UITableViewCellSeparatorStyleSingleLine;
    _mainTV.backgroundColor = [UIColor clearColor];
    _mainTV.backgroundView = nil;
    _mainTV.delegate = self;
    _mainTV.dataSource = self;
    _mainTV.hidden = YES;
    [self.view addSubview:_mainTV];
    
    _isExpand = NO;
    
    [self queryDetailData];
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    if (scrollView.tag == TOP_IMAGESCROLL_TAG)
    {
        int page = scrollView.contentOffset.x/scrollView.frame.size.width;
        UIPageControl *pageCtr = (UIPageControl *)[_mainTV.tableHeaderView viewWithTag:TOP_PAGECONTROL_TAG];
        pageCtr.currentPage = page;
    }
}

/**
 *	@brief	创建顶部海报
 *
 *	@return	N/A
 */
- (UIView *)createTableHeaderView
{
    UIView *headerView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, DETAIL_IMG_HEIGHT)];
    
    UIScrollView *imgScroll = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, 175)];
    imgScroll.tag = TOP_IMAGESCROLL_TAG;
    imgScroll.delegate = self;
    imgScroll.pagingEnabled = YES;
    imgScroll.backgroundColor = [UIColor clearColor];
    [headerView addSubview:imgScroll];
    
    UIImageView *defaultImgview = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, imgScroll.frame.size.width, imgScroll.frame.size.height)];
    defaultImgview.image = [UIImage imageNamed:@"redDefault"];
    [imgScroll addSubview:defaultImgview];
    
    //加载顶部海报
    NSArray *picArray = (NSArray*)[detailDict arrayObjectForKey:@"housePic"];
    for (int i = 0 ; i < picArray.count ; i++)
    {
        UIImageView *topImgview = [[UIImageView alloc] initWithFrame:CGRectMake(i*imgScroll.frame.size.width, 0, imgScroll.frame.size.width, imgScroll.frame.size.height)];
        NSString *imgUrl = @"";
        
        if (![[picArray objectAtIndex:i] isKindOfClass:[NSNull class]])
        {
            imgUrl = [picArray objectAtIndex:i];
        }
        
//        [topImgview setImageWithURL:[NSURL URLWithString:imgUrl] placeholderImage:[UIImage imageNamed:@"ic_empty"] options:SDWebImageProgressiveDownload];
        
        __weak UIImageView *blockImgV = topImgview;
        [topImgview setImageWithURL:[NSURL URLWithString:imgUrl] placeholderImage:[UIImage imageNamed:@"redDefault"] options:SDWebImageRefreshCached|SDWebImageRetryFailed completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType) {
            if (error)
            {
                NSLog(@"Error : load image fail.");
                blockImgV.image = [UIImage imageNamed:@"redDefault"];
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
        
        
        UIButton *topBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        topBtn.frame = CGRectMake(i*imgScroll.frame.size.width, 0, imgScroll.frame.size.width, imgScroll.frame.size.height);
        [topBtn addTarget:self action:@selector(topImgBtnClick) forControlEvents:UIControlEventTouchUpInside];
        [imgScroll addSubview:topImgview];
        [imgScroll addSubview:topBtn];
    }
    [imgScroll setContentSize:CGSizeMake(imgScroll.frame.size.width*picArray.count, imgScroll.frame.size.height)];
    
    
    UIPageControl *pageCtr = [[UIPageControl alloc] init];
    pageCtr.tag = TOP_PAGECONTROL_TAG;
    if([[UIDevice currentDevice].systemVersion floatValue] >= 6.0)
    {
        pageCtr.pageIndicatorTintColor = UIColorFromRGB(0xb8b8b8);
        pageCtr.currentPageIndicatorTintColor = UIColorFromRGB(0x8ACF1C);
    }
    pageCtr.numberOfPages = picArray.count;
    pageCtr.frame = CGRectMake(0, imgScroll.frame.origin.y+imgScroll.frame.size.height-36, imgScroll.frame.size.width, 40);
    [headerView addSubview:pageCtr];
    
    // ----  图片数量 部分 ------
    UIView *infoView = [[UIView alloc] initWithFrame:CGRectMake(0, imgScroll.frame.size.height - 40, imgScroll.frame.size.width, 40)];
    infoView.backgroundColor = [UIColor clearColor];
    [headerView addSubview:infoView];
    
    NSArray *hxArray = [self.detailDict arrayObjectForKey:@"picHx"];
    NSArray *xgArray = [self.detailDict arrayObjectForKey:@"housePic"];
    NSArray *jtArray = [self.detailDict arrayObjectForKey:@"picJt"];
    NSArray *sjArray = [self.detailDict arrayObjectForKey:@"picSj"];
    NSArray *ybArray = [self.detailDict arrayObjectForKey:@"picYb"];
    
    // 图片数量总和
    _countLabel = [[UILabel alloc] initWithFrame:CGRectZero];
    _countLabel.text = [NSString stringWithFormat:@"%d",(hxArray.count + xgArray.count + jtArray.count + sjArray.count + ybArray.count)];
    _countLabel.backgroundColor = [UIColor clearColor];
    _countLabel.textColor = [UIColor whiteColor];
    _countLabel.font = [UIFont fontWithName:FONTNAME size:9];
    [_countLabel sizeToFit];
    _countLabel.center = CGPointMake(kScreenWidth - _countLabel.frame.size.width/2 - 5 - 3, infoView.frame.size.height - 10);
    [infoView addSubview:_countLabel];
    
    UIImageView *picImgV = [[UIImageView alloc] initWithFrame:CGRectMake(_countLabel.frame.origin.x - 20 - 3, _countLabel.frame.origin.y - 5, 15, 15)];
    picImgV.backgroundColor = [UIColor clearColor];
    picImgV.image = [UIImage imageNamed:@"pictureCount"];
    [infoView addSubview:picImgV];
    
    // ------ 房价 楼盘 ------
    
    UIView *houseView = [[UIView alloc] initWithFrame:CGRectMake(0, CGRectGetMaxY(imgScroll.frame), kScreenWidth, 95)];
    houseView.backgroundColor = [UIColor whiteColor];
    [headerView addSubview:houseView];
    
    _houseName = [[UILabel alloc] initWithFrame:CGRectMake(15, 15, 290, 20)];
    _houseName.font = [UIFont fontWithName:FONTNAME size:18.0f];
    _houseName.textColor = THEME_COLOR_SMOKE;
    _houseName.text = [NSString stringWithFormat:@"%@",[self.detailDict stringObjectForKey:@"houseName"]];
    [houseView addSubview:_houseName];
    [_houseName sizeToFit];
    
    _areaLab = [[UILabel alloc] initWithFrame:CGRectMake(CGRectGetMaxX(_houseName.frame) + 5, CGRectGetMinY(_houseName.frame) + 2, 100, 20)];
    _areaLab.font = [UIFont fontWithName:FONTNAME size:13.0f];
    _areaLab.textColor = THEME_COLOR_TEXT;
    _areaLab.text = [NSString stringWithFormat:@"[%@]",[self.detailDict stringObjectForKey:@"houseRegion"]];
    [houseView addSubview:_areaLab];
    
    _recommendLab = [[UILabel alloc] initWithFrame:CGRectMake(15, CGRectGetMaxY(_areaLab.frame)+4, 200, 20)];
    _recommendLab.font = [UIFont fontWithName:FONTNAME size:12.0f];
    _recommendLab.backgroundColor = [UIColor clearColor];
    _recommendLab.textColor = THEME_COLOR_TEXT;
    _recommendLab.text = [NSString stringWithFormat:@"已有%@人被推荐",[[self.detailDict objectForKey:@"activity"] objectForKey:@"activityNum"]];
    [houseView addSubview:_recommendLab];
    
    _priceLab = [[UILabel alloc] initWithFrame:CGRectMake(15, houseView.frame.size.height - 10 - 20, 180, 20)];
    _priceLab.font = [UIFont fontWithName:FONTNAME size:12.0f];
    _priceLab.textColor = THEME_COLOR_TEXT;
//    _priceLab.textColor = [Utility customOrangeColor];
//    _priceLab.textAlignment = NSTextAlignmentRight;
//    _priceLab.text = [NSString stringWithFormat:@"%@",[self.detailDict objectForKey:@"housePrice"]];
    NSMutableString *price = [NSMutableString stringWithFormat:@"均价%@",[self.detailDict objectForKey:@"housePrice"]];
    
    // 计算字符串中数字的位置和长度
    int l = 0;//位置
    int r = 0;// 长度
    for (int i = 0; i < price.length; i++)
    {
        NSString *c = [price substringWithRange:NSMakeRange(i, 1)];
        char a = [c characterAtIndex:0];
        if (a >= 48 && a <= 57)
        {
            if (r == 0)
            {
                l = i;
            }
            r++;
        }
        else
        {
            if (r != 0)
            {
                break;
            }
        }
    }

    NSMutableAttributedString *attributeString = [[NSMutableAttributedString alloc] initWithString:price];
    [attributeString addAttribute:NSForegroundColorAttributeName value:(id)THEME_COLOR_ORANGE range:NSMakeRange(l, r)];
    [attributeString addAttribute:NSFontAttributeName value:(id)[UIFont fontWithName:FONTNAME size:15.0f] range:NSMakeRange(l, r)];
    _priceLab.attributedText = attributeString;
    [houseView addSubview:_priceLab];
    
    UIView *houseLine = [[UIView alloc] initWithFrame:CGRectMake(0, houseView.frame.size.height - 0.5f, kScreenWidth, 0.5f)];
    houseLine.backgroundColor = THEME_COLOR_ORANGE;
    [houseView addSubview:houseLine];
    
    // --------- 预约 --------
    
    UIView *orderView = [[UIView alloc] initWithFrame:CGRectMake(0, CGRectGetMaxY(houseView.frame), kScreenWidth, 75)];
    orderView.backgroundColor = [UIColor colorWithRed:255.0 / 255.0 green:248.0 / 255.0 blue:236.0 / 255.0 alpha:1];
    [headerView addSubview:orderView];
    
    _youhuiLab = [[UILabel alloc] initWithFrame:CGRectMake(15, 10, 230, 100)];
    _youhuiLab.font = [UIFont fontWithName:FONTNAME size:15.0f];
    _youhuiLab.backgroundColor = [UIColor clearColor];
    _youhuiLab.textColor = THEME_COLOR_ORANGE;
    NSString *activityDiscount = [NSString stringWithFormat:@"%@",[[self.detailDict objectForKey:@"activity"] objectForKey:@"activityDiscount"]];
    _youhuiLab.text = ([activityDiscount isEqualToString:@""] ? @"暂无优惠" : activityDiscount);
    _youhuiLab.numberOfLines = 0;
    
#if __IPHONE_OS_VERSION_MAX_ALLOWED >= 60000
    
    _youhuiLab.lineBreakMode = NSLineBreakByWordWrapping;
    
#else
    
    _youhuiLab.lineBreakMode = UILineBreakModeWordWrap;
    
#endif
    
    [orderView addSubview:_youhuiLab];
    
    //*** 自适应大小
    [_youhuiLab sizeToFit];
    _youhuiLab.frame = CGRectMake(15, 10, 230, MAX(20,_youhuiLab.frame.size.height));
    orderView.frame = CGRectMake(0, CGRectGetMaxY(houseView.frame), kScreenWidth, 20 + 10 + 5 + _youhuiLab.frame.size.height);
    headerView.frame = CGRectMake(0, 0, self.view.bounds.size.width, DETAIL_IMG_HEIGHT - 75 + orderView.frame.size.height);
    //*** ********
    
    _dateLab = [[UILabel alloc] initWithFrame:CGRectMake(15, CGRectGetMaxY(_youhuiLab.frame) , 220, 20)];
    _dateLab.font = [UIFont fontWithName:FONTNAME size:12.0f];
    _dateLab.backgroundColor = [UIColor clearColor];
    _dateLab.textColor = THEME_COLOR_GRAY;
    _dateLab.text = [NSString stringWithFormat:@"活动时间：%@",[[self.detailDict objectForKey:@"activity"] stringObjectForKey:@"activityTime"]];
    [orderView addSubview:_dateLab];
    
    UIButton *callBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [callBtn setImage:[UIImage imageNamed:@"housePhone"] forState:UIControlStateNormal];
    callBtn.frame = CGRectMake(kScreenWidth - 10 - 40, (orderView.frame.size.height - 40)/2.0f, 40, 40);
    [callBtn addTarget:self action:@selector(telClick) forControlEvents:UIControlEventTouchUpInside];
    [orderView addSubview:callBtn];
    
    UIView *orderLine = [[UIView alloc] initWithFrame:CGRectMake(0, orderView.frame.size.height - 0.5, kScreenWidth, 0.5)];
    orderLine.backgroundColor = THEME_COLOR_LINE;
    [orderView addSubview:orderLine];
    
    // --------- 房源类型 ------------
    
    UIView *typeView = [[UIView alloc] initWithFrame:CGRectMake(0, CGRectGetMaxY(orderView.frame), kScreenWidth, 90)];
    typeView.backgroundColor = [UIColor whiteColor];
    [headerView addSubview:typeView];
    
    UILabel *typeTitle = [[UILabel alloc] initWithFrame:CGRectMake(15, 0, 75, 45)];
    typeTitle.font = [UIFont fontWithName:FONTNAME size:15.0f];
    typeTitle.textColor = THEME_COLOR_SMOKE;
    typeTitle.text = @"房源类型：";
    [typeView addSubview:typeTitle];
    
    _typeLab = [[UILabel alloc] initWithFrame:CGRectMake(CGRectGetMaxX(typeTitle.frame), 0, 100, 45)];
    _typeLab.font = [UIFont fontWithName:FONTNAME size:14.0f];
    _typeLab.textColor = THEME_COLOR_TEXT;
    
    _typeLab.text = [NSString stringWithFormat:@"%@",[self.detailDict stringObjectForKey:@"houseProperty"]];
    
    [typeView addSubview:_typeLab];
    UIView *line = [[UIView alloc] initWithFrame:CGRectMake(15, 45 - 0.5f, kScreenWidth - 30, 0.5f)];
    line.backgroundColor = THEME_COLOR_LINE;
    [typeView addSubview:line];
    
    UILabel *tagTitle = [[UILabel alloc] initWithFrame:CGRectMake(15, 46, 50, 45)];
    tagTitle.font = [UIFont fontWithName:FONTNAME size:15.0f];
    tagTitle.backgroundColor = [UIColor clearColor];
    tagTitle.textColor = THEME_COLOR_SMOKE;
    tagTitle.text = @"标签：";
    [typeView addSubview:tagTitle];
    
    UIView *dLine = [[UIView alloc] initWithFrame:CGRectMake(0, typeView.frame.size.height - 0.5f, kScreenWidth, 0.5f)];
    dLine.backgroundColor = THEME_COLOR_LINE;
    [typeView addSubview:dLine];

    
    _tagLab = [[UILabel alloc] initWithFrame:CGRectMake(CGRectGetMaxX(typeTitle.frame) - 20, 45, 200, 45)];
    _tagLab.font = [UIFont fontWithName:FONTNAME size:14.0f];
    _tagLab.backgroundColor = [UIColor clearColor];
    _tagLab.textColor = THEME_COLOR_TEXT;
    _tagLab.textAlignment = NSTextAlignmentLeft;
    
    _tagLab.text = [NSString stringWithFormat:@"%@",[self.detailDict stringObjectForKey:@"houseBj"]];
    
    [typeView addSubview:_tagLab];
    
    return headerView;
}

/**
 *	@brief	拨打电话
 *
 *	@return	N/A
 */
-(void)telClick
{
    
//    if ([_houseGroup isEqualToString:@"2"])//旅游
//    {
//        [MobClick event:@"call_manager_t"];
//    }
//    else
//    {
//        [MobClick event:@"call_manager"];
//    }
    NSString *obj = [self.detailDict stringObjectForKey:@"xmjlPhone"];
    
    if (!_webView)
    {
        _webView = [[UIWebView alloc]initWithFrame:CGRectZero];
        [self.view addSubview:_webView];
    }
    [_webView loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"tel:%@",([obj isEqualToString:@""] ? @"4001808116" : obj)]]]];
    
}

/**
 *	@brief	加载房源详情信息
 *
 *	@return	N/A
 */
- (void)queryDetailData
{
    if ([self.view viewWithTag:1111])
    {
        [[self.view viewWithTag:1111] removeFromSuperview];
    }
    
    [Utility showMBProgress:self.view message:LOADING_TEXT];
    
    HWHTTPRequestOperationManager *manager = [HWHTTPRequestOperationManager societyManager];
    NSMutableDictionary *dict = [NSMutableDictionary dictionary];
    [dict setPObject:self.houseId forKey:@"houseId"];
    [dict setPObject:[HWUserLogin currentUserLogin].key forKey:@"key"];
    [dict setPObject:@"1" forKey:@"channel"];
//    [dict setObject:@"" forKey:@"mark"];
    
    [manager POST:kHouseDetail parameters:dict queue:nil success:^(id responseObject)
    {
        [Utility hideMBProgress:self.view];
        self.detailDict = [responseObject dictionaryObjectForKey:@"data"];
        
        // 加载底部推荐工具条
        if (_recommandView == nil)
        {
            _recommandView = [[UIView alloc] initWithFrame:CGRectMake(0, CGRectGetMaxY(_mainTV.frame), self.view.frame.size.width, 50)];
            _recommandView.backgroundColor = THEME_COLOR_ORANGE;
            [self.view addSubview:_recommandView];
            
            _yongjinLab = [[UILabel alloc] initWithFrame:CGRectMake(15, 0, 200, 50)];
            _yongjinLab.font = [UIFont fontWithName:FONTNAME size:20.0f];
            
            _yongjinLab.backgroundColor = [UIColor clearColor];
            _yongjinLab.textColor = [UIColor whiteColor];
            [_recommandView addSubview:_yongjinLab];
            
            _yongjinTitle = [[UILabel alloc] initWithFrame:CGRectZero];
            _yongjinTitle.backgroundColor = [UIColor clearColor];
            _yongjinTitle.textColor = [UIColor whiteColor];
            _yongjinTitle.font = [UIFont fontWithName:FONTNAME size:12.0f];
            [_recommandView addSubview:_yongjinTitle];
        }

        _yongjinLab.text = [NSString stringWithFormat:@"￥%@",[self.detailDict objectForKey:@"houseMoney"]];
        [_yongjinLab sizeToFit];
        _yongjinLab.center = CGPointMake(15 + _yongjinLab.frame.size.width/2.0f, 25);

        _yongjinTitle.frame = CGRectMake(CGRectGetMaxX(_yongjinLab.frame) + 2, _yongjinLab.frame.origin.y + 6, 40, 20);
        _yongjinTitle.text = @"佣金";
        
        _collectState = [[self.detailDict objectForKey:@"collectState"] intValue];
        
        self.hxArr = [self.detailDict arrayObjectForKey:@"picHx"];
        self.likeArr = [self.detailDict arrayObjectForKey:@"likeHouse"];
        
        _houseGroup = [self.detailDict stringObjectForKey:@"groupType"];
        
        _mainTV.hidden = NO;
        _mainTV.tableHeaderView = [self createTableHeaderView];
        [_mainTV reloadData];

    }
          failure:^(NSString *code, NSString *error)
    {
        
        [Utility hideMBProgress:self.view];
        [self showEmpty:@"点击重新加载"];
        
    }];
    
}

/**
 *	@brief	无数据显示信息
 *
 *	@param 	message 	显示内容
 *
 *	@return	N/A
 */
- (void)showEmpty:(NSString *)message
{
    if([self.view viewWithTag:1111]!=nil)
        return;
    EmptyControl *empty = [[EmptyControl alloc] initWithTitle:message frame:_mainTV.frame onClick:^{
        [self queryDetailData];
    }];
    empty.tag = 1111;
    [self.view addSubview:empty];
}

#pragma mark --------- 详情 ------------

/**
 *	@brief	楼盘基本信息
 *
 *	@return	N/A
 */
- (void)baseInfoBtnClick
{
//    if ([_houseGroup isEqualToString:@"2"])//旅游
//    {
//        [MobClick event:@"click_project_detail_t"];
//    }
//    else
//    {
//        [MobClick event:@"click_project_detail"];
//    }
    
    HWDetailBaseInfoViewController *infoCtr = [[HWDetailBaseInfoViewController alloc] init];
    infoCtr.baseInfo = self.detailDict;
    [self.navigationController pushViewController:infoCtr animated:YES];
}

#pragma mark -----------   海报  --------

/**
 *	@brief	顶部海报点击事件
 *
 *	@return	N/A
 */
- (void)topImgBtnClick
{
//    if ([_houseGroup isEqualToString:@"2"])//旅游
//    {
//        [MobClick event:@"click_house_photos_t"];
//    }
//    else
//    {
//        [MobClick event:@"click_house_photos"];
//    }
    
    UIScrollView *scrollV = (UIScrollView *)[_mainTV.tableHeaderView viewWithTag:TOP_IMAGESCROLL_TAG];
    int page = scrollV.contentOffset.x/scrollV.frame.size.width;
    [self topImgBtnClickDefaultPage:page tabNum:1];
}

/**
 *	@brief	根据页码，初始tab上button的位置
 *
 *	@param 	page 	页码
 *	@param 	num 	初始tab button 的位置
 *
 *	@return	N/A
 */
- (void)topImgBtnClickDefaultPage:(int)page tabNum:(int)num
{
    //NSLog(@"顶部海报点击");
    ScanImageViewCtr *scanCtr = [[ScanImageViewCtr alloc] init];
    scanCtr.hxArray = [self.detailDict arrayObjectForKey:@"picHx"];
    scanCtr.xgArray = [self.detailDict arrayObjectForKey:@"housePic"];
    scanCtr.jtArray = [self.detailDict arrayObjectForKey:@"picJt"];
    scanCtr.sjArray = [self.detailDict arrayObjectForKey:@"picSj"];
    scanCtr.ybArray = [self.detailDict arrayObjectForKey:@"picYb"];
    scanCtr.page = page;
    scanCtr.navigationItem.titleView = [Utility navTitleView:[detailDict stringObjectForKey:@"houseName"]];
    UINavigationController *nav = [[UINavigationController alloc] initWithRootViewController:scanCtr];
    [self presentViewController:nav animated:YES completion:nil];
    [scanCtr setDefaultTabBtn:num];
}

#pragma mark ------------   地图  ----------

/**
 *	@brief	显示地图事件
 *
 *	@return	N/A
 */
- (void)locationBtnClick
{
//    if ([_houseGroup isEqualToString:@"2"])//旅游
//    {
//        [MobClick event:@"click_address_t"];
//    }
//    else
//    {
//        [MobClick event:@"click_address"];
//    }
    
    // 计算经纬度  如果取值范围错误 默认改为 0，0
    NSString *lat = [NSString stringWithFormat:@"%@",[detailDict objectForKey:@"houseX"]]; // 纬度
    NSString *lon = [NSString stringWithFormat:@"%@",[detailDict objectForKey:@"houseY"]]; // 经度
    
    float fLat = [lat floatValue];
    float fLon = [lon floatValue];
    BOOL isTrue = YES;
    if (fLat >= 90 || fLat <= -90)
    {
        isTrue = NO;
    }
    if (fLon >= 180 || fLon <= -180)
    {
        isTrue = NO;
    }
    CLLocationCoordinate2D loctionCoor;
    if (!isTrue)
    {
        loctionCoor = CLLocationCoordinate2DMake(0, 0);
    }
    else
    {
        loctionCoor = CLLocationCoordinate2DMake(fLat, fLon);
    }
    
    if (([lat isEqualToString:@"0"] && [lon isEqualToString:@"0"]) || !isTrue)
    {
        [Utility showToastWithMessage:@"无楼盘位置信息" inView:self.view];
        return;
    }
    
    GoogleMapViewCtr *googleMap = [[GoogleMapViewCtr alloc] init];
    googleMap.coordinate = loctionCoor;
    googleMap.annotationTitle = [detailDict stringObjectForKey:@"houseName"];
    googleMap.address = [detailDict stringObjectForKey:@"houseAddress"];
    [self.navigationController pushViewController:googleMap animated:NO];

}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section == 0)
    {
        HWDetailFirstRowCell *cell = (HWDetailFirstRowCell *)[tableView dequeueReusableCellWithIdentifier:@"firstCell"];
        if (!cell)
        {
            cell = [[HWDetailFirstRowCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"firstCell"];
        }
        if (indexPath.row == 0)
        {
            cell.headImgV.image = [UIImage imageNamed:@"创建小区-位置"];
            cell.titleLab.text = @"楼盘位置";
            NSString *address = [self.detailDict stringObjectForKey:@"houseAddress"];
            cell.subTitleLab.text = [address isEqualToString:@""] ? @"" : [NSString stringWithFormat:@"（%@）",address];
        }
        else
        {
            cell.headImgV.image = [UIImage imageNamed:@"icon_xiangqing"];
            cell.titleLab.text = @"项目详情";
            cell.subTitleLab.text = nil;
        }
        
        return cell;
    }
    else if (indexPath.section == 1)
    {
        if (self.hxArr.count > 3)
        {
            if ((_isExpand && indexPath.row == self.hxArr.count) ||
                (!_isExpand && indexPath.row == 3))
            {
                HWMoreButtonCell *cell = (HWMoreButtonCell *)[tableView dequeueReusableCellWithIdentifier:@"moreCell"];
                if (!cell)
                {
                    cell = [[HWMoreButtonCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"moreCell"];
                }
                cell.selectionStyle = UITableViewCellSelectionStyleNone;
                if (_isExpand)
                {
                    cell.titleLabel.text = @"收起更多";
                    cell.arrowImgV.image = [UIImage imageNamed:@"icon_jianotu_shang"];
                }
                else
                {
                    cell.titleLabel.text = @"显示更多";
                    cell.arrowImgV.image = [UIImage imageNamed:@"icon_jianotu_xia"];
                }
                cell.delegate = self;
                return cell;
            }
            
        }
        
        NSDictionary *hxDic = [self.hxArr objectAtIndex:indexPath.row];
        
        HWDetailHouseTypeCell *cell = (HWDetailHouseTypeCell *)[tableView dequeueReusableCellWithIdentifier:@"tpyeCell"];
        if (!cell)
        {
            cell = [[HWDetailHouseTypeCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"typeCell"];
        }
        
//        [cell.headImgV setImageWithURL:[NSURL URLWithString:[hxDic stringObjectForKey:@"pic"]] placeholderImage:[UIImage imageNamed:@"ic_empty"] options:SDWebImageProgressiveDownload];
        
        __weak UIImageView *blockImgV = cell.headImgV;
        [cell.headImgV setImageWithURL:[NSURL URLWithString:[hxDic stringObjectForKey:@"pic"]] placeholderImage:[UIImage imageNamed:@"redDefault"] options:SDWebImageRefreshCached|SDWebImageRetryFailed completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType) {
            if (error)
            {
                NSLog(@"Error : load image fail.");
                blockImgV.image = [UIImage imageNamed:@"redDefault"];
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
        
        cell.titleLab.text = [hxDic stringObjectForKey:@"room"];
        cell.subTitleLab.text = [hxDic stringObjectForKey:@"area"];
        cell.secondSubLab.text = [NSString stringWithFormat:@"%@㎡",[hxDic objectForKey:@"reference"]];
        
        return cell;
    }
    else if (indexPath.section == 2)
    {
        HWHouseSourceCell *cell = (HWHouseSourceCell *)[tableView dequeueReusableCellWithIdentifier:@"sourceCell"];
        if (!cell)
        {
            cell = [[HWHouseSourceCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"sourceCell"];
        }
        
        NSDictionary *dic = [self.likeArr objectAtIndex:indexPath.row];
        
//        [cell.headImgV setImageWithURL:[NSURL URLWithString:[dic stringObjectForKey:@"housePic"]] placeholderImage:[UIImage imageNamed:@"ic_empty"] options:SDWebImageProgressiveDownload];
        
        __weak UIImageView *blockImgV = cell.headImgV;
        [cell.headImgV setImageWithURL:[NSURL URLWithString:[dic stringObjectForKey:@"housePic"]] placeholderImage:[UIImage imageNamed:@"redDefault"] options:SDWebImageRefreshCached|SDWebImageRetryFailed completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType) {
            if (error)
            {
                NSLog(@"Error : load image fail.");
                blockImgV.image = [UIImage imageNamed:@"redDefault"];
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
        
        cell.titleLabel.text = [NSString stringWithFormat:@"%@",[dic stringObjectForKey:@"houseName"]];
        
        NSString *str = [dic stringObjectForKey:@"houseArea"];
        if (![str isEqualToString:@""]) {
            str = [NSString stringWithFormat:@"[%@]",[dic stringObjectForKey:@"houseArea"]];
        }
        cell.delegate = self;
        
        cell.msgLabel.text = [NSString stringWithFormat:@"%@ %@",[dic objectForKey:@"housePrice"],str];
        cell.youhuiLabel.text = [NSString stringWithFormat:@"%@",[dic stringObjectForKey:@"houseMoney"]];
        
        [cell setType:[dic objectForKey:@"groupType"]];
        
        
        return cell;
    }
    
    return nil;
    
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section == 0)
    {
        return 50;
    }
    else if (indexPath.section == 1)
    {
        if (self.hxArr.count > 3)
        {
            
            if ((_isExpand && indexPath.row == self.hxArr.count) ||
                (!_isExpand && indexPath.row == 3))
            {
                return 60;
            }
        }
        return 90;
    }
    return 80;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    if (indexPath.section == 0)
    {
        if (indexPath.row == 0)
        {
            // 楼盘地图
            [self locationBtnClick];
        }
        else if (indexPath.row == 1)
        {
            // 楼盘信息
            [self baseInfoBtnClick];
        }
    }
    else if (indexPath.section == 1)
    {
//        [MobClick event:@"click_house_type"];
//        
//        if ([_houseGroup isEqualToString:@"2"])//旅游
//        {
//            [MobClick event:@"click_house_type_t"];
//        }
//        else
//        {
//            [MobClick event:@"click_house_type"];
//        }
        
        [self topImgBtnClickDefaultPage:indexPath.row tabNum:0];
    }
    else if (indexPath.section == 2)
    {
//        if ([_houseGroup isEqualToString:@"2"])//旅游
//        {
//            [MobClick event:@"click_around_house_t"];
//        }
//        else
//        {
//            [MobClick event:@"click_around_house"];
//        }
        
        HWHouseDetailViewController *houseVC = [[HWHouseDetailViewController alloc] init];
        houseVC.houseId = [[self.likeArr objectAtIndex:indexPath.row] stringObjectForKey:@"houseId"];
        [self.navigationController pushViewController:houseVC animated:YES];
    }
    
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 3;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (section == 0)
    {
        return 2;
    }
    else if (section == 1)
    {
        if (self.hxArr.count > 3)
        {
            if (_isExpand)
            {
                return self.hxArr.count + 1;
            }
            return 4;
        }
        return self.hxArr.count;
    }
    else if (section == 2)
    {
        return self.likeArr.count;
    }
    return 0;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 45;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    UIView *headerView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, 45)];
    headerView.backgroundColor = UIColorFromRGB(0xf5f5f5);
    
    UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(15, 1, 250, 45 - 2)];
    label.backgroundColor = [UIColor clearColor];
    if (section == 0)
    {
        label.text = @"楼盘信息";
    }
    else if (section == 1)
    {
        label.text = [NSString stringWithFormat:@"主力户型（共%d个）",self.hxArr.count];
    }
    else if (section == 2)
    {
        label.text = [NSString stringWithFormat:@"可能喜欢（共%d个）",self.likeArr.count];
    }
    label.font = [UIFont fontWithName:FONTNAME size:16.0f];
    label.textColor = THEME_COLOR_SMOKE;
    [headerView addSubview:label];
    
    UIView *downLine = [[UIView alloc] initWithFrame:CGRectMake(0, 45.0f - 0.5f, self.view.frame.size.width, 0.5)];
    downLine.backgroundColor = THEME_COLOR_LINE;
    [headerView addSubview:downLine];
    
    return headerView;
}


#pragma mark ---------------- HWHouseSourceCell delegate ---------------

/**
 *	@brief	tableview cell中推荐按钮 代理事件 ， “可能喜欢”中cell的回调
 *
 *	@param 	cell 	实例变量
 *
 *	@return	N/A
 */
- (void)didClickRecommandBtnWithCell:(HWHouseSourceCell *)cell
{
    // push 推荐页面
//    NSIndexPath *index = [_mainTV indexPathForCell:cell];
//    NSDictionary *dic = [self.likeArr objectAtIndex:index.row];
//    HWecommendController *recommendVC = [[HWecommendController alloc] init];
//    recommendVC.targetHouses = [NSMutableArray arrayWithObject:dic];
//    [self.navigationController pushViewController:recommendVC animated:YES];
}

/**
 *	@brief	主力户型 显示更多
 *
 *	@return	N/A
 */
- (void)didClickMoreButton
{
//    if ([_houseGroup isEqualToString:@"2"])//旅游
//    {
//        [MobClick event:@"click_more_house_type_t"];
//    }
//    else
//    {
//        [MobClick event:@"click_more_house_type"];
//    }
    _isExpand = !_isExpand;
    [_mainTV reloadData];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (void)dealloc
{
    NSLog(@"dealloc");
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
