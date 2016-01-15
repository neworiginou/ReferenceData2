//
//  HWReceiveAddressView.h
//  Community
//
//  Created by ryder on 8/3/15.
//  Copyright (c) 2015 caijingpeng. All rights reserved.
//

#import "BaseTableview.h"
#import "SWTableViewCell.h"
#import "HWReceiveAddressModel.h"
#import "HWAddressManagerCell.h"
#import "HWOrderSuccessView.h"

@interface HWReceiveAddressView : BaseTableview<SWTableViewCellDelegate, HWAddressManagerCellDelegate,HWCommodityDelegate>
@property (nonatomic,strong)NSMutableArray *data;
@property (nonatomic,copy)void(^returnAdress)(HWAddressInfo *addressModel);
@property (nonatomic,copy)void(^returnIsDelete)(NSString *addressId);

@end

