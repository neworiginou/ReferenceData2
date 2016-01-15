//
//  BaseViewController.m
//  PUClient
//
//  Created by RRLhy on 15/7/17.
//  Copyright (c) 2015年 RRLhy. All rights reserved.
//

#import "BaseViewController.h"
#import "MyPageVC.h"
#import "LoginVC.h"
@interface BaseViewController ()<UIGestureRecognizerDelegate,UINavigationControllerDelegate>
{
    NSArray * colorArray;
}
@end

@implementation BaseViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
   colorArray = @[RGBCOLOR(0.020, 0.745, 1.000),
                   RGBCOLOR(0.133, 0.133, 0.133),
                   RGBCOLOR(0.941, 0.188, 0.506),
                   RGBCOLOR(0.624, 0.377, 0.753),
                   RGBCOLOR(0.314, 0.153, 0.643),
                   RGBCOLOR(0.149, 0.416, 0.620),
                   RGBCOLOR(0.373, 0.620, 0.627),
                   RGBCOLOR(0.180, 0.522, 0.373),
                   RGBCOLOR(0.467, 0.584, 0.341),
                   RGBCOLOR(0.576, 0.424, 0.353),
                   RGBCOLOR(0.659, 0.580, 0.427),
                   RGBCOLOR(0.573, 0.565, 0.545)];
    NSInteger index = [[[NSUserDefaults standardUserDefaults] objectForKey:ColorIndex] integerValue];

    self.navImage = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, Main_Screen_Width, kStatusBarHeight + kTopBarHeight)];
    self.navImage.backgroundColor = colorArray[index];
    self.navImage.userInteractionEnabled = YES;
    [self.view addSubview:self.navImage];
    
    self.leftBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [self.leftBtn setFrame:CGRectMake(0, 20, 44, 44)];
    [self.leftBtn setImage:[UIImage imageNamed:@"nav_btn_back_n"] forState:UIControlStateNormal];
    [self.leftBtn setImage:[UIImage imageNamed:@"nav_back_me_h"] forState:UIControlStateHighlighted];
    [self.leftBtn addTarget:self action:@selector(popViewController) forControlEvents:UIControlEventTouchUpInside];
    [self.leftBtn.imageView setContentMode:UIViewContentModeScaleAspectFit];
    [self.navImage addSubview:self.leftBtn];
    
    self.rightBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [self.rightBtn setFrame:CGRectMake((Main_Screen_Width - 54), 20, 44, 44)];
    [self.rightBtn addTarget:self action:@selector(rightBtnClick) forControlEvents:UIControlEventTouchUpInside];
    [self.rightBtn.imageView setContentMode:UIViewContentModeScaleAspectFit];
    [self.rightBtn setHidden:YES];
    [self.rightBtn.titleLabel setFont:BOLDSYSTEMFONT(16)];
    [self.navImage addSubview:self.rightBtn];
    
    self.titleLabel = [[UILabel alloc]initWithFrame:CGRectMake(80, 20, (Main_Screen_Width - 160), 44)];
    self.titleLabel.font = BOLDSYSTEMFONT(18);
    self.titleLabel.textAlignment = NSTextAlignmentCenter;
    self.titleLabel.textColor = [UIColor whiteColor];
    [self.navImage addSubview:self.titleLabel];
    
    self.titleImage = [[UIImageView alloc ]init];
    self.titleImage.center = self.titleLabel.center;
    self.titleImage.contentMode = UIViewContentModeScaleAspectFit;
    [self.navImage addSubview:self.titleImage];
    
    self.navigationController.interactivePopGestureRecognizer.delegate = self;
    self.navigationController.interactivePopGestureRecognizer.enabled = YES;
    self.automaticallyAdjustsScrollViewInsets = NO;

//    [[AFNetworkReachabilityManager sharedManager] startMonitoring];
//    [self netWorkReachabilityStatus];
    
    self.view.backgroundColor = [UIColor whiteColor];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(changeNavImage) name:@"changeColor" object:nil];
}

