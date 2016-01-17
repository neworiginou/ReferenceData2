//
//  ImageView.m
//  3DSrollView
//
//  Created by lizhongqiang on 16/1/15.
//  Copyright © 2016年 lizhongqiang. All rights reserved.
//

#import "ImageView.h"
@interface ImageView ()
@property (nonatomic, assign)CGRect myFrame;
@end
@implementation ImageView
- (instancetype)initWithFrame:(CGRect)frame{
    if(self = [super initWithFrame:frame]){
        
        
        self.myFrame = frame;
    }
    return self;
}
- (void)setTag:(NSInteger)tag{
    [super setTag:tag];
}
- (void)setDirection:(MyDirection)direction{
    //if (direction == MyLeft) {
        self.layer.anchorPoint = CGPointMake(0.0, 0.5);
        self.layer.position = CGPointMake(self.myFrame.origin.x, self.layer.position.y);
//    }
//    if(direction == MyRight){
//        self.layer.anchorPoint = CGPointMake(1, 0.5);
//        self.layer.position = CGPointMake(self.myFrame.origin.x+self.frame.size.width, self.layer.position.y);
//    }
    _direction = direction;
}
- (void)currentPageMove:(CGFloat)contentOffX{

    //if (self.direction == MyLeft) {
#if 1
        CGFloat scale = contentOffX/CGRectGetWidth(self.superview.frame);
        CGFloat radius = -M_PI_2*scale;
        CATransform3D transform3D = CATransform3DMakeRotation(radius, 0, 1, 0);
        transform3D.m41 = contentOffX;
        transform3D.m11 =1-sinf(fabs(radius));//1- scale;//
        self.layer.transform = transform3D;
        
#endif

}
- (void)nextPageMove:(CGFloat)contentOffX{
    //NSLog(@"%f",contentOffX);
    [self newPageSetUp];
    //if(self.direction == MyLeft){
        CGFloat scale = contentOffX/CGRectGetWidth(self.superview.frame);
        CATransform3D transform3D = CATransform3DMakeRotation(M_PI_2*(1-scale), 0, 1, 0);
        transform3D.m41 = contentOffX;
        self.layer.transform = transform3D;
   // }
}
- (void)newPageSetUp{
    self.layer.anchorPoint = CGPointMake(1, 0.5);
    self.layer.position = CGPointMake(self.myFrame.origin.x, self.layer.position.y);
}
@end
