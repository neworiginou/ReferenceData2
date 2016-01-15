//
//  SelectSexViewController.m
//  Community
//
//  Created by gusheng on 14-9-6.
//  Copyright (c) 2014年 caijingpeng. All rights reserved.
//

#import "HWSelectSexViewController.h"
#import "HWModifyGenderView.h"

@interface HWSelectSexViewController ()<HWModifyGenderViewDelegate>

@end

@implementation HWSelectSexViewController

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
    self.navigationItem.leftBarButtonItem = [Utility navLeftBackBtn:self action:@selector(backMethod)];
    self.navigationItem.titleView = [Utility navTitleView:@"设置性别"];
    
    HWModifyGenderView *modifyView = [[HWModifyGenderView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, CONTENT_HEIGHT)];
    modifyView.delegate = self;
    [self.view addSubview:modifyView];
    
}

#pragma mark -
#pragma mark        HWModifyGenderView Delegate

- (void)modifyGenderSuccess
{
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
