//
//  SystemSettinViewController.m
//  Community
//
//  Created by gusheng on 14-9-7.
//  Copyright (c) 2014年 caijingpeng. All rights reserved.
//

#import "SystemSettinViewController.h"
#import "SystemInfoTableViewCell.h"
#import "PersonPrivacyViewController.h"
#import "NotificationAndTipViewController.h"
#import "CustomerProtocolViewController.h"
#import "HWHomePageViewController.h"
#import "HWAboutKoalaCommunityViewController.h"
#import "HWCoreDataManager.h"
#import "SBJson.h"

#import "HWCoreDataManager.h"
#import "HWAudioCache.h"
@interface SystemSettinViewController ()

@end

@implementation SystemSettinViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}
-(void)viewDidAppear:(BOOL)animated
{
//    [self checkNewVersion];
}

- (void)viewWillAppear:(BOOL)animated
{
    systemInfoTableView.delegate = self;
    systemInfoTableView.dataSource = self;
}

- (void)viewWillDisappear:(BOOL)animated
{
    systemInfoTableView.delegate = nil;
    systemInfoTableView.dataSource = nil;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.navigationItem.titleView = [Utility navTitleView:@"系统设置"];
    self.navigationItem.leftBarButtonItem = [Utility navLeftBackBtn:self action:@selector(backMethod)];
    isNewVersionFlag = YES;
    self.view.backgroundColor = UIColorFromRGB(0xf2f2f2);
    [self createDataSource];
    [self createMainView];
}
//返回上一级
- (void)backMethod
{
    [self.navigationController popViewControllerAnimated:YES];
}
//创建展示页面的主视图
-(void)createMainView
{
    systemInfoTableView.delegate = self;
    systemInfoTableView.dataSource = self;
//    systemInfoTableView.scrollEnabled = NO;
    [systemInfoTableView setSeparatorStyle:UITableViewCellSeparatorStyleNone];
    systemInfoTableView.frame = CGRectMake(0, 0, kScreenWidth, self.view.frame.size.height);
    systemInfoTableView.tableHeaderView = [self createHeadView];
    systemInfoTableView.backgroundColor = [UIColor clearColor];
}
//创建头视图
-(UIView *)createHeadView
{
    UIView *view = [[UIView alloc]initWithFrame:CGRectMake(0, 0, kScreenWidth, 10)];
    view.backgroundColor= UIColorFromRGB(0xf2f2f2);
    return view;
}


