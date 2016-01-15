//
//  HWPersonalHomePageVC.h
//  Community
//
//  Created by niedi on 15/4/13.
//  Copyright (c) 2015年 caijingpeng. All rights reserved.
//

#import "HWBaseViewController.h"
#import "HWPersonalHomePageView.h"


@interface HWPersonalHomePageVC : HWBaseViewController<HWPersonalHomePageViewDelegate>
{
    HWPersonalHomePageView *_personView;
}

@property (nonatomic, strong) NSString *userId;



@end
