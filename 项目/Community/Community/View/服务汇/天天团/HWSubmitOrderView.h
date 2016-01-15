//
//  HWSubmitOrderView.h
//  Community
//
//  Created by ryder on 7/29/15.
//  Copyright (c) 2015 caijingpeng. All rights reserved.
//

#import "HWBaseRefreshView.h"
#import "HWOrderSuccessView.h"
#import "HWCommondityDetailModel.h"
#import "HWTianTianTuanDetailVC.h"

@interface HWSubmitOrderView : UIView<UITableViewDataSource,UITableViewDelegate,UITextFieldDelegate, UIAlertViewDelegate>

@property (nonatomic, assign) id<HWCommodityDelegate> delegate;
@property (nonatomic, strong) HWCommondityDetailModel *model;
@property (nonatomic, strong) UIViewController *superVC;

- (instancetype)initWithModel:(HWCommondityDetailModel *)model;


@end
