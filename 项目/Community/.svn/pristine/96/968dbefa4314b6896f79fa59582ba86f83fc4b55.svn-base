//
//  HWPublichPicView.m
//  Community
//
//  Created by hw500027 on 15/6/12.
//  Copyright (c) 2015年 caijingpeng. All rights reserved.
//
//  功能描述：添加图片view 功能类似微信
//      姓名         日期               修改内容
//     陆晓波     2015-06-12            发布备注


#import "HWPublichPicView.h"

@interface HWPublichPicView()
{
    NSMutableArray *_picArray;
}
@end

@implementation HWPublichPicView

- (instancetype)initWithSingleLineFrame:(CGRect)frame withPicArray:(NSArray *)picArray
{
    self = [super initWithFrame:CGRectMake(frame.origin.x, frame.origin.y, frame.size.width, ((picArray.count + 1 ) / 4 + 1) * 90 * kScreenRate)];
    _picArray = [[NSMutableArray alloc] initWithArray:picArray];
    if (self)
    {
        [self configUI];
        self.backgroundColor = [UIColor whiteColor];
    }
    return self;
}

- (void)configUI
{
    UIImage *image = [UIImage imageNamed:@"camera_16_01"];
    for (int i = 0; i < _picArray.count + 1; i++)
    {
        UIImageView *imgView = [UIImageView newAutoLayoutView];
        [self addSubview:imgView];
        [imgView autoPinEdge:ALEdgeTop toEdge:ALEdgeTop ofView:self withOffset:i/4 * 90 * kScreenRate + 12 * kScreenRate];
        [imgView autoPinEdge:ALEdgeLeft toEdge:ALEdgeLeft ofView:self withOffset:i%4 * (image.size.width + 15) * kScreenRate + 15];
        [imgView autoSetDimensionsToSize:CGSizeMake(116/2 * kScreenRate , 116/2 * kScreenRate)];
        imgView.userInteractionEnabled = YES;
        if (i == _picArray.count)
        {
            imgView.image = image;
            UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(selectImageView:)];
            [imgView addGestureRecognizer:tap];
        }
        else
        {
            imgView.image = [UIImage imageWithData:[[_picArray pObjectAtIndex:i] objectForKey:@"selectImage"]];
            UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(editImage:)];
            [imgView addGestureRecognizer:tap];
            imgView.tag = 300 + i;
        }
    }
    
    [Utility bottomLine:self];
}

- (void)editImage:(UITapGestureRecognizer *)tap
{
    NSLog(@"%ld",(long)tap.view.tag);
    if (_picViewDelegate && [_picViewDelegate respondsToSelector:@selector(toEditImage:andSelectIndex:)])
    {
        [_picViewDelegate toEditImage:_picArray andSelectIndex:tap.view.tag - 300];
    }
}

- (void)selectImageView:(UITapGestureRecognizer *)tap
{
    if (_picArray.count >= 6)
    {
        UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"提示" message:@"图片最多上传6张" delegate:self cancelButtonTitle:nil otherButtonTitles:@"确定", nil];
        [alertView show];
    }
    else
    {
        if (_picViewDelegate && [_picViewDelegate respondsToSelector:@selector(toSelectImage)])
        {
            [_picViewDelegate toSelectImage];
        }
    }
}

- (void)fillWithPicDic:(NSMutableDictionary *)selectPicDic
{
    [_picArray addObject:selectPicDic];
    for (UIImageView *imageV in self.subviews)
    {
        if ([imageV isKindOfClass:[UIImageView class]])
        {
            [imageV removeFromSuperview];
        }
    }
    [self setFrame:CGRectMake(self.frame.origin.x, self.frame.origin.y, self.frame.size.width, ((_picArray.count ) / 4) * 90 * kScreenRate + 90 * kScreenRate)];
    [self configUI];
}

- (void)fillWithFullPicArray:(NSMutableArray *)picArray
{
    NSLog(@"%lu",(unsigned long)picArray.count);
    for (int i = 0 ; i < picArray.count; i++)
    {
        NSLog(@"%@",[[picArray pObjectAtIndex:i] objectForKey:@"selectKey"]);
    }
    
    _picArray = picArray;
    for (UIImageView *imageV in self.subviews)
    {
        if ([imageV isKindOfClass:[UIImageView class]])
        {
            [imageV removeFromSuperview];
        }
    }
    [self setFrame:CGRectMake(self.frame.origin.x, self.frame.origin.y, self.frame.size.width, ((_picArray.count ) / 4) * 90 * kScreenRate + 90 * kScreenRate)];
    [self configUI];
}

@end
