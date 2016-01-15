//
//  HWPropertyDetailVC.m
//  Community
//
//  Created by lizhongqiang on 14-9-1.
//  Copyright (c) 2014年 caijingpeng. All rights reserved.
//

#import "HWPropertyDetailVC.h"
#import "HWAudioPlayCenter.h"
#import "HWPublishViewController.h"
#import "HWDetailViewController.h"

#import "HWAnnouncementViewController.h"

@interface HWPropertyDetailVC ()
{
   
    
    UIFont *bigFont;            //大字体
    UIFont *smallFont;          //小字体
    
    UIButton *btn;
}
@end

@implementation HWPropertyDetailVC
@synthesize headView;
@synthesize tipAlert;
@synthesize propertyId;
- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
        
    }
    return self;
}

- (void)back
{
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)rightItem
{
    [MobClick event:@"click_more"];
    UIActionSheet *actionSheet = [[UIActionSheet alloc] initWithTitle:nil delegate:self cancelButtonTitle:@"取消" destructiveButtonTitle:nil otherButtonTitles:@"完善物业资料", nil];
    [actionSheet showInView:self.view];
}

-(void)actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex
{
    NSLog(@"%d",buttonIndex);
    if (buttonIndex == 0)
    {
        [MobClick event:@"click_change_property"];
        HWPerfectPropertyDataVC *perfect = [[HWPerfectPropertyDataVC alloc] init];
        perfect.isProperty = YES;
        perfect.propertyId = propertyId;
        [self.navigationController pushViewController:perfect animated:YES];
    }
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.navigationItem.titleView = [Utility navTitleView:@"物业详情"];
    self.navigationItem.leftBarButtonItem = [Utility navLeftBackBtn:self action:@selector(back)];
    
    
    
    bigFont = [UIFont fontWithName:FONTNAME size:THEME_FONT_BIG];
    smallFont = [UIFont fontWithName:FONTNAME size:THEME_FONT_SMALL];
    
    headView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, 480)];
    [self.headView setBackgroundColor:[UIColor whiteColor]];

    if (IOS7)
    {
        self.baseTableView.frame = CGRectMake(0, 0, kScreenWidth, self.view.frame.size.height - 64);
    }
    else
    {
        self.baseTableView.frame = CGRectMake(0, 0, kScreenWidth, self.view.frame.size.height - 44);
    }
    
    self.baseTableView.backgroundColor = [UIColor clearColor];
    self.baseTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    self.isNeedHeadRefresh = YES;
    _currentPage = 0;
    [self queryListData];
    
    self.baseTableView.tableHeaderView = headView;
    
    btn = [UIButton buttonWithType:UIButtonTypeCustom];
    btn.alpha = 0;
    [btn setFrame:CGRectMake(kScreenWidth - 60, self.view.frame.size.height - 130, 44, 44)];
    [btn setBackgroundImage:[UIImage imageNamed:@"top"] forState:UIControlStateNormal];
    [btn addTarget:self action:@selector(btnClick:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:btn];
    
}

- (void)viewWillAppear:(BOOL)animated
{
    [self queryListData];
    [self addAudioPlayNotification];
    [self addCallStateNotification];
    
}

- (void)viewWillDisappear:(BOOL)animated
{
    if ([[HWAudioPlayCenter shareAudioPlayCenter] isPlaying])
    {
        [[HWAudioPlayCenter shareAudioPlayCenter] stop];
    }
    
    [self removeAudioPlayNotification];
    [self removeCallStateNotification];
}

