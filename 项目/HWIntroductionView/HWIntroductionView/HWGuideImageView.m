//
//  HWGuideImageView.m
//  HWIntroductionView
//
//  Created by lizhongqiang on 15/11/9.
//  Copyright © 2015年 lizhongqiang. All rights reserved.
//

#import "HWGuideImageView.h"
@interface HWGuideImageView ()
@property (nonatomic, strong)UIImageView *imageView;
@property (nonatomic, strong)UIImageView *imageView_text;
@end
@implementation HWGuideImageView

- (instancetype)initWithFrame:(CGRect)frame{
    if(self = [super initWithFrame:frame]){
        self.imageView = [[UIImageView alloc]initWithFrame:CGRectZero];
        self.imageView_text = [[UIImageView alloc]initWithFrame:CGRectZero];
        //self.imageView.backgroundColor = [UIColor blueColor];
        //self.imageView_text.backgroundColor = [UIColor blackColor];
        self.imageView.contentMode = UIViewContentModeScaleAspectFill;
        self.imageView_text.contentMode = self.imageView.contentMode;
        [self addSubview:_imageView];
        [self addSubview:_imageView_text];
    }
    return self;
}
- (void)layoutSubviews
{
    if(CGRectGetHeight([UIScreen mainScreen].bounds)==480){
        //_imageView.contentMode = UIViewContentModeScaleAspectFit;
        _imageView.center = CGPointMake(CGRectGetWidth(self.frame)/2.0f, 30+277/2.f);
        _imageView.bounds = CGRectMake(0, 0, 277, 277);
        
        _imageView_text.center = CGPointMake(_imageView.center.x, CGRectGetMaxY(_imageView.frame)+60);
        _imageView_text.bounds = CGRectMake(0, 0, 251/2.f, 108/2.f);
        return;
    }
    
    _imageView.center = CGPointMake(CGRectGetWidth(self.frame)/2.0f, 390*CGRectGetHeight(self.frame)/1134);
    _imageView.bounds = CGRectMake(0, 0, 554*(CGRectGetWidth(self.frame)/637), 554*(CGRectGetWidth(self.frame)/637));
    
    _imageView_text.center = CGPointMake(_imageView.center.x, CGRectGetMaxY(_imageView.frame)+118*(CGRectGetHeight(self.frame)/1134)/2.f+90*(CGRectGetHeight(self.frame)/1134));
    _imageView_text.bounds =  CGRectMake(0, 0, 210*(CGRectGetWidth(self.frame)/637), 118*(CGRectGetHeight(self.frame)/1134));
}
- (void)setGuide:(NSString *)Guide
{
    self.imageView.image = [UIImage imageNamed:Guide];
}
- (void)setGuide_Text:(NSString *)Guide_Text{
    self.imageView_text.image = [UIImage imageNamed:Guide_Text];
}
@end
