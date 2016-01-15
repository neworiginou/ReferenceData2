//
//  GKImagePickerController.m
//  Camera
//
//  Created by caijingpeng on 13-12-11.
//  Copyright (c) 2013年 caijingpeng. All rights reserved.
//

#import "GKImagePickerController.h"
//#import "HWCropImgeViewController.h"
//#import "HWAlbumViewController.h"

#define CENTERLAYOUT (self.view.frame.size.height - 60 - 90) / 2.0f + 40



@interface GKImagePickerController ()

@end

@implementation GKImagePickerController
@synthesize groups;
@synthesize myStillImage;
@synthesize delegate;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
        
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(enterBackground:) name:UIApplicationDidEnterBackgroundNotification object:nil];
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(becomeActive:) name:UIApplicationDidBecomeActiveNotification object:nil];
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(sessionDidStartRunning:) name:AVCaptureSessionDidStartRunningNotification object:nil];
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(sessionDidStopRunning:) name:AVCaptureSessionDidStopRunningNotification object:nil];
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(sessionErrorKey:) name:AVCaptureSessionErrorKey object:nil];
        
    }
    return self;
}


- (void)enterBackground:(NSNotification *)notification
{
    // 关闭相机
    _upOverlay.frame = CGRectMake(_upOverlay.frame.origin.x,
                                  CENTERLAYOUT - _upOverlay.frame.size.height + 40,
                                  _upOverlay.frame.size.width,
                                  _upOverlay.frame.size.height);
    _downOverlay.frame = CGRectMake(_downOverlay.frame.origin.x,
                                    CENTERLAYOUT,
                                    _downOverlay.frame.size.width,
                                    _downOverlay.frame.size.height);
}

- (void)becomeActive:(NSNotification *)notification
{
    [self performSelector:@selector(openCameraAnimate) withObject:nil afterDelay:1.0f];
//    [camManager performSelectorInBackground:@selector(startRuning) withObject:nil];
}

