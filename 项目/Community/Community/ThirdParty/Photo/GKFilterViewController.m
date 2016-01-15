//
//  GKFilterViewController.m
//  Camera
//
//  Created by CaiJingPeng on 13-12-16.
//  Copyright (c) 2013年 caijingpeng. All rights reserved.
//

#import "GKFilterViewController.h"
//#import "GKSendMediaViewController.h"

//#import "GKUserLogin.h"
//#import "DBManager.h"
//#import "GKAppDelegate.h"
//#import "MovieDraft.h"

#define FILTER_BUTTON_TAG 999
#define SELECT_OVERLAY_TAG 888

@interface GKFilterViewController ()

@end

@implementation GKFilterViewController
@synthesize isEnableFilter,sourceImage,moviePath;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
//        self.isEnableFilter = NO;
        self.isPreview = YES;
    }
    return self;
}

- (void)viewWillDisappear:(BOOL)animated
{
    if (player != nil) {
        if (player.playbackState == MPMoviePlaybackStatePlaying) {
            [player stop];
        }
        
    }
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.
    self.view.backgroundColor = [UIColor blackColor];
    
    if(!IOS7)
    [[UIApplication sharedApplication] setStatusBarHidden:YES];
    
//    primaryView = [[GPUImageView alloc] initWithFrame:CGRectMake(0, 100, 320, 320)];
//    [self.view addSubview:primaryView];
    
     //------- image --------
     
     //    UIImage *inputImage = [UIImage imageNamed:@"WID-small.jpg"]; // The WID.jpg example is greater than 2048 pixels tall, so it fails on older devices
    if (self.sourceImage != nil) // 图片
    {
        /*
        sourcePicture = [[GPUImagePicture alloc] initWithImage:self.sourceImage smoothlyScaleOutput:YES];
        filter = [[GPUImageFilter alloc] init];
//        [(GPUImageSepiaFilter *)filter setIntensity:0.5f];
        
        
        [filter forceProcessingAtSizeRespectingAspectRatio:primaryView.sizeInPixels]; // This is now needed to make the filter run at the smaller output size
        [filter addTarget:primaryView];
        [sourcePicture addTarget:filter];
        [sourcePicture processImage];
         */
        
        primaryView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 100, 320, 320)];
        primaryView.image = self.sourceImage;
        [self.view addSubview:primaryView];
        
        
        
    }
    else    //视频
    {
        NSURL *sampleURL = [NSURL fileURLWithPath:self.moviePath];
////        NSURL *sampleURL = [[NSBundle mainBundle] URLForResource:@"sample_iPod" withExtension:@"m4v"];
//        movieFile = [[GPUImageMovie alloc] initWithURL:sampleURL];
//        movieFile.runBenchmark = YES;
//        movieFile.playAtActualSpeed = NO;
        
        player = [[MPMoviePlayerController alloc] initWithContentURL:sampleURL];
        player.controlStyle = MPMovieControlStyleNone;
        player.movieSourceType = MPMovieSourceTypeFile;
//        [player prepareToPlay];
        
        [player.view setFrame:CGRectMake(0, 100, 320, 320)];
        [player requestThumbnailImagesAtTimes:[NSArray arrayWithObject:[NSNumber numberWithDouble:1.0]] timeOption:MPMovieTimeOptionExact];
        [self.view addSubview:player.view];
        
//        [player play];
        
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(doTap:)];
        
        
        
        [[NSNotificationCenter defaultCenter] addObserver:self
                                                 selector:@selector(myMovieViewFinishedCallback:)
                                                     name:MPMoviePlayerPlaybackDidFinishNotification
                                                   object:player];
        
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(requestFinishedThumbnailImage:) name:MPMoviePlayerThumbnailImageRequestDidFinishNotification object:nil];
        
        
        
        controlImgV = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 300, 300)];
        controlImgV.image = [UIImage imageNamed:@"movieplay"];
        controlImgV.center = player.view.center;
        controlImgV.hidden = YES;
        controlImgV.userInteractionEnabled = YES;
        [controlImgV addGestureRecognizer:tap];
        [self.view addSubview:controlImgV];
        
        
    }
    
    // 预览页面
    
    UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 320, 65)];
    view.backgroundColor = [UIColor clearColor];
    [self.view addSubview:view];
    
    UIImageView *tBack = [[UIImageView alloc] initWithFrame:view.bounds];
    tBack.image = [UIImage imageNamed:@"edit-tray-background"];
    [view addSubview:tBack];
    
    
    UIButton *backBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [backBtn setTitle:NSLocalizedString(@"chongpai", @"  重拍") forState:UIControlStateNormal];
    [backBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    backBtn.titleLabel.font = [UIFont boldSystemFontOfSize:12];
    [backBtn setBackgroundImage:[[UIImage imageNamed:@"navbar-button-back-black-alt"] stretchableImageWithLeftCapWidth:13 topCapHeight:0] forState:UIControlStateNormal];
    [backBtn setBackgroundImage:[[UIImage imageNamed:@"navbar-button-back-black-alt-active"] stretchableImageWithLeftCapWidth:13 topCapHeight:0] forState:UIControlStateHighlighted];
    [backBtn setFrame:CGRectMake(0, 0, 60, 30)];
    [backBtn setCenter:CGPointMake(30, 40)];
    [backBtn addTarget:self action:@selector(doBack:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:backBtn];
    
    UIButton *nextBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [nextBtn setTitle:NSLocalizedString(@"next", @"下一步") forState:UIControlStateNormal];
    [nextBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    nextBtn.titleLabel.font = [UIFont boldSystemFontOfSize:12];
    [nextBtn setBackgroundImage:[[UIImage imageNamed:@"navbar-button-green"] stretchableImageWithLeftCapWidth:3 topCapHeight:15] forState:UIControlStateNormal];
    [nextBtn setBackgroundImage:[[UIImage imageNamed:@"navbar-button-green-active"] stretchableImageWithLeftCapWidth:3 topCapHeight:15] forState:UIControlStateHighlighted];
    [nextBtn setFrame:CGRectMake(0, 0, 60, 30)];
    [nextBtn setCenter:CGPointMake(280, 40)];
    //        [nextBtn addTarget:self action:@selector(pushNext:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:nextBtn];
    
    
    for (UIImageView *iv in self.view.subviews) {
        if ([iv isKindOfClass:[UIImageView class]]) {
            [iv removeFromSuperview];
        }
    }
    
    UIScrollView *sv = [[UIScrollView alloc]initWithFrame:CGRectMake(0, 100, 320, 120)];
    sv.delegate = self;
    sv.showsHorizontalScrollIndicator = NO;
    sv.showsVerticalScrollIndicator = NO;
    sv.clipsToBounds = NO;
    sv.maximumZoomScale = 2.0;
    
    UIScrollView *sv1 = [[UIScrollView alloc]initWithFrame:CGRectMake(0, 0, 320, 320)];
    sv1.contentSize = CGSizeMake(320, 320+200);
    sv1.clipsToBounds = NO;
    [self.view addSubview:sv1];
    
    [sv1 addSubview:sv];
    primaryView = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, 320, 320)];
    primaryView.image = self.sourceImage;
    [sv addSubview:primaryView];
    
    UIImageView *cropView = [[UIImageView alloc]initWithFrame:sv.frame];
    CALayer *layer=[cropView layer];
    [layer setMasksToBounds:YES];
    [layer setBorderWidth:1];
    [layer setBorderColor:[[UIColor grayColor] CGColor]];
    
    [self.view addSubview:cropView];
    
}

