//
//  OrderAddressController.h
//  Community
//
//  Created by hw500028 on 14/12/8.
//  Copyright (c) 2014年 caijingpeng. All rights reserved.
//

#import "HWBaseViewController.h"
#import "AddressTableView.h"
#import "AddressModel.h"
@interface OrderAddressController : HWBaseViewController
{
    
}
@property (nonatomic,strong)AddressTableView *tableView;
@property (nonatomic,strong)AddressModel *_addressModel;
@property (nonatomic,copy)void(^returnSelectedAddress)(AddressModel *address);
@property (nonatomic,copy)void(^deletedAddressId)(NSString *addressIdStr);
@end
