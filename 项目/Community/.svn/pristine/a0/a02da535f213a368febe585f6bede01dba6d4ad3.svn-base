//
//  HWShareDetailViewController.m
//  Community
//
//  Created by caijingpeng.haowu on 14-9-15.
//  Copyright (c) 2014年 caijingpeng. All rights reserved.
//

#import "HWShareDetailViewController.h"
#import "HWHouseDetailViewController.h"
#import "HWHaiwaiDetailViewController.h"
#import "HWShareSuccessViewController.h"
#import "WXApi.h"

@interface HWShareDetailViewController ()

@end

@implementation HWShareDetailViewController
@synthesize shareItem;
@synthesize shareImage;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.navigationItem.leftBarButtonItem = [Utility navLeftBackBtn:self action:@selector(backMethod)];
    self.navigationItem.titleView = [Utility navTitleView:@"活动分享"];
    
    //web内容页初始化
    _webView = [[UIWebView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, CONTENT_HEIGHT - 50)];
    _webView.delegate = self;
    [self.view addSubview:_webView];
    
    //详情按钮初始化
    _detailButton= [UIButton buttonWithType:UIButtonTypeCustom];
    _detailButton.frame = CGRectMake(0, CGRectGetMaxY(_webView.frame), kScreenWidth / 2.0f, 50);
    [_detailButton setTitle:@"查看楼盘详情" forState:UIControlStateNormal];
    [_detailButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    _detailButton.titleLabel.font = [UIFont fontWithName:FONTNAME size:16];
    [_detailButton setButtonGrayStyle];
    _detailButton.layer.cornerRadius = 0;
    [_detailButton addTarget:self action:@selector(showDetail) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:_detailButton];
    //分享按钮初始化
    _shareButton = [UIButton buttonWithType:UIButtonTypeCustom];
    _shareButton.frame = CGRectMake(kScreenWidth / 2.0f, CGRectGetMaxY(_webView.frame), kScreenWidth / 2.0f, 50);
    _shareButton.titleLabel.font = [UIFont fontWithName:FONTNAME size:16];
    [_shareButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [_shareButton setButtonOrangeStyle];
    _shareButton.layer.cornerRadius = 0;
    [_shareButton addTarget:self action:@selector(doShare) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:_shareButton];
    //是否有分享返现
    [self requestWithActivityID:self.shareItem.activityId];
    
    if (self.coolTime > 0)
    {
        timer = [NSTimer scheduledTimerWithTimeInterval:1.0f target:self selector:@selector(countDown) userInfo:nil repeats:YES];
        [[NSRunLoop currentRunLoop] addTimer:timer forMode:NSRunLoopCommonModes];
    }
    
    [self setShareButtonTitle];
    
    if ([Utility isNullQQAndWX])
    {
        _detailButton.frame = CGRectMake(0, CGRectGetMaxY(_webView.frame), kScreenWidth, 50);
        _shareButton.hidden = YES;
    }
    else
    {
        _detailButton.frame = CGRectMake(0, CGRectGetMaxY(_webView.frame), kScreenWidth / 2.0f, 50);
        _shareButton.frame = CGRectMake(kScreenWidth / 2.0f, CGRectGetMaxY(_webView.frame), kScreenWidth / 2.0f, 50);
        _shareButton.hidden = NO;
    }
}




#pragma mark -
#pragma mark Private Method

- (void)doShare
{
    [self requestBeforeShare];
}

/**
 *	@brief	判断是否有返现请求方法
 *
 *	@return	x
 */
- (void)requestBeforeShare

{
    //判断是否有返现
    HWHTTPRequestOperationManager *manager = [HWHTTPRequestOperationManager societyManager];
    
    NSMutableDictionary *dict = [NSMutableDictionary dictionary];
    [dict setPObject:[HWUserLogin currentUserLogin].key forKey:@"key"];
    [dict setPObject:shareItem.activityId forKey:@"activityId"];
    [dict setPObject:[Utility getUUID] forKey:@"mac"];
    [dict setPObject:@"1" forKey:@"channel"];
    //    NSLog(@"dic = %@",dict);
    
    //    [Utility showMBProgress:self.view message:@"请求数据"];
    [manager redPacketPost:kShareBefore parameters:dict queue:nil success:^(id responseObject) {
        _beforeShareState = [responseObject stringObjectForKey:@"data"];
        if ([_beforeShareState isEqualToString:@"1"])
        {
            // 分享有钱
            [self shareFunction];
        }
        else
        {
            // 分享没钱
            
            NSString *msg = [responseObject stringObjectForKey:@"detail"];
            if ([msg isEqualToString:@""])
            {
                msg = @"分享红包被抢完啦，你还要继续分享吗？";
            }
            
            UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"提示" message:msg delegate:self cancelButtonTitle:@"取消" otherButtonTitles:@"确定", nil];
            [alert show];
        }
        
    } failure:^(NSString *code, NSString *error) {
        [Utility showToastWithMessage:error inView:self.view];
        
    }];
    
}

- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    if (buttonIndex == 1)
    {
        [self shareFunction];
    }
}

- (void)shareFunction
{
    [MobClick event:@"click_share_kickbacks"];
    if ([HWUserLogin verifyBindMobileWithPopVC:self showAlert:YES])
    {
        if ([HWUserLogin verifyIsLoginWithPresentVC:self toViewController:nil])
        {
            NSMutableArray *arrImage = [[NSMutableArray alloc] init];
            NSMutableArray *arrName = [[NSMutableArray alloc] init];
            if ([Utility isInstalledWX])
            {
                [arrImage addObject:@"share_weixin161"];
                [arrName addObject:@"朋友圈"];
            }
            if ([Utility isInstalledQQ])
            {
                [arrImage addObject:@"share_qzone161"];
                [arrName addObject:@"QQ空间"];
            }
            
            MTCustomActionSheet *actionSheet = [[MTCustomActionSheet alloc] initWithFrame:CGRectZero andImageArr:arrImage nameArray:arrName orientation:0];
            actionSheet.delegate = self;
            
            //    AppDelegate *appDel = (AppDelegate *)[UIApplication sharedApplication].delegate;
            [actionSheet showInView:self.view];
        }
    }
}

#pragma mark -
#pragma mark MTCustomActionSheet Delegate

