//
//  HWAudioManager.m
//  Community
//
//  Created by caijingpeng.haowu on 14-9-16.
//  Copyright (c) 2014年 caijingpeng. All rights reserved.
//

#import "HWAudioManager.h"
#import "HWAudioCache.h"
#import "HWAudioDownloader.h"
#import "RecordAudio.h"
#import "HWAudioPlayCenter.h"

@implementation HWAudioManager

static HWAudioManager *_audioManager = nil;

+ (HWAudioManager *)shareAudioManager
{
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        _audioManager = [[HWAudioManager alloc] init];
    });
    return _audioManager;
}

- (id)init
{
    if (self = [super init]) {
        self.downloadQueue = [[NSOperationQueue alloc] init];
        self.downloadQueue.maxConcurrentOperationCount = 2;
    }
    return self;
}

- (void)playAudioUrl:(NSURL *)url forIndexPath:(NSIndexPath *)index
{
    HWAudioPlayCenter *playCenter = [HWAudioPlayCenter shareAudioPlayCenter];
    
    HWAudioCache *cache = [HWAudioCache shareAudioCache];
    NSData *data = [cache audioForKey:url.absoluteString];
    if (data != nil)
    {
        if ([playCenter isPlayingWithUrl:url])
        {
            // 如果正在播放的音频未当前url 暂停音频
            [playCenter pause];
        }
        else
        {
            // play
            [playCenter stop];
            playCenter.indexPath = index;
            playCenter.audioUrl = url;
            playCenter.audioData = data;
        }
    }
    else
    {
        //download
        
        for (int i = 0; i < self.downloadQueue.operationCount; i++) {
            HWAudioDownloader *downloaderOperation = [self.downloadQueue.operations pObjectAtIndex:i];
            NSString *urlStr = downloaderOperation.downloadUrl.absoluteString;
            if ([urlStr isEqualToString:url.absoluteString])
            {
                // 判断 url 是否已在下载队列中
                return;
            }
        }
        HWAudioDownloader *downloader = [[HWAudioDownloader alloc] initWithAudioUrl:url andIndex:index];
        // 下载完成发送通知 检测audio cell 是否可见 并且 cell url 与 下载 url 相等  即 播放
        [self.downloadQueue addOperation:downloader];
    }
    
}


@end










