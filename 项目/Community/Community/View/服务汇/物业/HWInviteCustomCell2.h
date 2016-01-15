//
//  HWInviteCustomCell2.h
//  Community
//
//  Created by niedi on 15/6/12.
//  Copyright (c) 2015年 caijingpeng. All rights reserved.
//

#import "HWBaseTableViewCell.h"

@protocol HWInviteCustomCell2Delegate <NSObject>

- (void)didSelectBtn:(NSString *)btnTitle;

@end

@interface HWInviteCustomCell2 : HWBaseTableViewCell

@property (nonatomic, weak) id<HWInviteCustomCell2Delegate> delegate;


- (void)setFold:(BOOL)isFold;

+ (CGFloat)getCellHeight:(BOOL)isFold;

- (void)setBtnSelectedWithTitle:(NSString *)title;

@end
