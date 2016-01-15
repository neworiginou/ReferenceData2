//
//  HWGameSpreadTableView.h
//  KaoLa
//
//  Created by WeiYuanlin on 15/1/13.
//  Copyright (c) 2015年 WeiYuanlin. All rights reserved.
//

#import "HWBaseRefreshView.h"
#import "HWGameSpreadTableViewCell.h"
#import "HWGameSpreadModel.h"
#import "HWGameSpreadPicModel.h"
#import "WXImageView.h"

@protocol HWGameSpreadTableViewDelegate <NSObject>

@optional
- (void)spreadBtnClickDelegate:(HWGameSpreadModel *)model;              //推广按钮代理
- (void)cellClickDelegate:(HWGameSpreadModel *)model;                   //cell点击代理
- (void)tableHeaderImageClickDelegate:(HWGameSpreadPicModel *)model;    //点击图片
- (void)showGuideViewWhenHaveList;


@end


@interface HWGameSpreadTableView : HWBaseRefreshView <HWGameSpreadTableViewCellDelegate>


@property (nonatomic, strong) NSMutableArray *picModelListArr;
@property (nonatomic, weak) id<HWGameSpreadTableViewDelegate> delegate;

@end
