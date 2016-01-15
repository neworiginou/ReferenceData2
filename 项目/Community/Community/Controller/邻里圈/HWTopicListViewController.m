//
//  HWTopicListViewController.m
//  Community
//
//  Created by hw500029 on 15/1/15.
//  Copyright (c) 2015年 caijingpeng. All rights reserved.
//  功能描述:某话题下的话题列表
//      姓名         日期               修改内容
//     马一平     2015-01-18           创建文件
//     马一平     2015-01-19           点击发送接口(纯文本/图文)

#import "HWTopicListViewController.h"
#import "HWInputBackView.h"
#import <AssetsLibrary/AssetsLibrary.h>
#import "HWPublishAlbumCell.h"
#import "GKImagePickerController.h"
#import "HWCropImageViewController.h"
#import "HWCustomSiftView.h"
#import "HWAlbumManager.h"
#import "AppDelegate.h"
#import "HWPublishViewController.h"

#import "HWPublishViewController.h"

#import "HWNoFoundPicView.h"
#import "HWAudioPlayCenter.h"

#define kScreenHeight [UIScreen mainScreen].bounds.size.height
#define INPUT_PLACEHOLDER       @"输入内容..."

@interface HWTopicListViewController ()<HWDetailViewControllerDelete>
/*UITextFieldDelegate,HWPublishAlbumCellDelegate,GKImagePickerControllerDelegate,HWCropImageViewControllerDelegate,UITableViewDataSource,UITableViewDelegate
 */
{
    UIView *_InPutBackView;//输入框背景视图
    UIView * _blackView;//输入框弹出时覆盖屏幕的视图
    UITextField *_InPutTF;//底部输入框
    UIButton *_CameraBtn;//底部相机按钮
    UIButton *_SoundBtn;//底部录音按钮
    BOOL _isShowImage;
    BOOL _isKeyBoardShow;
    
    
    ALAssetsLibrary *_assetLibrary;
    ALAssetsFilter *_assetsFilter;
    UITableView *_albumGridTV;
    
    GKCameraManager *camManager;
    UIView *camPreview;
    
    //图片选中状态栏
    UIImageView *_photoImgV;
    UIButton *_deletePhonoBtn;
    UIView *_photoImgBackView;
    //navRightBtn 点击出现的筛选器
    HWCustomSiftView *_sift;
}
@property (nonatomic, assign) BOOL  navigationHiden;

@end

@implementation HWTopicListViewController

- (instancetype)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    if (self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil])
    {
        
    }
    return self;
}

- (void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    
    if ([[HWAudioPlayCenter shareAudioPlayCenter] isPlaying])
    {
        [[HWAudioPlayCenter shareAudioPlayCenter] stop];
    }
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(refreshList) name:HWNeighbourDragRefresh object:nil];
    
    self.navigationController.navigationBarHidden = NO;
    
    self.assets = [NSMutableArray array];
    self.groups = [NSMutableArray array];
    
    _assetLibrary = [[ALAssetsLibrary alloc] init];
    
    //获取相册数据
