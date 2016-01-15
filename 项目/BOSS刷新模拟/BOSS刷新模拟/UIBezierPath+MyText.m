//
//  UIBezierPath+MyText.m
//  BOSS刷新模拟
//
//  Created by lizhongqiang on 16/1/12.
//  Copyright © 2016年 lizhongqiang. All rights reserved.
//

#import "UIBezierPath+MyText.h"
#import <CoreText/CoreText.h>
#import <objc/runtime.h>

@implementation UIBezierPath (MyText)
uint tag = 0;
uint numberTag =1;
+ (NSMutableArray *)layers{
    return objc_getAssociatedObject(self, &tag);
}

+ (void)setLayers:(NSMutableArray *)layers{
    objc_setAssociatedObject(self, &tag, layers, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}
+ (void)setNumber:(CGFloat)number{
    objc_setAssociatedObject(self, &numberTag, @(number), OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}
+  (CGFloat)number{
    return  [objc_getAssociatedObject(self, &numberTag) floatValue];
}
+(UIBezierPath *)bezierPathWithText:(NSString *)text attributes:(NSDictionary *)attrs;
{
    UIBezierPath.layers = [NSMutableArray array];
    //NSLog(@"%u",CTGetCoreTextVersion());//获取当前Core Text framework的版本号
    if (&CTGetCoreTextVersion != NULL && CTGetCoreTextVersion() >= kCTVersionNumber10_5) {
        // CoreText API is available
        NSLog(@"%u",CTGetCoreTextVersion());
    }
    NSAssert(text!= nil && attrs != nil, @"参数不能为空");
    
    NSAttributedString *attrStrs = [[NSAttributedString alloc] initWithString:text
                                                                   attributes:attrs];
    CGMutablePathRef paths = CGPathCreateMutable();//初始化路径容器
    CTLineRef line = CTLineCreateWithAttributedString((CFAttributedStringRef)attrStrs);
    CFArrayRef runArray = CTLineGetGlyphRuns(line);
    
    for (CFIndex runIndex = 0; runIndex < CFArrayGetCount(runArray); runIndex++)
    {
        CTRunRef run = (CTRunRef)CFArrayGetValueAtIndex(runArray, runIndex);//获取每个属性单词
        CTFontRef runFont = CFDictionaryGetValue(CTRunGetAttributes(run), kCTFontAttributeName);//获取每个单词的字体
        
        for (CFIndex runGlyphIndex = 0; runGlyphIndex < CTRunGetGlyphCount(run); runGlyphIndex++)
        {//获取单词的每一个字符的路径
            CFRange thisGlyphRange = CFRangeMake(runGlyphIndex, 1);//设置当前需要设置的图形范围
            CGGlyph glyph;
            CGPoint position;
            CTRunGetGlyphs(run, thisGlyphRange, &glyph);//在图形单元run中获得指定范围的图形
            CTRunGetPositions(run, thisGlyphRange, &position);
            {
                
                
                CGPathRef path = CTFontCreatePathForGlyph(runFont, glyph, NULL);
                CGAffineTransform t = CGAffineTransformMakeTranslation(position.x, position.y);
                //设置路径需要移动到的位置
                CGPathAddPath(paths, &t,path);//路径从path1加到paths之前，先将paths平移t
                CAShapeLayer *layers = [CAShapeLayer layer];
                layers.path = path;
                
                CGFloat offset;
                CGFloat retoffset = CTLineGetOffsetForStringIndex(line,runGlyphIndex,&offset);
//                if (runGlyphIndex == 0) {
//                    layers.frame = CGPathGetBoundingBox(path);
//                }else{
                    layers.frame =  CGRectMake(retoffset, 0, CGRectGetWidth(CGPathGetBoundingBox(path)), CGRectGetHeight(CGPathGetBoundingBox(path)));
              //  }
//                UIBezierPath.number =CGRectGetWidth(CGPathGetBoundingBox(paths)) ;
              
                //获取整段文字中charIndex位置的字符相对line的原点的x值
                
//                NSLog(@"return offset = %f",retoffset);
//                NSLog(@"output offset = %f",offset);
                UIBezierPath.number =offset ;
                [UIBezierPath.layers addObject:layers];
                CGPathRelease(path);
                
                
            }
        }
    }
    CFRelease(line);
    
    UIBezierPath *path = [UIBezierPath bezierPath];
    [path moveToPoint:CGPointZero];
    [path appendPath:[UIBezierPath bezierPathWithCGPath:paths]];
    
    CGPathRelease(paths);
    
    return path;
}
@end
