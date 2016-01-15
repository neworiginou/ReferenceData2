//
//  HWAudioDownloader.h
//  Community
//
//  Created by caijingpeng.haowu on 14-9-16.
//  Copyright (c) 2014年 caijingpeng. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol HWAudioDownloaderDelegate <NSObject>

- (void)didDownloadFinishedWithData:(NSData *)audioData;
- (void)downloadFailWithError:(NSError *)error;

@end

@interface HWAudioDownloader : NSOperation<NSURLConnectionDelegate, NSURLConnectionDataDelegate>
{
    long long totalSize;
}

@property (nonatomic, strong) NSMutableData *audioData;
@property (nonatomic, strong) NSURLConnection *connection;
@property (nonatomic, strong) NSURL *downloadUrl;
@property (nonatomic, assign) float progress;
@property (nonatomic, assign) id<HWAudioDownloaderDelegate> delegate;
@property (nonatomic, strong) NSIndexPath *indexPath;

- (id)initWithAudioUrl:(NSURL *)audioUrl andIndex:(NSIndexPath *)index;


@end
