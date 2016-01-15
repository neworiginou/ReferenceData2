//
//  HWPriviledgeTableViewCell.h
//  TestOne
//
//  Created by gusheng on 14-12-8.
//  Copyright (c) 2014年 gusheng. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "HWPriviledgeModel.h"

@protocol HWPriviledgeTableViewCellDelegate <NSObject>

- (void)didClickGetPriviledge:(HWPriviledgeModel *)priviledge;

@end

@interface HWPriviledgeTableViewCell : UITableViewCell

@property (nonatomic, strong) UILabel *hourLabel;
@property (nonatomic, strong) UILabel *minitueLabel;
@property (nonatomic, strong) UILabel *secondLabel;
@property (nonatomic, strong) UIView *activityTimeIV;
@property (nonatomic, strong) UIView *getPriviledgeIV;
@property (nonatomic, strong) UIButton *getPrivilegedBtn;
@property (nonatomic, strong) UIImageView *priviledgeIV;
@property (nonatomic, strong) HWPriviledgeModel *everyPriviledgeModel;
@property (nonatomic, assign) id<HWPriviledgeTableViewCellDelegate> delegate;
@property (nonatomic, strong) UIView *line;


- (void)setPriviledgeValue:(HWPriviledgeModel *)model;
- (void)setCoolTime:(int)time;
+ (CGFloat)getCellHeight;

@end
