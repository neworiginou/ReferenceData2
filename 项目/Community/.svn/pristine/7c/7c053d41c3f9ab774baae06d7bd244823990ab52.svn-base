//
//  HWCommondityDetailFirestCell.m
//  Community
//
//  Created by niedi on 15/8/7.
//  Copyright (c) 2015年 caijingpeng. All rights reserved.
//

#import "HWCommondityDetailFirestCell.h"

@interface HWCommondityDetailFirestCell ()
{
    long long _remainTimeLong;
    NSTimer *_timer;
    
    DLable *soldedLab;
    DImageV *limitImg;
    DLable *limitLab;
    DLable *remainTimeLab;
    DImageV *remainTimeIcon;
}
@end

@implementation HWCommondityDetailFirestCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier])
    {
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        self.contentView.backgroundColor = BACKGROUND_COLOR;
        
        DView *topBackV = [DView viewFrameX:0
                                          y:0
                                          w:kScreenWidth
                                          h:35.0f];
        topBackV.backgroundColor = THEME_COLOR_White;
        [self.contentView addSubview:topBackV];
        
        
        
        DImageV *soldedImgV = [DImageV imagV:@"已售"
                                      frameX:15
                                           y:11
                                           w:16
                                           h:15];
        [topBackV addSubview:soldedImgV];
        
        
        
        soldedLab = [DLable LabTxt:@""
                                   txtFont:TF13
                                  txtColor:THEME_COLOR_TEXT
                                    frameX:CGRectGetMaxX(soldedImgV.frame) + 4
                                         y:CGRectGetMinY(soldedImgV.frame) + 1.5f
                                         w:0
                                         h:15];
        [topBackV addSubview:soldedLab];
        
        
        
        limitImg = [DImageV imagV:@"限购"
                           frameX:0
                                y:CGRectGetMinY(soldedImgV.frame)
                                w:14.5f
                                h:15];
        [topBackV addSubview:limitImg];
        
        
        
        limitLab = [DLable LabTxt:@""
                          txtFont:TF13
                         txtColor:THEME_COLOR_TEXT
                           frameX:0
                                y:CGRectGetMinY(soldedImgV.frame) + 1
                                w:100
                                h:15];
        [topBackV addSubview:limitLab];
        
        
        
        remainTimeLab = [DLable LabTxt:@""
                                   txtFont:TF13
                                  txtColor:THEME_COLOR_ORANGE
                                    frameX:0
                                         y:CGRectGetMinY(soldedImgV.frame) + 1
                                         w:100
                                         h:15];
        [topBackV addSubview:remainTimeLab];
        
        
        
        remainTimeIcon = [DImageV imagV:@"剩余倒计时"
                                          frameX:kScreenWidth
                                               y:CGRectGetMinY(soldedImgV.frame)
                                               w:13.5
                                               h:15];
        [topBackV addSubview:remainTimeIcon];
        
        
        
        [Utility bottomLine:topBackV];
        
        
        
        DView *middleBackV = [DView viewFrameX:0
                                             y:CGRectGetMaxY(topBackV.frame) + 10
                                             w:kScreenWidth
                                             h:35];
        middleBackV.backgroundColor = THEME_COLOR_White;
        [self.contentView addSubview:middleBackV];
        
        
        
        [Utility topLine:middleBackV];
        
        
        
        DLable *topLab = [DLable LabTxt:@"商品说明"
                                txtFont:TF15
                               txtColor:THEME_COLOR_TEXT
                                 frameX:15
                                      y:0
                                      w:kScreenWidth - 2 * 15
                                      h:38];
        [middleBackV addSubview:topLab];
        
        
        
        CALayer *middleLine = [DView layerFrameX:15
                                              y:37.5
                                              w:kScreenWidth - 2 * 15
                                              h:0.5f];
        [middleBackV.layer addSublayer:middleLine];
    }
    return self;
}