//    dispatch_async(dispatch_queue_create("loadAlbum", DISPATCH_QUEUE_SERIAL), ^{
//        [self loadAlbum];
//    });
//    
//    //NSArray *arr = [HWAlbumManager shareAlbumManager].assets;
//    
//    _isShowImage = NO;
//    _isKeyBoardShow = NO;
//    
//    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(UIMove1:) name:UIKeyboardWillShowNotification object:nil];
//    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(UIMove2:) name:UIKeyboardWillHideNotification object:nil];
    
    self.navigationItem.rightBarButtonItem = nil;
    self.navigationItem.rightBarButtonItem = [Utility navPublishButton:self action:@selector(addTopicClick)];
    
    if ([_channelModel.channelId isEqualToString:@"邻居说"])
    {
        self.navigationItem.titleView = [Utility navTitleView:[HWUserLogin currentUserLogin].villageName];
    }
    else if ([_channelModel.channelId isEqualToString:@"同城说"])
    {
        self.navigationItem.titleView = [Utility navTitleView:@"同城说"];
    }
    else if ([_channelModel.channelId isEqualToString:@"串串门儿"])
    {
//        self.navigationItem.titleView = [Utility navTitleView:@"串串门儿"];
        
        if (_channelModel.passVillageIdArr != nil && _channelModel.passVillageIdArr.count > 1)  //两个以上
        {
            self.navigationItem.rightBarButtonItem = [Utility navButton:self title:@"下一个" action:@selector(changeVillage)];
        }
        else
        {
            self.navigationItem.rightBarButtonItem = nil;
        }
    }
    else
    {
        self.navigationItem.titleView = [Utility navTitleView:_channelModel.channelName];
    }
    
    self.navigationItem.leftBarButtonItem = [Utility navLeftBackBtn:self action:@selector(backMethod)];
    
    float height = 0.0f;
    if ([[[UIDevice currentDevice] systemVersion] floatValue] < 7.0 )
        height = CONTENT_HEIGHT - 20 ;
    else
        height = CONTENT_HEIGHT ;
    
    //频道主题列表
    _channelView = [[HWChannelView alloc]initWithFrame:CGRectMake(0, 0, kScreenWidth, CONTENT_HEIGHT)];
    _channelView.channelModel = self.channelModel;
    _channelView.delegate = self;
    [_channelView queryListData];
    _channelView.delegate = self;
    [self.view addSubview:_channelView];
    
    UIView *whiteV = [[UIView alloc]initWithFrame:CGRectMake(0 ,CONTENT_HEIGHT - 45 * kScreenRate, kScreenWidth, 45 * kScreenRate)];
    whiteV.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:whiteV];
    
    UIImageView *imageV = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"publishIcon"]];
    imageV.frame = CGRectMake(0, 0, 27, 17);
    [whiteV addSubview:imageV];
    imageV.center = CGPointMake(whiteV.frame.size.width / 2.0f, whiteV.frame.size.height / 2.0f);
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(doPub)];
    [whiteV addGestureRecognizer:tap];
    [whiteV addSubview:[Utility drawLineWithFrame:CGRectMake(0, 0, kScreenWidth, 0.5)]];
    whiteV.hidden = true;
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [self addAudioPlayNotification];
}

- (void)viewWillDisappear
{
    if ([[HWAudioPlayCenter shareAudioPlayCenter] isPlaying])
    {
        [[HWAudioPlayCenter shareAudioPlayCenter] stop];
    }
    [self removeAudioPlayNotification];
}

- (void)addAudioPlayNotification
{
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(downloadAudioFinish:) name:HWAudioDownloaderFinishedNotification object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(downloadAudioFailed:) name:HWAudioDownloaderFailedNotification object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(startPlayNotification:) name:HWAudioPlayCenterStartPlayNotification object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(pausePlayNotification:) name:HWAudioPlayCenterPausePlayNotification object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(stopPlayNotification:) name:HWAudioPlayCenterStopPlayNotification object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(downloadingAudio:) name:HWAudioDownloaderDownloadindNotification object:nil];
}

- (void)removeAudioPlayNotification
{
    [[NSNotificationCenter defaultCenter] removeObserver:self name:HWAudioDownloaderFinishedNotification object:nil];
    [[NSNotificationCenter defaultCenter] removeObserver:self name:HWAudioDownloaderFailedNotification object:nil];
    [[NSNotificationCenter defaultCenter] removeObserver:self name:HWAudioPlayCenterStartPlayNotification object:nil];
    [[NSNotificationCenter defaultCenter] removeObserver:self name:HWAudioPlayCenterPausePlayNotification object:nil];
    [[NSNotificationCenter defaultCenter] removeObserver:self name:HWAudioPlayCenterStopPlayNotification object:nil];
    [[NSNotificationCenter defaultCenter] removeObserver:self name:HWAudioDownloaderDownloadindNotification object:nil];
}


#pragma -
#pragma mark Play Audio

