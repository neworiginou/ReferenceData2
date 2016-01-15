//
//  HWMyOrderCell.m
//  Community
//
//  Created by niedi on 15/7/7.
//  Copyright (c) 2015年 caijingpeng. All rights reserved.
//

#import "HWMyOrderCell.h"

@interface HWMyOrderCell ()
{
    UIImageView *_rightImg;
    DLable *_leftLab;
    DImageV *_buttomLine;
}
@end

@implementation HWMyOrderCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier])
    {
        _rightImg = [[UIImageView alloc]initWithFrame:CGRectMake(15, 10, 45, 45)];
        _rightImg.backgroundColor = [UIColor whiteColor];
        [self.contentView addSubview:_rightImg];
        
        _leftLab = [DLable LabTxt:@"" txtFont:TF15 txtColor:THEME_COLOR_SMOKE frameX:CGRectGetMaxX(_rightImg.frame) + 10 y:(65.0f - 15.0f) / 2.0f w:kScreenWidth - 100 - 15 h:15];
        [self.contentView addSubview:_leftLab];
        
        DImageV *rightImg = [DImageV imagV:@"arrow" frameX:kScreenWidth - 9 - 15 y:(65.0f - 16.0f) / 2.0f w:9 h:16];
        [self.contentView addSubview:rightImg];
        
        _buttomLine = [DImageV imagV:@"" frameX:0 y:64.5f w:kScreenWidth h:0.5f];
        _buttomLine.backgroundColor = THEME_COLOR_LINE;
        [self.contentView addSubview:_buttomLine];
    }
    return self;
}

- (void)fillDataWithTitle:(NSString *)title imgName:(NSString *)imgName
{
    _rightImg.image = [UIImage imageNamed:imgName];
    _leftLab.text = title;
}





@end
