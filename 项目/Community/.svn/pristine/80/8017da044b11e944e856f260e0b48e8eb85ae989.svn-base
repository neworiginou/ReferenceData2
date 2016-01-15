//
//  HWInviteCustomCell1.m
//  Community
//
//  Created by niedi on 15/6/12.
//  Copyright (c) 2015年 caijingpeng. All rights reserved.
//

#import "HWInviteCustomCell1.h"
#import "HWSlideChoseDateView.h"

@interface HWInviteCustomCell1 ()<HWSlideChoseDateViewDelegate>
{
    BOOL _isFold;
    DLable *_rightLab;
    DImageV *_buttomLine;
    DImageV *downImg;
}
@end

@implementation HWInviteCustomCell1

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier])
    {
        _isFold = YES;
        self.layer.masksToBounds = YES;
        
        DLable *leftLab = [DLable LabTxt:@"有效天数" txtFont:TF15 txtColor:THEME_COLOR_SMOKE frameX:15 y:15 w:200 h:15];
        [self.contentView addSubview:leftLab];
        
        _rightLab = [DLable LabTxt:@"当天" txtFont:TF15 txtColor:THEME_COLOR_TEXT frameX:kScreenWidth - 36 - 200 y:15 w:200 h:15];
        _rightLab.textAlignment = NSTextAlignmentRight;
        [self.contentView addSubview:_rightLab];
        
        downImg = [DImageV imagV:@"arrow3" frameX:kScreenWidth - 16 - 15 y:(45.0f - 9.0f) / 2.0f w:16 h:9];
        [self.contentView addSubview:downImg];
        
        DImageV *line = [DImageV imagV:@"" frameX:0 y:44.5f w:kScreenWidth h:0.5f];
        line.backgroundColor = THEME_COLOR_LINE;
        [self.contentView addSubview:line];
        
        HWSlideChoseDateView *slideView = [[HWSlideChoseDateView alloc] initWithFrame:CGRectMake(0, 45.0f, kScreenWidth, 0)];
        slideView.slideViewDelegate = self;
        [self.contentView addSubview:slideView];
        
        _buttomLine = [DImageV imagV:@"" frameX:0 y:113 + 44.5f w:kScreenWidth h:0.5f];
        _buttomLine.backgroundColor = THEME_COLOR_LINE;
        _buttomLine.hidden = YES;
        [self.contentView addSubview:_buttomLine];
    }
    return self;
}

- (void)didSelectSlideDate:(NSString *)date
{
    _rightLab.text = date;
    if (self.delegate && [self.delegate respondsToSelector:@selector(getSlideChoseDateString:)])
    {
        [self.delegate getSlideChoseDateString:date];
    }
}

- (void)setFold:(BOOL)isFold
{
    _isFold = isFold;
    _buttomLine.hidden = isFold;
    if (isFold)
    {
        downImg.image = [UIImage imageNamed:@"arrow3"];
    }
    else
    {
        downImg.image = [UIImage imageNamed:@"arrow4"];
    }
}

+ (CGFloat)getCellHeight:(BOOL)isFold
{
    if (isFold)
    {
        return 45.0f;
    }
    else
    {
        return 113 + 45.0f;
    }
}



@end
