//
//  HWAudioDownloader.m
//  Community
//
//  Created by caijingpeng.haowu on 14-9-16.
//  Copyright (c) 2014年 caijingpeng. All rights reserved.
//

#import "HWAudioDownloader.h"
#import "HWAudioCache.h"

@implementation HWAudioDownloader
@synthesize connection;
@synthesize delegate;
@synthesize progress;
@synthesize audioData;
@synthesize downloadUrl;
@synthesize indexPath;

- (id)initWithAudioUrl:(NSURL *)audioUrl andIndex:(NSIndexPath *)index
{
    self = [super init];
    if (self)
    {
        [self downloadWithUrl:audioUrl];
        self.indexPath = index;
    }
    return self;
}

- (void)downloadWithUrl:(NSURL *)url
{
    self.downloadUrl = url;
//    NSURLRequest *request = [[NSURLRequest alloc] initWithURL:url];
    NSMutableURLRequest *request = [NSMutableURLRequest.alloc initWithURL:url cachePolicy:NSURLRequestUseProtocolCachePolicy timeoutInterval:15];
    self.connection = [[NSURLConnection alloc] initWithRequest:request delegate:self];
    
//    NSLog(@"download url %@",url);
}

- (void)connection:(NSURLConnection *)connection didReceiveResponse:(NSURLResponse *)response
{
    totalSize = [response expectedContentLength];
    self.audioData = [NSMutableData data];
    
    NSDictionary *dic = [NSDictionary dictionaryWithObjectsAndKeys:self.downloadUrl, @"downloadUrl", self.indexPath, @"indexPath", nil];
    [[NSNotificationCenter defaultCenter] postNotificationName:HWAudioDownloaderDownloadindNotification object:dic];
    
//    NSLog(@"download url start %lld",totalSize);
}

- (void)connection:(NSURLConnection *)connection didReceiveData:(NSData *)data
{
    [self.audioData appendData:data];
    self.progress = self.audioData.length / (double)totalSize;
//    NSLog(@"downloading %d",self.audioData.length);
}

- (void)connectionDidFinishLoading:(NSURLConnection *)connection
{
//    NSLog(@"download finished  %d",self.audioData.length);
    // store disk
    // store memery
    NSDictionary *dic = [NSDictionary dictionaryWithObjectsAndKeys:self.downloadUrl, @"downloadUrl", self.audioData, @"audioData", self.indexPath, @"indexPath", nil];
    
    if (self.audioData.length < 50)
    { // 错误数据
//        NSLog(@"fail *******************");
        [[NSNotificationCenter defaultCenter] postNotificationName:HWAudioDownloaderFailedNotification object:dic];
        return;
    }
    [[HWAudioCache shareAudioCache] storeAudio:self.audioData forKey:self.downloadUrl.absoluteString];
    
    if (delegate && [delegate respondsToSelector:@selector(didDownloadFinishedWithData:)])
    {
        [delegate didDownloadFinishedWithData:self.audioData];
    }
    
    [[NSNotificationCenter defaultCenter] postNotificationName:HWAudioDownloaderFinishedNotification object:dic];
    
}

- (void)connection:(NSURLConnection *)connection didFailWithError:(NSError *)error
{
    if (delegate && [delegate respondsToSelector:@selector(downloadFailWithError:)])
    {
        [delegate downloadFailWithError:error];
    }
    NSDictionary *dic = [NSDictionary dictionaryWithObjectsAndKeys:self.downloadUrl, @"downloadUrl", self.audioData, @"audioData", self.indexPath, @"indexPath", nil];
    [[NSNotificationCenter defaultCenter] postNotificationName:HWAudioDownloaderFailedNotification object:dic];
}

@end
