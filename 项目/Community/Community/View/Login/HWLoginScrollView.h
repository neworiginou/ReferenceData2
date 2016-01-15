//
//  HWLoginScrollView.h
//  Community
//
//  Created by hw500027 on 15/4/30.
//  Copyright (c) 2015年 caijingpeng. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol HWLoginScrollViewDelegate <NSObject>
-(void)didClickLoginBtn;
-(void)didClickRegisterBtn;
-(void)didClickWXBtn;
-(void)didclickGuestBtn;
@end

@interface HWLoginScrollView : UIView <UIScrollViewDelegate>
@property (nonatomic,strong) UIScrollView *scrollView;
@property (nonatomic,strong) UIPageControl *pageControl;
@property (nonatomic,assign) CGFloat totalHeight;
@property (nonatomic,assign) id<HWLoginScrollViewDelegate> scrollViewDelegate;
@end
