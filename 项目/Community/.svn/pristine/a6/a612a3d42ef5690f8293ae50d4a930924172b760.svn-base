//
//  HWbankViewController.m
//  HaoWu_4.0
//
//  Created by zhuming on 14-5-31.
//  Copyright (c) 2014年 caijingpeng. All rights reserved.
//

#import "HWbankViewController.h"
#import "HWBankCell.h"

@interface HWbankViewController ()

@end

@implementation HWbankViewController

- (void)doBack:(id)sender
{
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.navigationItem.leftBarButtonItem = [Utility navLeftBackBtn:self action:@selector(doBack:)];
//    self.navigationItem.title = @"银行列表";
    self.navigationItem.titleView =[Utility navTitleView:@"银行列表"];
    
    self.baseTableView.frame = CGRectMake(0, 0, kScreenWidth, CONTENT_HEIGHT);
    self.baseTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    self.isNeedHeadRefresh = YES;
    
    [self queryListData];
}

- (void)queryListData {
    
    [Utility showMBProgress:self.view message:LOADING_TEXT];
    HWHTTPRequestOperationManager *manager = [HWHTTPRequestOperationManager societyManager];
    NSMutableDictionary *param = [NSMutableDictionary dictionary];
    [param setPObject:@"1" forKey:@"channel"];
    [param setObject:[HWUserLogin currentUserLogin].key forKey:@"key"];
    [manager POST:GetBankList parameters:param queue:nil success:^(id responseObject) {
        [Utility hideMBProgress:self.view];
//        //NSLog(@"team suc %@",[responseObject JSONString]);
        if(_currentPage == 0)
            [self.dataList removeAllObjects];
        NSArray *array = [[responseObject dictionaryObjectForKey:@"data"] arrayObjectForKey:@"content"];
        if(array.count < kPageCount)
        {
            isLastPage = YES;
        }
        else
        {
            isLastPage = NO;
        }
        [self.dataList addObjectsFromArray:array];
        
        [baseTableView reloadData];
        if(self.dataList.count == 0)
        {
//            [self showEmpty];
        }
        [self doneLoadingTableViewData];
    } failure:^(NSString *code, NSString *error) {
//        //NSLog(@"team err:%@",[error description]);
        [Utility hideMBProgress:self.view];
        [self doneLoadingTableViewData];
        if (_currentPage == 1 && self.dataList.count == 0)
        {
//            [self showEmpty];
        }
    }];
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSDictionary *cellDict = (NSDictionary*)[self.dataList pObjectAtIndex:indexPath.row];
    
    HWBankCell *cell = (HWBankCell *)[tableView dequeueReusableCellWithIdentifier:@"cell"];
    
    if (!cell) {
        cell = [[HWBankCell alloc]init];
    }
    [cell.iconImageView setImageWithURL:[NSURL URLWithString:[cellDict stringObjectForKey:@"iconUrl"]] placeholderImage:[UIImage imageNamed:@"redDefault"]];
    cell.bankNameLabel.text = [cellDict stringObjectForKey:@"name"];
    
    return cell;
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 50.0;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.dataList.count;
}


- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    HWBankCell *cell = (HWBankCell *)[tableView cellForRowAtIndexPath:indexPath];
//    cell.accessoryType = UITableViewCellAccessoryCheckmark;
    UIImageView *imgV = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 22, 22)];
    imgV.image = [UIImage imageNamed:@"housecheck"];
    //                cell.accessoryType = UITableViewCellAccessoryCheckmark;
    cell.accessoryView = imgV;
    if (_setBank) {
        _setBank(self.dataList[indexPath.row]);
    }
    [self.navigationController popViewControllerAnimated:YES];
}

@end
