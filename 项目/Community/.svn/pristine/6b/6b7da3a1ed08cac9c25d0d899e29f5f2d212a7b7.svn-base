//
//  HWLikeButton.m
//  Community
//
//  Created by zhangxun on 15/1/19.
//  Copyright (c) 2015年 caijingpeng. All rights reserved.
//

#import "HWLikeButton.h"

@implementation HWLikeButton

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/
- (void)setLike:(BOOL)isLike
{
    if (isLike)
    {
        UIImageView *imageV = [[UIImageView alloc]initWithFrame:CGRectMake(self.imageView.frame.origin.x - 5, self.imageView.frame.origin.y - 5, self.imageView.frame.size.width + 10, self.imageView.frame.size.height + 10)];
        imageV.backgroundColor = [UIColor clearColor];
        imageV.image = [UIImage imageNamed:@"like_hi"];
        imageV.alpha = 0.0f;
        [self addSubview:imageV];
        [UIView animateWithDuration:0.5f animations:^{
            imageV.frame = self.imageView.frame;
            imageV.alpha = 1.0f;
            self.userInteractionEnabled = NO;
        } completion:^(BOOL finished)
        {
            [imageV removeFromSuperview];
            [self setImage:[UIImage imageNamed:@"like_hi"] forState:UIControlStateNormal];
            self.userInteractionEnabled = YES;
        }];
    }
    else
    {
        UIImageView *imageV = [[UIImageView alloc] initWithFrame:self.imageView.frame];
        imageV.backgroundColor = [UIColor clearColor];
        imageV.image = [UIImage imageNamed:@"like_hi"];
        [self addSubview:imageV];
        [UIView animateWithDuration:0.5f animations:^{
            imageV.frame = CGRectMake(imageV.frame.origin.x - 5, imageV.frame.origin.y - 5, imageV.frame.size.width + 10, imageV.frame.size.height + 10);
            imageV.alpha = 0;
            self.userInteractionEnabled = NO;
        } completion:^(BOOL finished) {
            [imageV removeFromSuperview];
            [self setImage:[UIImage imageNamed:@"like"] forState:UIControlStateNormal];
            self.userInteractionEnabled = YES;
        }];
    }
    
}

@end