- (void)fillDataWithModel:(HWCommondityDetailModel *)model
{
    if ([model.showSurplus isEqualToString:@"1"])
    {
        NSString *soldedStr = model.surplusStock.length > 0 ? model.surplusStock : @"0";
        soldedStr = [NSString stringWithFormat:@"剩余%@份", soldedStr];
        soldedLab.text = soldedStr;
        CGFloat width = [Utility calculateStringWidth:soldedStr
                                                 font:FONT(TF13)
                                      constrainedSize:CGSizeMake(10000, 15)].width;
        soldedLab.width = width;
    }
    else
    {
        NSString *soldedStr = model.buyGoodsCount.length > 0 ? model.buyGoodsCount : @"0";
        soldedStr = [NSString stringWithFormat:@"已售%@份", soldedStr];
        soldedLab.text = soldedStr;
        CGFloat width = [Utility calculateStringWidth:soldedStr
                                                 font:FONT(TF13)
                                      constrainedSize:CGSizeMake(10000, 15)].width;
        soldedLab.width = width;
    }
    
    if (model.limitCount.intValue > 0 && model.limitCount.length > 0)
    {
        limitImg.left = CGRectGetMaxX(soldedLab.frame) + 10;
        
        limitLab.left = CGRectGetMaxX(limitImg.frame) + 4;
        NSString *limitStr = [NSString stringWithFormat:@"限购%@份", model.limitCount];
        limitLab.text = limitStr;
        
        limitImg.hidden = NO;
        limitLab.hidden = NO;
    }
    else
    {
        limitImg.hidden = YES;
        limitLab.hidden = YES;
    }
    
    if ([model.status isEqualToString:@"0"] || [model.status isEqualToString:@"1"])
    {
        long long serverCurrentTime = [model.currentTime longLongValue];
        
        if ([model.status isEqualToString:@"1"])
        {
            long long serverEndTime = [model.endTime longLongValue];
            _remainTimeLong = (serverEndTime - serverCurrentTime) / 1000;
            [self startTimerFire:model];
            
            if ([model.showDistanceEndTime isEqualToString:@"1"])
            {
                remainTimeLab.hidden = NO;
                remainTimeIcon.hidden = NO;
                
                NSString *remainTimeStr = [Utility calculateRemainedTimeWithTimeInterval:_remainTimeLong];
                remainTimeLab.text = remainTimeStr;
                
                CGFloat width = [Utility calculateStringWidth:remainTimeStr
                                                         font:FONT(TF13)
                                              constrainedSize:CGSizeMake(10000, 14)].width;
                remainTimeLab.width = width;
                remainTimeLab.left = kScreenWidth - 15 - width;
                
                remainTimeIcon.left = CGRectGetMinX(remainTimeLab.frame) - 4 - 13.5f;
            }
            else
            {
                remainTimeLab.hidden = YES;
                remainTimeIcon.hidden = YES;
            }
        }
        else
        {
            long long serverStartTime = [model.startTime longLongValue];
            _remainTimeLong = (serverStartTime - serverCurrentTime) / 1000;
            [self startTimerFire:model];
            
            if ([model.showDistanceStartTime isEqualToString:@"1"])
            {
                remainTimeLab.hidden = NO;
                remainTimeIcon.hidden = NO;
                
                NSString *remainTimeStr = [Utility calculateRemainedTimeWithTimeInterval:_remainTimeLong];
                remainTimeLab.text = remainTimeStr;
                
                CGFloat width = [Utility calculateStringWidth:remainTimeStr
                                                         font:FONT(TF13)
                                              constrainedSize:CGSizeMake(10000, 14)].width;
                remainTimeLab.width = width;
                remainTimeLab.left = kScreenWidth - 15 - width;
                
                remainTimeIcon.left = CGRectGetMinX(remainTimeLab.frame) - 4 - 13.5f;
            }
            else
            {
                remainTimeLab.hidden = YES;
                remainTimeIcon.hidden = YES;
            }
        }
    }
    else
    {
        remainTimeLab.hidden = YES;
        remainTimeIcon.hidden = YES;
    }
}

- (void)startTimerFire:(HWCommondityDetailModel *)model
{
    [_timer invalidate];
    _timer = nil;
    
    long long serverCurrentTime = [model.currentTime longLongValue];
    if ([model.status isEqualToString:@"1"])
    {
        long long serverEndTime = [model.endTime longLongValue];
        _remainTimeLong = (serverEndTime - serverCurrentTime) / 1000;
    }
    else
    {
        long long serverStartTime = [model.startTime longLongValue];
        _remainTimeLong = (serverStartTime - serverCurrentTime) / 1000;
    }
    
    _timer = [NSTimer scheduledTimerWithTimeInterval:1
                                              target:self
                                            selector:@selector(updateTimer)
                                            userInfo:nil
                                             repeats:YES];
    //MYP add 防止tableview滚动时对timer的干扰
    [[NSRunLoop currentRunLoop]addTimer:_timer forMode:NSRunLoopCommonModes];
}

- (void)updateTimer
{
    if (_remainTimeLong <= 0)
    {
        [_timer invalidate];
        _timer = nil;
        if (self.delegate && [self.delegate respondsToSelector:@selector(timerEndAction)])
        {
            [self.delegate timerEndAction];
        }
        return;
    }
    _remainTimeLong--;
    NSString *remainTimeStr = [Utility calculateRemainedTimeWithTimeInterval:_remainTimeLong];
    remainTimeLab.text = remainTimeStr;
    
    CGFloat width = [Utility calculateStringWidth:remainTimeStr
                                     font:FONT(TF13)
                          constrainedSize:CGSizeMake(10000, 14)].width;
    remainTimeLab.width = width;
    remainTimeLab.left = kScreenWidth - 15 - width;
    
    remainTimeIcon.left = CGRectGetMinX(remainTimeLab.frame) - 4 - 13.5f;
}

@end
