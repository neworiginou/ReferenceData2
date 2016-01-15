//
//  HWActivityCell.h
//  HaoWu_4.0
//
//  Created by caijingpeng.haowu on 14-5-20.
//  Copyright (c) 2014年 caijingpeng. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "HWShareItemClass.h"
@class HWActivityCell;

@protocol HWActivityCellDelegate <NSObject>

- (void)didClickShareButtonWithCell:(HWActivityCell *)cell;
- (void)remaindTime:(NSInteger)time;

@end

@interface HWActivityCell : UITableViewCell

@property (nonatomic, strong)UIImageView *headImageView;
@property (nonatomic, strong)UILabel *titleLabel;
@property (nonatomic, strong)UIButton *shareButton;
@property (nonatomic, strong)UILabel *subTitleLabel;
@property (nonatomic, strong)UILabel *rewardlMoneyLab;
@property (nonatomic, strong)NSString *activityId;
@property (nonatomic, assign)NSInteger coolTime;

@property (nonatomic, strong)HWShareItemClass *myShareItem;

@property (nonatomic, assign)id<HWActivityCellDelegate> delegate;
@property (nonatomic, copy) void (^pullList)(BOOL finish);

- (void)setShareItem:(HWShareItemClass *)shareItem;
- (void)setCoolTime:(NSInteger)time;
//- (void)addaptWithDictionary:(NSDictionary *)dictionary setCoolTime:(CGFloat)ct;


@end
