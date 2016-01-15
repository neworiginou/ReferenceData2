//
//  GKCameraManager.h
//  Camera
//
//  Created by caijingpeng on 13-12-11.
//  Copyright (c) 2013年 caijingpeng. All rights reserved.
//
//  相机管理类

#import <Foundation/Foundation.h>
#import <AVFoundation/AVFoundation.h>
#import <MediaPlayer/MediaPlayer.h>
#import <MediaPlayer/MPMediaPlayback.h>
#import "GKRecordProgressView.h"

@protocol GKCameraManagerDelegate <NSObject>

@optional

- (void)didFinishedRecord:(NSString *)path;

@end

@interface GKCameraManager : NSObject
{
    NSString* capfilename;
    float time;
    float lastTime;
}

@property (atomic, readwrite) BOOL isCapturing;
@property (nonatomic, retain) NSTimer *progressTimer;
@property (atomic, readwrite) BOOL isPaused;
@property (nonatomic,assign) id<GKCameraManagerDelegate> delegate;
@property (nonatomic, retain) AVCaptureDeviceInput *_videoDeviceInput;

+ (id)manager;

- (void)setup;
//- (void)setupRecord;

// 获取当前设备
- (AVCaptureDevice *)currentVideoDevice;

//设置显示 预览.
- (void)embedPreviewInView:(UIView *)aView;

//改变摄像头.
- (void)changeCamera;

// 拍照.
- (void)snapStillImage:(void (^)(UIImage *stillImage, NSError *error))mBlock;

// 设置焦点
- (void)setCameraFoucusWithPoint:(CGPoint)point;

// 设置闪光灯
- (void)setFlashMode:(AVCaptureFlashMode)flashMode;

// 开启相机
- (void)startRuning;

// 关闭相机
- (void)stopRuning;

// 录像.

- (void)setProgressBar:(GKRecordProgressView *)progress;
- (void) startRecord;
- (void) stopCapture;
- (void) pauseCapture;
- (void) resumeCapture;

// 设置方向
- (void)setCameraOrientation:(AVCaptureVideoOrientation)toInterfaceOrientation;
- (void)clearMovieCache;

// 获取摄像头位置 （前、后）
- (AVCaptureDevicePosition)currentVideoPosition;

// 获取闪光灯开启状态
- (AVCaptureFlashMode)getFlashMode;

// 相机是否正在启动
- (BOOL)isRunning;


@end
