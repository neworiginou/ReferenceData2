//
//  HWGameSpreadRecordCell.h
//  Community
//
//  Created by niedi on 15/1/15.
//  Copyright (c) 2015年 caijingpeng. All rights reserved.
//

#import "HWBaseTableViewCell.h"
#import "HWGameSpreadRecordModel.h"

@interface HWGameSpreadRecordCell : HWBaseTableViewCell

@property (nonatomic, strong) UIImageView * headImage;  //头视图
@property (nonatomic, strong) UILabel *firTitleLab;     //标题
@property (nonatomic, strong) UILabel *secTitleLab;     //副标题
@property (nonatomic, strong) UILabel *thdTitleLab;     //子标题
@property (nonatomic, strong) UILabel *topLineLab;      //上边界线
@property (nonatomic, strong) UILabel *buttomLineLab;   //下边界线



- (void)setGaemSpreadRecordInfo:(HWGameSpreadRecordModel *)model;
+ (float)getCellHeight:(HWGameSpreadRecordModel *)model;

@end
