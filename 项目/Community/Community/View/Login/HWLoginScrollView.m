//
//  HWLoginScrollView.m
//  Community
//
//  Created by hw500027 on 15/4/30.
//  Copyright (c) 2015年 caijingpeng. All rights reserved.
//

#import "HWLoginScrollView.h"
#import "WXApi.h"
#define PAGE_CONTROL_HEIGHT 20  //pageControl高度
#define PAGE_ITEM_COUNT  3      //展示图片数量
#define AUTOSCROLL_TIME  5      //自动滚动间隔时间
#define TOP_HEIGHT     IPHONE4 == YES ? 30/2 : 130/2        //文字图片距离顶部高度
@interface HWLoginScrollView()
{
    NSInteger tempPage;
    
    UIImageView *guide_bigtxt0;
    UIImageView *guide_bigtxt1;
    UIImageView *guide_bigtxt2;
    
    UIView *guide_pic0;
    UIImageView *guide_pic1;
    UIImageView *guide_pic2;
    
    UIView *guide_picBackground0;
    UIImageView *guide_picBackground1;
    UIImageView *guide_picBackground2;
}

@end


@implementation HWLoginScrollView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self)
    {
        [self loadPageView];
    }
    return self;
}

-(void)loadPageView
{
    //加载scrollview
    [self loadScrollView];
    //加载第1个view
    [self addBigBackground1];
    //加载第2个view
    [self addBigBackground2];
    //加载第3个view
    [self addBigBackground3];
}

-(void)loadPageController
{
    _pageControl = [[UIPageControl alloc]initWithFrame:CGRectMake(0, 0, self.frame.size.width , _totalHeight)];
    _pageControl.center = CGPointMake(self.frame.size.width / 2, _totalHeight + 25);
    _pageControl.numberOfPages = PAGE_ITEM_COUNT;
    [self addSubview:_pageControl];
    _pageControl.currentPage = 0;
    [_pageControl autoAlignAxis:ALAxisVertical toSameAxisOfView:self.scrollView];
    if (IPHONE4) {
        [_pageControl autoPinEdge:ALEdgeTop toEdge:ALEdgeTop ofView:self.scrollView withOffset:self.totalHeight - 10];
    }
    else if (IPHONE5)
    {
        [_pageControl autoPinEdge:ALEdgeTop toEdge:ALEdgeTop ofView:self.scrollView withOffset:self.totalHeight + 50];
    }
    else if (IPHONE6)
    {
        [_pageControl autoPinEdge:ALEdgeTop toEdge:ALEdgeTop ofView:self.scrollView withOffset:self.totalHeight + 120];
    }
    else if (IPHONE6PLUS)
    {
        [_pageControl autoPinEdge:ALEdgeTop toEdge:ALEdgeTop ofView:self.scrollView withOffset:self.totalHeight + 150];
    }
    else
    {
        [_pageControl autoPinEdge:ALEdgeTop toEdge:ALEdgeTop ofView:self.scrollView withOffset:self.totalHeight + 0];
    }
}

-(void)loadScrollView
{
    CGRect scrollViewSize = CGRectMake(0, 0, self.frame.size.width, self.frame.size.height);
    _scrollView = [[UIScrollView alloc]initWithFrame:scrollViewSize];
    [self addSubview:_scrollView];
    
    _scrollView.delegate = self;
    _scrollView.showsHorizontalScrollIndicator = NO;
    _scrollView.showsVerticalScrollIndicator = NO;
    _scrollView.pagingEnabled = YES;
    _scrollView.directionalLockEnabled = YES;
    _scrollView.alwaysBounceHorizontal = YES;
    _scrollView.contentSize = CGSizeMake(scrollViewSize.size.width * PAGE_ITEM_COUNT, 0);
}


/**
 *	@brief	添加标题图片
 *
 *	@param 	img 	加载图片image
 *	@param 	superView 	加载图片的父视图
 *
 *	@return	返回该UIImageView
 */
-(UIImageView *)addImgvTxtWithImg:(UIImage *)img superView:(UIView *)superView

