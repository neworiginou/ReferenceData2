//
//  HWGeneralizeCell.h
//  Community
//
//  Created by zhangxun on 14-9-18.
//  Copyright (c) 2014年 caijingpeng. All rights reserved.
//
//活动cell
#import "HWAnimateBaseCell.h"
#import "HWChannelItemClass.h"

@interface HWGeneralizeCell : HWAnimateBaseCell

@property (nonatomic,strong)UIImageView *theImageView;

- (void)rebuildWithInfo:(HWChannelItemClass *)neighbourClass indexPath:(NSIndexPath *)index;

@end
