//
//  HWOrderSuccessView.h
//  Community
//
//  Created by ryder on 7/28/15.
//  Copyright (c) 2015 caijingpeng. All rights reserved.
//

#import "HWBaseRefreshView.h"
#import "HWCommondityModel.h"
#import "HWAddressInfo.h"

@protocol HWCommodityDelegate <NSObject>

@optional
- (void)didShowCommodityList;
- (void)didShowOrderList;
- (void)didConfirmPayment;
- (void)didSubmitOrder;
- (void)didSubmitOrder:(NSInteger)count price:(CGFloat)total orderId:(NSString *)orderId;
- (void)didShowCommondityDetail;
- (void)didShowCommondityDetailWithModel:(HWCommondityModel *)model;
- (void)didPurchase;
- (void)refreshCommondityList;
- (void)manageOrderAddress;
- (void)updateReceiverInfo:(HWAddressInfo *)model;

@end

@interface HWOrderSuccessView : HWBaseRefreshView

@property (nonatomic, strong) UIImageView *titleView;
@property (nonatomic, strong) UILabel *titleLabel;
@property (nonatomic, strong) UIButton *strollButton;
@property (nonatomic, strong) UIButton *orderButton;
@property (nonatomic, assign) id<HWCommodityDelegate> delegate;
@end
