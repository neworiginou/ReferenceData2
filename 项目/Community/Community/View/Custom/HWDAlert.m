//
//  HWDAlert.m
//  HWCustomAlertView
//
//  Created by D on 14/12/15.
//  Copyright (c) 2014年 D. All rights reserved.
//

#import "HWDAlert.h"

@implementation HWDAlert

- (instancetype)initWithOtherViewHight:(CGFloat)height {
    if (self = [super init]) {
        self.frame = CGRectMake(0, 0, kScreenWidth, CONTENT_HEIGHT + 64);
        self.backgroundColor = [UIColor clearColor];
        
        UIControl * resignResponseControl = [[UIControl alloc] initWithFrame:CGRectMake(0, 0, self.frame.size.width, self.frame.size.height)];
        resignResponseControl.backgroundColor = [UIColor clearColor];
        resignResponseControl.tag = 202;
        [resignResponseControl addTarget:self action:@selector(btnClick:) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:resignResponseControl];
        
        CGFloat width = kScreenWidth - 2 * 15;
        self.handleView = [[UIView alloc] initWithFrame:CGRectMake(15, 200, width, height + (width - 2 * 20)/7.0f)];
        self.handleView.backgroundColor = [UIColor whiteColor];
        self.handleView.layer.cornerRadius = 6;
        [self addSubview:self.handleView];
    }
    return self;
}

- (void)loadUI {
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardWillShow:) name:UIKeyboardWillShowNotification object:nil];
    self.secretStr = @"";
}

- (void)keyboardWillShow:(NSNotification *)notification {
    
    NSDictionary *info = [notification userInfo];
    CGSize kbSize = [[info objectForKey:UIKeyboardFrameEndUserInfoKey] CGRectValue].size;
    
    CGRect frame = self.handleView.frame;
    frame.origin.y = self.frame.size.height - kbSize.height - 20 - self.handleView.frame.size.height;
    self.handleView.frame = frame;
}

- (void)btnClick:(UIButton *)button {
    
    self.isShowing = NO;
    switch (button.tag - 202) {
        case 0: //取消
        {
            [self hide];
            
            if (self.delegate && [self.delegate respondsToSelector:@selector(alertView:secretStr:)]) {
                [self.delegate alertView:self secretStr:nil];
            }
            if (self.returanPayPassward)
            {
                self.returanPayPassward(nil);
            }
        }
            break;
        case 1:
        {
            if (self.isSingleCustomView)
            {
                [MobClick event:@"click_querenshiyongkaolabioverage"]; //maidian_1.2.1
            }
            else
            {
                [MobClick event:@"click_querenzhifu"]; //maidian_1.2.1
            }
            
            if (self.secretStr.length == 6)
            {
                if (self.delegate && [self.delegate respondsToSelector:@selector(alertView:secretStr:)]) {
                    [self.delegate alertView:self secretStr:self.secretStr];
                }
                if (self.returanPayPassward)
                {
                    self.returanPayPassward(self.secretStr);
                }
                [self hide];
            }
            [MobClick event:@"click_pay poundag"];
        }
        break;
        default:
            break;
    }
}

#pragma mark -
#pragma mark - 显示
- (void)show {
    
    [[UIApplication sharedApplication].delegate.window addSubview:self];
    
    CABasicAnimation *scale=[CABasicAnimation animationWithKeyPath:@"transform.scale"];
    
    scale.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseOut];
    scale.duration = 0.25;
    scale.fromValue = [NSNumber numberWithFloat:2];
    scale.toValue = [NSNumber numberWithFloat:1];
    
    CABasicAnimation *opacity=[CABasicAnimation animationWithKeyPath:@"opacity"];
    
    opacity.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseOut];
    opacity.duration =0.25;
    opacity.fromValue = [NSNumber numberWithFloat:0];
    opacity.toValue = [NSNumber numberWithFloat:1];
    
    
    [self.handleView.layer addAnimation:scale forKey:@"sc"];
    [self.handleView.layer addAnimation:opacity forKey:@"op"];
    
    [UIView animateWithDuration:0.3f animations:^{
        self.backgroundColor = [UIColor colorWithWhite:0 alpha:0.6];
    }];
}

- (void)hide
{
    [[self viewWithTag:555] resignFirstResponder];
    CABasicAnimation *scale=[CABasicAnimation animationWithKeyPath:@"transform.scale"];
    
    scale.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseOut];
    scale.duration = 0.25;
    scale.fromValue = [NSNumber numberWithFloat:1];
    scale.toValue = [NSNumber numberWithFloat:0.8];
    
    CABasicAnimation *opacity=[CABasicAnimation animationWithKeyPath:@"opacity"];
    
    opacity.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseOut];
    opacity.duration = 0.25;
    opacity.fromValue = [NSNumber numberWithFloat:1];
    opacity.toValue = [NSNumber numberWithFloat:0];
    
    
    [self.handleView.layer addAnimation:scale forKey:@"sc"];
    [self.handleView.layer addAnimation:opacity forKey:@"op"];
    
    [UIView animateWithDuration:0.25 animations:^{
        self.alpha = 0.0f;
    }completion:^(BOOL finished) {
        
        [self removeFromSuperview];
        
    }];
    
}

#pragma mark -
#pragma mark - textView代理方法
- (void)textViewDidBeginEditing:(UITextView *)textView
{
    if (self.isSingleCustomView)
    {
        [MobClick event:@"click_shiyongkaolabizhifu"]; //maidian_1.2.1
    }
    else
    {
        [MobClick event:@"get_focus_inputcashoverage"]; //maidian_1.2.1
    }
    
}

- (void)textViewDidChange:(UITextView *)textView {
    self.secretStr = textView.text;
    for (int i = 0; i < 6; i++)
    {
        UIImageView *imgV = (UIImageView *)[self viewWithTag:111 + i];
        if (i < textView.text.length)
        {
            imgV.image = [UIImage imageNamed:@"passwordBlock2"];
        }
        else
        {
            imgV.image = [UIImage imageNamed:@"passwordBlock"];
        }
    }
}
- (BOOL)textView:(UITextView *)textView shouldChangeTextInRange:(NSRange)range replacementText:(NSString *)text {
    if ([text isEqualToString:@""]) {
        return YES;
    }
    if (textView.text.length == 6) {
        return NO;
    }
    return YES;
}


+ (CGSize)calculateStringHeight:(NSString *)string font:(UIFont *)font constrainedSize:(CGSize)cSize
{
    if (IOS7)
    {
        NSDictionary *attribute = @{NSFontAttributeName: font};
        CGRect rect = [string boundingRectWithSize:cSize options:NSStringDrawingTruncatesLastVisibleLine | NSStringDrawingUsesLineFragmentOrigin | NSStringDrawingUsesFontLeading attributes:attribute context:nil];
        return rect.size;
    }
    else
    {
        CGSize size = [string sizeWithFont:font constrainedToSize:cSize lineBreakMode:NSLineBreakByWordWrapping];
        return size;
    }
    return CGSizeZero;
}

+ (UIImage *)imageWithColor:(UIColor *)color andSize:(CGSize)size
{
    CGRect rect = CGRectMake(0.0f, 0.0f, size.width, size.height);
    UIGraphicsBeginImageContext(rect.size);
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextSetFillColorWithColor(context, [color CGColor]);
    CGContextFillRect(context, rect);
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return image;
}

- (void)dealloc
{
    [[NSNotificationCenter defaultCenter] removeObserver:self name:UIKeyboardWillShowNotification object:nil];
}


@end
