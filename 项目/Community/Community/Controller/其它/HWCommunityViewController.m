//
//  HWCommunityViewController.m
//  Community
//
//  Created by caijingpeng.haowu on 14-9-7.
//  Copyright (c) 2014年 caijingpeng. All rights reserved.
//

#import "HWCommunityViewController.h"
#import "HWHTTPRequestOperationManager.h"
#import "HWRequestConfig.h"
#import "HWCityViewController.h"
#import "HWAreaClass.h"
#import "NoCommunityView.h"
#import "HWCreateNewCommunityViewController.h"
@interface HWCommunityViewController ()
{
    HWSearchBarView *_searchBar;
}
@end

@implementation HWCommunityViewController
@synthesize communities;
@synthesize cityId;
@synthesize villageId;
@synthesize slectedCommunityArry;
@synthesize searchResultArry;
@synthesize frontArry;
- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}
//判断定位是否开启
-(void)judgeLocationOnOrOff
{
    if ([CLLocationManager authorizationStatus] != kCLAuthorizationStatusAuthorized) {
        //[AppShare alertMB:self.view message:@"定位未开启,打开"定位服务"来允许"考拉社区"确定您的位置"];
        UIAlertView *alerView = [[UIAlertView alloc]initWithTitle:@"" message:@"定位未开启,打开\"定位服务\"来允许\"考拉社区\"确定您的位置" delegate:self cancelButtonTitle:@"取消" otherButtonTitles:@"确定", nil];
        [alerView show];
        
        
        return;
    }
}
-(void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    if (buttonIndex == 1) {
//        NSURL*url=[NSURL URLWithString:@"prefs:root=LOCATION_SERVICES"];
//        [[UIApplication sharedApplication] openURL:url];
//        [self.navigationController popViewControllerAnimated:YES];
        NSURL*url=[NSURL URLWithString:@"prefs:root=WIFI"];
        [[UIApplication sharedApplication] openURL:url];
    }
}
- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [baseTableView setFrame:CGRectMake(baseTableView.frame.origin.x, baseTableView.frame.origin.y+50, baseTableView.frame.size.width, baseTableView.frame.size.height-50)];
    self.navigationItem.leftBarButtonItem = [Utility navLeftBackBtn:self action:@selector(backMethod)];
    self.navigationItem.titleView = [Utility navTitleView:@"周边小区"];
    slectedCommunityArry = [NSMutableArray array];
    //add by gusheng
    if([frontArry count]!=0)
    {
        slectedCommunityArry = frontArry;
        self.navigationItem.rightBarButtonItem = [Utility navButton:self title:@"确认" action:@selector(toConfirm:) count:[slectedCommunityArry count]];
    }
    clickCount = [slectedCommunityArry count];
    //clickCount = 0;
    //end
    [self initialSearchDisplay];
    [self createNoAreaView];
    [self showOrHideCommunity:YES];
    //发送获取周边小区请求
 //   float longtitude = [HWUserLogin currentUserLogin].longitude;
 //   float latitude = [HWUserLogin currentUserLogin].latitude;
//    if (longtitude > -0.000001 && longtitude < 0.000011 && latitude > -0.000001 && longtitude < 0.0000011) {
//        [self showOrHideCommunity:NO];
//        [self judgeLocationOnOrOff];
//    }
//    else
//    {
        [self queryListData];

//    }
}
//提交服务范围
-(void)toConfirm:(id)sender
{
    if ([slectedCommunityArry count] == 0) {
        NSLog(@"数组为空");
        return;
    }
    NSMutableString *communityStrS = [[NSMutableString alloc]init];

    for (int i = 0; i < [slectedCommunityArry count]; i++) {
        HWAreaClass *araTemp = [slectedCommunityArry objectAtIndex:i];
        [communityStrS appendString:araTemp.villageNameStr];
        if (i < [slectedCommunityArry count] - 1) {
            [communityStrS appendString:@","];
        }
    }
    if (_SlectedCommunity) {
        _SlectedCommunity(communityStrS,slectedCommunityArry);
    }
    [_searchBar._searchTF resignFirstResponder];
    [self.navigationController popViewControllerAnimated:YES];
}
#pragma mark -
#pragma mark Initial View

