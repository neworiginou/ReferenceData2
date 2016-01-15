//
//  CityVC.h
//  PUClient
//
//  Created by RRLhy on 15/7/31.
//  Copyright (c) 2015年 RRLhy. All rights reserved.
//

#import "BaseViewController.h"

@protocol CityDelegate <NSObject>

- (void)selectedCity:(NSString*)selectName;

@end

@interface CityVC : BaseViewController

@property (nonatomic,assign)id <CityDelegate> delegate;

@end
