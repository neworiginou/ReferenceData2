//
//  HWAudioCacheManager.h
//  Community
//
//  Created by caijingpeng.haowu on 14-9-16.
//  Copyright (c) 2014年 caijingpeng. All rights reserved.
//

#import <Foundation/Foundation.h>

#define MemeryMaxSize (5 * 1024 * 1024)     // 5M

@interface HWAudioCache : NSObject

@property (nonatomic, strong)NSCache *memCache;
@property (nonatomic, strong)dispatch_queue_t ioQueue;
@property (nonatomic, strong)NSString *diskCachePath;

+ (HWAudioCache *)shareAudioCache;

- (void)storeAudio:(NSData *)data forKey:(NSString *)key;

- (NSData *)audioForKey:(NSString *)key;

- (void)clearMemory;

- (void)clearDisk;

@end
