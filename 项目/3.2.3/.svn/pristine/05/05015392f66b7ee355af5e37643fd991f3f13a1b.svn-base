//
//  HWImageScrollView.h
//  Test
//
//  Created by zhangxun on 14-9-4.
//  Copyright (c) 2014年 zhangxun. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "UIImageView+WebCache.h"

@class HWImageScrollView;

@protocol HWImageScrollViewDelegate <NSObject>

- (void)showPickerWithSV:(HWImageScrollView *)imageScrollview;

- (void)imageScrollView:(HWImageScrollView *)imageScrollview tapImageView:(UIImageView *)imageView;

- (void)setFirstWithString:(NSString *)string;

@end

@interface HWImageScrollView : UIScrollView<UIScrollViewDelegate>

@property (nonatomic,assign)id <HWImageScrollViewDelegate>del;

@property (nonatomic,strong)NSMutableArray *imageArray;

- (void)fillWithArray:(NSArray *)array;

@end
