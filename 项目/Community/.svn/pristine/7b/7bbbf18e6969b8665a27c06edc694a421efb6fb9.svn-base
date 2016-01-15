//
//  HWServeTableViewCell.h
//  Community
//
//  Created by lizhongqiang on 14-9-6.
//  Copyright (c) 2014年 caijingpeng. All rights reserved.
//  服务汇首页cell

#import <UIKit/UIKit.h>
#import "HWShopItemClass.h"

@protocol HWServerCellDelegate <NSObject>

- (void)callPhone:(int)index;           //拨打电话事件
- (void)selectCell:(int)index;          //选中表格

@end


@interface HWServeTableViewCell : UITableViewCell
{
    UIView *leftBgView;     //左背景图
}

@property (nonatomic, assign)id<HWServerCellDelegate>delegate;

@property (nonatomic, strong)UILabel *labName;              //店铺名称
@property (nonatomic, strong)UILabel *labCallNum;           //拨打次数
@property (nonatomic, strong)UIImageView *imgShop;          //店铺图片
@property (nonatomic) BOOL isAuthentication;                //是否认证
@property (nonatomic, strong) UILabel *labPhone;            //店铺电话

- (void)setCellDataWithShopItem:(HWShopItemClass *)shopItem;
- (void)moveDownAnimate;
- (void)loadingAnimate;

@end
