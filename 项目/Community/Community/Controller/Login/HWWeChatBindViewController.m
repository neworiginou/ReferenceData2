//
//  HWWeChatBindViewController.m
//  Community
//
//  Created by caijingpeng.haowu on 15/1/9.
//  Copyright (c) 2015年 caijingpeng. All rights reserved.
//
//  功能描述：微信登录授权成功后 改用户未登录过，选择新用户绑定或老用户绑定
//
//  修改记录：
//      姓名         日期               修改内容
//     蔡景鹏     2015-01-14           创建文件
//
//

#import "HWWeChatBindViewController.h"
#import "HWNewUserBindViewController.h"
#import "HWOldUserBindViewController.h"

@interface HWWeChatBindViewController ()
{
    UIScrollView *_mainSV;
    UILabel *_titleLabel;
    UIImageView *_logoLeftImgV; // 绑定用户头像
    UILabel *_leftLabel;        // 绑定用户名字
    UIImageView *_logoRightImgV; // 社区头像
    UILabel *_rightLabel;        // 社区名字
}
@end

@implementation HWWeChatBindViewController
@synthesize weChatAccount;

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.navigationItem.titleView = [Utility navTitleView:@"账号绑定"];
    self.navigationItem.leftBarButtonItem = [Utility navLeftBackBtn:self action:@selector(backMethod)];
    self.navigationController.navigationBarHidden = NO;
    
    [self initialView];
}

#pragma mark -
#pragma mark     Initial View

/**
 *	@brief	初始化 底部 ScrollView  及 按钮
 *
 *	@return
 */
- (void)initialView
{
    _mainSV = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, CONTENT_HEIGHT)];
    _mainSV.backgroundColor = [UIColor clearColor];
    _mainSV.contentSize = CGSizeMake(kScreenWidth, _mainSV.frame.size.height + 1);
    [self.view addSubview:_mainSV];
    
    _titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 15, kScreenWidth, 25.0f)];
    _titleLabel.backgroundColor = [UIColor clearColor];
    _titleLabel.textColor = THEME_COLOR_TEXT;
    _titleLabel.textAlignment = NSTextAlignmentCenter;
    _titleLabel.font = [UIFont fontWithName:FONTNAME size:THEME_FONT_BIG];
    _titleLabel.text = @"绑定后可同时使用考拉账号和微信登录";
    [_mainSV addSubview:_titleLabel];
    
    [self initialBindView];
    
    for (int i = 0; i < 2; i++)
    {
        UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
        [button setFrame:CGRectMake(15, CGRectGetMaxY(_leftLabel.frame) + 20 + i * (45 + 10), kScreenWidth - 30, 45.0f)];
        if (i == 0)
        {
            [button setButtonOrangeStyle];
            [button setTitle:@"我是新用户" forState:UIControlStateNormal];
            [button addTarget:self action:@selector(toNewUser:) forControlEvents:UIControlEventTouchUpInside];
        }
        else
        {
            [button setButtonYellowStyle];
            [button setTitle:@"已有考拉账号" forState:UIControlStateNormal];
            [button addTarget:self action:@selector(toOldUser:) forControlEvents:UIControlEventTouchUpInside];
        }
        [_mainSV addSubview:button];
    }
    
}

/**
 *	@brief	初始化 微信和考拉图标 view
 *
 *	@return
 */
- (void)initialBindView
{
    //  ********
    
    _logoLeftImgV = [[UIImageView alloc] initWithFrame:CGRectMake(kScreenWidth / 2.0f - 110, CGRectGetMaxY(_titleLabel.frame) + 20, 60, 60)];
    _logoLeftImgV.backgroundColor = [UIColor clearColor];
    _logoLeftImgV.layer.cornerRadius = 15.0f;
    _logoLeftImgV.layer.masksToBounds = YES;
    [_mainSV addSubview:_logoLeftImgV];
    
    _leftLabel = [[UILabel alloc] initWithFrame:CGRectMake(CGRectGetMinX(_logoLeftImgV.frame), CGRectGetMaxY(_logoLeftImgV.frame), CGRectGetWidth(_logoLeftImgV.frame), 27.5f)];
    _leftLabel.backgroundColor = [UIColor clearColor];
    _leftLabel.textAlignment = NSTextAlignmentCenter;
    _leftLabel.textColor = THEME_COLOR_TEXT;
    _leftLabel.font = [UIFont fontWithName:FONTNAME size:THEME_FONT_SMALL];
    [_mainSV addSubview:_leftLabel];
    
    //  *********
    
    _logoRightImgV = [[UIImageView alloc] initWithFrame:CGRectMake(kScreenWidth / 2.0f + 50, CGRectGetMaxY(_titleLabel.frame) + 20, 60, 60)];
    _logoRightImgV.backgroundColor = [UIColor clearColor];
    [_mainSV addSubview:_logoRightImgV];
    
    _rightLabel = [[UILabel alloc] initWithFrame:CGRectMake(CGRectGetMinX(_logoRightImgV.frame), CGRectGetMaxY(_logoRightImgV.frame), CGRectGetWidth(_logoRightImgV.frame), 27.5f)];
    _rightLabel.backgroundColor = [UIColor clearColor];
    _rightLabel.textAlignment = NSTextAlignmentCenter;
    _rightLabel.textColor = THEME_COLOR_TEXT;
    _rightLabel.font = [UIFont fontWithName:FONTNAME size:THEME_FONT_SMALL];
    [_mainSV addSubview:_rightLabel];
    
    
    //  ****** 绑定图标
    
    UIImageView *centerImgV = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 28, 11)];
    centerImgV.center = CGPointMake(CGRectGetMidX(_mainSV.frame), CGRectGetMidY(_logoLeftImgV.frame));
    centerImgV.image = [UIImage imageNamed:@"associate_icon"];
    [_mainSV addSubview:centerImgV];
    
    
    
    
    __weak UIImageView *weakLeftImgV = _logoLeftImgV;
    
    [_logoLeftImgV setImageWithURL:[NSURL URLWithString:weChatAccount.headIconUrl] placeholderImage:[UIImage imageNamed:@"associate_weixin"] completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType) {
        
        if (error != nil)
        {
            weakLeftImgV.image = [UIImage imageNamed:@"associate_weixin"];
        }
        else
        {
            weakLeftImgV.image = image;
        }
        
    }];
    
    _leftLabel.text = weChatAccount.userName;
    
    _logoRightImgV.image = [UIImage imageNamed:@"associate_kaola"];
    _rightLabel.text = @"考拉社区";
    
}

#pragma mark -
#pragma mark     Button Action Method

/**
 *	@brief	选择新用户绑定 按钮事件
 *
 *	@param 	sender
 *
 *	@return
 */
- (void)toNewUser:(id)sender
{
    HWNewUserBindViewController *newUserVC = [[HWNewUserBindViewController alloc] init];
    newUserVC.weChatAccount = self.weChatAccount;
    [self.navigationController pushViewController:newUserVC animated:YES];
}

/**
 *	@brief	选择老用户绑定 按钮事件
 *
 *	@param 	sender
 *
 *	@return
 */
- (void)toOldUser:(id)sender
{
    HWOldUserBindViewController *oldUserVC = [[HWOldUserBindViewController alloc] init];
    oldUserVC.weChatAccount = self.weChatAccount;
    [self.navigationController pushViewController:oldUserVC animated:YES];
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