- (void)initialSearchDisplay
{
    _searchBar = [[HWSearchBarView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, 50)];
    _searchBar.delegate = self;
    _searchBar.frameMaxHeight = self.view.frame.size.height - 64;
    [_searchBar setSearchBarPlaceholder:@"输入小区或首字母查询"];
    [self.view addSubview:_searchBar];
}
#pragma mark -
#pragma mark Private Method
//发送根据城市ID和关键字搜索--定位失败
-(void)searchComunityWithCityIDRequestLocationFailure
{
    NSMutableDictionary *param = [NSMutableDictionary dictionary];
    [param setPObject:[HWUserLogin currentUserLogin].key forKey:@"key"];
    [param setPObject:_searchBar._searchTF.text forKey:@"keywords"];
    [param setPObject:[HWUserLogin currentUserLogin].cityId forKey:@"cityId"];
    HWHTTPRequestOperationManager *manager = [HWHTTPRequestOperationManager manager];
    [manager POST:kSearchWithCityID parameters:param queue:nil success:^(id responseObject){
        NSLog(@"%@",responseObject);
        NSDictionary *dataDic = [responseObject dictionaryObjectForKey:@"data"];
        NSArray *array = [dataDic arrayObjectForKey:@"content"];
        self.dataList = [NSMutableArray array];
        for (NSDictionary *temp in array) {
            HWAreaClass *newsM = [[HWAreaClass alloc]initWithDic:temp];
            [self.dataList addObject:newsM];
        }
        if(self.dataList.count==0) {
            [self showOrHideCommunity:NO];
        }
        else
        {
            [self showOrHideCommunity:YES];
        }
        [baseTableView reloadData];
    } failure:^(NSString *code, NSString *error) {
        [self showOrHideCommunity:NO];
        NSLog(@"error");
    }];
    
}

//发送获取周围小区的列表请求
-(void)searchNearbyVillageRequest
{
    NSMutableDictionary *param = [NSMutableDictionary dictionary];
    [param setPObject:[HWUserLogin currentUserLogin].key forKey:@"key"];
    [param setPObject:_searchBar._searchTF.text forKey:@"keywords"];
    [param setPObject:[NSString stringWithFormat:@"%d",kPageCount] forKey:@"size"];
    [param setPObject:[NSString stringWithFormat:@"%f",[HWUserLogin currentUserLogin].latitude]forKey:@"latitude"] ;
    [param setPObject:[NSString stringWithFormat:@"%f",[HWUserLogin currentUserLogin].longitude] forKey:@"longitude"];
    HWHTTPRequestOperationManager *manager = [HWHTTPRequestOperationManager manager];
    [manager POST:kSearchVillage parameters:param queue:nil success:^(id responseObject){
        NSDictionary *dataDic = [responseObject dictionaryObjectForKey:@"data"];
        NSArray *array = [dataDic arrayObjectForKey:@"content"];
        self.dataList = [NSMutableArray array];
        //add by gusheng
        for(HWAreaClass *areaTemp in slectedCommunityArry)
        {
            [self.dataList addObject:areaTemp];
        }
        //end
        for (NSDictionary *temp in array) {
            HWAreaClass *newsM = [[HWAreaClass alloc]initWithDic:temp];
              [self.dataList addObject:newsM];
            for(HWAreaClass *area in slectedCommunityArry)
            {
                if ([newsM.villageIdStr isEqualToString:area.villageIdStr]) {
                    [self.dataList removeObject:newsM];
                }
            }
            
        }
        if(self.dataList.count==0) {
            [self showOrHideCommunity:NO];
        }
        else
        {
            [self showOrHideCommunity:YES];
        }
        isLastPage = YES;
        [baseTableView reloadData];
        [self doneLoadingTableViewData];
    } failure:^(NSString *code, NSString *error) {
        [self showOrHideCommunity:NO];
        NSLog(@"error");
    }];
    
}

#pragma mark -
#pragma mark Private Method
/**
 *	@brief	请求数据，获得周边小区列表数据
 *
 *	@return	void
 */
