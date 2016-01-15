//
//  NumberTableViewCell.h
//  AlertView
//
//  Created by lizhongqiang on 15/7/8.
//  Copyright (c) 2015年 lqq. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface NumberTableViewCell : UITableViewCell

@property (nonatomic, strong)UILabel *numberLabel;

@property (nonatomic, strong)UILabel *moneyLabel;

@property (nonatomic, strong)UILabel *timeLabel;

@property (nonatomic, assign)CGFloat spaceX;

@end
