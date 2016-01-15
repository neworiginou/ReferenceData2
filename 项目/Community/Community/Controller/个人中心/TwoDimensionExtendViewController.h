//
//  TwoDimensionExtendViewController.h
//  TEST
//
//  Created by gusheng on 14-8-28.
//  Copyright (c) 2014年 gusheng. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MTCustomActionSheet.h"
#import "UMSocial.h"
#import "HWRefreshBaseViewController.h"

@interface TwoDimensionExtendViewController :HWRefreshBaseViewController<UMSocialUIDelegate, MTCustomActionSheetDelegate>
{
     UIImageView *twoDismensionImageView;
    UIImageView *lineOneImageView;
    UIImageView *lineTwoImageView;
    UIButton *mineExtendBtn;
    UIButton *moreExtendBtn;
    UILabel *detailLabel;
    UIScrollView *myScrollView;
    UILabel *titleLable;
    NSOperationQueue *queue;
    UILabel *_rightsKeepLab;
}
@property (nonatomic,strong) NSOperationQueue *queue;
@property (nonatomic,strong) NSString *inviteUrl;
@end
