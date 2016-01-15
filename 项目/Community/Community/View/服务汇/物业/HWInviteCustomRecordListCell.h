//
//  HWInviteCustomRecordListCell.h
//  Community
//
//  Created by niedi on 15/6/13.
//  Copyright (c) 2015年 caijingpeng. All rights reserved.
//

#import "HWBaseTableViewCell.h"

@interface HWInviteCustomRecordListCell : HWBaseTableViewCell


- (void)fillDataWithDateStr:(NSString *)dateStr timesStr:(NSString *)times;


+ (CGFloat)getCellHeight;

@end
