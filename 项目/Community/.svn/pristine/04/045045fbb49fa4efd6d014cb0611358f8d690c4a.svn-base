//
//  ETShowBigImageView.m
//  etonkids-iphone
//
//  Created by CaiJingPeng on 13-7-17.
//  Copyright (c) 2013年 wpf. All rights reserved.
//

#import "ETShowBigImageView.h"
#import "AppDelegate.h"

#define IMAGEVIEWHEIGHT [UIScreen mainScreen].applicationFrame.size.height

@implementation ETShowBigImageView
@synthesize imgSV,imgUrlArr,imgVArr;
@synthesize content;
@synthesize rightButton,leftButton,delegate;

- (id)initWithFrame:(CGRect)frame AndShowImageNum:(int)num dataArr:(NSArray *)array content:(NSString *)_content
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
        originShowNum = num;
        
        self.backgroundColor = [UIColor blackColor];
        
        self.imgUrlArr = array;
        self.content=_content;
        self.imgVArr = [NSMutableArray array];
        self.backgroundColor = [UIColor blackColor];
                
//        navigationBackView=[[UIImageView alloc]initWithFrame:CGRectMake(0, 0, 320, NAVIHEIGHT)];
//        navigationBackView.image=[UIImage imageNamed:@"navigationNoText"];
//        navigationBackView.userInteractionEnabled = YES;
        
        
//        leftButton =[UIButton buttonWithType:UIButtonTypeCustom];
//        [leftButton setFrame:CGRectMake(0, 0, 50, 35)];
//        [leftButton setCenter:CGPointMake(10 + 34/2, navigationBackView.frame.size.height/2)];
//        [leftButton setImage:[UIImage imageNamed:@"backBtnDefault_3.0"] forState:UIControlStateNormal];
//        [leftButton setImage:[UIImage imageNamed:@"backBtnSel_3.0"] forState:UIControlStateHighlighted];
//        [leftButton addTarget:self action:@selector(leftButtonClick:) forControlEvents:UIControlEventTouchUpInside];
//        [navigationBackView addSubview:leftButton];
        
//        rightButton =[UIButton buttonWithType:UIButtonTypeCustom];
//        [rightButton setFrame:CGRectMake(0, 0, 50, 35)];
//        [rightButton addTarget:self action:@selector(rightButtonClick:) forControlEvents:UIControlEventTouchUpInside];
//        [rightButton setCenter:CGPointMake(320 - 10 - 50/2, navigationBackView.frame.size.height/2)];
//        [rightButton setImage:[UIImage imageNamed:@"shareBtn3.0"] forState:UIControlStateNormal];
//        [rightButton setImage:[UIImage imageNamed:@"shareBtnSel3.0"] forState:UIControlStateHighlighted];
//        [navigationBackView addSubview:rightButton];


        
//        item=[[UILabel alloc] initWithFrame:CGRectMake(0, 0, 100, 40)];
//        item.center = CGPointMake(160, NAVIHEIGHT/2);
//        item.textColor = [UIColor whiteColor];
//        item.backgroundColor = [UIColor clearColor];
//        item.textAlignment = NSTextAlignmentCenter;
//        item.font = [UIFont boldSystemFontOfSize:20];
//        item.text = [NSString stringWithFormat:@"%d / %d",originShowNum + 1,self.imgUrlArr.count];
//        [navigationBackView addSubview:item];
//        [item release];
        
        
        
        width = kScreenWidth;
        
        
        
        scrollV = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, frame.size.height)];
        scrollV.contentSize = CGSizeMake(width * self.imgUrlArr.count, scrollV.frame.size.height- 30);
        scrollV.backgroundColor = [UIColor blackColor];
        scrollV.delegate = self;
        scrollV.pagingEnabled = YES;
        scrollV.contentOffset = CGPointMake(width * originShowNum, 0);
        [self addSubview:scrollV];
        
        self.imgSV = scrollV;
        
        
        [self createZoomView];
//        for (int i = 0; i < array.count; i++) {
//            ETZoomScrollView *imgV = [[ETZoomScrollView alloc] initWithFrame:CGRectMake(width*i, 0, width, scrollV.frame.size.height)];
//            imgV.backgroundColor = [UIColor blackColor];
////            imgV.contentMode = UIViewContentModeScaleAspectFit;
//            imgV.tag = 777 + i;
//            imgV.tDelegate = self;
//            
//            [scrollV addSubview:imgV];
//            [imgV release];
//            
//            [self.imgVArr addObject:imgV];
//        }
//        
//        
//        [self downloadBigImage];
        
        
        pageCtr = [[UIPageControl alloc] init];
        pageCtr.pageIndicatorTintColor = UIColorFromRGB(0xb8b8b8);
        pageCtr.currentPageIndicatorTintColor = UIColorFromRGB(0x8ACF1C);
        pageCtr.numberOfPages = array.count;
        pageCtr.currentPage = num;
        pageCtr.frame = CGRectMake(0, frame.size.height - 80, kScreenWidth, 40);
        [self addSubview:pageCtr];
        
        
        
    }
    return self;
}