{
    //标题图片
    UIImageView *guide_bigtxt = [[UIImageView alloc]initWithImage:img];
    [superView addSubview:guide_bigtxt];
    guide_bigtxt.translatesAutoresizingMaskIntoConstraints = NO;
    [guide_bigtxt autoPinEdge:ALEdgeTop toEdge:ALEdgeTop ofView:superView withOffset:TOP_HEIGHT];
    [guide_bigtxt autoAlignAxis:ALAxisVertical toSameAxisOfView:superView];
    //按比例放大
    [guide_bigtxt autoSetDimensionsToSize:CGSizeMake(img.size.width * kScreenRate, img.size.height * kScreenRate)];
    return guide_bigtxt;
}

-(void)addBigBackground1
{
    UIImageView *view = [[UIImageView alloc]initWithFrame:self.frame];
    view.backgroundColor = UIColorFromRGB(0x02b2ac);
    [self.scrollView addSubview:view];
    
    //添加标题图片
    UIImage *titleImg1 = [UIImage imageNamed:@"guide1_bigtxt"];
    guide_bigtxt0 = [self addImgvTxtWithImg:titleImg1 superView:view];
    
    //添加考拉图片 背景view
    UIImage *klView = [UIImage imageNamed:@"guide3_pic1"];
    UIView *klBackgroundView1 = [UIView newAutoLayoutView];
    [view addSubview:klBackgroundView1];
    [klBackgroundView1 autoPinEdge:ALEdgeTop toEdge:ALEdgeBottom ofView:guide_bigtxt0];
    [klBackgroundView1 autoAlignAxis:ALAxisVertical toSameAxisOfView:view];
    [klBackgroundView1 autoSetDimensionsToSize:CGSizeMake(klView.size.width * kScreenRate, klView.size.height * kScreenRate)];
    
    //添加考拉图片
    UIImage *klImage = [UIImage imageNamed:@"guide1_pic1"];
    UIImageView *klImageV = [[UIImageView alloc]initWithImage:klImage];
    [klBackgroundView1 addSubview:klImageV];
    klImageV.translatesAutoresizingMaskIntoConstraints = NO;
    [klImageV autoAlignAxis:ALAxisHorizontal toSameAxisOfView:klBackgroundView1 withOffset:10];
    [klImageV autoAlignAxis:ALAxisVertical toSameAxisOfView:klBackgroundView1];

    [klImageV autoSetDimensionsToSize:CGSizeMake(klImage.size.width * kScreenRate, klImage.size.height * kScreenRate)];

    //添加考拉背景图片
    UIView *klBackgroundView2 = [UIView newAutoLayoutView];
    [view addSubview:klBackgroundView2];
    [view insertSubview:klBackgroundView2 belowSubview:klBackgroundView1];
    [klBackgroundView2 autoPinEdge:ALEdgeTop toEdge:ALEdgeBottom ofView:guide_bigtxt0];
    [klBackgroundView2 autoAlignAxis:ALAxisVertical toSameAxisOfView:view];
    [klBackgroundView2 autoSetDimensionsToSize:CGSizeMake(klView.size.width * kScreenRate, klView.size.height * kScreenRate)];
    
    UIImage *klImage1 = [UIImage imageNamed:@"guide1_pic2"];
    UIImageView *klImageV1 = [[UIImageView alloc]initWithImage:klImage1];
    [klBackgroundView2 addSubview:klImageV1];
    klImageV1.translatesAutoresizingMaskIntoConstraints = NO;
    [klImageV1 autoCenterInSuperview];
    [klImageV1 autoSetDimensionsToSize:CGSizeMake(klImage1.size.width * kScreenRate, klImage1.size.height * kScreenRate)];
    
    //气泡1
    UIImage *klPopImage1 = [UIImage imageNamed:@"guide1_pic3"];
    UIImageView *klPopImageV1 = [[UIImageView alloc]initWithImage:klPopImage1];
    [klBackgroundView2 addSubview:klPopImageV1];
    klPopImageV1.translatesAutoresizingMaskIntoConstraints = NO;
    [klPopImageV1 autoPinEdge:ALEdgeLeft toEdge:ALEdgeLeft ofView:klBackgroundView2 withOffset:10];
    [klPopImageV1 autoAlignAxis:ALAxisHorizontal toSameAxisOfView:klBackgroundView2 withOffset:0];
    [klPopImageV1 autoSetDimensionsToSize:CGSizeMake(klPopImage1.size.width * kScreenRate, klPopImage1.size.height * kScreenRate)];
    //气泡2
    UIImage *klPopImage2 = [UIImage imageNamed:@"guide1_pic4"];
    UIImageView *klPopImageV2 = [[UIImageView alloc]initWithImage:klPopImage2];
    [klBackgroundView2 addSubview:klPopImageV2];
    klPopImageV2.translatesAutoresizingMaskIntoConstraints = NO;
    [klPopImageV2 autoPinEdge:ALEdgeTop toEdge:ALEdgeTop ofView:klBackgroundView2 withOffset:klPopImage2.size.height];
    [klPopImageV2 autoAlignAxis:ALAxisVertical toSameAxisOfView:klBackgroundView2 withOffset:-klPopImage2.size.width-10];
    [klPopImageV2 autoSetDimensionsToSize:CGSizeMake(klPopImage2.size.width * kScreenRate, klPopImage2.size.height * kScreenRate)];
    //气泡3
    UIImage *klPopImage3 = [UIImage imageNamed:@"guide1_pic5"];
    UIImageView *klPopImageV3 = [[UIImageView alloc]initWithImage:klPopImage3];
    [klBackgroundView2 addSubview:klPopImageV3];
    klPopImageV3.translatesAutoresizingMaskIntoConstraints = NO;
    [klPopImageV3 autoPinEdge:ALEdgeRight toEdge:ALEdgeRight ofView:klBackgroundView2 withOffset:-klPopImage3.size.width/3];
    [klPopImageV3 autoAlignAxis:ALAxisHorizontal toSameAxisOfView:klBackgroundView2 withOffset:-klPopImage3.size.height];
    [klPopImageV3 autoSetDimensionsToSize:CGSizeMake(klPopImage3.size.width * kScreenRate, klPopImage3.size.height * kScreenRate)];
    
    _totalHeight = titleImg1.size.height + klView.size.height;
    //加载pagecontroller
    [self loadPageController];
    
    //加载按钮背景
    UIView *btnBackgroundView = [UIView newAutoLayoutView];
    [view addSubview:btnBackgroundView];
    [btnBackgroundView autoPinEdge:ALEdgeTop toEdge:ALEdgeBottom ofView:self.pageControl];
    [btnBackgroundView autoPinEdge:ALEdgeBottom toEdge:ALEdgeBottom ofView:view];
    [btnBackgroundView autoPinEdge:ALEdgeLeft toEdge:ALEdgeLeft ofView:view];
    [btnBackgroundView autoPinEdge:ALEdgeRight toEdge:ALEdgeRight ofView:view];
    
    view.userInteractionEnabled = YES;
    [self addButtonsWithSuperView:btnBackgroundView];
    
    guide_pic0 = klBackgroundView1;
    guide_picBackground0 = klBackgroundView2;
    [self hideAllView];
    [self doAnimationView1:guide_pic0 View2:guide_picBackground0 View3:guide_bigtxt0];
}

