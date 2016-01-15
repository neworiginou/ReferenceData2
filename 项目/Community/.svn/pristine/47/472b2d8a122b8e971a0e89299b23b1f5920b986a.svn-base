//
//  HWWuYeAddHouse1View.h
//  Community
//
//  Created by niedi on 15/6/23.
//  Copyright (c) 2015年 caijingpeng. All rights reserved.
//

#import "HWBaseRefreshView.h"
#import "HWWuYeAddHouseModel.h"

@protocol HWWuYeAddHouse1ViewDelegate <NSObject>

- (void)doneAddHouse;

@optional
- (void)didSelectAddressList:(HWWuYeAddHouseModel *)model;
@end


@interface HWWuYeAddHouse1View : HWBaseRefreshView

@property (nonatomic, weak) id<HWWuYeAddHouse1ViewDelegate> delegate;
//是否添加门牌
@property (nonatomic , assign) BOOL isAddaddress;

- (instancetype)initWithFrame:(CGRect)frame model:(HWWuYeAddHouseModel *)model;

@end
