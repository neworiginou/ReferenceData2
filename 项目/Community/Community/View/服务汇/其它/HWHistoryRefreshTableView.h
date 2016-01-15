//
//  HWHistoryRefreshTableView.h
//  Community
//
//  Created by caijingpeng.haowu on 14-12-11.
//  Copyright (c) 2014年 caijingpeng. All rights reserved.
//

#import "HWBaseRefreshView.h"
#import "HWTreatureHistoryCell.h"

@protocol HWHistoryRefreshTableViewDelegate <NSObject>

- (void)didSelectHistoryTableItem:(HWActivityHistoryModel *)historyItem;

@end

@interface HWHistoryRefreshTableView : HWBaseRefreshView

@property (nonatomic, assign) id<HWHistoryRefreshTableViewDelegate> delegate;

@end