- (void)btnClick:(id)sender
{
    [self.baseTableView setContentOffset:CGPointMake(0, 0) animated:YES];
}
#pragma mark -
#pragma mark 数据请求
-(void)queryListData
{
//    [Utility showMBProgress:self.view message:@"加载数据"];
    HWHTTPRequestOperationManager *manage = [HWHTTPRequestOperationManager manager];
    HWUserLogin *user = [HWUserLogin currentUserLogin];
    
    NSMutableDictionary *dict = [[NSMutableDictionary alloc] init];
    [dict setPObject:user.key forKey:@"key"];
    [dict setPObject:propertyId forKey:@"tenementId"];
    [dict setPObject:user.villageId forKey:@"valliageId"];
    [dict setPObject:[HWUserLogin currentUserLogin].userId forKey:@"userId"];
    [dict setPObject:[NSString stringWithFormat:@"%d",_currentPage] forKey:@"page"];
    [dict setPObject:[NSString stringWithFormat:@"%d",kPageCount] forKey:@"size"];
//    NSLog(@"%@",dict);
    [manage POST:kPropertyDetail parameters:dict queue:nil success:^(id responseObject) {
//        NSLog(@"%@",responseObject);
        
        HWPropertyDetailClass *detail = [[HWPropertyDetailClass alloc] initWithDictionary:[responseObject dictionaryObjectForKey:@"data"]];
        
        
        if (_currentPage == 0)
        {
            [HWCoreDataManager clearPropertyData];
            [HWCoreDataManager savePropertyData:detail];
            
            [arrType removeAllObjects];
            [arrTrack removeAllObjects];
            
            arrType = [[NSMutableArray alloc] initWithObjects:@"-1", nil];
            arrTrack = [[NSMutableArray alloc] initWithObjects:@"占个位置", nil];
            
            NSArray *array = detail.arrServiceTrack;
            for (int i = 0; i < array.count; i ++)
            {
                HWPropertyNewsClass *news = (HWPropertyNewsClass *)[array objectAtIndex:i];
                NSString *strType = news.releaseType;
                [arrType addObject:strType];
                [arrTrack addObject:news];
            }
            
        }
        else
        {
            NSArray *array = detail.arrServiceTrack;
            for (int i = 0; i < array.count; i ++)
            {
                HWPropertyNewsClass *news = (HWPropertyNewsClass *)[array objectAtIndex:i];
                NSString *strType = news.releaseType;
                [arrType addObject:strType];
                [arrTrack addObject:news];
            }
        }
        
        if (arrTrack.count == 1 || arrType.count == 1)
        {
            [arrType removeAllObjects];
            [arrTrack removeAllObjects];
        }
        
        [self loadPropertyBaseInfo:detail];
        
        if (detail.arrPropertyService.count <= 3)
        {
            arrCollect = [[NSMutableArray alloc] initWithObjects:detail.arrPropertyService, nil];
        }//NSInteger
        else
        {
            NSInteger num = detail.arrPropertyService.count / 3 + 1;
            NSInteger k = detail.arrPropertyService.count;
            for (int i = 0; i < num; i ++)
            {
                NSMutableArray *arr = [[NSMutableArray alloc] init];
                NSInteger N = (3 > k - 3 * i) ? k - 3 * i : 3;
                for (int j = 0; j < N; j ++)
                {
                    [arr addObject:[detail.arrPropertyService objectAtIndex:(3 * i + j)]];
                }
                [arrCollect addObject:arr];
            }
        }

        //@[@"上门服务",@"留言反馈",@"租售托管"]
//        NSLog(@"%@",arrCollect);
//        arrCollect = [[NSMutableArray alloc] initWithArray:@[@[@"上门服务",@"留言反馈",@"租售托管"]]];
        [self loadPropertyServer];
        
        
        //物业动态 数据
        if (detail.arrServiceTrack.count < kPageCount)
        {
            isLastPage = YES;
        }
        else
        {
            isLastPage = NO;
        }
        
        if ([detail.coStatus isEqualToString:@"1"])
        {
            self.navigationItem.rightBarButtonItem = [Utility navWalletButton:self action:@selector(rightItem)];
        }
        else
        {
            self.navigationItem.rightBarButtonItem = nil;
        }
        
        
        [self.baseTableView reloadData];
        [self doneLoadingTableViewData];
        
    } failure:^(NSString *code, NSString *error) {
//        [Utility hideMBProgress:self.view];
        [Utility showToastWithMessage:error inView:self.view];
        
        //加载缓存，代码简化下  电话几个？
        HWPropertyDetailClass *detail = [HWCoreDataManager searchAllPropertyData];
        
        [arrType removeAllObjects];
        [arrTrack removeAllObjects];
        
        arrType = [[NSMutableArray alloc] initWithObjects:@"-1", nil];
        arrTrack = [[NSMutableArray alloc] initWithObjects:@"占个位置", nil];
        
        NSArray *array = detail.arrServiceTrack;
        for (int i = 0; i < array.count; i ++)
        {
            HWPropertyNewsClass *news = (HWPropertyNewsClass *)[array objectAtIndex:i];
            NSString *strType = news.releaseType;
            [arrType addObject:strType];
            [arrTrack addObject:news];
        }
        
        if (arrTrack.count == 1 || arrType.count == 1)
        {
            [arrType removeAllObjects];
            [arrTrack removeAllObjects];
        }
        
        [self loadPropertyBaseInfo:detail];
        
        if (detail.arrPropertyService.count <= 3)
        {
            arrCollect = [[NSMutableArray alloc] initWithObjects:detail.arrPropertyService, nil];
        }//NSInteger
        else
        {
            NSInteger num = detail.arrPropertyService.count / 3 + 1;
            for (int i = 0; i < num; i ++)
            {
                NSMutableArray *arr = [[NSMutableArray alloc] init];
                NSInteger N = (3 > num - 3 * i) ? num - 3 * i : 3;
                for (int j = 0; j < N; j ++)
                {
                    [arr addObject:[detail.arrPropertyService objectAtIndex:(3 * i + j)]];
                }
                [arrCollect addObject:arr];
            }
        }
        
        //@[@"上门服务",@"留言反馈",@"租售托管"]
        NSLog(@"%@",arrCollect);
        //        arrCollect = [[NSMutableArray alloc] initWithArray:@[@[@"上门服务",@"留言反馈",@"租售托管"]]];
        [self loadPropertyServer];
        // 0 合作  1 未合作
        if ([detail.coStatus isEqualToString:@"1"])
        {
            self.navigationItem.rightBarButtonItem = [Utility navWalletButton:self action:@selector(rightItem)];
        }
        else
        {
            self.navigationItem.rightBarButtonItem = nil;
        }
        
        
        [self.baseTableView reloadData];
        [self doneLoadingTableViewData];
        
        
    }];
    
}
#pragma mark -
//加载物业基本信息
- (void)loadPropertyBaseInfo:(HWPropertyDetailClass *)detail
{
    proClass = detail;
    for (UIView *view in headView.subviews)
    {
        [view removeFromSuperview];
    }
    UIView *line = [[UIView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, 0.5)];
    [line setBackgroundColor:THEME_COLOR_LINE];
    [self.headView addSubview:line];
    
    
    UIImageView *imgProperty = [[UIImageView alloc] initWithFrame:CGRectMake(15, 10, 50, 50)];
    [imgProperty setImage:[UIImage imageNamed:@"sproperty"]];
    [self.headView addSubview:imgProperty];
    
    UILabel *labName = [[UILabel alloc] initWithFrame:CGRectMake(74, 10, 200, 21)];
    [labName setBackgroundColor:[UIColor clearColor]];
//    [labName setText:@"中海御景湾物业"];
    [labName setFont:[UIFont fontWithName:FONTNAME size:16.0f]];
    [labName setText:detail.name];
    labName.numberOfLines = 0;
    [labName sizeToFit];
    [labName setFont:bigFont];
    [self.headView addSubview:labName];
    
    
    UILabel *labelPro = [[UILabel alloc] initWithFrame:CGRectMake(CGRectGetMaxX(labName.frame) + 5, 12, 44, 16)];
    [labelPro setTextColor:THEME_COLOR_ORANGE_HIGHLIGHT];
    [labelPro setText:@"物业 "];
    labelPro.layer.cornerRadius = 8.0f;
    labelPro.layer.borderWidth = 1.0f;
    labelPro.layer.borderColor = THEME_COLOR_ORANGE.CGColor;
    [labelPro setTextAlignment:NSTextAlignmentCenter];
    [labelPro setFont:[UIFont fontWithName:FONTNAME size:12.0f]];
    [self.headView addSubview:labelPro];
    
    
    UILabel *labInfo = [[UILabel alloc] initWithFrame:CGRectMake(74, CGRectGetMaxY(labName.frame) + 5, kScreenWidth - 90, 21)];
    [labInfo setBackgroundColor:[UIColor clearColor]];
//    [labInfo setText:@"一级资质等级物业，诚意为中海御景业主服务"];
    [labInfo setText:detail.intro];
    [labInfo setFont:smallFont];
    [labInfo setTextColor:THEME_COLOR_TEXT];
    [labInfo setNumberOfLines:0];
    [labInfo sizeToFit];
    [self.headView addSubview:labInfo];
    float infoHeight = labInfo.frame.size.height;
    NSLog(@"%f",infoHeight);
//    CGSize sizeLabInfo = [labInfo.text sizeWithFont:smallFont constrainedToSize:CGSizeMake(220, CGFLOAT_MAX)];
    if (infoHeight < 35)
    {
        heightV = 80.0f;
    }
    else
    {
        heightV = infoHeight + 40;
    }
    
    UIView *linePro = [[UIView alloc] initWithFrame:CGRectMake(0, heightV, kScreenWidth, 0.5)];
    [linePro setBackgroundColor:THEME_COLOR_LINE];
    [self.headView addSubview:linePro];
    
    heightV += 10.0f;
    
    UIButton *btnPhone = [UIButton buttonWithType:UIButtonTypeCustom];
    [btnPhone setFrame:CGRectMake(kScreenWidth - 65 - 15, heightV - 2, 65, 35)];
    [btnPhone setBackgroundColor:[UIColor clearColor]];
    [btnPhone setImage:[UIImage imageNamed:@"phone_8"] forState:UIControlStateNormal];
    [btnPhone addTarget:self action:@selector(phoneClick:) forControlEvents:UIControlEventTouchUpInside];
    [self.headView addSubview:btnPhone];
    
    UILabel *labPhone = [[UILabel alloc] initWithFrame:CGRectMake(15, heightV - 3, 220, 21)];
    [labPhone setBackgroundColor:[UIColor clearColor]];
//    [labPhone setText:detail.tenementTel];
    [labPhone setText:[self searchPhoneNumber]];
    [labPhone setTextColor:THEME_COLOR_ORANGE];
    [labPhone setFont:bigFont];     //改为苹果数字字体
    [self.headView addSubview:labPhone];
    
    heightV += 20.0f;
    UILabel *labelCallNum = [[UILabel alloc] initWithFrame:CGRectMake(15, heightV, 150, 16)];
    [labelCallNum setBackgroundColor:[UIColor clearColor]];
    [labelCallNum setTextColor:THEME_COLOR_TEXT];
    [labelCallNum setFont:smallFont];
    if ([detail.callTimes isEqualToString:@""] || [detail.callTimes isEqualToString:@"(null)"] || detail.callTimes == NULL)
    {
        detail.callTimes = @"0";
    }
    [labelCallNum setText:[NSString stringWithFormat:@"%@次拨打",detail.callTimes]];
    [self.headView addSubview:labelCallNum];
    
    heightV += 22.0f;
    
    float grayViewHeight = 0.0f;
    UIView *grayView = [[UIView alloc] init];
    [grayView setBackgroundColor:BACKGROUND_COLOR];
    
    UILabel *line1 = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, 0.5)];
    [line1 setBackgroundColor:THEME_COLOR_LINE];
    [grayView addSubview:line1];
    
    
    grayViewHeight += 10.0f;
    
    UILabel *labAddress = [[UILabel alloc] initWithFrame:CGRectMake(15, grayViewHeight, 75, 21)];
    [labAddress setBackgroundColor:[UIColor clearColor]];
    [labAddress setFont:bigFont];
    labAddress.textColor = THEME_COLOR_SMOKE;
    [labAddress setText:@"办公地址 :"];
    [grayView addSubview:labAddress];
    
    UILabel *labAddressDetail = [[UILabel alloc] initWithFrame:CGRectMake(CGRectGetMaxX(labAddress.frame) + 5.0f, grayViewHeight + 3, kScreenWidth - CGRectGetMaxX(labAddress.frame) - 5 - 15, 21)];
    [labAddressDetail setBackgroundColor:[UIColor clearColor]];
