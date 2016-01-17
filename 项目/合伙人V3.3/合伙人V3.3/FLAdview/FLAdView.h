//
//  FLAdView.h
//  ImageTest
//
//  Created by apple on 15/5/5.
//  Copyright (c) 2015年 fengling2300. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "FLScrollView.h"

@protocol FLAdViewDelegate <NSObject>

-(void)imageTaped:(UIImageView *)imageView;

@end

@interface FLAdView : UIView<ScrollImageTapDelegate>

@property (nonatomic,retain) NSArray             *imageArray;
@property (nonatomic,assign) NSTimeInterval      chageTime;//定时切换时间
@property (nonatomic,retain) UIColor             *currentPageColor;//当前选中页的颜色
@property (nonatomic,retain) UIColor             *normalColor;//未选中页的颜色
@property (nonatomic,assign) PageControlLocation location;
@property (nonatomic,assign) id<FLAdViewDelegate> flDelegate;

@end
