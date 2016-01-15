//
//  HWCommitHomeServiceCell.h
//  Community
//
//  Created by niedi on 15/6/23.
//  Copyright (c) 2015年 caijingpeng. All rights reserved.
//

#import "HWBaseTableViewCell.h"

@protocol HWCommitHomeServiceCellDelegate <NSObject>

- (void)datePickerDateChanged:(NSDate *)date;

@end

@interface HWCommitHomeServiceCell : HWBaseTableViewCell

@property (nonatomic, weak) id<HWCommitHomeServiceCellDelegate> delegate;

- (void)setFold:(BOOL)isFold;

+ (CGFloat)getCellHeight:(BOOL)isFold;


@end
