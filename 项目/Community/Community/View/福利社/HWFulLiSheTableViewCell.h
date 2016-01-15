//
//  HWFulLiSheTableViewCell.h
//  KaoLa
//
//  Created by wuxiaohong on 15/1/12.
//  Copyright (c) 2015年 hw. All rights reserved.
//
//

#import <UIKit/UIKit.h>

@interface HWFulLiSheTableViewCell : UITableViewCell

@property (nonatomic, strong) UIImageView * headImageView;
@property (nonatomic, strong) UILabel * nameLable;
@property (nonatomic, strong) UILabel * detailLable;
@property (nonatomic, strong) UIImageView *rightJumpView;

+ (CGFloat)getCellHeight;

@end
