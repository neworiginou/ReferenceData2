//
//  HWSoundPlayButton.m
//  Community
//
//  Created by hw500027 on 15/1/12.
//  Copyright (c) 2015年 caijingpeng. All rights reserved.
//

#import "HWSoundPlayButton.h"

@interface HWSoundPlayButton ()
{
    UIImageView* animateImgV;
    NSString* _soundUrl;
    NSIndexPath *_index;
}

@end
@implementation HWSoundPlayButton
@synthesize buttonStatus;

-(id)initWithTitle:(NSString*)titleName isBig:(BOOL)big
{
    self = [HWSoundPlayButton buttonWithType:UIButtonTypeCustom];
    CGFloat btnWidth = 0.0f;
    if (self) {
        if (IOS7) {
            CGRect rect = [titleName boundingRectWithSize:CGSizeMake(100, 100) options:NSStringDrawingTruncatesLastVisibleLine attributes:@{NSFontAttributeName: [UIFont systemFontOfSize:12]} context:nil];
            btnWidth = rect.size.width;
        }else{
            CGSize size = [titleName sizeWithFont:[UIFont systemFontOfSize:12]];
            btnWidth = size.width;
        }
    }
    animateImgV = [[UIImageView alloc]initWithFrame:CGRectMake(10, 6, 13, 17)];
    animateImgV.image = [UIImage imageNamed:@"broadcast_04"];
    animateImgV.animationImages = [NSArray arrayWithObjects:[UIImage imageNamed:@"broadcast_01"], [UIImage imageNamed:@"broadcast_02"], [UIImage imageNamed:@"broadcast_03"], [UIImage imageNamed:@"broadcast_04"], nil];
    animateImgV.backgroundColor = [UIColor clearColor];
    animateImgV.animationDuration = 1.0f;
    [self addSubview:animateImgV];
    
    
    if (big) {
        [self setBackgroundImage:[[UIImage imageNamed:@"sound_background_big"] resizableImageWithCapInsets:UIEdgeInsetsMake(0, 30, 0, 30)] forState:UIControlStateNormal];
        self.frame = CGRectMake(0, 0, btnWidth + CGRectGetMaxX(animateImgV.frame) + 25 > 80 ? (btnWidth + CGRectGetMaxX(animateImgV.frame) + 25) : 80, 39.5f);
        animateImgV.frame = CGRectMake(10, 11, 13, 17);
    }else
    {
        [self setBackgroundImage:[[UIImage imageNamed:@"sound_background_small"] resizableImageWithCapInsets:UIEdgeInsetsMake(0, 20, 0, 20)] forState:UIControlStateNormal];
        self.frame = CGRectMake(0, 0, btnWidth + CGRectGetMaxX(animateImgV.frame) + 25 > 60 ? (btnWidth + CGRectGetMaxX(animateImgV.frame) + 25) : 60, 28);
    }
    
    
    self.titleLabel.font = [UIFont systemFontOfSize:12];
    [self setTitle:[NSString stringWithFormat:@"%@\"",titleName] forState:UIControlStateNormal];
    [self setTitleEdgeInsets:UIEdgeInsetsMake(0, 8, 0, -8)];
    
    
    
    customerAudio = [HWAudioManager shareAudioManager];
    return self;
}

//
-(void)setSoundBtnUrl:(NSString*)soundUrl andIndex:(NSIndexPath*)index
{
    _soundUrl = soundUrl;
    _index = index;
}

-(void)playSound
{
    [animateImgV startAnimating];
    
    NSLog(@"播放%@ %@",_soundUrl,_index);
}

- (void)setString:(NSString *)title
{
    [self setTitle:[NSString stringWithFormat:@"%@\"",title] forState:UIControlStateNormal];
    if ([title intValue] < 20)
    {
        self.frame = CGRectMake(0, 0, 80, 39.5f);
    }
    else if ([title intValue] >= 20 && [title intValue] <= 60)
    {
        self.frame = CGRectMake(0, 0, 100, 39.5f);
    }
    else
    {
        self.frame = CGRectMake(0, 0, 120, 39.5f);
    }
    
}

- (void)setButtonStatus:(soundStatus)buttonState{
    if (!animateImgV) {
        animateImgV = [[UIImageView alloc]initWithFrame:CGRectMake(10, 6, 13, 17)];
        animateImgV.image = [UIImage imageNamed:@"broadcast_04"];
        animateImgV.animationImages = [NSArray arrayWithObjects:[UIImage imageNamed:@"broadcast_01"], [UIImage imageNamed:@"broadcast_02"], [UIImage imageNamed:@"broadcast_03"], [UIImage imageNamed:@"broadcast_04"], nil];
        animateImgV.backgroundColor = [UIColor clearColor];
        animateImgV.animationDuration = 1.0f;
        [self addSubview:animateImgV];
    }
    
    if (buttonState == buttonStatusPlay){
        [animateImgV startAnimating];
    }else if (buttonState == buttonStatusPause){
        [animateImgV stopAnimating];
    }else{
        [animateImgV stopAnimating];
    }
}


//覆盖父类的方法,取消高亮状态

//返回图片的frame
//-(CGRect)imageRectForContentRect:(CGRect)contentRect
//{
//    return CGRectMake(10, 5, 13, 17);
//}

//返回标题的frame
//-(CGRect)titleRectForContentRect:(CGRect)contentRect
//{
//    return CGRectMake(10 + 17, 6, contentRect.size.width, 15);
//}
/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
