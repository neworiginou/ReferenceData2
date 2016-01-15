//
//  HWCityViewController.m
//  HaoWu_4.0
//
//  Created by zhuming on 14-6-1.
//  Copyright (c) 2014年 caijingpeng. All rights reserved.
//

#import "HWCityListViewController.h"

@interface HWCityListViewController ()
@property(nonatomic,strong)NSMutableArray *list;

@end

@implementation HWCityListViewController

- (void)doBack:(id)sender
{
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.navigationItem.leftBarButtonItem = [Utility navLeftBackBtn:self action:@selector(doBack:)];
    self.navigationItem.titleView =[Utility navTitleView:@"城市列表"];
    self.view.backgroundColor = [UIColor whiteColor];
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    
    [self queryListData];
}

- (void)queryListData {
    
    self.list = [NSMutableArray array];
    
    [Utility showMBProgress:self.view message:LOADING_TEXT];
    HWHTTPRequestOperationManager *manager = [HWHTTPRequestOperationManager societyManager];
    NSMutableDictionary *dict = [NSMutableDictionary dictionary];
    [dict setPObject:[HWUserLogin currentUserLogin].key forKey:@"key"];
    [dict setPObject:@(_province_id) forKey:@"province_id"];
    [dict setPObject:@"1" forKey:@"channel"];
    
    [manager POST:GetCityList parameters:dict queue:nil success:^(id responseObject) {
        
        [Utility hideMBProgress:self.view];
        NSArray *array = [[responseObject dictionaryObjectForKey:@"data"] arrayObjectForKey:@"content"];
//        //NSLog(@"arr = %@",[array JSONString]);
        [self.list addObjectsFromArray:array];
        [self.tableView reloadData];
        
    } failure:^(NSString *code, NSString *error) {
//        //NSLog(@"team err:%@",[error description]);
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
        line.backgroundColor = THEME_COLOR_LINE;
        [cell.contentView addSubview:line];
    }
    cell.textLabel.font =[UIFont fontWithName:FONTNAME size:15];
    cell.textLabel.textColor = THEME_COLOR_SMOKE;
    cell.textLabel.text = [cellDict stringObjectForKey:@"cityName"];
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
    imgV.image = [UIImage imageNamed:@"housecheck"];
    //                cell.accessoryType = UITableViewCellAccessoryCheckmark;
    cell.accessoryView = imgV;
    if (_City)
    {
        _City(self.list[indexPath.row]);
    }
    [self.navigationController popViewControllerAnimated:YES];
}

@end
