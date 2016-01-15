//
//  HWAudioPlayCenter.m
//  Community
//
//  Created by caijingpeng.haowu on 14-9-16.
//  Copyright (c) 2014年 caijingpeng. All rights reserved.
//

#import "HWAudioPlayCenter.h"

@implementation HWAudioPlayCenter
@synthesize audioData;
@synthesize avPlayer;
@synthesize audioUrl;
@synthesize indexPath;

static HWAudioPlayCenter *_playCenter = nil;

+ (HWAudioPlayCenter *)shareAudioPlayCenter
{
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        _playCenter = [[HWAudioPlayCenter alloc] init];
    });
    return _playCenter;
}

- (id)init
{
    self = [super init];
    if (self)
    {
        NSError *error;
        AVAudioSession * audioSession = [AVAudioSession sharedInstance];
        [audioSession setCategory:AVAudioSessionCategoryPlayAndRecord error: &error];
        
        UInt32 audioRouteOverride = kAudioSessionOverrideAudioRoute_Speaker;
        AudioSessionSetProperty (kAudioSessionProperty_OverrideAudioRoute,
								 sizeof (audioRouteOverride),
								 &audioRouteOverride);
        //Activate the session
        [audioSession setActive:NO error: &error];
    }
    return self;
}

- (NSData *)decodeAmr:(NSData *)data
{
    if (!data)
    {
        return data;
    }
    return DecodeAMRToWAVE(data);
}

- (void)setAudioData:(NSData *)_audioData
{
    
    AVAudioSession * audioSession = [AVAudioSession sharedInstance];
    [audioSession setActive:YES error:nil];
    
//    NSData *targetData = [self decodeAmr:_audioData];
    NSError *error;
    self.avPlayer = [[AVAudioPlayer alloc] initWithData:_audioData error:&error];
    self.avPlayer.delegate = self;
//    self.avPlayer.meteringEnabled = YES;
    self.avPlayer.volume = 1.0f;
    
    BOOL success = [self.avPlayer prepareToPlay];
    if (!success)
    {
        NSData *targetData = [self decodeAmr:_audioData];
        self.avPlayer = [[AVAudioPlayer alloc] initWithData:targetData error:&error];
        self.avPlayer.delegate = self;
        self.avPlayer.volume = 1.0f;
        [self.avPlayer prepareToPlay];
    }
    
    [self play];
}

- (void)play
{
    AVAudioSession * audioSession = [AVAudioSession sharedInstance];
    [audioSession setActive:YES error:nil];
    
    BOOL success = [self.avPlayer play];
    if (success)
    {
        NSDictionary *dic = [NSDictionary dictionaryWithObjectsAndKeys:indexPath, @"indexPath", nil];
        NSLog(@"%d %d",indexPath.row, indexPath.section);
        [[NSNotificationCenter defaultCenter] postNotificationName:HWAudioPlayCenterStartPlayNotification object:dic];
    }
}

- (void)pause
{
    [self.avPlayer pause];
    NSDictionary *dic = [NSDictionary dictionaryWithObjectsAndKeys:indexPath, @"indexPath", nil];
    [[NSNotificationCenter defaultCenter] postNotificationName:HWAudioPlayCenterPausePlayNotification object:dic];
    
    AVAudioSession * audioSession = [AVAudioSession sharedInstance];
    [audioSession setActive:NO error:nil];
}

- (void)stop
{
    [self.avPlayer stop];
    
    if (indexPath != nil)
    {
        NSDictionary *dic = [NSDictionary dictionaryWithObjectsAndKeys:indexPath, @"indexPath", nil];
        [[NSNotificationCenter defaultCenter] postNotificationName:HWAudioPlayCenterStopPlayNotification object:dic];
        
        indexPath = nil;
        
        AVAudioSession * audioSession = [AVAudioSession sharedInstance];
        [audioSession setActive:NO error:nil];
    }
}

- (BOOL)isPlayingWithUrl:(NSURL *)url
{
    if (self.avPlayer.isPlaying && [url.absoluteString isEqualToString:self.audioUrl.absoluteString])
    {
        return YES;
    }
    return NO;
}

- (BOOL)isPlaying
{
    if (self.avPlayer.isPlaying) {
        return YES;
    }
    return NO;
}

- (void)audioPlayerDidFinishPlaying:(AVAudioPlayer *)player successfully:(BOOL)flag
{
    NSDictionary *dic = [NSDictionary dictionaryWithObjectsAndKeys:indexPath, @"indexPath", nil];
    [[NSNotificationCenter defaultCenter] postNotificationName:HWAudioPlayCenterStopPlayNotification object:dic];
}


- (void)audioPlayerDecodeErrorDidOccur:(AVAudioPlayer *)player error:(NSError *)error
{
    NSLog(@"%@",error);
}

@end







