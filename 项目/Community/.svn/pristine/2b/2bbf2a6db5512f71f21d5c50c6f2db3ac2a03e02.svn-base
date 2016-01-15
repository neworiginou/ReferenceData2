//
//  HWShareRefreshView.h
//  Community
//
//  Created by caijingpeng.haowu on 15/1/17.
//  Copyright (c) 2015年 caijingpeng. All rights reserved.
//

#import "HWBaseRefreshView.h"
#import "HWShareItemClass.h"
#import "HWActivityCell.h"
#import "MTCustomActionSheet.h"

@protocol HWShareRefreshViewDelegate <NSObject>

- (void)toShareActivityWithState:(NSString *)shareState item:(HWShareItemClass *)shareItem image:(UIImage *)shareImage;
- (void)toSelectShareDetail:(HWShareItemClass *)shareItem coolTime:(int)coolTime shareImage:(UIImage *)image shareMethod:(NSString *)method;

@end

@interface HWShareRefreshView : HWBaseRefreshView <UIAlertViewDelegate, MTCustomActionSheetDelegate, HWActivityCellDelegate>
{
    NSTimer *timer;
    NSInteger  maxFreezeTime;
    NSInteger coolTime;
    BOOL activeTimer;
    HWActivityCell *_toShareCell;
    HWShareItemClass *_toShareItem;
    NSString *_beforeShareState;
}

@property (nonatomic, weak) UIViewController *superVC;

@property (nonatomic, assign) id<HWShareRefreshViewDelegate> delegate;

@end