- (void)downloadingAudio:(NSNotification *)notification
{
    [_channelView downloadingAudio:notification];
}

- (void)downloadAudioFinish:(NSNotification *)notificaiton
{
    [_channelView downloadAudioFinish:notificaiton];
}

- (void)downloadAudioFailed:(NSNotification *)notificaiton
{
    [_channelView downloadAudioFailed:notificaiton];
}

- (void)startPlayNotification:(NSNotification *)notificaiton
{
    [_channelView startPlayNotification:notificaiton];
}

- (void)pausePlayNotification:(NSNotification *)notificaiton
{
    [_channelView pausePlayNotification:notificaiton];
    
}

- (void)stopPlayNotification:(NSNotification *)notificaiton
{
    [_channelView stopPlayNotification:notificaiton];
    
}

- (void)refreshList
{
    [_channelView refreshList];
}

- (void)backMethod
{
    [MobClick event:@"click_fanhui_pingdaoxiangqing"]; //maidian_1.2.1 MYP add
    [super backMethod];
    if (self.isSearchBarPush == YES)
    {
        self.navigationController.navigationBarHidden = YES;
    }
}

/**
 *	@brief	设置右侧按钮
 *
 *	@param 	string 	默认文本
 *
 *	@return	N/A
 */
- (void)changeListWithString:(NSString *)string
{
//    self.navigationItem.rightBarButtonItem = nil;
//    self.navigationItem.rightBarButtonItem = [Utility navrightDownBtn:self withTitle:string sel:@selector(showSearch)];
}


/**
 *	@brief	推到发表页面
 *
 *	@return	N/A
 */
- (void)doPub
{
    if ([[HWUserLogin currentUserLogin].coStatus isEqualToString:@"0"])
    {
        if ([HWUserLogin verifyBindMobileWithPopVC:self showAlert:YES])
        {
            HWPublishViewController *pubVC = [[HWPublishViewController alloc]init];
            pubVC.curChannelModel = self.channelModel;
            if ([HWUserLogin verifyIsLoginWithPresentVC:self toViewController:nil])
            {
                if ([HWUserLogin verifyIsAuthenticationWithPopVC:self showAlert:YES])
                {
                    [self.navigationController pushViewController:pubVC animated:YES];
                }
            }
        }
    }
    else
    {
        if ([HWUserLogin verifyBindMobileWithPopVC:self showAlert:YES])
        {
            HWPublishViewController *publishVC = [[HWPublishViewController alloc] init];
            publishVC.publishRoute = NeighbourRoute;
            publishVC.isNeedAudio = NO;
            publishVC.isWriteAndPic = YES;
            if ([HWUserLogin verifyIsLoginWithPresentVC:self toViewController:publishVC])
            {
                [self.navigationController pushViewController:publishVC animated:YES];
            }
        }
    }
}

#pragma mark - 发布话题按钮点击
- (void)addTopicClick
{
    if ([[HWUserLogin currentUserLogin].coStatus isEqualToString:@"0"])
    {
        if ([HWUserLogin verifyBindMobileWithPopVC:self showAlert:YES])
        {
            HWPublishViewController *publishVC = [[HWPublishViewController alloc] init];
            publishVC.publishRoute = NeighbourRoute;
            publishVC.isNeedAudio = NO;
            publishVC.isWriteAndPic = YES;
            if (!([_channelModel.channelId isEqualToString:@"串串门儿"] || [_channelModel.channelId isEqualToString:@"同城说"] || [_channelModel.channelId isEqualToString:@"邻居说"]))
            {
                publishVC.curChannelModel = self.channelModel;
            }
            if ([HWUserLogin verifyIsLoginWithPresentVC:self toViewController:publishVC])
            {
                if ([HWUserLogin verifyIsAuthenticationWithPopVC:self showAlert:YES])
                {
                    [self.navigationController pushViewController:publishVC animated:YES];
                }
            }
        }
    }
    else
    {
        if ([HWUserLogin verifyBindMobileWithPopVC:self showAlert:YES])
        {
            HWPublishViewController *publishVC = [[HWPublishViewController alloc] init];
            publishVC.publishRoute = NeighbourRoute;
            publishVC.isNeedAudio = NO;
            publishVC.isWriteAndPic = YES;
            if ([HWUserLogin verifyIsLoginWithPresentVC:self toViewController:publishVC])
            {
                [self.navigationController pushViewController:publishVC animated:YES];
            }
        }
    }
}

