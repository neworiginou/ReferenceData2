//
//  DImageV.m
//  DView
//
//  Created by niedi on 15/6/5.
//  Copyright (c) 2015年 haowu. All rights reserved.
//

#import "DImageV.h"
#import "Ddefine.h"

@implementation DImageV

+ (DImageV *)imagV
{
    return [[self alloc] init];
}


/** imageName frame */
+ (DImageV *)imagV:(NSString *)imageName frameX:(CGFloat)x y:(CGFloat)y w:(CGFloat)w h:(CGFloat)h
{
    return [[self imagV] imagV:imageName frameX:x y:y w:w h:h];
}


- (DImageV *)imagV:(NSString *)imageName frameX:(CGFloat)x y:(CGFloat)y w:(CGFloat)w h:(CGFloat)h
{
    self.frame = CGRectMake(x, y, w, h);
    if (imageName)
    {
        self.image = [UIImage imageNamed:imageName];
    }
    
    return self;
}


- (void)setRadius:(CGFloat)radius
{
    self.layer.cornerRadius = radius;
    self.layer.masksToBounds = YES;
    
}













@end
