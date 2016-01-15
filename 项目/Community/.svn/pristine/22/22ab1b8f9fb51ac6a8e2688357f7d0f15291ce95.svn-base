//
//  GKRecordProgressView.m
//  Camera
//
//  Created by caijingpeng on 13-12-15.
//  Copyright (c) 2013年 caijingpeng. All rights reserved.
//

#import "GKRecordProgressView.h"


@implementation GKRecordProgressView
@synthesize progress,delegate,progressSegments;

- (id)initWithFrame:(CGRect)frame
{
    frame = CGRectMake(frame.origin.x,
                       frame.origin.y,
                       frame.size.width,
                       8);
    
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
        
        self.backgroundColor = [UIColor blackColor];
        
        UIImageView *back = [[UIImageView alloc] initWithFrame:self.bounds];
        back.image = [[UIImage imageNamed:@"camera-progress-background"] stretchableImageWithLeftCapWidth:3 topCapHeight:3];
        [self addSubview:back];
        
        UIImageView *min = [[UIImageView alloc] initWithFrame:CGRectMake(self.frame.size.width/4.5f, 1, 1, 6)];
        min.image = [UIImage imageNamed:@"camera-progress-min"];
        [self addSubview:min];
        
        self.progressSegments = [NSMutableArray array];
        
        headView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 8, 8)];
        headView.backgroundColor = [UIColor whiteColor];
        [self addSubview:headView];
        
        CABasicAnimation *opacity=[CABasicAnimation animationWithKeyPath:@"opacity"];
        
        opacity.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseOut];
        opacity.duration = 1.0f;
        opacity.repeatCount = 999;
        opacity.fromValue = [NSNumber numberWithFloat:1];
        opacity.toValue = [NSNumber numberWithFloat:0];
        [headView.layer addAnimation:opacity forKey:@"opacity"];
        
    }
    return self;
}

- (void)setProgress:(float)p
{
    if (p >= 1) {
        p = 1.0f;
    }
    progress = p;
    
    float value = p * self.frame.size.width;
    float a = 0;
    
    if (progressSegments.count == 0)
    {
        UIView *progressView = [[UIView alloc] initWithFrame:CGRectMake(0, 1, 0, self.frame.size.height - 2)];
        progressView.backgroundColor = [UIColor colorWithRed:53/255.0f green:146/255.0f blue:238/255.0f alpha:0.8];
        [self addSubview:progressView];
        
        [progressSegments addObject:progressView];
    }
    else if (progressSegments.count > 1)
    {
        for (int i = 0; i < progressSegments.count-1; i++) {
            UIView *v = [progressSegments objectAtIndex:i];
            a += 1.0f + v.frame.size.width;
        }
    }
    
    UIView *lastView = [progressSegments lastObject];
    lastView.frame = CGRectMake(lastView.frame.origin.x,
                                lastView.frame.origin.y,
                                value - a,
                                lastView.frame.size.height);
    
    headView.frame = CGRectMake(value,
                                headView.frame.origin.y,
                                headView.frame.size.width,
                                headView.frame.size.height);
    
    if (value > self.frame.size.width/4.5f + headView.frame.size.width)
    {
        if (delegate && [delegate respondsToSelector:@selector(reachMinProgress)]) {
            [delegate reachMinProgress];
        }
    }
    
}

- (void)markSegment
{
    if (progressSegments.count == 0 || self.progress >= 1) {
        return;
    }
    
    float a = 0.0f;
    for (int i = 0; i < progressSegments.count; i++) {
        UIView *v = [progressSegments objectAtIndex:i];
        a += 1.0f + v.frame.size.width;
    }
    
    UIView *progressView = [[UIView alloc] initWithFrame:CGRectMake(a, 1, 0, self.frame.size.height - 2)];
    progressView.backgroundColor = [UIColor colorWithRed:53/255.0f green:146/255.0f blue:238/255.0f alpha:0.8];
    [self addSubview:progressView];
    
    [progressSegments addObject:progressView];
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
