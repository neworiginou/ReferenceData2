//
//  HWCityViewController.m
//  Community
//
//  Created by caijingpeng.haowu on 14-9-6.
//  Copyright (c) 2014年 caijingpeng. All rights reserved.
//

#import "HWCityViewController.h"
#import "HWCityListCell.h"
#import "HWUserLogin.h"
#import "HWCoreDataManager.h"
@interface HWCityViewController ()
{
    HWSearchBarView *_searchBar;
}
@end

@implementation HWCityViewController
@synthesize cityList;
@synthesize chooseCities;
@synthesize keys;
@synthesize selecedCityId;
@synthesize selecedCityName;
@synthesize hotCityArry;
@synthesize isRegisterChangeCity;
@synthesize cityIdStrTemp;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

-(void)popText
{
    [_searchBar._searchTF resignFirstResponder];
}
//创建搜索为空的页面
-(void)createNoSearchPage
{
    noCommentGpsLocationView = [[UIView alloc]initWithFrame:CGRectMake(0, 50, kScreenWidth, [UIScreen mainScreen].bounds.size.height)];
    noCommentGpsLocationView.backgroundColor = UIColorFromRGB(0xf2f2f2);
    
    UILabel *noGpsCommentLabel = [[UILabel alloc]initWithFrame:CGRectMake(kScreenWidth/2-50, 100, 100, 14)];
    noGpsCommentLabel.backgroundColor = [UIColor clearColor];
    noGpsCommentLabel.text = @"搜索无结果";
    noGpsCommentLabel.textColor = THEME_COLOR_TEXT;
    noGpsCommentLabel.textAlignment = NSTextAlignmentCenter;
    noGpsCommentLabel.font = [UIFont systemFontOfSize:14.0];
    
    UITapGestureRecognizer *tap1 = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(popTemp)];
    [noCommentGpsLocationView addGestureRecognizer:tap1];
    [noCommentGpsLocationView addSubview:noGpsCommentLabel];
    noCommentGpsLocationView.hidden = YES;
    [self.view addSubview:noCommentGpsLocationView];

}
-(void)popTemp
{
    [_searchBar._searchTF resignFirstResponder];
}
- (void)viewDidLoad
{
    [super viewDidLoad];
    self.navigationItem.titleView = [Utility navTitleView:@"选择城市"];
    self.navigationItem.leftBarButtonItem = [Utility navLeftBackBtn:self action:@selector(backMethod)];
    chooseCities = [[NSMutableArray alloc]init];
    self.cityList = [HWUserLogin currentUserLogin].cities;
    [self sortByPinyin:self.cityList];
    [self initialTableView];
    [self initialTableViewTwo];
    [self initialSearchDisplay];
    [self createNoSearchPage];
    //获取定位的ID
    NSString *cityId = [Utility getCityId:[HWUserLogin currentUserLogin].gpsCityName];
    [HWUserLogin currentUserLogin].gpsCityId = cityId;
    [HWCoreDataManager saveUserInfo];
    hotCityArry = [HWUserLogin currentUserLogin].hotArry;
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(handleNotify:) name:pLocatedCityChanged object:nil];
}


#pragma mark -
#pragma mark -AlertViewDelegate Method
-(void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    if (alertView.tag == 5001) {
        if (buttonIndex == 0) {
            [self searchJudgeChangeCityCoodTimeRequest:cityIdStrTemp];
            return;
        }
    }
    switch (buttonIndex) {
        case 1:
            break;
        case 0:
        {
              [self judgeChangeCityCoodTimeRequest:selectCell];
            break;
        }
        default:
            break;
    }
}
/**
 *	@brief	刷新定位
 *
 *	@param 	notify 	通知
 *
 *	@return	void
 
 */
- (void)handleNotify:(NSNotification*)notify
{
    if ([notify.object isKindOfClass:[NSError class]]) {
            [self endRotateImage];
        [Utility showToastWithMessage:@"定位失败" inView:self.view];
            NSLog(@"定位失败");
            return;
    }
    [mainTV reloadData];
    [self endRotateImage];

}

//函数名：- (void)endRotateImage
//功能描述：停止旋转
//输入参数：N/A
//输出参数：N/A
//备注：N/A
//**************************/
/**
 *	@brief	停止旋转
 *
 *	@return	void
 */
- (void)endRotateImage
{
    [_refreshImgV.layer removeAllAnimations];
}

#pragma mark -
#pragma mark Initial View

