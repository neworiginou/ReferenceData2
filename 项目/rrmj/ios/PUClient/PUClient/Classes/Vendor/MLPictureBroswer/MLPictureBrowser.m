//
//  MLPictureBrowser.m
//  InventoryTool
//
//  Created by molon on 14-2-19.
//  Copyright (c) 2014年 Molon. All rights reserved.
//

#import "MLPictureBrowser.h"
#import "MLPictureBrowserCell.h"
#import "MLBroadcastView.h"
#import "MLPicture.h"
#import "UIImageView+AFNetworking.h"
#import "UIImage+Tint.h"

#define kPadding 10.0f //图片与图片之间的黑色间隔/2,因为每个图片左右都有占位，所以实际间隔是kPadding*2
#define kIsShowStatusBar NO //是否显示状态栏
#define kShowAndDisappearAnimationDuration .35f

#define kDefaultCurrentIndexLabelTag 111
#define kDefaultDownloadTag 112

#define kBundleName @"MLPictureBroswer.bundle"
#define kSrcName(file) [kBundleName stringByAppendingPathComponent:file]

@interface MLPictureBrowser ()<UIScrollViewDelegate,MLBroadcastViewDataSource,MLBroadcastViewDelegate,MLPictureBrowserCellDelegate>

@property(nonatomic,strong) MLBroadcastView *mainView;
@property(nonatomic,strong) UIView *overlayView; //覆盖View 底部显示下载图标和X/Y的view

@property(nonatomic,strong) UIWindow *actionWindow;

@end

@implementation MLPictureBrowser

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.
    
    [self.view addSubview:self.mainView];
    [self.view addSubview:self.overlayView];
    
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(onDeviceOrientationChange) name:UIDeviceOrientationDidChangeNotification object:nil];
    
}

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    [self onDeviceOrientationChange]; //当时就处理下
    NSLog(@"%@---%@",NSStringFromCGRect(self.mainView.frame),NSStringFromCGRect(self.overlayView.frame));

}

- (void)dealloc
{
    [[NSNotificationCenter defaultCenter] removeObserver:self name:UIDeviceOrientationDidChangeNotification object:nil];
}

-(void)onDeviceOrientationChange
{
    UIDeviceOrientation orientation = [UIDevice currentDevice].orientation;
    
    CGRect screenBounds = [UIScreen mainScreen].bounds;
#define kAnimationDuration 0.35f
    if (UIDeviceOrientationIsLandscape(orientation)) {
        [UIView animateWithDuration:kAnimationDuration delay:0.0f options:UIViewAnimationOptionBeginFromCurrentState animations:^{
            [[UIApplication sharedApplication] setStatusBarOrientation:(UIInterfaceOrientation)orientation];
            self.view.transform = (orientation==UIDeviceOrientationLandscapeRight)?CGAffineTransformMakeRotation(M_PI*1.5):CGAffineTransformMakeRotation(M_PI/2);
            self.view.bounds = CGRectMake(0, 0, screenBounds.size.height, screenBounds.size.width);
            [self.view setNeedsLayout];
            [self.view layoutIfNeeded];
        } completion:nil];
    }else if (orientation==UIDeviceOrientationPortrait){
        [UIView animateWithDuration:kAnimationDuration delay:0.0f options:UIViewAnimationOptionBeginFromCurrentState animations:^{
            [[UIApplication sharedApplication] setStatusBarOrientation:(UIInterfaceOrientation)orientation];
            self.view.transform = (orientation==UIDeviceOrientationPortrait)?CGAffineTransformIdentity:CGAffineTransformMakeRotation(M_PI);
            self.view.bounds = screenBounds;
            [self.view setNeedsLayout];
            [self.view layoutIfNeeded];
        } completion:nil];
    }
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - setter and getter

- (MLBroadcastView*)mainView
{
    if (!_mainView) {
        _mainView = [[MLBroadcastView alloc]init];
        _mainView.backgroundColor = [UIColor blackColor];
        _mainView.delegate = self;
        _mainView.dataSource = self;
        _mainView.padding = kPadding;
        _mainView.frame = self.view.bounds;
    }
    return _mainView;
}
-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    //
    for (UIView *view in _mainView.subviews) {
        NSLog(@"%@",view);
    }
}