- (BOOL)prefersStatusBarHidden
{
    return YES;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.navigationController.navigationBarHidden = YES;
//    [[UIApplication sharedApplication] setStatusBarHidden:YES];
    self.view.backgroundColor = [UIColor blackColor];
    
	// Do any additional setup after loading the view.
    if (IOS7)
    {
        [self setNeedsStatusBarAppearanceUpdate];
    }
    
// *******  初始化 相册类   *******
    _assetLibrary = [[ALAssetsLibrary alloc] init];
    _assetsFilter = [ALAssetsFilter allAssets];
    
// *******  相机管理类   ********
    camManager = [GKCameraManager manager];
    camManager.delegate = self;
    [camManager setup];
    
// ********     初始化 view     *******
    int bottomHeight = IPHONE5 ? 125 : 100;
    
    _cameraPreview = [[UIView alloc] initWithFrame:CGRectMake(0, 40, self.view.frame.size.width, self.view.frame.size.height - bottomHeight - 45)];
    _cameraPreview.backgroundColor = [UIColor blackColor];
    [camManager embedPreviewInView:_cameraPreview];
    [self.view addSubview:_cameraPreview];
    
    UITapGestureRecognizer *focusTap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(focusPoint:)];
    [_cameraPreview addGestureRecognizer:focusTap];
    
    _upOverlay = [[UIImageView alloc] initWithFrame:CGRectMake(0, CENTERLAYOUT - 280 + 40, self.view.frame.size.width, 280)];
    _upOverlay.backgroundColor = [UIColor blackColor];
    [self.view addSubview:_upOverlay];

    _downOverlay = [[UIImageView alloc] initWithFrame:CGRectMake(0, CENTERLAYOUT, self.view.frame.size.width, 250)];
    _downOverlay.backgroundColor = [UIColor blackColor];
    [self.view addSubview:_downOverlay];
    
    
    // ----------- 顶部导航条 ----------------
    _topToolsbar = [[UIView alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width * 2, 45)];
    _topToolsbar.backgroundColor = [UIColor blackColor];
    [self.view addSubview:_topToolsbar];
    
    
    UIButton *backBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [backBtn setImage:[[UIImage imageNamed:@"camera_back_defult"] stretchableImageWithLeftCapWidth:13 topCapHeight:0] forState:UIControlStateNormal];
    [backBtn setImage:[[UIImage imageNamed:@"camera_back_highlight"] stretchableImageWithLeftCapWidth:13 topCapHeight:0] forState:UIControlStateHighlighted];
    [backBtn setFrame:CGRectMake(0, 0, 24, 24)];
    [backBtn setCenter:CGPointMake(40, _topToolsbar.frame.size.height/2.0f)];
    [backBtn addTarget:self action:@selector(doBack:) forControlEvents:UIControlEventTouchUpInside];
    [_topToolsbar addSubview:backBtn];
    
    //  预览照片页面 返回按钮
    UIButton *backToCameraBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [backToCameraBtn setImage:[[UIImage imageNamed:@"album_back_default"] stretchableImageWithLeftCapWidth:13 topCapHeight:0] forState:UIControlStateNormal];
    [backToCameraBtn setImage:[[UIImage imageNamed:@"album_back_highlight"] stretchableImageWithLeftCapWidth:13 topCapHeight:0] forState:UIControlStateHighlighted];
    [backToCameraBtn setFrame:CGRectMake(0, 0, 24, 24)];
    [backToCameraBtn setCenter:CGPointMake(40 + self.view.frame.size.width, _topToolsbar.frame.size.height/2.0f)];
    [backToCameraBtn addTarget:self action:@selector(backToCamera:) forControlEvents:UIControlEventTouchUpInside];
    [_topToolsbar addSubview:backToCameraBtn];
    
    UILabel *titleLab = [[UILabel alloc] initWithFrame:CGRectMake(self.view.frame.size.width + (self.view.frame.size.width - 100)/2.0f, 7.5f, 100, 30)];
    titleLab.textAlignment = NSTextAlignmentCenter;
    titleLab.textColor = [UIColor whiteColor];
    titleLab.backgroundColor = [UIColor clearColor];
    titleLab.text = @"选择";
    [_topToolsbar addSubview:titleLab];
    
    UIButton *doneBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    doneBtn.backgroundColor = [UIColor clearColor];
    [doneBtn setTitle:@"发布" forState:UIControlStateNormal];
    doneBtn.titleLabel.font = [UIFont systemFontOfSize:16.0f];
    [doneBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    doneBtn.frame = CGRectMake(self.view.frame.size.width * 2 - 60 - 10, 7.5f, 60, 30);
    [doneBtn addTarget:self action:@selector(doDone:) forControlEvents:UIControlEventTouchUpInside];
    [_topToolsbar addSubview:doneBtn];
    
    float maskHeight = (self.view.frame.size.height - CGRectGetHeight(_topToolsbar.frame) - CROP_HEIGHT - bottomHeight) / 2.0f;
    _toolsBar = [[UIView alloc] initWithFrame:CGRectMake(0, CGRectGetMaxY(_topToolsbar.frame), self.view.frame.size.width, maskHeight)];
    _toolsBar.backgroundColor = [UIColor colorWithWhite:0 alpha:0.6f];
    [self.view addSubview:_toolsBar];
    
    for (int i = 0; i < 3; i++)
    {
        UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
        [button setFrame:CGRectMake(0, 0, 24, 24)];
        if (i == 1)
        {
            _positionBtn = button;
            [button setImage:[UIImage imageNamed:@"camera_toggle_default"] forState:UIControlStateNormal];
            [button setImage:[UIImage imageNamed:@"camera_toggle_highlight"] forState:UIControlStateHighlighted];
            button.showsTouchWhenHighlighted = YES;
            button.center = CGPointMake(self.view.frame.size.width / 2.0f, _toolsBar.frame.size.height/2.0f);
            [button addTarget:self action:@selector(toggleCamera:) forControlEvents:UIControlEventTouchUpInside];
        }
        else if (i == 2)
        {
            _flashBtn = button;
            switch ([camManager getFlashMode])
            {
                case AVCaptureFlashModeOff:
                {
                    [button setImage:[UIImage imageNamed:@"camera_flashClose_default"] forState:UIControlStateNormal];
                    break;
                }
                case AVCaptureFlashModeAuto:
                {
                    [button setImage:[UIImage imageNamed:@"camera_flashAuto_highlight"] forState:UIControlStateNormal];
                    break;
                }
                case AVCaptureFlashModeOn:
                {
                    [button setImage:[UIImage imageNamed:@"camera_flashOpen_highlight"] forState:UIControlStateNormal];
                    break;
                }
                default:
                    break;
            }
            button.showsTouchWhenHighlighted = YES;
            button.center = CGPointMake(self.view.frame.size.width / 4.0f * 3, _toolsBar.frame.size.height / 2.0f);
            [button addTarget:self action:@selector(toggleFlashMode:) forControlEvents:UIControlEventTouchUpInside];
        }
        else if (i == 0)
        {
            _gridBtn = button;
            [button setImage:[UIImage imageNamed:@"camera_grid_default"] forState:UIControlStateNormal];
            button.showsTouchWhenHighlighted = YES;
            button.center = CGPointMake(self.view.frame.size.width / 4.0f , _toolsBar.frame.size.height / 2.0f);
            [button addTarget:self action:@selector(toggleGrid:) forControlEvents:UIControlEventTouchUpInside];
        }
        
        [_toolsBar addSubview:button];
    }
    
    
    // ---------------- 底部工具条 -------------------
    bottomView = [[UIView alloc] initWithFrame:CGRectMake(0, self.view.frame.size.height - bottomHeight, self.view.frame.size.width, bottomHeight)];
    bottomView.backgroundColor = [UIColor blackColor];
    [self.view addSubview:bottomView];
    
    
    _bottomMaskView = [[UIView alloc] initWithFrame:CGRectMake(0, CGRectGetMinY(bottomView.frame) - maskHeight, self.view.frame.size.width, maskHeight)];
    _bottomMaskView.backgroundColor = [UIColor colorWithWhite:0 alpha:0.6];
    [self.view addSubview:_bottomMaskView];
    /*
    albumBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    albumBtn.layer.cornerRadius = 5.0f;
    albumBtn.layer.masksToBounds = YES;
    [albumBtn setFrame:CGRectMake((self.view.frame.size.width)/4.0f - 30, (bottomHeight - 35)/2.0f, 35, 35)];
    [albumBtn setImage:[UIImage imageNamed:@"albumButton"] forState:UIControlStateNormal];
    albumBtn.showsTouchWhenHighlighted = YES;
    [albumBtn addTarget:self action:@selector(chooseAlbum:) forControlEvents:UIControlEventTouchUpInside];
    [bottomView addSubview:albumBtn];
    */
    
    photoBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [photoBtn setFrame:CGRectMake((self.view.frame.size.width - 60)/2.0f, (bottomHeight - 60)/2.0f, 60, 60)];
    [photoBtn setImage:[UIImage imageNamed:@"takeCamera_default"] forState:UIControlStateNormal];
    [photoBtn setImage:[UIImage imageNamed:@"takeCamera_highlight"] forState:UIControlStateHighlighted];
    [photoBtn addTarget:self action:@selector(takePhoto:) forControlEvents:UIControlEventTouchUpInside];
    [bottomView addSubview:photoBtn];
    
    // orientation
    
//    motionManager = [[CMMotionManager alloc] init];
    
    
    // setup
    
    [self disableButton];
    
    [camManager stopRuning];
    
    dispatch_async(dispatch_queue_create("running.camera", DISPATCH_QUEUE_SERIAL), ^{
        [camManager startRuning];
    });
//    [camManager performSelectorInBackground:@selector(startRuning) withObject:nil];
    self.groups = [NSMutableArray array];
//    [self loadAlum];
    
    // 标识关闭相机页面
    toDismiss = NO;
    
    
}

- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary *)change context:(void *)context
{
    if([keyPath isEqualToString:@"adjustingFocus"])
    {
        if (_focusLayer != nil)
        {
            [_focusLayer startAnimate];
        }
        
    }
}

-(void)loadAlum
{
    // 加载相册
    [_assetLibrary enumerateGroupsWithTypes:ALAssetsGroupAll usingBlock:^(ALAssetsGroup *group, BOOL *stop) {
        
        if (group)
        {
            [group setAssetsFilter:_assetsFilter];
            if (group.numberOfAssets > 0)
                [self.groups addObject:group];
        }
        else
        {
            if (self.groups.count > 0) {
                
                // 倒序
                [Utility reverseArray:self.groups];
                
                ALAssetsGroup *assetsGroup = [self.groups objectAtIndex:0];
                CGImageRef posterImage = assetsGroup.posterImage;
                size_t height = CGImageGetHeight(posterImage);
                float scale = height / albumBtn.frame.size.height;
                UIImage *image = [UIImage imageWithCGImage:posterImage scale:scale orientation:UIImageOrientationUp];
                [albumBtn setImage:image forState:UIControlStateNormal];
            }
            
        }
        
    } failureBlock:^(NSError *error) {
        
        NSLog(@"------%@",error.description);
        NSLog(@"%d",(int)error.code);
        
        if(error.code == -3311)
        {
            //                UIAlertView *alert=[[UIAlertView alloc]initWithTitle:NSLocalizedString(@"alert", @"") message:NSLocalizedString(@"privacyPhoto", @"") delegate:nil cancelButtonTitle:NSLocalizedString(@"OK", @"") otherButtonTitles:nil, nil];
            //                [alert show];
        }
        
    }];
}

