//
//  HWReceiveAddressViewController.h
//  Community
//
//  Created by ryder on 8/3/15.
//  Copyright (c) 2015 caijingpeng. All rights reserved.
//

#import "HWRefreshBaseViewController.h"
#import "HWReceiveAddressModel.h"
#import "HWReceiveAddressView.h"

@interface HWReceiveAddressViewController : HWRefreshBaseViewController

@property (nonatomic,strong) HWReceiveAddressView *tableView;
@property (nonatomic, strong) HWAddressInfo       *_addressModel;
@property (nonatomic,copy)void(^returnSelectedAddress)(HWAddressInfo *address);
@property (nonatomic,copy)void(^deletedAddressId)(NSString *addressIdStr);
@property (nonatomic, assign) id<HWCommodityDelegate> commondityDelegate;
@property (nonatomic, strong) NSString *selectedAddressId;


@end
