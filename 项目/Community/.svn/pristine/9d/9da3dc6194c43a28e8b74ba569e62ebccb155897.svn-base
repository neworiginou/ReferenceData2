//
//  HWTianTianTuanListCell.h
//  Community
//
//  Created by niedi on 15/7/31.
//  Copyright (c) 2015年 caijingpeng. All rights reserved.
//

#import "HWBaseTableViewCell.h"
#import "HWTianTianTuanListModel.h"

@protocol HWTianTianTuanListCellDelegate <NSObject>

- (void)cellPayBtnClick:(HWTianTianTuanListModel *)model;

@end

@interface HWTianTianTuanListCell : HWBaseTableViewCell

@property (nonatomic, weak) id<HWTianTianTuanListCellDelegate> delegate;

- (void)fillDataWithModel:(HWTianTianTuanListModel *)model;


- (CGFloat)cellHeight;


@end
