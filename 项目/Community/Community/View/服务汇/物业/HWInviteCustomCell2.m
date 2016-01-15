//
//  HWInviteCustomCell2.m
//  Community
//
//  Created by niedi on 15/6/12.
//  Copyright (c) 2015年 caijingpeng. All rights reserved.
//

#import "HWInviteCustomCell2.h"

@interface HWInviteCustomCell2 ()
{
    BOOL _isFold;
    DLable *_rightLab;
    DImageV *_buttomLine;
    DImageV *downImg;
    NSMutableArray *_btnArr;
}
@end

@implementation HWInviteCustomCell2

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier])
    {
        _isFold = YES;
        _btnArr = [NSMutableArray array];
        self.layer.masksToBounds = YES;
        
        DLable *leftLab = [DLable LabTxt:@"选择访客身份" txtFont:TF15 txtColor:THEME_COLOR_SMOKE frameX:15 y:15 w:200 h:15];
        [self.contentView addSubview:leftLab];
        
        _rightLab = [DLable LabTxt:@"(选填)" txtFont:TF15 txtColor:THEME_COLOR_TEXT frameX:kScreenWidth - 36 - 200 y:15 w:200 h:15];
        _rightLab.textAlignment = NSTextAlignmentRight;
        [self.contentView addSubview:_rightLab];
        
        downImg = [DImageV imagV:@"arrow3" frameX:kScreenWidth - 16 - 15 y:(45.0f - 9.0f) / 2.0f w:16 h:9];
        [self.contentView addSubview:downImg];
        
        DImageV *line = [DImageV imagV:@"" frameX:0 y:44.5f w:kScreenWidth h:0.5f];
        line.backgroundColor = THEME_COLOR_LINE;
        [self.contentView addSubview:line];
        
        CGFloat rate = (kScreenWidth - 2 * 15) / (320 - 2 * 15);
        NSArray *titleArr = @[@"朋友", @"亲人", @"同学", @"外卖", @"快递", @"租客", @"看房", @"其他"];
        DButton *btn;
        for (int i = 0; i < titleArr.count; i++)
        {
            btn = [DButton btnTxt:titleArr[i] txtFont:TF16 frameX:15 + (88 + 10) * (i % 3) *rate y:45 + 20 + (i / 3) * (35 * rate + 10) w:88 * rate h:35 * rate target:self action:@selector(btnClick:)];
            [btn setRadius:3.5f];
            [btn cancleHighlighted];
            btn.layer.borderWidth = 0.5f;
            btn.layer.borderColor = THEME_COLOR_LINE.CGColor;
            [btn setTitleColor:THEME_COLOR_GRAY_MIDDLE forState:UIControlStateNormal];
            [btn setBackgroundImage:[Utility imageWithColor:BACKGROUND_COLOR andSize:btn.frame.size] forState:UIControlStateNormal];
            [btn setTitleColor:THEME_COLOR_ORANGE forState:UIControlStateSelected];
            [btn setBackgroundImage:[Utility imageWithColor:THEME_COLOR_ORANGE_light andSize:btn.frame.size] forState:UIControlStateSelected];
            [_btnArr addObject:btn];
            [self.contentView addSubview:btn];
        }
        _buttomLine = [DImageV imagV:@"" frameX:0 y:175 + 44.5f w:kScreenWidth h:0.5f];
        _buttomLine.backgroundColor = THEME_COLOR_LINE;
        _buttomLine.hidden = YES;
        [self.contentView addSubview:_buttomLine];
    }
    return self;
}

- (void)btnClick:(DButton *)btn
{
    for (DButton *tmpBtn in _btnArr)
    {
        tmpBtn.selected = NO;
    }
    
    btn.selected = YES;
    
    NSString *title = btn.titleLabel.text;
    _rightLab.text = title;
    if (self.delegate && [self.delegate respondsToSelector:@selector(didSelectBtn:)])
    {
        [self.delegate didSelectBtn:title];
    }
}

- (void)setBtnSelectedWithTitle:(NSString *)title
{
    NSInteger index = 0;
    
    NSArray *titleArr = @[@"朋友", @"亲人", @"同学", @"外卖", @"快递", @"租客", @"看房", @"其他"];
    for (int i = 0; i < titleArr.count; i++)
    {
        if ([[titleArr pObjectAtIndex:i] isEqualToString:title])
        {
            index = i;
        }
    }
    
    DButton *btn = [_btnArr pObjectAtIndex:index];
    btn.selected = YES;
    _rightLab.text = title;
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
        return 175 + 45.0f;
    }
}

@end
