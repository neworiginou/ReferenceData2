//
//  RecordAudio.m
//  JuuJuu
//
//  Created by xiaoguang huang on 11-12-19.
//  Copyright (c) 2011年 __MyCompanyName__. All rights reserved.
//

#import "RecordAudio.h"
#import <AudioToolbox/AudioToolbox.h>
#import <AVFoundation/AVFoundation.h>
#import "amrFileCodec.h"

@implementation RecordAudio
@synthesize delegate;
@synthesize avPlayer;
@synthesize recorderError;

- (void)dealloc {
    [recorder dealloc];
	recorder = nil;
	recordedTmpFile = nil;
    [avPlayer stop];
    [avPlayer release];
    avPlayer = nil;
    [super dealloc];
}

- (id)init {
    self = [super init];
    if (self) {
        //Instanciate an instance of the AVAudioSession object.
        AVAudioSession * audioSession = [AVAudioSession sharedInstance];
        //Setup the audioSession for playback and record. 
        //We could just use record and then switch it to playback leter, but
        //since we are going to do both lets set it up once.
        
        if ([audioSession respondsToSelector:@selector(requestRecordPermission:)]) {
            
            [audioSession requestRecordPermission:^(BOOL available) {
                
                if (available) {
                    //completionHandler
                    [audioSession setCategory:AVAudioSessionCategoryPlayAndRecord error: &recorderError];
                    
                    UInt32 audioRouteOverride = kAudioSessionOverrideAudioRoute_Speaker;
                    AudioSessionSetProperty (kAudioSessionProperty_OverrideAudioRoute,
                                             sizeof (audioRouteOverride),
                                             &audioRouteOverride);
                    
                    //Activate the session
                    [audioSession setActive:YES error: &recorderError];
                }
                else
                {
                    self.recorderError = [NSError errorWithDomain:@"record" code:9999 userInfo:nil];
                    dispatch_async(dispatch_get_main_queue(), ^{
                        [[[UIAlertView alloc] initWithTitle:@"提示" message:@"请在“设置-隐私-麦克风”选项中允许考拉社区访问你的麦克风" delegate:nil cancelButtonTitle:@"确定" otherButtonTitles:nil] show];
                    });
                }
            }];
            
        }
        
        
        
        
        
        
    }
    return self;
}

- (NSURL *) stopRecord
{
    NSURL *url = nil;
    if (recorder.url.absoluteString.length != 0)
    {
        url = [[NSURL alloc]initWithString:recorder.url.absoluteString];
    }
    
    [recorder stop];
    [recorder release];
    recorder =nil;
    
    [timer invalidate];
    timer = nil;
    
    
    return url;
    
//    return [url autorelease];
}

+ (NSTimeInterval)getAudioTime:(NSData *) data {
    NSError * error;
    AVAudioPlayer*play = [[AVAudioPlayer alloc] initWithData:data error:&error];
    NSTimeInterval n = [play duration];
    [play release];
    return n;
}

//0 播放 1 播放完成 2出错
- (void)sendStatus:(int)status
{
    if (delegate && [self.delegate respondsToSelector:@selector(RecordStatus:)])
    {
        [self.delegate RecordStatus:status];
    }
}

- (void)stopPlay
{
    if (avPlayer != nil)
    {
        [avPlayer stop];
        [self sendStatus:1];
    }
}

- (void)pausePlay
{
    if (avPlayer != nil)
    {
        [avPlayer pause];
        [self sendStatus:3];
    }
}

-(NSData *)decodeAmr:(NSData *)data{
    if (!data) {
        return data;
    }

    return DecodeAMRToWAVE(data);
}

- (void)initPlayerWithData:(NSData *)data
{
//    if (avPlayer != nil)
//    {
//        [self stopPlay];
//        return;
//    }
    NSData* o = [self decodeAmr:data];
    avPlayer = [[AVAudioPlayer alloc] initWithData:o error:&error];
    avPlayer.delegate = self;
    avPlayer.meteringEnabled = YES;
}

- (void)play
{
    [avPlayer prepareToPlay];
	if(![avPlayer play])
    {
        [self sendStatus:2];
    }
    else
    {
        [self sendStatus:0];
    }
}

- (void)audioPlayerDidFinishPlaying:(AVAudioPlayer *)player successfully:(BOOL)flag {
    [self sendStatus:1];
}

- (void)audioPlayerDecodeErrorDidOccur:(AVAudioPlayer *)player error:(NSError *)error{
    [self sendStatus:2];
}

- (void)initRecord
{
    //Begin the recording session.
    //Error handling removed.  Please add to your own code.
    
    //Setup the dictionary object with all the recording settings that this
    //Recording sessoin will use
    //Its not clear to me which of these are required and which are the bare minimum.
    //This is a good resource: http://www.totodotnet.net/tag/avaudiorecorder/
    
    NSDictionary *recordSetting = [NSDictionary dictionaryWithObjectsAndKeys:
                                   [NSNumber numberWithInt:kAudioFormatLinearPCM], AVFormatIDKey,
                                   //[NSNumber numberWithFloat:44100.0], AVSampleRateKey,
                                   [NSNumber numberWithFloat:8000.00], AVSampleRateKey,
                                   [NSNumber numberWithInt:1], AVNumberOfChannelsKey,
                                   //  [NSData dataWithBytes:&channelLayout length:sizeof(AudioChannelLayout)], AVChannelLayoutKey,
                                   [NSNumber numberWithInt:16], AVLinearPCMBitDepthKey,
                                   [NSNumber numberWithBool:NO], AVLinearPCMIsNonInterleaved,
                                   [NSNumber numberWithBool:NO],AVLinearPCMIsFloatKey,
                                   [NSNumber numberWithBool:NO], AVLinearPCMIsBigEndianKey,
                                   nil];
    
    
    recordedTmpFile = [NSURL fileURLWithPath:[NSTemporaryDirectory() stringByAppendingPathComponent: [NSString stringWithFormat: @"%.0f.%@", [NSDate timeIntervalSinceReferenceDate] * 1000.0, @"caf"]]];
//    NSLog(@"Using File called: %@",recordedTmpFile);
    
    recorder = [[AVAudioRecorder alloc] initWithURL:recordedTmpFile settings:recordSetting error:&error];
    [recorder setDelegate:self];
}

-(void) startRecord
{
    [recorder prepareToRecord];
    [recorder record];
    recorder.meteringEnabled = YES;
    
    if (timer == nil)
    {
        timer = [NSTimer scheduledTimerWithTimeInterval:1/20.0f target:self selector:@selector(scheduledUpdateMeters) userInfo:nil repeats:YES];
    }
}

- (void)scheduledUpdateMeters
{
    if (recorder != nil)
    {
        [recorder updateMeters];
    }
    
    float value = [recorder averagePowerForChannel:0];
    
    if (delegate && [delegate respondsToSelector:@selector(didRecoderUpdateMeters:)])
    {
        [delegate didRecoderUpdateMeters:value];
    }
//    NSLog(@"**** %@ %f", recorder,value);
}




@end
