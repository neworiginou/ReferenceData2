//
//  HWPersonAddedCountBtn.m
//  Community
//
//  Created by hw500027 on 15/1/13.
//  Copyright (c) 2015年 caijingpeng. All rights reserved.
//
//  功能描述：显示个人动态 @我的 接收评论 赞 主题信息
//  修改记录：
//	姓名      日期         修改内容
//  陆晓波    2015-01-21   字体使用宏定义
//  陆晓波    2015-01-29   背景图片更换

#import "HWPersonAddedCountBtn.h"

@implementation HWPersonAddedCountBtn

-(id)init
{
    self = [HWPersonAddedCountBtn buttonWithType:UIButtonTypeCustom];
    if (self)
    {
        UIImage *backGroundImage = [UIImage imageNamed:@"dynamic_background"];
        [self setBackgroundImage:backGroundImage forState:UIControlStateNormal];
        self.frame = CGRectMake(0, 0, backGroundImage.size.width, backGroundImage.size.height);
        [self setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        self.titleLabel.font = [UIFont fontWithName:FONTNAME size:THEME_FONT_SMALL12];
        self.titleLabel.textAlignment = NSTextAlignmentCenter;
    }
    return self;
}

//覆盖父类的方法,取消高亮状态
-(void)setHighlighted:(BOOL)highlighted
{
    
}

//返回标题的frame
-(CGRect)titleRectForContentRect:(CGRect)contentRect
{
    return CGRectMake(0, 1, contentRect.size.width, THEME_FONT_SMALL12);
}
/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