-(void)btnClick
{
    NSLog(@"aaaaaa");
}

-(void)addBigBackground2
{
    UIImageView *view = [[UIImageView alloc]initWithFrame:CGRectMake(self.frame.size.width, 0, self.frame.size.width, self.frame.size.height)];
    view.backgroundColor = UIColorFromRGB(0xf6c248);
    [self.scrollView addSubview:view];
    
    //添加标题图片
    UIImage *img1 = [UIImage imageNamed:@"guide2_bigtxt"];
    guide_bigtxt1 = [self addImgvTxtWithImg:img1 superView:view];
    
    //添加考拉图片
    UIImage *klView = [UIImage imageNamed:@"guide2_pic1-"];
    UIImageView *guide_pic = [[UIImageView alloc]initWithImage:klView];
    [view addSubview:guide_pic];
    guide_pic.translatesAutoresizingMaskIntoConstraints = NO;
    [guide_pic autoPinEdge:ALEdgeTop toEdge:ALEdgeBottom ofView:guide_bigtxt1];
    [guide_pic autoAlignAxis:ALAxisVertical toSameAxisOfView:view];
    [guide_pic autoSetDimensionsToSize:CGSizeMake(klView.size.width * kScreenRate, klView.size.height * kScreenRate)];
    
    //添加考拉背景图片
    UIImage *klBGView = [UIImage imageNamed:@"guide2_pic2"];
    UIImageView *guide_picBackground = [[UIImageView alloc]initWithImage:klBGView];
    [view insertSubview:guide_picBackground belowSubview:guide_pic];
    guide_picBackground.translatesAutoresizingMaskIntoConstraints = NO;
    [guide_picBackground autoAlignAxis:ALAxisHorizontal toSameAxisOfView:guide_pic];
    [guide_picBackground autoAlignAxis:ALAxisVertical toSameAxisOfView:guide_pic];
    //按比例放大
    [guide_picBackground autoSetDimensionsToSize:CGSizeMake(klBGView.size.width * kScreenRate, klBGView.size.height * kScreenRate)];
    
    //加载按钮背景
    UIView *btnBackgroundView = [UIView newAutoLayoutView];
    [view addSubview:btnBackgroundView];
    [btnBackgroundView autoPinEdge:ALEdgeTop toEdge:ALEdgeBottom ofView:self.pageControl];
    [btnBackgroundView autoPinEdge:ALEdgeBottom toEdge:ALEdgeBottom ofView:view];
    [btnBackgroundView autoPinEdge:ALEdgeLeft toEdge:ALEdgeLeft ofView:view];
    [btnBackgroundView autoPinEdge:ALEdgeRight toEdge:ALEdgeRight ofView:view];
    
    view.userInteractionEnabled = YES;
    [self addButtonsWithSuperView:btnBackgroundView];
    
    guide_bigtxt1.hidden = YES;
    guide_pic1 = guide_pic;
    guide_pic1.hidden = YES;
    guide_picBackground1 = guide_picBackground;
    guide_picBackground1.hidden = YES;
}

