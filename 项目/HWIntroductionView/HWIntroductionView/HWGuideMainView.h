//
//  HWGuideMainView.h
//  HWIntroductionView
//
//  Created by lizhongqiang on 15/11/9.
//  Copyright © 2015年 lizhongqiang. All rights reserved.
//

#import <UIKit/UIKit.h>
@protocol HWGuideMainViewDelegate<NSObject>
- (void)showStatusBar;
@end
@interface HWGuideMainView : UIView
@property (nonatomic, strong)UIPageControl *pageCtrl;
@property (nonatomic, assign)id<HWGuideMainViewDelegate>delegate;
@end