//    [labAddressDetail setText:@"吉浦路385号"];
    [labAddressDetail setText:detail.address];
//    labAddressDetail.text = @"一二三四五六七八九十一二三四五六七八九十一二三四五六七八九十一二三四五六七八九十一二三四五六七八九十";
    [labAddressDetail setTextColor:THEME_COLOR_TEXT];
    [labAddressDetail setFont:smallFont];
    labAddressDetail.numberOfLines = 0;
    [labAddressDetail sizeToFit];
    [grayView addSubview:labAddressDetail];
//    CGSize sizeAddress = [labAddressDetail.text sizeWithFont:smallFont constrainedToSize:CGSizeMake(kScreenWidth - CGRectGetMaxX(labAddress.frame) - 5 - 15, CGFLOAT_MAX)];
    float addressHeight = labAddressDetail.frame.size.height;
    if (addressHeight <= 30)
    {
        addressHeight = 30;
    }
    else
    {
        addressHeight += 10;
    }
    
    grayViewHeight += addressHeight + 5;
    
    UILabel *line3 = [[UILabel alloc] initWithFrame:CGRectMake(0, grayViewHeight, kScreenWidth, 0.5)];
    [line3 setBackgroundColor:THEME_COLOR_LINE];
    [grayView addSubview:line3];
    
    grayViewHeight += 10;
    
    UILabel *labTime = [[UILabel alloc] initWithFrame:CGRectMake(15, grayViewHeight, 75, 21)];
    [labTime setBackgroundColor:[UIColor clearColor]];
    [labTime setText:@"工作时间 :"];
    [labTime setFont:bigFont];
    labTime.textColor = THEME_COLOR_SMOKE;
    [grayView addSubview:labTime];
    
    UILabel *labTimeDetail = [[UILabel alloc] initWithFrame:CGRectMake(CGRectGetMaxX(labTime.frame) + 5, grayViewHeight + 3, kScreenWidth - CGRectGetMaxX(labTime.frame) - 5 - 15, 21)];
    [labTimeDetail setBackgroundColor:[UIColor clearColor]];
    [labTimeDetail setFont:smallFont];
    [labTimeDetail setTextColor:THEME_COLOR_TEXT];
    if ([detail.openTime isEqualToString:@"null-null"])
    {
        [labTimeDetail setText:@""];
    }
    else
    {
        [labTimeDetail setText:detail.openTime];
    }