-(void)addBigBackground3
{
    UIImageView *view = [[UIImageView alloc]initWithFrame:CGRectMake(self.frame.size.width * 2, 0, self.frame.size.width, self.frame.size.height)];
    view.backgroundColor = UIColorFromRGB(0xe45b5c);
    [self.scrollView addSubview:view];
    
    //添加标题图片
    UIImage *img1 = [UIImage imageNamed:@"guide3_bigtxt"];
    guide_bigtxt2 = [self addImgvTxtWithImg:img1 superView:view];
    
    //添加考拉图片
    UIImage *klView = [UIImage imageNamed:@"guide3_pic1"];
    UIImageView *guide_pic = [[UIImageView alloc]initWithImage:klView];
    [view addSubview:guide_pic];
    guide_pic.translatesAutoresizingMaskIntoConstraints = NO;
    [guide_pic autoPinEdge:ALEdgeTop toEdge:ALEdgeBottom ofView:guide_bigtxt2];
    [guide_pic autoAlignAxis:ALAxisVertical toSameAxisOfView:view];
    [guide_pic autoSetDimensionsToSize:CGSizeMake(klView.size.width * kScreenRate, klView.size.height * kScreenRate)];
    
    //添加考拉背景图片
    UIImage *klBGView = [UIImage imageNamed:@"guide3_pic2"];
    UIImageView *guide_picBackground = [[UIImageView alloc]initWithImage:klBGView];
    [view insertSubview:guide_picBackground belowSubview:guide_pic];
    guide_picBackground.translatesAutoresizingMaskIntoConstraints = NO;
    [guide_picBackground autoAlignAxis:ALAxisHorizontal toSameAxisOfView:guide_pic];
    [guide_picBackground autoAlignAxis:ALAxisVertical toSameAxisOfView:guide_pic];
    //按比例放大
    [guide_picBackground autoSetDimensionsToSize:CGSizeMake(klBGView.size.width * kScreenRate, klBGView.size.height * kScreenRate)];
    
    //加载按钮背景
    UIView *btnBackgroundView = [UIView newAutoLayoutView];
    [view addSubview:btnBackgroundView];
    [btnBackgroundView autoPinEdge:ALEdgeTop toEdge:ALEdgeBottom ofView:self.pageControl];
    [btnBackgroundView autoPinEdge:ALEdgeBottom toEdge:ALEdgeBottom ofView:view];
    [btnBackgroundView autoPinEdge:ALEdgeLeft toEdge:ALEdgeLeft ofView:view];
    [btnBackgroundView autoPinEdge:ALEdgeRight toEdge:ALEdgeRight ofView:view];
    
    view.userInteractionEnabled = YES;
    [self addButtonsWithSuperView:btnBackgroundView];
    
    guide_bigtxt2.hidden = YES;
    guide_pic2 = guide_pic;
    guide_pic2.hidden = YES;
    guide_picBackground2 = guide_picBackground;
    guide_picBackground2.hidden = YES;
}

