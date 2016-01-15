//
//  HWFuLiSheViewController.m
//  KaoLa
//
//  Created by hw on 15/1/12.
//  Copyright (c) 2015年 hw. All rights reserved.
//
//  功能描述：福利社首页 页面
//
//  修改记录：
//      姓名          日期                       修改内容
//      吴晓红        2015-1-13                 创建文件
//      聂迪          2015-1-16                 添加接口
//      聂迪          2015-1－17                修改内容
//      蔡景鹏         2015-1-17                接口对接
//

#import "HWFuLiSheViewController.h"
#import "HWTreasureRuleViewController.h"
#import "HWTreasureViewController.h"
#import "HWPriviledgeDetailVC.h"
#import "HWPropertyDetailVC.h"
#import "HWTopicListViewController.h"

@interface HWFuLiSheViewController ()

@end

@implementation HWFuLiSheViewController

- (void)viewWillAppear:(BOOL)animated
{
    [self.navigationController setNavigationBarHidden:NO animated:NO];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
   
    _fulisheView = [[HWFuLiSheView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, CONTENT_HEIGHT - 49.0f)];
    _fulisheView.delegate = self;
    [self.view addSubview:_fulisheView];
}

#pragma mark -
#pragma mark            HWFuLiSheView Delegate

- (void)cellSelectedPushVC:(UIViewController *)vc
{
    [self.navigationController pushViewController:vc animated:YES];
}

- (void)didSelectBanner:(HWActivityModel *)activity
{
    [self pushViewControllerByAppModel:activity];
    
//    HWApplicationDetailViewController *appDetailVC = [[HWApplicationDetailViewController  alloc] init];
//    appDetailVC.navigationItem.titleView = [Utility navTitleView:activity.activityName];
//    appDetailVC.appUrl = activity.activityURL;
//    [self.navigationController pushViewController:appDetailVC animated:YES];
}

- (void)pushViewControllerByAppModel:(HWActivityModel *)activityModel
{
    NSArray *strArr = [activityModel.activityURL componentsSeparatedByString:@":"];
    
    NSString *headStr = [strArr pObjectAtIndex:0];
    if ([headStr isEqualToString:@"kaola"])
    {
        // 应用内跳转
        NSString *secStr = [strArr pObjectAtIndex:1];
        if ([secStr isEqualToString:@"wy"])
        {
//            [Utility showToastWithMessage:@"错误地址" inView:self.view];
            
            if ([HWUserLogin currentUserLogin].tenementId == nil)
            {
                [self btnPerfectClick:nil];
            }
            else
            {
                [self propertyTapGesture:nil];
            }
            
        }
        else if ([secStr isEqualToString:@"cut"])
        {
            NSString *thirdStr = [strArr pObjectAtIndex:2];
            if ([thirdStr isEqualToString:@"index"])
            {
                [self pushCutApplication];
            }
            else if ([thirdStr isEqualToString:@"detail"])
            {
                // 详情
                NSString *detailIdStr = [strArr pObjectAtIndex:3];
                
                if ([detailIdStr hasPrefix:@"{"] && [detailIdStr hasSuffix:@"}"])
                {
                    if (detailIdStr.length < 3)
                    {
                        NSLog(@"id 不能为空");
                    }
                    else
                    {
                        [self pushCutDetail:[detailIdStr substringWithRange:NSMakeRange(1, detailIdStr.length - 2)]];
                    }
                }
                else
                {
                    NSLog(@"应用路径错误");
                }
            }
        }
        else if ([secStr isEqualToString:@"coupon"])
        {
            NSString *thirdStr = [strArr pObjectAtIndex:2];
            if ([thirdStr isEqualToString:@"index"])
            {
                [self pushCouponList];
            }
            else if ([thirdStr isEqualToString:@"detail"])
            {
                // 详情
                NSString *detailIdStr = [strArr pObjectAtIndex:3];
                if ([detailIdStr hasPrefix:@"{"] && [detailIdStr hasSuffix:@"}"])
                {
                    if (detailIdStr.length < 3)
                    {
                        NSLog(@"id 不能为空");
                    }
                    else
                    {
                        [self pushCouponDetail:[detailIdStr substringWithRange:NSMakeRange(1, detailIdStr.length - 2)]];
                    }
                }
                else
                {
                    NSLog(@"应用路径错误");
                }
                
            }
        }
        else if ([secStr isEqualToString:@"game"])
        {
            // 游戏
            NSString *thirdStr = [strArr pObjectAtIndex:2];
            if ([thirdStr isEqualToString:@"index"])
            {
                // 列表
                [self pushGameList];
            }
            else if ([thirdStr isEqualToString:@"detail"])
            {
                // 详情
                NSString *detailIdStr = [strArr pObjectAtIndex:3];
                if ([detailIdStr hasPrefix:@"{"] && [detailIdStr hasSuffix:@"}"])
                {
                    if (detailIdStr.length < 3)
                    {
                        NSLog(@"id 不能为空");
                    }
                    else
                    {
                        [self pushGameDetail:[detailIdStr substringWithRange:NSMakeRange(1, detailIdStr.length - 2)]];
                    }
                }
                else
                {
                    NSLog(@"应用路径错误");
                }
            }
        }
        else
        {
            NSLog(@"未知路径");
        }
        
    }
    else if ([headStr isEqualToString:@"topic"])
    {
        /*"topic:coupon:index:{话题Id}"
         "topic:coupon:detail:{主题Id}"*/
        NSString *secStr = [strArr pObjectAtIndex:1];
        if ([secStr isEqualToString:@"coupon"])
        {
            //先取id
            NSString *idStr = [strArr pObjectAtIndex:3];
            if (idStr.length > 2)
            {
                idStr = [idStr substringFromIndex:1];
                if (idStr.length > 1)
                {
                    idStr = [idStr substringToIndex:idStr.length -1];
                }
                else
                {
                    idStr = nil;
                }
            }
            else
            {
                idStr = nil;
            }
            
            if (idStr != nil)
            {
                NSString *detailIdStr = [strArr pObjectAtIndex:2];
                if ([detailIdStr isEqualToString:@"index"])
                {
                    HWChannelModel *model = [[HWChannelModel alloc] init];
                    model.channelId = idStr;
                    model.channelName = activityModel.activityName;
                    model.passVillageIdArr = nil;
                    
                    HWTopicListViewController *vc = [[HWTopicListViewController alloc]init];
                    vc.channelModel = model;
                    [self.navigationController pushViewController:vc animated:YES];
                }
                else if ([detailIdStr isEqualToString:@"detail"])
                {
                    HWDetailViewController *detailVC = [[HWDetailViewController alloc] initWithCardId:idStr];
                    detailVC.resourceType = detailResourceNeighbour;
                    detailVC.chuanChuanMenCanNotHandle = NO;
                    [self.navigationController pushViewController:detailVC animated:YES];
                }
            }
            else
            {
                NSLog(@"话题或主题id错误");
            }
        }
    }
    else
    {
        // web页面
        HWApplicationDetailViewController *appDetailVC = [[HWApplicationDetailViewController  alloc] init];
        appDetailVC.navigationItem.titleView = [Utility navTitleView:activityModel.activityName];
        appDetailVC.appUrl = activityModel.activityURL;
        [self.navigationController pushViewController:appDetailVC animated:YES];
    }
}