- (void)sessionDidStartRunning:(NSNotification *)notify
{
    dispatch_async(dispatch_get_main_queue(), ^{
//        if ([camManager isRunning])
//        {
//            AVCaptureDevice *videoDevice = [camManager currentVideoDevice];
//            [videoDevice addObserver:self forKeyPath:@"adjustingFocus" options:NSKeyValueObservingOptionNew context:nil];
//        }
        if (camManager._videoDeviceInput != nil)
        {
            [self enableButton];
            [self openCameraAnimate];
        }
        
    });
}

- (void)sessionErrorKey:(NSNotification *)notify
{
    NSLog(@"%@",notify);
}

- (void)sessionDidStopRunning:(NSNotification *)notify
{
    // 切换 navigation  展示照片、
    
//    AVCaptureDevice *videoDevice = [camManager currentVideoDevice];
//    [videoDevice removeObserver:self forKeyPath:@"adjustingFocus" context:nil];
    
    [self disableButton];
    
    if (toDismiss)
    {
        [self.navigationController dismissViewControllerAnimated:YES completion:nil];
    }
    
    if (_stillPhotoPreview == nil && self.myStillImage != nil)
    {
        _stillPhotoPreview = [[UIImageView alloc] initWithFrame:CGRectMake(0, CGRectGetMaxY(_toolsBar.frame), self.view.frame.size.width, CROP_HEIGHT)];
        _stillPhotoPreview.backgroundColor = [UIColor blackColor];
        _stillPhotoPreview.image = self.myStillImage;
        [self.view insertSubview:_stillPhotoPreview aboveSubview:_cameraPreview];
        
        [self openCameraAnimate];
    }
}