- (void)createZoomView
{
    
    for (int i = 0; i < self.imgUrlArr.count; i++) {
        
        ETZoomScrollView *imgV = [[ETZoomScrollView alloc] initWithFrame:CGRectMake(width*i, 0, scrollV.frame.size.width, scrollV.frame.size.height)];
        imgV.backgroundColor = [UIColor blackColor];
        //            imgV.contentMode = UIViewContentModeScaleAspectFit;
        imgV.tag = 777 + i;
        imgV.tDelegate = self;
        imgV.imageView.image = [UIImage imageNamed:@"holdImage"];
        [scrollV addSubview:imgV];
        
        [self.imgVArr addObject:imgV];
    }
//    AppDelegate *appDelegate = SHARED_APP_DELEGATE;
//    if (appDelegate.networkStatus == ReachableViaWiFi) {
        [self downloadBigImage];
//    }
//    else {
//        if ([[[NSUserDefaults standardUserDefaults] objectForKey:kOpen3GDownload] isEqualToString:@"2"]) {
//            //要求点击下载
//        }
//        else
//        {
//            [self downloadBigImage];
//        }
//    }
    
    
    
}

- (void)reloadFrame:(UIInterfaceOrientation)orientation
{
    /*
    //NSLog(@"%d",originShowNum);
    
    int temp = originShowNum;
    if (orientation == UIInterfaceOrientationLandscapeLeft || orientation == UIInterfaceOrientationLandscapeRight)
    {
//        navigationBackView.frame = CGRectMake(0, 0, iphone5 ? 568 : 480, NAVIHEIGHT);
//        item.center = CGPointMake((iphone5 ? 568 : 480)/2, NAVIHEIGHT/2);
//        rightButton.frame = CGRectMake((iphone5 ? 568 : 480) - 10 - 40, (NAVIHEIGHT - 35)/2.0f, 50, 35);
        scrollV.frame = CGRectMake(0, 0, [Utility isIphone5] ? 568 : 480, 300);
        scrollV.contentOffset = CGPointMake(([Utility isIphone5] ? 568 : 480) * temp, 0);
        
        scrollV.contentSize = CGSizeMake(scrollV.frame.size.width * self.imgUrlArr.count, scrollV.frame.size.height);
        
        for (id obj in scrollV.subviews) {
            
            if ([obj isKindOfClass:[ETZoomScrollView class]]) {
                ETZoomScrollView *imgV = (ETZoomScrollView *)obj;
                if (imgV.tag >= 777) {
                    imgV.frame = CGRectMake(scrollV.frame.size.width*(imgV.tag % 777), 0, scrollV.frame.size.width, scrollV.frame.size.height);
                    imgV.zoomScale = 1;
                    imgV.imageView.frame = CGRectMake(0,
                                                      0,
                                                      scrollV.frame.size.width,
                                                      scrollV.frame.size.height);
                }
            }
            
        }
        
        
        
        
        
        
    }
    else
    {
//        navigationBackView.frame = CGRectMake(0, 0, 320, NAVIHEIGHT);
//        item.center = CGPointMake(320/2, NAVIHEIGHT/2);
//        rightButton.frame=CGRectMake(320 - 10 - 40, (NAVIHEIGHT - 35)/2.0f,50, 35);
        scrollV.frame = CGRectMake(0, 0, width, IMAGEVIEWHEIGHT);
        scrollV.contentOffset = CGPointMake(width *originShowNum, 0);
        scrollV.contentSize = CGSizeMake(width * self.imgUrlArr.count, scrollV.frame.size.height);
        
        
        for (id obj in scrollV.subviews) {
            
            if ([obj isKindOfClass:[ETZoomScrollView class]]) {
                ETZoomScrollView *imgV = (ETZoomScrollView *)obj;
                if (imgV.tag >= 777) {
                    imgV.frame = CGRectMake(width*(imgV.tag % 777), 0, width, scrollV.frame.size.height);
                    imgV.zoomScale = 1;
                    imgV.imageView.frame = CGRectMake(0, 0, width, scrollV.frame.size.height);
                    
                }
            }
            
        }
        
        
        //NSLog(@"%d",originShowNum);
        
    }

    originShowNum = temp;
    
//    if ([self viewWithTag:555])
//    {
//        MTCustomActionSheet *action = (MTCustomActionSheet *)[self viewWithTag:555];
//        [action reloadFrame:orientation];
//    }
    */
    
}


