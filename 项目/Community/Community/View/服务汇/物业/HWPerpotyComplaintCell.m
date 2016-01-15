//
//  HWPerpotyComplaintCell.m
//  Community
//
//  Created by niedi on 15/6/19.
//  Copyright (c) 2015年 caijingpeng. All rights reserved.
//

#import "HWPerpotyComplaintCell.h"
#import "HWPerpotyComplaintCellSubV1.h"
#import "HWPerpotyComplaintCellSubV2.h"

@interface HWPerpotyComplaintCell ()
{
    HWPropertyComplainModel *_model;
    NSIndexPath *_indexPath;
    
    CALayer *_topLine;
    DLable *_topLab;
    CALayer *_midLine;
    DImageV *_buttomImgV;
    DLable *_buttomTimeLab;
    DLable *_evaluateLab;
    DButton *_evaluateBtn;
    DLable *_evaluateResultLab;
    CALayer *_buttomLine;
    
    HWPerpotyComplaintCellSubV1 *_subV1;
    CALayer *_buttomLine1;
}
@end

@implementation HWPerpotyComplaintCell

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
        
        _midLine = [DView layerFrameX:15 y:CGRectGetMaxY(_topLab.frame) + (155.0f + 20) * kScreenRate w:kScreenWidth - 15 h:0.5f];
        _midLine.backgroundColor = THEME_COLOR_LINE.CGColor;
        [self.contentView.layer addSublayer:_midLine];
        
        _buttomImgV = [DImageV imagV:@"icon_time_1" frameX:15 y:CGRectGetMaxY(_midLine.frame) + 20 w:15 h:15];
        [self.contentView addSubview:_buttomImgV];
        
        _buttomTimeLab = [DLable LabTxt:@"" txtFont:TF13 txtColor:THEME_COLOR_TEXT frameX:CGRectGetMaxX(_buttomImgV.frame) + 5 y:CGRectGetMinY(_buttomImgV.frame) w:65.0f h:13];
        _buttomTimeLab.textAlignment = NSTextAlignmentLeft;
        [self.contentView addSubview:_buttomTimeLab];
        
        _evaluateLab = [DLable LabTxt:@"" txtFont:TF13 txtColor:THE_COLOR_RED frameX:15 y:_buttomTimeLab.frame.origin.y w:kScreenWidth - 2 * 15 h:13];
        _evaluateLab.textAlignment = NSTextAlignmentRight;
        [self.contentView addSubview:_evaluateLab];
        
        _evaluateBtn = [DButton btnTxt:@"评价" txtFont:TF13 frameX:kScreenWidth - 15 - 42.5f y:CGRectGetMaxY(_midLine.frame) + 7.5f w:42.5f h:23 target:self action:@selector(evaluateBtnClick)];
        [_evaluateBtn setStyle:DBtnStyleYellow];
        [self.contentView addSubview:_evaluateBtn];
        
        _evaluateResultLab = [DLable LabTxt:@"" txtFont:TF13 txtColor:THEME_COLOR_MONEY frameX:kScreenWidth - 15 - 79 y:CGRectGetMaxY(_midLine.frame) + 7.5f w:79 h:13];
        [self.contentView addSubview:_evaluateResultLab];
        
        _buttomLine = [DView layerFrameX:0 y:214.5f w:kScreenWidth h:0.5f];
        _buttomLine.backgroundColor = THEME_COLOR_LINE.CGColor;
        [self.contentView.layer addSublayer:_buttomLine];
        
        _subV1 = [HWPerpotyComplaintCellSubV1 SubV1];
        [_subV1 addTarget:self action:@selector(foldBtnClick) forControlEvents:UIControlEventTouchUpInside];
        [self.contentView addSubview:_subV1];
        
        _buttomLine1 = [DView layerFrameX:0 y:0 w:kScreenWidth h:0.5f];
        _buttomLine1.backgroundColor = THEME_COLOR_LINE.CGColor;
        [self.contentView.layer addSublayer:_buttomLine1];
    }
    return self;
}

- (void)evaluateBtnClick
{
    if (self.delegate && [self.delegate respondsToSelector:@selector(evaluateBtnClick:isCanReComplain:)])
    {
        if ([_model.status isEqualToString:@"2"])
        {
            [self.delegate evaluateBtnClick:_model.modelId isCanReComplain:NO];
        }
        else
        {
            [self.delegate evaluateBtnClick:_model.modelId isCanReComplain:YES];
        }
    }
}