#pragma mark - 切换串串门小区
- (void)changeVillage
{
    [_channelView changeChuanChuanMenVillageIdQuery];
}

#pragma mark - 筛选列表显示/消失 -- 已取消显示
-(void)showSearch
{
    [MobClick event:@"click_quyuxuanzheqi"]; //maidian_1.2.1 MYP add
    //_sift.Selected = ! _sift.Selected;
    _sift =[[HWCustomSiftView alloc]initWithTitle:@[@"全国",@"同城",@"附近"] andBtnFrame:CGRectMake(0, 0, 0, 0)];
    
    __weak HWTopicListViewController *selfVC = self;
    __weak HWChannelView *channelV = _channelView;
    [_sift setSelectedInfo:^(NSString *title){
        NSLog(@"title ======== %@",title);
        selfVC.navigationItem.rightBarButtonItem = nil;
        selfVC.navigationItem.rightBarButtonItem = [Utility navrightDownBtn:selfVC withTitle:title sel:@selector(showSearch)];

        if ([title isEqualToString:@"全国"])
        {
            [MobClick event:@"click_quanbu"]; //maidian_1.2.1 MYP add
            channelV.range = @"0";
        }
        else if ([title isEqualToString:@"同城"])
        {
            [MobClick event:@"click_tongcheng"]; //maidian_1.2.1 MYP add
            channelV.range = @"1";
        }else
        {
            [MobClick event:@"click_zhoubian"]; //maidian_1.2.1 MYP add
            channelV.range = @"2";
        }
        [channelV.baseListArr removeAllObjects];
        [channelV queryListData];
    }];
    
    [[UIApplication sharedApplication].delegate.window addSubview:_sift];
}

#pragma -mark HWChannelViewDelegate

- (void)pushController:(id)controller
{
    [self.navigationController pushViewController:controller animated:YES];
}

- (void)doLikeWithIndex:(NSIndexPath *)index
{
    
}

- (void)didAddChannel
{
    HWAddChannelViewController *addVC = [[HWAddChannelViewController alloc]init];
    addVC.delegate = self;
    self.navigationController.navigationBarHidden = NO;
    [self.navigationController pushViewController:addVC animated:YES];
}

- (void)changeNavTitle:(NSString *)string
{
    self.navigationItem.titleView = [Utility navTitleView:string];
}

- (void)pushToDetailViewController:(NSString *)topicId resourceType:(detailResource)type isChuanChuanMen:(BOOL)isChuan personalVC:(UIViewController *)personalVC channelId:(NSString *)channelId
{
    HWDetailViewController *detailVC = [[HWDetailViewController alloc]initWithCardId:topicId];
    detailVC.resourceType = type;
    detailVC.channelId = channelId;
    detailVC.chuanChuanMenCanNotHandle = isChuan;
    detailVC.delegate = self;
    detailVC.personalVC = personalVC;
    [self.navigationController pushViewController:detailVC animated:YES];
}

#pragma mark -
#pragma mark - HWAddChannelViewControllerDelegate
- (void)didSelectChannel:(HWChannelModel *)model
{
    [_channelView selectChannel:model];
}

#pragma -mark HWDetailViewControllerDelete
- (void)changeLike:(NSDictionary *)dict
{
    [_channelView changeLike:[dict stringObjectForKey:@"likeCount"] isPrise:[dict stringObjectForKey:@"isPraise"]];
}

- (void)changeComment:(NSDictionary *)dict
{
    [_channelView changeComment:[dict stringObjectForKey:@"commentCount"]];
}


