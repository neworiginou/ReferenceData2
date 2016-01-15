//
//  HWAddShopViewController.m
//  Community
//
//  Created by caijingpeng.haowu on 14-12-9.
//  Copyright (c) 2014年 caijingpeng. All rights reserved.
//

#import "HWAddShopViewController.h"
#import "HWShopInputViewController.h"
#import "HWAddShopNumModel.h"
#import "HWAddShopNumCell.h"
@interface HWAddShopViewController ()

@end

@implementation HWAddShopViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.navigationItem.titleView = [Utility navTitleView:@"添加商店"];
    self.navigationItem.leftBarButtonItem = [Utility navLeftBackBtn:self action:@selector(backMethod)];
    self.dataList = [[NSMutableArray alloc]init];
    [self queryListData];
}

- (void)queryListData
{
    HWHTTPRequestOperationManager *manage = [HWHTTPRequestOperationManager manager];
    NSMutableDictionary *dict = [[NSMutableDictionary alloc] init];
    [dict setPObject:[HWUserLogin currentUserLogin].key forKey:@"key"];
    
    [manage POST:kShopType parameters:dict queue:nil success:^(id responseObject) {
        
        NSArray *respList = [[responseObject dictionaryObjectForKey:@"data"] arrayObjectForKey:@"content"];
        for (NSDictionary *dic in respList) {
            HWAddShopNumModel *model = [[HWAddShopNumModel alloc]initShopNumWithDic:dic];
            [self.dataList addObject:model];
        }
        [baseTableView reloadData];
        
    } failure:^(NSString *code, NSString *error) {
        NSLog(@"error %@",error);
    }];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.dataList.count;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 50.0f;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    HWAddShopNumCell *cell = (HWAddShopNumCell *)[tableView dequeueReusableCellWithIdentifier:@"cell"];
    if (!cell)
    {
        cell = [[HWAddShopNumCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"cell"];
        
        UIView *line = [[UIView alloc] initWithFrame:CGRectMake(0, 50.0f - 0.5f, kScreenWidth, 0.5f)];
        line.backgroundColor = THEME_COLOR_LINE;
        [cell.contentView addSubview:line];
    }
    
    
        HWAddShopNumModel *model = self.dataList[indexPath.row];
    
        cell.model = model;
    
    [cell setNeedsLayout];
    
    cell.accessoryView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"arrow"]];
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    [MobClick event:@"click_haomaleibie"];
    
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    HWShopInputViewController *inputVC = [[HWShopInputViewController alloc] init];
    [self.navigationController pushViewController:inputVC animated:YES];
    HWAddShopNumModel *model =self.dataList[indexPath.row];
    inputVC.model = model;

    
    
}


@end