- (UIView *)viewForZoomingInScrollView:(UIScrollView *)scrollView{
    return primaryView;
}

- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    if (buttonIndex == 1)
    {
        
    }
    
}


- (void)doTap:(UIGestureRecognizer *)gesture
{
    
    switch (player.playbackState) {
        case MPMoviePlaybackStateStopped:
        {
            [player play];
            controlImgV.hidden = YES;
            break;
        }
        case MPMoviePlaybackStatePlaying:
        {
            [player pause];
            controlImgV.hidden = NO;
            break;
        }
        case MPMoviePlaybackStatePaused:
        {
            [player play];
            controlImgV.hidden = YES;
            break;
        }
            
        default:
            break;
    }
}

- (void)requestFinishedThumbnailImage:(NSNotification *)notification
{
//    NSLog(@" MPMoviePlayerThumbnailImageRequestDidFinishNotification : %@",notification);
    
    UIImage *image =[notification.userInfo objectForKey: @"MPMoviePlayerThumbnailImageKey"];
    self.movieThumbnail = image;
    
    
}

- (void)myMovieViewFinishedCallback:(NSNotification *)notification
{
    NSLog(@"play finished");
    
    controlImgV.hidden = NO;
}

- (void)doBack:(id)sender
{
    [self.navigationController popViewControllerAnimated:YES];
    [[UIApplication sharedApplication] setStatusBarHidden:YES];
}

- (void)dismissViewController:(id)sender
{
    [self dismissViewControllerAnimated:YES completion:nil];
        [[UIApplication sharedApplication] setStatusBarHidden:NO];
}


- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (void)dealloc
{
    self.sourceImage = nil;
    self.moviePath = nil;
    self.movieThumbnail = nil;
}


@end
