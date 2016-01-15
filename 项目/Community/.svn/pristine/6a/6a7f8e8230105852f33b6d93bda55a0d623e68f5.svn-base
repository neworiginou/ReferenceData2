//
//  HWPublicRepairCell.m
//  Community
//
//  Created by niedi on 15/6/15.
//  Copyright (c) 2015年 caijingpeng. All rights reserved.
//

#import "HWPublicRepairCell.h"
#import "HWPublicRepairImgView.h"

@interface HWPublicRepairCell ()
{
    NSString *_modelId;// 投诉的modelID
    
    HWPublicRepairModel *_model;//报修的model
    
    CALayer *_topLine;
    DLable *_topLab;
    HWPublicRepairImgView *_imgView;
    CALayer *_midLine;
    DImageV *_buttomImgV;
    DLable *_buttomTimeLab;
    DLable *_evaluateLab;
    DButton *_evaluateBtn;
    DLable *_evaluateResultLab;
    CALayer *_buttomLine;
}
@end

@implementation HWPublicRepairCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier])
    {
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        
        _topLine = [DView layerFrameX:0 y:0 w:kScreenWidth h:0.5f];
        _topLine.backgroundColor = THEME_COLOR_LINE.CGColor;
        [self.contentView.layer addSublayer:_topLine];
        
        _topLab = [DLable LabTxt:@"" txtFont:TF15 txtColor:THEME_COLOR_SMOKE frameX:15 y:20.0f w:kScreenWidth - 2 * 15 h:40];
        [self.contentView addSubview:_topLab];
        
        _imgView = [[HWPublicRepairImgView alloc] initWithFrame:CGRectMake(15, CGRectGetMaxY(_topLab.frame), kScreenWidth - 2 * 15, 155.0f * kScreenRate)];
        [self.contentView addSubview:_imgView];
        
        _midLine = [DView layerFrameX:15 y:CGRectGetMaxY(_topLab.frame) + (155.0f + 20) * kScreenRate w:kScreenWidth - 15 h:0.5f];
        _midLine.backgroundColor = THEME_COLOR_LINE.CGColor;
        [self.contentView.layer addSublayer:_midLine];
        
        _buttomImgV = [DImageV imagV:@"icon_time_1" frameX:15 y:CGRectGetMaxY(_midLine.frame) + 20 w:15 h:15];
        [self.contentView addSubview:_buttomImgV];
        
        _buttomTimeLab = [DLable LabTxt:@"" txtFont:TF13 txtColor:THEME_COLOR_TEXT frameX:CGRectGetMaxX(_buttomImgV.frame) + 5 y:CGRectGetMinY(_buttomImgV.frame) w:200 h:13];
        _buttomTimeLab.textAlignment = NSTextAlignmentLeft;
        [self.contentView addSubview:_buttomTimeLab];
        
        _evaluateLab = [DLable LabTxt:@"" txtFont:TF13 txtColor:THE_COLOR_RED frameX:15 y:_buttomTimeLab.frame.origin.y w:kScreenWidth - 2 * 15 h:13];
        _evaluateLab.textAlignment = NSTextAlignmentRight;
        [self.contentView addSubview:_evaluateLab];
        
        _evaluateBtn = [DButton btnTxt:@"评价" txtFont:TF13 frameX:kScreenWidth - 15 - 42.5f y:CGRectGetMaxY(_midLine.frame) + 7.5f w:42.5f h:23 target:self action:@selector(evaluateBtnClick)];
        [_evaluateBtn setStyle:DBtnStyleYellow];
        [self.contentView addSubview:_evaluateBtn];
        
        _evaluateResultLab = [DLable LabTxt:@"" txtFont:TF13 txtColor:THEME_COLOR_MONEY frameX:kScreenWidth - 15 - 65 y:CGRectGetMaxY(_midLine.frame) + 7.5f w:100 h:13];
        _evaluateResultLab.userInteractionEnabled = YES;
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(unSatisfyReEvaluateClick)];
        [_evaluateResultLab addGestureRecognizer:tap];
        [self.contentView addSubview:_evaluateResultLab];
        
        _buttomLine = [DView layerFrameX:0 y:214.5f w:kScreenWidth h:0.5f];
        _buttomLine.backgroundColor = THEME_COLOR_LINE.CGColor;
        [self.contentView.layer addSublayer:_buttomLine];
    }
    return self;
}

