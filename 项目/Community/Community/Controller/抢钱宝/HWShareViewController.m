//
//  HWShareViewController.m
//  Community
//
//  Created by caijingpeng.haowu on 14-8-28.
//  Copyright (c) 2014年 caijingpeng. All rights reserved.
//

#import "HWShareViewController.h"
#import "HWShareRefreshView.h"
#import "AppDelegate.h"
#import "HWShareSuccessViewController.h"
#import "HWShareDetailViewController.h"
#import "WXApi.h"

@interface HWShareViewController ()<HWShareRefreshViewDelegate, MTCustomActionSheetDelegate>
{
    HWShareItemClass *_toShareItem;
    NSString *_beforeShareState;
    UIImage *_toShareImage;
    HWShareRefreshView *_shareView ;
}
@end

@implementation HWShareViewController

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
    self.navigationItem.leftBarButtonItem = [Utility navLeftBackBtn:self action:@selector(backMethod)];
    self.navigationItem.titleView = [Utility navTitleView:@"红包"];
    
    _shareView = [[HWShareRefreshView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, CONTENT_HEIGHT)];
    _shareView.delegate = self;
    [self.view addSubview:_shareView];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(shareSuccess) name:@"shareSuccess" object:nil];
    
}


#pragma mark -
#pragma mark            Share Method

/**
 *	@brief	分享成功后回调
 *
 *	@param 	type
 *
 *	@return	x
 */

- (void)shareSuccess
{
    [_shareView queryListData];
}

- (void)shareSuccessWithType:(NSString *)type
{
    /* 如果网速慢  校验是否在当前navigationcontroller 下
     id vc = [self.navigationController.viewControllers lastObject];
     if (![vc isKindOfClass:[HWTabBarViewController class]])
     {
     return;
     }*/
    
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
    [dict setPObject:_toShareItem.activityId forKey:@"activityId"];
    [dict setPObject:wap forKey:@"way"];
    [dict setPObject:_beforeShareState forKey:@"shareStatus"];
    [dict setPObject:@"1" forKey:@"channel"];
    [manager redPacketPost:kShareSuccess parameters:dict queue:nil success:^(id responseObject) {
        // 分享成功
        
        [_shareView queryListData];
        HWShareSuccessViewController *successVC = [[HWShareSuccessViewController alloc] init];
        successVC.shareInfo = [responseObject dictionaryObjectForKey:@"data"];
        //        shareSucceed.strHouseID = [_shareDic stringObjectForKey:@"houseId"];
        successVC.shareBeforeIsMoney = _beforeShareState;
        [self.navigationController pushViewController:successVC animated:YES];
        
    } failure:^(NSString *code, NSString *error) {
        [Utility showToastWithMessage:error inView:self.view];
        
    }];
    //    [manager POST:kShareSuccess parameters:dict queue:nil success:^(id responseObject) {
    //
    //        // 分享成功
    //         HWShareSuccessViewController *successVC = [[HWShareSuccessViewController alloc] init];
    //         successVC.shareInfo = [responseObject dictionaryObjectForKey:@"data"];
    //         //        shareSucceed.strHouseID = [_shareDic stringObjectForKey:@"houseId"];
    //         successVC.shareBeforeIsMoney = _beforeShareState;
    //         [self.navigationController pushViewController:successVC animated:YES];
    //
    //
    //    } failure:^(NSString *code, NSString *error) {
    //        [Utility showToastWithMessage:error inView:self.view];
    //    }];
}

#pragma mark -
#pragma mark            HWShareRefreshView Delegate

- (void)toShareActivityWithState:(NSString *)shareState item:(HWShareItemClass *)shareItem image:(UIImage *)shareImage
{
    _toShareItem = shareItem;
    _beforeShareState = shareState;
    _toShareImage = shareImage;
    
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
    AppDelegate *appDel = (AppDelegate *)[UIApplication sharedApplication].delegate;
    [actionSheet showInView:appDel.window];
}

- (void)toSelectShareDetail:(HWShareItemClass *)shareItem coolTime:(int)coolTime shareImage:(UIImage *)image shareMethod:(NSString *)method
{
    
    HWShareDetailViewController *detailVC = [[HWShareDetailViewController alloc] init];
    detailVC.shareItem = shareItem;
    detailVC.coolTime = coolTime;
    detailVC.shareImage = image;
    [self.navigationController pushViewController:detailVC animated:YES];
    
}


#pragma mark -
#pragma mark            MTCustomActionSheet Delegate

