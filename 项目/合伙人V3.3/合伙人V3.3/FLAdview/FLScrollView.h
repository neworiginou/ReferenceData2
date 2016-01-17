//
//  FLScrollView.h
//  ImageTest
//
//  Created by apple on 15-4-23.
//  Copyright (c) 2015年 fengling2300. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "TapImageView.h"

typedef enum {
    PageControlCenter = 1,
    PageControlLeft,
    PageControlRight
} PageControlLocation;

@protocol ScrollImageTapDelegate <NSObject>

-(void)scrollImageTaped:(UIImageView *)imageView;

@end

@interface FLScrollView : UIScrollView<UIScrollViewDelegate,ImageTapDelegate>

@property (nonatomic,retain) NSArray             *imageArray;//图片数组
@property (nonatomic,assign) NSTimeInterval      chageTime;//切换时间
@property (nonatomic,retain) UIPageControl       *pageControl;
@property (nonatomic,assign) PageControlLocation location;
@property (nonatomic,assign) id<ScrollImageTapDelegate>  imgDelegate;
@end
