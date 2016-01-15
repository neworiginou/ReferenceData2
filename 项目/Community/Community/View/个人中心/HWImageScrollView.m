//
//  HWImageScrollView.m
//  Test
//
//  Created by zhangxun on 14-9-4.
//  Copyright (c) 2014年 zhangxun. All rights reserved.
//

#import "HWImageScrollView.h"
#import "HWPhoto.h"
#define kImageSize 60
#define kTopMargin 10

@implementation HWImageScrollView
@synthesize del;
@synthesize imageArray;
@synthesize submitShopFlag;
@synthesize tempImageView;
- (id)initWithFrame:(CGRect)frame flag:(BOOL)flag
{
    self = [super initWithFrame:frame];
    if (self) {
        imageArray = [NSMutableArray  array];
        tempImageView = [[UIImageView alloc]init];
        self.submitShopFlag = flag;
        if (flag == YES) {
          [imageArray addObject:[UIImage imageNamed:@"openshop_addphoto"]];
          [imageArray addObject:[UIImage imageNamed:@"shop_del_photo"]];
        }
        else
        {
            HWPhoto *addPhoto = [[HWPhoto alloc]initWithUrlAndKey:nil key:nil image:[UIImage imageNamed:@"openshop_addphoto"]];
            HWPhoto *delPhoto = [[HWPhoto alloc]initWithUrlAndKey:nil key:nil image:[UIImage imageNamed:@"shop_del_photo"]];
            [imageArray addObject:addPhoto];
            [imageArray addObject:delPhoto];
        }
       
//        [imageArray addObject:[UIImage imageNamed:@"openshop_addphoto"]];
//        [imageArray addObject:[UIImage imageNamed:@"shop_del_photo"]];
        [self recreatUI];
    }
    return self;
}

- (void)addImage:(id)image{
    if (!image) {
        return;
    }
    if (submitShopFlag == YES) {
        [imageArray insertObject:(UIImage*)image atIndex:imageArray.count-2];
        [self recreatUI];
    }
    else
    {
        [imageArray insertObject:(HWPhoto*)image atIndex:imageArray.count-2];
        [self recreatUI];
    }
    
}

- (void)recreatUI{
    for (UIImageView *imageV in self.subviews) {
        if ([imageV isKindOfClass:[UIImageView class]] && imageV.frame.origin.y == kTopMargin) {
            [imageV removeFromSuperview];
        }
    }
    
    for (int i = 0; i < imageArray.count; i++) {
        UIImageView *imageV = [[UIImageView alloc]initWithFrame:CGRectMake(10 + (kImageSize +kTopMargin) * i, kTopMargin, kImageSize+10, kImageSize+10)];
        imageV.tag = i+100;
        imageV.backgroundColor = [UIColor clearColor];
        //创建LAYER
        CALayer *imageLayer = [[CALayer alloc]init];
        imageLayer.cornerRadius = 8.0f;
        imageLayer.masksToBounds = YES;
        [imageLayer setFrame:CGRectMake(10, kTopMargin-5, kImageSize, kImageSize)];
        imageLayer.backgroundColor = [UIColor clearColor].CGColor;
        [imageV.layer addSublayer:imageLayer];
        
        if (submitShopFlag == YES) {
            UIImage *imageTemp = imageArray[i];
            imageLayer.contents = (id)imageTemp.CGImage;
        }
        else
        {
            //分数据
            __weak HWPhoto *photoTemp = [imageArray objectAtIndex:i];
            if (!photoTemp.photoUrl) {
                imageLayer.contents = (id) photoTemp.localPhotoImage.CGImage;
            }
            else
            {
                //获取数据
                __weak UIImageView *myImageView = imageV;
                [imageV setImageWithURL:photoTemp.photoUrl placeholderImage:[UIImage imageNamed:IMAGE_PLACE] completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType) {
                    if (error)
                    {
                        NSLog(@"Error : load image fail.");
                        imageLayer.contents = (id)[UIImage imageNamed:IMAGE_BREAK_CUBE].CGImage;
                        photoTemp.localPhotoImage = image;
                        myImageView.image = nil;
                    }
                    else
                    {
                        photoTemp.localPhotoImage = image;
                        imageLayer.contents = (id)image.CGImage;
                        myImageView.image = nil;
                        
                        
                    }
                }];
            }

        }
        //处理头像数据
        [self addSubview:imageV];
        if (i==imageArray.count -2) {
            imageV.userInteractionEnabled = YES;
            UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(fillImage)];
            [imageV addGestureRecognizer:tap];
        }
        else if (i == imageArray.count - 1) {
            imageV.userInteractionEnabled = YES;
            UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(doEdit)];
            [imageV addGestureRecognizer:tap];
        }
        else
        {
            imageV.userInteractionEnabled = YES;
            UITapGestureRecognizer *tapFandDa = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(clickFangDa:)];
            
            [imageV addGestureRecognizer:tapFandDa];
        }
    }
    self.contentSize = CGSizeMake(imageArray.count * 70 + 10, self.frame.size.height);
    if (imageArray.count > 4 && (imageArray.count * 70 + 10)>kScreenWidth) {
        NSInteger index = imageArray.count-4;
        if (index > 0) {
            self.contentOffset = CGPointMake((index)*60, 0);

        }
    }
}
//放大图片
-(void)clickFangDa:(UITapGestureRecognizer *)gesture
{
//    UIImage *image = [imageArray objectAtIndex:gesture.view.frame.origin.x / (kImageSize + kTopMargin)];
    if (del && [del respondsToSelector:@selector(returnClickImage:currentIndex:gesture:)])
    {
//        NSLog(@"%g",gesture.view.frame.origin.x / (kImageSize + kTopMargin));
        [del returnClickImage:imageArray currentIndex:gesture.view.frame.origin.x / (kImageSize + kTopMargin) gesture:gesture];
    }
    
    
}
- (void)fillImage{
    [self cancleEdit];
    [self.del showPicker];
}

