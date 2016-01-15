//
//  HWAudioPlayCenter.h
//  Community
//
//  Created by caijingpeng.haowu on 14-9-16.
//  Copyright (c) 2014年 caijingpeng. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <AVFoundation/AVFoundation.h>
#import <CoreAudio/CoreAudioTypes.h>
#import "amrFileCodec.h"



@interface HWAudioPlayCenter : NSObject<AVAudioPlayerDelegate>

@property (nonatomic, strong) NSData *audioData;
@property (nonatomic, strong) AVAudioPlayer *avPlayer;
@property (nonatomic, strong) NSURL *audioUrl;
@property (nonatomic, strong) NSIndexPath *indexPath;

+ (HWAudioPlayCenter *)shareAudioPlayCenter;

- (BOOL)isPlayingWithUrl:(NSURL *)url;

- (BOOL)isPlaying;
- (void)play;
- (void)pause;
- (void)stop;

@end
