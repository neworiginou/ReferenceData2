//
//  WYYCGrabOrderCell.h
//  无忧云车司机
//
//  Created by luosai19910103@163.com on 15/6/23.
//  Copyright (c) 2015年 wuyouyunche. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "WYYCOrder.h"

@protocol WYYCGrabOrderCellDelegage <NSObject>

- (void)clickToCustomerDetail:(NSString *)customerId;

@end

@interface WYYCGrabOrderCell : UITableViewCell
@property (nonatomic ,strong)WYYCOrder *order;
@property (nonatomic ,strong) id<WYYCGrabOrderCellDelegage> delegate;
@end
