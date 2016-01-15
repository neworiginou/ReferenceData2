//
//  HWSearchChannelView.h
//  Community
//
//  Created by caijingpeng.haowu on 15/1/15.
//  Copyright (c) 2015年 caijingpeng. All rights reserved.
//

#import "HWBaseRefreshView.h"
#import "HWChannelModel.h"

@protocol HWSearchChannelViewDelegate <NSObject>

- (void)searchChannelViewCancelSearch;
- (void)searchChannelResult:(HWChannelModel *)dataModel;
- (void)didCreateChannel:(HWChannelModel *)dataModel;
- (void)didDeleteCurrentChannel;

@end

@interface HWSearchChannelView : HWBaseRefreshView <UITextFieldDelegate>
{
    UIView *_searchView;
    HWTextField *_searchBarTF;
    UIButton *_deleteButton;         //删除话题按钮
}

@property (nonatomic, assign) id <HWSearchChannelViewDelegate> delegate;
@property (nonatomic, strong) NSMutableArray *hotList;
@property (nonatomic, strong) HWChannelModel *curChannel;

- (void)addKeyboardAbserver;
- (void)removeKeyboardAbserver;

@end