- (void)actionSheet:(MTCustomActionSheet *)actionSheet didClickButtonByIndex:(int)index
{
    if ([Utility isInstalledQQAndInstalledWX])
    {
        if (index == 0) // 分享微信朋友圈
        {
            [MobClick event:@"click_sharekickbacks_wechatcircle"];
            if (![WXApi isWXAppInstalled]) {
                return;
            }
            NSString *url = [NSString stringWithFormat:@"%@&way=1",shareItem.shareUrl];
            NSString *shareText = [NSString stringWithFormat:@"%@ %@", shareItem.shareLinkTitle, shareItem.activityTitle];
            shareText = shareText.length > 0 ? shareText : DEFAULTSHARECONTENT;
            
            [UMSocialData defaultData].extConfig.wxMessageType = UMSocialWXMessageTypeApp;
            [UMSocialData defaultData].urlResource.url = url;
            [UMSocialData defaultData].extConfig.wechatTimelineData.url = url;
            [UMSocialData defaultData].extConfig.wechatSessionData.url = url;
            [UMSocialData defaultData].extConfig.title = shareText;
            
            //        NSLog(@"%@",[UMSocialSnsPlatformManager sharedInstance].allSnsValuesArray);
            
            
            [[UMSocialDataService defaultDataService]  postSNSWithTypes:@[UMShareToWechatTimeline] content:shareText image:shareImage location:nil urlResource:nil presentedController:self completion:^(UMSocialResponseEntity *response)
             {
                 if (response.responseCode == UMSResponseCodeSuccess)
                 {
                     NSLog(@"分享成功！");
                     [self shareSuccessWithType:[[response.data allKeys] objectAtIndex:0]];
                     //                 HWShareSuccessViewController *successVC = [[HWShareSuccessViewController alloc] init];\
                     //                 [self.navigationController pushViewController:successVC animated:YES];
                 }
                 else
                 {
                     [Utility showToastWithMessage:@"分享失败" inView:self.view];
                 }
             }];
        }
        else if (index == 1) // 分享QQZone
        {
            //直接到QQ
            
            //分享数据的采集
            
            NSString *url = [NSString stringWithFormat:@"%@&way=5",shareItem.shareUrl];
            NSString *shareText = [NSString stringWithFormat:@"%@ %@",shareItem.activityTitle, url];
            shareText = shareText.length > 0 ? shareText : DEFAULTSHARECONTENT;
            
            NSString *shareTitle = shareItem.shareLinkTitle.length > 0 ? shareItem.shareLinkTitle : SHARE_TEXT;
            //分享内容设置
            
            [UMSocialData defaultData].extConfig.qzoneData.url = url;
            [UMSocialData defaultData].extConfig.qzoneData.title = shareTitle;
            [UMSocialData defaultData].extConfig.qzoneData.shareText = shareText;
            [UMSocialData defaultData].extConfig.qzoneData.shareImage = UIImageJPEGRepresentation(shareImage,0.1f);
            
            //分享数据，平台设置   UMSocialQzoneData
            [[UMSocialDataService defaultDataService]  postSNSWithTypes:@[UMShareToQzone] content:shareText image:nil location:nil urlResource:nil presentedController:self completion:^(UMSocialResponseEntity *response)
             {
                 if (response.responseCode == UMSResponseCodeSuccess)
                 {
                     [self shareSuccessWithType:[[response.data allKeys] objectAtIndex:0]];
                 }
                 else
                 {
                     [Utility showToastWithMessage:@"分享失败" inView:self.view];
                 }
             }];
            
        }
    }
    else
    {
        if ([Utility isInstalledWX])
        {
            [MobClick event:@"click_sharekickbacks_wechatcircle"];
            if (![WXApi isWXAppInstalled]) {
                return;
            }
            NSString *url = [NSString stringWithFormat:@"%@&way=1",shareItem.shareUrl];
            NSString *shareText = [NSString stringWithFormat:@"%@ %@", shareItem.shareLinkTitle, shareItem.activityTitle];
            shareText = shareText.length > 0 ? shareText : DEFAULTSHARECONTENT;
            
            [UMSocialData defaultData].extConfig.wxMessageType = UMSocialWXMessageTypeApp;
            [UMSocialData defaultData].urlResource.url = url;
            [UMSocialData defaultData].extConfig.wechatTimelineData.url = url;
            [UMSocialData defaultData].extConfig.wechatSessionData.url = url;
            [UMSocialData defaultData].extConfig.title = shareText;
            
            //        NSLog(@"%@",[UMSocialSnsPlatformManager sharedInstance].allSnsValuesArray);
            
            
            [[UMSocialDataService defaultDataService]  postSNSWithTypes:@[UMShareToWechatTimeline] content:shareText image:shareImage location:nil urlResource:nil presentedController:self completion:^(UMSocialResponseEntity *response)
             {
                 if (response.responseCode == UMSResponseCodeSuccess)
                 {
                     NSLog(@"分享成功！");
                     [self shareSuccessWithType:[[response.data allKeys] objectAtIndex:0]];
                     //                 HWShareSuccessViewController *successVC = [[HWShareSuccessViewController alloc] init];\
                     //                 [self.navigationController pushViewController:successVC animated:YES];
                 }
                 else
                 {
                     [Utility showToastWithMessage:@"分享失败" inView:self.view];
                 }
             }];
        }
        
        if ([Utility isInstalledQQ])
        {
            //直接到QQ
            
            //分享数据的采集
            
            NSString *url = [NSString stringWithFormat:@"%@&way=5",shareItem.shareUrl];
            NSString *shareText = [NSString stringWithFormat:@"%@ %@",shareItem.activityTitle, url];
            shareText = shareText.length > 0 ? shareText : DEFAULTSHARECONTENT;
            
            NSString *shareTitle = shareItem.shareLinkTitle.length > 0 ? shareItem.shareLinkTitle : SHARE_TEXT;
            //分享内容设置
            
            [UMSocialData defaultData].extConfig.qzoneData.url = url;
            [UMSocialData defaultData].extConfig.qzoneData.title = shareTitle;
            [UMSocialData defaultData].extConfig.qzoneData.shareText = shareText;
            [UMSocialData defaultData].extConfig.qzoneData.shareImage = UIImageJPEGRepresentation(shareImage,0.1f);
            
            //分享数据，平台设置   UMSocialQzoneData
            [[UMSocialDataService defaultDataService]  postSNSWithTypes:@[UMShareToQzone] content:shareText image:nil location:nil urlResource:nil presentedController:self completion:^(UMSocialResponseEntity *response)
             {
                 if (response.responseCode == UMSResponseCodeSuccess)
                 {
                     [self shareSuccessWithType:[[response.data allKeys] objectAtIndex:0]];
                 }
                 else
                 {
                     [Utility showToastWithMessage:@"分享失败" inView:self.view];
                 }
             }];
        }
        
    }
    
}

