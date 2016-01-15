//
//  TwoDimensionExtendViewController.m
//  TEST
//
//  Created by gusheng on 14-8-28.
//  Copyright (c) 2014年 gusheng. All rights reserved.
//
// 功能描述：邀请好友页面
//
// 魏远林    2015-01-28  添加新的分享视图

#import "TwoDimensionExtendViewController.h"
#import "MineExtendDetailViewController.h"
#import "MineExtendRecordTableViewCell.h"
#import "HWBaseNavigationController.h"
#import "AppDelegate.h"
#import "HWShareView.h"
#import "QRCodeGenerator.h"
@interface TwoDimensionExtendViewController () <HWShareViewDelegate>
{
    UIView *_pushView;
    UIView *_popView;
    UILabel * detailTitleLabel;
    NSDictionary *_detailDic;//存放数据的字典
}
@end

@implementation TwoDimensionExtendViewController
@synthesize queue,inviteUrl;
- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        //
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.navigationItem.leftBarButtonItem = [Utility navLeftBackBtn:self action:@selector(doBack)];
    self.navigationItem.titleView = [Utility navTitleView:@"邀请朋友"];
    self.view.backgroundColor = UIColorFromRGB(0xf5f5f5);
    [self createBtnS];
    [self createLabelTwo:@"￥0.00"];
    [self createPageElementAttribution];
    
    _rightsKeepLab = [[UILabel alloc] initWithFrame:CGRectMake(15, CGRectGetMaxY(detailTitleLabel.frame), kScreenWidth - 2 * 15, 15)];
    _rightsKeepLab.backgroundColor = [UIColor clearColor];
    _rightsKeepLab.text = @"最终解释权归考拉社区所有";
    _rightsKeepLab.font = [UIFont fontWithName:FONTNAME size:THEME_FONT_SMALL12];
    _rightsKeepLab.textColor = UIColorFromRGB(0xb0b0b0);
    _rightsKeepLab.textAlignment = NSTextAlignmentLeft;
    [myScrollView addSubview:_rightsKeepLab];
    [self queryListDataForBackstage];
    
    
    // Do any additional setup after loading the view from its nib.
}

