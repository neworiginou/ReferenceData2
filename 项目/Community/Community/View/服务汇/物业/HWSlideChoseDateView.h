//
//  HWSlideChoseDateView.h
//  Community
//
//  Created by hw500027 on 15/6/12.
//  Copyright (c) 2015年 caijingpeng. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol HWSlideChoseDateViewDelegate <NSObject>

- (void)didSelectSlideDate:(NSString *)date;

@end

@interface HWSlideChoseDateView : UIView
@property (nonatomic , weak) id <HWSlideChoseDateViewDelegate> slideViewDelegate;
@end
