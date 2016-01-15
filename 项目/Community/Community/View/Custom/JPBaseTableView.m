//
//  JPBaseTableView.m
//  Community
//
//  Created by caijingpeng.haowu on 14-12-12.
//  Copyright (c) 2014年 caijingpeng. All rights reserved.
//

#import "JPBaseTableView.h"

#define END_VIEW_HEIGHT     60

@implementation JPBaseTableView

@synthesize endFooterView;
@synthesize showEndFooterView;

- (id)init
{
    self = [super init];
    if (self)
    {
        [self createEndFooterView];
    }
    return self;
}

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self)
    {
        [self createEndFooterView];
    }
    return self;
}

- (id)initWithFrame:(CGRect)frame style:(UITableViewStyle)style
{
    self = [super initWithFrame:frame style:style];
    if (self)
    {
        [self createEndFooterView];
    }
    return self;
}

- (void)setTableHeaderView:(UIView *)tableHeaderView
{
    [super setTableHeaderView:tableHeaderView];
    [self createEndFooterView];
}

- (void)setTableFooterView:(UIView *)tableFooterView
{
    [super setTableFooterView:tableFooterView];
    [self createEndFooterView];
}

- (void)reloadData
{
    [super reloadData];
    [self createEndFooterView];
}

- (void)setShowEndFooterView:(BOOL)isShow
{
    showEndFooterView = isShow;
    [self reloadData];
}

- (void)createEndFooterView
{
    CGFloat height = MAX(self.contentSize.height, self.frame.size.height);
    
    if (nil == endFooterView)
    {
        endFooterView = [[UIView alloc] initWithFrame:CGRectMake(0, height, self.frame.size.width, END_VIEW_HEIGHT)];
        endFooterView.backgroundColor = [UIColor clearColor];
        
        [self addSubview:endFooterView];
        
        UILabel *endLabel = [[UILabel alloc] initWithFrame:endFooterView.bounds];
        endLabel.backgroundColor =[UIColor clearColor];
        endLabel.textColor = THEME_COLOR_TEXT;
        endLabel.font = [UIFont fontWithName:FONTNAME size:14.0f];
        endLabel.text = @"             没有更多了...";
        endLabel.textAlignment = NSTextAlignmentCenter;
        [endFooterView addSubview:endLabel];
        
        UIImageView *endImgV = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 75 / 2.0f, 64 / 2.0f)];
        endImgV.center = CGPointMake(endFooterView.frame.size.width / 2.0f - 40, endFooterView.frame.size.height / 2.0f);
        endImgV.image = [UIImage imageNamed:@"the_end"];
        [endFooterView addSubview:endImgV];
    }
    else
    {
        endFooterView.frame = CGRectMake(0, height, CGRectGetWidth(endFooterView.frame), CGRectGetHeight(endFooterView.frame));
    }
    
    endFooterView.hidden = !showEndFooterView;
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
