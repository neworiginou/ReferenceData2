//
//  HWCommondityDetailFirestCell.h
//  Community
//
//  Created by niedi on 15/8/7.
//  Copyright (c) 2015年 caijingpeng. All rights reserved.
//

#import "HWBaseTableViewCell.h"
#import "HWCommondityDetailModel.h"

@protocol HWCommondityDetailFirestCellDelegate  <NSObject>

- (void)timerEndAction;

@end

@interface HWCommondityDetailFirestCell : HWBaseTableViewCell

@property (nonatomic, weak) id<HWCommondityDetailFirestCellDelegate> delegate;

- (void)fillDataWithModel:(HWCommondityDetailModel *)model;

@end
