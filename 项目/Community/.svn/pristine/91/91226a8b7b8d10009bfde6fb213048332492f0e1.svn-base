//
//  HWModifyGenderView.h
//  Community
//
//  Created by caijingpeng.haowu on 15/1/14.
//  Copyright (c) 2015年 caijingpeng. All rights reserved.
//

#import "HWBaseRefreshView.h"

@protocol HWModifyGenderViewDelegate <NSObject>

- (void)modifyGenderSuccess;

@end

@interface HWModifyGenderView : HWBaseRefreshView
{
    NSArray *_listData;
    NSString *_selectedGender;
}

@property (nonatomic, assign) id<HWModifyGenderViewDelegate> delegate;

@end
