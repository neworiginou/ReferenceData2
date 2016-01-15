//
//  RedPacketCell.h
//  HaoWu_4.0
//
//  Created by zhangxun on 14-8-1.
//  Copyright (c) 2014年 caijingpeng. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "HWRedPacketObject.h"

@interface RedPacketCell : UITableViewCell
{
    UIView *_lineV;
}
@property (nonatomic,strong)NSString *keyId;
@property (nonatomic,strong)NSString *redId;
@property (nonatomic,strong)NSString *activityName;
@property (nonatomic,strong)NSString *rewardTime;
@property (nonatomic,strong)NSString *minReward;
@property (nonatomic,strong)NSString *maxReward;
@property (nonatomic,strong)NSString *status;
@property (nonatomic,strong)NSString *rewardMoney;
@property (nonatomic,strong)NSString *effectiveTimeMills;
@property (nonatomic,strong)NSString *redType;

@property (nonatomic,strong)UIImageView *purseIV;
@property (nonatomic,strong)UIImageView *effectiveIV;
@property (nonatomic,strong)UILabel *activityLabel;
@property (nonatomic,strong)UILabel *dateLabel;
@property (nonatomic,strong)UILabel *tipLabel;
@property (nonatomic,strong)UIImageView *timeIV;
@property (nonatomic,strong)UIImageView*lockIV;

//- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier;
- (void)sizeFitWithObject:(HWRedPacketObject *)redObj section:(NSInteger)section;
- (void)countDownFinish;
- (void)setFinaLine;
- (void)setNormalLine;

@end
