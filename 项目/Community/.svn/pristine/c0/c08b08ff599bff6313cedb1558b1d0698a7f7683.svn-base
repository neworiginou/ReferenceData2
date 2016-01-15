//
//  HWHouseSourceCell.h
//  HaoWu_4.0
//
//  Created by caijingpeng.haowu on 14-5-21.
//  Copyright (c) 2014年 caijingpeng. All rights reserved.
//

#import <UIKit/UIKit.h>

@class HWHouseSourceCell;
@protocol HWHouseSourceCellDelegate <NSObject>

- (void)didClickRecommandBtnWithCell:(HWHouseSourceCell *)cell;

@end

@interface HWHouseSourceCell : UITableViewCell

@property (nonatomic, strong)UIImageView *headImgV;
@property (nonatomic, strong)UIView *spreadTag;
@property (nonatomic, strong)UILabel *titleLabel;
@property (nonatomic, strong)UILabel *msgLabel;
@property (nonatomic, strong)UILabel *youhuiLabel;
@property (nonatomic, strong)UILabel *thirdLineLabel;
@property (nonatomic, strong)UILabel *priceLabel;
@property (nonatomic, strong)UIButton *recommandBtn;
@property (nonatomic, assign)id<HWHouseSourceCellDelegate> delegate;

- (void)setType:(NSArray *)typeArr;

@end