- (void)actionSheet:(MTCustomActionSheet *)actionSheet didClickButtonByIndex:(int)index
{
    if ([_toShareImage isEqual:IMAGE_BREAK_CUBE] || [_toShareImage isEqual:IMAGE_PLACE])
    {
        _toShareImage = [UIImage imageNamed:@"Icon"];
    }
    
    if ([Utility isInstalledQQAndInstalledWX])
    {
        if (index == 0) // 分享微信朋友圈
        {
            [MobClick event:@"click_sharekickbacks_wechatcircle"];
            if (![WXApi isWXAppInstalled]){
                return;
            }
            NSString *url = [NSString stringWithFormat:@"%@&way=1",_toShareItem.shareUrl];
            NSString *shareText = [NSString stringWithFormat:@"%@",_toShareItem.activityTitle.length > 0 ? _toShareItem.activityTitle : SHARE_TEXT];
            
            [UMSocialData defaultData].extConfig.wxMessageType = UMSocialWXMessageTypeApp;
            [UMSocialData defaultData].urlResource.url = url;
            [UMSocialData defaultData].extConfig.wechatTimelineData.url = url;
            [UMSocialData defaultData].extConfig.wechatSessionData.url = url;
            [UMSocialData defaultData].extConfig.title = shareText;
            
            NSLog(@"%@",[UMSocialSnsPlatformManager sharedInstance].allSnsValuesArray);
            
            
            [[UMSocialDataService defaultDataService]  postSNSWithTypes:@[UMShareToWechatTimeline] content:shareText image:_toShareImage location:nil urlResource:nil presentedController:self completion:^(UMSocialResponseEntity *response)
             {
                 if (response.responseCode == UMSResponseCodeSuccess)
                 {
                     NSLog(@"分享成功！");
                     [self shareSuccessWithType:[[response.data allKeys] objectAtIndex:0]];
                     //                 HWShareSuccessViewController *successVC = [[HWShareSuccessViewController alloc] init];
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
            
            NSString *url = [NSString stringWithFormat:@"%@&way=5",_toShareItem.shareUrl];
            NSString *shareText = [NSString stringWithFormat:@"%@ %@",_toShareItem.activityTitle, url];
            shareText = shareText.length > 0 ? shareText : SHARE_TEXT;
            _toShareItem.shareLinkTitle = _toShareItem.shareLinkTitle.length > 0 ? _toShareItem.shareLinkTitle : SHARE_TEXT;
            //分享内容设置
            
            [UMSocialData defaultData].extConfig.qzoneData.url = url;
            [UMSocialData defaultData].extConfig.qzoneData.title = _toShareItem.shareLinkTitle;
            [UMSocialData defaultData].extConfig.qzoneData.shareText = shareText;
            [UMSocialData defaultData].extConfig.qzoneData.shareImage = UIImageJPEGRepresentation(_toShareImage, 0.1f);
            //分享数据，平台设置   UMSocialQzoneData
            [[UMSocialDataService defaultDataService] postSNSWithTypes:@[UMShareToQzone] content:shareText image:nil location:nil urlResource:nil presentedController:self completion:^(UMSocialResponseEntity *response)
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
            if (![WXApi isWXAppInstalled]){
                return;
            }
            NSString *url = [NSString stringWithFormat:@"%@&way=1",_toShareItem.shareUrl];
            NSString *shareText = [NSString stringWithFormat:@"%@",_toShareItem.activityTitle.length > 0 ? _toShareItem.activityTitle : SHARE_TEXT];
            
            [UMSocialData defaultData].extConfig.wxMessageType = UMSocialWXMessageTypeApp;
            [UMSocialData defaultData].urlResource.url = url;
            [UMSocialData defaultData].extConfig.wechatTimelineData.url = url;
            [UMSocialData defaultData].extConfig.wechatSessionData.url = url;
            [UMSocialData defaultData].extConfig.title = shareText;
            
            NSLog(@"%@",[UMSocialSnsPlatformManager sharedInstance].allSnsValuesArray);
            
            
            [[UMSocialDataService defaultDataService]  postSNSWithTypes:@[UMShareToWechatTimeline] content:shareText image:_toShareImage location:nil urlResource:nil presentedController:self completion:^(UMSocialResponseEntity *response)
             {
                 if (response.responseCode == UMSResponseCodeSuccess)
                 {
                     NSLog(@"分享成功！");
                     [self shareSuccessWithType:[[response.data allKeys] objectAtIndex:0]];
                     //                 HWShareSuccessViewController *successVC = [[HWShareSuccessViewController alloc] init];
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
            
            NSString *url = [NSString stringWithFormat:@"%@&way=5",_toShareItem.shareUrl];
            NSString *shareText = [NSString stringWithFormat:@"%@ %@",_toShareItem.activityTitle, url];
            shareText = shareText.length > 0 ? shareText : SHARE_TEXT;
            _toShareItem.shareLinkTitle = _toShareItem.shareLinkTitle.length > 0 ? _toShareItem.shareLinkTitle : SHARE_TEXT;
            //分享内容设置
            
            [UMSocialData defaultData].extConfig.qzoneData.url = url;
            [UMSocialData defaultData].extConfig.qzoneData.title = _toShareItem.shareLinkTitle;
            [UMSocialData defaultData].extConfig.qzoneData.shareText = shareText;
            [UMSocialData defaultData].extConfig.qzoneData.shareImage = UIImageJPEGRepresentation(_toShareImage, 0.1f);
            //分享数据，平台设置   UMSocialQzoneData
            [[UMSocialDataService defaultDataService] postSNSWithTypes:@[UMShareToQzone] content:shareText image:nil location:nil urlResource:nil presentedController:self completion:^(UMSocialResponseEntity *response)
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
