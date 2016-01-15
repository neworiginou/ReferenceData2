//
//  HWCustomSegmentControl.m
//  Community
//
//  Created by wuxiaohong on 15/1/15.
//  Copyright (c) 2015年 caijingpeng. All rights reserved.
//

#import "HWCustomSegmentControl.h"
#define ITEM_WIDTH      350/2
#define SEGMENT_RADIUS  12.5f
#define BORDER_WIDTH    1.0f
#define BUTTON_TAG      1001

@implementation HWCustomSegmentControl
@synthesize selectedIndex;
@synthesize delegate;
- (id)initWithTitles:(NSArray *)titleArr fram:(CGRect)fram;
{
    if (titleArr.count == 0)
    {
        return nil;
    }
    
    self = [super initWithFrame:fram];
    if (self)
    {
        buttons = [NSMutableArray array];
        
        self.layer.cornerRadius = 15 / 2.0f;
        self.layer.borderColor = THEME_COLOR_ORANGE.CGColor;
        self.layer.borderWidth = BORDER_WIDTH;
        self.layer.masksToBounds = YES;
        
        self.backgroundColor = THEME_COLOR_ORANGE;
        
        for (int i = 0; i < titleArr.count; i++)
        {
            int width =fram.size.width/2 ;
            
            UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
            [button setFrame:CGRectMake(i * fram.size.width/2, 0, width, self.frame.size.height)];
            button.titleLabel.font = [UIFont fontWithName:FONTNAME size:THEME_FONT_SMALLTITLE];
            
            if (i == 0)
            {
                // 激活状态//THEME_COLOR_GREEN_NORMAL
                button.backgroundColor = [UIColor clearColor];
                [button setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
            }
            else
            {
                button.backgroundColor = [UIColor whiteColor];
                [button setTitleColor:THEME_COLOR_ORANGE forState:UIControlStateNormal];
            }
            button.tag = BUTTON_TAG + i;
            [button setTitle:[titleArr objectAtIndex:i] forState:UIControlStateNormal];
            [button addTarget:self action:@selector(doSelectItem:) forControlEvents:UIControlEventTouchUpInside];
            [self addSubview:button];
            
            //            if (i != titleArr.count - 1)
            //            {
            //                UIView *line = [[UIView alloc] initWithFrame:CGRectMake((i + 1) * ITEM_WIDTH, 0, BORDER_WIDTH, self.frame.size.height)];
            //                line.backgroundColor = [UIColor greenColor];
            //                [self addSubview:line];
            //            }
            
            [buttons addObject:button];
            
        }
        
        selectedIndex = 0;
        
    }
    
    return self;//THEME_COLOR_GREEN_NORMAL
}

- (void)setSelectedIndex:(int)aSelectedIndex
{
    UIButton *preSelBtn = [buttons objectAtIndex:selectedIndex];
    preSelBtn.backgroundColor = [UIColor whiteColor];
    [preSelBtn setTitleColor:THEME_COLOR_ORANGE forState:UIControlStateNormal];
    
    UIButton *selBtn = [buttons objectAtIndex:aSelectedIndex];
    selBtn.backgroundColor = [UIColor clearColor];
    [selBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    
    selectedIndex = aSelectedIndex;
}

- (void)doSelectItem:(UIButton *)sender
{
    self.selectedIndex = sender.tag % BUTTON_TAG;
    if (delegate && [delegate respondsToSelector:@selector(segmentControl:didSelectSegmentIndex:)])
    {
        [delegate segmentControl:self didSelectSegmentIndex:self.selectedIndex];
    }
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
