//
//  UIBezierPath+ZJText.m
//  Path
//
//  Created by Nick on 15-1-30.
//  Copyright (c) 2015年 onebyte. All rights reserved.
// 

#import "UIBezierPath+ZJText.h"
#import <CoreText/CoreText.h>

@implementation UIBezierPath (ZJText)

+(UIBezierPath *)zjBezierPathWithText:(NSString *)text attributes:(NSDictionary *)attrs;
{
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
            NSLog(@"%ld",runGlyphIndex);
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
