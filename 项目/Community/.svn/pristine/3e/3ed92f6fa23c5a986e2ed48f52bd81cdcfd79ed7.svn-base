//
//  HWAudioManager.h
//  Community
//
//  Created by caijingpeng.haowu on 14-9-16.
//  Copyright (c) 2014年 caijingpeng. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef void(^AudioStartBlock)();
typedef void(^AudioPauseBlock)();

@interface HWAudioManager : NSObject

@property (nonatomic, strong)NSOperationQueue *downloadQueue;

+ (HWAudioManager *)shareAudioManager;

- (void)playAudioUrl:(NSURL *)url forIndexPath:(NSIndexPath *)index;

@end