//创建控件
-(void)createBtnS
{
    myScrollView = [[UIScrollView alloc]initWithFrame:CGRectMake(0, 0, kScreenWidth, self.view.bounds.size.height)];
    myScrollView.userInteractionEnabled = YES;
    myScrollView.backgroundColor = [UIColor clearColor];
    myScrollView.contentSize = CGSizeMake(0, self.view.frame.size.height);
    [self.view addSubview:myScrollView];
    
    UILabel * titleLabel = [[UILabel alloc]init];
    titleLabel.textAlignment = NSTextAlignmentCenter;
    titleLabel.backgroundColor = [UIColor clearColor];
    [titleLabel setFont:[UIFont systemFontOfSize:18.0]];
    titleLabel.text = @"邀请朋友一同入驻考拉社区";
    titleLabel.textColor = UIColorFromRGB(0x666666);
    [titleLabel sizeToFit];
    titleLabel.frame = CGRectMake((kScreenWidth - titleLabel.frame.size.width) / 2.0f, 20.0f , titleLabel.frame.size.width, titleLabel.frame.size.height);
    [myScrollView addSubview:titleLabel];
    
    
    moreExtendBtn = [[UIButton alloc]initWithFrame:CGRectMake(self.view.frame.size.width/2, CONTENT_HEIGHT-50,self.view.frame.size.width/2, 50)];
    moreExtendBtn.userInteractionEnabled = YES;
    [moreExtendBtn setTitle:@"立刻邀请" forState:UIControlStateNormal];
    //    [moreExtendBtn  setBackgroundImage:[UIImage imageNamed:@"bg2"] forState:UIControlStateNormal];
    [moreExtendBtn setBackgroundImage:[Utility imageWithColor:THEME_COLOR_ORANGE andSize:CGSizeMake(10, 10)] forState:UIControlStateNormal];
    [moreExtendBtn addTarget:self action:@selector(clickMoreExtend) forControlEvents:UIControlEventTouchUpInside];
    [moreExtendBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [self.view addSubview:moreExtendBtn];
    
    
    mineExtendBtn = [[UIButton alloc]initWithFrame:CGRectMake(0,CONTENT_HEIGHT - 50,self.view.frame.size.width/2, 50)];
    [mineExtendBtn setTitle:@"我的邀请记录" forState:UIControlStateNormal];
    [mineExtendBtn  setBackgroundImage:[UIImage imageNamed:@"bg2"] forState:UIControlStateNormal];
    [mineExtendBtn addTarget:self action:@selector(clickMineEextend) forControlEvents:UIControlEventTouchUpInside];
    [mineExtendBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [self.view addSubview:mineExtendBtn];
    
    
    twoDismensionImageView = [[UIImageView alloc]initWithFrame:CGRectMake((kScreenWidth - 209.0f) / 2, 57, 209.0f, 209.0f)];
    twoDismensionImageView.contentMode = UIViewContentModeScaleAspectFit;
    twoDismensionImageView.backgroundColor = IMAGE_DEFAULT_COLOR;
    [myScrollView addSubview:twoDismensionImageView];
    
    lineOneImageView = [[UIImageView alloc]initWithFrame:CGRectMake(0, CGRectGetMaxY(twoDismensionImageView.frame)+13, kScreenWidth, 80)];
    lineOneImageView.backgroundColor = [UIColor lightGrayColor];
    [myScrollView addSubview:lineOneImageView];
    
    detailTitleLabel = [[UILabel alloc] initWithFrame:CGRectMake(15, CGRectGetMaxY(twoDismensionImageView.frame) + 20, kScreenWidth - 2 * 15, 20)];
    detailTitleLabel.font = [UIFont fontWithName:FONTNAME size:THEME_FONT_SMALL];
    detailTitleLabel.textColor = UIColorFromRGB(0x666666);
    detailTitleLabel.textAlignment = NSTextAlignmentLeft;
    detailTitleLabel.backgroundColor = [UIColor clearColor];
    detailTitleLabel.numberOfLines = 0;
    detailTitleLabel.text = @"通过二维码邀请你的小伙伴下载并注册考拉社区";
    CGRect frame = detailTitleLabel.frame;
    frame.size.height = [Utility calculateStringHeight:detailTitleLabel.text font:detailTitleLabel.font constrainedSize:CGSizeMake(kScreenWidth - 2 * 15, 10000)].height;
    detailTitleLabel.frame = frame;
    [myScrollView addSubview:detailTitleLabel];
    
    detailLabel = [[UILabel alloc]initWithFrame:CGRectMake(15, CGRectGetMaxY(detailTitleLabel.frame), kScreenWidth - 2 * 15, 17)];
    detailLabel.textAlignment = NSTextAlignmentLeft;
    detailLabel.backgroundColor = [UIColor clearColor];
    [detailLabel setFont:[UIFont fontWithName:FONTNAME size:THEME_FONT_SMALL]];
    detailLabel.textColor = UIColorFromRGB(0x666666);
    [myScrollView addSubview:detailLabel];
    
    lineTwoImageView = [[UIImageView alloc]initWithFrame:CGRectMake(0, self.view.frame.size.height-50-1, kScreenWidth, 1)];
    lineTwoImageView.backgroundColor = THEME_COLOR_LINE;
    [self.view addSubview:lineTwoImageView];
}

/**
 *	@brief	后台添加用户到游戏推广相关的数据库中
 *
 *	@return	后台设定接口
 */
- (void)queryListDataForBackstage {
    
    /*游戏推广首页接口之前：起到后台 添加用户到游戏推广相关的数据库中 的作用
     popularizeUserId=12&popularizeMobile=15112345678&popularizeName=用户昵称&uuid=retret4545334r34
     出参：
     布尔类型：true/false    经验证不是－by niedi
     */
    
    NSMutableDictionary *param = [NSMutableDictionary dictionary];
    
    HWHTTPRequestOperationManager *manager = [HWHTTPRequestOperationManager gameManager];
    [param setPObject:[HWUserLogin currentUserLogin].userId forKey:@"popularizeUserId"];
    [param setPObject:[HWUserLogin currentUserLogin].telephoneNum forKey:@"popularizeMobile"];
    [param setPObject:[HWUserLogin currentUserLogin].nickname forKey:@"popularizeName"];
    [param setPObject:[HWUserLogin currentUserLogin].key forKey:@"uuid"];
    
    [manager POST:KGameSpreadVC parameters:param queue:nil success:^(id responseObject) {
        
        NSLog(@"%@",responseObject);
        [self getInviteInfo];
        
    } failure:^(NSString *code, NSString *error) {
        
        [Utility showToastWithMessage:error inView:self.view];
        [self showNoMessage];
    }];
}
////发送获取二维码请求
//-(void)sendGetTwodimensionCode
//{
//    [Utility showMBProgress:self.view message:@"获取二维码"];
//
//    HWHTTPRequestOperationManager *manager = [HWHTTPRequestOperationManager manager];
//    NSMutableDictionary *dict = [NSMutableDictionary dictionary];
//    [dict setPObject:[HWUserLogin currentUserLogin].key forKey:@"username"];
//    [dict setPObject:@"10010" forKey:@"appKey"];
//    [dict setPObject:@"sq1W" forKey:@"code"];
//   [manager POST:kBangQuUrl parameters:dict queue:nil success:^(id responseObject)
//     {
//        [Utility hideMBProgress:self.view];
//         NSString *url = [responseObject objectForKey:@"url"];
//         inviteUrl = url;
//         NSLog(@"sucess");
//         NSURL *imageUrl = [NSURL URLWithString:url];
//         NSData* data = [NSData dataWithContentsOfURL:imageUrl];//获取网咯图片数据
//         if(data!=nil)
//         {
//          twoDismensionImageView.image = [[UIImage alloc] initWithData:data];//根据图片数据流构造image
//         }
//
//     }
//    failure:^(NSString *code, NSString *error)
//     {
//         [Utility hideMBProgress:self.view];
//    }];
//    [Utility showMBProgress:self.view message:LOADING_TEXT];
//    HWHTTPRequestOperationManager *manager = [HWHTTPRequestOperationManager manager];
//    [manager POST:kInviteUrl parameters:nil queue:nil success:^(id responseObject) {
//        [Utility hideMBProgress:self.view];
//        self.inviteUrl = [responseObject stringObjectForKey:@"data"];
//        if ([self.inviteUrl length]==0) {
//            self.inviteUrl = ITUNSE_DOWNLOAD_URL;
//        }
//        [self generateQR];
//    } failure:^(NSString *code, NSString *error) {
//        [Utility hideMBProgress:self.view];
//        self.inviteUrl = ITUNSE_DOWNLOAD_URL;
//        [self generateQR];
//
//    }];

/**
 *	@brief	个人游戏推广页 数据请求
 *
 *
 *	@return	N/A
 */
- (void)getInviteInfo
{
    /*
     接口名称：推广游戏--单个游戏分享
     接口URL：hw-game-app-web/quickmark/queryQuickMarkAndUrl.do
     入参：
     popularizeUserId(必填，推广员ID)，
     gameId(必填，游戏ID)，
     appkey(必填，)，
     code(必填，) 例：?popularizeUserId=77&gameId=2&appkey=10010&code=KALA
     */
    
    [Utility showMBProgress:self.view message:@"加载中"];
    NSMutableDictionary *param = [NSMutableDictionary dictionary];
    [param setPObject:[HWUserLogin currentUserLogin].userId forKey:@"popularizeUserId"];
    //        [param setPObject:@"" forKey:@"gameId"];
    [param setPObject:@"10010" forKey:@"appkey"];
    [param setPObject:@"KALA" forKey:@"code"];
    HWHTTPRequestOperationManager *manager = [HWHTTPRequestOperationManager gameManager];
    [manager POST:kSingleGameSpread parameters:param queue:nil success:^(id responese) {
        [Utility hideMBProgress:self.view];
        NSDictionary *dataDic = [responese dictionaryObjectForKey:@"data"];
        NSArray *contentArr = [dataDic arrayObjectForKey:@"content"];
        _detailDic = [contentArr pObjectAtIndex:0];
        
        __weak UIImageView *weakQRImgV = twoDismensionImageView;
        [twoDismensionImageView setImageWithURL:[NSURL URLWithString:[_detailDic stringObjectForKey:@"dimensionalCode"]] placeholderImage:[UIImage imageNamed:IMAGE_PLACE] completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType) {
            
            if (error != nil)
            {
                weakQRImgV.image = [UIImage imageNamed:IMAGE_BREAK_CUBE];
            }
            else
            {
                weakQRImgV.image = image;
            }
            
        }];
        [self getInviteMoney];
        
    } failure:^(NSString *code, NSString *error) {
        [Utility hideMBProgress:self.view];
        [Utility showToastWithMessage:error inView:self.view];
        [self showNoMessage];
    }];
}

- (void)getInviteMoney
{
    [Utility showMBProgress:self.view message:LOADING_TEXT];
    HWHTTPRequestOperationManager *manager = [HWHTTPRequestOperationManager gameManager];
    NSMutableDictionary *param = [NSMutableDictionary dictionary];
    [param setPObject:@"1" forKey:@"gameId"];
    
    [manager POST:kInviteMoney parameters:param queue:nil success:^(id responese) {
        
        [Utility hideMBProgress:self.view];
        NSLog(@"分享奖励 %@",responese);
        NSString *resultStr = [NSString stringWithFormat:@"%.2f",[[responese stringObjectForKey:@"data"] floatValue]];
        
        [self createLabelTwo:resultStr];//@"2.00"
        
    } failure:^(NSString *code, NSString *error) {
        
        [Utility hideMBProgress:self.view];
        [Utility showToastWithMessage:error inView:self.view];
        [self showNoMessage];
        
    }];
}

//返回上一级
-(void)doBack
{
    [self.navigationController popViewControllerAnimated:YES];
}

-(void)createLabelTwo:(NSString *)str
{
    if ([str floatValue] <= 0)
    {
        detailLabel.hidden = YES;
        
        _rightsKeepLab.frame = CGRectMake(_rightsKeepLab.frame.origin.x, detailLabel.frame.origin.y + 5, _rightsKeepLab.frame.size.width, _rightsKeepLab.frame.size.height);
    }
    else
    {
        detailLabel.hidden = NO;
        str = [NSString stringWithFormat:@"￥%@", str];
        NSString *string = [NSString stringWithFormat:@"即可获得%@元奖励，赶紧行动吧！", str];
        NSMutableAttributedString *temp =[self setStringdiffrentColor:string color:UIColorFromRGB(0x666666)];
        NSRange range=[string rangeOfString:str];
        temp = [self setStringdiffrentColor:temp color:UIColorFromRGB(0xfd7b31) range:range];
        [detailLabel setAttributedText:temp];
        
        _rightsKeepLab.frame = CGRectMake(_rightsKeepLab.frame.origin.x, CGRectGetMaxY(detailLabel.frame) + 3, _rightsKeepLab.frame.size.width, _rightsKeepLab.frame.size.height);
        
    }
    
    
}
-(void)createPageElementAttribution
{
    
    lineOneImageView.backgroundColor = UIColorFromRGB(0xeaeaea);
    myScrollView.scrollEnabled = YES;
    //myScrollView.pagingEnabled = YES;
    //scrollView.delegate = self;
    myScrollView.bounces = YES;
    myScrollView.contentOffset = CGPointMake(0, 0);
    myScrollView.clipsToBounds = NO;
    
    myScrollView.contentSize  = CGSizeMake(320, 568 - IOS7? 64 : 44);
    // myScrollView.backgroundColor = [UIColor redColor];
    myScrollView.frame = CGRectMake(0, 0, self.view.frame.size.width, (IOS7 ? 568 : 480) - 44 -IOS7? 20 : 0);
    myScrollView.userInteractionEnabled = YES;
    
}
//创建内容可动态变化的Label
-(void)createDynamicLabel:(NSString *)str
{
    NSMutableAttributedString *temp =[self setStringdiffrentColor:str color:[UIColor blackColor]];
    NSRange range=[str rangeOfString:@"￥2.00"];
    temp = [self setStringdiffrentColor:temp color:[UIColor redColor] range:range];
    [detailLabel setAttributedText:temp];
    //
    
}

//改变整个字符串颜色
-(NSMutableAttributedString *)setStringdiffrentColor:(NSString *)str color:(UIColor *)color
{
    NSMutableAttributedString *string = [[NSMutableAttributedString alloc]initWithString:str];
    NSRange range=[str rangeOfString:str];
    
    [string addAttribute:NSForegroundColorAttributeName value:color range:range];
    
    return string;
}

- (void)showNoMessage
{
    UIView *backView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, kScreenWidth, CONTENT_HEIGHT)];
    backView.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:backView];
    [self showEmpty:@""];
    
}

