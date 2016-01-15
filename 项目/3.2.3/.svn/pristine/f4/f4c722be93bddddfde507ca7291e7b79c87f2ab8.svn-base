//
//  HWFeedBackViewController.h
//  Community
//
//  Created by zhangxun on 14-9-3.
//  Copyright (c) 2014年 caijingpeng. All rights reserved.
//
//  意见反馈
//

#import <UIKit/UIKit.h>
#import "UMFeedback.h"
#import "UMEGORefreshTableHeaderView.h"
//#import "HWSuggestTypeButton.h"

@interface HWFeedBackViewController : UIViewController<UMFeedbackDataDelegate,UITextFieldDelegate>
{
    UMFeedback *feedbackClient;
    BOOL _reloading;
    UMEGORefreshTableHeaderView *_refreshHeaderView;
    CGFloat _tableViewTopMargin;
    BOOL _shouldScrollToBottom;
    
//    HWSuggestTypeButton *_suggestButton;
//    HWSuggestTypeButton *_bugButton;
//    NSString *_suggestType;
}

@property(nonatomic, retain) IBOutlet UITableView *mTableView;
@property(nonatomic, retain) IBOutlet UIToolbar *mToolBar;
@property(nonatomic, retain) IBOutlet UIView *mContactView;

@property(nonatomic, retain) UITextField *mTextField;
@property(nonatomic, retain) UIBarButtonItem *mSendItem;
@property(nonatomic, retain) NSArray *mFeedbackData;
@property(nonatomic, copy) NSString *appkey;

@end
