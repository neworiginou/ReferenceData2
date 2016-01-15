//
//  HWClickTableViewReturnViewController.m
//  HaoWuAgenciesEdition
//
//  Created by gusheng on 14-7-11.
//  Copyright (c) 2014年 ZhuMing. All rights reserved.
//

#import "HWClickTableViewReturnViewController.h"
#import "HWGeneralTableViewCell.h"
#import "Partner_Swift-Swift.h"
#import "Define-OC.h"
@interface HWClickTableViewReturnViewController ()

@end

@implementation HWClickTableViewReturnViewController
@synthesize dataArry,typeStr;
- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.view.backgroundColor = UIColorFromRGB(0xf5f5f5);
    if (IOS7) {
        self.navigationController.edgesForExtendedLayout = UIRectEdgeNone;
    }
    
    self.navigationItem.titleView = [Utility navTitleView:@"房贷计算器"];
    self.navigationItem.leftBarButtonItem = [Utility navLeftBackBtn:self _selector:@selector(backBtn:)];
    
    UITableView *mainTableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, kScreenWidth, 40*[dataArry count]+10+0.5) style:UITableViewStylePlain];
    
    if (40*[dataArry count]+64>self.view.frame.size.height) {
        if (IOS7) {
             mainTableView.frame = CGRectMake(0, 0, kScreenWidth, self.view.frame.size.height-63.5);
        }
        else{
             mainTableView.frame = CGRectMake(0, 0, kScreenWidth, self.view.frame.size.height - 63.5+20);
        }
    }
    mainTableView.delegate = self;
    mainTableView.dataSource = self;
    mainTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    [self.view addSubview:mainTableView];
    [self createFooterView:mainTableView];
    [self createHeaderView:mainTableView];
  
}
/**
 *	@brief	创建tableview的FootView
 *
 *	@param 	tableView
 *
 *	@return	 无
 */
-(void)createFooterView:(UITableView *)tableView
{
    UIView *sectionBackView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, kScreenWidth, 0.5)];
    sectionBackView.backgroundColor = [UIColor clearColor];
    UIImageView *lineTwoImage = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, kScreenWidth, 0.5)];
    [lineTwoImage setBackgroundColor:UIColorFromRGB(0xbfbfbf)];
    [sectionBackView addSubview:lineTwoImage];
    tableView.tableFooterView = sectionBackView;
}

/**
 *	@brief	创建tableViewHeadView
 *
 *	@param 	tableView
 *
 *	@return	 无
 */
-(void)createHeaderView:(UITableView *)tableView
{
    UIView *sectionBackView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, kScreenWidth, 10)];
    sectionBackView.backgroundColor = UIColorFromRGB(0xf5f5f5);
    UIImageView *lineTwoImage = [[UIImageView alloc]initWithFrame:CGRectMake(0, 9.5, kScreenWidth, 0.5)];
    [lineTwoImage setBackgroundColor:UIColorFromRGB(0xbfbfbf)];
    [sectionBackView addSubview:lineTwoImage];
    tableView.tableHeaderView = sectionBackView;
}
#pragma tableviewDelegates

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return [self.dataArry count];
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 40.0f;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    HWGeneralTableViewCell *cell = (HWGeneralTableViewCell *)[tableView dequeueReusableCellWithIdentifier:@"firstCell"];
    if (!cell) {
        cell = [[HWGeneralTableViewCell alloc] init];
    }
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    cell.textLabel.text = [self.dataArry objectAtIndex:[indexPath row]];
    cell.textLabel.textColor = UIColorFromRGB(0x666666);
    cell.textLabel.font = [UIFont fontWithName:FONTNAME size:14];
    cell.backgroundColor = [UIColor whiteColor];
    NSInteger row = [indexPath row];
    NSInteger index = [self.dataArry indexOfObject:typeStr];
    if (row == index) {
        cell.accessoryView.hidden = NO;
    }
    else{
        cell.accessoryView.hidden = YES;
    }
    if (row == [self.dataArry count]-1) {
        cell.lineImage.hidden = YES;
    }
    return cell;

}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSInteger row = [indexPath row];
   if(_returnSelectedResult)
   {
       _returnSelectedResult([self.dataArry objectAtIndex:row],row);
       [self.navigationController popViewControllerAnimated:YES];
   }
    
}

/**
 *	@brief	返回上一级
 *
 *	@param 	sender
 *
 *	@return	  无
 */
-(void)backBtn:(id)sender
{
    [self.navigationController popViewControllerAnimated:YES];
}
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
