//
//  HWMyCardCell.h
//  HaoWu_4.0
//
//  Created by caijingpeng.haowu on 14-5-24.
//  Copyright (c) 2014年 caijingpeng. All rights reserved.
//

#import <UIKit/UIKit.h>

@class HWMyCardCell;
@protocol HWMyCardCellDelegate <NSObject>

- (void)didClickSetDefaultWithCell:(HWMyCardCell *)cell;

@end

@interface HWMyCardCell : UITableViewCell

@property (nonatomic, strong) NSString *carNoStr;
@property (nonatomic, strong) UIImageView *headImgV;
@property (nonatomic, strong) UILabel *titleLab;
@property (nonatomic, strong) UILabel *subTitleLab;
//@property (nonatomic, strong)UIButton *settingButton;
@property (nonatomic, strong) UILabel *defaultLab;
@property (nonatomic, strong)id<HWMyCardCellDelegate> delegate;

@end
