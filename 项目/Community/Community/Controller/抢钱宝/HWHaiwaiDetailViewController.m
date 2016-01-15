//
//  HWHaiwaiDetailViewController.m
//  HaoWu_4.0
//
//  Created by caijingpeng.haowu on 14-5-30.
//  Copyright (c) 2014年 caijingpeng. All rights reserved.
//

#import "HWHaiwaiDetailViewController.h"
#import "HWDoubleLabelCell.h"
#import "HWDetailFirstRowCell.h"
#import "GoogleMapViewCtr.h"
#import "HWDetailBaseInfoViewController.h"
#import "ScanImageViewCtr.h"
#import "HWHaiwaiBaseInfoViewController.h"
#import "AppDelegate.h"
#import "EmptyControl.h"

#define DETAIL_IMG_HEIGHT   250
#define TOP_IMAGESCROLL_TAG 6101
#define TOP_PAGECONTROL_TAG 8888

@interface HWHaiwaiDetailViewController ()
{
    UITableView *_mainTV;
    int _collectState; // 收藏状态 
    UILabel *_yongjinLab;
    UILabel *_yongjinTitle;
    UIWebView *_webView;
    UIView *_recommandView;
}
@property (nonatomic, strong) NSDictionary *detailDict;
@end

@implementation HWHaiwaiDetailViewController
@synthesize detailDict;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewWillAppear:(BOOL)animated
{
    self.navigationItem.titleView =[Utility navTitleView:@"房源详情"];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.view.backgroundColor = [UIColor whiteColor];
    self.navigationItem.leftBarButtonItem = [Utility navLeftBackBtn:self action:@selector(backBtnClick)];
    
    CGRect rect = CGRectMake(0, 0, kScreenWidth, IOS7 ? (CONTENT_HEIGHT - 50) : (CONTENT_HEIGHT - 30));
    
    _mainTV = [[UITableView alloc] initWithFrame:rect style:UITableViewStylePlain];
    _mainTV.separatorStyle = UITableViewCellSeparatorStyleSingleLine;
    _mainTV.backgroundColor = [UIColor clearColor];
    _mainTV.backgroundView = nil;
    _mainTV.delegate = self;
    _mainTV.dataSource = self;
    _mainTV.hidden = YES;
    [self.view addSubview:_mainTV];
    
    [self queryDetailData];
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

/**
 *	@brief	加载海外楼盘信息
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
    
    [manager POST:kHouseDetail parameters:dict queue:nil success:^(id responseObject) {
        
//        //NSLog(@"detail responseObj:%@",responseObject);
        [Utility hideMBProgress:self.view];
        self.detailDict = [responseObject dictionaryObjectForKey:@"data"];
//        _collectState = [[[responseObject objectForKey:@"data"] objectForKey:@"has_attention"] intValue];
        
        if (_recommandView == nil)
        {
            _recommandView = [[UIView alloc] initWithFrame:CGRectMake(0, CGRectGetMaxY(_mainTV.frame), kScreenWidth, 50)];
            _recommandView.backgroundColor = THEME_COLOR_ORANGE;
            [self.view addSubview:_recommandView];
            
            _yongjinLab = [[UILabel alloc] initWithFrame:CGRectMake(15, 0, 200, 50)];
            _yongjinLab.font = [UIFont fontWithName:FONTNAME size:20.0f];
            
            _yongjinLab.backgroundColor = [UIColor clearColor];
            _yongjinLab.textColor = [UIColor whiteColor];
            [_recommandView addSubview:_yongjinLab];
            
            _yongjinTitle = [[UILabel alloc] initWithFrame:CGRectZero];
            _yongjinTitle.textColor = [UIColor whiteColor];
            _yongjinTitle.font = [UIFont fontWithName:FONTNAME size:12.0f];
            [_recommandView addSubview:_yongjinTitle];
            
        }

        _yongjinLab.text = [NSString stringWithFormat:@"￥%@",[self.detailDict objectForKey:@"houseJianjin"]];
        
        [_yongjinLab sizeToFit];
        _yongjinLab.center = CGPointMake(15 + _yongjinLab.frame.size.width/2.0f, 25);
        
        _yongjinTitle.frame = CGRectMake(CGRectGetMaxX(_yongjinLab.frame) + 2, _yongjinLab.frame.origin.y + 6, 40, 20);
        _yongjinTitle.text = @"佣金";
        
        _collectState = [[self.detailDict objectForKey:@"collectState"] intValue];
        
        _mainTV.hidden = NO;
        _mainTV.tableHeaderView = [self createTableHeaderView];
        [_mainTV reloadData];
        
        
    } failure:^(NSString *code, NSString *error) {
        
        [Utility hideMBProgress:self.view];
        [self showEmpty:@"点击重新加载"];
        
    }];
    
    
}

/**
 *	@brief	初始化海报内容
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
    for (int i=0; i<picArray.count; i++) {
        UIImageView *topImgview = [[UIImageView alloc] initWithFrame:CGRectMake(i*imgScroll.frame.size.width, 0, imgScroll.frame.size.width, imgScroll.frame.size.height)];
//        [topImgview setImageWithURL:/*[Utility imageURL:[picArray objectAtIndex:i]]*/[NSURL URLWithString:[picArray objectAtIndex:i]] placeholderImage:[UIImage imageNamed:@"ic_empty"] options:SDWebImageProgressiveDownload];
        __weak UIImageView *blockImgV = topImgview;
        [topImgview setImageWithURL:[NSURL URLWithString:[picArray objectAtIndex:i]] placeholderImage:[UIImage imageNamed:@"redDefault"] options:SDWebImageRefreshCached|SDWebImageRetryFailed completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType) {
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
    pageCtr.pageIndicatorTintColor = UIColorFromRGB(0xb8b8b8);
    pageCtr.currentPageIndicatorTintColor = UIColorFromRGB(0x8ACF1C);
    pageCtr.numberOfPages = picArray.count;
    pageCtr.frame = CGRectMake(0, imgScroll.frame.origin.y + imgScroll.frame.size.height - 36, imgScroll.frame.size.width, 40);
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
    
    
    UILabel *countLabel = [[UILabel alloc] initWithFrame:CGRectZero];
    countLabel.textColor = [UIColor whiteColor];
    countLabel.font = [UIFont fontWithName:FONTNAME size:9];
    countLabel.backgroundColor = [UIColor clearColor];
    countLabel.text = [NSString stringWithFormat:@"%d",(hxArray.count + xgArray.count + jtArray.count + sjArray.count + ybArray.count)];
    [countLabel sizeToFit];
    countLabel.center = CGPointMake(kScreenWidth - countLabel.frame.size.width / 2 - 5, infoView.frame.size.height - 10);
    [infoView addSubview:countLabel];
    
//    UIImageView *picImgV = [[UIImageView alloc] initWithFrame:CGRectMake(countLabel.frame.origin.x - 20, countLabel.frame.origin.y, 15, 10)];
//    picImgV.backgroundColor = [UIColor redColor];
//    [infoView addSubview:picImgV];
    
    UIImageView *picImgV = [[UIImageView alloc] initWithFrame:CGRectMake(countLabel.frame.origin.x - 20 - 3, countLabel.frame.origin.y - 5, 15, 15)];
    picImgV.backgroundColor = [UIColor clearColor];
    picImgV.image = [UIImage imageNamed:@"pictureCount"];
    [infoView addSubview:picImgV];
    
    
    // ------ 房价 楼盘 ------
    
    UIView *houseView = [[UIView alloc] initWithFrame:CGRectMake(0, CGRectGetMaxY(imgScroll.frame), kScreenWidth, 75)];
    houseView.backgroundColor = [UIColor whiteColor];
    [headerView addSubview:houseView];
    
    UILabel *houseName = [[UILabel alloc] initWithFrame:CGRectMake(15, 15, kScreenWidth - 30, 20)];
    houseName.font = [UIFont fontWithName:FONTNAME size:17];
    houseName.textColor = [UIColor blackColor];
    houseName.text = [NSString stringWithFormat:@"%@",[self.detailDict stringObjectForKey:@"houseName"]];
//    houseName.text = [];
    [houseView addSubview:houseName];
    [houseName sizeToFit];
    
    UILabel *areaLab = [[UILabel alloc] initWithFrame:CGRectMake(CGRectGetMaxX(houseName.frame)+5, CGRectGetMinY(houseName.frame) + 2, 100, 20)];
    areaLab.font = [UIFont fontWithName:FONTNAME size:13.0f];
    areaLab.textColor = THEME_COLOR_TEXT;
//    areaLab.text = @"[吴中区]";
    areaLab.text = [NSString stringWithFormat:@"[%@]",[self.detailDict stringObjectForKey:@"houseRegion"]];
    [houseView addSubview:areaLab];
    
    UILabel *priceLab = [[UILabel alloc] initWithFrame:CGRectMake(15, houseView.frame.size.height - 10 - 20, 240, 20)];
    priceLab.font = [UIFont fontWithName:FONTNAME size:12.0f];
    priceLab.textColor = THEME_COLOR_TEXT;
//    priceLab.text = [self.detailDict stringObjectForKey:@"housePrice"];
    
    NSMutableString *price = [NSMutableString stringWithFormat:@"均价%@",[self.detailDict stringObjectForKey:@"housePrice"]];
    
    // 计算字符串中数字的位置 及长度
    int l = 0;//位置
    int r = 0;// 长度
    for (int i = 0; i < price.length; i++) {
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
    [attributeString setAttributes:@{NSForegroundColorAttributeName : THEME_COLOR_ORANGE,   NSFontAttributeName : [UIFont fontWithName:FONTNAME size:17.0f] , } range:NSMakeRange(l, r)];
    
    if([[UIDevice currentDevice].systemVersion floatValue]>=6.0)
    {
        priceLab.attributedText = attributeString;
    }
    else {
        priceLab.text = price;
        priceLab.textColor = THEME_COLOR_ORANGE;
    }
    [houseView addSubview:priceLab];
    
    UIView *houseLine = [[UIView alloc] initWithFrame:CGRectMake(0, houseView.frame.size.height - 0.5f, kScreenWidth, 0.5f)];
    houseLine.backgroundColor = THEME_COLOR_LINE;
    [houseView addSubview:houseLine];
    
    return headerView;
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

#pragma mark --------- 详情 ------------

/**
 *	@brief	楼盘基本信息
 *
 *	@return	N/A
 */
- (void)baseInfoBtnClick
{
    //楼盘基本信息
//    [MobClick event:@"click_project_detail_o"];
    HWHaiwaiBaseInfoViewController *infoCtr = [[HWHaiwaiBaseInfoViewController alloc] init];
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
//    [MobClick event:@"click_house_photos_o"];
    UIScrollView *scrollV = (UIScrollView *)[_mainTV.tableHeaderView viewWithTag:TOP_IMAGESCROLL_TAG];
    int page = scrollV.contentOffset.x/scrollV.frame.size.width;
    [self topImgBtnClickDefaultPage:page];
}

/**
 *	@brief	根据默认显示页码弹出显示大图页面
 *
 *	@param 	page 	页码
 *
 *	@return	N/A
 */
- (void)topImgBtnClickDefaultPage:(int)page
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
    
    [scanCtr setDefaultTabBtn:1];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section == 0) {
        
        HWDoubleLabelCell *cell = (HWDoubleLabelCell *)[tableView dequeueReusableCellWithIdentifier:@"double"];
        if (!cell)
        {
            cell = [[HWDoubleLabelCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"double"];
        }
        cell.leftLabel.frame = CGRectMake(12, 7, 200, 16);
        cell.rightLabel.frame = CGRectMake(0, 0, 0, 16);
        if (indexPath.row == 0)
        {
            cell.leftLabel.text = @"房源类型：";
            cell.rightLabel.text = [NSString stringWithFormat:@"%@",[self.detailDict stringObjectForKey:@"houseProperty"]];
        }
        else if (indexPath.row == 1)
        {
            cell.leftLabel.text = @"标签：";
            cell.rightLabel.text = [NSString stringWithFormat:@"%@",[[self.detailDict objectForKey:@"haiwai"] stringObjectForKey:@"housingLabel"]];
        }
        else if (indexPath.row == 2)
        {
            cell.leftLabel.text = @"总价：";
            cell.rightLabel.text = [self.detailDict stringObjectForKey:@"housePrice"];
        }
        else if (indexPath.row == 3)
        {
            cell.leftLabel.text = @"面积：";
            cell.rightLabel.text = [NSString stringWithFormat:@"室内面积：%@ 室外面积：%@",[[self.detailDict objectForKey:@"haiwai"] stringObjectForKey:@"indoorArea"],[[self.detailDict objectForKey:@"haiwai"] stringObjectForKey:@"outdoorArea"]];
        }
        else if (indexPath.row == 4)
        {
            cell.leftLabel.text = @"户型：";
            cell.rightLabel.text = [NSString stringWithFormat:@"%@",[[self.detailDict objectForKey:@"haiwai"] stringObjectForKey:@"room"]];;
        }
//        else if (indexPath.row == 5) {
//            cell.leftLabel.text = @"物业类型：";
//            cell.rightLabel.text = [NSString stringWithFormat:@"%@",[self.detailDict stringObjectForKey:@"houseProperty"]];
//        }
        else if (indexPath.row == 5)
        {
            cell.leftLabel.text = @"编号：";
            cell.rightLabel.text = [self.detailDict stringObjectForKey:@"housingNumbers"];
        }
        
        [cell frameToFit];
        
        return cell;
    }
    else if (indexPath.section == 1)
    {
        HWDetailFirstRowCell *cell = (HWDetailFirstRowCell *)[tableView dequeueReusableCellWithIdentifier:@"firstCell"];
        if (!cell)
        {
            cell = [[HWDetailFirstRowCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"firstCell"];
        }
        if (indexPath.row == 0)
        {
            cell.headImgV.image = [UIImage imageNamed:@"icon_loupan"];
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
    else if (indexPath.section == 2)
    {
        UITableViewCell *cell = (UITableViewCell *)[tableView dequeueReusableCellWithIdentifier:@"cell"];
        if (!cell)
        {
            cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"cell"];
        }
        cell.textLabel.text = [NSString stringWithFormat:@"%@",[[self.detailDict objectForKey:@"haiwai"] stringObjectForKey:@"propertyFeatures"]];;
        cell.textLabel.font = [UIFont fontWithName:FONTNAME size:13.0f];
        return cell;
    }
    else if (indexPath.section == 3)
    {
        HWCallCell *cell = (HWCallCell *)[tableView dequeueReusableCellWithIdentifier:@"callcell"];
        if (!cell)
        {
            cell = [[HWCallCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"callcell"];
        }
        cell.delegate = self;
        cell.titleLab.text = @"咨询电话";
        return cell;
    }
    
    return nil;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section == 0)
    {
        return 30;
    }
    else if (indexPath.section == 3)
    {
        return 60;
    }
    return 50;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    if (indexPath.section == 1)
    {
        if (indexPath.row == 0)
        {
//            [MobClick event:@"click_address_o"];
            
            // 计算经纬度 ， 如果取值错误 默认 处理为0，0
            NSString *lat = [NSString stringWithFormat:@"%@",[detailDict objectForKey:@"houseX"]]; //经度
            NSString *lon = [NSString stringWithFormat:@"%@",[detailDict objectForKey:@"houseY"]]; // 纬度
            
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
        else if (indexPath.row == 1)
        {
            [self baseInfoBtnClick];
        }
    }
    
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 4;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (section == 0)
    {
        return 6;
    }
    else if (section == 1)
    {
        return 2;
    }
    else
    {
        return 1;
    }
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    if (section == 0 || section == 3)
    {
        return 10;
    }
    return 30;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    int height;
    if (section == 0 || section == 3)
    {
        height = 10;
    }
    else
    {
        height = 30;
    }
    
    UIView *headerView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, height)];
    headerView.backgroundColor = UIColorFromRGB(0xf5f5f5);
    
    if (section == 1 || section == 2)
    {
        UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(15, 1, 250, 28)];
        
        if (section == 1)
        {
            label.text = @"楼盘信息";
        }
        else if (section == 2)
        {
            label.text = @"物业特色";
        }
        label.backgroundColor = [UIColor clearColor];
        label.font = [UIFont fontWithName:FONTNAME size:15.0f];
        [headerView addSubview:label];
    }

    UIView *downLine = [[UIView alloc] initWithFrame:CGRectMake(0, height - 0.5f, self.view.frame.size.width, 0.5f)];
    downLine.backgroundColor = THEME_COLOR_LINE;
    [headerView addSubview:downLine];
    
    return headerView;
}

/**
 *	@brief	拨号按钮回调事件
 *
 *	@return	N/A
 */
- (void)didClickCallButton
{
//    [MobClick event:@"call_manager_o"];
    id obj = [self.detailDict stringObjectForKey:@"xmjl_mobile"];
    
    if (!_webView)
    {
        _webView = [[UIWebView alloc]init];
        [self.view addSubview:_webView];
    }
    [_webView loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"tel:%@",([obj isEqualToString:@""]?@"4001808116":obj)]]]];
}

- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    if (buttonIndex==1)
    {
        NSString *obj = [self.detailDict stringObjectForKey:@"xmjl_mobile"];
        
        [[UIApplication sharedApplication] openURL:[NSURL URLWithString:[NSString stringWithFormat:@"tel://%@",([obj isEqualToString:@""] ? @"4001808116" : (NSString *)obj)]]];
    }
}

/**
 *	@brief	返回事件
 *
 *	@return	N/A
 */
- (void)backBtnClick
{
    [self.navigationController popViewControllerAnimated:YES];
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
