//
//  GKImagePickerController.h
//  Camera
//
//  Created by caijingpeng on 13-12-11.
//  Copyright (c) 2013年 caijingpeng. All rights reserved.
//
//  相机页面

#import <UIKit/UIKit.h>
#import "GKCameraManager.h"
#import <CoreMotion/CoreMotion.h>
#import <AssetsLibrary/AssetsLibrary.h>
#import "HWFocusLayer.h"
#import "HWGridView.h"

typedef void(^CloseCompletedBlock)();

@protocol GKImagePickerControllerDelegate <NSObject>

- (void)didFinishedSelectImage:(UIImage *)image;

@end

@interface GKImagePickerController : UIViewController<UIImagePickerControllerDelegate,UINavigationControllerDelegate,GKCameraManagerDelegate>
{
    GKCameraManager *camManager;
    UIView *bottomView;
    UIView *_topToolsbar;               // 顶部navigation
    UIView *_toolsBar;                  // 黑色半透明view（上）工具条
    
    UIButton *albumBtn;                 // 相册按钮
    UIButton *photoBtn;                 // 拍照按钮
//    UIButton *recordBtn;
    UIButton *_positionBtn;
    UIButton *_gridBtn;
    UIButton *_flashBtn;
    UIView *_bottomMaskView;            // 黑色半透明view（下）
    
    CMMotionManager *motionManager;
    
    UIImageView *_upOverlay;            // 相机开关 上半部
    UIImageView *_downOverlay;          // 相机开关 下半部
    
    HWGridView *_gridView;              // 网格
    ALAssetsLibrary *_assetLibrary;
    ALAssetsFilter *_assetsFilter;
    UIImageView *_stillPhotoPreview;    // 照片预览
    UIView *_cameraPreview;             // 摄像头加载view
    HWFocusLayer *_focusLayer;          // 焦点
    
    BOOL toDismiss;
}


@property (nonatomic ,strong) NSMutableArray *groups;    // 相册group
@property (nonatomic, strong) UIImage *myStillImage;     // 拍照生成图片
@property (nonatomic, assign) id<GKImagePickerControllerDelegate> delegate;


@end
