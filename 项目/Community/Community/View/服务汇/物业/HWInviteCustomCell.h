//
//  HWInviteCustomCell.h
//  Community
//
//  Created by niedi on 15/6/12.
//  Copyright (c) 2015年 caijingpeng. All rights reserved.
//

#import "HWBaseTableViewCell.h"

@protocol HWInviteCustomCellDelegate <NSObject>

- (void)datePickerDateChanged:(NSDate *)date;

@end


@interface HWInviteCustomCell : HWBaseTableViewCell

@property (nonatomic, weak) id<HWInviteCustomCellDelegate> delegate;

- (void)setFold:(BOOL)isFold;

+ (CGFloat)getCellHeight:(BOOL)isFold;


@end