- (void)shareSuccessWithType:(NSString *)type
{
    //    id vc = [self.navigationController.viewControllers lastObject];
    //    if (![vc isKindOfClass:[HWTabBarViewController class]])
    //    {
    //        return;
    //    }
    
    //得到分享到的微博平台名
    NSString *wap = nil;
    if ([type isEqualToString:@"wxtimeline"])
    {
        wap = @"1";
    }
    else
    {
        wap = @"5";
    }
    HWHTTPRequestOperationManager *manager = [HWHTTPRequestOperationManager societyManager];
    NSMutableDictionary *dict = [NSMutableDictionary dictionary];
    
    [dict setPObject:[HWUserLogin currentUserLogin].key forKey:@"key"];
    [dict setPObject:shareItem.activityId forKey:@"activityId"];
    [dict setPObject:wap forKey:@"way"];
    [dict setPObject:_beforeShareState forKey:@"shareStatus"];
    [dict setPObject:@"1" forKey:@"channel"];
    
    [manager redPacketPost:kShareSuccess parameters:dict queue:nil success:^(id responseObject) {
        
        [[NSNotificationCenter defaultCenter] postNotificationName:@"shareSuccess" object:nil];
        HWShareSuccessViewController *successVC = [[HWShareSuccessViewController alloc] init];
        successVC.shareInfo = [responseObject dictionaryObjectForKey:@"data"];
        //        shareSucceed.strHouseID = [_shareDic stringObjectForKey:@"houseId"];
        successVC.shareBeforeIsMoney = _beforeShareState;
        [self.navigationController pushViewController:successVC animated:YES];
        
    } failure:^(NSString *code, NSString *error) {
        [Utility showToastWithMessage:error inView:self.view];
        
    }];
}

- (void)countDown
{
    self.coolTime++;
    
    [self setShareButtonTitle];
}