//    labTimeDetail.text = @"一二三四五六七八九十一二三四五六七八九十一二三四五六七八九十一二三四五六七八九十一二三四五六七八九十";
    labTimeDetail.numberOfLines = 0;
    [labTimeDetail sizeToFit];
    float timeHeight = labTimeDetail.frame.size.height;
    if (timeHeight < 30)
    {
        timeHeight = 30;
    }
    else
    {
        timeHeight += 10;
    }
    [grayView addSubview:labTimeDetail];
    
    grayViewHeight += timeHeight + 5;
    
    UILabel *line4 = [[UILabel alloc] initWithFrame:CGRectMake(0, grayViewHeight - 0.5, kScreenWidth, 0.5)];
    [line4 setBackgroundColor:THEME_COLOR_LINE];
    [grayView addSubview:line4];
    
    [grayView setFrame:CGRectMake(0, heightV, kScreenWidth, grayViewHeight)];
    [self.headView addSubview:grayView];
    
    heightV += grayViewHeight;
    
}
//加载物业的服务
- (void)loadPropertyServer
{
    if (arrCollect.count != 0)
    {
        NSArray *array = arrCollect[0];
        if (array.count != 0)
        {
            //请求图片地址
            
            NSMutableDictionary *dict = [[NSMutableDictionary alloc] init];
            [dict setPObject:@"300" forKey:@"parentDictId"];
            [dict setPObject:[HWUserLogin currentUserLogin].key forKey:@"key"];
            
            HWHTTPRequestOperationManager *manage = [HWHTTPRequestOperationManager manager];
            [manage POST:kServiceBaseData parameters:dict queue:nil success:^(id responseObject) {
                NSLog(@"%@",responseObject);
                NSDictionary *dic = [responseObject dictionaryObjectForKey:@"data"];

                NSArray *arrContent = [dic arrayObjectForKey:@"content"];
                HWServiceData *serviceData = [HWServiceData getServiceData];
                for (int i = 0; i < arrContent.count; i ++)
                {
                    HWServiceBaseDataClass *base = [[HWServiceBaseDataClass alloc] initWithDictionary:arrContent[i]];
                    [serviceData.arrServiceBase addObject:base];
                }
                
            } failure:^(NSString *code, NSString *error) {
                NSLog(@"%@",error);
            }];
            
            UICollectionViewFlowLayout *collectLayout = [[UICollectionViewFlowLayout alloc] init];
            collectLayout.itemSize = CGSizeMake(90, 90);//每格子大小
            CGFloat paddingY = 10;
            CGFloat paddingX = 10;
            collectLayout.sectionInset = UIEdgeInsetsMake(paddingY, paddingX, paddingY, paddingX);//内边距
            CGFloat colWidth = (kScreenWidth - 90 * 3 - 20) / 2;
            collectLayout.minimumInteritemSpacing = colWidth; // 设置每行之间间距
            
            UICollectionView *collect = [[UICollectionView alloc] initWithFrame:CGRectMake(0, heightV + 5, kScreenWidth, arrCollect.count * 100 + 20) collectionViewLayout:collectLayout];
            [collect registerClass:[HWPropertyServerCell class] forCellWithReuseIdentifier:@"cell"];
            collect.delegate = self;
            collect.dataSource = self;
            collect.scrollEnabled = NO;
            collect.backgroundColor = [UIColor clearColor];
            [self.headView addSubview:collect];
            
            heightV += arrCollect.count * 100 + 20;
            
            UIView *line = [[UIView alloc] initWithFrame:CGRectMake(0, heightV, kScreenWidth, 0.5)];
            [line setBackgroundColor:THEME_COLOR_LINE];
            //    [line setBackgroundColor:[UIColor redColor]];
            [self.headView addSubview:line];
            
            
        }
    }
    
    
    [self.headView setFrame:CGRectMake(0, 0, kScreenWidth, heightV)];
    self.baseTableView.tableHeaderView = self.headView;
    
}

