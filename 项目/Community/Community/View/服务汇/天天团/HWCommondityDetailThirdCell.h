//
//  HWCommondityDetailThirdCell.h
//  Community
//
//  Created by niedi on 15/8/7.
//  Copyright (c) 2015年 caijingpeng. All rights reserved.
//

#import "HWBaseTableViewCell.h"
#import "HWCommondityDetailModel.h"

@protocol HWCommondityDetailThirdCellDelegate <NSObject>

- (void)pushToBrandLink:(NSString *)linkUrl;

@end


@interface HWCommondityDetailThirdCell : HWBaseTableViewCell

@property (nonatomic, weak) id<HWCommondityDetailThirdCellDelegate> delegate;


- (void)fillDataWithModel:(HWCommondityDetailModel *)model;

+ (CGFloat)getCellHeigth:(HWCommondityDetailModel *)model;

@end
