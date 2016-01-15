//
//  HWPicBrownerAndEditViewController.h
//  Community
//
//  Created by hw500027 on 15/6/13.
//  Copyright (c) 2015年 caijingpeng. All rights reserved.
//

#import "HWBaseViewController.h"

@protocol HWPicBrownerAndEditViewControllerDelegate <NSObject>

- (void)didDeleteSelctedImg:(NSMutableArray *)picArray;

@end

@interface HWPicBrownerAndEditViewController : HWBaseViewController
@property (nonatomic , strong) NSMutableArray *picArray;
@property (nonatomic , assign) NSInteger selectIndex;
@property (nonatomic , strong) id <HWPicBrownerAndEditViewControllerDelegate> delegate;
@end
