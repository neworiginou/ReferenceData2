//
//  WYYCAccountCell.m
//  无忧云车司机
//
//  Created by luosai19910103@163.com on 15/6/19.
//  Copyright (c) 2015年 wuyouyunche. All rights reserved.
//

#import "WYYCAccountCell.h"
@interface WYYCAccountCell ()
//订单号
@property (weak, nonatomic) IBOutlet UILabel *orderNum;
//项目名称
@property (weak, nonatomic) IBOutlet UILabel *itemName;
//日期
@property (weak, nonatomic) IBOutlet UILabel *date;
//金额
@property (weak, nonatomic) IBOutlet UILabel *balance;

@end
@implementation WYYCAccountCell

- (void)awakeFromNib {
    // Initialization code
    self.backgroundColor=[UIColor lightGrayColor];
    
}

- (void)setAccount:(WYYCAccount *)account
{
    self.orderNum.text=account.orderNum;
    self.itemName.text=account.itemName;
    self.date.text=@"日期：2013-02-11 10:22";
    self.balance.text=[NSString stringWithFormat:@"%@元",account.balance];
     self.autoresizingMask=UIViewAutoresizingFlexibleWidth;
}

@end
