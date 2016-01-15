//
//  HWPerpotyComplaintCellSubV2.m
//  Community
//
//  Created by niedi on 15/6/19.
//  Copyright (c) 2015年 caijingpeng. All rights reserved.
//

#import "HWPerpotyComplaintCellSubV2.h"
#import "HWPersonDynamicCustomBackGroundView.h"

@interface HWPerpotyComplaintCellSubV2 ()
{
    NSString *_title;
    NSString *_content;
    
    DImageV *_line;
}
@end

@implementation HWPerpotyComplaintCellSubV2

- (instancetype)initWith:(NSString *)title content:(NSString *)content
{
    if (self = [super initWithFrame:CGRectMake(0, 0, kScreenWidth, 109.5f)])
    {
        _title = title;
        _content = content;
        [self loadSubView];
    }
    return self;
}

- (void)loadSubView
{
    DLable *lab = [DLable LabTxt:_title txtFont:TF13 txtColor:THEME_COLOR_TEXT frameX:25 y:15 w:kScreenWidth - 2 * 20 h:13];
    [self addSubview:lab];
    
    HWPersonDynamicCustomBackGroundView *titleView = [[HWPersonDynamicCustomBackGroundView alloc]initWithFrame:CGRectMake(25, CGRectGetMaxY(lab.frame) + 10, kScreenWidth - 25 - 10, 53)];
    [self addSubview:titleView];
    
    [titleView setTopicContent:_content];
    
    _line = [DImageV imagV:@"" frameX:25.0f y:CGRectGetMaxY(titleView.frame) + 18.0f w:kScreenWidth - 25.0f h:0.5f];
    _line.backgroundColor = THEME_COLOR_LINE;
    [self addSubview:_line];
}

- (void)hideButtomLine
{
    _line.hidden = YES;
}

@end