- (void)doEdit{
    if (_editingMode) {
        [self cancleEdit];
        return;
    }
    _editingMode = YES;
    for (UIImageView *imageV in self.subviews) {
        if ([imageV isKindOfClass:[UIImageView class]] && imageV.frame.origin.y == kTopMargin && imageV.frame.origin.x != (kImageSize +kTopMargin) * (imageArray.count - 1) + 10 && imageV.frame.origin.x != (kImageSize +kTopMargin) * (imageArray.count - 2) + 10) {
            imageV.userInteractionEnabled = YES;
            UIButton *delButton = [UIButton buttonWithType:UIButtonTypeCustom];
            delButton.frame = CGRectMake(0,0, 20, 20);
            [delButton setBackgroundImage:[UIImage imageNamed:@"delete"] forState:UIControlStateNormal];
            [imageV addSubview:delButton];
            [delButton addTarget:self action:@selector(doDel:) forControlEvents:UIControlEventTouchUpInside];
        }
    }
}

- (void)cancleEdit{
    _editingMode = NO;
    for (UIImageView *imageV in self.subviews) {
        if ([imageV isKindOfClass:[UIImageView class]] && imageV.frame.origin.y == kTopMargin && imageV.frame.origin.x != (kImageSize +kTopMargin) * (imageArray.count - 1) + 10 && imageV.frame.origin.x != (kImageSize +kTopMargin) * (imageArray.count - 2) + 10) {
            imageV.userInteractionEnabled = YES;
            for (UIButton *button in imageV.subviews) {
                if ([button isKindOfClass:[UIButton class]]) {
                    [button removeFromSuperview];
                }
            }
            
        }
    }
}
//删除图片
-(void)delePhotoAlert
{
    UIAlertView *alertView = [[UIAlertView alloc]initWithTitle:@"" message:@"确定删除相册图片嘛？" delegate:self cancelButtonTitle:@"取消" otherButtonTitles:@"确定", nil];
    [alertView show];
}
-(void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    if (buttonIndex == 1) {
        [self.del deleLocalOnePic:deleteIndex];
        [imageArray removeObjectAtIndex:saveDeletBtn.superview.frame.origin.x / (kImageSize + kTopMargin)];
        [saveDeletBtn.superview removeFromSuperview];
        [self recreatUI];
        if (_editingMode) {
            _editingMode = NO;
            [self doEdit];
        }
    }
}
- (void)doDel:(UIButton *)btn{
    
    NSInteger index = btn.superview.frame.origin.x / (kImageSize + kTopMargin);
    deleteIndex = index;
    saveDeletBtn = btn;
    if (submitShopFlag == YES) {
        NSLog(@"sucess");
    }
    else
    {
        [self delePhotoAlert];
        return;
    }
    
    [imageArray removeObjectAtIndex:btn.superview.frame.origin.x / (kImageSize + kTopMargin)];
    [btn.superview removeFromSuperview];
    [self recreatUI];
    if (_editingMode) {
        _editingMode = NO;
        [self doEdit];
    }

}

@end