//改变制定字符串的颜色
-(NSMutableAttributedString *)setStringdiffrentColor:(NSMutableAttributedString *)string color:(UIColor *)color range:(NSRange)rangeTemp
{
    
    [string addAttribute:NSForegroundColorAttributeName value:color range:rangeTemp];
    
    return string;
}

//点击我的推广
-(void)clickMineEextend
{
    MineExtendDetailViewController *mineExtendView = [[MineExtendDetailViewController alloc]initWithNibName:@"MineExtendDetailViewController" bundle:nil];
    [self.navigationController pushViewController:mineExtendView animated:YES];
}
//点击更多推广
-(void)clickMoreExtend
{
    //    MTCustomActionSheet *actionSheet = [[MTCustomActionSheet alloc] initWithFrame:CGRectZero andImageArr:[NSArray arrayWithObjects:@"weixin",@"sinaweibo",@"messageperson",nil] nameArray:[NSArray arrayWithObjects:@"微信",@"新浪微博",@"短信",nil] orientation:0];
    //    actionSheet.delegate = self;
    //    [actionSheet showInView:self.view];
    BOOL isNormalH = [Utility isInstalledQQ] || [Utility isInstalledWX];
    
    _popView = [[UIView alloc]initWithFrame:[UIScreen mainScreen].bounds];
    _popView.backgroundColor = [UIColor colorWithWhite:0 alpha:0.5];
    AppDelegate *appDel = SHARED_APP_DELEGATE;
    [appDel.window addSubview:_popView];
    
    //灰色背景视图
    UIView *backView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, kScreenWidth, [UIScreen mainScreen].bounds.size.height - 215.0f - 50.0f)];
    if (!isNormalH)
    {
        backView.frame = CGRectMake(0, 0, kScreenWidth, [UIScreen mainScreen].bounds.size.height - 50.0f - 115.0f);
    }
    backView.backgroundColor = [UIColor clearColor];
    backView.userInteractionEnabled = YES;
    [_popView addSubview:backView];
    UITapGestureRecognizer *grayGesture = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(removeTheSuperView)];
    [backView addGestureRecognizer:grayGesture];
    
    _pushView = [[UIView alloc]initWithFrame:CGRectMake(0, CGRectGetMaxY(_popView.frame), kScreenWidth, isNormalH ? 265.0f : 165.0f)];
    _pushView.backgroundColor = [UIColor clearColor];
    [_popView addSubview:_pushView];
    
    HWShareView *shareView = [[HWShareView alloc]initWithShareTitile:SHARE_TITLE content:[NSString stringWithFormat:@"你的朋友 %@ %@", [HWUserLogin currentUserLogin].nickname, SHARE_CONTENT] image:[UIImage imageNamed:@"associate_kaola"] shareUrl:[_detailDic stringObjectForKey:@"downloadAddress"]];
    shareView.frame = CGRectMake(0, 0, kScreenWidth, 215.0f);
    if (!isNormalH)
    {
        shareView.frame = CGRectMake(0, 0, kScreenWidth, 115.0f);
    }
    shareView.backgroundColor = [UIColor whiteColor];
    shareView.copiesUrl = [_detailDic stringObjectForKey:@"downloadAddress"];
    shareView.superView = self.view;
    shareView.gameId = @"";
    [shareView showInView:self.view presentController:self];
    shareView.delegate = self;
    shareView.shareSource = 2;
    [_pushView addSubview:shareView];
    
    UIView *line = [[UIView alloc]initWithFrame:CGRectMake(0, CGRectGetMaxY(shareView.frame) - 0.5f, kScreenWidth, 0.5f)];
    line.backgroundColor = THEME_COLOR_LINE;
    [_pushView addSubview:line];
    
    //取消
    UILabel *cancleLabel = [[UILabel alloc]initWithFrame:CGRectMake(0, CGRectGetMaxY(line.frame), kScreenWidth, 50.f)];
    cancleLabel.backgroundColor = [UIColor whiteColor];
    cancleLabel.text = @"取消";
    cancleLabel.font = [UIFont fontWithName:FONTNAME size:18.0f];
    cancleLabel.textColor = THEME_COLOR_ORANGE;
    cancleLabel.textAlignment = NSTextAlignmentCenter;
    cancleLabel.userInteractionEnabled = YES;
    [_pushView addSubview:cancleLabel];
    
    UITapGestureRecognizer *gesture = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(removeTheSuperView)];
    [cancleLabel addGestureRecognizer:gesture];
    
    [UIView animateWithDuration:0.25 animations:^{
        _pushView.frame = CGRectMake(0, CGRectGetMaxY(backView.frame), kScreenWidth, _pushView.frame.size.height);
    }];
}

- (void)removeTheSuperView
{
    [UIView animateWithDuration:0.5 animations:^{
        _pushView.frame = CGRectMake(0, CGRectGetMaxY(_popView.frame), kScreenWidth, 265.0f);
    } completion:^(BOOL finished) {
        [_popView removeFromSuperview];
    }];
}

#pragma mark - HWShareView Delegate
- (void)removeSuperView
{
    [_popView removeFromSuperview];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
