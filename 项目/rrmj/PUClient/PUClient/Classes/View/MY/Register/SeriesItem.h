//
//  SeriesItem.h
//  PUClient
//
//  Created by RRLhy on 15/7/20.
//  Copyright (c) 2015年 RRLhy. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void(^SeriesSelectBlock) (NSInteger index, BOOL isSelected);

@interface SeriesItem : UIView

@property (nonatomic,copy)SeriesSelectBlock selectBlock;

@end
