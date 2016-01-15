//
//  HWRecorderView.h
//  CallPhoneAlert
//
//  Created by caijingpeng.haowu on 14-9-12.
//  Copyright (c) 2014年 Lizhongqiang. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "RecordAudio.h"
#import "KACircleProgressView.h"

typedef enum {
    Inactive = 0,
	RecorderStart,
	Recordering,
	Playing,
    Pause,
    Stop
} RecorderState;

@protocol HWRecorderViewDelegate <NSObject>

- (void)moveToRecordState;
- (void)recordTiming:(int)time;
- (void)recordState:(RecorderState)state;
- (void)finishRecordWithData:(NSData *)audioData andDuration:(int)time;

@end

@interface HWRecorderView : UIView <UIGestureRecognizerDelegate,RecordAudioDelegate>
{
    UIImageView *_frontImgV;
    UILongPressGestureRecognizer *_longPress;
    UITapGestureRecognizer *_tap;
    RecordAudio *recordAudio;
    NSData *curAudio;
    int recordTime;
    NSTimer *timer;
    
    UIImageView *_bigCircle;
    UIImageView *_midCircle;
    
    UIControl *_controlV;
    KACircleProgressView *_playerProgress;
    int audioTotalTime;
    BOOL activeCountDown;
}

@property (nonatomic, assign) RecorderState state;
@property (nonatomic, assign) id<HWRecorderViewDelegate> delegate;

- (void)resetRecord;

- (void)stopPlay;

@end
