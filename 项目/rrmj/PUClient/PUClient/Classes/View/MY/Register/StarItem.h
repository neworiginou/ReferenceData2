//
//  StarItem.h
//  PUClient
//
//  Created by RRLhy on 15/7/20.
//  Copyright (c) 2015年 RRLhy. All rights reserved.
//

#import <UIKit/UIKit.h>
typedef void(^StarSelectBlok) (NSInteger index,BOOL isSelected);
@interface StarItem : UIView
@property (nonatomic,copy)StarSelectBlok selectBlok;
@end
