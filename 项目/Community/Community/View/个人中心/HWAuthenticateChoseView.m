//
//  HWAuthenticateChoseView.m
//  Community
//
//  Created by niedi on 15/8/4.
//  Copyright (c) 2015年 caijingpeng. All rights reserved.
//

#import "HWAuthenticateChoseView.h"
#import "HWAuthenticateChoseCell.h"

@interface HWAuthenticateChoseView ()
{
    NSArray *_titleArr;
}
@end

@implementation HWAuthenticateChoseView

- (instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame])
    {
        self.isNeedHeadRefresh = NO;
        [self initData];
    }
    return self;
}

- (void)initData
{
    _titleArr = @[@"明信片认证", @"物业认证"];
    [self.baseTable reloadData];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return _titleArr.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSString *cellID = @"cellID";
    HWAuthenticateChoseCell *cell = [tableView dequeueReusableCellWithIdentifier:cellID];
    if (self)
    {
        cell = [[HWAuthenticateChoseCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellID];
    }
    
    [cell fillDataWithLeftStr:[_titleArr pObjectAtIndex:indexPath.row]];
    
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return [HWAuthenticateChoseCell getHeight];
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    if (self.delegate && [self.delegate respondsToSelector:@selector(cellClickForRow:)])
    {
        [self.delegate cellClickForRow:indexPath.row];
    }
}

@end