- (void)pushCutApplication
{
    [MobClick event:@"click_bargain"];
    
    NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
    NSString *agreeFlag = [userDefaults objectForKey:kAgreeProtocol];
    if (agreeFlag == nil || [agreeFlag isEqualToString:@"0"])
    {
        HWTreasureRuleViewController *treasureRuleVC = [[HWTreasureRuleViewController alloc] init];
        treasureRuleVC.isAgree = YES;
        [self.navigationController pushViewController:treasureRuleVC animated:YES];
    }
    else
    {
        HWTreasureViewController *treasureVC = [[HWTreasureViewController alloc] init];
        [self.navigationController pushViewController:treasureVC animated:YES];
    }
}

- (void)pushCutDetail:(NSString *)cutId
{
    HWTreasureViewController *treasureVC = [[HWTreasureViewController alloc] init];
    treasureVC.preProductId = cutId;
    [self.navigationController pushViewController:treasureVC animated:YES];
}

- (void)pushCouponList
{
    HWDiscountViewController *couponVC = [[HWDiscountViewController alloc] init];
    [self.navigationController pushViewController:couponVC animated:YES];
}

- (void)pushCouponDetail:(NSString *)couponId
{
    HWPriviledgeDetailVC *detailVC = [[HWPriviledgeDetailVC alloc] init];
    detailVC.priviledgeId = couponId;
    [self.navigationController pushViewController:detailVC animated:YES];
}

- (void)pushGameList
{
    HWGameSpreadVC *gameVC = [[HWGameSpreadVC alloc] init];
    [self.navigationController pushViewController:gameVC animated:YES];
}

- (void)pushGameDetail:(NSString *)gameId
{
    HWGameDetailViewController *gameVC = [[HWGameDetailViewController alloc] init];
    gameVC.gameId = gameId;
    [self.navigationController pushViewController:gameVC animated:YES];
}

//完善物业信息
- (void)btnPerfectClick:(id)sender
{
    [MobClick event:@"click_property_card"];
    HWPerfectPropertyDataVC *perfect = [[HWPerfectPropertyDataVC alloc] init];
    perfect.isProperty = NO;
    [self.navigationController pushViewController:perfect animated:YES];
}

