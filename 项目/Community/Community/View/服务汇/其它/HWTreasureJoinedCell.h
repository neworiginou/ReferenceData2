//
//  HWTreasureJoinedCell.h
//  Community
//
//  Created by caijingpeng.haowu on 14-12-9.
//  Copyright (c) 2014年 caijingpeng. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "HWJoinedActivityModel.h"

@interface HWTreasureJoinedCell : UITableViewCell

@property (nonatomic, strong) UIImageView *goodsImgV;
@property (nonatomic, strong) UILabel *titleLab;
@property (nonatomic, strong) UILabel *contentLab;
@property (nonatomic, strong) UILabel *dateLab;
@property (nonatomic, strong) UILabel *statusLab;

- (void)setJoinedInfo:(HWJoinedActivityModel *)info;

+ (float)getCellHeight:(HWJoinedActivityModel *)info;

@end
