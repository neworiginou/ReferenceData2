//
//  HWTreatureHistoryCell.h
//  Community
//
//  Created by caijingpeng.haowu on 14-12-9.
//  Copyright (c) 2014年 caijingpeng. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "HWActivityHistoryModel.h"
#import "HWContentImageView.h"

@interface HWTreatureHistoryCell : UITableViewCell

@property (nonatomic, strong) UIImageView *goodsImgV;
@property (nonatomic, strong) UILabel *titleLab;
@property (nonatomic, strong) UILabel *contentLab;
@property (nonatomic, strong) HWContentImageView *showImgV;
@property (nonatomic, strong) UILabel *dateLab;
@property (nonatomic, strong) UIImageView *headImgV;
@property (nonatomic, strong) UILabel *telephoneLab;
@property (nonatomic, strong) UILabel *showDateLab;
@property (nonatomic, strong) UIView *line;
@property (nonatomic, strong) UIView *showView;

- (void)setHistoryInfo:(HWActivityHistoryModel *)info;

+ (float)getCellHeight:(HWActivityHistoryModel *)info;

@end
