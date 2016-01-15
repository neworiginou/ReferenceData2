//
//  HWPerpotyComplaintCell.h
//  Community
//
//  Created by niedi on 15/6/19.
//  Copyright (c) 2015年 caijingpeng. All rights reserved.
//

#import "HWBaseTableViewCell.h"
#import "HWPropertyComplainModel.h"

@protocol HWPerpotyComplaintCellDelegate <NSObject>

- (void)evaluateBtnClick:(NSString *)modelId isCanReComplain:(BOOL)isCan;

- (void)foldBtnClickIndexPath:(NSIndexPath *)indexPath;

@end


@interface HWPerpotyComplaintCell : HWBaseTableViewCell

@property (nonatomic, weak) id<HWPerpotyComplaintCellDelegate> delegate;


- (void)fillDataWithModel:(HWPropertyComplainModel *)model indexPath:(NSIndexPath *)indexPath;


+ (CGFloat)getHeight:(HWPropertyComplainModel *)model;



@end
