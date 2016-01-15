//
//  AnimationView.m
//  BOSS刷新模拟
//
//  Created by lizhongqiang on 16/1/8.
//  Copyright © 2016年 lizhongqiang. All rights reserved.
//

#import "AnimationView.h"

#define Radius 4
#define Color1 [UIColor colorWithRed:71/255.f green:192/255.f blue:182/255.f alpha:1.0]
#define Color1WithAlpha(value) [UIColor colorWithRed:71/255.f green:192/255.f blue:182/255.f alpha:value]
#define Color2 [UIColor colorWithRed:231/255.f green:69/255.f blue:61/255.f alpha:1.0]
#define Color3 [UIColor colorWithRed:77/255.f green:195/255.f blue:80/255.f alpha:1.0]
#define Color4 [UIColor colorWithRed:253/255.F green:158/255.F blue:49/255.F alpha:1.0]
#define InitShapeLayer(object,tag,color,point,offY)\
\
if(contentOffY<=-offY){\
if(object == nil){\
    object = [self layer:tag backgroundColor:color center:point];\
switch (tag) {\
case 200:\
object.type = Left;\
break;\
case 300:\
object.type = Bottom;\
break;\
case 400:\
object.type = Right;\
break;\
}\
}\
[self.layer insertSublayer:object below:self.shapeLayer];\
}else{\
    [object removeFromSuperlayer];\
}


