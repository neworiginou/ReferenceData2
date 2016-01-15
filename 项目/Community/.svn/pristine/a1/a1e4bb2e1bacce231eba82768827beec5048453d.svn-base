//
//  HWInviteCustomView.h
//  Community
//
//  Created by niedi on 15/6/12.
//  Copyright (c) 2015年 caijingpeng. All rights reserved.
//

#import "HWBaseRefreshView.h"
#import "HWInviteCustomRecordModel.h"

@protocol HWInviteCustomViewDelegate <NSObject>

- (void)visitPhoneBook;
- (void)pushViewController:(UIViewController *)VC;

@end


@interface HWInviteCustomView : HWBaseRefreshView

@property (nonatomic, strong) UIViewController *fatherVC;

@property (nonatomic, weak) id<HWInviteCustomViewDelegate> delegate;


- (instancetype)initWithFrame:(CGRect)frame recordModel:(HWInviteCustomRecordModel *)recordModel;

- (void)phoneBookSet:(NSString *)phoneNum name:(NSString *)name;


@end
