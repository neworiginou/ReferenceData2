//
//  HWLocationTableViewCell.h
//  Community
//
//  Created by gusheng on 14-9-13.
//  Copyright (c) 2014年 caijingpeng. All rights reserved.
//

#import <UIKit/UIKit.h>

@class HWLocationTableViewCell;

@interface HWLocationTableViewCell : UITableViewCell

@property (nonatomic, strong) UILabel *titleLab;
@property (nonatomic, strong) UILabel *subTitleLab;
@property (nonatomic, strong) UILabel *distanceLab;
@property (nonatomic, strong) UIImageView *locationImageView;
@property (nonatomic, strong) UIButton *selectBtn;


@end
