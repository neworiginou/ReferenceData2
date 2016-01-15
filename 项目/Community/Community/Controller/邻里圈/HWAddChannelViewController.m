//
//  HWAddChannelViewController.m
//  Community
//
//  Created by caijingpeng.haowu on 15/1/15.
//  Copyright (c) 2015年 caijingpeng. All rights reserved.
//
//  功能描述：添加话题 页面
//
//  修改记录：
//      姓名         日期               修改内容
//     蔡景鹏     2015-01-15          创建文件
//
//

#import "HWAddChannelViewController.h"
#import "HWSearchChannelView.h"

@interface HWAddChannelViewController ()<HWSearchChannelViewDelegate>
{
    HWSearchChannelView *_searchChannelView;
}
@end

@implementation HWAddChannelViewController
@synthesize delegate;
@synthesize currentChannel;

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    _searchChannelView = [[HWSearchChannelView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, [UIScreen mainScreen].bounds.size.height)];
    _searchChannelView.delegate = self;
    _searchChannelView.curChannel = self.currentChannel;
    [self.view addSubview:_searchChannelView];
    
}

- (void)viewWillAppear:(BOOL)animated
{
    self.navigationController.navigationBarHidden = YES;
}

- (void)viewWillDisappear:(BOOL)animated
{
    self.navigationController.navigationBarHidden = NO;
    [_searchChannelView removeKeyboardAbserver];
}

- (void)viewDidAppear:(BOOL)animated
{
    [_searchChannelView addKeyboardAbserver];
}

#pragma mark -
#pragma mark        HWSearchChannelView Delegate

/**
 *	@brief	取消搜索
 *
 *	@return	
 */
- (void)searchChannelViewCancelSearch
{
    [self.navigationController popViewControllerAnimated:YES];
}

/**
 *	@brief	选择搜索出来的话题
 *
 *	@param 	dataModel 	话题数据模型
 *
 *	@return
 */
- (void)searchChannelResult:(HWChannelModel *)dataModel
{
    if (delegate && [delegate respondsToSelector:@selector(didSelectChannel:)])
    {
        [delegate didSelectChannel:dataModel];
    }
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)didCreateChannel:(HWChannelModel *)dataModel
{
    if (delegate && [delegate respondsToSelector:@selector(didSelectChannel:)])
    {
        [delegate didSelectChannel:dataModel];
    }
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)didDeleteCurrentChannel
{
    if (delegate && [delegate respondsToSelector:@selector(didDeleteSelectedChannel)])
    {
        [delegate didDeleteSelectedChannel];
    }
}

- (void)didReceiveMemoryWarning
{
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
