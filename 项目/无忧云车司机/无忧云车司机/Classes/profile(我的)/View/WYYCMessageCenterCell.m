//
//  WYYCMessageCenterCell.m
//  无忧云车司机
//
//  Created by luosai19910103@163.com on 15/6/23.
//  Copyright (c) 2015年 wuyouyunche. All rights reserved.
//

#import "WYYCMessageCenterCell.h"

@interface WYYCMessageCenterCell ()
//消息标题
@property (weak, nonatomic) IBOutlet UILabel *MessageTitle;
//出发地
@property (weak, nonatomic) IBOutlet UILabel *startPlace;
//目的地
@property (weak, nonatomic) IBOutlet UILabel *destination;
//出发时间
@property (weak, nonatomic) IBOutlet UILabel *startTime;
//乘客姓名
@property (weak, nonatomic) IBOutlet UILabel *passengerName;
//订单状态
@property (weak, nonatomic) IBOutlet UILabel *orderstatusCode;
//开始和结束工作View
@property (weak, nonatomic) IBOutlet UIView *startAndEndWorkingView;

@property (weak, nonatomic) IBOutlet UIView *orderMessageView;

//开始或结束工作的时间
@property (weak, nonatomic) IBOutlet UILabel *startOrEndWorkingTime;
//工作状态：上线 或下o
@property (weak, nonatomic) IBOutlet UILabel *workingStatus;

@end

@implementation WYYCMessageCenterCell

- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
    //self.backgroundColor=[UIColor lightGrayColor];
}

- (void)setMessage:(WYYCMessage *)message
{
    self.MessageTitle.text = message.title;
    self.startPlace.text = message.startPlace;
    self.destination.text = message.destination;
    self.startTime.text = message.startTime;
    self.passengerName.text = message.passengerName;
    self.orderstatusCode.text = message.orderStatusCode;
    
    self.startOrEndWorkingTime.text = message.startOrEndWorkingTime;
    self.workingStatus.text = message.workingStatus;
    
    NSLog(@"%@",message.title);
    if (message.title) {
         self.startAndEndWorkingView.hidden = YES;
         self.orderMessageView.hidden = NO;
    }else{
        self.startAndEndWorkingView.hidden = NO;
        self.orderMessageView.hidden = YES;
    }
   

    
}

@end
