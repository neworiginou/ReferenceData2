//
//  HWModifyUserInfoView.m
//  Community
//
//  Created by caijingpeng.haowu on 15/1/14.
//  Copyright (c) 2015年 caijingpeng. All rights reserved.
//
//  功能描述：修改用户信息页面 view
//
//  修改记录：
//      姓名         日期               修改内容
//     蔡景鹏     2015-01-14           创建文件
//
//

#import "HWModifyUserInfoView.h"
#import "ModifyPersonInfoTableViewCell.h"
#import "HWCoreDataManager.h"

@interface HWModifyUserInfoView()
{
    NSString *_authStatus;
    BOOL _isWuYeAuth;
}
@end

@implementation HWModifyUserInfoView
@synthesize delegate;

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self)
    {
        [self queryListData];
        [self initialView];
    }
    return self;
}

- (void)queryListData
{
    NSMutableDictionary *parame = [[NSMutableDictionary alloc] init];
    [parame setPObject:[HWUserLogin currentUserLogin].key forKey:@"key"];
    
    HWHTTPRequestOperationManager *manager = [HWHTTPRequestOperationManager manager];
    [manager POST:kMeIndex parameters:parame queue:nil success:^(id responese)
    {
        NSLog(@"%@",responese);
        NSDictionary *dataDict = [responese dictionaryObjectForKey:@"data"];
        _authStatus = [dataDict stringObjectForKey:@"authStatus"];
        
        NSString *applyAddress = [dataDict stringObjectForKey:@"applyAddress"];
        if (applyAddress.length == 0)
        {
            _isWuYeAuth = YES;
        }
        else
        {
            _isWuYeAuth = NO;
        }
        
        NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
        [defaults setObject:[dataDict stringObjectForKey:@"buildingNo"] forKey:kAuthBuildingNo];
        [defaults setObject:[dataDict stringObjectForKey:@"unitNo"] forKey:kAuthUnitNo];
        [defaults setObject:[dataDict stringObjectForKey:@"roomNo"] forKey:kAuthRoomNo];
        [defaults setObject:[dataDict stringObjectForKey:@"applyId"] forKey:kAuthApplyId];
        [defaults synchronize];
        
        [self.baseTable reloadData];
    } failure:^(NSString *code, NSString *error) {
        
    }];
}

#pragma mark -
#pragma mark        Initial View

- (void)initialView
{
    self.isNeedHeadRefresh = NO;
    [self initialHeaderView];
    [self initialFooterView];
}

- (void)initialHeaderView
{
    personInfoView = [[HWPersonInfoHeadView alloc]initWithFrame:CGRectMake(0, 0, kScreenWidth, 90)];
    personInfoView.delegate = self;
    
    self.baseTable.tableHeaderView = personInfoView;
}