#pragma mark -
#pragma mark Audio Method

- (void)addAudioPlayNotification
{
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(downloadAudioFinish:) name:HWAudioDownloaderFinishedNotification object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(downloadAudioFailed:) name:HWAudioDownloaderFailedNotification object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(startPlayNotification:) name:HWAudioPlayCenterStartPlayNotification object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(pausePlayNotification:) name:HWAudioPlayCenterPausePlayNotification object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(stopPlayNotification:) name:HWAudioPlayCenterStopPlayNotification object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(downloadingAudio:) name:HWAudioDownloaderDownloadindNotification object:nil];
}

- (void)removeAudioPlayNotification
{
    [[NSNotificationCenter defaultCenter] removeObserver:self name:HWAudioDownloaderFinishedNotification object:nil];
    [[NSNotificationCenter defaultCenter] removeObserver:self name:HWAudioDownloaderFailedNotification object:nil];
    [[NSNotificationCenter defaultCenter] removeObserver:self name:HWAudioPlayCenterStartPlayNotification object:nil];
    [[NSNotificationCenter defaultCenter] removeObserver:self name:HWAudioPlayCenterPausePlayNotification object:nil];
    [[NSNotificationCenter defaultCenter] removeObserver:self name:HWAudioPlayCenterStopPlayNotification object:nil];
    [[NSNotificationCenter defaultCenter] removeObserver:self name:HWAudioDownloaderDownloadindNotification object:nil];
}

- (void)downloadingAudio:(NSNotification *)notification
{
    NSDictionary *dic = notification.object;
    NSIndexPath *index = [dic objectForKey:@"indexPath"];
    
    if (index != 0)
    {
        HWPropertyNewsClass *itemClass = [arrTrack pObjectAtIndex:index.row];
        itemClass.audioPlayMode = DownloadingPlayMode;
        [self.baseTableView reloadData];
    }
    
}

- (void)downloadAudioFinish:(NSNotification *)notificaiton
{
    //    NSLog(@"notification :%@ %@",notificaiton.object, [self.baseTableView indexPathsForVisibleRows]);
    //    [self.baseTableView visibleCells]
    
    NSDictionary *dic = notificaiton.object;
    NSIndexPath *index = [dic objectForKey:@"indexPath"];
    
    if (index != nil)
    {
        UITableViewCell *cell = [self.baseTableView cellForRowAtIndexPath:index];
        if ([cell isKindOfClass:[HWProNewsSoundCell class]])
        {
            [(HWProNewsSoundCell *)cell toPlay];
        }
    }
    
}

- (void)downloadAudioFailed:(NSNotification *)notificaiton
{
    NSDictionary *dic = notificaiton.object;
    NSIndexPath *index = [dic objectForKey:@"indexPath"];
    
    if (index != nil)
    {
        HWPropertyNewsClass *itemClass = [arrTrack pObjectAtIndex:index.row];
        itemClass.audioPlayMode = StopPlayMode;
        [self.baseTableView reloadData];
        
        [Utility showToastWithMessage:@"播放失败" inView:self.view];
    }
}