//创建数据源
-(void)createDataSource
{
    NSMutableArray *arryOne = [[NSMutableArray alloc]initWithObjects:@"消息提醒",@"清除缓存", nil];
    NSMutableArray *arryTwo = [[NSMutableArray alloc]initWithObjects:@"用户协议",@"隐私策略",@"关于考拉社区", nil];
    listDataDic = [[NSDictionary alloc]initWithObjectsAndKeys:arryOne,@"arryOne",arryTwo,@"arryTwo", nil];
    
}
//创建版本更新按钮
-(UIButton *)createVersionBtn
{
    UIButton *versionBtn = [[UIButton alloc]initWithFrame:CGRectMake(self.view.frame.size.width-150, 15, 140, 18)];
    versionBtn.backgroundColor = [UIColor clearColor];
    if(isNewVersionFlag == YES)
    {
        [versionBtn setTitle:@"最新版本" forState:UIControlStateNormal];
        [versionBtn setTitleEdgeInsets:UIEdgeInsetsMake(0,70, 0, 0)];
    }
    else
    {
        [versionBtn setTitle:@"有新版本,点击更新" forState:UIControlStateNormal];
    }
    
    [versionBtn.titleLabel setFont:[UIFont systemFontOfSize:14.0f]];
    [versionBtn setTitleColor:THEME_COLOR_ORANGE forState:UIControlStateNormal];
    [versionBtn addTarget:self action:@selector(checkVersion) forControlEvents:UIControlEventTouchUpInside];
    return versionBtn;
}
//检查新版本
-(void)checkNewVersion
{
      [self performSelectorInBackground:@selector(checkNewVersion:) withObject:APP_CHECKUPDATE];
}
//检查最新版本
-(void)checkNewVersion:(NSString *)string
{
    NSData *data=  [NSData dataWithContentsOfURL:[NSURL URLWithString:string]];
    SBJsonParser *parser = [[SBJsonParser alloc]init];
    NSDictionary *dict = [parser objectWithData:data];
    
    if (dict == nil) {
        return;
    }
    if (![[[[dict arrayObjectForKey:@"results"] lastObject] stringObjectForKey:@"version"] isEqualToString:[Utility getLocalAppVersion]])
    {
        isNewVersionFlag = NO;
        if (systemInfoTableView && listDataDic)
        {
            
            NSMutableArray *arrTwo = (NSMutableArray *)[listDataDic arrayObjectForKey:@"arryTwo"];
            NSString *versionStr = [[[dict arrayObjectForKey:@"results"] lastObject] stringObjectForKey:@"version"];
            if (versionStr)
            {
                NSString *version =[NSString stringWithFormat:@"当前版本%@",[[[dict arrayObjectForKey:@"results"] lastObject] stringObjectForKey:@"version"]];
                if (arrTwo != nil)
                {
                    [arrTwo replaceObjectAtIndex:0 withObject:version];
                }
                
            }
            [systemInfoTableView performSelectorOnMainThread:@selector(reloadData) withObject:nil waitUntilDone:YES];
        }
    }


}
#pragma - mark
#pragma alertView
-(void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
  if(buttonIndex == 1)
  {
      [[UIApplication sharedApplication] openURL:[NSURL URLWithString:ITUNSE_DOWNLOAD_URL]];
  }
}
//检查版本更新
-(void)checkVersion
{
    [MobClick event:@"click_check_"];
    
    [Utility showMBProgress:self.view message:LOADING_TEXT];
    [self performSelectorInBackground:@selector(checkVersion:) withObject:APP_CHECKUPDATE];

}
/**
 *	@brief	检查版本号
 *
 *	@param 	string
 *
 *	@return	 无
 */
-(void)checkVersion:(NSString *)string
{
    NSData *data=  [NSData dataWithContentsOfURL:[NSURL URLWithString:string]];
    SBJsonParser *parser = [[SBJsonParser alloc]init];
    NSDictionary *dict = [parser objectWithData:data];
    
    [self performSelectorOnMainThread:@selector(hideMBProgress) withObject:nil waitUntilDone:YES];
    
    
    if (dict == nil) {
        [Utility hideMBProgress:self.view];
        [Utility showToastWithMessage:@"检查版本超时" inView:self.view];
        return;
    }
    
    if (![[[[dict arrayObjectForKey:@"results"] lastObject] stringObjectForKey:@"version"] isEqualToString:[Utility getLocalAppVersion]])
    {
        NSString *msg = [[[dict objectForKey:@"results"] lastObject] objectForKey:@"releaseNotes"];
        if (![msg isEqualToString:@""] && msg != nil)
        {
            UIAlertView *_alert = [[UIAlertView alloc] initWithTitle:@"新版本更新" message:[[[dict objectForKey:@"results"] lastObject] objectForKey:@"releaseNotes"] delegate:self cancelButtonTitle:@"取消" otherButtonTitles:@"确定", nil];
            _alert.tag = CURUPDATE_TAG;
            [_alert performSelectorOnMainThread:@selector(show) withObject:nil waitUntilDone:YES];
        }
    }
    else
    {
//        [self performSelectorOnMainThread:@selector(showNewVersionToast) withObject:nil waitUntilDone:YES];
    }
}

//- (void)showNewVersionToast
//{
//    [Utility showToastWithMessage:@"已是最新版" inView:self.view];
//}
//
- (void)hideMBProgress
{
    [Utility hideMBProgress:self.view];
}

