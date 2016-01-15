//
//  ScanImageViewCtr.m
//  HaoWu
//
//  Created by PengHuang on 13-9-16.
//  Copyright (c) 2013年 PengHuang. All rights reserved.
//

#import "ScanImageViewCtr.h"
//#import "UIImageView+AFNetworking.h"
//#import "UILabel+Utils.h"

#define SCAN_TAB_HEIGHT     44.5
#define SCAN_TAB_WIDTH      64.0
#define SCAN_SCROLL_TAG     6001
#define SCAN_COUNTLBL_TAG   6002
#define SCAN_PAGECONTROL_TAG    6003

@interface ScanImageViewCtr ()<UIScrollViewDelegate>
{
    BOOL _hideBar;
}

@end

@implementation ScanImageViewCtr
@synthesize hxArray,xgArray,jtArray,sjArray,ybArray,page = _page;

- (id)init {
    if(self = [super init]) {
        hxArray = [[NSArray alloc] init];   // 户型图
        xgArray = [[NSArray alloc] init];   // 效果图
        jtArray = [[NSArray alloc] init];   // 交通图
        sjArray = [[NSArray alloc] init];   // 实景图
        ybArray = [[NSArray alloc] init];   // 样板图
    }
    return self;
}

- (BOOL)prefersStatusBarHidden
{
    return _hideBar; //返回NO表示要显示，返回YES将hiden
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    _hideBar = NO;
    
    self.view.backgroundColor = [UIColor whiteColor];
    self.navigationController.navigationBarHidden = YES;
    _navigationView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, 44 + (IOS7 ? 20 : 0))];
    _navigationView.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:_navigationView];
    
    UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
    [btn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [btn setFrame:CGRectMake(20, (IOS7 ? 20 : 0) + (44 - 30) / 2.0f, 50, 30)];
    [btn addTarget:self action:@selector(backBtnClick) forControlEvents:UIControlEventTouchUpInside];
    [btn setImage:[UIImage imageNamed:@"navigation_back"] forState:UIControlStateNormal];
    btn.imageEdgeInsets = UIEdgeInsetsMake(5.5, 2, 5.5, 37);
    [_navigationView addSubview:btn];
    
    UILabel *label = [[UILabel alloc]initWithFrame:CGRectMake(0, _navigationView.frame.size.height - 44, kScreenWidth, 44)];
    label.text = @"图片库";
    label.font = [UIFont fontWithName:FONTNAME size:19];
    label.textAlignment = NSTextAlignmentCenter;
    [_navigationView addSubview:label];
    
    UIView *lineV = [[UIView alloc]initWithFrame:CGRectMake(0, _navigationView.frame.size.height - 0.5, kScreenWidth, 0.5)];
    lineV.backgroundColor = THEME_COLOR_TEXT;
    [_navigationView addSubview:lineV];
    
    _tabView = [[UIView alloc] initWithFrame:CGRectMake(0, self.view.bounds.size.height-SCAN_TAB_HEIGHT, self.view.frame.size.width, SCAN_TAB_HEIGHT)];
    [self.view addSubview:_tabView];
    
    for (int i =0; i<5; i++)
    {
        UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
        btn.backgroundColor = [UIColor whiteColor];
        if(i==0)
            [btn setBackgroundImage:[UIImage imageNamed:@"house_photoview_tab_bg_x"] forState:UIControlStateNormal];
        else
            [btn setBackgroundImage:[UIImage imageNamed:@"house_photoview_tab_bg"] forState:UIControlStateNormal];
        NSString *title = nil;
        if(i==0)
            title = @"户型图";
        else if(i==1)
            title = @"效果图";
        else if(i==2)
            title = @"交通图";
        else if(i==3)
            title = @"实景图";
        else if(i==4)
            title = @"样板图";
        btn.tag = 666 + i;
        [btn setTitle:title forState:UIControlStateNormal];
        btn.frame = CGRectMake(SCAN_TAB_WIDTH*i, 0, SCAN_TAB_WIDTH, SCAN_TAB_HEIGHT);
        [btn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        btn.titleLabel.font = [UIFont systemFontOfSize:14];
        [btn addTarget:self action:@selector(tabBtnClick:) forControlEvents:UIControlEventTouchUpInside];
        [_tabView addSubview:btn];
    }
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


#pragma mark - button actions
/**
 *	@brief	返回按钮事件
 *
 *	@return	N/A
 */
- (void)backBtnClick
{
    [self.navigationController dismissViewControllerAnimated:YES completion:nil];
}

/**
 *	@brief	设置默认显示按钮
 *
 *	@param 	tabNum 	按钮索引
 *
 *	@return	N/A
 */
- (void)setDefaultTabBtn:(int)tabNum

{
    UIButton *btn = (UIButton *)[self.view viewWithTag:(tabNum + 666)];
    [self tabBtnClick:btn];
    UIScrollView *scroll = (UIScrollView *)[self.view viewWithTag:SCAN_SCROLL_TAG];
    [scroll setContentOffset:CGPointMake(self.page*scroll.frame.size.width, 0)];
}

/**
 *	@brief	底部tab 按钮点击事件
 *
 *	@param 	btn
 *
 *	@return	N/A
 */
- (void)tabBtnClick:(UIButton*)btn
{
    for(UIButton *tabBtn in _tabView.subviews)
    {
        if([tabBtn isKindOfClass:[UIButton class]])
        {
            [tabBtn setBackgroundImage:[UIImage imageNamed:@"house_photoview_tab_bg"] forState:UIControlStateNormal];
            [tabBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        }
    }
    [btn setBackgroundImage:[UIImage imageNamed:@"house_photoview_tab_bg_x"] forState:UIControlStateNormal];
    [btn setTitleColor:THEME_COLOR_ORANGE forState:UIControlStateNormal];
    
    UIScrollView *scroll = (UIScrollView *)[self.view viewWithTag:SCAN_SCROLL_TAG];
    for(UIView *sView in scroll.subviews)
    {
        if([sView isKindOfClass:[UIImageView class]])
            [sView removeFromSuperview];
    }
    
    NSArray *array = nil;
    if(btn.tag%666==0)
    {
        NSArray *tempArr = [hxArray isKindOfClass:[NSArray class]]?hxArray:[NSArray array];
        NSMutableArray *resultArr = [NSMutableArray array];
        for (int i = 0; i < tempArr.count; i++)
        {
            NSDictionary *dic = [tempArr objectAtIndex:i];
            [resultArr addObject:[dic stringObjectForKey:@"pic"]];
        }
        array = resultArr;
    }
    else if(btn.tag%666 == 1)
        array = [xgArray isKindOfClass:[NSArray class]]?xgArray:[NSArray array];
    else if(btn.tag%666==2)
        array = [jtArray isKindOfClass:[NSArray class]]?jtArray:[NSArray array];
    else if(btn.tag%666==3)
        array = [sjArray isKindOfClass:[NSArray class]]?sjArray:[NSArray array];
    else if(btn.tag%666 == 4)
        array = [ybArray isKindOfClass:[NSArray class]]?ybArray:[NSArray array];
    
    
    CGRect frame= [[UIScreen mainScreen] applicationFrame];
    
    if (_bigImgV != nil)
    {
        [_bigImgV removeFromSuperview];
    }
    
    _bigImgV = [[ETShowBigImageView alloc] initWithFrame:CGRectMake(0, 0, frame.size.width, frame.size.height + 20) AndShowImageNum:self.page dataArr:array content:nil];
    _bigImgV.delegate = self;
    _bigImgV.backgroundColor = [UIColor blackColor];
    [self.view insertSubview:_bigImgV atIndex:0];
    
    self.page = 0;
    
    UIPageControl *pageCtr =  (UIPageControl*)[self.view viewWithTag:SCAN_PAGECONTROL_TAG];
    if(pageCtr!=nil)
    {
        [pageCtr removeFromSuperview];
        pageCtr = [[UIPageControl alloc] init];
        pageCtr.tag = SCAN_PAGECONTROL_TAG;
    }
    if([[UIDevice currentDevice].systemVersion floatValue]>=6.0)
    {
        pageCtr.pageIndicatorTintColor = UIColorFromRGB(0xb8b8b8);
        pageCtr.currentPageIndicatorTintColor = UIColorFromRGB(0x8ACF1C);
    }
    pageCtr.numberOfPages = array.count;
    pageCtr.currentPage = self.page;
    pageCtr.frame = CGRectMake(0, scroll.frame.origin.y+scroll.frame.size.height-38, scroll.frame.size.width, 40);
    [self.view addSubview:pageCtr];
}

/**
 *	@brief	单击图片事件
 *
 *	@param 	bImgView
 *
 *	@return	N/A
 */
- (void)didSingleTapImageView:(ETShowBigImageView *)bImgView
{
    
    if (_tabView.alpha == 0.0f)
    {
        // 显示 导航条 tabview
        _hideBar = NO;
        [UIView animateWithDuration:0.3f animations:^{
            _navigationView.alpha = 1.0f;
            _tabView.alpha = 1.0f;
        }];
    }
    else
    {
        // 隐藏 导航条 tabview
        _hideBar = YES;
        [UIView animateWithDuration:0.3f animations:^{
            _navigationView.alpha = 0.0f;
            _tabView.alpha = 0.0f;
//            UIApplication *application = [UIApplication sharedApplication];
//            [application setStatusBarHidden:YES withAnimation:UIStatusBarAnimationFade];
        }];
    }
    if (IOS7)
    {
        [self setNeedsStatusBarAppearanceUpdate];
    }
    
   
}

- (void)viewWillDisappear:(BOOL)animated
{
    UIApplication *application = [UIApplication sharedApplication];
    [application setStatusBarHidden:NO withAnimation:UIStatusBarAnimationFade];
}

#pragma mark - scroll delegate
- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    int page = scrollView.contentOffset.x / scrollView.frame.size.width;
    UIPageControl *pageCtr = (UIPageControl *)[self.view viewWithTag:SCAN_PAGECONTROL_TAG];
    pageCtr.currentPage = page;
}

@end
