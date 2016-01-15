//
//  NotificationAndTipViewController.m
//  Community
//
//  Created by gusheng on 14-9-8.
//  Copyright (c) 2014年 caijingpeng. All rights reserved.
//

#import "NotificationAndTipViewController.h"

#import "HWCoreDataManager.h"

@interface NotificationAndTipViewController ()

@end

@implementation NotificationAndTipViewController
- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.navigationItem.leftBarButtonItem = [Utility navLeftBackBtn:self action:@selector(backMethod)];
    self.view.backgroundColor = UIColorFromRGB(0xececec);
    self.navigationItem.titleView = [Utility navTitleView:@"消息提醒"];
    [self initialValue];
    [self createDataSource];
    [self createMainView];
}

- (void)initialValue
{
    HWUserLogin *user = [HWUserLogin currentUserLogin];
    valueDic = [NSMutableDictionary dictionary];
    [valueDic setPObject:user.acceptNotify forKey:@"isReceiveMsg"];
    [valueDic setPObject:user.propertyNotify forKey:@"isRecevieWy"];
    [valueDic setPObject:user.shopNotify forKey:@"isRecevieShop"];
    [valueDic setPObject:user.soundNotify forKey:@"isVoice"];
    [valueDic setPObject:user.shakeNotify forKey:@"isShake"];
}

- (void)backMethod
{
    NSString *acceptNotify = [[valueDic stringObjectForKey:@"isReceiveMsg"] isEqualToString:@"1"] ? @"1" : @"0";
    NSString *acceptProperty = [[valueDic stringObjectForKey:@"isRecevieWy"] isEqualToString:@"1"] ? @"1" : @"0";
    NSString *acceptshop = [[valueDic stringObjectForKey:@"isRecevieShop"] isEqualToString:@"1"] ? @"1" : @"0";
    NSString *voice = [[valueDic stringObjectForKey:@"isVoice"] isEqualToString:@"1"] ? @"1" : @"0";
    NSString *shake = [[valueDic stringObjectForKey:@"isShake"] isEqualToString:@"1"] ? @"1" : @"0";
    
    HWHTTPRequestOperationManager *manager = [HWHTTPRequestOperationManager manager];
    NSMutableDictionary *param = [NSMutableDictionary dictionary];
    [param setPObject:[HWUserLogin currentUserLogin].key forKey:@"key"];
    [param setPObject:[HWUserLogin currentUserLogin].userId forKey:@"userId"];
    [param setPObject:acceptNotify forKey:@"isReceiveMsg"];
    [param setPObject:acceptProperty forKey:@"isRecevieWy"];
    [param setPObject:acceptshop forKey:@"isRecevieShop"];
    [param setPObject:voice forKey:@"isVoice"];
    [param setPObject:shake forKey:@"isShake"];
    
    [manager POST:kNotificationSetting parameters:param queue:nil success:^(id responseObject) {
        
        NSLog(@"%@",responseObject);
        NSDictionary *dic = [responseObject dictionaryObjectForKey:@"data"];
        
        HWUserLogin *user = [HWUserLogin currentUserLogin];
        user.acceptNotify = [dic stringObjectForKey:@"isReceiveMsg"];
        user.propertyNotify = [dic stringObjectForKey:@"isRecevieWy"];
        user.shopNotify = [dic stringObjectForKey:@"isRecevieShop"];
        user.soundNotify = [dic stringObjectForKey:@"isVoice"];
        user.shakeNotify = [dic stringObjectForKey:@"isShake"];
        
        [HWCoreDataManager saveUserInfo];
        
    }failure:^(NSString *code, NSString *error){
        NSLog(@"%@",error);
    }];
    
    [self.navigationController popViewControllerAnimated:YES];
}


