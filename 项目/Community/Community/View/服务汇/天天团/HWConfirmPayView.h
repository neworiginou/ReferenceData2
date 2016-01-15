//
//  HWConfirmPayView.h
//  Community
//
//  Created by hw500029 on 15/8/5.
//  Copyright (c) 2015年 caijingpeng. All rights reserved.
//

#import "HWBaseRefreshView.h"
#import "HWConfirmOrderModel.h"
#import "HWAddressInfo.h"

@protocol HWConfirmPayViewDelegate <NSObject>

- (void)pushAddressListView;
- (void)startTimer;
- (void)pushToPaySuccessVC:(NSString *)orderId;

@end

@interface HWConfirmPayView : HWBaseRefreshView<UITextViewDelegate>

@property (nonatomic,strong)NSArray *titleArray;
@property (nonatomic,copy)NSString * orderId;
@property (nonatomic,strong)HWConfirmOrderModel *model;
@property (nonatomic,strong)HWAddressInfo *addressInfo;
@property (nonatomic,strong)UITextView *textView;

@property (nonatomic,assign)id<HWConfirmPayViewDelegate>delegate;

- (instancetype)initWithFrame:(CGRect)frame andOrderId:(NSString *)orderId;

@end
