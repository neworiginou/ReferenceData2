//
//  HWPersonDynamicRefreshView.h
//  Community
//
//  Created by hw500027 on 15/1/9.
//  Copyright (c) 2015年 caijingpeng. All rights reserved.
//

#import "HWBaseRefreshView.h"
#import "HWPersonDynamicModel.h"
#import "HWSoundPlayButton.h"

typedef NS_ENUM(NSInteger, DataType) {
    MineType = 0,
    CommentType,
    LikeType,
    ThemeType
};

//代理方法
@protocol HWPersonDynamicRefreshViewDelegate <NSObject>
- (void)didSelectPersonDynamicRefreshView:(HWPersonDynamicModel *)personDynamicModel;
@end


@interface HWPersonDynamicRefreshView : HWBaseRefreshView

@property (nonatomic,assign) DataType dataType;
@property (nonatomic,assign) BOOL isAddRedPoint;
@property (nonatomic,strong) NSString *soundUrl;

- (void)queryListData;

- (void)downloadingAudio:(NSNotification *)notification;

- (void)downloadAudioFinish:(NSNotification *)notificaiton;

- (void)downloadAudioFailed:(NSNotification *)notificaiton;

- (void)startPlayNotification:(NSNotification *)notificaiton;

- (void)pausePlayNotification:(NSNotification *)notificaiton;

- (void)stopPlayNotification:(NSNotification *)notificaiton;

-(id)initWithFrame:(CGRect)frame andDataType:(NSInteger)dataType;
@property (nonatomic, assign)PlayMode playStatus;

@property (nonatomic, assign) id<HWPersonDynamicRefreshViewDelegate> delegate;
@end
