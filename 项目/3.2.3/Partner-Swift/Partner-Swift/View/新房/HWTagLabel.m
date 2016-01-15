//
//  HWTagLabel.m
//  MoreHouse
//
//  Created by zhangxun on 14/11/19.
//  Copyright (c) 2014年 lizhongqiang. All rights reserved.
//

#import "HWTagLabel.h"

@implementation HWTagLabel

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

/**
 *	@brief	tagLabe
 *
 *	@param 	frame 	frame，大小，resize=YES的时候会自适应size，可空
 *	@param 	font 	字体 不可空
 *	@param 	resize 	是否自适应大小，不可空（对于固定大小的控件请传NO）
 *
 *	@return	适配好的label
 */
- (id)initWithFrame:(CGRect)frame text:(NSString *)string Font:(UIFont *)font isAutoResize:(BOOL)resize
{
    self = [super initWithFrame:frame];
    if (self) {
        self.text = string;
        self.font = font;
        self.textAlignment = NSTextAlignmentCenter;
        self.layer.cornerRadius = 2;
        self.clipsToBounds = YES;
        
        if (resize) {
            [self sizeToFit];
            self.frame = CGRectMake(frame.origin.x, frame.origin.y, self.frame.size.width + 6, self.frame.size.height+ 6);
            self.layer.borderWidth = 1.0f;
        }else{
            self.layer.borderWidth = 1.0f;
        }
    }
    return self;
}

- (void)setColor:(UIColor *)color{
    self.textColor = color;
    self.layer.borderColor = color.CGColor;
}



- (void)setString:(NSString *)string
{
    self.text = string;
    if (string.length > 0) {
        [self sizeToFit];
        self.frame = CGRectMake(self.frame.origin.x, self.frame.origin.y, self.frame.size.width + 7, self.frame.size.height + 2);
    }
}

- (id)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self){
        
    }
    return self;
}

@end
