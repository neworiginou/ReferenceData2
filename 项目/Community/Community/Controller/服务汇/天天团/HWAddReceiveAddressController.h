//
//  HWAddReceiveAddressController.h
//  Community
//
//  Created by ryder on 8/3/15.
//  Copyright (c) 2015 caijingpeng. All rights reserved.
//

#import "HWBaseViewController.h"
#import "BasePickView.h"
#import "HWAddressInfo.h"

@interface HWAddReceiveAddressController : HWBaseViewController<UITableViewDataSource,UITableViewDelegate,UITextFieldDelegate,UITextViewDelegate,AddressDelegate>

@property (nonatomic,strong) UITableView *tableView;
@property (nonatomic,strong) UITextView *textView;
//@property (nonatomic,strong)void(^returnAddress)(HWAddressModel *newAddress);
@property (nonatomic,strong) HWAddressInfo *addressModel;

@end