- (UIView*)overlayView
{
    if (!_overlayView) {
        if (self.delegate&&[self.delegate respondsToSelector:@selector(customOverlayViewOfMLPictureBrowser:)]&&[self.delegate respondsToSelector:@selector(customOverlayViewFrameOfMLPictureBrowser:)]) {
            _overlayView = [self.delegate customOverlayViewOfMLPictureBrowser:self];
        }
        if (!_overlayView) {
            _overlayView = [[UIView alloc]init];
            _overlayView.userInteractionEnabled = YES;
            _overlayView.backgroundColor = [UIColor blackColor];//[UIColor clearColor];
            _overlayView.alpha = 0.8;
            //            _overlayView.layer.opacity = 0.55f;
            UILabel *currentIndexLabel = [[UILabel alloc]init];
            currentIndexLabel.userInteractionEnabled = NO;
            currentIndexLabel.textColor = [UIColor whiteColor];
            currentIndexLabel.textAlignment = NSTextAlignmentCenter;
            currentIndexLabel.font = [UIFont systemFontOfSize:14.0f];
            currentIndexLabel.tag = kDefaultCurrentIndexLabelTag;
            currentIndexLabel.backgroundColor = [UIColor clearColor];
            currentIndexLabel.contentMode = UIViewContentModeCenter;
            [_overlayView addSubview:currentIndexLabel];
            
            UIButton *downloadButton = [UIButton buttonWithType:UIButtonTypeCustom];
            [downloadButton setImage:[UIImage imageNamed:kSrcName(@"picture_download_icon")] forState:UIControlStateNormal];
            [downloadButton setImage:[[UIImage imageNamed:kSrcName(@"picture_download_icon")]imageWithTintColor:[UIColor lightGrayColor]] forState:UIControlStateHighlighted];
            [downloadButton setImage:[[UIImage imageNamed:kSrcName(@"picture_download_icon")]imageWithTintColor:[UIColor lightGrayColor]] forState:UIControlStateDisabled];
            downloadButton.exclusiveTouch = YES;
            [downloadButton addTarget:self action:@selector(downloadImageToSystemBrowser:) forControlEvents:UIControlEventTouchUpInside];
            downloadButton.tag = kDefaultDownloadTag;
            
            [_overlayView addSubview:downloadButton];
        }
    }
    return _overlayView;
}

- (void)setPictures:(NSArray *)pictures
{
    if ([_pictures isEqual:pictures]) {
        return;
    }
    _pictures = pictures;
    
    //设置对应的元素的下标序号
    for (int i = 0; i<pictures.count; i++) {
        MLPicture *picture = pictures[i];
        picture.index = i;
    }
}

#pragma mark - download to system browser
- (void)downloadImageToSystemBrowser:(UIButton*)sender
{
    MLPicture *picture = (MLPicture*)self.pictures[self.currentIndex];
    if (!picture.isLoaded) {
        //没有下载完毕则无操作
        return;
    }
    sender.enabled = NO;
    
    //取得image
    UIImageView *tempImageView = [[UIImageView alloc]init];
    
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:picture.url];
    [request addValue:@"image/*" forHTTPHeaderField:@"Accept"];
    
    [tempImageView setImageWithURLRequest:request placeholderImage:nil success:^(NSURLRequest *request, NSHTTPURLResponse *response, UIImage *image) {
        //下载
        UIImageWriteToSavedPhotosAlbum(image, self, @selector(image:didFinishSavingWithError:contextInfo:), (__bridge_retained void *)(sender));
    } failure:nil];
}

// 指定回调方法
- (void)image:(UIImage *)image didFinishSavingWithError:(NSError *)error contextInfo:(void *)contextInfo
{
    UIButton *button = (__bridge_transfer UIButton*)contextInfo;
    button.enabled = YES;
    
    NSString *msg = nil ;
    if(error != NULL){
        msg = @"保存图片失败" ;
    }else{
        msg = @"已保存至相册" ;
    }
    [[[UIAlertView alloc]initWithTitle:nil message:msg delegate:nil cancelButtonTitle:nil otherButtonTitles:@"确定", nil]show];
}


