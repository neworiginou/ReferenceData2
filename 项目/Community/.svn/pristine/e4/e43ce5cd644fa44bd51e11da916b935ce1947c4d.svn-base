//
//  HWGameSpreadTableViewCell.h
//  KaoLa
//
//  Created by WeiYuanlin on 15/1/13.
//  Copyright (c) 2015年 WeiYuanlin. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "HWGameSpreadModel.h"

@protocol HWGameSpreadTableViewCellDelegate <NSObject>

- (void)spreadBtnIsClicked:(HWGameSpreadModel *)spreadModel;

@end


@interface HWGameSpreadTableViewCell : UITableViewCell

{
    HWGameSpreadModel *_model;
}


@property (nonatomic, strong) UIImageView *headerImageView;//cell头image
@property (nonatomic, strong) UILabel *titleLabel;//主标题
@property (nonatomic, strong) UILabel *peopleLabel;
@property (nonatomic, strong) UILabel *subTitleLabel;//副标题
@property (nonatomic, strong) UIButton *spreadButton;//下载按钮


@property (nonatomic)id <HWGameSpreadTableViewCellDelegate> delegate;

- (void)setGameSpreadInfo:(HWGameSpreadModel *)model;

+ (CGFloat)getCellHeight;

@end
