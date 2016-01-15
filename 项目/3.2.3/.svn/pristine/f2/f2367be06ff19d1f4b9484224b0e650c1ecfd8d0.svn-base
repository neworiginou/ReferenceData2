//
//  STScratchView.m
//  STScratchView
//
//  Created by Sebastien Thiebaud on 12/17/12.
//  Copyright (c) 2012 Sebastien Thiebaud. All rights reserved.
//

#import "STScratchView.h"
@interface STScratchView ()


@property (nonatomic,strong)NSMutableArray *pointsSet;

@end
//速度，即隔离多少个像素取一个点
#define speed 30
//结果，当比例大于多少之后算刮完
#define result 0.3

@implementation STScratchView
@synthesize pointsSet,delegate;

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self setOpaque:NO];
        _sizeBrush = 50.0;
    }
    
    return self;
}

#pragma mark -
#pragma mark CoreGraphics methods

// Will be called every touch and at the first init
- (void)drawRect:(CGRect)rect
{
    [super drawRect:rect];
    
    UIImage *imageToDraw = [UIImage imageWithCGImage:scratchImage];
    [imageToDraw drawInRect:CGRectMake(0.0, 0.0, self.frame.size.width, self.frame.size.height)];
}

// Method to change the view which will be scratched
- (void)setHideView:(UIView *)hideView
{
    CGColorSpaceRef colorspace = CGColorSpaceCreateDeviceGray();
	int bitmapByteCount;
	int bitmapBytesPerRow;

    float scale = [UIScreen mainScreen].scale;
    
    UIGraphicsBeginImageContextWithOptions(hideView.bounds.size, NO, 0);
    [hideView.layer renderInContext:UIGraphicsGetCurrentContext()];
    hideView.layer.contentsScale = scale;
    
    hideImage = UIGraphicsGetImageFromCurrentImageContext().CGImage;
    UIGraphicsEndImageContext();
    
    size_t imageWidth = CGImageGetWidth(hideImage);
    size_t imageHeight = CGImageGetHeight(hideImage);
        
	bitmapBytesPerRow = (imageWidth * 4);
	bitmapByteCount = (bitmapBytesPerRow * imageHeight);
    
    CFMutableDataRef pixels = CFDataCreateMutable(NULL, bitmapByteCount);
    
    contextMask = CGBitmapContextCreate(CFDataGetMutableBytePtr(pixels), imageWidth, imageHeight , 8, imageWidth, colorspace,kCGImageAlphaNone);
    CGDataProviderRef dataProvider = CGDataProviderCreateWithCFData(pixels);

    CGContextSetFillColorWithColor(contextMask, [UIColor blackColor].CGColor);
    CGContextFillRect(contextMask, CGRectMake(0, 0, self.frame.size.width * scale, self.frame.size.height * scale));

    CGContextSetStrokeColorWithColor(contextMask, [UIColor whiteColor].CGColor);
    CGContextSetLineWidth(contextMask, _sizeBrush);
    CGContextSetLineCap(contextMask, kCGLineCapRound);

    CGImageRef mask = CGImageMaskCreate(imageWidth, imageHeight, 8, 8, imageWidth, dataProvider, nil, NO);
    scratchImage = CGImageCreateWithMask(hideImage, mask);
    
    CGImageRelease(mask);
    CGColorSpaceRelease(colorspace);
}

- (void)scratchTheViewFrom:(CGPoint)startPoint to:(CGPoint)endPoint
{
    float scale = [UIScreen mainScreen].scale;

    CGContextMoveToPoint(contextMask, startPoint.x * scale, (self.frame.size.height - startPoint.y) * scale);
	CGContextAddLineToPoint(contextMask, endPoint.x * scale, (self.frame.size.height - endPoint.y) * scale);
	CGContextStrokePath(contextMask);
	[self setNeedsDisplay];
    
}

#pragma mark -
#pragma mark Touch event

- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    [super touchesBegan:touches withEvent:event];
    
    UITouch *touch = [[event touchesForView:self] anyObject];
    currentTouchLocation = [touch locationInView:self];
    _totalCount = 0;
}

