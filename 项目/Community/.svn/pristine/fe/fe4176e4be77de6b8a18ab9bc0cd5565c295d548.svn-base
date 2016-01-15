//
//  HWPublicRepairCell.h
//  Community
//
//  Created by niedi on 15/6/15.
//  Copyright (c) 2015年 caijingpeng. All rights reserved.
//

#import "HWBaseTableViewCell.h"
#import "HWPublicRepairModel.h"
#import "HWPropertyComplainModel.h"

@protocol HWPublicRepairCellDelegate <NSObject>

@optional
- (void)evaluateBtnClick:(NSString *)modelId;

- (void)unSatisfyReEvaluateClick:(NSString *)modelId;

@end


@interface HWPublicRepairCell : HWBaseTableViewCell

@property (nonatomic, strong) UIView *superV;
@property (nonatomic, weak) id<HWPublicRepairCellDelegate> delegate;


- (void)fillDataWithModel:(HWPublicRepairModel *)model;

+ (CGFloat)getHeight:(HWPublicRepairModel *)model;


- (void)fillDataWithModelForComplain:(HWPropertyComplainModel *)model;

+ (CGFloat)getHeightForComplain:(HWPropertyComplainModel *)model;

@end
