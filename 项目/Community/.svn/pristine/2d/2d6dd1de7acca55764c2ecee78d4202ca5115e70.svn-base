//
//  HWAssetsView.h
//  camera
//
//  Created by caijingpeng.haowu on 14-9-1.
//  Copyright (c) 2014年 caijingpeng.haowu. All rights reserved.
//
//  相册网格 item 类

#import <UIKit/UIKit.h>
#import <AssetsLibrary/AssetsLibrary.h>

@class HWAssetsView;

@protocol HWAssetsViewDelegate <NSObject>

- (void)didSelectedAssetsView:(HWAssetsView *)aView;

@end

@interface HWAssetsView : UIView
{
    UIImageView *thumbnailImgV;
}

@property (nonatomic, strong)ALAsset *asset;
@property (nonatomic, assign)id<HWAssetsViewDelegate> delegate;
@property (nonatomic, assign)int index;

- (void)setDeSelected;
- (void)setSelected;

@end