- (void)evaluateBtnClick
{
    if (self.delegate && [self.delegate respondsToSelector:@selector(evaluateBtnClick:)])
    {
        [self.delegate evaluateBtnClick:_modelId];
    }
}

- (BOOL)getInterval:(NSString *)strTimestamp
{
    long long time = [strTimestamp longLongValue] / 1000;
    NSDate *date = [NSDate dateWithTimeIntervalSince1970:time];
    NSDate *currentDate = [NSDate date];
    float timeInterval = [currentDate timeIntervalSinceDate:date];
    if (timeInterval < 60 * 60 * 24 * 7)
    {
        return YES;
    }
    else
    {
        return NO;
    }
}

- (void)unSatisfyReEvaluateClick
{
    if ([_model.result isEqualToString:@"0"] && [self getInterval:_model.modifyTime] && [_model.userId isEqualToString:[HWUserLogin currentUserLogin].userId])
    {
        if (self.delegate && [self.delegate respondsToSelector:@selector(unSatisfyReEvaluateClick:)])
        {
            [self.delegate unSatisfyReEvaluateClick:_modelId];
        }
    }
}

- (void)fillDataWithModel:(HWPublicRepairModel *)model
{
    _modelId = model.modelId;
    _model = model;
    
    CGRect frame = _topLab.frame;
    frame.size.height = [Utility calculateStringHeight:model.content font:[UIFont fontWithName:FONTNAME size:TF15] constrainedSize:CGSizeMake(kScreenWidth - 2 * 15, 10000)].height;
    _topLab.frame = frame;
    _topLab.text = model.content;
    
    frame = _imgView.frame;
    frame.origin.y = CGRectGetMaxY(_topLab.frame);
    CGFloat imgVHeight;
    if (model.imagesArr.count == 2 || model.imagesArr.count == 3)
    {
        imgVHeight = 75.0f * kScreenRate + 20.0f;
    }
    else if (model.imagesArr.count == 0)
    {
        imgVHeight = 15;
    }
    else
    {
        imgVHeight = 155.0f * kScreenRate + 20.0f;
    }
    if (model.content.length == 0)
    {
        frame.origin.y = 10.0f;
    }
    frame.size.height = imgVHeight;
    _imgView.frame = frame;
    
    [_imgView setImgUrlArr:model.imagesArr superView:self.superV];
    
    frame = _midLine.frame;
    frame.origin.y = CGRectGetMaxY(_imgView.frame);
    _midLine.frame = frame;
    
    frame = _buttomImgV.frame;
    frame.origin.y = CGRectGetMaxY(_midLine.frame) + 12;
    _buttomImgV.frame = frame;
    
    frame = _buttomTimeLab.frame;
    frame.origin.y = CGRectGetMinY(_buttomImgV.frame);
    frame.origin.x = CGRectGetMaxX(_buttomImgV.frame) + 5;
    _buttomTimeLab.text = [Utility getTimeStampToStrRule:model.createTime];
    _buttomTimeLab.frame = frame;
    
    frame = _evaluateLab.frame;
    frame.origin.y = _buttomTimeLab.frame.origin.y;
    if ([model.status isEqualToString:@"0"])
    {
        _evaluateLab.text = @"等待物业受理";
        _evaluateLab.textColor = THEBUTTON_RED_NORMAL;
        frame.origin.x = 15;
        _evaluateBtn.hidden = YES;
        _evaluateResultLab.hidden = YES;
    }
    else if ([model.status isEqualToString:@"1"])
    {
        _evaluateLab.text = @"物业处理中";
        _evaluateLab.textColor = THEME_COLOR_ORANGE;
        frame.origin.x = 15;
        _evaluateBtn.hidden = YES;
        _evaluateResultLab.hidden = YES;
    }
    else if ([model.status isEqualToString:@"2"])
    {
        if ([model.result isEqualToString:@""])
        {
            _evaluateLab.text = [NSString stringWithFormat:@"处理完毕,%@", model.spendTimeStr];
            _evaluateLab.textColor = THEME_COLOR_TEXT;
            if ([model.userId isEqualToString:[HWUserLogin currentUserLogin].userId])
            {
                frame.origin.x = -32.5;
                _evaluateBtn.hidden = NO;
            }
            else
            {
                frame.origin.x = 15;
                _evaluateBtn.hidden = YES;
            }
            _evaluateResultLab.hidden = YES;
        }
        else if ([model.result isEqualToString:@"1"])
        {
            _evaluateLab.text = [NSString stringWithFormat:@"处理完毕,%@", model.spendTimeStr];
            _evaluateLab.textColor = THEME_COLOR_TEXT;
            frame.origin.x = -55;
            _evaluateBtn.hidden = YES;
            _evaluateResultLab.hidden = NO;
            _evaluateResultLab.text = @"评价：满意";
            CGRect tmpFrame = _evaluateResultLab.frame;
            tmpFrame.origin.y = _buttomTimeLab.frame.origin.y;
            tmpFrame.origin.x = kScreenWidth - 15 - 65;
            _evaluateResultLab.frame = tmpFrame;
        }
        else if ([model.result isEqualToString:@"0"])
        {
            _evaluateLab.text = [NSString stringWithFormat:@"处理完毕,%@", model.spendTimeStr];
            _evaluateLab.textColor = THEME_COLOR_TEXT;
            frame.origin.x = -71;
            _evaluateBtn.hidden = YES;
            _evaluateResultLab.hidden = NO;
            _evaluateResultLab.text = @"评价：不满意";
            CGRect tmpFrame = _evaluateResultLab.frame;
            tmpFrame.origin.y = _buttomTimeLab.frame.origin.y;
            tmpFrame.origin.x = kScreenWidth - 15 - 65 - 12;
            _evaluateResultLab.frame = tmpFrame;
        }
    }
    _evaluateLab.frame = frame;
    
    frame = _evaluateBtn.frame;
    frame.origin.y = CGRectGetMaxY(_midLine.frame) + 7.5f;
    _evaluateBtn.frame = frame;
    
    frame = _buttomLine.frame;
    frame.origin.y = CGRectGetMaxY(_midLine.frame) + 40;
    _buttomLine.frame = frame;
    
}


