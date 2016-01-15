//
//  HWAlbumManager.m
//  Community
//
//  Created by caijingpeng.haowu on 15/1/16.
//  Copyright (c) 2015年 caijingpeng. All rights reserved.
//
//  功能描述：相册管理类
//
//  修改记录：
//      姓名         日期               修改内容
//     蔡景鹏     2015-01-16           创建文件
//

#import "HWAlbumManager.h"

NSString *const HWAlbumManagerLoadSuccess = @"ASSETS_LOAD_SUCCESS";

@implementation HWAlbumManager
@synthesize assetLibrary = _assetLibrary;
@synthesize assets = _assets;
@synthesize assetsFilter = _assetsFilter;
@synthesize groups = _groups;

static HWAlbumManager *_albumManager = nil;

- (id)init
{
    if (self = [super init])
    {
        _assetLibrary = [[ALAssetsLibrary alloc] init];
        _assetsFilter = [ALAssetsFilter allAssets];
        
        self.groups = [[NSMutableArray alloc] init];
        self.assets = [[NSMutableArray alloc] init];
//        dispatch_async(dispatch_queue_create("loadAlbum", DISPATCH_QUEUE_SERIAL), ^{
//            [self loadAlbum];
//        });
    }
    return self;
}

//+ (HWAlbumManager *)shareAlbumManager
//{
//    static dispatch_once_t onceToken;
//    dispatch_once(&onceToken, ^{
//        _albumManager = [[HWAlbumManager alloc] init];
//        _albumManager.groups = [[NSMutableArray alloc] init];
//        _albumManager.assets = [[NSMutableArray alloc] init];
//    });
//    return _albumManager;
//}

- (void)loadAlbum
{
//    [self.groups removeAllObjects];
//    [self.assets removeAllObjects];
    self.groups = [[NSMutableArray alloc] init];
    self.assets = [[NSMutableArray alloc] init];
    // 加载相册
    [_assetLibrary enumerateGroupsWithTypes:ALAssetsGroupAll usingBlock:^(ALAssetsGroup *group, BOOL *stop) {
        
        if (group)
        {
//            NSLog(@"$$$$$$$$ %@", );
            NSString *groupType = [NSString stringWithFormat:@"%@", [group valueForProperty:ALAssetsGroupPropertyType]];
            [group setAssetsFilter:_assetsFilter];
            if (group.numberOfAssets > 0 && groupType.intValue != 32)
            {
                // 不显示 分享流里的照片
                [self.groups addObject:group];
            }
        }
        else
        {
            if (self.groups.count > 0)
            {
                NSLog(@"########## %d", self.groups.count);
                for (ALAssetsGroup *assetsGroup in self.groups)
                {
//                    NSString *name = [assetsGroup valueForProperty:ALAssetsGroupPropertyName];
//                    if ([name isEqualToString:@"Camera Roll"] || [name isEqualToString:@"相机胶卷"])
//                    {
                        [self setupAssets:assetsGroup];
//                    }
                }
            }
            
        }
        
    } failureBlock:^(NSError *error) {
        
        NSLog(@"------%@",error.description);
        NSLog(@"%d",(int)error.code);
        
        if(error.code == -3311)
        {
            //            [Utility showAlertWithMessage:@"无法读取相册图片，请打开设备\"设置\"-\"隐私\"-\"照片\"，开启\"考拉社区\"访问权限"];
            //            UIAlertView *alert=[[UIAlertView alloc]initWithTitle:NSLocalizedString(@"alert", @"") message:NSLocalizedString(@"privacyPhoto", @"") delegate:nil cancelButtonTitle:NSLocalizedString(@"OK", @"") otherButtonTitles:nil, nil];
            //            [alert show];
        }
        
    }];
}

- (void)setupAssets:(ALAssetsGroup *)assetsGroup
{
    ALAssetsGroupEnumerationResultsBlock resultsBlock = ^(ALAsset *asset, NSUInteger index, BOOL *stop) {
        
        if (asset)
        {
            [self.assets addObject:asset];
            //            NSString *type = [asset valueForProperty:ALAssetPropertyType];
        }
        else if (self.assets.count > 0)
        {
            // 倒序
            [Utility reverseArray:self.assets];
            
            dispatch_async(dispatch_get_main_queue(), ^{
                
                [[NSNotificationCenter defaultCenter] postNotificationName:HWAlbumManagerLoadSuccess object:nil];
            });
            
        }
    };
    
    [assetsGroup enumerateAssetsUsingBlock:resultsBlock];
}



@end