#pragma mark - TableViewDelegate
#pragma - mark tableview delegate method
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *cellIdentifier1 = @"modifyPersonAvatar";
    NSInteger row = [indexPath row];
    SystemInfoTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier1];
    if (!cell)
    {
        cell = [[SystemInfoTableViewCell alloc]init];
    }
    if ([indexPath section] == 0)
    {
        NSMutableArray *arrOne = [listDataDic objectForKey:@"arryOne"];
        cell.titleLabel.text = [arrOne objectAtIndex:[indexPath row]];
        [cell addLine:45.5 isHide:NO];
        cell.rightJmpImgV.hidden = NO;
    }
    else
    {
        NSMutableArray *arrTwo = [listDataDic objectForKey:@"arryTwo"];
//        if (row == 0)
//        {
//            [cell.contentView addSubview:[self createVersionBtn]];
//        }
        
        cell.titleLabel.text = [arrTwo objectAtIndex:[indexPath row]];
        [cell addLine:45.5 isHide:NO];
        
//        if (row == 0)
//        {
//            cell.rightJmpImgV.hidden = YES;
//        }
//        else
//        {
            cell.rightJmpImgV.hidden = NO;
//        }
       
    }
    if(indexPath.row == 0) {
        [cell addLine:0.0f isHide:NO];
    }
    
    cell.titleLabel.font = [UIFont systemFontOfSize:15.0];
    cell.titleLabel.textColor = UIColorFromRGB(0x333333);
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    return cell;
    
    
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSInteger row = indexPath.row;
    NSInteger section = [indexPath section];
    switch (section) {
        case 0:
        {
        switch (row) {
        case 0:
                {
                    [MobClick event:@"click_notification"];
                    NotificationAndTipViewController *notificationView = [[NotificationAndTipViewController alloc]initWithNibName:@"NotificationAndTipViewController" bundle:nil];
                    [self.navigationController pushViewController:notificationView animated:YES];
                    break;
                }
                case 1:
                {
                    [MobClick event:@"click_clear_cache"];
                    [HWCoreDataManager clearNeighbourList];
                    [HWCoreDataManager removeAllShareItem];
                    [HWCoreDataManager clearPropertyList];
                    [HWCoreDataManager removeAllNotification];
                    [HWCoreDataManager clearShopList];
                    [HWCoreDataManager clearPropertyData];
                    
                    //清除音频缓存
                    [[HWAudioCache shareAudioCache] clearDisk];
                    
                    //清除webImage缓存
                    [[SDImageCache sharedImageCache]clearDisk];
                    //获取缓存大小
//                    long tmpSize = (long)[[SDImageCache sharedImageCache]getSize];
                    [Utility showToastWithMessage:@"已清理" inView:self.view];
                    
                    
                    break;
                }
                default:
                    break;
            }
             break;
        }
        case 1:
        {
            switch (row) {
                case 0:
                {
                    [MobClick event:@"click_useragreement"];
                    CustomerProtocolViewController *customerProtocolView = [[CustomerProtocolViewController alloc]initWithNibName:@"CustomerProtocolViewController" bundle:nil];
                    [self.navigationController pushViewController:customerProtocolView animated:YES];
                    break;
                }
                case 1:
                {
                    [MobClick event:@"click_privacy_policy"];
                    PersonPrivacyViewController *personPrivacyView = [[PersonPrivacyViewController alloc]init];
                    [self.navigationController pushViewController:personPrivacyView animated:YES];
                    break;
                }
                case 2:
                {
                    [MobClick event:@"click_aboutKoalaCommmunity"];
                    [self.navigationController pushViewController:[HWAboutKoalaCommunityViewController new] animated:YES];
                    break;
                }
                default:
                    break;
            }
             break;
        }
        default:
            break;
    }
    
    
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 46.0f;
    
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (section == 0) {
        return 2;
    }
    return  3;
}
-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    if (section == 0) {
        return nil;
    }
    else
    {
        UIView *viewBackView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, 320, 10)];
        viewBackView.backgroundColor = UIColorFromRGB(0xf2f2f2);
        return viewBackView;
    }
}
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 2.0f;
}
-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    if (section == 0) {
        return 0.0f;
    }
    return 10.0f;
}
- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