#pragma mark ----------------------------- 以下代码不使用

////去除已选图片
//-(void)deleteImg
//{
//    _photoImgV.image = nil;
//    _photoImgBackView.hidden = YES;
//}

//#pragma mark -- 底部输入框按钮点击事件
//-(void)showImage
//{
//    //照片选择器已推出情况下 点击相机按钮无效
//    if (_albumGridTV.frame.origin.y< CONTENT_HEIGHT && _albumGridTV!=nil && _InPutTF.editing == NO) {
//        return;
//    }
//    
//    _isShowImage = YES;
//    [_InPutTF resignFirstResponder];
//    
//    [self initialAlbum];
//    
//    _blackView.frame = _blackView.frame = CGRectMake(0, 0, kScreenWidth, CONTENT_HEIGHT);
//    [UIView animateWithDuration:0.2 animations:^{
//        
//        _InPutBackView.frame = CGRectMake(0, CONTENT_HEIGHT-(45 + 35 + 216)*kScreenRate, kScreenWidth, ( 45 + 35 )*kScreenRate);
//        
//        _albumGridTV.frame = CGRectMake(0, CGRectGetMaxY(_InPutBackView.frame), kScreenWidth, CONTENT_HEIGHT - CGRectGetMaxY(_InPutBackView.frame));
//    } completion:^(BOOL finished){
//        
//    }];
//    //NSLog(@"选择图片展示");
//}
//
//-(void)pushRecordingVC
//{
//    //NSLog(@"进入录音界面");
//    HWPublishViewController *publishVC = [[HWPublishViewController alloc]init];
//    publishVC.isOnlyAudio = YES;
//    [self.navigationController pushViewController:publishVC animated:YES];
//}

//#pragma UITextFieldDelegate
//-(void)textFieldDidBeginEditing:(UITextField *)textField
//{
//    _blackView.frame = CGRectMake(0, 0, kScreenWidth, CONTENT_HEIGHT);
//    _albumGridTV.frame = CGRectMake(0, CONTENT_HEIGHT, kScreenWidth, CONTENT_HEIGHT - CGRectGetMaxY(_InPutBackView.frame));
//}

