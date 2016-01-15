//
//  MainViewController.h
//  BlurryImage
//
//  Created by guohu on 15/7/14.
//  Copyright (c) 2015年 idouzi.com. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <Accelerate/Accelerate.h>

@interface MainViewController : UIViewController

@property (strong,nonatomic)IBOutlet UISlider *m_slider;
@property (strong,nonatomic)IBOutlet UIImageView *bkgroundView;

@end
