//
//  HWCropImageViewController.h
//  Community
//
//  Created by caijingpeng.haowu on 14-9-12.
//  Copyright (c) 2014年 caijingpeng. All rights reserved.
//

#import "HWBaseViewController.h"

@protocol HWCropImageViewControllerDelegate <NSObject>

- (void)didCropImage:(UIImage *)image;

@end

@interface HWCropImageViewController : HWBaseViewController

@property (nonatomic, strong)UIImage *stillImage;
@property (nonatomic, assign)id<HWCropImageViewControllerDelegate> delegate;

@end
