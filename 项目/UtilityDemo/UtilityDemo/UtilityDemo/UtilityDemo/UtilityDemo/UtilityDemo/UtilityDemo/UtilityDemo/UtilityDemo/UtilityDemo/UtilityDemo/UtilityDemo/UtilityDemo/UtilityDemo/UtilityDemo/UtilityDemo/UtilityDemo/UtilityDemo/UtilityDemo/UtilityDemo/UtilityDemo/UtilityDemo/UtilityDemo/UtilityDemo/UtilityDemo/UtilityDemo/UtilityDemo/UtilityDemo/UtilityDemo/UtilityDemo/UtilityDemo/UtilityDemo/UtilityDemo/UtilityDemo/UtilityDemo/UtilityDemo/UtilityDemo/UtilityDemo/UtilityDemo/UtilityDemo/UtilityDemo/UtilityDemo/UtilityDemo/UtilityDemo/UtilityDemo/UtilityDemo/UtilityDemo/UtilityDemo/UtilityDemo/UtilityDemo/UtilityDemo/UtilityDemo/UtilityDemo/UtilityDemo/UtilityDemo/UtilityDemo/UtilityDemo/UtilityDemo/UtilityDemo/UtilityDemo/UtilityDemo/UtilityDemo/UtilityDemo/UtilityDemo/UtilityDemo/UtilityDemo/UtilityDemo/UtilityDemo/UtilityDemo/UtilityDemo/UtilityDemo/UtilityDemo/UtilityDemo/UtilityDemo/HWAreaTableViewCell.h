//
//  HWAreaTableViewCell.h
//  UtilityDemo
//
//  Created by wuxiaohong on 15/3/31.
//  Copyright (c) 2015年 hw. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface HWAreaTableViewCell : UITableViewCell

@property(nonatomic,strong)UILabel * titleLabel;
@property(nonatomic,strong)UILabel * unitLabel;

@property (nonatomic, strong)UITextField *textfield;

@property (nonatomic, strong)UIView *cover;

@end
