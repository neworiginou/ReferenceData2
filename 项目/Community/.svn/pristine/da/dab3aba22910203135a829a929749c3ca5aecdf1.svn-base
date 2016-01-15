//
//  HWProvinceViewController.m
//  HaoWu_4.0
//
//  Created by zhuming on 14-5-31.
//  Copyright (c) 2014年 caijingpeng. All rights reserved.
//

#import "HWProvinceViewController.h"

@interface HWProvinceViewController ()

@property(nonatomic,strong)NSMutableArray *list;

@end

@implementation HWProvinceViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}
- (void)doBack:(id)sender
{
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.navigationItem.leftBarButtonItem = [Utility navLeftBackBtn:self action:@selector(doBack:)];
//    self.navigationItem.title = @"省份列表";
    self.navigationItem.titleView =[Utility navTitleView:@"省份列表"];
    self.view.backgroundColor = [UIColor whiteColor];
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
//    self.tableView.backgroundColor = [Utility customGrayColor];
    [self queryListData];
}

- (void)queryListData {
    
    self.list = [NSMutableArray array];
    
    [Utility showMBProgress:self.view message:@"获取数据"];
    HWHTTPRequestOperationManager *manager = [HWHTTPRequestOperationManager societyManager];
    NSMutableDictionary *dict = [NSMutableDictionary dictionary];
    [dict setPObject:[HWUserLogin currentUserLogin].key forKey:@"key"];
    [dict setPObject:@"1" forKey:@"channel"];
    [manager POST:GetProvinceList parameters:dict queue:nil success:^(id responseObject) {
        
        [Utility hideMBProgress:self.view];
        //NSLog(@"team suc %@",[responseObject JSONString]);
        NSArray *array = [[responseObject dictionaryObjectForKey:@"data"] arrayObjectForKey:@"content"];
        [self.list addObjectsFromArray:array];
        [self.tableView reloadData];
        
    } failure:^(NSString *code, NSString *error) {
        //NSLog(@"team err:%@",[error description]);
        [Utility hideMBProgress:self.view];
    }];
    
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSDictionary *cellDict = (NSDictionary*)[self.list objectAtIndex:indexPath.row];
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell"];
    
    if (!cell)
    {
        cell = [[UITableViewCell alloc]init];
        UIView *line = [[UIView alloc] initWithFrame:CGRectMake(0, 45 - 0.5f, kScreenWidth, 0.5f)];
        line.backgroundColor = THEME_COLOR_LINE;
        [cell.contentView addSubview:line];
    }
    cell.textLabel.font =[UIFont fontWithName:FONTNAME size:15];
    cell.textLabel.textColor = THEME_COLOR_SMOKE;
    cell.textLabel.text = [cellDict stringObjectForKey:@"provinceName"];
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
    if (_Province) {
        _Province(self.list[indexPath.row]);
    }
    [self.navigationController popViewControllerAnimated:YES];
}

@end