- (void)initialSearchDisplay
{
    _searchBar = [[HWSearchBarView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, 50)];
    _searchBar.delegate = self;
    _searchBar.frameMaxHeight = self.view.frame.size.height - 64;
    [_searchBar setSearchBarPlaceholder:@"请输入城市中文名称或拼音"];
    _searchBar.cityOrCommunityFlag = NO;//标示回调函数回调给谁
    [self.view addSubview:_searchBar];
}

- (void)initialTableView
{
    mainTV = [[UITableView alloc] initWithFrame:CGRectMake(0, 50, kScreenWidth, CONTENT_HEIGHT - 50.0f) style:UITableViewStylePlain];
    mainTV.delegate = self;
    mainTV.dataSource = self;
    mainTV.separatorStyle = UITableViewCellSeparatorStyleNone;
    [self.view addSubview:mainTV];
}
-(void)initialTableViewTwo
{
    mainSerachTv = [[UITableView alloc] initWithFrame:CGRectMake(0, 50, kScreenWidth, CONTENT_HEIGHT - 50.0f) style:UITableViewStylePlain];
    mainSerachTv.delegate = self;
    mainSerachTv.dataSource = self;
    mainSerachTv.hidden = YES;
    mainSerachTv.separatorStyle = UITableViewCellSeparatorStyleNone;
    [self.view addSubview:mainSerachTv];
}
#pragma mark -
#pragma mark Private Method

/**
 *	@brief	按城市拼音排序
 *
 *	@param 	targetArray 	城市数组
 *
 *	@return	void
 */
- (void)sortByPinyin:(NSArray*)targetArray
{
    self.keys = [[NSMutableArray alloc] init];
    self.list = [[NSMutableDictionary alloc] init];
    
    for(HWCityClass *cityClass in targetArray)
    {
        NSString *firstKey = [cityClass.cityPinyin substringToIndex:1];
        if(self.keys.count == 0)
        {
            [self.keys addObject:firstKey];
            if([self.list objectForKey:firstKey] == nil)
            {
                NSMutableArray *keyArray = [NSMutableArray array];
                [self.list setPObject:keyArray forKey:firstKey];
            }
            NSMutableArray *array = (NSMutableArray*)[self.list objectForKey:firstKey];
            [array addObject:cityClass];
            [self.list setPObject:array forKey:firstKey];
        }
        else
        {
            for(int i = 0; i < self.keys.count; i++)
            {
                NSString *key = [self.keys objectAtIndex:i];
                if([key isEqualToString:firstKey])
                {
                    NSMutableArray *array = (NSMutableArray*)[self.list objectForKey:firstKey];
                    [array addObject:cityClass];
                    [self.list setPObject:array forKey:firstKey];
                    break;
                }
                if(i == self.keys.count - 1)
                {
                    [self.keys addObject:firstKey];
                    if([self.list objectForKey:firstKey] == nil)
                    {
                        NSMutableArray *keyArray = [NSMutableArray array];
                        [self.list setPObject:keyArray forKey:firstKey];
                    }
                    NSMutableArray *array = (NSMutableArray*)[self.list objectForKey:firstKey];
                    [array addObject:cityClass];
                    [self.list setPObject:array forKey:firstKey];
                    break;
                }
            }
        }
    }
    
    self.keys =(NSMutableArray *) [[self.list allKeys] sortedArrayUsingSelector:
                                   @selector(compare:)];
}

#pragma mark -
#pragma mark Search View Delegate

- (void)searchBar:(HWSearchBarView *)searchView textChange:(NSString *)text
{
    if ([_searchBar._searchTF.text length]==0) {
        mainSerachTv.hidden = YES;
        mainTV.hidden = NO;
        noCommentGpsLocationView.hidden = YES;
        [mainTV reloadData];
        return;
    }
    NSString *str = [searchView._searchTF.text lowercaseString];
    
    [chooseCities removeAllObjects];
    //    if (self.searchDisplayController.searchResultsTableView == tableview) {
    for (HWCityClass *cityClass in [HWUserLogin currentUserLogin].cities) {
        NSString *pinyin = cityClass.cityPinyin;
        NSString *cityPinyin = [NSString stringWithString:pinyin];
        if (pinyin.length > 3) {
            cityPinyin = [pinyin substringToIndex:(pinyin.length - 3)];//去掉“市”字拼音
        }
        if ([cityClass.cityName rangeOfString:str].location!=NSNotFound||[cityPinyin rangeOfString:str].location!=NSNotFound) {
            [chooseCities addObject:cityClass];
        }
    }
    if ([chooseCities count]==0) {
        noCommentGpsLocationView.hidden = NO;
        mainTV.hidden = YES;
        mainSerachTv.hidden = YES;
        return;
    }
    mainSerachTv.hidden = NO;
    mainTV.hidden = YES;
    noCommentGpsLocationView.hidden = YES;
    [mainSerachTv reloadData];
    
   

}

