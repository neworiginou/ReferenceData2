//
//  RedPacketCell.m
//  HaoWu_4.0
//
//  Created by zhangxun on 14-8-1.
//  Copyright (c) 2014年 caijingpeng. All rights reserved.
//

#import "RedPacketCell.h"

@implementation RedPacketCell

@synthesize redId,activityName,rewardTime,minReward,maxReward,status,rewardMoney,effectiveTimeMills,redType;
@synthesize purseIV,activityLabel,dateLabel,tipLabel,timeIV,lockIV,effectiveIV;

-(id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        
        
        self.purseIV = [[UIImageView alloc]initWithFrame:CGRectMake(20, 13, 30, 38.5)];
        [self.contentView addSubview:purseIV];
        
        activityLabel = [[UILabel alloc]initWithFrame:CGRectMake(60, 12.5, 100, 20)];
        activityLabel.backgroundColor = [UIColor clearColor];
        activityLabel.font = [UIFont fontWithName:FONTNAME size:15];
        activityLabel.textColor = THEME_COLOR_SMOKE;
        [self.contentView addSubview:activityLabel];
        
        dateLabel = [[UILabel alloc]initWithFrame:CGRectMake(60, 32.5, 150, 20)];
        dateLabel.font = [UIFont fontWithName:FONTNAME size:12];
        dateLabel.textColor = THEME_COLOR_TEXT;
        dateLabel.backgroundColor = [UIColor clearColor];
        [self.contentView addSubview:dateLabel];
        
        self.effectiveIV = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"time"]];
        [self.contentView addSubview:effectiveIV];
        
        self.lockIV = [[UIImageView alloc]initWithFrame:CGRectZero];
        lockIV.image = [UIImage imageNamed:@"lock"];
        [self.contentView addSubview:lockIV];
        
        self.tipLabel = [[UILabel alloc]init];
        tipLabel.backgroundColor = UIColorFromRGB(0x8ACF1C);
        tipLabel.font = [UIFont fontWithName:FONTNAME size:12];
        tipLabel.textColor = [UIColor whiteColor];
        [self.contentView addSubview:tipLabel];
        
        _lineV = [[UIView alloc]initWithFrame:CGRectMake(10, 64.5, self.frame.size.width - 20, 0.5)];
        _lineV.backgroundColor = [UIColor lightGrayColor];
        [self.contentView addSubview:_lineV];
        
    }
    return self;
}

- (void)sizeFitWithObject:(HWRedPacketObject *)redObj section:(NSInteger)section{
    
    self.keyId = redObj.keyId;
    self.redId = redObj.redId;
    self.activityName = redObj.activityName;
    self.rewardTime = redObj.rewardTime;
    self.minReward = redObj.minReward;
    self.maxReward = redObj.maxReward;
    self.status = redObj.status;
    self.rewardMoney =  redObj.rewardMoney;
    self.effectiveTimeMills = redObj.effectiveTimeMills;
    _lineV.frame = CGRectMake(10, 64.5, 300, 0.5);
    
    
    self.activityLabel.text = self.activityName;
    [activityLabel sizeToFit];
    if (activityLabel.frame.size.width > kScreenWidth - 110)
    {
        activityLabel.frame = CGRectMake(activityLabel.frame.origin.x, activityLabel.frame.origin.y, kScreenWidth - 110, activityLabel.frame.size.height);
    }
    if (section == 1)
    {
        purseIV.image = [UIImage imageNamed:@"purse_gray"];
        
        effectiveIV.frame = CGRectMake(60, 36.5, 12, 12);
        dateLabel.frame = CGRectMake(effectiveIV.frame.size.width + effectiveIV.frame.origin.x + 5, effectiveIV.frame.origin.y- 4, dateLabel.frame.size.width, dateLabel.frame.size.height);
        
        tipLabel.text = [NSString stringWithFormat:@" 最低￥%@ ",redObj.minReward];
        [tipLabel sizeToFit];
        tipLabel.frame = CGRectMake(activityLabel.frame.size.width + activityLabel.frame.origin.x+ 10, activityLabel.frame.origin.y+2, tipLabel.frame.size.width, tipLabel.frame.size.height);
        
        if (tipLabel.frame.size.width + activityLabel.frame.size.width > kScreenWidth - 110)
        {
            activityLabel.frame = CGRectMake(activityLabel.frame.origin.x, activityLabel.frame.origin.y, kScreenWidth - 110 - tipLabel.frame.size.width, activityLabel.frame.size.height);
            tipLabel.frame = CGRectMake(activityLabel.frame.size.width + activityLabel.frame.origin.x+ 10, activityLabel.frame.origin.y+2, tipLabel.frame.size.width, tipLabel.frame.size.height);
        }
        
        if (![redObj.status isEqualToString:@"1"])
        {
            [self showLockIV];
        }
        else
        {
            [self hideLockIV];
        }
    }
    else
    {
        self.dateLabel.text = self.rewardTime;
        
        purseIV.image = [UIImage imageNamed:@"purse_red"];
        effectiveIV.frame = CGRectZero;
        dateLabel.frame = CGRectMake(60, 32.5, 100, 20);
        [dateLabel sizeToFit];
        
    }
}

- (void)setFinaLine
{
    _lineV.frame = CGRectMake(0, 64.5, kScreenWidth, 0.5);
}

- (void)setNormalLine
{
    _lineV.frame = CGRectMake(10, 64.5, kScreenWidth - 20, 0.5);
}

- (void)showLockIV
{
    self.lockIV.frame = CGRectMake(kScreenWidth - 30, 25, 13, 15);
}

- (void)hideLockIV
{
    self.lockIV.frame = CGRectZero;
}

- (void)countDownFinish
{
    self.rewardTime = @"0";
    self.dateLabel.text = @"已过期";
}

- (void)awakeFromNib
{
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