- (void)viewWillAppear:(BOOL)animated
{
//    [motionManager startAccelerometerUpdatesToQueue:[NSOperationQueue currentQueue] withHandler:^(CMAccelerometerData *accelerometerData, NSError *error) {
//        
//        double ax = accelerometerData.acceleration.x;
//        AVCaptureVideoOrientation orientation;
//        
//        if (ax < -0.7)
//        {
//            orientation = AVCaptureVideoOrientationLandscapeRight;
////            NSLog(@"right");
//            
//            if (!CGAffineTransformEqualToTransform(photoBtn.transform, CGAffineTransformMakeRotation(M_PI_2))) {
//                
//                [UIView animateWithDuration:0.2f animations:^{
//                    photoBtn.transform = CGAffineTransformMakeRotation(M_PI_2);
//                    _flashBtn.transform = CGAffineTransformMakeRotation(M_PI_2);
//                    _gridBtn.transform = CGAffineTransformMakeRotation(M_PI_2);
//                    _positionBtn.transform = CGAffineTransformMakeRotation(M_PI_2);
//                }];
//            }
//            
//        }
//        else if (ax > 0.7)
//        {
////            NSLog(@"left");
//            orientation = AVCaptureVideoOrientationLandscapeLeft;
//            if (!CGAffineTransformEqualToTransform(photoBtn.transform, CGAffineTransformMakeRotation(-M_PI_2))) {
//                [UIView animateWithDuration:0.2f animations:^{
//                    photoBtn.transform = CGAffineTransformMakeRotation(-M_PI_2);
//                    _flashBtn.transform = CGAffineTransformMakeRotation(-M_PI_2);
//                    _gridBtn.transform = CGAffineTransformMakeRotation(-M_PI_2);
//                    _positionBtn.transform = CGAffineTransformMakeRotation(-M_PI_2);
//                }];
//            }
//        }
//        else
//        {
//            
//            orientation = AVCaptureVideoOrientationPortrait;
//            if (!CGAffineTransformEqualToTransform(photoBtn.transform, CGAffineTransformIdentity)) {
//                [UIView animateWithDuration:0.2f animations:^{
//                    photoBtn.transform = CGAffineTransformIdentity;
//                    _flashBtn.transform = CGAffineTransformIdentity;
//                    _gridBtn.transform = CGAffineTransformIdentity;
//                    _positionBtn.transform = CGAffineTransformIdentity;
//                }];
//            }
//        }
//        
//        [camManager setCameraOrientation:orientation];
//        
//    }];
    
    [camManager setCameraOrientation:AVCaptureVideoOrientationPortrait];
}

- (void)doBack:(id)sender
{
//    [[UIApplication sharedApplication] setStatusBarHidden:NO];
    
    
    if (camManager.isRunning)
    {
        [self closeCameraAnimateCompletion:^{
            [camManager stopRuning];
        }];
        toDismiss = YES;
    }
    else
    {
        [self.navigationController dismissViewControllerAnimated:YES completion:nil];
    }
    
    
    
}
- (void)backToCamera:(id)sender
{
    [self closeCameraAnimateCompletion:^{
        if (_stillPhotoPreview)
        {
            [_stillPhotoPreview removeFromSuperview];
            _stillPhotoPreview = nil;
        }
    }];
    [self popPreview];
    
    
    [camManager performSelectorInBackground:@selector(startRuning) withObject:nil];
}

- (void)doDone:(id)sender
{
//    self.myStillImage
    if (delegate && [delegate respondsToSelector:@selector(didFinishedSelectImage:)])
    {
        [delegate didFinishedSelectImage:self.myStillImage];
    }
    [self.navigationController dismissViewControllerAnimated:YES completion:nil];
}

- (void)viewWillDisappear:(BOOL)animated
{
//    [motionManager stopAccelerometerUpdates];
//    [self closeCameraAnimateCompletion:YES];
}

#pragma mark UI

- (void)openCameraAnimate
{
    [UIView animateWithDuration:0.3f animations:^{
        _upOverlay.frame = CGRectMake(_upOverlay.frame.origin.x,
                                     CENTERLAYOUT - 2*_upOverlay.frame.size.height,
                                     _upOverlay.frame.size.width,
                                     _upOverlay.frame.size.height);
        _downOverlay.frame = CGRectMake(_downOverlay.frame.origin.x,
                                       CENTERLAYOUT + _downOverlay.frame.size.height,
                                       _downOverlay.frame.size.width,
                                       _downOverlay.frame.size.height);
    }completion:^(BOOL finished) {
        
    }];
}