- (void)startPlayNotification:(NSNotification *)notificaiton
{
    NSDictionary *dic = notificaiton.object;
    NSIndexPath *index = [dic objectForKey:@"indexPath"];
    
    if (index != nil)
    {
        HWPropertyNewsClass *itemClass = [arrTrack pObjectAtIndex:index.row];
        itemClass.audioPlayMode = PlayingPlayMode;
        [self.baseTableView reloadData];
    }
}

- (void)pausePlayNotification:(NSNotification *)notificaiton
{
    NSDictionary *dic = notificaiton.object;
    NSIndexPath *index = [dic objectForKey:@"indexPath"];
    
    if (index != 0)
    {
        HWPropertyNewsClass *itemClass = [arrTrack pObjectAtIndex:index.row];
        itemClass.audioPlayMode = StopPlayMode;
        [self.baseTableView reloadData];
    }
}

- (void)stopPlayNotification:(NSNotification *)notificaiton
{
    NSDictionary *dic = notificaiton.object;
    NSIndexPath *index = [dic objectForKey:@"indexPath"];
    
    if (index != 0)
    {
        HWPropertyNewsClass *itemClass = [arrTrack pObjectAtIndex:index.row];
        itemClass.audioPlayMode = StopPlayMode;
        [self.baseTableView reloadData];
    }
    
    
}

#pragma mark -
#pragma mark collect delegate

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView
{
    return arrCollect.count;
}

//每组有多少格
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    
    return [arrCollect[section] count];
}

-(UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{

    HWPropertyServerCell *cell = (HWPropertyServerCell *)[collectionView dequeueReusableCellWithReuseIdentifier:@"cell" forIndexPath:indexPath];
    if (!cell)
    {
        cell = [[HWPropertyServerCell alloc] init];
    }
    
    [cell setProService:(HWPropertyServiceClass *)arrCollect[indexPath.section][indexPath.item]];
//    cell.bigBtn.tag = indexPath;
//    cell.indexPath = indexPath;
    cell.bigBtn.tag = indexPath.row;
    [cell.bigBtn addTarget:self action:@selector(bigBtnClick:) forControlEvents:UIControlEventTouchUpInside];
    
    return cell;
}

- (void)bigBtnClick:(id)sender
{
    UIButton *myBtn = (UIButton *)sender;
    HWPropertyServiceClass *service = (HWPropertyServiceClass *)arrCollect[0][myBtn.tag];
    
    if ([service.serviceId isEqualToString:@"301"]) //预约上门
    {
        [MobClick event:@"click_reservation"];
        HWOrderPropertyVC *order = [[HWOrderPropertyVC alloc] init];
        order.tenementId = proClass.tenementId;
        [self.navigationController pushViewController:order animated:YES];
    }
    else if ([service.serviceId isEqualToString:@"302"])    //租售委托
    {
        [MobClick event:@"click_rent"];
        HWRentsIntentionVC *intention = [[HWRentsIntentionVC alloc] init];
        intention.rootVC = self;
        [self.navigationController pushViewController:intention animated:YES];
    }
    else if ([service.serviceId isEqualToString:@"303"])    //留言反馈
    {
        [MobClick event:@"click_leavemessage"];
        HWPublishViewController *publishVC = [[HWPublishViewController alloc] init];
        publishVC.publishRoute = PropertyRoute;
        publishVC.isNeedAudio = NO;
        publishVC.isWriteAndPic = YES;
        [self.navigationController pushViewController:publishVC animated:YES];
    }
}

-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    
    HWPropertyServiceClass *service = (HWPropertyServiceClass *)arrCollect[indexPath.section][indexPath.row];
    if ([service.serviceId isEqualToString:@"301"]) //预约上门
    {
        [MobClick event:@"click_reservation"];
        HWOrderPropertyVC *order = [[HWOrderPropertyVC alloc] init];
        order.tenementId = proClass.tenementId;
        [self.navigationController pushViewController:order animated:YES];
    }
    else if ([service.serviceId isEqualToString:@"302"])    //租售委托
    {
        [MobClick event:@"click_rent"];
        HWRentsIntentionVC *intention = [[HWRentsIntentionVC alloc] init];
        intention.rootVC = self;
        [self.navigationController pushViewController:intention animated:YES];
    }
    else if ([service.serviceId isEqualToString:@"303"])    //留言反馈
    {
        [MobClick event:@"click_leavemessage"];
        HWPublishViewController *publishVC = [[HWPublishViewController alloc] init];
        publishVC.publishRoute = PropertyRoute;
        publishVC.isNeedAudio = NO;
        publishVC.isWriteAndPic = YES;
        [self.navigationController pushViewController:publishVC animated:YES];
    }
}