+ (CGFloat)getHeight:(HWPublicRepairModel *)model
{
    CGFloat titleHeight = [Utility calculateStringHeight:model.content font:[UIFont fontWithName:FONTNAME size:TF15] constrainedSize:CGSizeMake(kScreenWidth - 2 * 15, 10000)].height;
    if (model.content.length == 0)
    {
        titleHeight = -10;
    }
    CGFloat imgVHeight;
    if (model.imagesArr.count == 2 || model.imagesArr.count == 3)
    {
        imgVHeight = 75.0f * kScreenRate + 20.0f;
    }
    else if (model.imagesArr.count == 0)
    {
        imgVHeight = 15;
    }
    else
    {
        imgVHeight = 155.0f * kScreenRate + 20.0f;
    }
    
    return 20 + titleHeight + imgVHeight + 41;
}


#pragma mark - 投诉复用
- (void)fillDataWithModelForComplain:(HWPropertyComplainModel *)model
{
    _modelId = model.modelId;
    
    CGRect frame = _topLab.frame;
    frame.size.height = [Utility calculateStringHeight:model.content font:[UIFont fontWithName:FONTNAME size:TF15] constrainedSize:CGSizeMake(kScreenWidth - 2 * 15, 10000)].height;
    _topLab.frame = frame;
    _topLab.text = model.content;
    
    frame = _imgView.frame;
    frame.origin.y = CGRectGetMaxY(_topLab.frame);
    CGFloat imgVHeight;
    if (model.imagesArr.count == 2 || model.imagesArr.count == 3)
    {
        imgVHeight = 75.0f * kScreenRate + 20.0f;
    }
    else if (model.imagesArr.count == 0)
    {
        imgVHeight = 15;
    }
    else
    {
        imgVHeight = 155.0f * kScreenRate + 20.0f;
    }
    if (model.content.length == 0)
    {
        frame.origin.y = 10.0f;
    }
    frame.size.height = imgVHeight;
    _imgView.frame = frame;
    
    [_imgView setImgUrlArr:model.imagesArr superView:self.superV];
    
    frame = _midLine.frame;
    frame.origin.y = CGRectGetMaxY(_imgView.frame);
    _midLine.frame = frame;
    
    frame = _buttomImgV.frame;
    frame.origin.y = CGRectGetMaxY(_midLine.frame) + 12;
    _buttomImgV.frame = frame;
    
    frame = _buttomTimeLab.frame;
    frame.origin.y = CGRectGetMinY(_buttomImgV.frame);
    frame.origin.x = CGRectGetMaxX(_buttomImgV.frame) + 5;
    _buttomTimeLab.text = [Utility getTimeStampToStrRule:model.createTime];
    _buttomTimeLab.frame = frame;
    
    frame = _evaluateLab.frame;
    frame.origin.y = _buttomTimeLab.frame.origin.y;
    if ([model.status isEqualToString:@"0"])
    {
        _evaluateLab.text = @"等待物业受理";
        _evaluateLab.textColor = THEBUTTON_RED_NORMAL;
        frame.origin.x = 15;
        _evaluateBtn.hidden = YES;
        _evaluateResultLab.hidden = YES;
    }
    else if ([model.status isEqualToString:@"1"])
    {
        _evaluateLab.text = @"物业处理中";
        _evaluateLab.textColor = THEME_COLOR_ORANGE;
        frame.origin.x = 15;
        _evaluateBtn.hidden = YES;
        _evaluateResultLab.hidden = YES;
    }
    else if ([model.status isEqualToString:@"3"])
    {
        if ([model.result isEqualToString:@""])
        {
            _evaluateLab.text = [NSString stringWithFormat:@"处理完毕,%@", model.spendTimeStr];
            _evaluateLab.textColor = THEME_COLOR_TEXT;
            frame.origin.x = -32.5;
            _evaluateBtn.hidden = NO;
            _evaluateResultLab.hidden = YES;
        }
        else if ([model.result isEqualToString:@"1"])
        {
            _evaluateLab.text = [NSString stringWithFormat:@"处理完毕,%@", model.spendTimeStr];
            _evaluateLab.textColor = THEME_COLOR_TEXT;
            frame.origin.x = -55;
            _evaluateBtn.hidden = YES;
            _evaluateResultLab.hidden = NO;
            _evaluateResultLab.text = @"评价：满意";
            CGRect tmpFrame = _evaluateResultLab.frame;
            tmpFrame.origin.y = _buttomTimeLab.frame.origin.y;
            tmpFrame.origin.x = kScreenWidth - 15 - 65;
            _evaluateResultLab.frame = tmpFrame;
        }
        else if ([model.result isEqualToString:@"0"])
        {
            _evaluateLab.text = [NSString stringWithFormat:@"处理完毕,%@", model.spendTimeStr];//耗时
            _evaluateLab.textColor = THEME_COLOR_TEXT;
            frame.origin.x = -71;
            _evaluateBtn.hidden = YES;
            _evaluateResultLab.hidden = NO;
            _evaluateResultLab.text = @"评价：不满意";
            CGRect tmpFrame = _evaluateResultLab.frame;
            tmpFrame.origin.y = _buttomTimeLab.frame.origin.y;
            tmpFrame.origin.x = kScreenWidth - 15 - 65 - 12;
            _evaluateResultLab.frame = tmpFrame;
        }
    }
    _evaluateLab.frame = frame;
    
    frame = _evaluateBtn.frame;
    frame.origin.y = CGRectGetMaxY(_midLine.frame) + 7.5f;
    _evaluateBtn.frame = frame;
    
    frame = _buttomLine.frame;
    frame.origin.y = CGRectGetMaxY(_midLine.frame) + 40;
    _buttomLine.frame = frame;
}

+ (CGFloat)getHeightForComplain:(HWPropertyComplainModel *)model
{
    CGFloat titleHeight = [Utility calculateStringHeight:model.content font:[UIFont fontWithName:FONTNAME size:TF15] constrainedSize:CGSizeMake(kScreenWidth - 2 * 15, 10000)].height;
    if (model.content.length == 0)
    {
        titleHeight = -10;
    }
    CGFloat imgVHeight;
    if (model.imagesArr.count == 2 || model.imagesArr.count == 3)
    {
        imgVHeight = 75.0f * kScreenRate + 20.0f;
    }
    else if (model.imagesArr.count == 0)
    {
        imgVHeight = 15;
    }
    else
    {
        imgVHeight = 155.0f * kScreenRate + 20.0f;
    }
    
    return 20 + titleHeight + imgVHeight + 41;
    
}

@end
