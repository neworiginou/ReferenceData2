//
//  HWTreatureCell.h
//  Community
//
//  Created by caijingpeng.haowu on 14-12-8.
//  Copyright (c) 2014年 caijingpeng. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "HWRecordModel.h"

@interface HWTreatureCell : UITableViewCell

@property (nonatomic, strong) UILabel *dateLabel;
@property (nonatomic, strong) UILabel *contentLabel;
@property (nonatomic, strong) UILabel *priceLabel;
@property (nonatomic, strong) UIView *verticalLine;
@property (nonatomic, strong) UIImageView *championImgV;
@property (nonatomic, strong) UILabel *championLabel;

- (void)setTreatureInfo:(HWRecordModel *)info;
+ (float)getCellHeight:(HWRecordModel *)info;

@end
