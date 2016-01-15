//
//  HWCommunityCell.h
//  Community
//
//  Created by caijingpeng.haowu on 14-9-7.
//  Copyright (c) 2014年 caijingpeng. All rights reserved.
//
//  周边小区 cell
//

#import <UIKit/UIKit.h>

@class HWCommunityCell;

@protocol HWCommunityCellDelegate <NSObject>

- (void)communityCell:(HWCommunityCell *)cell didSelectItem:(BOOL)yesOrNo;

@end

@interface HWCommunityCell : UITableViewCell

@property (nonatomic, strong) UILabel *titleLab;
@property (nonatomic, strong) UILabel *subTitleLab;
@property (nonatomic, strong) UILabel *distanceLab;
@property (nonatomic, strong) UIButton *selectBtn;
@property (nonatomic, assign) id<HWCommunityCellDelegate> delegate;
@property (nonatomic, copy)void(^selecCommunity)(BOOL flag);

@end
