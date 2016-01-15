//
//  HWCheckForceUpdateWidget.m
//  MoreHouse
//
//  Created by caijingpeng.haowu on 14/12/25.
//  Copyright (c) 2014年 lizhongqiang. All rights reserved.
//

#import "HWCheckForceUpdateWidget.h"
#import "SBJsonParser.h"
#import "HWNetWorkManager.h"

@implementation HWCheckForceUpdateWidget
@synthesize dependView;
@synthesize reachabiltiy;

- (id)initWithDependView:(UIView *)view
{
    self = [super init];
    
    if (self)
    {
        self.dependView = view;
        _isForceUpdate = @"N";
        [self checkNetworkConnection];
    }
    
    return self;
}

/**
 *	@brief	检查网络连接
 *
 *	@return
 */
- (void)checkNetworkConnection
{
    self.reachabiltiy = [Reachability reachabilityWithHostName:@"www.haowu.com"];
    [self.reachabiltiy startNotifier];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(networkChanged:) name:kReachabilityChangedNotification object:nil];
}

/**
 *	@brief	网络变化 回调函数
 *
 *	@param 	notify 	通知
 *
 *	@return
 */
- (void)networkChanged:(NSNotification *)notify
{
    if ([Utility isConnectionAvailable])
    {
        [[HWNetWorkManager currentManager] commitIconChange];   //上传icon更改
        [[HWNetWorkManager currentManager] postSavedZan];   //上传本地保存的赞
    }
    
    Reachability *curReach = [notify object];
    NSParameterAssert([curReach isKindOfClass: [Reachability class]]);
    NetworkStatus networkStatus = [curReach currentReachabilityStatus];
    switch (networkStatus)
    {
        case NotReachable:
        {
            if (self.dependView != nil)
            {
                [Utility showToastWithMessage:@"网络未连接" inView:self.dependView];
            }
            
            break;
        }
        case ReachableViaWiFi:
        {
            [self checkForceUpdateVersion];
            break;
        }
        case ReachableViaWWAN:
        {
            [self checkForceUpdateVersion];
            break;
        }
        default:
            break;
    }
}

- (void)checkForceUpdateVersion
{
    HWHTTPRequestOperationManager *httpManager = [HWHTTPRequestOperationManager manager];
    NSMutableDictionary *dict = [NSMutableDictionary dictionary];
    [dict setPObject:@"community" forKey:@"domain"]; //【"society"社会版,"org"机构版,"robguest"抢客宝,"assitant"案场助理】
    [dict setPObject:@"ios" forKey:@"os"];
    [dict setPObject:[Utility getLocalAppVersion] forKey:@"versionCode"];
    
    [httpManager POST:kForceUpdate parameters:dict queue:nil success:^(id responseObject) {
        
        NSDictionary *dic = [responseObject dictionaryObjectForKey:@"data"];
        NSString *isforce = [NSString stringWithFormat:@"%@",[dic stringObjectForKey:@"isforce"]];
        NSString *isNeeded = [NSString stringWithFormat:@"%@",[dic stringObjectForKey:@"needed"]];
        NSString *updateMsg = [dic stringObjectForKey:@"updateMessage"];
        if ([isforce isEqualToString:@"Y"])
        {
            UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"提示" message:updateMsg delegate:self cancelButtonTitle:nil otherButtonTitles:@"更新", nil];
            [alert showAlertViewWithCompleteBlock:^(NSInteger buttonIndex) {
                if (buttonIndex == 0)
                {
                    dispatch_async(dispatch_get_main_queue(), ^{
                        [[UIApplication sharedApplication] openURL:[NSURL URLWithString:ITUNSE_DOWNLOAD_URL]];
                    });
                }
            }];
            
            _isForceUpdate = @"Y";
            _forceUpdateMsg = updateMsg;
        }
        else if ([isNeeded isEqualToString:@"Y"])
        {
            NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
            
            if (![defaults objectForKey:@"hasRemindUpdate"])
            {
                UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"提示" message:updateMsg delegate:self cancelButtonTitle:@"取消" otherButtonTitles:@"确定", nil];
                [alert showAlertViewWithCompleteBlock:^(NSInteger buttonIndex) {
                    if (buttonIndex == 1)
                    {
                        dispatch_async(dispatch_get_main_queue(), ^{
                            [[UIApplication sharedApplication] openURL:[NSURL URLWithString:ITUNSE_DOWNLOAD_URL]];
                        });
                    }
                }];
            }
            
            [defaults setObject:@"1" forKey:@"hasRemindUpdate"];
            [defaults synchronize];
        }
    } failure:^(NSString *code, NSString *error) {
        
    }];
}

