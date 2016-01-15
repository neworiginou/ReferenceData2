//
//  HWAddHouse1VC.m
//  Community
//
//  Created by niedi on 15/6/23.
//  Copyright (c) 2015年 caijingpeng. All rights reserved.
//

#import "HWAddHouse1VC.h"
#import "HWWuYeAddHouse1View.h"
#import "HWWuYeFeeVC.h"

@interface HWAddHouse1VC ()<HWWuYeAddHouse1ViewDelegate>
{
    HWWuYeAddHouse1View *_mainView;
}
@end

@implementation HWAddHouse1VC

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.navigationItem.titleView = [Utility navTitleView:@"请选择"];
    
    _mainView = [[HWWuYeAddHouse1View alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, CONTENT_HEIGHT) model:self.model];
    _mainView.delegate = self;
    [self.view addSubview:_mainView];
}

#pragma mark - HWWuYeAddHouse1ViewDelegate
- (void)doneAddHouse
{
    for (UIViewController *vc in self.navigationController.viewControllers)
    {
        if ([vc isMemberOfClass:[HWWuYeFeeVC class]])
        {
            [self.navigationController popToViewController:vc animated:YES];
        }
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
