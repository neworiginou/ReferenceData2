//
//  GKFilterViewController.h
//  Camera
//
//  Created by CaiJingPeng on 13-12-16.
//  Copyright (c) 2013年 caijingpeng. All rights reserved.
//

#import <UIKit/UIKit.h>
//#import <GPUImage/GPUImage.h>
#import <MediaPlayer/MediaPlayer.h>

@interface GKFilterViewController : UIViewController<UIAlertViewDelegate,UIScrollViewDelegate>
{
    /*
    GPUImagePicture *sourcePicture;
    GPUImageOutput<GPUImageInput> *filter;
    
    GPUImageMovie *movieFile;
    GPUImageMovieWriter *movieWriter;
     
    GPUImageView *primaryView;
    */
    UIImageView *primaryView;
    
    MPMoviePlayerController *player;
    UIImageView *controlImgV;
    
}

@property (nonatomic,retain) UIImage *sourceImage;
@property (nonatomic,retain) NSString *moviePath;
@property (nonatomic) BOOL isEnableFilter;  // enable filter   default is no
@property (nonatomic,retain) UIImage *movieThumbnail;
@property (nonatomic) BOOL isPreview;

@end
