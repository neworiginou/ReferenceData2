//
//  UITableViewCell(FixUITableViewCellAutolayoutIHope).h
//  Community
//
//  Created by caijingpeng.haowu on 14-12-19.
//  Copyright (c) 2014年 caijingpeng. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UITableViewCell (FixUITableViewCellAutolayoutIHope)

+ (void)load;
- (void)_autolayout_replacementLayoutSubviews;

@end