- (void)closeCameraAnimateCompletion:(CloseCompletedBlock)stopSession
{
    
    [UIView animateWithDuration:0.3f animations:^{
        _upOverlay.frame = CGRectMake(_upOverlay.frame.origin.x,
                                     CENTERLAYOUT - _upOverlay.frame.size.height + 40,
                                     _upOverlay.frame.size.width,
                                     _upOverlay.frame.size.height);
        _downOverlay.frame = CGRectMake(_downOverlay.frame.origin.x,
                                       CENTERLAYOUT,
                                       _downOverlay.frame.size.width,
                                       _downOverlay.frame.size.height);
    }completion:^(BOOL finished) {
        stopSession();
    }];
}

- (void)toggleGrid:(UIButton *)sender
{
    if (_gridView == nil)
    {
        _gridView = [HWGridView layer];
        _gridView.frame = CGRectMake(0, CGRectGetMaxY(_toolsBar.frame), self.view.frame.size.width, CROP_HEIGHT);
//        _gridView.alpha = 0.0f;
        _gridView.hidden = YES;
        [self.view.layer addSublayer:_gridView];
    }
    
    [UIView animateWithDuration:0.3f animations:^{
        
        _gridView.hidden = !_gridView.hidden;
        if (_gridView.hidden)
        {
            [sender setImage:[UIImage imageNamed:@"camera_grid_default"] forState:UIControlStateNormal];
        }
        else
        {
            [sender setImage:[UIImage imageNamed:@"camera_grid_highlight"] forState:UIControlStateNormal];
        }
        
    }];
    
    
}

- (void)hideGrid
{
    if (_gridView != nil)
    {
        [_gridBtn setImage:[UIImage imageNamed:@"camera_grid_default"] forState:UIControlStateNormal];
        [UIView animateWithDuration:0.3f animations:^{
//            _gridView.alpha = 0.0f;
            _gridView.hidden = YES;
        }];
    }
}

- (void)disableButton
{
    photoBtn.userInteractionEnabled = NO;
    _flashBtn.userInteractionEnabled = NO;
    albumBtn.userInteractionEnabled = NO;
    _positionBtn.userInteractionEnabled = NO;
    _gridBtn.userInteractionEnabled = NO;

    photoBtn.alpha = 0.5f;
    _flashBtn.alpha = 0.5f;
    albumBtn.alpha = 0.5f;
    _positionBtn.alpha = 0.5f;
    _gridBtn.alpha = 0.5f;
    
    _bottomMaskView.backgroundColor = [UIColor blackColor];
    _toolsBar.backgroundColor = [UIColor blackColor];
}

- (void)enableButton
{
    photoBtn.userInteractionEnabled = YES;
    _flashBtn.userInteractionEnabled = YES;
    albumBtn.userInteractionEnabled = YES;
    _positionBtn.userInteractionEnabled = YES;
    _gridBtn.userInteractionEnabled = YES;
    
    photoBtn.alpha = 1.0f;
    _flashBtn.alpha = 1.0f;
    albumBtn.alpha = 1.0f;
    _positionBtn.alpha = 1.0f;
    _gridBtn.alpha = 1.0f;
    
    _bottomMaskView.backgroundColor = [UIColor colorWithWhite:0 alpha:0.6];
    _toolsBar.backgroundColor = [UIColor colorWithWhite:0 alpha:0.6];
}


