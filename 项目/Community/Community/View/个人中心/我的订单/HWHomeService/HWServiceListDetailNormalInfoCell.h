//
//  HWServiceListDetailNormalInfoCell.h
//  Community
//
//  Created by hw500027 on 15/6/18.
//  Copyright (c) 2015年 caijingpeng. All rights reserved.
//

#import "HWBaseTableViewCell.h"
#import "HWServiceListDetailModel.h"

@interface HWServiceListDetailNormalInfoCell : HWBaseTableViewCell
+ (NSString *)reuseID;
- (void)fillDataWithModel:(HWServiceListDetailModel *)model;
@end
