//
//  RecordAudio.h
//  JuuJuu
//
//  Created by xiaoguang huang on 11-12-19.
//  Copyright (c) 2011年 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <AVFoundation/AVFoundation.h>
#import <CoreAudio/CoreAudioTypes.h>
#import "amrFileCodec.h"

@protocol RecordAudioDelegate <NSObject>

//0 播放 1 播放完成 2出错 3 暂停
- (void)RecordStatus:(int)status;

@optional
- (void)didRecoderUpdateMeters:(float)value;

@end

@interface RecordAudio : NSObject <AVAudioRecorderDelegate,AVAudioPlayerDelegate>
{
    //Variables setup for access in the class:
	NSURL * recordedTmpFile;
	AVAudioRecorder * recorder;
	NSError * error;
    AVAudioPlayer * avPlayer;
    NSTimer *timer;
}

@property (nonatomic,assign)id<RecordAudioDelegate> delegate;
@property (nonatomic, strong)AVAudioPlayer * avPlayer;
@property (nonatomic, strong)NSError *recorderError;

- (NSURL *)stopRecord;
- (void)startRecord;

- (void)initPlayerWithData:(NSData *)data;
- (void)stopPlay;
+ (NSTimeInterval)getAudioTime:(NSData *)data;
- (void)pausePlay;
- (void)play;
- (void)initRecord;

@end