- (void)handleSingleTap
{
//    AppDelegate *appDelegate = SHARED_APP_DELEGATE;
//    if (appDelegate.networkStatus == ReachableViaWiFi) {
//        
//    }
//    else {
//        if ([[[NSUserDefaults standardUserDefaults] objectForKey:kOpen3GDownload] isEqualToString:@"2"]) {
    
            [self downloadBigImage];
//        }
//    }
    
    
    if (delegate && [delegate respondsToSelector:@selector(didSingleTapImageView:)]) {
        [delegate didSingleTapImageView:self];
    }
    
}





-(void)leftButtonClick:(UIButton*)sender
{
    if (delegate && [delegate respondsToSelector:@selector(didClickBackButton)]) {
        [delegate didClickBackButton];
    }
}

/// 下载大图.
- (void)downloadBigImage
{
    if (self.imgVArr.count > 0)
    {
        ETZoomScrollView *zoomView = [self.imgVArr objectAtIndex:originShowNum];
        MBProgressHUD *hud = [[MBProgressHUD alloc] initWithView:zoomView];
        hud.center = CGPointMake(scrollV.frame.size.width/2 + originShowNum*scrollV.frame.size.width, scrollV.frame.size.height/2.0f);
        hud.mode = MBProgressHUDModeAnnularDeterminate;
        //hud.tag = HUDTAG + i;
        [self.imgSV addSubview:hud];
        [hud show:YES];
        
        //    NSDictionary * dic = [self.imgUrlArr objectAtIndex:originShowNum];
        NSString * path = [self.imgUrlArr objectAtIndex:originShowNum];
        NSURL *url = [NSURL URLWithString:path];
        __weak ETZoomScrollView *weakZoomView = zoomView;
        [zoomView.imageView setImageWithURL:url placeholderImage:[UIImage imageNamed:@"holdImage"] options:SDWebImageRetryFailed progress:^(NSUInteger receivedSize, long long expectedSize) {
            
            hud.progress = receivedSize/(float)expectedSize;
            
        } completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType) {
            weakZoomView.imageView.image = image;
            [hud removeFromSuperview];
        }];
    }
    
    
}


- (void)imageSavedToPhotosAlbum:(UIImage *)image didFinishSavingWithError:(NSError *)error contextInfo:(void *) contextInfo {
    NSString *message;
//    NSString *title;
    
    if(saveHUD)
    {
        [saveHUD removeFromSuperview];
        saveHUD=nil;
        
    }
    if (!error) {
//        title = LOCAL(@"alert", @"提示");
//        message = LOCAL(@"success", @"保存成功");
    } else {
//        title =LOCAL(@"fail",  @"失败");
       // message = [error description];
        
       // message=@"没有相册访问权限，请在\"设置\"--\"隐私\"--\"照片\"--\"云中校车\"中设置";
        message = NSLocalizedString(@"privacy", @"");
    }
//    ETCustomAlertView *alert = [[ETCustomAlertView alloc] initWithTitle:nil message:message delegate:nil cancelButtonTitle:nil otherButtonTitles:nil];
//    [alert show];
    
}



// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
    // Drawing code
    
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    
    
    if (scrollView == scrollV)
    {
        int offset = (int)scrollV.contentOffset.x/scrollV.frame.size.width;
//        //NSLog(@"offset  %f,%f , %d",scrollV.contentOffset.x,scrollV.frame.size.width,offset);
        
        pageCtr.currentPage = offset;
        
        if ((int)scrollView.contentOffset.x % (int)scrollV.frame.size.width == 0)
        {
            if (offset != originShowNum)
            {
                originShowNum = offset;
                item.text = [NSString stringWithFormat:@"%d / %d",originShowNum + 1,self.imgUrlArr.count];
                
                [self downloadBigImage];
               
                for (id obj in scrollV.subviews)
                {
                    if ([obj isKindOfClass:[ETZoomScrollView class]])
                    {
                        ETZoomScrollView *imgV = (ETZoomScrollView *)obj;
                        if (imgV.tag >= 777)
                        {
                            imgV.zoomScale = 1;
                            imgV.imageView.center = CGPointMake(imgV.frame.size.width / 2,imgV.frame.size.height / 2);
                        }
                    }
                    
                }
                
            }
            
        }
    }
 
}




@end
