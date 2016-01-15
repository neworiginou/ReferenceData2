//
//  HWIdentifyingCodeButton.m
//  Community
//
//  Created by hw500027 on 15/4/7.
//  Copyright (c) 2015年 caijingpeng. All rights reserved.
//
//  功能描述：社区V1.3 验证码按钮 能够进行语音播放
//  修改记录：
//	姓名     日期         修改内容
//  陆晓波   2015-04-07   文件创建

#import "HWIdentifyingCodeButton.h"
@interface HWIdentifyingCodeButton()
{
    int coldDown;
}
@end

@implementation HWIdentifyingCodeButton

- (id)init
{
    if (self)
    {
        self = [HWIdentifyingCodeButton buttonWithType:UIButtonTypeCustom];
    }
    return self;
}

-(void)btnFirstClick
{
    [self setInactiveState];
    [self setBackgroundImage:[Utility imageWithColor:BUTTON_COLOR_LIGHTGRAY andSize:self.frame.size] forState:UIControlStateNormal];
    coldDown = 60;
    [self setTitle:[NSString stringWithFormat:@"语音播报(%dS)",coldDown] forState:UIControlStateNormal];
    _timer = [NSTimer scheduledTimerWithTimeInterval:1 target:self selector:@selector(btnColdDown) userInfo:nil repeats:YES];
}

-(void)btnColdDown
{
    if (coldDown > 0)
    {
        coldDown = coldDown - 1;
        [self setTitle:[NSString stringWithFormat:@"语音播报(%dS)",coldDown] forState:UIControlStateNormal];
    }
    else if (coldDown == 0)
    {
        [self changeBtnStatus];
    }
}

-(void)changeBtnStatus
{
    [_timer invalidate];
    _timer = nil;
    
    self.userInteractionEnabled = YES;
    self.titleLabel.alpha = 1.0f;
    [self setTitle:@"语音播报" forState:UIControlStateNormal];
    [self setBackgroundImage:[Utility imageWithColor:THEBUTTON_GREEN_NORMAL andSize:self.frame.size] forState:UIControlStateNormal];
    [self setBackgroundImage:[Utility imageWithColor:THEBUTTON_GREEN_HIGHLIGHT andSize:self.frame.size] forState:UIControlStateHighlighted];

    if (self.identifyingCodeButtonDelegate && [self.identifyingCodeButtonDelegate respondsToSelector:@selector(btnPlaySound)])
    {
        [self.identifyingCodeButtonDelegate btnPlaySound];
    }
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
