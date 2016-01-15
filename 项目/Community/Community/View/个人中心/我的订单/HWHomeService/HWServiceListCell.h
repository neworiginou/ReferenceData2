//
//  HWServiceListCell.h
//  Community
//
//  Created by hw500027 on 15/6/15.
//  Copyright (c) 2015年 caijingpeng. All rights reserved.
//

#import "HWBaseTableViewCell.h"
#import "HWServiceListModel.h"

@protocol HWServiceListCellDelegate <NSObject>

- (void)evaluateBtnClick:(NSString *)currentOrderId;
- (void)toPayBtnClick:(HWServiceListModel *)model;

@end


@interface HWServiceListCell : HWBaseTableViewCell

@property (nonatomic, weak) id<HWServiceListCellDelegate> delegate;

- (void)fillDataWithModel:(HWServiceListModel *)model;
+ (NSString *)reuseID;
+ (CGFloat)cellHeight;
@end
