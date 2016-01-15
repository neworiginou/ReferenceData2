//
//  HWConfirmPayCell2.h
//  Community
//
//  Created by hw500029 on 15/8/5.
//  Copyright (c) 2015年 caijingpeng. All rights reserved.
//

#import "HWBaseTableViewCell.h"

@interface HWConfirmPayCell2 : HWBaseTableViewCell

@property (nonatomic,strong)UILabel *cargoNameLabel;
@property (nonatomic,strong)UILabel *priceLabel;

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier;

- (void)fillDataWithCargoName:(NSString *)name andPrice:(NSString *)price;

@end
