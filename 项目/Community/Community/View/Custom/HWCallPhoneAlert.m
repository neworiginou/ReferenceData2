//
//  CallPhoneAlert.m
//  CallPhoneAlert
//
//  Created by lizhongqiang on 14-8-27.
//  Copyright (c) 2014年 Lizhongqiang. All rights reserved.
//

#import "HWCallPhoneAlert.h"
#import "AppDelegate.h"
@implementation HWCallPhoneAlert

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        
    }
    return self;
}

- (id)initWithMessage:(NSString *)message closeEnable:(BOOL)close
{
    self = [super initWithFrame:CGRectMake(0, 44 + (IOS7 ? 20 : 0), kScreenWidth, 30)];//此处坐标无影响
    
    if (self) {
        self.backgroundColor = [UIColor clearColor];
        self.layer.masksToBounds = YES;
        // Initialization code
        label = [[UILabel alloc] initWithFrame:CGRectMake(0, -30, kScreenWidth, 30)];
        [label setBackgroundColor:UIColorFromRGB(0x959595)];
        label.textColor = [UIColor whiteColor];
        [label setText:message];
        label.font = [UIFont fontWithName:FONTNAME size:12.0f];
        [self addSubview:label];//label.alpha = 1;
        
        //最右边取消按钮  无图  以后换图片
        if (close)
        {
            btnClose = [UIButton buttonWithType:UIButtonTypeCustom];
            [btnClose setFrame:CGRectMake(kScreenWidth - 60, -30, 60, 30)];
            [btnClose setTitle:@"关闭" forState:UIControlStateNormal];
            //[btnClose setBackgroundImage:[UIImage imageNamed:@""] forState:UIControlStateNormal];
            btnClose.backgroundColor = [UIColor redColor];
            [btnClose setTitleColor:[UIColor redColor] forState:UIControlStateNormal];
            [btnClose addTarget:self action:@selector(hide) forControlEvents:UIControlEventTouchUpInside];
          //  btnClose.alpha = 0;
            [self addSubview:btnClose];
        }
    
        UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
        btn.backgroundColor = [UIColor clearColor];
        btn.frame = self.bounds;
        [btn addTarget:self action:@selector(alertDoTap:) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:btn];
    }
    return self;
    
}

const float animateTime = 1.0f;
const float animateStopTime = 3.0f;

- (void)show
{
    [UIView animateWithDuration:animateTime animations:^{
        [label setFrame:CGRectMake(0, 0, kScreenWidth, 30)];
        [btnClose setFrame:CGRectMake(kScreenWidth - 60, 0, 60, 30)];
        label.alpha = 1;
        btnClose.alpha = 1;
    } completion:^(BOOL finished) {
        [self performSelector:@selector(hide) withObject:nil afterDelay:animateStopTime];
    }];
}

- (void)hide
{
    [UIView animateWithDuration:animateTime animations:^{
        [label setFrame:CGRectMake(0, -30, kScreenWidth, 30)];
        [btnClose setFrame:CGRectMake(kScreenWidth - 60, -30, 60, 30)];
        label.alpha = 0;
        btnClose.alpha = 0;
    } completion:^(BOOL finished) {
        [label removeFromSuperview];
        [btnClose removeFromSuperview];
        [self removeFromSuperview];
        if (_hideAlert) {
            _hideAlert();
        }
    }];
}

- (void)alertDoTap:(id)sender
{
    // 跳转邻里圈  刷新列表
    AppDelegate *appDel = (AppDelegate *)[UIApplication sharedApplication].delegate;
    [appDel.tabBarVC.navigationController popToRootViewControllerAnimated:YES];
    [appDel.tabBarVC setSelectedIndex:1];
    
    [appDel.tabBarVC.neighbourVC refreshList];
    
    [self hide];
}

- (void)dealloc
{
    //alertView = nil;
    label = nil;
}


/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
    // Drawing code
}
*/

@end
