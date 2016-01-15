//
//  HWCityViewController.m
//  HaoWu_4.0
//
//  Created by zhuming on 14-6-1.
//  Copyright (c) 2014年 caijingpeng. All rights reserved.
//

#import "HWCityListViewController.h"
#import "Partner_Swift-Swift.h"
#import "Define-OC.h"

@interface HWCityListViewController ()
@property(nonatomic,strong)NSMutableArray *list;

@end

@implementation HWCityListViewController
@synthesize province_id;

- (void)doBack:(id)sender
{
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)viewDidLoad
{
    [super viewDidLoad];

//    self.navigationItem.leftBarButtonItem = [Utility navLeftBackBtn:self action:@selector(doBack:)];
    self.navigationItem.leftBarButtonItem = [Utility navLeftBackBtn:self _selector:@selector(doBack:)];
    self.navigationItem.titleView =[Utility navTitleView:@"城市列表"];
    self.view.backgroundColor = [UIColor whiteColor];
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    
    [self queryListData];
}

- (void)queryListData {
    
    self.list = [NSMutableArray array];
    
//    [Utility showMBProgress:self.view message:LOADING_TEXT];
    
    HWHttpRequestOperationManager *manager = [HWHttpRequestOperationManager baseManager];
    NSMutableDictionary *dict = [NSMutableDictionary dictionary];
    [dict setPObject:[HWUserLogin currentUserLogin].key forKey:@"key"];
//    [dict setPObject:@(_province_id) forKey:@"province_id"];
//    [dict setPObject:@"1" forKey:@"channel"];
    
    [manager postHttpRequest:GetProvinceAndCity parameters:dict queue:nil success:^(NSDictionary *responseObject) {
        [Utility hideMBProgress:self.view];
        //查找当前省的城市
        NSArray *arrCity = [[NSArray alloc] init];
        NSArray *array = [[responseObject dictionaryObjectForKey:@"data"] arrayObjectForKey:@"json"];
        for (int i = 0; i < array.count; i ++)
        {
            NSString *proId = [[array objectAtIndex:i] stringObjectForKey:@"id"];
//            NSLog(@"获取到的id = %@  要比较的id = %@",proId,province_id);
            if ([proId isEqualToString:province_id]) {
                arrCity = [[array objectAtIndex:i] arrayObjectForKey:@"citys"];
                break;
            }
        }
        //        //NSLog(@"arr = %@",[array JSONString]);
        [self.list addObjectsFromArray:arrCity];
        [self.tableView reloadData];
    } failure:^(NSString *code, NSString *error) {
        [Utility hideMBProgress:self.view];
    }];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSDictionary *cellDict = (NSDictionary*)[self.list objectAtIndex:indexPath.row];
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell"];
    
    if (!cell) {
        cell = [[UITableViewCell alloc]init];
        UIView *line = [[UIView alloc] initWithFrame:CGRectMake(0, 45 - 0.5f, kScreenWidth, 0.5f)];
        line.backgroundColor = CD_LineColor;
        [cell.contentView addSubview:line];
    }
    cell.textLabel.font =[UIFont fontWithName:FONTNAME size:15];
#warning color
//    cell.textLabel.textColor = THEME_COLOR_SMOKE;
    cell.textLabel.text = [cellDict stringObjectForKey:@"city_name"];
    return cell;
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 45.0;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.list.count;
}


- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    UITableViewCell *cell = [tableView cellForRowAtIndexPath:indexPath];
//    cell.accessoryType = UITableViewCellAccessoryCheckmark;
    UIImageView *imgV = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 22, 22)];
    imgV.image = [UIImage imageNamed:@"housecheck.png"];
    //                cell.accessoryType = UITableViewCellAccessoryCheckmark;
    cell.accessoryView = imgV;
    if (_City)
    {
        _City(self.list[indexPath.row]);
    }
    [self.navigationController popViewControllerAnimated:YES];
}

@end
