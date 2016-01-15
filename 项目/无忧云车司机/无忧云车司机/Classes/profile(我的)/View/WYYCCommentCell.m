//
//  WYYCCommentCell.m
//  无忧云车司机
//
//  Created by luosai19910103@163.com on 15/6/19.
//  Copyright (c) 2015年 wuyouyunche. All rights reserved.
//

#import "WYYCCommentCell.h"
#import "HCSStarRatingView.h"
@interface WYYCCommentCell ()
@property (weak, nonatomic) IBOutlet UILabel *orderNum;
@property (weak, nonatomic) IBOutlet HCSStarRatingView *commentView;
@property (weak, nonatomic) IBOutlet UITextView *commentMessage;
@property (weak, nonatomic) IBOutlet UILabel *commentDate;

@end
@implementation WYYCCommentCell

- (void)awakeFromNib {
    // Initialization code
}

- (void)setComment:(WYYCComment *)comment
{
    self.orderNum.text = comment.orderNum;
    self.commentView.value = comment.commentScore.floatValue;
    self.commentMessage.text = comment.commentContent;
    self.commentDate.text = comment.commentDate;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
