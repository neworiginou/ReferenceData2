//
//  HWAddressManagerCell.h
//  Community
//
//  Created by caijingpeng.haowu on 14-12-19.
//  Copyright (c) 2014年 caijingpeng. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "AddressModel.h"
@class HWAddressManagerCell;

@protocol HWAddressManagerCellDelegate <NSObject>

- (void)didSelectedEdit:(HWAddressManagerCell *)info;
- (void)didSelectedDelete:(HWAddressManagerCell *)info;

@end

@interface HWAddressManagerCell : UITableViewCell

@property (nonatomic, strong) UILabel *nameLabel;
@property (nonatomic, strong) UILabel *telephoneLabel;
@property (nonatomic, strong) UILabel *addressLabel;
@property (nonatomic, strong) UIImageView *selectImgV;
@property (nonatomic, strong) UIButton *editButton;
@property (nonatomic, strong) UIButton *deleteButton;

@property (nonatomic, assign) id<HWAddressManagerCellDelegate> delegate;

- (void)setAddressInfo:(AddressModel *)info;

+ (float)getCellHeight:(AddressModel *)info;

@end
