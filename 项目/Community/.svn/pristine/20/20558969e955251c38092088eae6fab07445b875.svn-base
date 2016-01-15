//
//  HWPublishAlbumCell.h
//  Community
//
//  Created by caijingpeng.haowu on 14-9-12.
//  Copyright (c) 2014年 caijingpeng. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "HWAssetsView.h"

@protocol HWPublishAlbumCellDelegate <NSObject>

- (void)didSelectTakePhoto;
- (void)didSelectAlbumPicture:(UIImage *)image;

@end

@interface HWPublishAlbumCell : UITableViewCell<HWAssetsViewDelegate>

@property (nonatomic, strong) HWAssetsView *imgBtnOne;
@property (nonatomic, strong) HWAssetsView *imgBtnTwo;
@property (nonatomic, strong) HWAssetsView *imgBtnThree;
@property (nonatomic, strong) HWAssetsView *imgBtnFour;

@property (nonatomic, strong) UIButton *cameraBtn;
@property (nonatomic, strong) id<HWPublishAlbumCellDelegate> delegate;

- (void)setImage:(NSMutableArray *)assets withIndex:(long)index;

@end
