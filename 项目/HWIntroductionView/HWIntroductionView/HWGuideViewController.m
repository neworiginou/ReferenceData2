//
//  HWGuideViewController.m
//  HWIntroductionView
//
//  Created by lizhongqiang on 15/11/9.
//  Copyright © 2015年 lizhongqiang. All rights reserved.
//

#import "HWGuideViewController.h"
#import "HWGuideMainView.h"
@interface HWGuideViewController ()<HWGuideMainViewDelegate>
@property (nonatomic, strong)HWGuideMainView *mainView;
@end

@implementation HWGuideViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // Do any additional setup after loading the view.
    //[self prefersStatusBarHidden];
    
    
    [self.view addSubview:self.mainView];
    //[self.view addSubview:self.mainView.pageCtrl];
}
- (HWGuideMainView *)mainView
{
    if(_mainView == nil){
        _mainView = [[HWGuideMainView alloc]initWithFrame:CGRectMake(0, 0, CGRectGetWidth([UIScreen mainScreen].bounds), CGRectGetHeight([UIScreen mainScreen].bounds))];
        _mainView.delegate = self;
    }
    return _mainView;
}
- (void)showStatusBar{
    //[[UIApplication sharedApplication]setStatusBarHidden:NO withAnimation:NO];
    //[UIApplication sharedApplication].statusBarHidden = NO;
    [self prefersStatusBarHidden];
}
- (BOOL)prefersStatusBarHidden{
    return NO;
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