- (void)searchBar:(HWSearchBarView *)searchView didSelectSearchResult:(NSString *)text villageId:cityId flag:(BOOL)flag
{
    _searchBar._searchTF.text = text;
}

-(void)searchBarEnd
{
    if ([_searchBar._searchTF.text length] == 0) {
        mainTV.hidden = NO;
        mainSerachTv.hidden = YES;
    }
}
#pragma mark -
#pragma mark TableView Delegate

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    if (tableView == mainTV) {
        return self.keys.count+2;
    }
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (tableView == mainTV) {
        if (section >= 2) {
            NSArray *array = [self.list objectForKey:[self.keys objectAtIndex:(section-2)]];
            return array.count;
        }
        else if(section == 0)
        {
            return 1;
        }
        else
        {
            return [hotCityArry count];
        }

    }
    else
    {
        return [chooseCities count];
    }
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSInteger row = [indexPath row];
    NSInteger section = [indexPath section];
    static NSString *cellIdentifier = @"cell";
    static NSString *cellIdentifierOne = @"cellOne";
    if (tableView == mainTV) {
        HWCityListCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
        if (!cell)
        {
            cell = [[HWCityListCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdentifier];
        }
        if (section >= 2) {
            NSArray *array = [self.list objectForKey:[self.keys objectAtIndex:indexPath.section-2]];
            HWCityClass *city = [array objectAtIndex:indexPath.row];
            
            cell.titleLab.text = city.cityName;
            
        }
        else if(section == 0)
        {
            float longtitude = [HWUserLogin currentUserLogin].longitude;
            float latitude = [HWUserLogin currentUserLogin].latitude ;
            if (longtitude > -0.000001 && longtitude < 0.000001 && latitude > -0.000001 && longtitude < 0.0000001) {
                cell.titleLab.text = @"定位失败";
            }
            else
            {
                cell.titleLab.text = [HWUserLogin currentUserLogin].gpsCityName;
            }
        }
        else
        {
            HWCityClass *city = [hotCityArry objectAtIndex:row];
            cell.titleLab.text = city.cityName;
        }
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        return cell;

    }
    else if(tableView == mainSerachTv)
    {
        HWCityListCell *cellOne = [tableView dequeueReusableCellWithIdentifier:cellIdentifierOne];
        if (!cellOne) {
            cellOne = [[HWCityListCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdentifierOne];
        }
        HWCityClass *cityInfo = [chooseCities objectAtIndex:[indexPath row]];
        cellOne.titleLab.text = cityInfo.cityName;
        cellOne.selectionStyle = UITableViewCellSelectionStyleNone;
        return cellOne;
    }
    return nil;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [self popText];
    if (tableView == mainTV) {
        NSInteger section = [indexPath section];
        if(section == 0)
        {
            float longtitude = [HWUserLogin currentUserLogin].longitude;
            float latitude = [HWUserLogin currentUserLogin].latitude ;
            if (longtitude > -0.000001 && longtitude < 0.000001 && latitude > -0.000001 && longtitude < 0.0000001)
            {
                return;
            }
            else
            {
                if (_selectedCity) {
                    _selectedCity([HWUserLogin currentUserLogin].gpsCityId);
                }
                [self.navigationController popViewControllerAnimated:YES];
                return;
            }
            
        }
        else if(section == 1)
        {
            HWCityClass *cityInfo = [hotCityArry objectAtIndex:[indexPath row]];
            selecedCityId = cityInfo.cityId;
            if (isRegisterChangeCity == YES) {
                [self searchJudgeChangeCityCoodTimeRequest:cityInfo.cityId];
            }
            else
            {
                [self changeCitySerach:selecedCityId];
            }

            return;
        }
        NSArray *array = [self.list objectForKey:[self.keys objectAtIndex:indexPath.section-2]];
        HWCityClass *city = [array objectAtIndex:indexPath.row];
        selecedCityId = city.cityId;
        cityIdStrTemp = city.cityId;
        selectCell = indexPath;
        [tableView deselectRowAtIndexPath:indexPath animated:YES];
        if (isRegisterChangeCity == YES) {
            [self judgeChangeCityCoodTimeRequest:indexPath];
        }
        else
        {
            [self changeCity:selecedCityId];
        }
    }
    else if(tableView == mainSerachTv)
    {
        NSLog(@"%@,%@",[HWUserLogin currentUserLogin].cityId,[HWUserLogin currentUserLogin].cityName);
        
        HWCityClass *cityInfo = [chooseCities objectAtIndex:[indexPath row]];
        selecedCityId = cityInfo.cityId;
        [tableView deselectRowAtIndexPath:indexPath animated:YES];
        if (isRegisterChangeCity == YES) {
             [self searchJudgeChangeCityCoodTimeRequest:selecedCityId];
        }
        else
        {
            if ([[HWUserLogin currentUserLogin].gpsCityId isEqualToString:cityInfo.cityId]) {
                [self searchJudgeChangeCityCoodTimeRequest:cityInfo.cityId];
            }
            else
            {
                [self changeCitySerach:cityInfo.cityId];
            }
        }
       
    }
   
}
- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{

    if (tableView == mainTV) {
        UIView *headerView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, 30)];
        headerView.backgroundColor = UIColorFromRGB(0xf8f8f8);
        
        UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(15, 5, kScreenWidth - 30, 20)];
        label.backgroundColor = [UIColor clearColor];
        label.textColor = THEME_COLOR_TEXT;
        label.font = [UIFont fontWithName:FONTNAME size:13.0f];
        if (section >= 2)
        {
            label.text = [self.keys objectAtIndex:section-2];
        }
        else if(section == 0)
        {
            label.text = @"定位城市";
            
            _refreshImgV = [[UIImageView alloc] initWithFrame:CGRectMake(kScreenWidth - 40 , 7 , 15, 16)];
            _refreshImgV.image = [UIImage imageNamed:@"icon_GPS"];
            [headerView addSubview:_refreshImgV];
            
            UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
            btn.frame = CGRectMake(kScreenWidth - 40, 0, 30, 30);
            btn.backgroundColor = [UIColor clearColor];
            [btn addTarget:self action:@selector(clickGPS:) forControlEvents:UIControlEventTouchUpInside];
            [headerView addSubview:btn];
        }
        else
        {
            label.text = @"热门城市";
        }
        [headerView addSubview:label];
        
        UIView *line = [[UIView alloc] initWithFrame:CGRectMake(0, 30 - 0.5f, kScreenWidth, 0.5f)];
        line.backgroundColor = THEME_COLOR_LINE;
        [headerView addSubview:line];
        return headerView;

    }
    else if(tableView == mainSerachTv)
    {
        return nil;
    }
    return nil;

}
//给tableviewcell添加索引
- (NSArray *)sectionIndexTitlesForTableView:(UITableView *)tableView
{
    if (tableView == mainTV) {
        NSMutableArray *array = [NSMutableArray array];
        [array addObject:@""];
        [array addObject:@""];
        [array addObject:@""];
        for(NSString *str in self.keys){
            [array addObject:[str uppercaseString]];
        }
        return array;
    }
    else
    {
        return nil;
    }
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    if (tableView == mainTV) {
        return 30.0f;
    }
    else
    {
        return 0.0f;
    }
    
}
/**
 *	@brief	点击定位小图标
 *
 *	@param 	sender 	按钮
 *
 *	@return	void
 */
