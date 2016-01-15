//
//  HWOrderCell.h
//  Community
//
//  Created by lizhongqiang on 14-9-7.
//  Copyright (c) 2014年 caijingpeng. All rights reserved.
//  预约物业上门的cell

#import <UIKit/UIKit.h>

@interface HWOrderCell : UITableViewCell
{
    UILabel *labLeft;
    UILabel *labRight;
}
//- (void)setOrderCell:(NSDictionary *)dic;
@property (nonatomic, strong)NSDictionary *orderCellDic;
+ (CGFloat)getOrderCellHeight:(NSDictionary *)dic;

@end