//#pragma mark -- 发布图文
//- (BOOL)textFieldShouldReturn:(UITextField *)textField
//{
//    NSLog(@"发布");
//    
//    [self sendTopic];
//    
//    return YES;
//}
//
//- (void)sendTopic
//{
//    NSString *publishStr = [[_InPutTF.text stringByReplacingOccurrencesOfString:@"\n" withString:@" "] stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]];
//    //附件类型1：文字 0：文字+图片2：语音
//    HWHTTPRequestOperationManager *manager = [HWHTTPRequestOperationManager manager];
//    
//    
//        if (publishStr == nil || [publishStr isEqualToString:@""] || [publishStr isEqualToString:INPUT_PLACEHOLDER])
//        {
//            [Utility showToastWithMessage:@"写点内容再发吧~" inView:self.view];
//            return;
//        }
//    [self remove];
//        [Utility showMBProgress:self.view.window message:@"发送数据"];
//        
//        NSMutableDictionary *param = [NSMutableDictionary dictionary];
//        [param setPObject:[HWUserLogin currentUserLogin].key forKey:@"key"];
//        [param setPObject:[HWUserLogin currentUserLogin].userId forKey:@"userId"];
//        [param setPObject:publishStr forKey:@"text"];
//        //[param setPObject:(_anonymous ? @"1" : @"0") forKey:@"isAnonymous"];
//        [param setPObject:@"1"  forKey:@"isAnonymous"];
//        [param setPObject:[HWUserLogin currentUserLogin].tenementId forKey:@"tenementId"];
//        [param setPObject:[HWUserLogin currentUserLogin].villageId forKey:@"villageId"];
//        [param setPObject:[HWUserLogin currentUserLogin].nickname forKey:@"nickName"];
//        [param setPObject:_channelModel.channelId forKey:@"channelId"];
//        if (_photoImgV.image != nil)
//        {
//            [param setPObject:@"23" forKey:@"releaseType"];
//            [param setPObject:[NSString stringWithFormat:@"%@%g",[HWUserLogin currentUserLogin].userId, [[NSDate date] timeIntervalSinceNow]] forKey:@"fileName"];
//            [param setPObject:UIImageJPEGRepresentation(_photoImgV.image, 1.0f) forKey:@"file"];
//            [manager POSTImage:kPropertyFeedback parameters:param queue:nil success:^(id responseObject) {
//                
//                [Utility hideMBProgress:self.view.window];
//                
//                if ([[[responseObject dictionaryObjectForKey:@"data"] stringObjectForKey:@"status"] isEqualToString:@"1"]) {
//                    [Utility showToastWithMessage:[[responseObject dictionaryObjectForKey:@"data"] stringObjectForKey:@"returnInfo"]inView:self.view];
//                    return ;
//                }
//                
//                [[NSNotificationCenter defaultCenter] postNotificationName:HWNeighbourDragRefresh object:nil];
//                
//                AppDelegate *appDel = (AppDelegate *)SHARED_APP_DELEGATE;
//                [Utility showToastWithMessage:@"发布成功" inView:appDel.window];
//                
//                [self.navigationController popViewControllerAnimated:YES];
//                
//            } failure:^(NSString *error) {
//                [Utility hideMBProgress:self.view.window];
//                [Utility showToastWithMessage:error inView:self.view];
//            }];
//        }
//        else
//        {
//            [param setPObject:@"24" forKey:@"releaseType"];
//            [manager POSTImage:kPropertyFeedback parameters:param queue:nil success:^(id responseObject) {
//                [Utility hideMBProgress:self.view.window];
//                
//                if ([[[responseObject dictionaryObjectForKey:@"data"] stringObjectForKey:@"status"] isEqualToString:@"1"]) {
//                    [Utility showToastWithMessage:[[responseObject dictionaryObjectForKey:@"data"] stringObjectForKey:@"returnInfo"] inView:self.view];
//                    return ;
//                }
//                
//                [[NSNotificationCenter defaultCenter] postNotificationName:HWNeighbourDragRefresh object:nil];
//                
//                AppDelegate *appDel = (AppDelegate *)SHARED_APP_DELEGATE;
//                [Utility showToastWithMessage:@"发布成功" inView:appDel.window];
//                [self.navigationController popViewControllerAnimated:YES];
//            } failure:^(NSString *error) {
//                [Utility hideMBProgress:self.view.window];
//                [Utility showToastWithMessage:error inView:self.view];
//            }];
//        }
//    
//
//}

//移除筛选框
//-(void)remove
//{
//    [_InPutTF resignFirstResponder];
//    
//    [UIView animateWithDuration:0.2 animations:^{
//        
//            _InPutBackView.frame = CGRectMake(0, CONTENT_HEIGHT-(45+35)*kScreenRate, kScreenWidth, (45+35)*kScreenRate);
//        _albumGridTV.frame = CGRectMake(0, CONTENT_HEIGHT, kScreenWidth, CONTENT_HEIGHT - CGRectGetMaxY(_InPutBackView.frame));
//    } completion:^(BOOL finished){
//        _blackView.frame = CGRectMake(0, CONTENT_HEIGHT-45, kScreenWidth, 45);
//        [_InPutTF resignFirstResponder];
//    }];
//}

////键盘向上移动
//-(void)UIMove1:(NSNotification *)not
//{
//    CGFloat h = [not.userInfo[UIKeyboardFrameEndUserInfoKey]CGRectValue].size.height ;
//    [UIView animateWithDuration:0.2 animations:^{
//    
//            _InPutBackView.frame = CGRectMake(0, CONTENT_HEIGHT-(45+35)*kScreenRate - h, kScreenWidth, (45+35)*kScreenRate);
//        
//    } completion:^(BOOL finished){
//        _isKeyBoardShow = YES;
//    }];
//}
//

