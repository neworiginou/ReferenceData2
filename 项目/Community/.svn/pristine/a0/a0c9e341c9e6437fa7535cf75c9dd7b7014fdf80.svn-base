//
//  AddressTableView.h
//  Community
//
//  Created by hw500028 on 14/12/8.
//  Copyright (c) 2014年 caijingpeng. All rights reserved.
//

#import "BaseTableview.h"
#import "SWTableViewCell.h"
#import "AddressModel.h"
#import "HWAddressManagerCell.h"

@interface AddressTableView : BaseTableview<SWTableViewCellDelegate, HWAddressManagerCellDelegate>
@property (nonatomic,strong)NSMutableArray *data;
@property (nonatomic,copy)void(^returnAdress)(AddressModel *addressModel);
@property (nonatomic,copy)void(^returnIsDelete)(NSString *addressId);
@end
