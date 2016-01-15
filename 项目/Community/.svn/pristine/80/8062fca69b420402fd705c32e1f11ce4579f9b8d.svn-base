//
//  HWPicBrownerAndEditViewController.m
//  Community
//
//  Created by hw500027 on 15/6/13.
//  Copyright (c) 2015年 caijingpeng. All rights reserved.
//
//
//  功能描述：编辑图片
//      姓名         日期               修改内容
//     陆晓波     2015-06-12            创建文件

#import "HWPicBrownerAndEditViewController.h"
#import "ETShowBigImageView.h"

@interface HWPicBrownerAndEditViewController () <UIScrollViewDelegate>
{
    UIScrollView *_scrollView;
}
@end

@implementation HWPicBrownerAndEditViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor blackColor];
    self.navigationItem.titleView = [Utility navTitleView:[NSString stringWithFormat:@"%ld/%lu",(long)_selectIndex + 1,(unsigned long)_picArray.count]];
    
    self.navigationItem.leftBarButtonItem = [Utility navLeftBackBtn:self action:@selector(customBackMethod)];
    self.navigationItem.rightBarButtonItem = [Utility navButton:self image:@"editor_icon6" action:@selector(toDeleteImage)];
    
    
    //创建scrollView
    _scrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, [UIScreen mainScreen].bounds.size.height - 64)];
    _scrollView.delegate = self;
    _scrollView.contentSize = CGSizeMake(kScreenWidth * _picArray.count, _scrollView.frame.size.height);
    _scrollView.pagingEnabled = YES;
    _scrollView.alwaysBounceHorizontal = YES;
    [self.view addSubview:_scrollView];
    
    //添加图片
    [self addImage];
}

- (void)customBackMethod
{
    if (_delegate && [_delegate respondsToSelector:@selector(didDeleteSelctedImg:)])
    {
        [_delegate didDeleteSelctedImg:_picArray];
    }
    [self.navigationController popViewControllerAnimated:YES];
}

//添加图片
- (void)addImage
{
//    for (int i = 0 ; i < _picArray.count; i++)
//    {
//        UIImageView *imageView = [[UIImageView alloc] initWithFrame:CGRectMake(i * _scrollView.frame.size.width, 0, _scrollView.frame.size.width, _scrollView.frame.size.height)];
//        imageView.image = [UIImage imageWithData:[[_picArray pObjectAtIndex:i] objectForKey:@"selectImage"]];
//        imageView.contentMode = UIViewContentModeScaleAspectFit;
//        [_scrollView addSubview:imageView];
//    }
    [_scrollView setContentOffset:CGPointMake(_selectIndex * kScreenWidth, 0)];
    
    for (int i = 0 ; i < _picArray.count; i ++)
    {
        ETZoomScrollView *imgV = [[ETZoomScrollView alloc] initWithFrame:CGRectMake(i * _scrollView.frame.size.width, 0, _scrollView.frame.size.width, _scrollView.frame.size.height)];
        imgV.tag = 3001 + i;
        imgV.contentMode = UIViewContentModeScaleAspectFit;
        imgV.imageView.image = [UIImage imageWithData:[[_picArray pObjectAtIndex:i] objectForKey:@"selectImage"]];
        [_scrollView addSubview:imgV];
    }
}

- (void)toDeleteImage
{
    UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"提醒" message:@"是否确认删除这张图片" delegate:self cancelButtonTitle:@"取消" otherButtonTitles:@"确定", nil];
    [alertView showAlertViewWithCompleteBlock:^(NSInteger buttonIndex)
    {
        if (buttonIndex == 1)
        {
            [_picArray removeObjectAtIndex:_selectIndex];
            if (_picArray.count == 0)
            {
                //删前只有1张图片 直接返回
                [self customBackMethod];
            }
            else
            {
                _scrollView.contentSize = CGSizeMake(kScreenWidth * _picArray.count, _scrollView.frame.size.height);
                for (UIImageView *imageV in _scrollView.subviews)
                {
                    if ([imageV isKindOfClass:[UIImageView class]])
                    {
                        [imageV removeFromSuperview];
                    }
                }
                [self addImage];
                self.navigationItem.titleView = [Utility navTitleView:[NSString stringWithFormat:@"%ld/%lu",(long)_selectIndex + 1,(unsigned long)_picArray.count]];
                //如果删除的图片为最后一张
                if (_selectIndex == _picArray.count)
                {
                    _selectIndex--;
                    [_scrollView setContentOffset:CGPointMake(_selectIndex * kScreenWidth, 0)];
                    self.navigationItem.titleView = [Utility navTitleView:[NSString stringWithFormat:@"%ld/%lu",(long)_selectIndex + 1,(unsigned long)_picArray.count]];
                }
            }
        }
    }];
}

- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView
{
    _selectIndex = _scrollView.contentOffset.x / _scrollView.frame.size.width;
    self.navigationItem.titleView = [Utility navTitleView:[NSString stringWithFormat:@"%ld/%lu",(long)_selectIndex + 1,(unsigned long)_picArray.count]];
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
