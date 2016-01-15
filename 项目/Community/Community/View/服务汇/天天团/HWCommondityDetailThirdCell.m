//
//  HWCommondityDetailThirdCell.m
//  Community
//
//  Created by niedi on 15/8/7.
//  Copyright (c) 2015年 caijingpeng. All rights reserved.
//

#import "HWCommondityDetailThirdCell.h"

@interface HWCommondityDetailThirdCell ()
{
    HWCommondityDetailModel *_model;
    DLable *brandLab;
    DButton *brandClickBtn;
}
@end

@implementation HWCommondityDetailThirdCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier])
    {
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        
        CALayer *line = [DView layerFrameX:15
                                         y:0
                                         w:kScreenWidth - 2 * 15
                                         h:0.5f];
        [self.contentView.layer addSublayer:line];
        
        
        brandLab = [DLable LabTxt:@"" txtFont:TF15 txtColor:THEME_COLOR_SMOKE frameX:15 y:CGRectGetMaxY(line.frame) + 10 w:kScreenWidth - 2 * 15 h:20];
        [self.contentView addSubview:brandLab];
        
        brandClickBtn = [DButton buttonWithType:UIButtonTypeCustom];
        brandClickBtn.frame = brandLab.frame;
        [brandClickBtn addTarget:self action:@selector(brandLabClickAction) forControlEvents:UIControlEventTouchUpInside];
        [self.contentView addSubview:brandClickBtn];
    }
    return self;
}

- (void)fillDataWithModel:(HWCommondityDetailModel *)model
{
    _model = model;
    
    NSString *brandStr = [NSString stringWithFormat:@"品牌商：%@", _model.brand];
    CGFloat height = [Utility calculateStringHeight:brandStr font:FONT(TF15) constrainedSize:CGSizeMake(kScreenWidth - 2 * 15, 10000)].height;
    brandLab.height = height;
    brandLab.text = brandStr;
    
    brandClickBtn.frame = brandLab.frame;
}


- (void)brandLabClickAction
{
    [MobClick event:@"click_group_business"];//1.7
    
    if (_model.brandUrl.length > 0)
    {
        if (self.delegate && [self.delegate respondsToSelector:@selector(pushToBrandLink:)])
        {
            [self.delegate pushToBrandLink:_model.brandUrl];
        }
    }
}

+ (CGFloat)getCellHeigth:(HWCommondityDetailModel *)model
{
    NSString *brandStr = [NSString stringWithFormat:@"品牌商：%@", model.brand];
    CGFloat height = [Utility calculateStringHeight:brandStr font:FONT(TF15) constrainedSize:CGSizeMake(kScreenWidth - 2 * 15, 10000)].height;
    return height + 20;
}

@end
