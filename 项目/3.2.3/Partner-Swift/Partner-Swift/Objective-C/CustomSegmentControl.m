//
//  CustomSegmentControl.m
//  TableTest
//
//  Created by caijingpeng.haowu on 14-11-17.
//  Copyright (c) 2014年 caijingpeng.haowu. All rights reserved.
//
//  功能描述：自定义SegementControl
//  修改记录：
//	姓名    日期         修改内容
//  陆晓波  2015-02-15   背景色修改
//  陆晓波  2015-02-27   宏定义修改
//  陆晓波  2015-03-03   添加按钮borderColor，borderWidth

#import "CustomSegmentControl.h"
#import "Define-OC.h"

#define ITEM_WIDTH      85
#define ITEM_WIDTH_SHORT      65
#define SEGMENT_RADIUS  12.5f
#define BORDER_WIDTH    1.0f
#define BUTTON_TAG      1001

@implementation CustomSegmentControl
@synthesize selectedIndex;
@synthesize delegate;

- (id)initWithTitles:(NSArray *)titleArr 
{
    if (titleArr.count == 0)
    {
        return nil;
    }
    else if ([titleArr  isEqual: @[@"动态",@"我的房源",@"我的收藏"]] && (IPHONE4 || IPHONE5))
    {
        self = [super initWithFrame:CGRectMake(0, 0, ITEM_WIDTH_SHORT * titleArr.count, 30)];
    }
    else
    {
        self = [super initWithFrame:CGRectMake(0, 0, ITEM_WIDTH * titleArr.count, 30)];
    }
    
    if (self)
    {
        buttons = [NSMutableArray array];
        self.layer.cornerRadius = 3.0f;
        self.layer.borderColor = CD_MainColor.CGColor;
        self.layer.borderWidth = BORDER_WIDTH;
        self.layer.masksToBounds = YES;
        
        self.backgroundColor = CD_MainColor;
        
        for (int i = 0; i < titleArr.count; i++)
        {
            int width = ITEM_WIDTH;
            int widthShort = ITEM_WIDTH_SHORT;
            UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
            button.layer.borderColor = CD_MainColor.CGColor;
            button.layer.borderWidth = BORDER_WIDTH / 2.0;
            if ([titleArr  isEqual: @[@"动态",@"我的房源",@"我的收藏"]] && (IPHONE4 || IPHONE5))
            {
                [button setFrame:CGRectMake(i * ITEM_WIDTH_SHORT, 0, widthShort, self.frame.size.height)];
            }
            else
            {
                [button setFrame:CGRectMake(i * ITEM_WIDTH, 0, width, self.frame.size.height)];
            }
            button.titleLabel.font = [UIFont fontWithName:FONTNAME size:TITLE_FUBIAOTI_SIZE];
            
            if (i == 0)
            {
                // 激活状态
                button.backgroundColor = [UIColor clearColor];
                [button setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
            }
            else
            {
                button.backgroundColor = [UIColor whiteColor];
                [button setTitleColor:CD_MainColor forState:UIControlStateNormal];
            }
            button.tag = BUTTON_TAG + i;
            [button setTitle:[titleArr objectAtIndex:i] forState:UIControlStateNormal];
            [button addTarget:self action:@selector(doSelectItem:) forControlEvents:UIControlEventTouchUpInside];
            
            
            if ([button.titleLabel.text  isEqual: @"动态"])
            {
                UITapGestureRecognizer *doubleClick = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(doubleClickItem)];
                [doubleClick setNumberOfTapsRequired:2];
                [button addGestureRecognizer:doubleClick];
                doubleClick.delaysTouchesEnded = NO;
            }
            [self addSubview:button];
            
            [buttons addObject:button];
            
        }
        
        selectedIndex = 0;
   
    }
    
    return self;
}

- (void)setSelectedIndex:(int)aSelectedIndex
{
    UIButton *preSelBtn = [buttons objectAtIndex:selectedIndex];
    preSelBtn.backgroundColor = [UIColor whiteColor];
    [preSelBtn setTitleColor:CD_MainColor forState:UIControlStateNormal];
    
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

- (void)doubleClickItem
{
    if (delegate && [delegate respondsToSelector:@selector(doubleClickGestureRecognizer)])
    {
        [delegate doubleClickGestureRecognizer];
    }
}

@end
