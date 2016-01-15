//
//  HWAudioCacheManager.m
//  Community
//
//  Created by caijingpeng.haowu on 14-9-16.
//  Copyright (c) 2014年 caijingpeng. All rights reserved.
//

#import "HWAudioCache.h"
#import <mach/mach.h>
#import <mach/mach_host.h>
#import <CommonCrypto/CommonDigest.h>

@implementation HWAudioCache
@synthesize memCache;
@synthesize ioQueue;
@synthesize diskCachePath;

static HWAudioCache *_audioCache = nil;

+ (HWAudioCache *)shareAudioCache
{
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        _audioCache = [[HWAudioCache alloc] init];
    });
    return _audioCache;
}

- (id)init
{
    self = [super init];
    if (self)
    {
        self.ioQueue = dispatch_queue_create("haowu.AudioCache", DISPATCH_QUEUE_SERIAL);
        NSArray *paths = NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES);
        self.diskCachePath = [paths[0] stringByAppendingPathComponent:@"haowu.AudioCache"];
        self.memCache = [[NSCache alloc] init];
        self.memCache.name = @"haowu.AudioCache";
    }
    return self;
}

- (void)storeAudio:(NSData *)audioData forKey:(NSString *)key
{
    [self.memCache setObject:audioData forKey:key];
    dispatch_async(self.ioQueue, ^
                   {
                       NSData *data = audioData;
                       
                       if (data)
                       {
                           // Can't use defaultManager another thread
                           NSFileManager *fileManager = NSFileManager.new;
                           
                           if (![fileManager fileExistsAtPath:self.diskCachePath])
                           {
                               [fileManager createDirectoryAtPath:self.diskCachePath withIntermediateDirectories:YES attributes:nil error:NULL];
                           }
                           [fileManager createFileAtPath:[self cachePathForKey:key] contents:data attributes:nil];
                       }
                       
                   });
    
}

- (NSData *)audioForKey:(NSString *)key
{
    NSData *data = [self.memCache objectForKey:key];
    if (data != nil)
    {
        return data;
    }
    
    data = [NSData dataWithContentsOfFile:[self cachePathForKey:key]];
    
    if (data)
    {
        [self.memCache setObject:data forKey:key];
    }
    
    return data;
}

- (NSString *)cachePathForKey:(NSString *)key
{
    const char *str = [key UTF8String];
    unsigned char r[CC_MD5_DIGEST_LENGTH];
    CC_MD5(str, (CC_LONG)strlen(str), r);
    NSString *filename = [NSString stringWithFormat:@"%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x",
                          r[0], r[1], r[2], r[3], r[4], r[5], r[6], r[7], r[8], r[9], r[10], r[11], r[12], r[13], r[14], r[15]];
    
    return [self.diskCachePath stringByAppendingPathComponent:filename];
}

- (void)clearMemory
{
    [self.memCache removeAllObjects];
}

- (void)clearDisk
{
    dispatch_async(self.ioQueue, ^
                   {
                       [[NSFileManager defaultManager] removeItemAtPath:self.diskCachePath error:nil];
                       [[NSFileManager defaultManager] createDirectoryAtPath:self.diskCachePath
                                                 withIntermediateDirectories:YES
                                                                  attributes:nil
                                                                       error:NULL];
                   });
}


@end
