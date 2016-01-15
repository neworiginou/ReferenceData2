//
//  HWServiceMoreVC.h
//  Community
//
//  Created by niedi on 15/6/25.
//  Copyright (c) 2015年 caijingpeng. All rights reserved.
//

#import "HWBaseViewController.h"

@protocol HWServiceMoreVCDelegate <NSObject>

- (void)setRefresh;

@end

@interface HWServiceMoreVC : HWBaseViewController

@property (nonatomic, weak) id<HWServiceMoreVCDelegate> delegate;

@property (nonatomic, strong) NSArray *homepageIconArr;



@end
