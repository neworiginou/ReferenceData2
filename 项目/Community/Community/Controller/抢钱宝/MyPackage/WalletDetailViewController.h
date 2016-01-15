//
//  WalletDetailViewController.h
//  HaoWu_4.0
//
//  Created by zhangxun on 14-5-24.
//  Copyright (c) 2014年 caijingpeng. All rights reserved.
//

#import "HWBaseViewController.h"

@interface WalletDetailViewController : HWBaseViewController<UITableViewDataSource,UITableViewDelegate>
{
    NSString *_recordId;
}

- (id)initWithDetailID:(NSString *)theID;

@end
