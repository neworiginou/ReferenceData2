//
//  HWCommissionDetailView.h
//  Community
//
//  Created by niedi on 15/1/20.
//  Copyright (c) 2015年 caijingpeng. All rights reserved.
//

#import "HWBaseRefreshView.h"
#import "HWCommissionInfoModel.h"
#import "HWCommissionDetailModel.h"
#import "HWCommissionDetailCell.h"

@interface HWCommissionDetailView : HWBaseRefreshView
{
    UIView *_tableViewHeaderView;
    
    //每日佣金明细下的ui
    UILabel *_totalRMBCommissionLab;            //人民币总佣金
    UIImageView *_totalKoalaIconImg;            //考拉币图标
    UILabel *_totalKoalaCommissionLab;          //考拉币总佣金
    UILabel *_totalActivateGamePeopleNumLab;    //激活总量（人）
    UILabel *_totalGameCostLab;                 //用户总消费（￥）
    UIView *_belowSegmentViewForCommission;     //佣金明细的segment以下view
    
    UIView *_buttomTableViewUpView;
}

@property (nonatomic, strong) NSString *gameId;
@property (nonatomic, strong) HWCommissionInfoModel *commissionInfoModel;
@property (nonatomic, strong) NSMutableArray *sectionStatusArr;

- (instancetype)initWithFrame:(CGRect)frame andGameId:(NSString *)gameId;

@end
