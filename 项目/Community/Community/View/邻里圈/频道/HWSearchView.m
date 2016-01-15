//
//  HWSearchView.m
//  Community
//
//  Created by hw500028 on 15/1/13.
//  Copyright (c) 2015年 caijingpeng. All rights reserved.
//  功能描述:搜索视图的父视图
//      姓名         日期               修改内容
//     杨庆龙     2015-01-15           创建文件

#import "HWSearchView.h"

@interface HWSearchView()

@end
@implementation HWSearchView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {

        [self setValue:self.searchListTableView forKey:@"searchListTableView"];
    }
    return self;
}

- (HWSearchListTableView *)searchListTableView
{
    if (_searchListTableView == nil) {
        _searchListTableView = [[HWSearchListTableView alloc]initWithFrame:CGRectMake(0, 64 * kScreenRate, kScreenWidth, CONTENT_HEIGHT - 217)];
        _searchListTableView.backgroundColor = BACKGROUND_COLOR;
        _searchListTableView.baseTable.scrollsToTop = NO;
        [self addSubview:_searchListTableView];
    }
    return _searchListTableView;
}

- (void)setHidden:(BOOL)hidden
{
    [super setHidden:hidden];
    self.searchListTableView.isShow = hidden;

}

@end