//滚动视图减速完成，滚动将停止时，调用该方法
-(void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView
{
    if (tempPage != _pageControl.currentPage)
    {
        [self viewWithAnimation];
    }
    tempPage = _pageControl.currentPage;
}

-(CABasicAnimation *)normalViewWithAnimation
{
    // 设定为缩放
    CABasicAnimation *animation = [CABasicAnimation animationWithKeyPath:@"transform.scale"];
    // 动画选项设定
    animation.duration = 0.4; // 动画持续时间
    animation.repeatCount = 0; // 重复次数
    animation.autoreverses = NO; // 动画结束时执行逆动画
    // 缩放倍数
    animation.fromValue = [NSNumber numberWithFloat:0.0]; // 开始时的倍率
    animation.toValue = [NSNumber numberWithFloat:1.0]; // 结束时的倍率
    return animation;
}

-(void)hideAllView
{
    guide_bigtxt0.hidden = YES;
    guide_pic0.hidden = YES;
    guide_picBackground0.hidden = YES;
    
    guide_bigtxt1.hidden = YES;
    guide_pic1.hidden = YES;
    guide_picBackground1.hidden = YES;
    
    guide_bigtxt2.hidden = YES;
    guide_pic2.hidden = YES;
    guide_picBackground2.hidden = YES;
}

-(void)doAnimationView1:(UIView *)view1 View2:(UIView *)view2 View3:(UIView *)view3
{
    dispatch_queue_t queue = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0);
    dispatch_async(queue, ^{
        dispatch_sync(dispatch_get_main_queue(), ^(void)
          {
              // 添加动画
              view1.hidden = NO;
              [view1.layer addAnimation:self.normalViewWithAnimation forKey:@"scale-layer"];
          });
        [NSThread sleepForTimeInterval:0.4];
        dispatch_sync(dispatch_get_main_queue(), ^(void)
          {
              // 添加动画
              view2.hidden = NO;
              [view2.layer addAnimation:self.normalViewWithAnimation forKey:@"scale-layer"];
          });
        [NSThread sleepForTimeInterval:0.4];
        dispatch_sync(dispatch_get_main_queue(), ^(void)
          {
              view3.hidden = NO;
              [view3.layer addAnimation:self.normalViewWithAnimation forKey:@"scale-layer"];
          });
    });
}

-(void)viewWithAnimation
{
    if (_pageControl.currentPage == 0)
    {
        [self hideAllView];
        [self doAnimationView1:guide_pic0 View2:guide_picBackground0 View3:guide_bigtxt0];
    }
    else if (_pageControl.currentPage == 1)
    {
        [self hideAllView];
        [self doAnimationView1:guide_pic1 View2:guide_picBackground1 View3:guide_bigtxt1];
    }
    else
    {
        [self hideAllView];
        [self doAnimationView1:guide_pic2 View2:guide_picBackground2 View3:guide_bigtxt2];
    }
}

-(void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    _pageControl.currentPage = _scrollView.contentOffset.x / _scrollView.frame.size.width;
}

