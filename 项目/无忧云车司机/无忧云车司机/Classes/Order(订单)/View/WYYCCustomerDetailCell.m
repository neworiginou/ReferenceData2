//
//  WYYCCustomerDetailCell.m
//  无忧云车司机
//
//  Created by luosai19910103@163.com on 15/6/24.
//  Copyright (c) 2015年 wuyouyunche. All rights reserved.
//

#import "WYYCCustomerDetailCell.h"
#import "HCSStarRatingView.h"
@interface WYYCCustomerDetailCell()
@property (weak, nonatomic) IBOutlet UILabel *orderNum;

@property (weak, nonatomic) IBOutlet HCSStarRatingView *starRatingView;

@property (weak, nonatomic) IBOutlet UILabel *commentContent;
@property (weak, nonatomic) IBOutlet UILabel *commentTime;

@end
@implementation WYYCCustomerDetailCell

- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (void)setComment:(WYYCComment *)comment
{
    self.orderNum.text=comment.orderNum;
    self.commentContent.text=comment.commentContent;
    
    self.starRatingView.value=comment.commentScore.floatValue;
    self.commentTime.text=comment.commentDate;
    
    
}
@end
