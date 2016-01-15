//
//  HWReceiveAddressCell.h
//  Community
//
//  Created by ryder on 8/3/15.
//  Copyright (c) 2015 caijingpeng. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "HWAddressInfo.h"
#import "SWTableViewCell.h"

@interface HWReceiveAddressCell : SWTableViewCell

@property (nonatomic,strong)  HWAddressInfo *addressModel;
@property (nonatomic, strong) NSIndexPath *indexPath;//cell所在的indexPath
@property (nonatomic,weak)    UITableView *tableView;//cell所在的tableView
@property (nonatomic,strong)  UIImageView *selectImage;//accessoryView
@property (nonatomic, strong) UILabel *nameLabel;
@property (nonatomic, strong) UILabel *phoneNumLabel;
@property (nonatomic, strong) UILabel *orderAddressLabel;
@property (nonatomic, strong) UIView*line;
@property (nonatomic, strong) NSString * isDefault;


+ (HWReceiveAddressCell *)cellWithTableView:(UITableView *)tableView;
//计算cell的高度
+ (CGFloat)getHeightWithModel:(HWAddressInfo *)model;

@end