-(void)addButtonsWithSuperView:(UIView *)superView
{
    //登录按钮
    UIButton *_loginBtn = [UIButton newAutoLayoutView];
    [superView addSubview:_loginBtn];
    [_loginBtn setBackgroundImage:[UIImage imageNamed:@"guide-but1"] forState:UIControlStateNormal];
    [_loginBtn setBackgroundImage:[UIImage imageNamed:@"guide-but2"] forState:UIControlStateHighlighted];
    [_loginBtn setTitle:@"登 录" forState:UIControlStateNormal];
    [_loginBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    _loginBtn.titleLabel.font = [UIFont fontWithName:FONTNAME size:19.0f];
    [_loginBtn addTarget:self action:@selector(toLoginBtn) forControlEvents:UIControlEventTouchUpInside];
    //登录按钮布局
    CGFloat width = IPHONE6PLUS ==YES?25:IPHONE6==YES?15:5;
    [_loginBtn autoPinEdge:ALEdgeTop toEdge:ALEdgeBottom ofView:self.pageControl withOffset:IPHONE4==YES?0:10];
    [_loginBtn autoAlignAxis:ALAxisVertical toSameAxisOfView:superView withOffset:width +[_loginBtn systemLayoutSizeFittingSize:UILayoutFittingCompressedSize].width/2];
    
    //注册按钮
    UIButton *_registerBtn = [UIButton newAutoLayoutView];
    [superView addSubview:_registerBtn];
    [_registerBtn setBackgroundImage:[UIImage imageNamed:@"guide-but1"] forState:UIControlStateNormal];
    [_registerBtn setBackgroundImage:[UIImage imageNamed:@"guide-but2"] forState:UIControlStateHighlighted];
    [_registerBtn setTitle:@"注 册" forState:UIControlStateNormal];
    [_registerBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    _registerBtn.titleLabel.font = [UIFont fontWithName:FONTNAME size:19.0f];
    [_registerBtn addTarget:self action:@selector(toRegister) forControlEvents:UIControlEventTouchUpInside];
    //注册按钮布局
    [_registerBtn autoPinEdge:ALEdgeTop toEdge:ALEdgeBottom ofView:self.pageControl withOffset:IPHONE4==YES?0:10];
    [_registerBtn autoAlignAxis:ALAxisVertical toSameAxisOfView:superView withOffset:-width -[_registerBtn systemLayoutSizeFittingSize:UILayoutFittingCompressedSize].width/2];
    
    //如果没有安装微信 只显示游客按钮
    if (![WXApi isWXAppInstalled])
    {
        //游客按钮
        UIButton *_guestBtn = [UIButton newAutoLayoutView];
        [superView addSubview:_guestBtn];
        [_guestBtn setImage:[UIImage imageNamed:@"guide-icon1"] forState:UIControlStateNormal];
        [_guestBtn setTitle:@"游客" forState:UIControlStateNormal];
        _guestBtn.titleLabel.font = [UIFont fontWithName:FONTNAME size:THEME_FONT_BIG];
        _guestBtn.titleLabel.backgroundColor = [UIColor clearColor];
        [_guestBtn setImageEdgeInsets:UIEdgeInsetsMake(0, -12, 0, 0)];
        [_guestBtn setTitleEdgeInsets:UIEdgeInsetsMake(0, 8, 0, 0)];
        _guestBtn.backgroundColor = [UIColor clearColor];
        [_guestBtn addTarget:self action:@selector(toGuestLogin) forControlEvents:UIControlEventTouchUpInside];
        //游客按钮布局
        [_guestBtn autoPinEdge:ALEdgeTop toEdge:ALEdgeBottom ofView:_loginBtn withOffset:IPHONE6PLUS==YES?40:IPHONE6?30:20];
        [_guestBtn autoAlignAxis:ALAxisVertical toSameAxisOfView:superView];
        [_guestBtn autoSetDimension:ALDimensionWidth toSize:[_guestBtn systemLayoutSizeFittingSize:UILayoutFittingCompressedSize].width + 8];
    }
    else
    {
        //微信与游客按钮分割线
        UIView *line = [UIView newAutoLayoutView];
        [superView addSubview:line];
        line.backgroundColor = [UIColor whiteColor];
        [line autoSetDimensionsToSize:CGSizeMake(1, 13)];
        [line autoPinEdge:ALEdgeTop toEdge:ALEdgeBottom ofView:_loginBtn withOffset:IPHONE6PLUS==YES?40:IPHONE6?30:20];
        [line autoAlignAxis:ALAxisVertical toSameAxisOfView:superView];
        
        //微信按钮
        UIButton *_wechatBtn = [UIButton newAutoLayoutView];
        [superView addSubview:_wechatBtn];
        [_wechatBtn setImage:[UIImage imageNamed:@"guide-icon2"] forState:UIControlStateNormal];
        [_wechatBtn setTitle:@"微信" forState:UIControlStateNormal];
        _wechatBtn.titleLabel.font = [UIFont fontWithName:FONTNAME size:THEME_FONT_BIG];
        _wechatBtn.titleLabel.backgroundColor = [UIColor clearColor];
        [_wechatBtn setImageEdgeInsets:UIEdgeInsetsMake(0, -12, 0, 0)];
        [_wechatBtn setTitleEdgeInsets:UIEdgeInsetsMake(0, 8, 0, 0)];
        _wechatBtn.backgroundColor = [UIColor clearColor];
        [_wechatBtn addTarget:self action:@selector(toWeChatLogin) forControlEvents:UIControlEventTouchUpInside];
        //微信按钮布局
        CGFloat width1 = 22;
        [_wechatBtn autoAlignAxis:ALAxisBaseline toSameAxisOfView:line];
        [_wechatBtn autoPinEdge:ALEdgeRight toEdge:ALEdgeLeft ofView:line withOffset:-width1];
        [_wechatBtn autoSetDimension:ALDimensionWidth toSize:[_wechatBtn systemLayoutSizeFittingSize:UILayoutFittingCompressedSize].width + 8];
        
        //游客按钮
        UIButton *_guestBtn = [UIButton newAutoLayoutView];
        [superView addSubview:_guestBtn];
        [_guestBtn setImage:[UIImage imageNamed:@"guide-icon1"] forState:UIControlStateNormal];
        [_guestBtn setTitle:@"游客" forState:UIControlStateNormal];
        _guestBtn.titleLabel.font = [UIFont fontWithName:FONTNAME size:THEME_FONT_BIG];
        _guestBtn.titleLabel.backgroundColor = [UIColor clearColor];
        [_guestBtn setImageEdgeInsets:UIEdgeInsetsMake(0, -12, 0, 0)];
        [_guestBtn setTitleEdgeInsets:UIEdgeInsetsMake(0, 8, 0, 0)];
        _guestBtn.backgroundColor = [UIColor clearColor];
        [_guestBtn addTarget:self action:@selector(toGuestLogin) forControlEvents:UIControlEventTouchUpInside];
        //游客按钮布局
        [_guestBtn autoAlignAxis:ALAxisBaseline toSameAxisOfView:line];
        [_guestBtn autoPinEdge:ALEdgeLeft toEdge:ALEdgeRight ofView:line withOffset:width1 + 12];
        [_guestBtn autoSetDimension:ALDimensionWidth toSize:[_guestBtn systemLayoutSizeFittingSize:UILayoutFittingCompressedSize].width + 8];
    }
}

-(void)toLoginBtn
{
    if (_scrollViewDelegate && [_scrollViewDelegate respondsToSelector:@selector(didClickLoginBtn)])
    {
        [_scrollViewDelegate didClickLoginBtn];
    }
}
-(void)toRegister
{
    if (_scrollViewDelegate && [_scrollViewDelegate respondsToSelector:@selector(didClickRegisterBtn)])
    {
        [_scrollViewDelegate didClickRegisterBtn];
    }
}
-(void)toWeChatLogin
{
    if (_scrollViewDelegate && [_scrollViewDelegate respondsToSelector:@selector(didClickWXBtn)])
    {
        [_scrollViewDelegate didClickWXBtn];
    }
}
-(void)toGuestLogin
{
    if (_scrollViewDelegate && [_scrollViewDelegate respondsToSelector:@selector(didclickGuestBtn)])
    {
        [_scrollViewDelegate didclickGuestBtn];
    }
}
@end