- (void)initialFooterView
{
    UIView *view = [[UIView alloc]initWithFrame:CGRectMake(0, 0, self.frame.size.width, 110)];
    view.backgroundColor = [UIColor clearColor];
    
    UIButton *logoutBtn = [[UIButton alloc]initWithFrame:CGRectMake(10, 20, kScreenWidth - 20, 45)];
    [logoutBtn addTarget:self action:@selector(logout) forControlEvents:UIControlEventTouchUpInside];
    [logoutBtn setTitle:@"退出登录" forState:UIControlStateNormal];
    [logoutBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    logoutBtn.layer.cornerRadius = 3.0f;
    logoutBtn.layer.masksToBounds = YES;
    [logoutBtn setBackgroundImage:[Utility imageWithColor:THEME_COLOR_GRAY andSize:logoutBtn.frame.size] forState:UIControlStateNormal];
    [view addSubview:logoutBtn];
    
    self.baseTable.tableFooterView = view;
}

#pragma mark -
#pragma mark        Public Method

- (void)refreshUserInfo
{
    [self queryListData];
    [personInfoView refreshPersonInfo];
    [self.baseTable reloadData];
}

#pragma mark -
#pragma mark        Private Method

- (void)logout
{
    if (delegate && [delegate respondsToSelector:@selector(didSelectLogout)])
    {
        [delegate didSelectLogout];
    }
}

#pragma mark -
#pragma mark        HWPersonInfoHeadView Delegate

- (void)didClickEditHead
{
    if (delegate && [delegate respondsToSelector:@selector(userInfoViewEditHeadPhoto)])
    {
        [delegate userInfoViewEditHeadPhoto];
    }
}

#pragma mark -
#pragma mark        UITableView Delegate DataSource

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *cellIdentifier1 = @"modifyPersonAvatar";
    ModifyPersonInfoTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier1];
    if (!cell)
    {
        cell = [[ModifyPersonInfoTableViewCell alloc]init];
    }
    
    NSInteger row = [indexPath row];
    cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;

    if (indexPath.section == 0)
    {
        if (row == 0)
        {
            cell.catoryLabel.text = @"昵称";
            if ([[HWUserLogin currentUserLogin].nickname length] == 0)
            {
                cell.catroryContentLabel.text = @"无名的考拉";
            }
            else
            {
                cell.catroryContentLabel.text = [HWUserLogin currentUserLogin].nickname;
            }
        }
        else if(row == 1)
        {
            cell.catoryLabel.text = @"性别";
            if ([[HWUserLogin currentUserLogin].gender length] == 0)
            {
                // 默认为保密
                cell.catroryContentLabel.text = @"保密";
                [HWUserLogin currentUserLogin].gender = @"0";
                [HWCoreDataManager saveUserInfo];
            }
            else
            {
                cell.catroryContentLabel.text = [Utility parseGenderByValue:[HWUserLogin currentUserLogin].gender];
            }
        }
        else if(row == 2)
        {
            cell.catoryLabel.text = @"爱好";
            if ([[HWUserLogin currentUserLogin].favorite length] == 0)
            {
                cell.catroryContentLabel.text = @"添加爱好";
            }
            else
            {
                cell.catroryContentLabel.text = [HWUserLogin currentUserLogin].favorite;
            }
        }
        else if (row == 3)
        {
            cell.catoryLabel.text = @"认证";
            //authStatus：0：审核中；1：已审核；2：已认证、3：未认证
            if (_authStatus.length == 0)
            {
                cell.catroryContentLabel.text = @"未认证"; //这个状态不显示此行
            }
            else if ([_authStatus isEqual:@"0"])
            {
                cell.catroryContentLabel.text = @"等待认证";//审核中
                cell.catroryContentLabel.textColor = THEBUTTON_YELLOW_NORMAL;
            }
            else if ([_authStatus isEqual:@"1"])
            {
                cell.catroryContentLabel.text = @"等待认证";//已审核
                cell.catroryContentLabel.textColor = THEBUTTON_YELLOW_NORMAL;
            }
            else if ([_authStatus isEqual:@"2"])
            {
                cell.catroryContentLabel.text = @"已认证";
                cell.catroryContentLabel.textColor = THEBUTTON_GREEN_NORMAL;
                
                [HWUserLogin currentUserLogin].isAuth = @"0";//置为已认证
            }
            else if ([_authStatus isEqual:@"3"])
            {
                cell.catroryContentLabel.text = @"未认证";
            }
        }
    }
    else
    {
        if (row == 0)
        {
            cell.catoryLabel.text = @"微信账号";
            if ([[HWUserLogin currentUserLogin].isBindWeixin isEqualToString:@"1"])
            {
                cell.catroryContentLabel.text = @"已绑定";
            }
            else
            {
                cell.catroryContentLabel.text = @"未绑定";
            }
        }
        else
        {
            cell.catoryLabel.text = @"绑定手机";
//            if ([[HWUserLogin currentUserLogin].isBindMobile isEqualToString:@"1"])
            if([HWUserLogin verifyBindMobileWithPopVC:nil showAlert:NO])
            {
                cell.catroryContentLabel.text = [HWUserLogin currentUserLogin].telephoneNum;
                cell.editing = NO;
                cell.accessoryType = UITableViewCellAccessoryNone;
            }
            else
            {
                cell.catroryContentLabel.text = @"未绑定";
            }
        }
    }
    
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSInteger row = indexPath.row;
    
    if (indexPath.section == 0)
    {
        switch (row)
        {
            case 0:
            {
                if (delegate && [delegate respondsToSelector:@selector(didSelectChangeNickname)])
                {
                    [delegate didSelectChangeNickname];
                }
                break;
                
            }
            case 1:
            {
                if (delegate && [delegate respondsToSelector:@selector(didSelectChangeGender)])
                {
                    [delegate didSelectChangeGender];
                }
                break;
            }
            case 2:
            {
                if (delegate && [delegate respondsToSelector:@selector(didSelectChangeFavorate)])
                {
                    [delegate didSelectChangeFavorate];
                }
                break;
            }
            case 3:
            {
                if (delegate && [delegate respondsToSelector:@selector(didSelectAuthenticate:isWuYeAuth:)])
                {
                    //需要根据认证状态，添加判断。
                    [delegate didSelectAuthenticate:_authStatus isWuYeAuth:_isWuYeAuth];//_authStatus
                }
            }
            default:
                break;
        }
    }
    else
    {
        switch (row)
        {
            case 0:
            {
                [MobClick event:@"click_connet_wechat"]; //maidian_1.2.1
                if (delegate && [delegate respondsToSelector:@selector(didSelectBindWeixin:isBindTel:)])
                {
                    //绑定微信未绑定手机
                    if (![[HWUserLogin currentUserLogin].isBindMobile isEqualToString:@"1"])
                    {
                        [delegate didSelectBindWeixin:self isBindTel:NO];
                    }
                    else
                    {
                        [delegate didSelectBindWeixin:self isBindTel:YES];
                    }
                }
                break;
                
            }
            case 1:
            {
                [MobClick event:@"click_connet_phonenumber"]; //maidian_1.2.1
                if (![HWUserLogin verifyBindMobileWithPopVC:nil showAlert:NO])
                {
                    if (delegate && [delegate respondsToSelector:@selector(didSelectBindMobile)])
                    {
                        [delegate didSelectBindMobile];
                    }
                }

                break;
            }
            default:
                break;
        }
    }
    
    
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 50.0f;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 10.0f;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 2;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    UIView *headerView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, kScreenWidth, 10)];
    headerView.backgroundColor = [UIColor clearColor];
    
    UIView *line = [[UIView alloc] initWithFrame:CGRectMake(0, 10 - 0.5f, kScreenWidth, 0.5f)];
    line.backgroundColor = THEME_COLOR_LINE;
    [headerView addSubview:line];
    
    return headerView;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (section == 0)
    {
        if ([[HWUserLogin currentUserLogin].coStatus isEqualToString:@"0"] && _authStatus != nil)
        {
            return  4;
        }
        else
        {
            return 3;
        }
    }
    
    return 2;
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
