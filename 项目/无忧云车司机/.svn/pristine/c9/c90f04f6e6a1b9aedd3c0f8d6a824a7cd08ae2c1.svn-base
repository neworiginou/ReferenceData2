//
//  WYYCFinishedOrderCell.m
//  无忧云车司机
//
//  Created by luosai19910103@163.com on 15/6/23.
//  Copyright (c) 2015年 wuyouyunche. All rights reserved.
//

#import "WYYCFinishedOrderCell.h"
@interface WYYCFinishedOrderCell()
//客户名
@property (weak, nonatomic) IBOutlet UILabel *customerName;
//出发地
@property (weak, nonatomic) IBOutlet UILabel *startPlace;
//目的地
@property (weak, nonatomic) IBOutlet UILabel *destination;
//出发时间
@property (weak, nonatomic) IBOutlet UILabel *startTime;
//订单状态
@property (weak, nonatomic) IBOutlet UILabel *orderStatus;
//支付费用
@property (weak, nonatomic) IBOutlet UILabel *cost;
//支付方式
@property (weak, nonatomic) IBOutlet UIButton *payWay;

@end
@implementation WYYCFinishedOrderCell

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
    self.destination.text=order.destination;
    self.orderStatus.text=[NSString stringWithFormat:@"%d",order.orderStatusCode]
    ;
    self.cost.text=order.cost.stringValue;
    self.cost.adjustsFontSizeToFitWidth=YES;
    if (order.payWay) {
        self.payWay.titleLabel.text=@"现金支付";
    }else{
        self.payWay.titleLabel.text=@"线上支付";
    }
    

}
@end