- (void)queryListData
{
   // [Utility showMBProgress:self.view message:@""];
    NSMutableDictionary *param = [NSMutableDictionary dictionary];
//    _currentPage = 0;
    [param setPObject:[NSString stringWithFormat:@"%d",_currentPage] forKey:@"page"];
    [param setPObject:[NSString stringWithFormat:@"%d",25] forKey:@"size"];             //默认小区数据25
    [param setPObject:[NSString stringWithFormat:@"%f",[HWUserLogin currentUserLogin].latitude]forKey:@"latitude"];
    [param setPObject:[NSString stringWithFormat:@"%f",[HWUserLogin currentUserLogin].longitude] forKey:@"longitude"];
    [param setPObject:[HWUserLogin currentUserLogin].key forKey:@"key"];
    HWHTTPRequestOperationManager *manager = [HWHTTPRequestOperationManager manager];
    [manager POST:kGetNearbyVillage parameters:param queue:nil success:^(id responseObject)  {
        if ([self.view viewWithTag:1111]) {
            [[self.view viewWithTag:1111] removeFromSuperview];
        }
        NSDictionary *dataDic = [responseObject dictionaryObjectForKey:@"data"];
        NSArray *array = [dataDic arrayObjectForKey:@"content"];
        if(array.count < 25)
        {
            isLastPage = YES;
        }
        else
        {
            isLastPage = YES;
        }
        
        if (_currentPage == 0) {
            self.dataList = [NSMutableArray array];
            for(HWAreaClass *areaTemp in slectedCommunityArry)
            {
                [self.dataList addObject:areaTemp];
            }

            for (NSDictionary *temp in array) {
                HWAreaClass *newsM = [[HWAreaClass alloc]initWithDic:temp];
                [self.dataList addObject:newsM];
                for(HWAreaClass *area in slectedCommunityArry)
                {
                    if ([newsM.villageIdStr isEqualToString:area.villageIdStr]) {
                        [self.dataList removeObject:newsM];
                    }
                }
            }
            //保存数据库
            if (self.dataList != 0) {
                
            }
        }
        else
        {
            for (NSDictionary *temp in array) {
                HWAreaClass *newsM = [[HWAreaClass alloc]initWithDic:temp];
                [self.dataList addObject:newsM];
            }
        }
        [baseTableView reloadData];
        
        if(self.dataList.count==0)
        {
            [self showOrHideCommunity:NO];
        }
        else
        {
            [self showOrHideCommunity:YES];
        }
        
        [self doneLoadingTableViewData];
        [self dismissViewControllerAnimated:YES completion:nil];
    } failure:^(NSString *code, NSString *error) {
        [self doneLoadingTableViewData];
        if (_currentPage==0&&[[error description] isEqualToString:@"没有符合条件的"]) {
            [self.dataList removeAllObjects];
            [self.baseTableView reloadData];
            [self showOrHideCommunity:NO];
        }
        else if(self.dataList.count==0) {
            [self showOrHideCommunity:NO];
        }
    }];
}
//创建搜索小区无结果的界面
-(void)createNoAreaView
{
    noCommentView = [[UIView alloc]initWithFrame:CGRectMake(0, 50, kScreenWidth, [UIScreen mainScreen].bounds.size.height)];
    noCommentView.backgroundColor = UIColorFromRGB(0xf0f0f0);
    UIImageView *AvatarImageView = [[UIImageView alloc]initWithFrame:CGRectMake(kScreenWidth/2-167.5/2, 62, 167.5, 124.5)];
    AvatarImageView.image = [UIImage imageNamed:@"emptyData"];
    [noCommentView addSubview:AvatarImageView];
    
    UILabel *noCommentLabel = [[UILabel alloc]initWithFrame:CGRectMake(kScreenWidth/2-100, 205, 200, 14)];
    noCommentLabel.backgroundColor = [UIColor clearColor];
    noCommentLabel.text = @"当前城市未找到你搜索的小区";
    noCommentLabel.textColor = THEME_COLOR_TEXT;
    noCommentLabel.textAlignment = NSTextAlignmentCenter;
    noCommentLabel.font = [UIFont systemFontOfSize:14.0];
    [noCommentView addSubview:noCommentLabel];
    
    
    UIButton *commentBtn = [[UIButton alloc]initWithFrame:CGRectMake(kScreenWidth/2-280/2, 264, 280, 44)];
    commentBtn.backgroundColor = [UIColor clearColor];
    commentBtn.titleLabel.textColor = [UIColor whiteColor];
    commentBtn.layer.cornerRadius = 2.0f;
    commentBtn.layer.masksToBounds = YES;
    [commentBtn setBackgroundImage:[Utility imageWithColor:THEME_COLOR_ORANGE andSize:CGSizeMake(280, 44)] forState:UIControlStateNormal];
    [commentBtn addTarget:self action:@selector(clickComment:) forControlEvents:UIControlEventTouchUpInside];
    [commentBtn setTitle:@"创建小区" forState:UIControlStateNormal];
    [noCommentView addSubview:commentBtn];
    [self.view addSubview:noCommentView];
}
//创建小区
-(void)clickComment:(id)sender
{
    HWCreateNewCommunityViewController *createNewCommunityView = [[HWCreateNewCommunityViewController alloc] initWithNibName:@"HWCreateNewCommunityViewController" bundle:nil];
    [self.navigationController pushViewController:createNewCommunityView animated:YES];
}
//搜索小区有无接口-flag:yes有结果，no无结果
-(void)showOrHideCommunity:(BOOL)flag
{
    mainTV.hidden = !flag;
    baseTableView.hidden = !flag;
    noCommentView.hidden = flag;
}
#pragma mark -
#pragma mark HWCommunityCell Delegate