- (void)setShareButtonTitle
{
    NSInteger freezeTime = [shareItem.freezeRemainMillis integerValue] / 1000.0f;
    NSInteger remaindTime = freezeTime - self.coolTime;
    
    NSInteger hour = remaindTime / 60 / 60;
    NSInteger minute = remaindTime / 60 % 60;
    NSInteger second = (remaindTime) % 60;
    if (shareItem.started.intValue == 0)
    {
#warning 倒计时
        if (remaindTime > 0)
        {
            // 活动未开始
            [_shareButton setFreezeStyle];
            NSInteger secInt = 0;
            
            secInt = remaindTime / 60;
            
            NSString *str;
            str = [NSString stringWithFormat:@"%02ld:%02ld:%02ld",hour, minute, second];
            [_shareButton setTitle:str forState:UIControlStateNormal];
            _shareButton.userInteractionEnabled = NO;
        }
        else
        {
            [_shareButton setNonFreezeStyle];
            NSString *str = [NSString stringWithFormat:@"￥%@分享", [self handleNumber:shareItem.sharedMoney]];
            [_shareButton setTitle:str forState:UIControlStateNormal];
            _shareButton.userInteractionEnabled = YES;
        }
        
    }
    else if (shareItem.sharedMoney.floatValue > 0 &&
             (shareItem.restMoney.floatValue - shareItem.sharedMoney.floatValue) >= 0 &&
             shareItem.shareState.intValue == 1)
    {
        
        if (shareItem.shareState.intValue == 0)
        {
            [_shareButton setTitle:@"分享" forState:UIControlStateNormal];
            _shareButton.userInteractionEnabled = NO;
            
        }
        if (shareItem.shareState.intValue == 1) {
            if (remaindTime > 0)
            {
                [_shareButton setFreezeStyle];
                NSInteger secInt = 0;
                
                secInt = remaindTime / 60;
                NSString *str;
                str = [NSString stringWithFormat:@"%02d:%02d:%02d",hour, minute, second];
                [_shareButton setTitle:str forState:UIControlStateNormal];
                _shareButton.userInteractionEnabled = NO;
            }
            else
            {
                [_shareButton setNonFreezeStyle];
                NSString *str = [NSString stringWithFormat:@"￥%@分享", [self handleNumber:shareItem.sharedMoney]];
                [_shareButton setTitle:str forState:UIControlStateNormal];
                _shareButton.userInteractionEnabled = YES;
            }
            
        }
        
    }
    
    else if (shareItem.shareMethod.intValue == 1)
    {
        if (shareItem.shareState.intValue == 0)
        {
            [_shareButton setNonFreezeStyle];
            [_shareButton setTitle:@"分享" forState:UIControlStateNormal];
            _shareButton.userInteractionEnabled = YES;
        }
        if (shareItem.shareState.intValue == 1)
        {
            if (remaindTime > 0)
            {
                [_shareButton setFreezeStyle];
                NSInteger secInt = 0;
                
                secInt = remaindTime / 60;
                NSString *str;
                str = [NSString stringWithFormat:@"%02d:%02d:%02d",hour, minute, second];
                [_shareButton setTitle:str forState:UIControlStateNormal];
                _shareButton.userInteractionEnabled = NO;
            }
            else
            {
                [_shareButton setNonFreezeStyle];
                if (shareItem.restNum.intValue == 0 || shareItem.restNum.length == 0)
                {
                    [_shareButton setTitle:@"分享" forState:UIControlStateNormal];
                    
                }
                else
                {
                    [_shareButton setTitle:@"神秘红包" forState:UIControlStateNormal];
                }
                _shareButton.userInteractionEnabled = YES;
            }
            
        }
        
        
    }
    
    else
    {
        [_shareButton setNonFreezeStyle];
        if (shareItem.shareMethod.intValue == 0) {
            [_shareButton setTitle:@"分享" forState:UIControlStateNormal];
            
        }
        if (shareItem.shareMethod.intValue == 1) {
            if ([shareItem.restNum isEqualToString:@"0"] || shareItem.restNum.length == 0 || shareItem.restNum == nil) {
                [_shareButton setTitle:@"分享" forState:UIControlStateNormal];
            }
            else
            {
                [_shareButton setTitle:@"神秘红包" forState:UIControlStateNormal];
                
            }
        }
        _shareButton.userInteractionEnabled = YES;
    }
}

