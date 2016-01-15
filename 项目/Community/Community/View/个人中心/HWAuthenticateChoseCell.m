//
//  HWAuthenticateChoseCell.m
//  Community
//
//  Created by niedi on 15/8/4.
//  Copyright (c) 2015年 caijingpeng. All rights reserved.
//

#import "HWAuthenticateChoseCell.h"

@interface HWAuthenticateChoseCell ()
{
    DLable *_leftLab;
}
@end

@implementation HWAuthenticateChoseCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier])
    {
        _leftLab = [DLable LabTxt:@"" txtFont:TF16 txtColor:THEME_COLOR_SMOKE frameX:15 y:0 w:kScreenWidth - 2 * 15 h:65.0f];
        [self.contentView addSubview:_leftLab];
        
        CALayer *buttomLine = [DView layerFrameX:0 y:64.5f w:kScreenWidth h:0.5f];
        [self.contentView.layer addSublayer:buttomLine];
    }
    return self;
}

- (void)fillDataWithLeftStr:(NSString *)leftStr
{
    _leftLab.text = leftStr;
}

+ (CGFloat)getHeight
{
    return 65.0f;
}

@end
