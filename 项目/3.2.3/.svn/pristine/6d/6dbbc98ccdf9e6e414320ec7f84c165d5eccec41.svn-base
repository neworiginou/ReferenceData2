//
//  HWImageEditVC.m
//  MoreHouse
//
//  Created by zhangxun on 14/12/2.
//  Copyright (c) 2014年 lizhongqiang. All rights reserved.
//

#import "HWImageEditVC.h"

@interface HWImageEditVC ()
{
    UIButton *_setFirstButton;
}
@end

@implementation HWImageEditVC
@synthesize editImage,hasSelected;
@synthesize delegate;
@synthesize imageString;

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.navigationItem.leftBarButtonItem = [Utility_OC navLeftBackBtn:self action:@selector(backMethod)];
    self.navigationItem.titleView = [Utility_OC navTitleView:@"图片编辑"];
    self.navigationItem.rightBarButtonItem= [ Utility_OC navButton:self action:@selector(doAbandon) image:[UIImage imageNamed:@"editor_icon6"]];
    self.view.backgroundColor = [UIColor blackColor];
    UIImageView *imageV = [[UIImageView alloc]initWithFrame:CGRectMake(0, 50, [UIScreen mainScreen].bounds.size.width, [UIScreen mainScreen].bounds.size.width)];
    imageV.image = editImage;
    [self.view addSubview:imageV];
    
    _setFirstButton = [UIButton buttonWithType:UIButtonTypeCustom];
    _setFirstButton.frame = CGRectMake(13, CGRectGetMaxY(imageV.frame) + 15, 30, 30);
    if (!hasSelected) {
        [_setFirstButton setImage:[UIImage imageNamed:@"choose_2_1"] forState:UIControlStateNormal];
    }else{
        [_setFirstButton setImage:[UIImage imageNamed:@"choose_2_2"] forState:UIControlStateNormal];
    }
    [_setFirstButton addTarget:self action:@selector(doTap) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:_setFirstButton];
    
    UILabel *label = [[UILabel alloc]initWithFrame:CGRectMake(45, _setFirstButton.frame.origin.x, [UIScreen mainScreen].bounds.size.width - 40, 19)];
    CGPoint centerp = label.center;
    centerp.y = _setFirstButton.center.y;
    label.center = centerp;
    label.font = [UIFont systemFontOfSize:16];
    label.textColor = TITLE_COLOR_99;
    label.text = @"设为首张展示图片";
    [self.view addSubview:label];
}

/**
 *	@brief	删除
 *
 *	@return	N/A
 */
- (void)doAbandon
{
    [self.delegate doDelete:self.imageString];
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)setCustomer{
    [self.delegate doSetFirst:self.imageString];
    hasSelected = YES;
    [_setFirstButton setImage:[UIImage imageNamed:@"choose_2_2"] forState:UIControlStateNormal];
}

/**
 *	@brief	设为首张展示图片
 *
 *	@return	N/A
 */
- (void)doTap
{
    hasSelected = !hasSelected;
    if (!hasSelected) {
        [_setFirstButton setImage:[UIImage imageNamed:@"choose_2_1"] forState:UIControlStateNormal];
        [self.delegate doUnFirst];
    }else{
        [_setFirstButton setImage:[UIImage imageNamed:@"choose_2_2"] forState:UIControlStateNormal];
        [self.delegate doSetFirst:self.imageString];
        [self.navigationController popViewControllerAnimated:YES];
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
