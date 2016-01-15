//
//  HWGoodsDetailViewController.h
//  Community
//
//  Created by lizhongqiang on 15/4/13.
//  Copyright (c) 2015年 caijingpeng. All rights reserved.
//  无底线商品详情页

#import "HWBaseViewController.h"
#import "HWJoinedActivityModel.h"

@protocol HWGoodsDetailViewControllerDelegate <NSObject>

- (void)goodsListRefreshView;

@end

@interface HWGoodsDetailViewController : UIViewController
@property (nonatomic, strong) NSString *productId;
@property (nonatomic, strong)HWJoinedActivityModel *joinedItem;
@property (nonatomic, weak) id<HWGoodsDetailViewControllerDelegate> delegate;

@end