- (void)clickGPS:(id)sender
{
    // 旋转动画 *问题* 定位成功后停止
    
    if ([CLLocationManager authorizationStatus] != kCLAuthorizationStatusAuthorized) {
        //[AppShare alertMB:self.view message:@"定位未开启"];
        NSLog(@"定位未开启");
        return;
    }
    
    [self startRotateImage];
    [[HWUserLogin currentUserLogin]startLocating];
    
}
/**
 *	@brief	定位图标旋转
 *
 *	@return	void
 */
- (void)startRotateImage
{
    CABasicAnimation *a = [CABasicAnimation animationWithKeyPath:@"transform.rotation.z"];
    a.fromValue = [NSNumber numberWithFloat:0.0f];
    a.toValue = [NSNumber numberWithFloat:M_PI*2];
    a.duration = 1.0f;
    a.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut];
    //    a.repeatCount = CGFLOAT_MAX;
    [_refreshImgV.layer addAnimation:a forKey:@"rotate"];
}
#pragma mark - 切换城市冷却时间请求
-(void)judgeChangeCityCoodTimeRequest:(NSIndexPath *)path
{
    HWHTTPRequestOperationManager *manager = [HWHTTPRequestOperationManager manager];
    NSMutableDictionary *dict = [NSMutableDictionary dictionary];
    [dict setPObject:selecedCityId forKey:@"cityId"];
    [dict setPObject:[HWUserLogin currentUserLogin].key forKey:@"key"];
    [manager POST:kCityChangeCoodTime parameters:dict queue:nil success:^(id responseObject){
        NSDictionary *dataDic = (NSDictionary *)responseObject;
        NSString *statusStr = [dataDic stringObjectForKey:@"status"];
        if ([statusStr isEqualToString:@"0"]) {
            NSString *detailStr = [dataDic stringObjectForKey:@"detail"];
            [Utility showAlertWithMessage:detailStr];
        }
        else if([statusStr isEqualToString:@"1"])
        {
            [self returnCityId:path];
        }
        NSLog(@"sucess");
    }failure:^(NSString *code, NSString *error) {
        [Utility showToastWithMessage:error inView:self.view];
        NSLog(@"error");
    }];
    
}
//非登录情况下选择城市
-(void)changeCity:(NSString *)cityIdStr
{
    cityIdStrTemp = cityIdStr;
    if ([[HWUserLogin currentUserLogin].gpsCityId isEqualToString:cityIdStr]) {
        if (_selectedCity) {
            _selectedCity(cityIdStrTemp);
        }
        [self.navigationController popViewControllerAnimated:YES];
        return;
    }
    UIAlertView *tipAlerView = [[UIAlertView alloc]initWithTitle:@"" message:@"切换城市后需要等待30天才能再次切换，是否继续？" delegate:self cancelButtonTitle:@"切换" otherButtonTitles:@"不切换", nil];
    tipAlerView.tag = 5000;
    [tipAlerView show];
}

