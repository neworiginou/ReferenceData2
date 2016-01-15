//
//  CommentCell.m
//  PUClient
//
//  Created by RRLhy on 15/8/14.
//  Copyright (c) 2015年 RRLhy. All rights reserved.
//

#import "CommentCell.h"
#import "RRMJTool.h"

@implementation CommentCell

- (void)awakeFromNib {
    // Initialization code
    [super awakeFromNib];
    self.headerView = [[UserHeaderView alloc]initWithFrame:CGRectMake(10, 17, 35, 35)];
    [self.contentView addSubview:self.headerView];
    
    _parentImage.image = [UIImage stretchImageWithName:@"bg_news_pop_9"];
    
    [_parentLabel sizeToFit];
}

+ (NSString*)cellIndentifier
{
    return @"commentCell";
}

+ (CommentCell*)commentCellAtIndex:(NSInteger)index
{
    // mainBundel加载xib,扩展名不用写.xib
    NSArray *arrayXibObjects = [[NSBundle mainBundle] loadNibNamed:@"CommentCell" owner:nil options:nil];
    return arrayXibObjects[index];
}

- (CommentCell*)cellWithComment:(CommentModel *)comment
{
    _headerView.type = User_General;
    _headerView.userUrl = comment.author.headImgUrl;
    [_nickLabel setTitle:comment.author.nickName forState:UIControlStateNormal];
    _levelImage.image = [RRMJTool levelImageWith:comment.author.level];
    _timeLabel.text = comment.createTimeStr;
    _contentLabel.text = comment.content;
    
    NSMutableAttributedString * str = [RRMJTool setLineSpacing:1 string:@"利卡觉得立法；离开减肥；ask 家；反抗军撒；离开减肥撒开减肥；开始；打开房间撒离开房间；啊口角是非；可立即大声；多浪费空间；阿拉山口减肥"];
    _parentLabel.attributedText = str;
    
    return self;
}

+ (CGFloat)heightForRowWithComment:(CommentModel *)comment
{
    CGFloat contentH = [comment.content heightWithFont:SYSTEMFONT(14) width:Main_Screen_Width - 20];
    return 100 + contentH;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

//
//- (void)layoutSubviews
//{
//    [super layoutSubviews];
//    [self.contentView setNeedsLayout];
//    [self.contentView layoutIfNeeded];
//    _contentLabel.preferredMaxLayoutWidth = CGRectGetWidth(_contentLabel.bounds);
//}
@end