//- (void)checkAppVersion
//{
//    [self performSelectorInBackground:@selector(synCheckAppVersion) withObject:nil];
//}
//
//- (void)checkAppVersionNoAlert
//{
//    [self performSelectorInBackground:@selector(synCheckAppVersionNoAlert) withObject:nil];
//}
//
//- (void)synCheckAppVersionNoAlert
//{
//    NSString *string = [NSString stringWithFormat:@"http://itunes.apple.com/lookup?id=%@",APP_ID];
//    NSData *data=  [NSData dataWithContentsOfURL:[NSURL URLWithString:string]];
//    SBJsonParser *parser = [[SBJsonParser alloc]init];
//    NSDictionary *dict = [parser objectWithData:data];
//    
//    if (dict == nil)
//    {
//        // [AppShare alertMB:self.window message:@"检测版本超时"];
//        return;
//    }
//    
//    if (![[[[dict arrayObjectForKey:@"results"]lastObject] stringObjectForKey:@"version"] isEqualToString:[Utility getLocalAppVersion]])
//    {
//
//        NSString *msg = [[[dict objectForKey:@"results"] lastObject] stringObjectForKey:@"releaseNotes"];
//        if (msg.length > 0)
//        {
//            UIAlertView *_alert = [[UIAlertView alloc] initWithTitle:@"新版本更新" message:[[[dict objectForKey:@"results"] lastObject] objectForKey:@"releaseNotes"] delegate:self cancelButtonTitle:@"取消" otherButtonTitles:@"确定", nil];
//            [_alert performSelectorOnMainThread:@selector(show) withObject:nil waitUntilDone:YES];
//            
//            [[NSNotificationCenter defaultCenter]postNotificationName:@"checkOut" object:nil userInfo:@{@"update":msg}];
//        }
//    }
//}

- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    if (buttonIndex == 1)
    {
        [[UIApplication sharedApplication] openURL:[NSURL URLWithString:ITUNSE_DOWNLOAD_URL]];
    }
}

// 同步请求 
//- (void)synCheckAppVersion
//{
//    NSString *string = [NSString stringWithFormat:@"http://itunes.apple.com/lookup?id=%@",APP_ID];
//    NSData *data=  [NSData dataWithContentsOfURL:[NSURL URLWithString:string]];
//    SBJsonParser *parser = [[SBJsonParser alloc]init];
//    NSDictionary *dict = [parser objectWithData:data];
//    
//    if (dict == nil)
//    {
//        // [AppShare alertMB:self.window message:@"检测版本超时"];
//        return;
//    }
//    
//    if (![[[[dict arrayObjectForKey:@"results"]lastObject] stringObjectForKey:@"version"] isEqualToString:[Utility getLocalAppVersion]])
//    {
//        NSString *msg = [[[dict objectForKey:@"results"] lastObject] stringObjectForKey:@"releaseNotes"];
//        if (msg.length > 0)
//        {
//            UIAlertView *_alert = [[UIAlertView alloc] initWithTitle:@"新版本更新" message:[[[dict objectForKey:@"results"] lastObject] objectForKey:@"releaseNotes"] delegate:self cancelButtonTitle:@"取消" otherButtonTitles:@"确定", nil];
//            [_alert performSelectorOnMainThread:@selector(show) withObject:nil waitUntilDone:YES];
//        }
//        else
//        {
//            if (self.dependView != nil)
//            {
//                [Utility showToastWithMessage:@"已是最新版" inView:self.dependView];
//            }
//        }
//    }
//    else
//    {
//        if (self.dependView != nil)
//        {
//            [Utility showToastWithMessage:@"已是最新版" inView:self.dependView];
//        }
//    }
//}

//- (void)checkForceUpdate
//{
//    [self checkAppVersionNoAlert];
//    
//    if ([_isForceUpdate isEqualToString:@"Y"])
//    {
//        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"提示" message:_forceUpdateMsg delegate:self cancelButtonTitle:nil otherButtonTitles:@"更新", nil];
//        [alert showAlertViewWithCompleteBlock:^(NSInteger buttonIndex) {
//            if (buttonIndex == 0)
//            {
//                [[UIApplication sharedApplication] openURL:[NSURL URLWithString:ITUNSE_DOWNLOAD_URL]];
//            }
//        }];
//    }
//}

@end
