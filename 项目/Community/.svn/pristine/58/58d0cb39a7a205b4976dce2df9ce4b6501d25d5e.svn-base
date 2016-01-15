//
//  GKImagePickerController.h
//  Camera
//
//  Created by caijingpeng on 13-12-11.
//  Copyright (c) 2013年 caijingpeng. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "GKCameraManager.h"
#import <CoreMotion/CoreMotion.h>


typedef enum
{
    photoModel = 0,
    recordModel
} CameraModel;



@interface HWGKImagePickerController : UIViewController<UIImagePickerControllerDelegate,UINavigationControllerDelegate,GKCameraManagerDelegate>
{
    GKCameraManager *camManager;
    UIView *bottomView;
    UIView *topToolsbar;
    
    CameraModel currentModel;
    
    BOOL isStartRecording;
    
    
    UIButton *albumBtn;
    UIButton *photoBtn;
    UIButton *positionBtn;
    UIButton *nextBtn;
    UIButton *flashBtn;
    
    CMMotionManager *motionManager;
    
    UIImageView *upOverlay;
    UIImageView *downOverlay;
    
}

@end
