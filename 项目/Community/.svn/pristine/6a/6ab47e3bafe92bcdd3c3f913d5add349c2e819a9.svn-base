//
//  HWPostOfficeRecordCell.m
//  Community
//
//  Created by niedi on 15/6/12.
//  Copyright (c) 2015年 caijingpeng. All rights reserved.
//

#import "HWPostOfficeRecordCell.h"

@interface HWPostOfficeRecordCell ()
{
    DLable *postNameLab;
    DLable *postNumLab;
    DLable *lastStateLab;
    DLable *codeTitleLab;
    DLable *codeLab;
    DImageV *stateImgV;
}
@end

@implementation HWPostOfficeRecordCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier])
    {
        self.backgroundColor = BACKGROUND_COLOR;
        self.contentView.backgroundColor = BACKGROUND_COLOR;
        
        CGFloat backImgWidth = kScreenWidth - 2 * 15;
        DImageV *backImgV = [DImageV imagV:@"post-office_02" frameX:15 y:10 w:backImgWidth h:92];
        [self.contentView addSubview:backImgV];
        
        postNameLab = [DLable LabTxt:@"" txtFont:TF16 txtColor:THEME_COLOR_SMOKE frameX:15 y:15 w:backImgWidth - 2 * 15 h:18];
        [backImgV addSubview:postNameLab];
        
        postNumLab = [DLable LabTxt:@"" txtFont:TF13 txtColor:THEME_COLOR_SMOKE frameX:15 y:20 w:backImgWidth - 2 * 15 h:14];
        postNumLab.textAlignment = NSTextAlignmentRight;
        [backImgV addSubview:postNumLab];
        
        lastStateLab = [DLable LabTxt:@"" txtFont:TF13 txtColor:THEME_COLOR_SMOKE frameX:15 y:60 w:backImgWidth - 2 * 15 h:16];
        [backImgV addSubview:lastStateLab];
        
        stateImgV = [DImageV imagV:@"label_16_06" frameX:kScreenWidth - 14 - 55 y:105 - 55 w:55 h:55];
        [self.contentView addSubview:stateImgV];
    }
    return self;
}


- (void)fillDataWithModel:(HWHWPostOfficeModel *)model
{
    NSString *postName = model.expressName.length == 0 ? @"快递" : model.expressName;
    postNameLab.text = postName;
    postNumLab.text = [NSString stringWithFormat:@"(单号：%@)", model.expressNum];
    lastStateLab.text = [NSString stringWithFormat:@"%@ 本人已取件", model.createTimeStr];
    codeLab.text = model.recipientPassword;
}

+ (CGFloat)getCellHeight:(HWHWPostOfficeModel *)model
{
    return 105;
}


@end