//创建数据源
-(void)createDataSource
{
    NSArray *arryOne = [NSArray arrayWithObjects:@"消息提醒", nil];
    NSArray *arryTwo = [NSArray arrayWithObjects:@"物业通知",@"商户通知",nil];
    NSArray *arryThree = [NSArray arrayWithObjects:@"声音",@"震动",nil];
    listDataDic = [[NSDictionary alloc]initWithObjectsAndKeys:arryOne,@"arryOne",arryTwo,@"arryTwo",arryThree,@"arryThree", nil];
    
}
//创建主视图
-(void)createMainView
{
    notificationTableView.delegate = self;
    notificationTableView.dataSource = self;
    notificationTableView.scrollEnabled = NO;
    notificationTableView.backgroundColor = [UIColor clearColor];
    [notificationTableView setSeparatorStyle:UITableViewCellSeparatorStyleNone];
    
    notificationTableView.tableFooterView = [self createBotomView];
    notificationTableView.tableHeaderView = [self createHeaderView];
}
//创建head
-(UIView *)createHeaderView
{
    UIView *view = [[UIView alloc]initWithFrame:CGRectMake(0, 0, kScreenWidth, 10)];
    view.backgroundColor = UIColorFromRGB(0xf2f2f2);
    return view;
}
//创建底部视图
-(UIView *)createBotomView
{
    UIView *view = [[UIView alloc]init];
    UILabel *instrumentLabel = [[UILabel alloc]init];
    instrumentLabel.textColor = THEME_COLOR_TEXT;
    view.backgroundColor = [UIColor clearColor];;
    [view setFrame:CGRectMake(0, 0, kScreenWidth, 50)];
    [instrumentLabel setFrame:CGRectMake(13, 10, kScreenWidth - 26, 40)];
    instrumentLabel.numberOfLines = 0;
    CGSize sizeTwo = CGSizeMake(298, 40);
    UIFont *font = [UIFont systemFontOfSize:13.0f];
    NSString *str =  @"当考拉社区运行时，你可以设置是否需要声音或者震动";
    instrumentLabel.text = str;
    [instrumentLabel setFont:font];
    CGSize actualSizeTwo = [str sizeWithFont:font constrainedToSize:sizeTwo lineBreakMode:NSLineBreakByWordWrapping];
    instrumentLabel.frame = CGRectMake(13, 10, 298, actualSizeTwo.height);
    [view addSubview:instrumentLabel];
    return view;
}

