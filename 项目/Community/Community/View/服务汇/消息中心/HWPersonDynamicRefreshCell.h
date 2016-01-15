//
//  HWPersonDynamicRefreshCell.h
//  Community
//
//  Created by hw500027 on 15/1/9.
//  Copyright (c) 2015年 caijingpeng. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "HWPersonDynamicCustomBackGroundView.h"
#import "HWPersonDynamicModel.h"
#import "HWSoundPlayButton.h"

@interface HWPersonDynamicRefreshCell : HWBaseTableViewCell

@property (nonatomic, strong) NSIndexPath *indexPath;
@property (nonatomic, strong) UIImageView *iconImgV;
@property (nonatomic, strong) UILabel *nameLabel;
@property (nonatomic, strong) UILabel *timeLabel;
@property (nonatomic, strong) UILabel *replyLabel;
@property (nonatomic, strong) HWPersonDynamicCustomBackGroundView *titleView;
@property (nonatomic, strong) UIView *line;
@property (nonatomic, strong) UIImageView *redPoint;
@property (nonatomic, strong) HWSoundPlayButton *soundPlayButton;

@property (nonatomic, strong) NSString *soundUrl;

- (void)setMineTypeInfo:(HWPersonDynamicModel *)model;
- (void)setCommentTypeInfo:(HWPersonDynamicModel *)model;
- (void)setLikeTypeInfo:(HWPersonDynamicModel *)model;
- (void)setThemeTypeInfo:(HWPersonDynamicModel *)model;

- (void)doPlay;

+ (CGFloat)getCellHeight:(NSDictionary *)info;

@end
