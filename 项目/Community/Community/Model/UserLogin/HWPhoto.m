//
//  HWPhoto.m
//  Community
//
//  Created by gusheng on 14-9-19.
//  Copyright (c) 2014年 caijingpeng. All rights reserved.
//

#import "HWPhoto.h"

@implementation HWPhoto
@synthesize photoKey;
@synthesize photoUrl;
@synthesize localPhotoImage;
/**
 *  保存图片数据
 *
 *  @param photoUrlStr     空传nil
 *  @param photoKeyStr     空传nil
 *  @param localPhotoImage 空传nil
 *
 *  @return self
 */
- (id)initWithUrlAndKey:(NSURL *)photoUrlStr key:(NSString *)photoKeyStr image:(UIImage *)localPhotoImageTemp
{
    if (self = [super init])
    {
        self.photoUrl = photoUrlStr;
        self.photoKey = photoKeyStr;
        self.localPhotoImage = localPhotoImageTemp;
    }
    return self;
}
@end
