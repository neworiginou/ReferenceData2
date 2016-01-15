//
//  NoticeCell.h
//  PUClient
//
//  Created by RRLhy on 15/8/3.
//  Copyright (c) 2015年 RRLhy. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface NoticeCell : UITableViewCell
@property (retain, nonatomic) IBOutlet UserHeaderView *headerView;
@property (weak, nonatomic) IBOutlet UILabel *nickLabel;
@property (weak, nonatomic) IBOutlet UILabel *contentLabel;
@property (weak, nonatomic) IBOutlet UILabel *timeLabel;

+ (NSString*)indentifierId;

+ (NoticeCell*)noticeCell;

- (NoticeCell*)cellWithNotice:(id)notice;

+ (CGFloat)heightForRowWithNotice:(id)notice;

@end