-(void)changeCitySerach:(NSString *)cityIdStr
{
    cityIdStrTemp = cityIdStr;
    if ([[HWUserLogin currentUserLogin].cityId isEqualToString:cityIdStr]) {
        if (_selectedCity) {
            _selectedCity(cityIdStrTemp);
        }
        [self.navigationController popViewControllerAnimated:YES];
        return;
    }

    UIAlertView *tipAlerView = [[UIAlertView alloc]initWithTitle:@"" message:@"切换城市后需要等待30天才能再次切换，是否继续？" delegate:self cancelButtonTitle:@"切换" otherButtonTitles:@"不切换", nil];
    tipAlerView.tag = 5001;
    [tipAlerView show];
}

#pragma mark - 切换城市冷却时间请求
-(void)searchJudgeChangeCityCoodTimeRequest:(NSString *)cityId
{
    if (!cityId) {
        [Utility showToastWithMessage:@"城市ID不能为空" inView:self.view];
        return;
    }
    HWHTTPRequestOperationManager *manager = [HWHTTPRequestOperationManager manager];
    NSMutableDictionary *dict = [NSMutableDictionary dictionary];
    [dict setPObject:cityId forKey:@"cityId"];
    [dict setPObject:[HWUserLogin currentUserLogin].key forKey:@"key"];
    [manager POST:kCityChangeCoodTime parameters:dict queue:nil success:^(id responseObject){
        NSDictionary *dataDic = (NSDictionary *)responseObject;
        NSString *statusStr = [dataDic stringObjectForKey:@"status"];
        if ([statusStr isEqualToString:@"0"]) {
            NSString *detailStr = [dataDic stringObjectForKey:@"detail"];
            [Utility showAlertWithMessage:detailStr];
        }
        else if([statusStr isEqualToString:@"1"])
        {
            if (_selectedCity) {
                _selectedCity(cityId);
            }
            [self.navigationController popViewControllerAnimated:YES];
        }
        NSLog(@"sucess");
    }failure:^(NSString *code, NSString *error) {
        [Utility showToastWithMessage:error inView:self.view];
        NSLog(@"error");
    }];
    
}

//热门城市

//返回城市id
-(void)returnCityId:(NSIndexPath *)indexPath
{
    NSArray *array = [self.list objectForKey:[self.keys objectAtIndex:indexPath.section-2]];
    HWCityClass *city = [array objectAtIndex:indexPath.row];
    selecedCityName = city.cityName;
//    if (selecedCityId)
//    {
//        [HWUserLogin currentUserLogin].cityId = selecedCityId;
//        [HWUserLogin currentUserLogin].cityName = selecedCityName;
//        [HWCoreDataManager saveUserInfo];
//    }
    if (_selectedCity) {
        _selectedCity(selecedCityId);
    }
    [self.navigationController popViewControllerAnimated:YES];
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
