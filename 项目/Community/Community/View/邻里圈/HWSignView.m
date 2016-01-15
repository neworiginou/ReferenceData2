//
//  HWSignView.m
//  Community
//
//  Created by niedi on 15/4/21.
//  Copyright (c) 2015年 caijingpeng. All rights reserved.
//
//  功能描述：邻里圈个人主页 标签view
//
//  修改记录：
//      姓名          日期                      修改内容
//      聂迪        2015-04-21                 创建文件
//

#import "HWSignView.h"

@implementation HWSignView

- (instancetype)initWithTitle:(NSString *)title pointImgName:(NSString *)pointImgStr signBackImg:(NSString *)signBackImgStr
{
    if (self = [super init])
    {
        self.frame = CGRectMake(0, 0, 100, 40);
        
        UIImageView *pointImgV = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 15, 15)];
        pointImgV.image = [UIImage imageNamed:pointImgStr];
        [self addSubview:pointImgV];
        
        UIButton *signBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        signBtn.frame = CGRectMake(16, 16, 84, 24);
        [signBtn setBackgroundImage:[UIImage imageNamed:signBackImgStr] forState:UIControlStateNormal];
        [signBtn setTitle:title forState:UIControlStateNormal];
        [signBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        signBtn.titleLabel.font = [UIFont fontWithName:FONTNAME size:THEME_FONT_SMALL];
        [self addSubview:signBtn];
        
    }
    return self;
}


@end
