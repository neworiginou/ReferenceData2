//
//  HWClickZanRefreshView.h
//  Community
//
//  Created by hw500029 on 15/1/20.
//  Copyright (c) 2015年 caijingpeng. All rights reserved.



#import <UIKit/UIKit.h>
#import "HWBaseRefreshView.h"

@interface HWClickZanRefreshView : HWBaseRefreshView

@property (nonatomic ,copy)NSString *topicId;
@property (nonatomic ,assign)BOOL isLast;//次界面不用上啦刷新，而是点击按钮加载更多
@property (nonatomic ,strong)NSMutableArray *normalDataList;
@property (nonatomic ,assign)BOOL isFirstRequest;

@property (nonatomic ,copy)void(^changeNavTitleView)(NSString *title);

- (id)initWithFrame:(CGRect)frame andTopicId:(NSString *)topicId;

@end
