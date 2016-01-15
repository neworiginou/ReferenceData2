//
//  WXImageView.m
//  weibo1
//  Copyright (c) 2014年 yang. All rights reserved.
//

#import "WXImageView.h"

@implementation WXImageView

-(id)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        self.userInteractionEnabled = YES;
        UITapGestureRecognizer *tapGesture = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(tapActon:)];
        [self addGestureRecognizer:tapGesture];
    }
    return self;
}

- (void)setTouchBlock:(ImageBlovk)touchBlock{
    if (_touchBlock != touchBlock) {
        _touchBlock = [touchBlock copy];
    }
}
- (void)tapActon:(UITapGestureRecognizer *)tapGesture{
    if (self.touchBlock) {
        _touchBlock();
    }
}


//图片拉伸




@end
