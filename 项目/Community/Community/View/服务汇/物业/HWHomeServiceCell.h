//
//  HWHomeServiceCell.h
//  Community
//
//  Created by niedi on 15/6/23.
//  Copyright (c) 2015年 caijingpeng. All rights reserved.
//

#import "HWBaseTableViewCell.h"

@interface HWHomeServiceCell : HWBaseTableViewCell

- (void)fillDataWithLeftStr:(NSString *)leftStr rightStr:(NSString *)rightStr;
- (void)fillDataWithServiceListLeftStr:(NSString *)leftStr rightStr:(NSString *)rightStr;


+ (CGFloat)getCellHeight:(NSString *)leftStr;


- (void)setLeftGap:(BOOL)isGap;

- (void)setLeftGap:(BOOL)isGapL rigthGap:(BOOL)isGapR;

- (void)hideButtomLine:(BOOL)isHide;

@end