#pragma mark - layout
- (void)viewDidLayoutSubviews
{
    [super viewDidLayoutSubviews];
    
    self.mainView.frame = self.view.bounds; //包裹完
    
    //overlayView 的frame
    CGFloat overlayViewHeight = 38;
    CGRect overlayViewFrame = CGRectMake(0, self.view.bounds.size.height-overlayViewHeight, self.view.bounds.size.width, overlayViewHeight);//默认覆盖View的frame
    BOOL isCustomOverlay = NO;
    if (self.delegate&&[self.delegate respondsToSelector:@selector(customOverlayViewOfMLPictureBrowser:)]&&[self.delegate respondsToSelector:@selector(customOverlayViewFrameOfMLPictureBrowser:)]) {
        overlayViewFrame = [self.delegate customOverlayViewFrameOfMLPictureBrowser:self];
        isCustomOverlay = YES;
    }
    self.overlayView.frame = overlayViewFrame;
    if (!isCustomOverlay) {
        UILabel *currentIndexLabel = (UILabel *)[self.overlayView viewWithTag:kDefaultCurrentIndexLabelTag];
        currentIndexLabel.frame = self.overlayView.bounds;
        
        UIButton *downloadButton = (UIButton*)[self.overlayView viewWithTag:kDefaultDownloadTag];
        downloadButton.frame = CGRectMake(self.overlayView.bounds.size.width-50.0f, 0, 40.0f, 40.0f);
     }
}

#pragma mark - show and destory 只显示图片
- (void)showWithPictureURLs:(NSArray*)pictureURLs atIndex:(NSUInteger)index
{
    NSMutableArray *pictures = [NSMutableArray arrayWithCapacity:pictureURLs.count];
    for (int i = 0; i<pictureURLs.count; i++) {
        MLPicture *picture = [[MLPicture alloc] init];
        if ([pictureURLs[i] isKindOfClass:[NSString class]]) {
            picture.url = [NSURL URLWithString:pictureURLs[i]];
        }else if ([pictureURLs[i] isKindOfClass:[NSURL class]]) {
            picture.url = pictureURLs[i];
        }else{
            NSAssert(NO, @"图片的URL类型异常");
            return;
        }
        [pictures addObject:picture];
    }
    self.pictures = pictures;
    
    [self.mainView reloadData];
    
    [self.mainView scrollToPageIndex:index animated:NO];
    
//    [self showWithAnimated:YES];
}

