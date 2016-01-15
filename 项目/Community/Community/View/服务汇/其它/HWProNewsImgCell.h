//
//  HWProNewsImgCell.h
//  Community
//
//  Created by lizhongqiang on 14-9-3.
//  Copyright (c) 2014年 caijingpeng. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "HWPropertyNewsClass.h"
@interface HWProNewsImgCell : UITableViewCell


@property (nonatomic, strong) HWPropertyNewsClass *news;

+ (CGFloat) getCellHeightWithForCellDic:(HWPropertyNewsClass *)news;

@end
