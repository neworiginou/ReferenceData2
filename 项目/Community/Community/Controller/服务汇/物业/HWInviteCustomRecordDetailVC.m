//
//  HWInviteCustomRecordDetailVC.m
//  Community
//
//  Created by niedi on 15/6/13.
//  Copyright (c) 2015年 caijingpeng. All rights reserved.
//

#import "HWInviteCustomRecordDetailVC.h"
#import "HWInviteCustomRecordDetailView.h"
#import "HWInviteCustomRecordListlVC.h"
#import "HWInviteCustomVC.h"

@interface HWInviteCustomRecordDetailVC ()<HWInviteCustomRecordDetailViewDelegate>
{
    HWInviteCustomRecordDetailView *_mainView;
    NSString *_cardId;
}
@end

@implementation HWInviteCustomRecordDetailVC

- (UIBarButtonItem *)rightBarButtonItem
{
    UIButton *rightButton = [UIButton buttonWithType:UIButtonTypeCustom];
    rightButton.frame = CGRectMake(0, 0, 60.0f, 44.0f);
    [rightButton setTitleColor:THEME_COLOR_ORANGE forState:UIControlStateNormal];
    rightButton.titleLabel.font = [UIFont fontWithName:FONTNAME size:THEME_FONT_BIG];
    [rightButton setTitle:@"验证记录" forState:UIControlStateNormal];
    rightButton.titleEdgeInsets = UIEdgeInsetsMake(0, 0, 0, -5);
    [rightButton addTarget:self action:@selector(recordBtnClick) forControlEvents:UIControlEventTouchUpInside];
    return [[UIBarButtonItem alloc] initWithCustomView:rightButton];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.navigationItem.titleView = [Utility navTitleView:@"访客通行证"];
    self.navigationItem.rightBarButtonItem = [self rightBarButtonItem];
    
    _mainView = [[HWInviteCustomRecordDetailView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, CONTENT_HEIGHT) withModel:_model];
    _mainView.fatherVC = self;
    _mainView.delegate = self;
    [self.view addSubview:_mainView];
}

- (void)recordBtnClick
{
    HWInviteCustomRecordListlVC *lVC = [[HWInviteCustomRecordListlVC alloc] init];
    lVC.tvId = _model.tvId;
    [self pushViewController:lVC];
}

- (void)pushViewController:(UIViewController *)vc
{
    [self.navigationController pushViewController:vc animated:YES];
}

#pragma mark - HWInviteCustomRecordDetailViewDelegate
- (void)showRightNavBtnWithCardId:(NSString *)cardId
{//未调用
    self.navigationItem.rightBarButtonItem = [self rightBarButtonItem];
    _cardId = cardId;
}

- (void)reExtendWithModel:(HWInviteCustomRecordModel *)model
{
    HWInviteCustomVC *ivc = [[HWInviteCustomVC alloc] init];
    ivc.recordModel = model;
    [self.navigationController pushViewController:ivc animated:YES];
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
