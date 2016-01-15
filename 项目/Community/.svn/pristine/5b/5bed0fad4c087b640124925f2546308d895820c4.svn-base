//
//  HWModifyGenderView.m
//  Community
//
//  Created by caijingpeng.haowu on 15/1/14.
//  Copyright (c) 2015年 caijingpeng. All rights reserved.
//
//  功能描述：修改性别页面 view
//
//  修改记录：
//      姓名         日期               修改内容
//     蔡景鹏     2015-01-14           创建文件
//
//

#import "HWModifyGenderView.h"
#import "SexTableViewCell.h"
#import "AppDelegate.h"

@implementation HWModifyGenderView
@synthesize delegate;

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self)
    {
        self.isNeedHeadRefresh = NO;
        _listData = [[NSArray alloc]initWithObjects:@"男",@"女",@"保密", nil];
        _selectedGender = [HWUserLogin currentUserLogin].gender;
    }
    return self;
}

#pragma mark -
#pragma mark        Private Method

/**
 *	@brief	请求修改性别接口
 *
 *	@return	
 */
- (void)modifySexRequest
{
    [Utility showMBProgress:self message:@"提交中"];
    
    HWHTTPRequestOperationManager *manager = [HWHTTPRequestOperationManager manager];
    NSMutableDictionary *dict = [NSMutableDictionary dictionary];
    [dict setPObject:_selectedGender forKey:@"sex"];
    [dict setPObject:[HWUserLogin currentUserLogin].key forKey:@"key"];
    //gender(0 ：保密  1：男   2：女)
    [manager POST:kModifySex parameters:dict queue:nil success:^(id responseObject) {
        
        [Utility hideMBProgress:self];
        AppDelegate *appDel = (AppDelegate *)SHARED_APP_DELEGATE;
        [Utility showToastWithMessage:@"修改成功" inView:appDel.window];
        
        [HWUserLogin currentUserLogin].gender = _selectedGender;
        
        if (delegate && [delegate respondsToSelector:@selector(modifyGenderSuccess)])
        {
            [delegate modifyGenderSuccess];
        }
        
    } failure:^(NSString *code, NSString *error) {
        [Utility hideMBProgress:self];
        AppDelegate *appDel = (AppDelegate *)SHARED_APP_DELEGATE;
        [Utility showToastWithMessage:error inView:appDel.window];
    }];
}

#pragma mark -
#pragma mark            UITableView Delegate

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *cellIdentifier1 = @"modifyPersonAvatar";
    
    SexTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier1];
    if (!cell) {
        cell = [[SexTableViewCell alloc]init];
    }
    
    int row = [indexPath row];
    
    cell.sexTitle.text = [_listData objectAtIndex:row];
    if ([ [_listData objectAtIndex:row] isEqualToString:[Utility parseGenderByValue:_selectedGender]])
    {
        cell.gouImageView.hidden = NO;
        cell.accessoryType = UITableViewCellAccessoryCheckmark;
    }
    else
    {
        cell.gouImageView.hidden = YES;
        cell.accessoryType = UITableViewCellAccessoryNone;
    }
    [cell addLine:43.5f isHide:NO];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    return cell;

}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSString *genderStr = [_listData objectAtIndex:[indexPath row]];
    _selectedGender = [Utility parseGenderByString:genderStr];
    
    [self modifySexRequest];
    
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 44.0f;
    
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return  3;
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