- (void)propertyTapGesture:(UITapGestureRecognizer *)tap
{
    [MobClick event:@"click_property_card"];
    //物业详情
    HWPropertyDetailVC *property = [[HWPropertyDetailVC alloc] init];
    property.propertyId = [HWUserLogin currentUserLogin].tenementId;
    [self.navigationController pushViewController:property animated:YES];
}


- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
/*
 
 //- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
 //{
 //    return 3;
 //}
 //
 //
 //- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
 //{
 //    HWFulLiSheTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cellIdentifier"];
 //    if (!cell)
 //    {
 //        cell = [[HWFulLiSheTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"cellIdentifier"];
 //    }
 //    cell.imaageView.image  =[UIImage imageNamed:[NSString stringWithFormat:@"fulishe_%d.png",indexPath.row+1]];
 //    HWFuLiSheModel * model = [self.dataList objectAtIndex:indexPath.row];
 //    [cell setContactCellContent:model];
 //    return cell;
 //}
 //
 //- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
 //{
 //    return 320 / 3.0f;
 //
 //}
 //
 //- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
 //{
 //    if (indexPath.row==0) {
 //
 //    }
 //    if (indexPath.row==1) {
 //
 //    }
 //    if (indexPath.row==2) {
 //        HWGameSpreadVC *gsc = [[HWGameSpreadVC alloc]init];
 //        [self.navigationController pushViewController:gsc animated:YES];
 //    }
 //}
 
 -(void)didSelectCell
 {
 HWGameSpreadVC *gsc = [[HWGameSpreadVC alloc]init];
 [self.navigationController pushViewController:gsc animated:YES];
 }
 
 //-(void)createScroll
 //{
 //
 //    headView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, (460/2+10+0.5) * kScreenRate)];
 //
 //    [self.view addSubview:headView];
 //    tab.tableHeaderView = headView;
 //
 //     scroll =[[UIScrollView alloc]initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, 460/2)];
 //  //  scroll.backgroundColor =[UIColor greenColor];
 //    [scroll setContentSize:CGSizeMake(self.view.frame.size.width * 3, 0)];
 //    scroll.bounces = NO;
 //    [headView addSubview:scroll];
 //    for (int i=0; i<3; i++) {
 //        UIImageView * imageview = [[UIImageView alloc]initWithFrame:CGRectMake(self.view.frame.size.width*i, 0, self.view.frame.size.width, 460/2)];
 //        //imageview.image = [UIImage imageNamed:[NSString stringWithFormat:@"2.jpg"]];
 //        [scroll addSubview:imageview];
 //    }
 //
 //
 //    UIView * view =[[UIView alloc]initWithFrame:CGRectMake(0, 460/2, self.view.frame.size.width,10)];
 //    view.backgroundColor = THEME_COLOR_BACKGROUND_1;
 //    [headView addSubview:view];
 //    UIView * line =[[UIView alloc]initWithFrame:CGRectMake(0, 460/2+10-0.5, self.view.frame.size.width, 0.5)];
 //    line.backgroundColor = THEME_COLOR_LINE;
 //    [headView addSubview:line];
 
 //}
 //-(void)createTab
 //
 //{
 //    tab = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, self.view.frame.size.width,CONTENT_HEIGHT-44) style:UITableViewStylePlain];
 //    tab.delegate =self;
 //    tab.dataSource =self;
 //    //tab.backgroundColor =[UIColor redColor];
 //    tab.separatorStyle =UITableViewCellSeparatorStyleNone;
 //   // tab.bounces = YES;
 //    //tab.scrollEnabled = NO;
 //    [self.view addSubview:tab];
 //
 //}
 //
 //- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
 //{
 //    return 3;
 //}
 //
 //
 //- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
 //{
 //    HWFulLiSheTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cellIdentifier"];
 //    if (!cell)
 //    {
 //        cell = [[HWFulLiSheTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"cellIdentifier"];
 //    }
 //    cell.imaageView.image  =[UIImage imageNamed:[NSString stringWithFormat:@"fulishe_%d.png",indexPath.row+1]];
 //    HWFuLiSheModel * model = [self.dataList objectAtIndex:indexPath.row];
 //    [cell setContactCellContent:model];
 //    return cell;
 //}
 //
 //- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
 //{
 //    return 320/3;
 //
 //}
 //
 //- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
 //{
 //    if (indexPath.row==0) {
 //
 //    }
 //    if (indexPath.row==1) {
 //
 //    }
 //    if (indexPath.row==2) {
 //        HWGameSpreadVC *gsc = [[HWGameSpreadVC alloc]init];
 //        [self.myNavigationController pushViewController:gsc animated:YES];
 //    }
 //}
 //}
 */
