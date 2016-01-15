//
//  HWShareDetailViewController.h
//  Community
//
//  Created by caijingpeng.haowu on 14-9-15.
//  Copyright (c) 2014年 caijingpeng. All rights reserved.
//

#import "HWBaseViewController.h"
#import "HWShareItemClass.h"
#import "HWShareDetailClass.h"
#import "MTCustomActionSheet.h"

@interface HWShareDetailViewController : HWBaseViewController <UIWebViewDelegate,MTCustomActionSheetDelegate, UIAlertViewDelegate>
{
    UIWebView *_webView;
    UIButton *_detailButton;
    UIButton *_shareButton;
    HWShareDetailClass *_shareDetail;
    NSTimer *timer;
    NSString *_beforeShareState;
}

@property (nonatomic, strong) HWShareItemClass *shareItem;
@property (nonatomic, strong) UIImage *shareImage;
@property (nonatomic, assign) int coolTime;
@property (nonatomic, strong) NSString * shareMethod;

@end