- (void)foldBtnClick
{
    if (self.delegate && [self.delegate respondsToSelector:@selector(foldBtnClickIndexPath:)])
    {
        [self.delegate foldBtnClickIndexPath:_indexPath];
    }
}

- (void)fillDataWithModel:(HWPropertyComplainModel *)model indexPath:(NSIndexPath *)indexPath
{
    for (UIView *subV in self.contentView.subviews)
    {
        if ([subV isMemberOfClass:[HWPerpotyComplaintCellSubV2 class]])
        {
            [subV removeFromSuperview];
        }
    }
    
    _model = model;
    _indexPath = indexPath;
    
    CGRect frame = _topLab.frame;
    frame.size.height = [Utility calculateStringHeight:model.content font:[UIFont fontWithName:FONTNAME size:TF15] constrainedSize:CGSizeMake(kScreenWidth - 2 * 15, 10000)].height;
    _topLab.frame = frame;
    _topLab.text = model.content;
    
    frame = _midLine.frame;
    frame.origin.y = CGRectGetMaxY(_topLab.frame) + 15;
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
            _evaluateLab.text = [NSString stringWithFormat:@"处理完毕,耗时%@", model.spendTimeStr];
            _evaluateLab.textColor = THEME_COLOR_TEXT;
            frame.origin.x = -32.5;
            _evaluateBtn.hidden = NO;
            _evaluateResultLab.hidden = YES;
        }
        else if ([model.result isEqualToString:@"1"])
        {
            _evaluateLab.text = [NSString stringWithFormat:@"处理完毕,耗时%@", model.spendTimeStr];
            _evaluateLab.textColor = THEME_COLOR_TEXT;
            frame.origin.x = -55;
            _evaluateBtn.hidden = YES;
            _evaluateResultLab.hidden = NO;
            _evaluateResultLab.text = @"评价：满意";
            CGRect tmpFrame = _evaluateResultLab.frame;
            tmpFrame.origin.x = kScreenWidth - 15 - 65;
            tmpFrame.origin.y = _buttomTimeLab.frame.origin.y;
            _evaluateResultLab.frame = tmpFrame;
        }
        else if ([model.result isEqualToString:@"0"])
        {
            _evaluateLab.text = [NSString stringWithFormat:@"处理完毕,耗时%@", model.spendTimeStr];
            _evaluateLab.textColor = THEME_COLOR_TEXT;
            frame.origin.x = -68;
            _evaluateBtn.hidden = YES;
            _evaluateResultLab.hidden = NO;
            _evaluateResultLab.text = @"评价：不满意";
            CGRect tmpFrame = _evaluateResultLab.frame;
            tmpFrame.origin.x = kScreenWidth - 15 - 79;
            tmpFrame.origin.y = _buttomTimeLab.frame.origin.y;
            _evaluateResultLab.frame = tmpFrame;
        }
    }
    else if ([model.status isEqualToString:@"2"])
    {
        if ([model.result isEqualToString:@""])
        {
            _evaluateLab.text = [NSString stringWithFormat:@"处理完毕,耗时%@", model.spendTimeStr];
            _evaluateLab.textColor = THEME_COLOR_TEXT;
            frame.origin.x = -32.5;
            _evaluateBtn.hidden = NO;
            _evaluateResultLab.hidden = YES;
        }
        else if ([model.result isEqualToString:@"1"])
        {
            _evaluateLab.text = [NSString stringWithFormat:@"处理完毕,耗时%@", model.spendTimeStr];
            _evaluateLab.textColor = THEME_COLOR_TEXT;
            frame.origin.x = -55;
            _evaluateBtn.hidden = YES;
            _evaluateResultLab.hidden = NO;
            _evaluateResultLab.text = @"评价：满意";
            CGRect tmpFrame = _evaluateResultLab.frame;
            tmpFrame.origin.x = kScreenWidth - 15 - 65;
            tmpFrame.origin.y = _buttomTimeLab.frame.origin.y;
            _evaluateResultLab.frame = tmpFrame;
        }
        else if ([model.result isEqualToString:@"0"])
        {
            _evaluateLab.text = [NSString stringWithFormat:@"处理完毕,耗时%@", model.spendTimeStr];
            _evaluateLab.textColor = THEME_COLOR_TEXT;
            frame.origin.x = -68;
            _evaluateBtn.hidden = YES;
            _evaluateResultLab.hidden = NO;
            _evaluateResultLab.text = @"评价：不满意";
            CGRect tmpFrame = _evaluateResultLab.frame;
            tmpFrame.origin.x = kScreenWidth - 15 - 79;
            tmpFrame.origin.y = _buttomTimeLab.frame.origin.y;
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
    
    
    if (model.sonList.count > 3)
    {
        if (model.isFold)
        {
            _subV1.hidden = NO;
            
            HWPerpotyComplaintCellSubV2 *sub2;
            
            for (int i = 0; i < model.sonList.count; i++)
            {
                if (i == 0 || i == 1 || i == model.sonList.count - 1)
                {
                    HWPropertyComplainModel *subModel = [model.sonList pObjectAtIndex:i];
                    
                    sub2 = [[HWPerpotyComplaintCellSubV2  alloc] initWith:subModel.createTimeStr content:subModel.content];
                    if (i == 0 || i == 1)
                    {
                        frame = sub2.frame;
                        frame.origin.y = CGRectGetMaxY(_buttomLine.frame) + 5 + 109.5f * i;
                        sub2.frame = frame;
                        [self.contentView addSubview:sub2];
                    }
                    else
                    {
                        frame = _subV1.frame;
                        frame.origin.y = CGRectGetMaxY(_buttomLine.frame) + 5 + 109.5f * 2;
                        _subV1.frame = frame;
                        
                        frame = sub2.frame;
                        frame.origin.y = CGRectGetMaxY(_subV1.frame);
                        sub2.frame = frame;
                        [self.contentView addSubview:sub2];
                    }
                    
                    if (i == 1 || i == model.sonList.count - 1)
                    {
                        [sub2 hideButtomLine];
                    }
                }
            }
            frame = _buttomLine1.frame;
            frame.origin.y = CGRectGetMaxY(sub2.frame);
            _buttomLine1.frame = frame;
        }
        else
        {
            _subV1.hidden = YES;
            
            HWPerpotyComplaintCellSubV2 *sub2;
            
            for (int i = 0; i < model.sonList.count; i++)
            {
                HWPropertyComplainModel *subModel = [model.sonList pObjectAtIndex:i];
                
                sub2 = [[HWPerpotyComplaintCellSubV2  alloc] initWith:subModel.createTimeStr content:subModel.content];
                frame = sub2.frame;
                frame.origin.y = CGRectGetMaxY(_buttomLine.frame) + 5 + sub2.frame.size.height * i;
                sub2.frame = frame;
                [self.contentView addSubview:sub2];
                
                if (i == model.sonList.count - 1)
                {
                    [sub2 hideButtomLine];
                }
            }
            
            frame = _buttomLine1.frame;
            frame.origin.y = CGRectGetMaxY(sub2.frame);
            _buttomLine1.frame = frame;
        }
    }
    else
    {
        _subV1.hidden = YES;
        
        HWPerpotyComplaintCellSubV2 *sub2;
        
        for (int i = 0; i < model.sonList.count; i++)
        {
            HWPropertyComplainModel *subModel = [model.sonList pObjectAtIndex:i];
            
            sub2 = [[HWPerpotyComplaintCellSubV2  alloc] initWith:subModel.createTimeStr content:subModel.content];
            frame = sub2.frame;
            frame.origin.y = CGRectGetMaxY(_buttomLine.frame) + 5 + sub2.frame.size.height * i;
            sub2.frame = frame;
            [self.contentView addSubview:sub2];
            
            if (i == model.sonList.count - 1)
            {
                [sub2 hideButtomLine];
            }
        }
        
        frame = _buttomLine1.frame;
        frame.origin.y = CGRectGetMaxY(sub2.frame);
        _buttomLine1.frame = frame;
    }
    
}



+ (CGFloat)getHeight:(HWPropertyComplainModel *)model
{
    CGFloat titleHeight = [Utility calculateStringHeight:model.content font:[UIFont fontWithName:FONTNAME size:TF15] constrainedSize:CGSizeMake(kScreenWidth - 2 * 15, 10000)].height;
    
    CGFloat subV2H = 0;
    if (model.sonList.count > 3)
    {
        if (model.isFold)
        {
            subV2H = 109.5f * 3 + 30.0f;
        }
        else
        {
            subV2H = 109.5f * model.sonList.count;
        }
    }
    else
    {
        subV2H = 109.5f * model.sonList.count;
    }
    return 20 + titleHeight + 15.0f + 41 + + 5.0f + subV2H;
}


@end
