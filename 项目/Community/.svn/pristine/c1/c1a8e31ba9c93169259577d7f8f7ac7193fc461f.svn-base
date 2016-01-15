//
//  HWAlbumManager.h
//  Community
//
//  Created by caijingpeng.haowu on 15/1/16.
//  Copyright (c) 2015年 caijingpeng. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <AssetsLibrary/AssetsLibrary.h>

extern NSString *const HWAlbumManagerLoadSuccess;

@interface HWAlbumManager : NSObject

@property (nonatomic, strong) NSMutableArray *groups;
@property (nonatomic, strong) NSMutableArray *assets;           // 相册图片
@property (nonatomic, strong) ALAssetsLibrary *assetLibrary;
@property (nonatomic, strong) ALAssetsFilter *assetsFilter;

//+ (HWAlbumManager *)shareAlbumManager;

- (void)loadAlbum;

@end