#define Speed 4
@interface AnimationView()
{
    CGFloat _oldY;
}
@property (nonatomic, strong)CAShapeLayer *shapeLayer;
@property (nonatomic, strong)MyLayer *firstLayer;
@property (nonatomic, strong)MyLayer *secondLayer;
@property (nonatomic, strong)MyLayer *thirdLayer;
@property (nonatomic, strong)MyLayer *forthLayer;
@property (nonatomic, strong)CABasicAnimation *animation;
@end
@implementation AnimationView
@synthesize firstLayer;
@synthesize secondLayer;
@synthesize thirdLayer;
@synthesize forthLayer;
- (instancetype)initWithFrame:(CGRect)frame{
    if(self = [super initWithFrame:frame]){
        
        [self setUp];
    }
    return self;
}
- (void)setUp{
    self.shapeLayer = [CAShapeLayer layer];//
    self.shapeLayer.fillColor =CustomColor(@"71#192#192").CGColor;//CustomColor(@"71#192#192").CGColor;//[UIColor colorWithRed:71/255.f green:192/255.f blue:192/255.f alpha:1.0].CGColor;
    UIBezierPath *path = [UIBezierPath bezierPathWithArcCenter:CGPointMake(CGRectGetWidth(self.frame)/2, Radius) radius:Radius startAngle:0 endAngle:M_PI*2 clockwise:1];
    self.shapeLayer.path = path.CGPath;
    [self.layer addSublayer:self.shapeLayer];
}
UIBezierPath * myPath(CGPoint point1,CGPoint point2,CGFloat radius){
    UIBezierPath *path = [UIBezierPath bezierPath];
    [path addArcWithCenter:point1 radius:radius startAngle:M_PI/4 endAngle:M_PI*5/4 clockwise:YES];
    CGFloat offset = radius*sinf(M_PI/4);
    [path addLineToPoint:CGPointMake(point2.x-offset, point2.y-offset)];
    [path addArcWithCenter:point2 radius:radius startAngle:M_PI*5/4 endAngle:M_PI/4 clockwise:YES];
    [path addLineToPoint:CGPointMake(point1.x+offset, point1.y+offset)];//
    return path;
}
UIBezierPath * secondPath(CGPoint point1,CGPoint point2,CGFloat radius){
    UIBezierPath *path = [UIBezierPath bezierPath];
    [path addArcWithCenter:point1 radius:radius startAngle:M_PI*3/4 endAngle:M_PI*7/4 clockwise:YES];
    CGFloat offset = radius*sinf(M_PI/4);
    [path addLineToPoint:CGPointMake(point2.x+offset, point2.y-offset)];
    [path addArcWithCenter:point2 radius:radius startAngle:M_PI*7/4 endAngle:M_PI*3/4 clockwise:YES];
    [path addLineToPoint:CGPointMake(point1.x-offset, point1.y+offset)];//
    return path;
}
- (void)refreshAnimationView:(CGFloat)contentOffY{
    if(self.animationStart){
        return;
    }

    CGPoint end = CGPointMake(CGRectGetWidth(self.frame)/2, Radius);
    CGPoint start;
    CGFloat minY = 98;//---123
    
    InitShapeLayer(secondLayer,200, Color2, CGPointMake(Radius, CGRectGetHeight(self.frame)/2), (minY+14/Speed));//minY+14.5/Speed
    InitShapeLayer(thirdLayer, 300, Color3, CGPointMake(CGRectGetWidth(self.frame)/2, CGRectGetHeight(self.frame)-Radius), (minY+28/Speed));//minY+30/Speed
    InitShapeLayer(forthLayer, 400, Color4, CGPointMake(CGRectGetWidth(self.frame)-Radius, CGRectGetHeight(self.frame)/2), (minY+42/Speed));//minY+44/Speed
    
    
#pragma mark --------------------------
    CGFloat offsetX = 2*Radius*cosf(M_PI/4);
    
    if(contentOffY<-minY){
        contentOffY = Speed*(contentOffY+minY);
        
        self.shapeLayer.fillColor = Color1.CGColor;
        start = CGPointMake(end.x+contentOffY, end.y-contentOffY);
        if (start.x<=Radius+offsetX) {
            start = CGPointMake(Radius, CGRectGetHeight(self.frame)/2.f);
        }
        self.shapeLayer.fillColor = Color1.CGColor;
    }else {
        
        start = CGPointMake(end.x, Radius);
        if(self.firstLayer){
            [self.firstLayer removeFromSuperlayer];
        }
        if(_oldY>contentOffY){
            self.shapeLayer.fillColor = Color1WithAlpha(1).CGColor;
        }else{
            self.shapeLayer.fillColor = Color1WithAlpha(-1*(contentOffY+91)/8).CGColor;//;
        }
        
        _oldY = contentOffY;
    }
    if(start.x - Radius <= 0){
        if (self.firstLayer == nil) {
            self.firstLayer = [self layer:minY backgroundColor:Color1 center:end];
            self.firstLayer.type = Top;
        }
        [self.layer insertSublayer:self.firstLayer below:self.shapeLayer];
    }else{
        [self.firstLayer removeFromSuperlayer];
    }
    if(start.x-Radius<=0)
    {
        CGPoint point0 = CGPointMake(end.x+contentOffY, end.y-contentOffY);
        end = CGPointMake(point0.x+CGRectGetWidth(self.frame)/2-Radius-offsetX,point0.y-CGRectGetHeight(self.frame)/2+Radius+offsetX);
        start = CGPointMake(Radius, CGRectGetHeight(self.frame)/2.f);
        
        CGFloat offset = 14;
#if 1
        
        if (end.x-Radius<0) {
            
            end = start;
            start = CGPointMake(end.x-contentOffY-offset, end.y-contentOffY-offset);
            
            if(start.y+Radius+offsetX>=CGRectGetHeight(self.frame)){
                start = CGPointMake(CGRectGetWidth(self.frame)/2, CGRectGetHeight(self.frame)-Radius);
                end = CGPointMake(end.x-contentOffY-offset-start.x+Radius+offsetX, end.y-contentOffY-offset-CGRectGetHeight(self.frame)/2+Radius+offsetX);
#if 1
                offset = 28;
                if(end.y+Radius>CGRectGetHeight(self.frame)){
                    end = start;
                    start = CGPointMake(start.x-contentOffY-offset, start.y+contentOffY+offset);
                    if(start.x+Radius+offsetX>=CGRectGetWidth(self.frame)){
                        start = CGPointMake(CGRectGetWidth(self.frame)-Radius, CGRectGetHeight(self.frame)/2);
                        end = CGPointMake(end.x-contentOffY-offset-CGRectGetWidth(self.frame)/2+Radius+offsetX, end.y+contentOffY+offset+CGRectGetHeight(self.frame)/2-Radius-offsetX);
                        offset = 42;
                        
                        if (end.x+Radius>=CGRectGetWidth(self.frame)) {
                            end = CGPointMake(CGRectGetWidth(self.frame)-Radius, CGRectGetHeight(self.frame)/2);
                            
                            start = CGPointMake(end.x+contentOffY+offset, end.y+contentOffY+offset);
                            if(start.y - Radius-offsetX<=0){
                                end = CGPointMake(start.x+CGRectGetWidth(self.frame)/2-Radius-offsetX, start.y+CGRectGetWidth(self.frame)/2-Radius-offsetX);
                                start = CGPointMake(CGRectGetWidth(self.frame)/2, Radius);
                                if(end.y<=Radius){
                                    end = CGPointMake(CGRectGetWidth(self.frame)/2.f, Radius);
                                    self.shapeLayer.fillColor = Color1.CGColor;
                                    self.shapeLayer.path = secondPath(start, end, Radius).CGPath;
                                    return;
                                }
                            }
                            self.shapeLayer.fillColor = Color4.CGColor;
                            self.shapeLayer.path = secondPath(start, end, Radius).CGPath;
                            
                            return;
                        }
                        
                    }
                    self.shapeLayer.fillColor = Color3.CGColor;
                    self.shapeLayer.path = myPath(end, start, Radius).CGPath;
                    
                    return;
                }
#endif
            }
            
            self.shapeLayer.path = secondPath(end, start, Radius).CGPath;
            self.shapeLayer.fillColor = Color2.CGColor;
            return;
        }
       #endif
    }

    
    self.shapeLayer.path = myPath(start, end, Radius).CGPath;
    
    //self.shapeLayer.path = path.CGPath;
    
    
}
- (MyLayer *)layer:(int)tag backgroundColor:(UIColor *)color center:(CGPoint)point{
    MyLayer *layer = [MyLayer layer];
    layer.tag = tag;
    UIBezierPath *path = [UIBezierPath bezierPath];
    [path addArcWithCenter:point radius:Radius startAngle:0 endAngle:M_PI*2 clockwise:0];
    layer.fillColor = color.CGColor;
    layer.path = path.CGPath;
    return layer;
}
- (CABasicAnimation *)animation{
    if(_animation == nil){
        _animation = [CABasicAnimation animationWithKeyPath:@"transform.rotation.z"];
        _animation.toValue = @(M_PI*2);
        _animation.duration = 1;
        _animation.repeatCount = CGFLOAT_MAX;
    }
    return _animation;
}
- (void)startAnimations{
    if (firstLayer) {
        [firstLayer animationStart];
        self.shapeLayer.hidden = YES;
    }
    if (secondLayer) {
        [secondLayer animationStart];
    }
    if (thirdLayer) {
        [thirdLayer animationStart];
    }
    if (forthLayer) {
        [forthLayer animationStart];
    }
    self.animationStart = YES;
    [self.layer addAnimation:self.animation forKey:@"animation"];
    
}
#if 0
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
    CGContextRef ctx = UIGraphicsGetCurrentContext();
    CGContextSaveGState(ctx);
    CGContextSetFillColorWithColor(ctx, [UIColor colorWithRed:193/255.f green:199/255.f blue:199/255.f alpha:1.0].CGColor);
    CGContextAddRect(ctx, self.bounds);
    CGContextFillPath(ctx);
}
#endif


@end
