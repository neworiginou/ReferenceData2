//
//  HWInviteCustomCell1.h
//  Community
//
//  Created by niedi on 15/6/12.
//  Copyright (c) 2015年 caijingpeng. All rights reserved.
//

#import "HWBaseTableViewCell.h"

@protocol HWInviteCustomCell1Delegate <NSObject>

- (void)getSlideChoseDateString:(NSString *)dateStr;

@end


@interface HWInviteCustomCell1 : HWBaseTableViewCell

@property (nonatomic, weak) id<HWInviteCustomCell1Delegate> delegate;


- (void)setFold:(BOOL)isFold;

+ (CGFloat)getCellHeight:(BOOL)isFold;

@end