- (void)communityCell:(HWCommunityCell *)cell didSelectItem:(BOOL)yesOrNo
{
    
}

#pragma mark -
#pragma mark TableView Delegate

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [self.dataList count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *cellIdentifier = @"cell";
    HWCommunityCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    if (!cell)
    {
        cell = [[HWCommunityCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdentifier];
    }
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    __weak HWCommunityCell *myCell = cell;
    HWAreaClass *area = [self.dataList objectAtIndex:[indexPath row]];
    cell.titleLab.text = area.villageNameStr;
    cell.subTitleLab.text = area.villageAddressStr;
    if (![area.distanceStr length]==0) {
        cell.distanceLab.text = [NSString stringWithFormat:@"%@m",area.distanceStr];
    }
   
    [cell setSelecCommunity:^(BOOL flag) {
        
        if (flag == YES) {
            if ([slectedCommunityArry count]<=5) {
                clickCount++;
                if (clickCount > 5) {
                    [Utility showToastWithMessage:@"最多可选择5个小区" inView:self.view];
                    [myCell.selectBtn setImage:nil forState:UIControlStateNormal];
                    clickCount --;
                    return ;
                }
                HWAreaClass *area = [self.dataList objectAtIndex:[indexPath row]];
                [slectedCommunityArry addObject:area];
                area.flag = YES;
                if (clickCount >= 1)
                {
                    self.navigationItem.rightBarButtonItem = [Utility navButton:self title:@"确认" action:@selector(toConfirm:) count:clickCount];
                }
                else
                {
                    self.navigationItem.rightBarButtonItem = [Utility navButton:self title:@"确认" action:@selector(toConfirm:)];
                }

            }
        }
        else
        {
            if([slectedCommunityArry count]>0 && myCell.titleLab.text)
            {
                 HWAreaClass *area = [self.dataList objectAtIndex:[indexPath row]];
                for(HWAreaClass *areaTemp in slectedCommunityArry)
                {
                    if ([areaTemp.villageNameStr isEqualToString:area.villageNameStr]) {
                        clickCount--;
                        HWAreaClass *area = [self.dataList objectAtIndex:[indexPath row]];
                        [slectedCommunityArry removeObject:area];
                        area.flag = NO;
                        if (clickCount > 1)
                        {
                            self.navigationItem.rightBarButtonItem = [Utility navButton:self title:@"确认" action:@selector(toConfirm:) count:clickCount];
                        }
                        else
                        {
                            self.navigationItem.rightBarButtonItem = [Utility navButton:self title:@"确认" action:@selector(toConfirm:)];
                        }
                        
                        return;
                        
                    }
                }
                
            }
        }
        if (clickCount > 1)
        {
            self.navigationItem.rightBarButtonItem = [Utility navButton:self title:@"确认" action:@selector(toConfirm:) count:clickCount];
        }
        else
        {
            self.navigationItem.rightBarButtonItem = [Utility navButton:self title:@"确认" action:@selector(toConfirm:)];
        }
    }];
    
    if (area.flag == YES) {
         [cell.selectBtn setImage:[UIImage imageNamed: @"actived_checkbox"] forState:UIControlStateNormal];
    }
    else
    {
        [cell.selectBtn setImage:nil forState:UIControlStateNormal];
    }
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 70.0f;
}
#pragma mark -
#pragma mark SearchBarDelegate
- (void)searchBar:(HWSearchBarView *)searchView didSelectSearchResult:(NSString *)text villageId:(NSString *)villageIdStr  flag:(BOOL)flag
{
   
}
- (void)searchBar:(HWSearchBarView *)searchView textChange:(NSString *)text
{
    if ([_searchBar._searchTF.text length]==0) {
        [[self class]cancelPreviousPerformRequestsWithTarget:self selector:@selector(searchNearbyVillageRequest) object:nil];
        [self queryListData];
    }
    else
    {
        [[self class]cancelPreviousPerformRequestsWithTarget:self selector:@selector(searchNearbyVillageRequest) object:nil];
        float longtitude = [HWUserLogin currentUserLogin].longitude;
        float latitude = [HWUserLogin currentUserLogin].latitude;
        if (longtitude > -0.000001 && longtitude < 0.000011 && latitude > -0.000001 && longtitude < 0.0000011) {
            [self performSelector:@selector(searchComunityWithCityIDRequestLocationFailure) withObject:nil afterDelay:0.5];
        }
        else
        {
              [self performSelector:@selector(searchNearbyVillageRequest) withObject:nil afterDelay:0.5];
        }

    }
    
    
}
-(void)searchViewHide
{
    
}
#pragma mark -
#pragma mark System Method

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/


@end