- (void)toggleCamera:(id)sender
{
    [camManager changeCamera];
    
    if ([camManager currentVideoPosition] == AVCaptureDevicePositionFront)
    {
        _flashBtn.userInteractionEnabled = NO;
        _flashBtn.alpha = 0.5f;
    }
    else
    {
        _flashBtn.userInteractionEnabled = YES;
        _flashBtn.alpha = 1.0f;
    }
    
    NSLog(@"change camera device position");
}
- (void)toggleFlashMode:(id)sender
{
    switch ([camManager getFlashMode]) {
        case AVCaptureFlashModeOn:
        {
            [camManager setFlashMode:AVCaptureFlashModeAuto];
            [_flashBtn setImage:[UIImage imageNamed:@"camera_flashAuto_highlight"] forState:UIControlStateNormal];
            break;
        }
        case AVCaptureFlashModeAuto:
        {
            [camManager setFlashMode:AVCaptureFlashModeOff];
            [_flashBtn setImage:[UIImage imageNamed:@"camera_flashClose_default"] forState:UIControlStateNormal];
            break;
        }
        case AVCaptureFlashModeOff:
        {
            [camManager setFlashMode:AVCaptureFlashModeOn];
            [_flashBtn setImage:[UIImage imageNamed:@"camera_flashOpen_highlight"] forState:UIControlStateNormal];
            break;
        }
            
        default:
            break;
    }
    NSLog(@"change camera flash mode");
}
- (void)takePhoto:(id)sender
{
    NSLog(@"take photo");
    [self hideGrid];
    [self disableButton];
    [self closeCameraAnimateCompletion:^{
    }];
    
    [camManager snapStillImage:^(UIImage *stillImage, NSError *error) {
        UIImageWriteToSavedPhotosAlbum(stillImage, nil, NULL, nil);
        [self push:stillImage];
        [camManager stopRuning];
    }];

}

- (void)push:(UIImage *)stillImage
{
//    [[UIApplication sharedApplication] setStatusBarHidden:NO];
    
    self.myStillImage = stillImage;

    // 切换 navigation disable 按钮
    [self disableButton];
    [self pushPreview];
}

- (void)pushPreview
{
    [UIView animateWithDuration:0.3f animations:^{
        CGRect frame = _topToolsbar.frame;
        frame.origin.x = -self.view.frame.size.width;
        _topToolsbar.frame = frame;
    }];
}
- (void)popPreview
{
    self.myStillImage = nil;
    [UIView animateWithDuration:0.3f animations:^{
        CGRect frame = _topToolsbar.frame;
        frame.origin.x = 0;
        _topToolsbar.frame = frame;
    }];
}

- (void)focusPoint:(UITapGestureRecognizer *)sender
{
    CGPoint touchPos = [sender locationInView:sender.view];
    _focusLayer = [HWFocusLayer layer];
    [_focusLayer setFrame:CGRectMake(touchPos.x - 60/2.0f, touchPos.y - 60/2.0f, 60, 60)];
    [sender.view.layer addSublayer:_focusLayer];
    // ** 暂未解决kvo问题
    [_focusLayer startAnimate];
    [camManager setCameraFoucusWithPoint:touchPos];
}
/*
- (void)chooseAlbum:(id)sender
{
    HWAlbumViewController *albumVC = [[HWAlbumViewController alloc] init];
    if (self.groups.count > 0)
    {
        albumVC.groups = self.groups;
    }
    
    albumVC.navigationController.navigationBarHidden = YES;
    [self.navigationController pushViewController:albumVC animated:YES];
}
*/
- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)dealloc
{
    [[NSNotificationCenter defaultCenter] removeObserver:self name:UIApplicationDidEnterBackgroundNotification object:nil];
    [[NSNotificationCenter defaultCenter] removeObserver:self name:UIApplicationDidBecomeActiveNotification object:nil];
    [[NSNotificationCenter defaultCenter] removeObserver:self name:AVCaptureSessionDidStartRunningNotification object:nil];
    [[NSNotificationCenter defaultCenter] removeObserver:self name:AVCaptureSessionDidStopRunningNotification object:nil];
}


- (BOOL)shouldAutorotate
{
    return NO;
}
- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)toInterfaceOrientation
{
    return NO;
}

@end
