//
//  HWNeighbourDetailCell.h
//  Community
//
//  Created by zhangxun on 14-9-1.
//  Copyright (c) 2014年 caijingpeng. All rights reserved.
//
//  邻里圈详情cell
//  修改记录
//          李中强 2015-01-15 13:26:33 修改为使用第三方cell，左划对IOS6适配


#import <UIKit/UIKit.h>
#import "HWNeighbourDetailListItemClass.h"
#import "UIImageView+WebCache.h"
#import "SWTableViewCell.h"

@protocol HWNeighbourDetailCellDelegate <NSObject>

- (void)reportWithReplyId:(NSString *)replyId;
- (void)pasteSucceed;

@end

@interface HWNeighbourDetailCell : SWTableViewCell
{
    HWNeighbourDetailListItemClass *_currentItem;
}

@property (nonatomic,strong)UIImageView *headIV;
@property (nonatomic,strong)UILabel *nameLabel;
@property (nonatomic,strong)UILabel *dateLabel;
@property (nonatomic,strong)UILabel *contentLabel;
@property (nonatomic,strong)NSString *detailId;
@property (nonatomic,strong)UIView *lineV;

@property (nonatomic,assign)id <HWNeighbourDetailCellDelegate>delegare;

- (void)rebuildWithInfo:(HWNeighbourDetailListItemClass *)neighbourDetailClass;

- (void)setFinalLine;

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier containingTableView:(UITableView *)containingTableView leftUtilityButtons:(NSArray *)leftUtilityButtons rightUtilityButtons:(NSArray *)rightUtilityButtons;
+ (float)getCellHeight:(HWNeighbourDetailListItemClass *)item;


@end