#pragma mark -
#pragma mark tableview delegate
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return arrType.count;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    //动态调整高度
    NSInteger index = indexPath.row;
    
    NSString *strCellType = arrType[index];
    if ([strCellType isEqualToString:@"-1"])
    {
        return 55;
    }
    else if ([strCellType isEqualToString:@"0"] || [strCellType isEqualToString:@"24"] || [strCellType isEqualToString:@"21"])
    {
        return [HWProNewsTextCell getCellHeightWithForCellDic:(HWPropertyNewsClass *)arrTrack[index]];
    }
    else if ([strCellType isEqualToString:@"1"] || [strCellType isEqualToString:@"23"])
    {
        return [HWProNewsImgCell getCellHeightWithForCellDic:(HWPropertyNewsClass *)arrTrack[index]];
    }
    else if ([strCellType isEqualToString:@"2"] || [strCellType isEqualToString:@"25"])
    {
        return [HWProNewsSoundCell getCellHeightWithForCellDic:(HWPropertyNewsClass *)arrTrack[index]];
    }
    else
    {
        return 80;
    }
    
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{

    static NSString *strIdentifier1 = @"cell1";
    static NSString *strIdentifier2 = @"cell2";
    static NSString *strIdentifier3 = @"cell3";
    static NSString *strIdentifier4 = @"cell4";
    
    NSInteger index = indexPath.row;
    NSString *strCellType = arrType[index];
    // 0 文字   1 文字+图片    2 语音
    // 24 文字      23 文字+图片    25 语音      21物业公告
    if (indexPath.row == 0)
    {
        UITableViewCell *cell = (UITableViewCell *)[tableView dequeueReusableCellWithIdentifier:strIdentifier1];
        if (!cell)
        {
            cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:strIdentifier1];
            UIImageView *img = [[UIImageView alloc] initWithFrame:CGRectMake(15, 17, 21, 21)];
            [img setImage:[UIImage imageNamed:@"property_dynamic"]];
            [cell.contentView addSubview:img];
            
            UIView *line = [[UIView alloc] initWithFrame:CGRectMake(25, 38, 1, 17)];
            [line setBackgroundColor:THEME_COLOR_LINE];
            [cell.contentView addSubview:line];
            
            UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(42, 18, 150, 21)];
            [label setBackgroundColor:[UIColor clearColor]];
            [label setFont:[UIFont fontWithName:FONTNAME size:THEME_FONT_BIG]];
            [label setTextColor:THEME_COLOR_SMOKE];
            [label setText:@"近期动态"];
            [cell.contentView addSubview:label];
            cell.userInteractionEnabled = NO;
            
            cell.backgroundColor = BACKGROUND_COLOR;
            cell.contentView.backgroundColor = BACKGROUND_COLOR;
        }
        return cell;
    }
    else
    {
        if ([strCellType isEqualToString:@"0"] || [strCellType isEqualToString:@"24"] || [strCellType isEqualToString:@"21"])
        {
            HWProNewsTextCell *cell = (HWProNewsTextCell *)[tableView dequeueReusableCellWithIdentifier:strIdentifier2];
            if (!cell)
            {
                cell = [[HWProNewsTextCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:strIdentifier2];
            }
            
            cell.news = (HWPropertyNewsClass *)arrTrack[index];
//            cell.userInteractionEnabled = NO;
            cell.backgroundColor = BACKGROUND_COLOR;
            cell.contentView.backgroundColor = BACKGROUND_COLOR;
            return cell;
            
        }
        else if ([strCellType isEqualToString:@"1"] || [strCellType isEqualToString:@"23"])
        {
            HWProNewsImgCell *cell = (HWProNewsImgCell *)[tableView dequeueReusableCellWithIdentifier:strIdentifier3];
            if (!cell)
            {
                cell = [[HWProNewsImgCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:strIdentifier3];
            }
            cell.news = (HWPropertyNewsClass *)arrTrack[index];
//            cell.userInteractionEnabled = NO;
            cell.backgroundColor = BACKGROUND_COLOR;
            cell.contentView.backgroundColor = BACKGROUND_COLOR;
            return cell;
        }
        else if ([strCellType isEqualToString:@"2"] || [strCellType isEqualToString:@"25"])
        {
            HWProNewsSoundCell *cell = (HWProNewsSoundCell *)[tableView dequeueReusableCellWithIdentifier:strIdentifier4];
            if (!cell)
            {
                cell = [[HWProNewsSoundCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:strIdentifier4];
            }
            cell.news = (HWPropertyNewsClass *)arrTrack[index];
            cell.indexPath = indexPath;
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
            cell.backgroundColor = BACKGROUND_COLOR;
            cell.contentView.backgroundColor = BACKGROUND_COLOR;
            return cell;
        }
        else
        {
            UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell"];
            if (!cell)
            {
                cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"cell"];
            }
            cell.userInteractionEnabled = NO;
            return cell;
        }
    }
    
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    if (indexPath.row != 0)
    {
        HWPropertyNewsClass *propertyClass = arrTrack[indexPath.row];
        if ([propertyClass.releaseType isEqualToString:@"21"]) {
            HWAnnouncementViewController *announceVC = [[HWAnnouncementViewController alloc]initWithCardId:propertyClass.topicId];
            [self.navigationController pushViewController:announceVC animated:YES];
        }
        else
        {
            HWDetailViewController *dymanicDetailView = [[HWDetailViewController alloc]initWithCardId:propertyClass.topicId];
            [self.navigationController pushViewController:dymanicDetailView animated:YES];
        }
        
    }
}

#pragma mark -
#pragma mark scrollview delegate
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


- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    [super scrollViewDidScroll:scrollView];
    [UIView animateWithDuration:1.0f animations:^{
        btn.alpha = 0;
    }];
}

