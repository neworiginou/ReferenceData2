//
//  HWImageScrollView.m
//  Test
//
//  Created by zhangxun on 14-9-4.
//  Copyright (c) 2014年 zhangxun. All rights reserved.
//

#import "HWImageScrollView.h"
#import "Partner_Swift-Swift.h"
#define kImageSize 65
#define kTopMargin 5

@implementation HWImageScrollView
@synthesize del;
@synthesize imageArray;

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.imageArray = [NSMutableArray  array];
        [imageArray addObject:@"add_pic"];
        [self recreatUI];
    }
    return self;
}

- (void)fillWithArray:(NSArray *)array{
    [self.imageArray removeAllObjects];
    for (int i = 0; i < array.count; i ++) {
        [self.imageArray addObject:[array[i] objectForKey:@"picKey"]];
        if ([[array[i] objectForKey:@"isMain"] isEqualToString:@"yes"]) {
            [self.del setFirstWithString:[array[i] objectForKey:@"picKey"]];
            
        }
    }
    
    [imageArray addObject:@"add_pic"];
    self.contentSize = CGSizeMake(75 * imageArray.count, 65);
    [self recreatUI];
}

- (void)delImageWithTag:(NSInteger)imageTag{
    [imageArray removeObjectAtIndex:imageTag];
}

- (void)recreatUI{
    for (UIImageView *imageV in self.subviews) {
        if ([imageV isKindOfClass:[UIImageView class]] && imageV.frame.origin.y == kTopMargin) {
            [imageV removeFromSuperview];
        }
    }
    
    for (int i = 0; i < imageArray.count; i++) {
        UIImageView *imageV = [[UIImageView alloc]initWithFrame:CGRectMake(10 + (kImageSize +kTopMargin) * i, kTopMargin, kImageSize, kImageSize)];
        imageV.layer.cornerRadius = 8.0f;
        imageV.clipsToBounds = YES;
        if (i == imageArray.count - 1) {
            
            imageV.image = [UIImage imageNamed:@"add_pic"];
        }else{
            
            //MYP add v3.2.2 加载图片使用后台返回完整的图片url字段
            //NSString * url = [Utility imageDownloadWithMongoDbKey:imageArray[i]];
            NSString *url = imageArray[i];
            [imageV setImageWithURL:[NSURL URLWithString:url] completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType) {
                
            }];
        }
        imageV.tag = i;
        [self addSubview:imageV];
        imageV.userInteractionEnabled = YES;
        if (i == imageArray.count - 1) {
            UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(imageEdit:)];
            [imageV addGestureRecognizer:tap];
        }else{
            UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(selectImageView:)];
            [imageV addGestureRecognizer:tap];
        }
    }
    self.contentSize = CGSizeMake(imageArray.count * (kImageSize +kTopMargin) + 10, self.frame.size.height);
}

- (void)imageEdit:(UITapGestureRecognizer *)tap{
    [self.del showPickerWithSV:self];
}

- (void)selectImageView:(UITapGestureRecognizer *)tap
{
    [self.del imageScrollView:self tapImageView:(UIImageView *)tap.view];
}

- (void)doDel:(UIButton *)btn{
    [imageArray removeObjectAtIndex:btn.superview.frame.origin.x / (kImageSize + kTopMargin)];
    [btn.superview removeFromSuperview];
    [self recreatUI];
}

@end