- (UIImageView *)gifImageView
{
    if (!_gifImageView) {
        UITapGestureRecognizer * gesture = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(failReload)];
        _gifImageView = [[UIImageView alloc] initWithFrame:CGRectMake(100, 100, 100, 100)];
        
        NSArray *gifArray = [NSArray arrayWithObjects:
                             [UIImage imageNamed:@"loading01"],
                             [UIImage imageNamed:@"loading02"],
                             [UIImage imageNamed:@"loading03"],
                             [UIImage imageNamed:@"loading04"],
                             [UIImage imageNamed:@"loading05"],
                             [UIImage imageNamed:@"loading06"],
                             [UIImage imageNamed:@"loading07"],
                             [UIImage imageNamed:@"loading08"],nil];
        _gifImageView.animationImages = gifArray; //动画图片数组
        _gifImageView.animationDuration = 1; //执行一次完整动画所需的时长
        _gifImageView.animationRepeatCount = 0;  //动画重复次数
        _gifImageView.image = IMAGENAME(@"pic_Failedtoload");
        _gifImageView.userInteractionEnabled = YES;
        [self.view addSubview:_gifImageView];
        [_gifImageView addGestureRecognizer:gesture];
    }
    return _gifImageView;
}

- (UILabel*)reminderLabel
{
    if (!_reminderLabel) {
        _reminderLabel = [[UILabel alloc]initWithFrame:CGRectMake(0, MaxY(self.gifImageView), Main_Screen_Width, 20)];
        _reminderLabel.textColor = GRAYCOLOR;
        _reminderLabel.font = SYSTEMFONT(16);
        _reminderLabel.textAlignment = NSTextAlignmentCenter;
        _reminderLabel.text = REMINDTEXT1;
        [self.view addSubview:_reminderLabel];
    }
    return _reminderLabel;
}

- (void)changeNavImage
{
    NSInteger index = [[[NSUserDefaults standardUserDefaults] objectForKey:ColorIndex] integerValue];
    self.navImage.backgroundColor = colorArray[index];
}

#pragma mark 监听网络变化
- (void)netWorkReachabilityStatus {
    
    __block BOOL reachable;
    
    [[AFNetworkReachabilityManager sharedManager] setReachabilityStatusChangeBlock:^(AFNetworkReachabilityStatus status) {
        
        switch (status) {
            case AFNetworkReachabilityStatusNotReachable:
                NSLog(@"No Internet Connection");
                reachable = NO;
                self.isNetWork = NO;
                [IanAlert alertError:@"网络已断开" length:1.5];
                break;
            case AFNetworkReachabilityStatusReachableViaWiFi:
                NSLog(@"WIFI");
                self.isNetWork = YES;;
                reachable = YES;
                break;
            case AFNetworkReachabilityStatusReachableViaWWAN:
                NSLog(@"3G");
                self.isNetWork = YES;
                reachable = YES;
                break;
            default:
                NSLog(@"Unkown network status");
                reachable = NO;
                self.isNetWork = NO;
                break;
                
        }
    }];
}

#pragma mark 返回上一个视图控制器
- (void)popViewController
{
    [self.navigationController popViewControllerAnimated:YES];
}

#pragma mark 返回到根视图控制器
- (void)popRootViewController
{
    NSArray * array = self.navigationController.viewControllers;
    MyPageVC * myPage = (MyPageVC*)array[0];
    [myPage reloadUIData];
    [self.navigationController popToViewController:array[0] animated:YES];
}

#pragma mark 跳转登录界面
- (void)skipToLoginVc
{
    UIStoryboard * storyboard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
    LoginVC * loginVC = [storyboard instantiateViewControllerWithIdentifier:@"loginVC"];
    [self.navigationController pushViewController:loginVC animated:YES];
}
#pragma mark 失败重新请求
- (void)failReload
{
    [self requestData];
}

#pragma mark 请求数据
- (void)requestData
{
    
}

- (void)rightBtnClick
{
    
}

- (UIStatusBarStyle)preferredStatusBarStyle
{
    return UIStatusBarStyleLightContent;
}

- (BOOL)shouldAutorotate
{
    return NO;
}

- (NSUInteger)supportedInterfaceOrientations
{
    
    return UIInterfaceOrientationMaskPortrait;//只支持这一个方向(正常的方向)
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)toInterfaceOrientation
{
    
    return (toInterfaceOrientation == UIInterfaceOrientationPortrait);
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
