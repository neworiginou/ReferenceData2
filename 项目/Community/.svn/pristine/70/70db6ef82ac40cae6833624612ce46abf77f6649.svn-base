//
//  VideoEncoder.m
//  Encoder Demo
//
//  Created by Geraint Davies on 14/01/2013.
//  Copyright (c) 2013 GDCL http://www.gdcl.co.uk/license.htm
//

#import "VideoEncoder.h"

#define MAX_RECORD_TIMING 15
@implementation VideoEncoder

@synthesize path = _path,_writer;

+ (VideoEncoder*) encoderForPath:(NSString*) path Height:(int) cy width:(int) cx channels: (int) ch samples:(Float64) rate;
{
    VideoEncoder* enc = [VideoEncoder alloc];
    [enc initPath:path Height:cy width:cx channels:ch samples:rate];
    return enc;
}


- (void) initPath:(NSString*)path Height:(int) cy width:(int) cx channels: (int) ch samples:(Float64) rate;
{
    self.path = path;
    
    [[NSFileManager defaultManager] removeItemAtPath:self.path error:nil];
    NSURL* url = [NSURL fileURLWithPath:self.path];
    NSLog(@"##########################       new writer");
    self._writer = [AVAssetWriter assetWriterWithURL:url fileType:AVFileTypeMPEG4 error:nil];

    
    NSMutableDictionary *codecSettings = [NSMutableDictionary dictionaryWithObjectsAndKeys:
//                                   AVVideoH264EntropyModeCABAC, AVVideoH264EntropyModeKey,
                                          [NSNumber numberWithInt:480000], AVVideoAverageBitRateKey,
                                          AVVideoProfileLevelH264Main30, AVVideoProfileLevelKey,
                                          nil];
    
    if (IOS7) {
        [codecSettings setObject:AVVideoH264EntropyModeCABAC forKey:AVVideoH264EntropyModeKey];
    }
    
    NSDictionary* settings = [NSDictionary dictionaryWithObjectsAndKeys:
                              AVVideoCodecH264, AVVideoCodecKey,
                              [NSNumber numberWithInt: cx], AVVideoWidthKey,
                              [NSNumber numberWithInt: cy], AVVideoHeightKey,
                              AVVideoScalingModeResizeAspectFill, AVVideoScalingModeKey,
                              codecSettings, AVVideoCompressionPropertiesKey,
                              nil];
    _videoInput = [AVAssetWriterInput assetWriterInputWithMediaType:AVMediaTypeVideo outputSettings:settings];
    _videoInput.expectsMediaDataInRealTime = YES;
    [_writer addInput:_videoInput];
    
    AudioChannelLayout acl;
    bzero(&acl, sizeof(acl));
    acl.mChannelLayoutTag = kAudioChannelLayoutTag_Stereo;
    settings = [NSDictionary dictionaryWithObjectsAndKeys:
                [ NSNumber numberWithInt: kAudioFormatMPEG4AAC], AVFormatIDKey,
                [ NSNumber numberWithInt: 2], AVNumberOfChannelsKey,   //如果是4s  需要两个声道
                [ NSNumber numberWithFloat: rate], AVSampleRateKey,
                [ NSNumber numberWithInt: 64000 ], AVEncoderBitRateKey,
                [NSData dataWithBytes:&acl length:sizeof(AudioChannelLayout)], AVChannelLayoutKey,
                nil];
    _audioInput = [AVAssetWriterInput assetWriterInputWithMediaType:AVMediaTypeAudio outputSettings:settings];
    _audioInput.expectsMediaDataInRealTime = YES;
    [_writer addInput:_audioInput];
    
    
}

- (void) finishWithCompletionHandler:(void (^)(void))handler
{
//    BOOL success = [_writer finishWriting];
    [_writer finishWritingWithCompletionHandler:handler];
//    if (success) {
//        handler();
//    }
}

- (void)cancelWrite:(void (^)(void))handler
{
    [_writer finishWritingWithCompletionHandler:handler];
}

- (BOOL)encodeFrame:(CMSampleBufferRef)sampleBuffer isVideo:(BOOL)bVideo
{
    @synchronized(self)
    {
        if (CMSampleBufferDataIsReady(sampleBuffer))
        {
            if (_writer.status == AVAssetWriterStatusUnknown)
            {
                CMTime startTime = CMSampleBufferGetPresentationTimeStamp(sampleBuffer);
                [_writer startWriting];
                [_writer startSessionAtSourceTime:startTime];
                time = ((double)startTime.value)/startTime.timescale;
                NSLog(@"~~~~~~~~~  start : %f,write status : %ld    path : %@",time,(long)_writer.status,self.path);
                
            }
            if (_writer.status == AVAssetWriterStatusFailed)
            {
                CMTime startTime = CMSampleBufferGetPresentationTimeStamp(sampleBuffer);
                float s = ((double)startTime.value)/startTime.timescale;
                NSLog(@"writer error %@,%f", _writer.error.localizedDescription,s);
                return NO;
            }
            
//            NSLog(@"_writer status %d",_writer.status);
            if (bVideo)
            {
                if (_videoInput.readyForMoreMediaData == YES)
                {
                    [_videoInput appendSampleBuffer:sampleBuffer];
                    
                    CMTime startTime = CMSampleBufferGetPresentationTimeStamp(sampleBuffer);
                    float s = ((double)startTime.value)/startTime.timescale;
                    
                    float value = (s - time) / MAX_RECORD_TIMING;
//                    NSLog(@"~~~~~~~~~ : %f",s);
                    if (self.slider)
                    {
                        [self performSelectorOnMainThread:@selector(setProgress:) withObject:[NSString stringWithFormat:@"%f",value] waitUntilDone:NO];
                    }
                    
                    return YES;
                }
            }
            else
            {
                if (_audioInput.readyForMoreMediaData)
                {
                    [_audioInput appendSampleBuffer:sampleBuffer];
                    return YES;
                }
            }
            
        }
    }
    
    return NO;
}
- (void)setProgress:(NSString *)sender
{
    self.slider.progress = sender.floatValue;
    
    if (self.slider.progress >= 1) {
        [[NSNotificationCenter defaultCenter] postNotificationName:@"stopRecord" object:nil];
    }
}

- (void)dealloc
{
    self.path = nil;
    self._writer = nil;
    self.slider = nil;
    [super dealloc];
    
}

@end