#pragma - mark TableViewDelegate
#pragma - mark tableview delegate method
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *cellIdentifier1 = @"NotificationTableViewCell";
    int row = [indexPath row];
    int section = [indexPath section];
    NotificationTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier1];
    if (!cell) {
        cell = [[NotificationTableViewCell alloc]init];
    }
    cell.delegate = self;
    if (section == 0) {
        NSArray *arryOne = [listDataDic objectForKey:@"arryOne"];
        cell.titleLabel.text = [arryOne objectAtIndex:row];
        cell.selectBtn.hidden = YES;
        cell.tipONOrOffLabel.hidden = YES;
        if (row == 0) {
            cell.selectBtn.hidden = YES;
            cell.tipONOrOffLabel.hidden = NO;
            if ([[HWUserLogin currentUserLogin].notificationOnOrOff isEqualToString:@"0"]) {
                cell.tipONOrOffLabel.text = @"关闭";
            }
            else
            {
                cell.tipONOrOffLabel.text = @"开启";
            }
            
        }
    }
    else if(section == 1)
    {
        cell.selectBtn.hidden = NO;
        cell.tipONOrOffLabel.hidden = YES;
        NSArray *arryTwo = [listDataDic objectForKey:@"arryTwo"];
        cell.titleLabel.text = [arryTwo objectAtIndex:row];
        
        if (indexPath.row == 0)
        {
            if ([[valueDic stringObjectForKey:@"isRecevieWy"] isEqualToString:@"1"])
                [cell.selectBtn setOn:YES];
            else
                [cell.selectBtn setOn:NO];
        }
        else if (indexPath.row == 1)
        {
            if ([[valueDic stringObjectForKey:@"isRecevieShop"] isEqualToString:@"1"])
                [cell.selectBtn setOn:YES];
            else
                [cell.selectBtn setOn:NO];
        }
        
    }
    else
    {
        cell.selectBtn.hidden = NO;
        cell.tipONOrOffLabel.hidden = YES;
        NSArray *arryThree = [listDataDic objectForKey:@"arryThree"];
        cell.titleLabel.text = [arryThree objectAtIndex:row];
        
        if (indexPath.row == 0)
        {
            if ([[valueDic stringObjectForKey:@"isVoice"] isEqualToString:@"1"])
                [cell.selectBtn setOn:YES];
            else
                [cell.selectBtn setOn:NO];
        }
        else if (indexPath.row == 1)
        {
            if ([[valueDic stringObjectForKey:@"isShake"] isEqualToString:@"1"])
                [cell.selectBtn setOn:YES];
            else
                [cell.selectBtn setOn:NO];
        }
    }
    [cell addLine:43.5 isHide:NO];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    return cell;
    //}
    
    
}
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 3;
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 44.0f;
    
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (section == 0)
    {
        return [[listDataDic objectForKey:@"arryOne"] count];
    }
    else if(section == 1)
    {
        return [[listDataDic objectForKey:@"arryTwo"] count];
    }
    else
    {
        return [[listDataDic objectForKey:@"arryThree"] count];
    }
}
-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    if (section == 0)
    {
        return 0.0f;
    }
    else if(section == 1)
    {
        return 60.0f;
    }
    else
    {
        return 50.0f;
    }
}
- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    UIView *view = [[UIView alloc] init];
    UILabel *instrumentLabel = [[UILabel alloc]init];
    instrumentLabel.textColor = THEME_COLOR_TEXT;
    view.backgroundColor = THEME_COLOR_TEXTBACKGROUND;
    if (section == 0) {
        return nil;
    }
    else if(section == 1)
    {
        [view setFrame:CGRectMake(0, 0, kScreenWidth, 60)];
        [instrumentLabel setFrame:CGRectMake(13, 10, kScreenWidth - 26, 40)];
        instrumentLabel.numberOfLines = 0;
        CGSize sizeTwo = CGSizeMake(298, 40);
        UIFont *font = [UIFont systemFontOfSize:13.0f];
        NSString *str = @"如果你需要打开或关闭消息通知，请在iPhone的\"设置\"-\"通知\"中找到考拉社区，进行设置";
        instrumentLabel.text = str;
        [instrumentLabel setFont:font];
        CGSize actualSizeTwo = [str sizeWithFont:font constrainedToSize:sizeTwo lineBreakMode:NSLineBreakByWordWrapping];
        instrumentLabel.frame = CGRectMake(13, 10, 298, actualSizeTwo.height);
        
    }
    else
    {
        [view setFrame:CGRectMake(0, 0, kScreenWidth, 50)];
        [instrumentLabel setFrame:CGRectMake(13, 10, kScreenWidth - 26, 15)];
        [instrumentLabel setFont:[UIFont systemFontOfSize:13.0f]];
        instrumentLabel.text = @"在这里你可以开启或关闭物业和商家给的消息提示";

    }
    [view addSubview:instrumentLabel];
    return view;
}

- (void)notifyCell:(NotificationTableViewCell *)cell switchValueChange:(BOOL)value
{
    NSIndexPath *index = [notificationTableView indexPathForCell:cell];
    if (index.section == 1)
    {
        if (index.row == 0)
        {
            if (value == 1)
            {
                [MobClick event:@"click_open_propertynotification"];
            }
            else
            {
                [MobClick event:@"click_close_propertynotification"];
            }
            [valueDic setPObject:(value ? @"1" : @"0") forKey:@"isRecevieWy"];
            
        }
        else if (index.row == 1)
        {
            if (value == 1)
            {
                [MobClick event:@"click_open_shopnotification"];
            }
            else
            {
                [MobClick event:@"click_close_shopnotification"];
            }
            [valueDic setPObject:(value ? @"1" : @"0") forKey:@"isRecevieShop"];
        }
    }
    else if (index.section == 2)
    {
        if (index.row == 0)
        {
            if (value == 1)
            {
                [MobClick event:@"click_open_sound"];
            }
            else
            {
                [MobClick event:@"click_close_sound"];
            }
            [valueDic setPObject:(value ? @"1" : @"0") forKey:@"isVoice"];
        }
        else if (index.row == 1)
        {
            if (value == 1)
            {
                [MobClick event:@"click_open_shake"];
            }
            else
            {
                [MobClick event:@"click_close_shake"];
            }
            [valueDic setPObject:(value ? @"1" : @"0") forKey:@"isShake"];
        }
    }
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
