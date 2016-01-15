//
//  HWMyWuYeCell.h
//  Community
//
//  Created by niedi on 15/6/4.
//  Copyright (c) 2015年 caijingpeng. All rights reserved.
//

#import "HWBaseTableViewCell.h"
#import "HWMyWuYeModel.h"

@interface HWMyWuYeCell : HWBaseTableViewCell


- (void)fillData:(HWMyWuYeModel *)model row:(NSInteger)row;

+ (CGFloat)getHight:(HWMyWuYeModel *)model;


@end
