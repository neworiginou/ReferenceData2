//
//  HWPerpotyComplaintCellSubV1.m
//  Community
//
//  Created by niedi on 15/6/19.
//  Copyright (c) 2015年 caijingpeng. All rights reserved.
//

#import "HWPerpotyComplaintCellSubV1.h"

@implementation HWPerpotyComplaintCellSubV1

+ (HWPerpotyComplaintCellSubV1 *)SubV1
{
    HWPerpotyComplaintCellSubV1 *btn = [self buttonWithType:UIButtonTypeCustom];
    btn.frame = CGRectMake(0, 0, kScreenWidth, 30.0f);
    [btn loadSubView];
    return btn;
}

- (void)loadSubView
{
    DImageV *topLine = [DImageV imagV:@"" frameX:0 y:0.5f w:kScreenWidth h:0.5f];
    topLine.backgroundColor = THEME_COLOR_LINE;
    [self addSubview:topLine];
    
    DImageV *buttomLine = [DImageV imagV:@"" frameX:0 y:29.5f w:kScreenWidth h:0.5f];
    buttomLine.backgroundColor = THEME_COLOR_LINE;
    [self addSubview:buttomLine];
    
    DLable *titleLab = [DLable LabTxt:@"展开全部" txtFont:TF15 txtColor:THEME_COLOR_TEXT frameX:(kScreenWidth - 55) / 2.0f + 10 y:5 w:100 h:20.0f];
    [self addSubview:titleLab];
    
    DImageV *arrImgV = [DImageV imagV:@"arrow3" frameX:CGRectGetMinX(titleLab.frame) - 16 - 5 y:(30 - 9) / 2.0f w:16 h:9];
    [self addSubview:arrImgV];
}


@end
