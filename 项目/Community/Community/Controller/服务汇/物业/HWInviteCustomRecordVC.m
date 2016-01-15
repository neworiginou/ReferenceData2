//
//  HWInviteCustomRecordVC.m
//  Community
//
//  Created by niedi on 15/6/13.
//  Copyright (c) 2015年 caijingpeng. All rights reserved.
//

#import "HWInviteCustomRecordVC.h"
#import "HWCustomSegmentControl.h"
#import "HWInviteCustomRecordView.h"
#import "HWInviteCustomRecord1View.h"

@interface HWInviteCustomRecordVC ()<HWCustomSegmentControlDelegate, HWInviteCustomRecord1ViewDelegate, HWInviteCustomRecordViewDelegate>
{
    int _selectedIndex;
    HWInviteCustomRecordView *_mainView;
    HWInviteCustomRecord1View *_scdView;
}
@end

@implementation HWInviteCustomRecordVC

- (void)viewWillAppear:(BOOL)animated
{
    MLNavigationController *navigation = (MLNavigationController *)self.navigationController;
    navigation.canDragBack = NO;
}

- (void)viewWillDisappear:(BOOL)animated
{
    MLNavigationController *navigation = (MLNavigationController *)self.navigationController;
    navigation.canDragBack = YES;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    _selectedIndex = 0;
    
    HWCustomSegmentControl *segmentControl = [[HWCustomSegmentControl alloc]initWithTitles:[NSArray arrayWithObjects:@"普通访客",@"长期访客", nil] fram: CGRectMake(0, 0, kScreenWidth - 150, 30)];
    segmentControl.selectedIndex = _selectedIndex;
    segmentControl.delegate = self;
    self.navigationItem.titleView = segmentControl;
    
    _mainView = [[HWInviteCustomRecordView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, CONTENT_HEIGHT)];
    _mainView.delegate = self;
    [self.view addSubview:_mainView];
    
    _scdView = [[HWInviteCustomRecord1View alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, CONTENT_HEIGHT)];
    _scdView.delegate = self;
    _scdView.hidden = YES;
    [self.view addSubview:_scdView];
}

- (void)segmentControl:(HWCustomSegmentControl *)sControl didSelectSegmentIndex:(int)index
{
    _selectedIndex = index;
    
    if (index == 0)
    {
        _mainView.hidden = NO;
        _scdView.hidden = YES;
    }
    else
    {
        _mainView.hidden = YES;
        _scdView.hidden = NO;
    }
}

- (void)pushViewController:(UIViewController *)vc
{
    [self.navigationController pushViewController:vc animated:YES];
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