#pragma mark - 
#pragma mark 拨打电话

- (void)addCallStateNotification
{
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(dialingNotify:) name:HWCallDetectCenterStateDialingNotification object:nil];
}

- (void)removeCallStateNotification
{
    [[NSNotificationCenter defaultCenter] removeObserver:self name:HWCallDetectCenterStateDialingNotification object:nil];
}

- (void)phoneClick:(id)sender
{
    [MobClick event:@"click_call_property"];
    
    // *** 拨打电话
    if (callWebview == nil)
    {
        callWebview = [[UIWebView alloc] init];
        [self.view addSubview:callWebview];
    }
    
    NSString *strPhone = [self searchPhoneNumber];
    
    NSLog(@"%@",strPhone);
    if (strPhone.length <= 0)
    {
        [Utility showToastWithMessage:@"这个物业还没有电话哦~" inView:self.view];
        return;
    }
    
    
    NSURL *telURL =[NSURL URLWithString:[NSString stringWithFormat:@"tel:%@",strPhone]];
    _callNum = strPhone;
    [callWebview loadRequest:[NSURLRequest requestWithURL:telURL]];
}

- (NSString *)searchPhoneNumber
{
    NSString *strResult = @"";
//    NSLog(@"%@",proClass.tenementTel);
    for (int i = 0; i < proClass.tenementTel.count; i ++)
    {
        NSString *phone = [proClass.tenementTel objectAtIndex:i];
        BOOL tel = [Utility validatePhoneTel:phone];
        if (tel)
        {
            strResult = phone;
            break;
        }
    }
    
//    if ([strResult isEqualToString:@""])
//    {
//        for (int i = 0; i < proClass.tenementTel.count; i ++)
//        {
//            NSString *phone = [proClass.tenementTel objectAtIndex:i];
//            BOOL isPhone = [Utility validateMobile:phone];
//            if (isPhone)
//            {
//                strResult = phone;
//                break;
//            }
//        }
//    }
    
    if ([strResult isEqualToString:@""])
    {
        if (proClass.tenementTel.count > 0)
        {
            strResult = [proClass.tenementTel objectAtIndex:0];
    
        }
    }
    
    return strResult;
}

- (void)dialingNotify:(NSNotification *)notification
{
    
    NSUserDefaults *userDefault = [NSUserDefaults standardUserDefaults];
    [userDefault setObject:@"1" forKey:kHaveDialing];
    
    // *** 发送接口
    NSMutableDictionary *param = [NSMutableDictionary dictionary];
    [param setPObject:[HWUserLogin currentUserLogin].key forKey:@"key"];
    [param setPObject:@"1" forKey:@"type"];         //0:拨打给店铺,1是拨打给物业
    [param setPObject:_callNum forKey:@"phoneCalled"];
    [param setPObject:[HWUserLogin currentUserLogin].tenementId forKey:@"toId"];
    [param setPObject:[HWUserLogin currentUserLogin].residendId forKey:@"residentId"];
    HWHTTPRequestOperationManager *manage = [HWHTTPRequestOperationManager manager];
    [manage POST:kMakeTelContent parameters:param queue:nil success:^(id responseObject) {
        
//        [Utility showToastWithMessage:@"cheng gong" inView:self.view];
    } failure:^(NSString *code, NSString *error) {
        NSLog(@"%@", error);
    }];
}

//- (void)dialingNotify:(NSNotification *)notification
//{
//    NSUserDefaults *userDefault = [NSUserDefaults standardUserDefaults];
//    [userDefault setObject:@"1" forKey:kHaveDialing];
//    
//    // *** 发送接口
//    
//    NSMutableDictionary *param = [NSMutableDictionary dictionary];
//    [param setPObject:[HWUserLogin currentUserLogin].key forKey:@"key"];
//    if ([strCallType isEqualToString:@"0"])
//    {
//        [param setPObject:callItem.phoneNumber forKey:@"phoneCalled"];
//        [param setPObject:callItem.shopId forKey:@"toId"];
//    }
//    else
//    {
//        [param setPObject:proItem.propertyId forKey:@"toId"];
//        [param setPObject:proItem.phoneNumber forKey:@"phoneCalled"];
//    }
//    [param setPObject:strCallType forKey:@"type"];         //0:拨打给店铺,1是拨打给物业
//    [param setPObject:[HWUserLogin currentUserLogin].residendId forKey:@"residentId"];
//    
//    HWHTTPRequestOperationManager *manage = [HWHTTPRequestOperationManager manager];
//    [manage POST:kMakeTelContent parameters:param queue:nil success:^(id responseObject) {
//        
//        NSLog(@"%@", responseObject);
//        //        [Utility showToastWithMessage:@"cheng gong" inView:self.view];
//        
//    } failure:^(NSString *error) {
//        NSLog(@"%@", error);
//        //        [Utility showToastWithMessage:@"shi bai" inView:self.view];
//    }];
//}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    
}

@end