#pragma mark - 显示图片和图片上的文字
- (void)showWithPictureURLs:(NSArray*)pictureURLs withTextArray:(NSArray*)textArray atIndex:(NSUInteger)index
{
    NSMutableArray *pictures = [NSMutableArray arrayWithCapacity:pictureURLs.count];
    for (int i = 0; i<pictureURLs.count; i++) {
        MLPicture *picture = [[MLPicture alloc] init];
        if ([pictureURLs[i] isKindOfClass:[NSString class]]) {
            picture.url = [NSURL URLWithString:pictureURLs[i]];
        }else if ([pictureURLs[i] isKindOfClass:[NSURL class]]) {
            picture.url = pictureURLs[i];
        }else{
            NSAssert(NO, @"图片的URL类型异常");
            return;
        }
        if (i < textArray.count) {
            picture.content = textArray[i];//设置显示内容
        }
        [pictures addObject:picture];
    }
    self.pictures = pictures;
    
    [self.mainView reloadData];
    
    [self.mainView scrollToPageIndex:index animated:NO];
    
    [self showWithAnimated:YES];
}
#pragma mark - 显示图片和图片上的文字,评论按钮
- (void)showWithPictureURLs:(NSArray*)pictureURLs withTextArray:(NSArray*)textArray WithcommentNum:(NSString *)commentNum atIndex:(NSUInteger)index
{
    NSMutableArray *pictures = [NSMutableArray arrayWithCapacity:pictureURLs.count];
    for (int i = 0; i<pictureURLs.count; i++) {
        MLPicture *picture = [[MLPicture alloc] init];
        if ([pictureURLs[i] isKindOfClass:[NSString class]]) {
            picture.url = [NSURL URLWithString:pictureURLs[i]];
        }else if ([pictureURLs[i] isKindOfClass:[NSURL class]]) {
            picture.url = pictureURLs[i];
        }else{
            NSAssert(NO, @"图片的URL类型异常");
            return;
        }
        if (i < textArray.count) {
            picture.content = textArray[i];//设置显示内容
        }
        picture.commentNum = commentNum;//设置评论按钮
        [pictures addObject:picture];
    }
    self.pictures = pictures;
    
    [self.mainView reloadData];
    
    [self.mainView scrollToPageIndex:index animated:NO];
    
    [self showWithAnimated:YES];
}
- (void)showWithAnimated:(BOOL)animated
{
    if (!self.pictures||self.pictures.count<=0) {
        NSLog(@"没有图片需要显示");
        return;
    }
    for (NSUInteger i=0; i<self.pictures.count; i++) {
        if (![self.pictures[i] isKindOfClass:[MLPicture class]]) {
            NSAssert(NO, @"传递的图片类型非MLPicture");
            return;
        }
    }
    
//    UIWindow *window = [[UIWindow alloc] initWithFrame:[UIScreen mainScreen].bounds];
//    window.opaque = YES;
//    UIWindowLevel level = UIWindowLevelStatusBar+10.0f;
//    if (kIsShowStatusBar) {
//        level = UIWindowLevelNormal+10.0f;
//    }
//    window.windowLevel = level;
//    window.rootViewController = self;
//    window.backgroundColor = [UIColor blackColor];
//    [window makeKeyAndVisible];
//    self.actionWindow = window;
//    
//    if (animated) {
//        self.actionWindow.layer.opacity = .01f;
//        [UIView animateWithDuration:kShowAndDisappearAnimationDuration animations:^{
//            self.actionWindow.layer.opacity = 1.0f;
//        }];
//    }
    
    [self.superView addSubview:self.view];
}

- (void)setSuperView:(UIView *)superView
{
    if (_superView == superView) {
        return;
    }
    _superView = superView;
}

- (void)disappear
{
    [[UIApplication sharedApplication] setStatusBarOrientation:UIInterfaceOrientationPortrait];
    [UIView animateWithDuration:kShowAndDisappearAnimationDuration animations:^{
        self.actionWindow.layer.opacity = .01f;
    } completion:^(BOOL finished) {
        [self.actionWindow removeFromSuperview];
        [self.actionWindow resignKeyWindow];
        self.actionWindow = nil;
        
        if (self.delegate&&[self.delegate respondsToSelector:@selector(didDisappearOfMLPictureBrowser:)]) {
            [self.delegate didDisappearOfMLPictureBrowser:self];
        }
    }];
}

- (void)scrollToIndex:(NSUInteger)index animated:(BOOL)animated
{
    [self.mainView scrollToPageIndex:index animated:animated];
}

#pragma mark - broadcast datasource
- (NSUInteger)cellCountOfBroadcastView:(MLBroadcastView *)broadcastView
{
    return self.pictures.count;
}

- (MLBroadcastViewCell *)broadcastView:(MLBroadcastView *)broadcastView cellAtPageIndex:(NSUInteger)pageIndex
{
    static NSString *CellIdentifier = @"BroadcastCell";
    MLPictureBrowserCell *cell = [broadcastView dequeueReusableCellWithIdentifier:CellIdentifier];
    
    if (!cell) {
        cell = [[MLPictureBrowserCell alloc]initWithReuseIdentifier:CellIdentifier];
        cell.delegate = self;
    }
#pragma - mark 设置对应位置的图片
    cell.picture = self.pictures[pageIndex]; //设置对应的图像
    
    return cell;
}

