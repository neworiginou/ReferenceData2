//
//  HWFangZuHeVC.m
//  UtilityDemo
//
//  Created by lizhongqiang on 15/7/6.
//  Copyright (c) 2015年 hw. All rights reserved.
//

#import "HWFangZuHeVC.h"
#import "HWTableViewCell.h"

@interface HWFangZuHeVC ()<UITableViewDataSource,UITableViewDelegate>

@property (nonatomic, strong)UITableView *tableView;

@end

@implementation HWFangZuHeVC


- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
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
    {
        switch (self.selectedRow) {
           
                case 0:
                        self.paymentIndex = indexPath.row;
                        break;
                
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
    if(self.reloadForTableView)
    {
        self.reloadForTableView();
    }
    [self.navigationController popToRootViewControllerAnimated:YES];
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
