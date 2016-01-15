//
//  HWStreamLabelView.m
//  MoreHouse
//
//  Created by caijingpeng.haowu on 14-11-26.
//  Copyright (c) 2014年 lizhongqiang. All rights reserved.
//


#import "HWStreamLabelView.h"
#import "Define-OC.h"
#define TOPMARGIN       0
#define LEFTMARGIN      0
#define EDGE_WIDTH      10
#define EDGE_HEIGHT     5

//#define BUTTON_HEIGHT   40

@implementation HWStreamLabelView

@synthesize itemArray;
@synthesize itemBorderWidth;
@synthesize itemBorderColor;
@synthesize itemBackgroundColor;
@synthesize itemCornerRadius;
@synthesize itemFont;
@synthesize itemTitleColor;

@synthesize betweenMargin;
@synthesize lineMargin;
@synthesize rows;

- (id)initWithItem:(NSArray *)itemArr constrainedFrame:(CGRect)frame constrainedItemSize:(CGSize)size
{
    self = [super initWithFrame:frame];
    if (self)
    {
        constrainedFrame = frame;
        constrainedItemSize = size;
        self.itemArray = itemArr;
        
        // 初始化参数
        self.itemBorderWidth = 1.0f;
        self.itemBorderColor = [UIColor blackColor].CGColor;
        self.itemBackgroundColor = [UIColor clearColor];
        self.itemCornerRadius = 2.0f;
        self.itemFont = [UIFont fontWithName:FONTNAME size:12];
        self.itemTitleColor = [UIColor blackColor];
        self.backgroundColor = [UIColor clearColor];
        
        self.lineMargin = 5;
        self.betweenMargin = 5;
        rows = 0;
    }
    
    
    int x = LEFTMARGIN; // 标记当前插入位置.
    int y = TOPMARGIN;
    
    for (int i = 0 ; i < self.itemArray.count; i++) {
        
        int originX;
        int originY;
        int width; /*按钮宽度*/
        
        NSString *title = [self.itemArray objectAtIndex:i];
        CGSize titleSize = [HWStreamLabelView calculateStringHeight:title font:self.itemFont constrainedSize:CGSizeMake(constrainedItemSize.width - 10, constrainedItemSize.height - 10)];
//        [Utility calculateStringHeight:title font:self.itemFont constrainedSize:CGSizeMake(constrainedItemSize.width - 10, constrainedItemSize.height - 10)];
        //        width = 95; //固定长度
        
        width = titleSize.width + 10;
        if (width + 10 > constrainedFrame.size.width)
        {
            width = constrainedFrame.size.width - 10;
        }
        
        if (self.frame.size.width >= x + width + self.betweenMargin)
        {
            originX = x;
            originY = y;
            
            x = originX + width + self.betweenMargin;
        }
        else
        {
            originX = LEFTMARGIN;
            originY = y + lineMargin + constrainedItemSize.height;
            x = originX + width + betweenMargin;  //
            y = originY;
            rows++;
        }
        
        UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
        btn.titleLabel.numberOfLines = 0;
        btn.titleLabel.lineBreakMode = NSLineBreakByWordWrapping;
        btn.layer.masksToBounds = YES;
        
        
        btn.titleLabel.font = self.itemFont;
        btn.backgroundColor = self.itemBackgroundColor;
        
        [btn setTitle:title forState:UIControlStateNormal];
        [btn setTitleColor:self.itemTitleColor forState:UIControlStateNormal];
        [btn setFrame:CGRectMake(originX, originY, width, constrainedItemSize.height)];
        //        btn.tag = TAG + i;
        //        [btn addTarget:self action:@selector(clickButton:) forControlEvents:UIControlEventTouchUpInside];
        btn.userInteractionEnabled = NO;
        [self addSubview:btn];
    }
    
    CGRect endFrame = self.frame;
    endFrame.size = CGSizeMake(self.frame.size.width, y + constrainedItemSize.height + TOPMARGIN);
    self.frame = endFrame;
    
    return self;
}

+ (CGSize)calculateStringHeight:(NSString *)string font:(UIFont *)font constrainedSize:(CGSize)cSize
{
    if (IOS7)
    {
        NSDictionary *attribute = @{NSFontAttributeName: font};
        CGRect rect = [string boundingRectWithSize:cSize options:NSStringDrawingTruncatesLastVisibleLine | NSStringDrawingUsesLineFragmentOrigin | NSStringDrawingUsesFontLeading attributes:attribute context:nil];
        return rect.size;
    }
    else
    {
        CGSize size = [string sizeWithFont:font constrainedToSize:cSize lineBreakMode:NSLineBreakByWordWrapping];
        return size;
    }
    return CGSizeZero;
}

//streamView.itemBorderColor = THEME_COLOR_NORMAL.CGColor;
//streamView.itemBorderWidth = 1.0f;
//streamView.itemCornerRadius = 2.0f;

- (void)setItemBorderColor:(CGColorRef)itemColor{
    for (UIButton *btn in self.subviews) {
        if ([btn isKindOfClass:[UIButton class]]) {
            btn.layer.borderColor = itemColor;
        }
    }
}

- (void)setItemTitleColor:(UIColor *)itemColor{
    for (UIButton *btn in self.subviews) {
        if ([btn isKindOfClass:[UIButton class]]) {
            [btn setTitleColor:itemColor forState:UIControlStateNormal];
        }
    }
}

- (void)setItemBorderWidth:(float)itemWith{
    for (UIButton *btn in self.subviews) {
        if ([btn isKindOfClass:[UIButton class]]) {
            btn.layer.borderWidth = itemWith;
        }
    }
}

- (void)setItemCornerRadius:(float)itemRadius{
    for (UIButton *btn in self.subviews) {
        if ([btn isKindOfClass:[UIButton class]]) {
            btn.layer.cornerRadius = itemRadius;
        }
    }
}



// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
    // Drawing code
    
    
}


@end
