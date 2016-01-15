//
//  HWStartRepairComplaintVC.h
//  Community
//
//  Created by niedi on 15/6/15.
//  Copyright (c) 2015年 caijingpeng. All rights reserved.
//

#import "HWBaseViewController.h"

typedef NS_ENUM(NSInteger, startRepairComplaintType) {
    StartRepair = 0,        // 发起报修
    StartComplaint,         //发起投诉
    AddRemark               //添加备注
};


@protocol HWStartRepairComplaintVCDelegate <NSObject>

@optional
- (void)didLeaveMessage:(NSString *)leaveMessage imgStr:(NSString *)imgStr mongokeyArr:(NSArray *)mongkeyArr;

- (void)setRefreshVC;

@end


@interface HWStartRepairComplaintVC : HWBaseViewController

@property (nonatomic, weak) id<HWStartRepairComplaintVCDelegate> delegate;

@property (nonatomic, assign) startRepairComplaintType type;

@property (nonatomic, strong) NSString *beiZhuStr;
@property (nonatomic, strong) NSArray *beizhuImgArr;


@end
