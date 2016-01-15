//
//  HWGoodsListView.h
//  Community
//
//  Created by lizhongqiang on 15/4/13.
//  Copyright (c) 2015年 caijingpeng. All rights reserved.
//

#import "HWBaseRefreshView.h"
#import "HWGoodsListCell.h"

@protocol HWGoodsListViewDelegate <NSObject>

- (void)cellSelectPushVC:(UIViewController *)vc;
- (void)setWuDiXianChannelId:(NSString *)wuDiXianChannelId;

@end


@interface HWGoodsListView : HWBaseRefreshView<HWGoodsListCellDelegate>
{
    long _theTime;
    NSTimer *_theTimer;
}

@property (nonatomic, assign) id<HWGoodsListViewDelegate>delegate;
@property (nonatomic, strong) NSString *wuDiXianChannelId;
@property (nonatomic , strong) NSString *selectTime;
@property (nonatomic , assign) float floatConstant;

- (void)queryListData;

@end
