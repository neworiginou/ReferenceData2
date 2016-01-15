//
//  HWMonthRepaymentViewController.m
//  HaoWuAgenciesEdition
//
//  Created by gusheng on 14-7-10.
//  Copyright (c) 2014年 ZhuMing. All rights reserved.
//

#import "HWMonthRepaymentViewController.h"
#import "Define-OC.h"

@interface HWMonthRepaymentViewController ()

@end

@implementation HWMonthRepaymentViewController

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
    self.view.backgroundColor = [UIColor whiteColor];
//    if ([Utility iosIOS7]) {
//        self.navigationController.edgesForExtendedLayout = UIRectEdgeNone;
//    }
    self.navigationItem.titleView = [Utility navTitleView:@"房贷计算器"];
    
   
     self.navigationItem.leftBarButtonItem = [Utility navLeftBackBtn:self action:@selector(backBtn:)];
    HWExpendTableView* expendView = [[HWExpendTableView alloc]initWithFrame:CGRectMake(self.view.frame.origin.x, self.view.frame.origin.y, self.view.frame.size.width,self.view.frame.size.height)];
        expendView.expendTab.frame = CGRectMake(self.view.frame.origin.x, self.view.frame.origin.y, self.view.frame.size.width,self.view.frame.size.height-64);
    expendView.backgroundColor = [UIColor clearColor];
    expendView.hidden = NO;
    expendView.nameAry = self.nameArray_2;
    expendView.dataAry = self.dataArray_2;
    [self.view addSubview:expendView];
    
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
