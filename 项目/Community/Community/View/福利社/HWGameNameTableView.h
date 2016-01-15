//
//  HWGameNameTableView.h
//  Community
//
//  Created by WeiYuanlin on 15/1/16.
//  Copyright (c) 2015年 caijingpeng. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "HWBaseRefreshView.h"
#import "HWGameNameTableViewCell.h"
#import "HWGameAllNameModel.h"
#import "HWShareView.h"

@protocol HWGameNameTableViewDelegate <NSObject>

- (void)didSelectedCell:(HWGameAllNameModel *)model;

@end
@interface HWGameNameTableView : HWBaseRefreshView

@property (nonatomic, strong) UIViewController *presentController;
@property (nonatomic, assign) id <HWGameNameTableViewDelegate> delegate;
@property (nonatomic, strong) UIImageView *userImg;
@property (nonatomic, strong) HWShareView *shareView;

@end
