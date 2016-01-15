//
//  AddressCell.h
//  Community
//
//  Created by hw500028 on 14/12/8.
//  Copyright (c) 2014年 caijingpeng. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "AddressModel.h"
#import "SWTableViewCell.h"
@interface AddressCell : SWTableViewCell

@property (nonatomic,strong)AddressModel *addressModel;
@property (nonatomic, strong) NSIndexPath *indexPath;//cell所在的indexPath
@property (nonatomic,weak)    UITableView *tableView;//cell所在的tableView
@property (nonatomic,strong)  UIImageView *selectImage;//accessoryView
@property (nonatomic, strong) UILabel *nameLabel;
@property (nonatomic, strong) UILabel *phoneNumLabel;
@property (nonatomic, strong) UILabel *orderAddressLabel;
@property (nonatomic, strong) UIView*line;
@property (nonatomic, strong) NSString * isDefault;


+ (AddressCell *)cellWithTableView:(UITableView *)tableView;
//计算cell的高度
+ (CGFloat)getHeightWithModel:(AddressModel *)model;
@end
