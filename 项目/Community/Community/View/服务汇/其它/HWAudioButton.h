//
//  HWAudioButton.h
//  UnitTest
//
//  Created by caijingpeng.haowu on 14-9-17.
//  Copyright (c) 2014年 caijingpeng. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface HWAudioButton : UIButton
{
    UIImageView *animateImgV;
    UIActivityIndicatorView *activityView;
}

- (void)setPlayMode:(PlayMode)mode;

@end
