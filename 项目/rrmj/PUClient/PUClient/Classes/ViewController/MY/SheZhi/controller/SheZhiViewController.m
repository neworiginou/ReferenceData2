//
//  SheZhiViewController.m
//  PUClient
//
//  Created by lizhongqiang on 15/7/30.
//  Copyright (c) 2015年 RRLhy. All rights reserved.
//

#import "SheZhiViewController.h"
#import "SheZhiTableViewCell.h"
#import "CustomColorViewController.h"
#import "Switch.h"
#import "FeedbackViewController.h"
#import "AboutViewController.h"
#import "ClearCache.h"
#import "AppDelegate.h"
@interface SheZhiViewController ()
@property (nonatomic, strong)NSArray *dataArray;
@property (nonatomic, strong)CADisplayLink *timeLink;

@end

@implementation SheZhiViewController
static NSString *cellId = @"SheZhiCellId";

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.navigationItem.title = @"设置";
    
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    [self initDataArray];
    
    
}
- (void)viewWillAppear:(BOOL)animated
{
    if(_timeLink != nil)
    {
        [_timeLink setPaused:NO];
    }
}
- (void)viewWillDisappear:(BOOL)animated
{
    if(_timeLink != nil)
    {
        [_timeLink setPaused:YES];
    }
}
- (void)changeCacheLabel
{
    SheZhiTableViewCell *cell = (SheZhiTableViewCell *)[self.tableView cellForRowAtIndexPath:[NSIndexPath indexPathForItem:2 inSection:0]];
    if(cell != nil)
    {
        UILabel *label = (UILabel *)cell.accessoryView;
        label.text = [ClearCache cathSize];
    }
    NSLog(@"%f",_timeLink.timestamp);
}
- (void)initDataArray
{
    _dataArray = @[@{@"title":@"自定义色彩",@"subTitle":@"自定义我的色彩"},@{@"title":@"推送消息",@"subTitle":@"精彩内容马上知道"},@{@"title":@"清楚缓存",@"subTitle":@"清理系统缓存，释放更多空间"},@{@"title":@"网络提示",@"subTitle":@"在WIFI环境下观看或下载电影提示"},@{@"title":@"意见反馈",@"subTitle":@""},@{@"title":@"关于",@"subTitle":@""}];
   
    [self.tableView reloadData];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return _dataArray.count;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    SheZhiTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellId];
    
    cell.titleLabel.hidden = NO;
    cell.titleLabel.text = _dataArray[indexPath.row][@"title"];
    //cell.textLabel.text = @"";
    cell.detailLabel.text = _dataArray[indexPath.row] [@"subTitle"];
    if(!cell.detailLabel.text.length)
    {
        cell.titleLabel.hidden = YES;
        
        cell.textLabel.text = [NSString stringWithFormat:@" %@",_dataArray[indexPath.row][@"title"]];
    }
    if(indexPath.row == 0)
    {
        cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    }
    if(indexPath.row == 1||indexPath.row == 3)
    {
        Switch *mySwitch = [[Switch alloc]init];
     
        AppDelegate *appDelegate = (AppDelegate *)[UIApplication sharedApplication].delegate;
        switch (indexPath.row) {
            case 1:
                mySwitch.on = appDelegate.pushOn;
                break;
                
            default:
                mySwitch.on = appDelegate.wifiOn;
                break;
        }
        mySwitch.tag = 100+indexPath.row;
//        UIView *view = [[UIView alloc]init];
//        [view addSubview:mySwitch];
        [mySwitch addTarget:self action:@selector(switchState:) forControlEvents:UIControlEventValueChanged];
        cell.accessoryView = mySwitch;
    }
    if(indexPath.row == 2)
    {
        UILabel *label = [[UILabel alloc]init];
        label.frame = CGRectMake(0, 0, 100, 20);
        cell.accessoryView = label;
        label.textAlignment = NSTextAlignmentRight;
        label.font = cell.detailLabel.font;
        label.textColor = cell.detailLabel.textColor;
        label.text = [ClearCache cathSize];
        
        if(_timeLink == nil)
        {
            CADisplayLink *link = [CADisplayLink displayLinkWithTarget:self selector:@selector(changeCacheLabel)];
            [link addToRunLoop:[NSRunLoop currentRunLoop] forMode:NSDefaultRunLoopMode];
            link.frameInterval = 60;
            _timeLink = link;
        }
        
        
    }
    
    cell.detailLabel.textColor = [UIColor grayColor];
    
    return cell;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 200/3.f;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
   UIStoryboard *story = [UIStoryboard storyboardWithName:@"Main" bundle:[NSBundle mainBundle]];
   
    
    if(indexPath.row == 0)
    {
        CustomColorViewController *customVC = [story instantiateViewControllerWithIdentifier:@"CustomColorViewControllerId"];
        [self.navigationController pushViewController:customVC animated:YES];
    }
    
    if(indexPath.row == 4)
    {
        FeedbackViewController *feedbackVC = [story instantiateViewControllerWithIdentifier:@"FeedbackViewControllerId"];
        [self.navigationController pushViewController:feedbackVC animated:YES];
    }
    if(indexPath.row == 5)
    {
        AboutViewController *aboutVC = [story instantiateViewControllerWithIdentifier:@"AboutViewControllerId"];
        [self.navigationController pushViewController:aboutVC animated:YES];
    }
    if(indexPath.row == 2)
    {
        [ClearCache  clearCache];
        SheZhiTableViewCell *cell = (SheZhiTableViewCell *)[self.tableView cellForRowAtIndexPath:[NSIndexPath indexPathForItem:2 inSection:0]];
        UILabel *label = (UILabel *)cell.accessoryView;
        label.text = [ClearCache cathSize];
    }
}
- (void)switchState:(UISwitch *)mySwitch
{
    AppDelegate *appDelegate = (AppDelegate *)[UIApplication sharedApplication].delegate;
    if(mySwitch.tag == 101)
    {
        
        
        appDelegate.pushOn = mySwitch.on;
    }
    if(mySwitch.tag == 103)
    {
        appDelegate.wifiOn = mySwitch.on;
    }
}
- (void)didReceiveMemoryWarning {
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
