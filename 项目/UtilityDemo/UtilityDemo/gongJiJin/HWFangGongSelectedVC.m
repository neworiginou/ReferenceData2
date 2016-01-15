//
//  HWFangGongSelectedVC.m
//  UtilityDemo
//
//  Created by lizhongqiang on 15/7/3.
//  Copyright (c) 2015年 hw. All rights reserved.
//

#import "HWFangGongSelectedVC.h"
#import "HWTableViewCell.h"

@interface HWFangGongSelectedVC ()<UITableViewDataSource,UITableViewDelegate>
@property (nonatomic, strong)UITableView *tableView;
@end

@implementation HWFangGongSelectedVC

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.navigationItem.hidesBackButton = YES;
    
    UILabel *label = [[UILabel alloc]init];
    
    label.font = [UIFont systemFontOfSize:16];
    
    label.frame = CGRectMake(0, 0, 100, 20);
    
    label.text = @"房贷计算器";
    
    self.navigationItem.titleView = label;
    
}
- (void)loadView
{
    _tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 64+20, kScreenWidth, [UIScreen mainScreen].bounds.size.height - 64 -10 ) style:UITableViewStylePlain];
    
    _tableView.dataSource = self;
    
    _tableView.delegate = self;
    
    self.view = _tableView;
}
- (void)viewWillAppear:(BOOL)animated
{
    
    [_tableView reloadData];
}

-  (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    
    return _dataArray.count;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *selectId = @"cellSelectedId";
    
    HWTableViewCell *cell = [_tableView dequeueReusableCellWithIdentifier:selectId];
    
    if(cell == nil)
    {
        cell = [[HWTableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:selectId];;
    }
    cell.textLabel.text = _dataArray[indexPath.row];
    
    return cell;
    
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    if(self.selectedRow == 1)
    {
        self.compentIndex = indexPath.row;
    }
    else if(self.selectedRow == 0)
    {
        self.paymentIndex = indexPath.row;
    }
    else
    {
        switch (self.compentIndex) {
            case 0:
            {
                switch (self.selectedRow) {
                    case 3:
                        self.anjieYearIndex = indexPath.row;
                        
                        break;
                    case 4:
                        self.rateIndex = indexPath.row;
                        
                        break;
                    default:
                        break;
                }
            }
                
                break;
            case 1:
            {
                switch (self.selectedRow) {
                    case 4:
                        self.anjieCountIndex = indexPath.row;
                        
                        break;
                    case 5:
                        self.anjieYearIndex = indexPath.row;
                        
                        break;
                    case 6:
                        self.rateIndex = indexPath.row;
                        
                        break;
                        
                    default:
                        break;
                }
            }
                break;
                
            default:
                break;
        }
    }
    if(self.reloadForTableView)
    {
        self.reloadForTableView(self.compentIndex);
    }
    
    [self.navigationController popToRootViewControllerAnimated:YES];
}


@end