////键盘向下移动
//-(void)UIMove2:(NSNotification *)not
//{
//    [UIView animateWithDuration:0.2 animations:^{
//        if (!_isShowImage) {
//            _InPutBackView.frame = CGRectMake(0, CONTENT_HEIGHT-(45+35)*kScreenRate, kScreenWidth, (45+35)*kScreenRate);
//        }
//    } completion:^(BOOL finished){
//        _isKeyBoardShow = NO;
//    }];
//}
//
//-(void)loadAlbum
//{
//    // 加载相册
//    [_assetLibrary enumerateGroupsWithTypes:ALAssetsGroupAll usingBlock:^(ALAssetsGroup *group, BOOL *stop) {
//        
//        if (group)
//        {
//            [group setAssetsFilter:_assetsFilter];
//            if (group.numberOfAssets > 0)
//                [self.groups addObject:group];
//        }
//        else
//        {
//            if (self.groups.count > 0)
//            {
//                for (ALAssetsGroup *assetsGroup in self.groups)
//                {
//                    //                    NSString *name = [assetsGroup valueForProperty:ALAssetsGroupPropertyName];
//                    //                    if ([name isEqualToString:@"Camera Roll"] || [name isEqualToString:@"相机胶卷"])
//                    //                    {
//                    [self setupAssets:assetsGroup];
//                    //                    }
//                }
//            }
//            
//        }
//        
//    } failureBlock:^(NSError *error) {
//        
//        NSLog(@"------%@",error.description);
//        NSLog(@"%d",(int)error.code);
//        
//        if(error.code == -3311)
//        {
//            //            [Utility showAlertWithMessage:@"无法读取相册图片，请打开设备\"设置\"-\"隐私\"-\"照片\"，开启\"考拉社区\"访问权限"];
//            //            UIAlertView *alert=[[UIAlertView alloc]initWithTitle:NSLocalizedString(@"alert", @"") message:NSLocalizedString(@"privacyPhoto", @"") delegate:nil cancelButtonTitle:NSLocalizedString(@"OK", @"") otherButtonTitles:nil, nil];
//            //            [alert show];
//        }
//        
//    }];
//
//}
//
//- (void)setupAssets:(ALAssetsGroup *)assetsGroup
//{
//    if (!self.assets)
//        self.assets = [[NSMutableArray alloc] init];
//    //    else
//    //        [self.assets removeAllObjects];
//    
//    ALAssetsGroupEnumerationResultsBlock resultsBlock = ^(ALAsset *asset, NSUInteger index, BOOL *stop) {
//        
//        if (asset)
//        {
//            [self.assets addObject:asset];
//            //            NSString *type = [asset valueForProperty:ALAssetPropertyType];
//        }
//        else if (self.assets.count > 0)
//        {
//            // 倒序
//            [Utility reverseArray:self.assets];
//            
//            dispatch_async(dispatch_get_main_queue(), ^{
//                [_albumGridTV reloadData];
//            });
//            
//        }
//    };
//    
//    [assetsGroup enumerateAssetsUsingBlock:resultsBlock];
//}


//#pragma mark -
//#pragma mark TableView Delegate Datasource
//
//- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
//{
//    return 80.0f*kScreenRate;
//}
//
//- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
//{
//    return 1;
//}
//
//- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
//{
//    return (self.assets.count + 4) / 4.0f;
//}
//
//- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
//{
//    static NSString *cellIdentifier = @"cell";
//    static NSString *cellIdentifier1 = @"cell1";
//    HWPublishAlbumCell *cell = nil;
//    
//    if (indexPath.row == 0)
//    {
//        cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier1];
//    }
//    else
//    {
//        cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
//    }
//    
//    if (!cell)
//    {
//        if (indexPath.row == 0)
//        {
//            cell = [[HWPublishAlbumCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdentifier1];
//        }
//        else
//        {
//            cell = [[HWPublishAlbumCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdentifier];
//        }
//    }
//    cell.delegate = self;
//    
//    if (indexPath.row == 0)
//    {
//        
//        [cell setImage:self.assets withIndex:0];
//        if (camPreview == nil)
//        {
//            camPreview = cell.imgBtnOne;
//            [self updateCamera];
//        }
//    }
//    else
//    {
//        int index = 3 + (indexPath.row - 1) * 4;
//        [cell setImage:self.assets withIndex:index];
//    }
//    return cell;
//}

