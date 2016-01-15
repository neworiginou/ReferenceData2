//
//  HWPostOfficeCell.m
//  Community
//
//  Created by niedi on 15/6/12.
//  Copyright (c) 2015年 caijingpeng. All rights reserved.
//

#import "HWPostOfficeCell.h"

@interface HWPostOfficeCell ()
{
    DLable *postNameLab;
    DLable *postNumLab;
    DLable *lastStateLab;
    DLable *codeTitleLab;
    DLable *codeLab;
    DImageV *stateImgV;
}
@end

@implementation HWPostOfficeCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier])
    {
        self.backgroundColor = BACKGROUND_COLOR;
        self.contentView.backgroundColor = BACKGROUND_COLOR;
        
        CGFloat backImgWidth = kScreenWidth - 2 * 15;
        DImageV *backImgV = [DImageV imagV:@"post-office_01" frameX:15 y:10 w:backImgWidth h:127];
        [self.contentView addSubview:backImgV];
        
        postNameLab = [DLable LabTxt:@"" txtFont:TF16 txtColor:THEME_COLOR_SMOKE frameX:15 y:15 w:backImgWidth - 2 * 15 h:18];
        [backImgV addSubview:postNameLab];
        
        postNumLab = [DLable LabTxt:@"" txtFont:TF13 txtColor:THEME_COLOR_SMOKE frameX:15 y:20 w:backImgWidth - 2 * 15 h:14];
        postNumLab.textAlignment = NSTextAlignmentRight;
        [backImgV addSubview:postNumLab];
        
        lastStateLab = [DLable LabTxt:@"" txtFont:TF13 txtColor:THEME_COLOR_SMOKE frameX:15 y:60 w:backImgWidth - 2 * 15 h:16];
        [backImgV addSubview:lastStateLab];
        
        codeTitleLab = [DLable LabTxt:@"取件密码：" txtFont:TF13 txtColor:THEME_COLOR_SMOKE frameX:15 y:CGRectGetMaxY(lastStateLab.frame) + 16 w:backImgWidth - 2 * 15 h:13];
        [backImgV addSubview:codeTitleLab];
        
        codeLab = [DLable LabTxt:@"" txtFont:TF19 txtColor:THEME_COLOR_SMOKE frameX:65 + 15 y:CGRectGetMaxY(lastStateLab.frame) + 11 w:200 h:19];
        [backImgV addSubview:codeLab];
        
        stateImgV = [DImageV imagV:@"label_16_05" frameX:kScreenWidth - 13 - 55 y:140 - 55 w:55 h:55];
        [self.contentView addSubview:stateImgV];
    }
    return self;
}


- (void)fillDataWithModel:(HWHWPostOfficeModel *)model
{
    NSString *postName = model.expressName.length == 0 ? @"快递" : model.expressName;
    postNameLab.text = postName;
    postNumLab.text = [NSString stringWithFormat:@"(单号：%@)", model.expressNum];
    lastStateLab.text = [NSString stringWithFormat:@"%@ 物业已签收", model.createTimeStr];
    codeLab.text = model.recipientPassword;
}

+ (CGFloat)getCellHeight:(HWHWPostOfficeModel *)model
{
    return 140;
}


@end
