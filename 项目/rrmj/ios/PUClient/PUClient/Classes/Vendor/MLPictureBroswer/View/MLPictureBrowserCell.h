//
//  MLPictureBrowserCell.h
//  InventoryTool
//
//  Created by molon on 14-2-19.
//  Copyright (c) 2014年 Molon. All rights reserved.
//

#import "MLBroadcastViewCell.h"

@class MLPicture;

@class MLPictureBrowserCell;
@protocol MLPictureBrowserCellDelegate <NSObject>

//点击了某个页面
- (void)didTapForMLPictureCell:(MLPictureBrowserCell*)pictureCell ofIndex:(NSUInteger)index;

@optional
//自定义覆盖View
- (UIView*)customOverlayViewOfMLPictureCell:(MLPictureBrowserCell*)pictureCell ofIndex:(NSUInteger)index;
//自定义覆盖View的frame
- (CGRect)customOverlayViewFrameOfMLPictureCell:(MLPictureBrowserCell*)pictureCell ofIndex:(NSUInteger)index;

-(void)PictureBrowserCellCommentButtonClick:(UIButton *)button;
@end

@interface MLPictureBrowserCell : MLBroadcastViewCell

@property(nonatomic,strong) MLPicture *picture;
@property(nonatomic,weak) id<MLPictureBrowserCellDelegate> delegate;

@end