//#pragma mark -
//#pragma mark HWPublishAlbumCellDelegate
//
//- (void)didSelectTakePhoto
//{
//    // 打开相机
//    
//    [MobClick event:@"click_screen_photo"];
//    GKImagePickerController *imagePicker = [[GKImagePickerController alloc] init];
//    imagePicker.delegate = self;
//    UINavigationController *nav = [[UINavigationController alloc] initWithRootViewController:imagePicker];
//    [self presentViewController:nav animated:YES completion:nil];
//}
//
//- (void)didSelectAlbumPicture:(UIImage *)image
//{
//    [MobClick event:@"click_choose_photo"];
//    
//    HWCropImageViewController *imagePicker = [[HWCropImageViewController alloc] init];
//    imagePicker.delegate = self;
//    imagePicker.stillImage = image;
//    HWBaseNavigationController *nav = [[HWBaseNavigationController alloc] initWithRootViewController:imagePicker];
//    [nav setNavigationBarBlackColor];
//    [self presentViewController:nav animated:YES completion:nil];
//}

//#pragma mark -
//#pragma mark GKImagePickerControllerDelegate
//
//- (void)didFinishedSelectImage:(UIImage *)image
//{
//    [_albumGridTV reloadData];
//    _photoImgV.image = image;
//    _photoImgBackView.hidden = NO;
//}
//
//#pragma mark -
//#pragma mark HWCropImageViewControllerDelegate
//
//- (void)didCropImage:(UIImage *)image
//{
//    _photoImgV.image = image;
//    _photoImgBackView.hidden = NO;
//}

//- (void)updateCamera
//{
//    camManager = [GKCameraManager manager];
//    [camManager setup];
//    [camManager embedPreviewInView:camPreview];
//    
//    dispatch_async(dispatch_queue_create("loadCamera", DISPATCH_QUEUE_SERIAL), ^{
//        if (![camManager isRunning])
//        {
//            [camManager startRuning];
//        }
//    });
//    
//}


//- (void)initialAlbum
//{
//    if (_albumGridTV == nil)
//    {
//       // _albumGridTV = [[UITableView alloc] initWithFrame:CGRectMake(0, CGRectGetMaxY(_InPutBackView.frame), kScreenWidth, CONTENT_HEIGHT - CGRectGetMaxY(_InPutBackView.frame))];
//        _albumGridTV = [[UITableView alloc] initWithFrame:CGRectMake(0, CONTENT_HEIGHT, kScreenWidth, CONTENT_HEIGHT - CGRectGetMaxY(_InPutBackView.frame))];
//        _albumGridTV.backgroundColor = [UIColor whiteColor];
//        _albumGridTV.delegate = self;
//        _albumGridTV.dataSource = self;
//        _albumGridTV.separatorStyle = UITableViewCellSeparatorStyleNone;
//        _albumGridTV.alpha = 1.0f;
//        //    _albumGridTV.userInteractionEnabled = NO;
//        //[_upScrollView addSubview:_albumGridTV];
//        [self.view addSubview:_albumGridTV];
//    }
//    else{
//        _albumGridTV.frame = CGRectMake(0, CONTENT_HEIGHT, kScreenWidth, CONTENT_HEIGHT - CGRectGetMaxY(_InPutBackView.frame));}
//}

//- (void)dealloc
//{
//    [[NSNotificationCenter defaultCenter] removeObserver:self name:UIKeyboardWillShowNotification object:nil];
//    [[NSNotificationCenter defaultCenter] removeObserver:self name:UIKeyboardWillHideNotification object:nil];
//}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