- (NSString *)handleNumber:(NSString *)string
{
    NSString *finalMoney = nil;
    if (string.intValue / 10000)
    {
        if (string.intValue % 10000 > 0)
        {
            finalMoney = [NSString stringWithFormat:@"%.1f万",string.floatValue/10000.0f];
        }
        else
        {
            finalMoney = [NSString stringWithFormat:@"%d万",string.intValue/10000];
        }
        
    }
    else if (string.intValue / 1000)
    {
        if (string.intValue % 1000 > 0)
        {
            finalMoney = [NSString stringWithFormat:@"%.1f千",string.floatValue/1000.0f];
        }
        else
        {
            finalMoney = [NSString stringWithFormat:@"%d千",string.intValue/1000];
        }
    }
    else
    {
        finalMoney = string;
    }
    return finalMoney;
}

/**
 *	@brief	查看房源详情
 *
 *	@return	x
 */
- (void)showDetail
{
    int isHaiWaiSource = [self.shareItem.haiwaiCountry intValue];
    //    [MobClick event:@""];
    if (isHaiWaiSource == 0)
    {
        HWHouseDetailViewController *houseVC = [[HWHouseDetailViewController alloc] init];
        houseVC.houseId = self.shareItem.houseId;
        [self.navigationController pushViewController:houseVC animated:YES];
    }
    else
    {
        HWHaiwaiDetailViewController *haiwaiVC = [[HWHaiwaiDetailViewController alloc] init];
        haiwaiVC.houseId = self.shareItem.houseId;
        [self.navigationController pushViewController:haiwaiVC animated:YES];
    }
    
}

/**
 *	@brief	分享活动请求
 *
 *	@param 	activityID
 *
 *	@return	x
 */
- (void)requestWithActivityID:(NSString *)activityID
{
    
    NSMutableDictionary *param = [NSMutableDictionary dictionary];
    [param setPObject:activityID forKey:@"activityId"];
    [param setPObject:[HWUserLogin currentUserLogin].key forKey:@"key"];
    [param setPObject:@"1" forKey:@"channel"];
    HWHTTPRequestOperationManager *manager = [HWHTTPRequestOperationManager societyManager];
    [manager POST:kGetShareContent parameters:param queue:nil success:^(id responseObject) {
        //NSLog(@"%@",responseObject);
        
        _shareDetail = [[HWShareDetailClass alloc] initWithDictionary:[responseObject dictionaryObjectForKey:@"data"]];
        
        if (_shareDetail.houseId.intValue == -1)
        {
            [_detailButton setHidden:YES];
            _shareButton.frame = CGRectMake(0, CGRectGetMaxY(_webView.frame), kScreenWidth,50);
        }
        else
        {
            [_detailButton setHidden:NO];
            _shareButton.frame = CGRectMake(kScreenWidth / 2.0f, CGRectGetMaxY(_webView.frame), kScreenWidth / 2.0f, 50);
        }
        NSURLRequest *request =[NSURLRequest requestWithURL:[NSURL URLWithString:_shareDetail.contentUrl]];
        
        [_webView loadRequest:request];
        
    } failure:^(NSString *code, NSString *error) {
        [Utility showToastWithMessage:error inView:self.view];
    }];
}


#pragma mark -
#pragma mark webview delegate

- (void)webViewDidStartLoad:(UIWebView *)webView
{
    [Utility showMBProgress:self.view message:@"请求数据"];
}

- (void)webViewDidFinishLoad:(UIWebView *)webView
{
    [Utility hideMBProgress:self.view];
}

- (void)webView:(UIWebView *)webView didFailLoadWithError:(NSError *)error
{
    [Utility hideMBProgress:self.view];
}

-(BOOL)webView:(UIWebView *)webView shouldStartLoadWithRequest:(NSURLRequest *)request navigationType:(UIWebViewNavigationType)navigationType;
{
    return YES;
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
