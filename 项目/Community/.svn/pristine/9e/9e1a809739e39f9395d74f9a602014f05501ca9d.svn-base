//
//  HWCommitHomeServiceCell1.h
//  Community
//
//  Created by niedi on 15/6/23.
//  Copyright (c) 2015年 caijingpeng. All rights reserved.
//

#import "HWBaseTableViewCell.h"

@protocol HWCommitHomeServiceCell1Delegate <NSObject>

- (void)pickerDateChanged:(NSInteger)selectedRow;

@end


@interface HWCommitHomeServiceCell1 : HWBaseTableViewCell

@property (nonatomic, weak) id<HWCommitHomeServiceCell1Delegate> delegate;

- (void)setFold:(BOOL)isFold;

+ (CGFloat)getCellHeight:(BOOL)isFold;


@end
