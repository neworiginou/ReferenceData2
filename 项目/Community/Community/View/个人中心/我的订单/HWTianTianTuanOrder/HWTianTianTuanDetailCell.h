//
//  HWTianTianTuanDetailCell.h
//  Community
//
//  Created by niedi on 15/8/8.
//  Copyright (c) 2015年 caijingpeng. All rights reserved.
//

#import "HWBaseTableViewCell.h"

@interface HWTianTianTuanDetailCell : HWBaseTableViewCell

- (void)fillDataWithLeftStr:(NSString *)leftStr;


+ (CGFloat)getCellHeight:(NSString *)leftStr;


- (void)setLeftGap:(BOOL)isGap;

- (void)setLeftGap:(BOOL)isGapL rigthGap:(BOOL)isGapR;

- (void)hideButtomLine:(BOOL)isHide;

@end
