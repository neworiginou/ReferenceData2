//
//  HWInviteCustomRecordCell.h
//  Community
//
//  Created by niedi on 15/6/13.
//  Copyright (c) 2015年 caijingpeng. All rights reserved.
//

#import "HWBaseTableViewCell.h"
#import "HWInviteCustomRecordModel.h"

@interface HWInviteCustomRecordCell : HWBaseTableViewCell


- (void)fillDataWithModel:(HWInviteCustomRecordModel *)model;

- (void)fillDataWithModel:(HWInviteCustomRecordModel *)model type:(BOOL)isLongCustom;

+ (CGFloat)getCellHeight:(HWInviteCustomRecordModel *)model;


@end
