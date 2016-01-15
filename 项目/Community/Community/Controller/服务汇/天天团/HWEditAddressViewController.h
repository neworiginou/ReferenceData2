//
//  HWEditAddressViewController.h
//  Community
//
//  Created by ryder on 8/3/15.
//  Copyright (c) 2015 caijingpeng. All rights reserved.
//

#import "HWBaseViewController.h"
#import "CreatAddressController.h"
#import "HWAddressInfo.h"
#import "BasePickView.h"

@interface HWEditAddressViewController : HWBaseViewController<UITextFieldDelegate,AddressDelegate,UITextViewDelegate,UITableViewDataSource,UITableViewDelegate>
@property (nonatomic,strong) HWAddressInfo *addressModel;
@end
