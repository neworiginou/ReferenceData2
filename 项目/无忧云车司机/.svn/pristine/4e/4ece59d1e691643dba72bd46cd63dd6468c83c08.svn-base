//
//  WYYCGrabOrderCell.m
//  无忧云车司机
//
//  Created by luosai19910103@163.com on 15/6/23.
//  Copyright (c) 2015年 wuyouyunche. All rights reserved.
//

#import "WYYCGrabOrderCell.h"

@interface WYYCGrabOrderCell()
//客户名
@property (weak, nonatomic) IBOutlet UILabel *customerName;
//出发地
@property (weak, nonatomic) IBOutlet UILabel *startPlace;
//出发时间
@property (weak, nonatomic) IBOutlet UILabel *startTime;
//预估费用
@property (weak, nonatomic) IBOutlet UILabel *estimatedCost;
//接单
- (IBAction)acceptOrder:(id)sender;
//客户详情
- (IBAction)clicktoCustomerDetailMessage:(id)sender;

@end
@implementation WYYCGrabOrderCell

- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (void)setOrder:(WYYCOrder *)order
{
    self.customerName.text = order.customerName;
    self.startTime.text = order.startTime;
    self.startPlace.text = order.startPlace;
    self.estimatedCost.text = order.estimatedCost.stringValue;
    _order=order;
}
- (IBAction)acceptOrder:(id)sender {
}


- (IBAction)clicktoCustomerDetailMessage:(id)sender {
    if ([self.delegate respondsToSelector:@selector(clickToCustomerDetail:)]) {
        [self.delegate clickToCustomerDetail:self.order.customerId];
    }
}
@end