#pragma mark - broadcast delegate
//滚到了某一个页面
- (void)didScrollToPageIndex:(NSUInteger)pageIndex ofBroadcastView:(MLBroadcastView *)broadcastView
{
    _currentIndex = pageIndex;
    
    if (!self.delegate||![self.delegate respondsToSelector:@selector(customOverlayViewOfMLPictureBrowser:)]||![self.delegate respondsToSelector:@selector(customOverlayViewFrameOfMLPictureBrowser:)]) {
        UILabel *currentIndexLabel = (UILabel *)[self.overlayView viewWithTag:kDefaultCurrentIndexLabelTag];
        if (self.pictures.count>1) {
            currentIndexLabel.text = [NSString stringWithFormat:@"%lu/%lu",pageIndex+1,self.pictures.count];
        }else{
            currentIndexLabel.text = @"123";
        }
     }
    
    if (self.delegate&&[self.delegate respondsToSelector:@selector(didScrollToIndex:ofMLPictureBrowser:)]) {
        [self.delegate didScrollToIndex:pageIndex ofMLPictureBrowser:self];
    }
}

- (void)preOperateInBackgroundAtPageIndex:(NSUInteger)pageIndex ofBroadcastView:(MLBroadcastView *)broadcastView
{
    MLPicture *picture = (MLPicture*)self.pictures[pageIndex];
    if (picture.isLoaded) {
        return;
    }
    //加载
    UIImageView *tempImageView = [[UIImageView alloc]init];
    
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:picture.url];
    [request addValue:@"image/*" forHTTPHeaderField:@"Accept"];
    
    [tempImageView setImageWithURLRequest:request placeholderImage:nil success:^(NSURLRequest *request, NSHTTPURLResponse *response, UIImage *image) {
        picture.isLoaded = YES;
    } failure:nil];
}

#pragma mark - cell delegate
- (void)didTapForMLPictureCell:(MLPictureBrowserCell*)pictureCell ofIndex:(NSUInteger)index
{
    [self disappear];
}

//自定义覆盖View
- (UIView*)customOverlayViewOfMLPictureCell:(MLPictureBrowserCell *)pictureCell ofIndex:(NSUInteger)index
{
    if (self.delegate&&[self.delegate respondsToSelector:@selector(customOverlayViewOfMLPictureCell:ofIndex:)]) {
        return [self.delegate customOverlayViewOfMLPictureCell:pictureCell ofIndex:index];
    }
    return nil;
    //测试数据
    //    UILabel *label = [[UILabel alloc]init];
    //    label.backgroundColor = [UIColor yellowColor];
    //    label.layer.opacity = .45f;
    //    label.textAlignment = NSTextAlignmentCenter;
    //    label.font = [UIFont systemFontOfSize:14.0f];
    //    label.text = [NSString stringWithFormat:@"第%u页",index];
    //    return label;
}

//自定义覆盖View的frame
- (CGRect)customOverlayViewFrameOfMLPictureCell:(MLPictureBrowserCell*)pictureCell ofIndex:(NSUInteger)index
{
    if (self.delegate&&[self.delegate respondsToSelector:@selector(customOverlayViewFrameOfMLPictureCell:ofIndex:)]) {
        return [self.delegate customOverlayViewFrameOfMLPictureCell:pictureCell ofIndex:index];
    }
    return CGRectZero;
    //测试数据
    //    return CGRectMake(0, 0, pictureCell.bounds.size.width, 50);
}

#pragma mark - rotate 这里限制住旋转，旋转在上面监控OBServer里有处理

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return interfaceOrientation == UIInterfaceOrientationPortrait;
}

- (BOOL)shouldAutorotate
{
    return NO;
}

-(NSUInteger)supportedInterfaceOrientations
{
    return UIInterfaceOrientationMaskPortrait;
}

- (UIInterfaceOrientation)preferredInterfaceOrientationForPresentation
{
    return UIInterfaceOrientationPortrait;
}
-(void)PictureBrowserCellCommentButtonClick:(UIButton *)button
{
    if ([self.delegate respondsToSelector:@selector(PictureBrowserCommentButtonClick:)]) {
        [self.delegate PictureBrowserCommentButtonClick:button];
    }
}

#pragma mark - status bar
#if kIsShowStatusBar
- (UIStatusBarStyle)preferredStatusBarStyle
{
    return UIStatusBarStyleLightContent;
}

- (BOOL)prefersStatusBarHidden
{
    return NO;
}
#endif

@end
