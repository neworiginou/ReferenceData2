//
//  HWSearchListTableView.h
//  Community
//
//  Created by hw500028 on 15/1/13.
//  Copyright (c) 2015年 caijingpeng. All rights reserved.
//

#import "HWBaseRefreshView.h"
#import "HWChannelModel.h"

@class HWSearchListTableView;
@protocol hwsearchListTableDelegate <NSObject>

@optional
- (void)searchListTableView:(HWSearchListTableView *)searchListTableView createChannelButtonSelected:(UIButton *)btn;
//
- (void)searchListTableView:(HWSearchListTableView *)searchListTableView pushCtroller:(HWChannelModel *)model;
@end

@interface HWSearchListTableView : HWBaseRefreshView
@property (nonatomic, strong) NSArray * dataArr;
@property (nonatomic, assign) BOOL isShow;
@property (nonatomic, strong) NSString * searchWord;
@property (nonatomic, assign) id <hwsearchListTableDelegate>delegate;

@end
