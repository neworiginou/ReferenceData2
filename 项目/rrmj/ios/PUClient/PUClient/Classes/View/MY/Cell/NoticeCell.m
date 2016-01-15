//
//  NoticeCell.m
//  PUClient
//
//  Created by RRLhy on 15/8/3.
//  Copyright (c) 2015年 RRLhy. All rights reserved.
//

#import "NoticeCell.h"

@implementation NoticeCell

- (void)awakeFromNib {
    // Initialization code
    self.headerView = [[UserHeaderView alloc]initWithFrame:CGRectMake(10, 17, 48, 48)];
    [self.contentView addSubview:self.headerView];
}

+ (NSString*)indentifierId
{
    return @"noticeCell";
}

+ (NoticeCell * )noticeCell
{
    // mainBundel加载xib,扩展名不用写.xib
    NSArray *arrayXibObjects = [[NSBundle mainBundle] loadNibNamed:@"NoticeCell" owner:nil options:nil];
    return arrayXibObjects[0];
}

- (NoticeCell*)cellWithNotice:(id)notice
{
    _headerView.userUrl = [UserInfoConfig sharedUserInfoConfig].userInfo.headImgUrl;
    _headerView.type = User_Star;
    _nickLabel.text = @"伦敦的雨淋湿巴黎";
    _contentLabel.text = @"回复了你：滚犊子，别bb";
    _timeLabel.text = @"5分钟前";
    return self;
}

+ (CGFloat)heightForRowWithNotice:(id)notice
{
    return 80;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
