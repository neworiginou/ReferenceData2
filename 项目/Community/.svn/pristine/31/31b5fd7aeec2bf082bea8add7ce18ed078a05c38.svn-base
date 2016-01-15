//
//  HWLocationChangeViewController.h
//  Community
//
//  Created by gusheng on 14-9-12.
//  Copyright (c) 2014年 谷胜. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "HWBaseViewController.h"
#import "HWSearchBarView.h"
#import "HWCommunityCell.h"
#import "HWRefreshBaseViewController.h"
#import "NoCommunityView.h"
#import "HWAreaClass.h"

@protocol HWLocationChangeOtherDelegate <NSObject>

- (void)getOtherAddress:(NSString *)address Name:(NSString *)name Community:(HWAreaClass *)area;

@end



@interface HWLocationChangeViewController : HWRefreshBaseViewController<UITableViewDataSource, UITableViewDelegate, UISearchBarDelegate, UISearchDisplayDelegate, HWSearchBarViewDelegate, HWCommunityCellDelegate,UIAlertViewDelegate>
{
    UITableView *mainTV;
    NoCommunityView *noCommunityView;
    UIView *noCommentView;
    UIView *noCommentGpsLocationView;
    NSInteger serarchPage;
    NSMutableArray *searchResultArry;
    BOOL isSearchLastPage;
    NSString *cityId;
    BOOL locationChangeFlag;    //NO是登陆，YES位置变更
    BOOL isChangeCityFlag;//是否切换城市
}

@property (nonatomic, strong)NSArray *communities;
@property (nonatomic, strong)NSString *cityId;
@property (nonatomic, strong)NSString *villageId;
@property (nonatomic, strong)NSMutableArray *searchResultArry;
@property (nonatomic, assign)BOOL locationChangeFlag;
@property (nonatomic, assign)BOOL isNickVCPush; // 是否从设置昵称页面push进来
@property (nonatomic, assign)BOOL isOtherCommunity;//是否选择其他小区
@property (nonatomic, assign) BOOL isCheckIPBindVillageId;  //是否检查ip然后绑定小区
@property (nonatomic, assign) BOOL isCustomLogin;
@property (nonatomic, assign)id<HWLocationChangeOtherDelegate>delegate;
@end