- (void)touchesMoved:(NSSet *)touches withEvent:(UIEvent *)event
{
    [super touchesMoved:touches withEvent:event];
    UITouch *touch = [[event touchesForView:self] anyObject];
    CGPoint thePoint = CGPointMake((int)[touch locationInView:self].x, (int)[touch locationInView:self].y);
//    if (!pointsSet) {
//        pointsSet = [NSMutableArray array];
//    }
//    BOOL doAdd = YES;
//    for (int i=0; i<[pointsSet count]; i++) {
//        CGPoint pPoint = [[pointsSet objectAtIndex:i]CGPointValue] ;
//        if ((int)pPoint.x == (int)thePoint.x && (int)pPoint.y == (int)thePoint.y) {
//            
//            doAdd = NO;
//        }
//    }
//    if (doAdd) {
//        [pointsSet addObject:[NSValue valueWithCGPoint:thePoint]];
//    }
//    [pointsSet addObject:[NSValue valueWithCGPoint:thePoint]];
//    NSLog(@"%d",[pointsSet count]);
    
    
    
    
//    if ([touch locationInView:self].x > _theClearFrame.origin.x &&[touch locationInView:self].x < _theClearFrame.origin.x+_theClearFrame.size.width &&[touch locationInView:self].y > _theClearFrame.origin.y&&[touch locationInView:self].y < _theClearFrame.origin.y+_theClearFrame.size.height) {
//        NSLog(@"完成");
//    }
   
    if (!CGPointEqualToPoint(previousTouchLocation, CGPointZero))
    {
        currentTouchLocation = [touch locationInView:self];
    }
    
    previousTouchLocation = [touch previousLocationInView:self];
   
    [self scratchTheViewFrom:previousTouchLocation to:currentTouchLocation];
}

- (void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event
{
    self.userInteractionEnabled = NO;
    [super touchesEnded:touches withEvent:event];
    
    UITouch *touch = [[event touchesForView:self] anyObject];

    if (!CGPointEqualToPoint(previousTouchLocation, CGPointZero))
    {
        previousTouchLocation = [touch previousLocationInView:self];
        [self scratchTheViewFrom:previousTouchLocation to:currentTouchLocation];
    }
    
//    UIImage *nowImage = UIGraphicsGetImageFromCurrentImageContext();
//    UIGraphicsEndImageContext();
    
    
    UIGraphicsBeginImageContext(self.bounds.size);
    
    [self.layer renderInContext:UIGraphicsGetCurrentContext()];
    
    UIImage *image= UIGraphicsGetImageFromCurrentImageContext();
    
    UIGraphicsEndImageContext();
    
    
    int a=0;
    
    for (int i =0; i <= (int)image.size.width; i+=speed) {
        for (int j =0; j <= (int)image.size.height; j+=speed) {
            
//            NSLog(@"%@",[self getPixelColorAtLocation:CGPointMake(i, j) Image:image]);
//            NSLog(@"%d,%d",i,j);
            const CGFloat *components = CGColorGetComponents([self GetCurrentPixelColorAtPoint:CGPointMake(i, j)].CGColor);
            if (components[3]==0.0) {
                _totalCount++;
            }
            a++;
        }
        
    
    }
    
    if (_totalCount / a >result) {
        self.alpha = 0;
        [self.delegate passResult:YES];
        return;
    }
    
//    for (STScratchView *subView in [view subviews]) {
//        if ([subView isKindOfClass:[STScratchView class]]) {
//            UIGraphicsBeginImageContextWithOptions(subView.frame.size, NO, 0.0);
//        }else{
//            UIGraphicsBeginImageContext(subView.frame.size);
//        }
//        [subView.layer renderInContext:UIGraphicsGetCurrentContext()];
//        UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
//        UIGraphicsEndImageContext();
//        [self.delegate passImage:image];
//        
//        
//        
//        
//    }
    NSLog(@"total:%d count:%f",a,_totalCount);
    self.userInteractionEnabled = YES;
}

- (UIColor *) GetCurrentPixelColorAtPoint:(CGPoint)point
{
    unsigned char pixel[4] = {0};
    
    CGColorSpaceRef colorSpace = CGColorSpaceCreateDeviceRGB();
    
    CGContextRef context = CGBitmapContextCreate(pixel, 1, 1, 8, 4, colorSpace, kCGBitmapAlphaInfoMask & kCGImageAlphaPremultipliedLast);
    
    CGContextTranslateCTM(context, -point.x, -point.y);
    
    [self.layer renderInContext:context];
    
    CGContextRelease(context);
    
    CGColorSpaceRelease(colorSpace);
    
//    NSLog(@"pixel: %d %d %d %d", pixel[0], pixel[1], pixel[2], pixel[3]);
    
    UIColor *color = [UIColor colorWithRed:pixel[0]/255.0 green:pixel[1]/255.0 blue:pixel[2]/255.0 alpha:pixel[3]/255.0];
    
    return color;
}

- (void)touchesCancelled:(NSSet *)touches withEvent:(UIEvent *)event
{
    [super touchesCancelled:touches withEvent:event];
}

- (void)calculateOpen{
    
}



- (void)initScratch
{
    currentTouchLocation = CGPointZero;
    previousTouchLocation = CGPointZero;
}

@end
