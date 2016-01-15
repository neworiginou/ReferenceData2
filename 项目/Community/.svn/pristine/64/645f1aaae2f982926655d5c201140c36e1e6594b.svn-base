//
//  HWDetailViewController.m
//  Community
//
//  Created by zhangxun on 14-9-1.
//  Copyright (c) 2014年 caijingpeng. All rights reserved.
//
//    修改人         日期          修改内容
//     张迅        2015.1.16   header部分修改
//      李中强     2015-01-20      修改发布按钮
//      李中强     2015-01-29      修改UI及评论显示

#import "HWDetailViewController.h"
#import "HWNeighbourDetailListItemClass.h"
#import "HWAudioManager.h"
#import "HWAudioPlayCenter.h"
#import "HWCoreDataManager.h"
#import "HWTagItemClass.h"
#import "AppDelegate.h"
#import "HWMarginView.h"
#import "HWClickZanViewController.h"
#import "HWTopicListViewController.h"

@interface HWDetailViewController ()
{
    UIControl *topCtrl;  // 滚动到顶部
}
@end

#define kTagLabelTag 888

#define kActionReport 134
#define kActionDelete 256

#define kAlertReport 145
#define kAlertDelete 278

#define kLikeHeight 85

@implementation HWDetailViewController
@synthesize detailPlayMode;
@synthesize delegate,animate;
@synthesize resourceType;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardShow:) name:UIKeyboardWillShowNotification object:nil];
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardHide:) name:UIKeyboardWillHideNotification object:nil];
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(textViewChangeForNoti:) name:UITextViewTextDidChangeNotification object:nil];
        
        animate = NO;
    }
    return self;
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    self.baseTableView.delegate = self;
    [self addAudioPlayNotification];
    
    topCtrl = [[UIControl alloc] initWithFrame:CGRectMake(60, 0, kScreenWidth - 120, 20)];
    topCtrl.backgroundColor = [UIColor clearColor];
    [topCtrl addTarget:self action:@selector(toTop:) forControlEvents:UIControlEventTouchUpInside];
    [self.navigationController.navigationBar addSubview:topCtrl];
}

- (void)viewWillDisappear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    if ([[HWAudioPlayCenter shareAudioPlayCenter] isPlaying])
    {
        [[HWAudioPlayCenter shareAudioPlayCenter] stop];
    }
    
    self.baseTableView.delegate = nil;
    [self removeAudioPlayNotification];
    [topCtrl removeFromSuperview];
}

- (id)initWithCardInfo:(HWNeighbourItemClass *)cardInfo index:(NSIndexPath *)index
{
    self = [super init];
    if (self) {
        _cardInfo = cardInfo;
        _cardIndex = index;
        _isPush = YES;
    }
    return self;
}

- (id)initWithCardId:(NSString *)cardId{
    self = [super init];
    if (self)
    {
        _isPush = NO;
        _cardId = cardId;
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    _commentAtId = nil;
    _commentAtStr = @"";
    
    if (self.animate)
    {
        self.view.alpha = 0.0f;
        
        AppDelegate *appDel = (AppDelegate *)[UIApplication sharedApplication].delegate;
        
        [UIView animateWithDuration:0.4f animations:^{
            self.view.alpha = 1.0f;
            
            if ([appDel.window viewWithTag:1001])
            {
                UIView *view = [appDel.window viewWithTag:1001];
                view.alpha = 0.0f;
            }
            
        }completion:^(BOOL finished) {
            
            
            if ([appDel.window viewWithTag:1001])
            {
                UIView *view = [appDel.window viewWithTag:1001];
                //            [UIView animateWithDuration:0.2f animations:^{
                //                view.alpha = 0.0f;
                //            }completion:^(BOOL finished) {
                [view removeFromSuperview];
                //            }];
            }
        }];
    }
    self.navigationItem.leftBarButtonItem = [Utility navLeftBackBtn:self action:@selector(backMethod)];
    if (self.chuanChuanMenCanNotHandle)
    {
        self.navigationItem.rightBarButtonItem = nil;
    }
    else
    {
        self.navigationItem.rightBarButtonItem = [Utility navWalletButton:self action:@selector(reportTopic)];
    }
    if ([_cardInfo.creater isEqualToString:[HWUserLogin currentUserLogin].userId])
    {
        self.navigationItem.rightBarButtonItem = nil;
    }
    self.navigationItem.titleView = [Utility navTitleView:@"动态详情"];
    
    _commentV = [[UIView alloc]initWithFrame:CGRectMake(0, CONTENT_HEIGHT - 46, kScreenWidth, 46)];
    _commentV.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:_commentV];
    
    UIView *lineV = [[UIView alloc]initWithFrame:CGRectMake(0, 0, kScreenWidth, 0.5)];
//    lineV.backgroundColor = [UIColor colorWithRed:221.0 / 255.0 green:221.0 / 255.0 blue:221.0 / 255.0 alpha:1];
    lineV.backgroundColor = THEME_COLOR_LINE;
    [_commentV addSubview:lineV];
    
    _commentButton = [UIButton buttonWithType:UIButtonTypeCustom];
    _commentButton.frame = CGRectMake(kScreenWidth - 67, 8, 50, 30);
    [_commentButton setBackgroundImage:[Utility imageWithColor:THEBUTTON_GREEN_NORMAL andSize:CGSizeMake(50, 30)] forState:UIControlStateNormal];
    [_commentButton setBackgroundImage:[Utility imageWithColor:THEBUTTON_GREEN_HIGHLIGHT andSize:CGSizeMake(50, 30)] forState:UIControlStateHighlighted];
    [_commentButton setBackgroundColor:THEBUTTON_GREEN_NORMAL];
    [_commentButton setTitle:@"发送" forState:UIControlStateNormal];
    [_commentButton setTitleColor:THEME_COLOR_CELLCOLOR forState:UIControlStateNormal];
    _commentButton.titleLabel.font = [UIFont fontWithName:FONTNAME size:16];
    _commentButton.userInteractionEnabled = NO;
    _commentButton.layer.cornerRadius = 5;
    _commentButton.layer.masksToBounds = YES;
    [_commentButton addTarget:self action:@selector(sendComment) forControlEvents:UIControlEventTouchUpInside];
    [_commentV addSubview:_commentButton];
    
    UIView *buttonLineView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, 0.5, 45)];
    buttonLineView.backgroundColor = [UIColor colorWithRed:221.0 / 255.0 green:221.0 / 255.0 blue:221.0 / 255.0 alpha:1];
    [_commentButton addSubview:buttonLineView];
    
    _commentTF = [[UITextView alloc]initWithFrame:CGRectMake(10, 8, kScreenWidth - 90, 32)];
//    _commentTF.backgroundColor = THEME_COLOR_TEXT;
    _commentTF.font = [UIFont fontWithName:FONTNAME size:THEME_FONT_SMALL];
    _commentTF.text = @"发表评论";
    _commentTF.textColor = [UIColor lightGrayColor];
    _commentTF.delegate = self;
    _commentTF.layer.cornerRadius = 5;
    _commentTF.layer.masksToBounds = YES;
    _commentTF.layer.borderWidth = 0.5f;
    _commentTF.layer.borderColor = THEME_COLOR_LINE.CGColor;
    [_commentV addSubview:_commentTF];
    
    _commentAtLabel = [[UILabel alloc] initWithFrame:CGRectMake(5, 3, 0, 26)];
    _commentAtLabel.backgroundColor = [UIColor clearColor];
    _commentAtLabel.font = [UIFont fontWithName:FONTNAME size:THEME_FONT_SMALL];
    _commentAtLabel.textColor = THEME_COLOR_SMOKE;
    _commentAtLabel.layer.cornerRadius = 5;
    _commentAtLabel.layer.masksToBounds = YES;
    [_commentTF addSubview:_commentAtLabel];
    
    if (self.chuanChuanMenCanNotHandle)
    {
        _commentV.hidden = YES;
        self.baseTableView.frame = CGRectMake(0, 0, kScreenWidth, CONTENT_HEIGHT);
    }
    else
    {
        self.baseTableView.frame = CGRectMake(0, 0, kScreenWidth, CONTENT_HEIGHT - _commentV.frame.size.height);
    }
    
    if (_isPush)
    {
        [self createHeader];
        [self queryListData];
    }
    else
    {
        [self queryHeader];
    }
    
    if (self.isShouldCommentTFBecomeFirstResponse)
    {
        [_commentTF becomeFirstResponder];
    }
}
- (void)toTop:(id)sender
{
    [self.baseTableView setContentOffset:CGPointMake(0, 0) animated:YES];
}
/**
 *	@brief	根据不同的标签创建头部
 *
 *	@return	N/A
 */
- (void)createHeader
{
    //创建标签
    if ([_cardInfo.isShowReport isEqualToString:@"1"]) {
        self.navigationItem.rightBarButtonItem = [Utility navWalletButton:self action:@selector(deleteTopic)];
    }
//    if (self.resourceType == detailResourceChannel && [_cardInfo.isShowReport isEqualToString:@"1"]) {
//        self.navigationItem.rightBarButtonItem = nil;
//    }
    
    _realHeaderView = [[UIView alloc]init];
    _realHeaderView.backgroundColor = [UIColor whiteColor];

    UIImageView *headIV = [[UIImageView alloc]initWithFrame:CGRectMake(10, 10, 32, 32)];
    headIV.clipsToBounds = YES;
    headIV.image =[UIImage imageNamed:@"head_1"];
    headIV.layer.cornerRadius = 16.0;
    //0不匿名
    if ([_cardInfo.anonymity isEqualToString:@"0"]) {
        NSURL *imageUrl = [NSURL URLWithString:[NSString stringWithFormat:@"%@/hw-sq-app-web/%@&key=%@",kUrlBase,_cardInfo.headUrl,[HWUserLogin currentUserLogin].key]];
        __weak UIImageView *blockImgV = headIV;
        [headIV setImageWithURL:imageUrl placeholderImage:[UIImage imageNamed:@"head_placeholder"] completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType) {
            
            if (error)
            {
                NSLog(@"Error : load image fail.");
                blockImgV.image = [UIImage imageNamed:@"head_placeholder"];
            }
            else
            {
                blockImgV.image = image;
                if (cacheType == 0)
                { // request url
                    CATransition *transition = [CATransition animation];
                    transition.duration = 1.0f;
                    transition.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut];
                    transition.type = kCATransitionFade;
                    [blockImgV.layer addAnimation:transition forKey:nil];
                }
            }
        }];
    }
    headIV.userInteractionEnabled = YES;
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(headImgClick)];
    [headIV addGestureRecognizer:tap];
    [_realHeaderView addSubview:headIV];
    
    
    
    UILabel *nameLabel = [[UILabel alloc]initWithFrame:CGRectMake(50, 12, kScreenWidth - 50, 17)];
    nameLabel.backgroundColor = [UIColor clearColor];
    nameLabel.font = [UIFont fontWithName:FONTNAME size:THEME_FONT_SMALL];
    nameLabel.textColor = THEME_COLOR_SMOKE;
    nameLabel.text = _cardInfo.author;
    if (_cardInfo.author.length == 0) {
        nameLabel.text = @"无名的考拉";
    }
    if ([_cardInfo.anonymity isEqualToString:@"1"]) {
        nameLabel.text = @"某人";
    }
    if ([_cardInfo.creater isEqualToString:@"1"]) {
        nameLabel.text = @"考拉君";
    }
    [_realHeaderView addSubview:nameLabel];
    
    
    UILabel *dateLabel = [[UILabel alloc]initWithFrame:CGRectMake(50, 35, kScreenWidth - 50, 10)];
    dateLabel.text = _cardInfo.createDate;
    dateLabel.font = [UIFont fontWithName:FONTNAME size:THEME_FONT_SMALL12];
    dateLabel.backgroundColor = [UIColor clearColor];
    dateLabel.textColor = THEME_COLOR_TEXT;
    [_realHeaderView addSubview:dateLabel];
    
//    UIView *lineV = [[UIView alloc]initWithFrame:CGRectMake(0, 51.5f, kScreenWidth, 0.5f)];
//    lineV.backgroundColor = THEME_COLOR_LINE;
//    [_realHeaderView addSubview:lineV];
    
    
    if ([_cardInfo.cardType intValue] == 0 || [_cardInfo.cardType intValue] == 23)
    {
        float height = 0.0;
        
        if (IOS7)
        {
            CGRect rect = [_cardInfo.content boundingRectWithSize:CGSizeMake(kScreenWidth - 15 * 2, 1000) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:THEME_FONT_BIG]} context:nil];
            height = rect.size.height;
        }
        else
        {
            CGSize size = [_cardInfo.content sizeWithFont:[UIFont fontWithName:FONTNAME size:THEME_FONT_BIG] constrainedToSize:CGSizeMake(kScreenWidth - 15 * 2, 1000) lineBreakMode:NSLineBreakByWordWrapping];
            height = size.height;
        }
        
        UIImageView *cardIV = [[UIImageView alloc]initWithFrame:CGRectMake(9, 52, kScreenWidth - 2 * 9, kDetailCardHeight)];
        cardIV.image = nil;
        NSURL *imageUrl = [NSURL URLWithString:[NSString stringWithFormat:@"%@/hw-sq-app-web/%@&key=%@",kUrlBase,_cardInfo.pictureURL,[HWUserLogin currentUserLogin].key]];
        __weak UIImageView *blockImgV = cardIV;
        [cardIV setImageWithURL:imageUrl placeholderImage:[UIImage imageNamed:IMAGE_PLACE] completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType) {
            
            if (error)
            {
                NSLog(@"Error : load image fail.");
                blockImgV.image = [UIImage imageNamed:IMAGE_BREAK_CUBE];
            }
            else
            {
                blockImgV.image = image;
                if (cacheType == 0)
                { // request url
                    CATransition *transition = [CATransition animation];
                    transition.duration = 1.0f;
                    transition.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut];
                    transition.type = kCATransitionFade;
                    [blockImgV.layer addAnimation:transition forKey:nil];
                }
            }
        }];
        [_realHeaderView addSubview:cardIV];
        
        UILabel *textLabel = [[UILabel alloc]initWithFrame:CGRectMake(15, cardIV.frame.size.height + 10 + 52.0, kScreenWidth - 30, height)];
        [_realHeaderView addSubview:textLabel];
        textLabel.numberOfLines = 0;
        textLabel.backgroundColor = [UIColor clearColor];
        textLabel.text = _cardInfo.content;
        textLabel.font = [UIFont fontWithName:FONTNAME size:THEME_FONT_BIG];
        textLabel.lineBreakMode = NSLineBreakByWordWrapping;
        [_realHeaderView addSubview:textLabel];
        
        height += 52 + kDetailCardHeight + 20 + kIntervalHeight;
        
        BOOL isMine = NO;
        if ([_cardInfo.userId isEqualToString:[HWUserLogin currentUserLogin].userId])
        {
            isMine = YES;
        }
        if (isMine || _cardInfo.channelName.length > 0)
        {
            _channelBtn = [[HWChannelButton alloc]init];
            
            if (isMine && _cardInfo.channelName.length == 0)
            {
                [_channelBtn setString:@"+添加话题"];
                [_channelBtn removeTarget:self action:@selector(showChannel) forControlEvents:UIControlEventTouchUpInside];
                [_channelBtn removeTarget:self action:@selector(addChannel) forControlEvents:UIControlEventTouchUpInside];
                [_channelBtn addTarget:self action:@selector(addChannel) forControlEvents:UIControlEventTouchUpInside];
            }
            else
            {
                [_channelBtn setString:_cardInfo.channelName];
                [_channelBtn removeTarget:self action:@selector(showChannel) forControlEvents:UIControlEventTouchUpInside];
                [_channelBtn removeTarget:self action:@selector(addChannel) forControlEvents:UIControlEventTouchUpInside];
                [_channelBtn addTarget:self action:@selector(showChannel) forControlEvents:UIControlEventTouchUpInside];
            }
            _channelBtn.frame = CGRectMake(kScreenWidth - 15 - _channelBtn.frame.size.width, 15, _channelBtn.frame.size.width,_channelBtn.frame.size.height);
            [_realHeaderView addSubview:_channelBtn];
        }
        _realHeaderView.frame = CGRectMake(0, 0, kScreenWidth, height);
    }
    else if ([_cardInfo.cardType intValue] == 1 || [_cardInfo.cardType intValue] == 24)
    {
        float height = 0.0;
        
        if (IOS7)
        {
            CGRect rect = [_cardInfo.content boundingRectWithSize:CGSizeMake(kScreenWidth - 15 * 2, 1000) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:THEME_FONT_BIG]} context:nil];
            height = rect.size.height;
        }
        else
        {
            CGSize size = [_cardInfo.content sizeWithFont:[UIFont fontWithName:FONTNAME size:THEME_FONT_BIG] constrainedToSize:CGSizeMake(kScreenWidth - 15 * 2, 1000) lineBreakMode:NSLineBreakByWordWrapping];
            height = size.height;
        }
        UILabel *textLabel = [[UILabel alloc]initWithFrame:CGRectMake(15, 52 + 10, kScreenWidth - 30, height)];
        [_realHeaderView addSubview:textLabel];
        
        height += 52 + 20 + kIntervalHeight;
        
        textLabel.numberOfLines = 0;
        textLabel.backgroundColor = [UIColor clearColor];
        textLabel.text = _cardInfo.content;
        textLabel.font = [UIFont fontWithName:FONTNAME size:THEME_FONT_BIG];
        textLabel.lineBreakMode = NSLineBreakByWordWrapping;
        [_realHeaderView addSubview:textLabel];
        
        
        BOOL isMine = NO;
        if ([_cardInfo.userId isEqualToString:[HWUserLogin currentUserLogin].userId]) {
            isMine = YES;
        }
        if (isMine || _cardInfo.channelName.length > 0)
        {
            _channelBtn = [[HWChannelButton alloc]init];
            textLabel.backgroundColor = [UIColor clearColor];
            
            if (isMine && _cardInfo.channelName.length == 0)
            {
                [_channelBtn setString:@"+添加话题"];
                [_channelBtn removeTarget:self action:@selector(showChannel) forControlEvents:UIControlEventTouchUpInside];
                [_channelBtn removeTarget:self action:@selector(addChannel) forControlEvents:UIControlEventTouchUpInside];
                [_channelBtn addTarget:self action:@selector(addChannel) forControlEvents:UIControlEventTouchUpInside];
            }
            else
            {
                [_channelBtn setString:_cardInfo.channelName];
                [_channelBtn removeTarget:self action:@selector(showChannel) forControlEvents:UIControlEventTouchUpInside];
                [_channelBtn removeTarget:self action:@selector(addChannel) forControlEvents:UIControlEventTouchUpInside];
                [_channelBtn addTarget:self action:@selector(showChannel) forControlEvents:UIControlEventTouchUpInside];
            }
            _channelBtn.frame = CGRectMake(kScreenWidth - 15 - _channelBtn.frame.size.width, 15, _channelBtn.frame.size.width,_channelBtn.frame.size.height);
            [_realHeaderView addSubview:_channelBtn];
        }
        
        _realHeaderView.frame = CGRectMake(0, 0, kScreenWidth, height);
    }
    else if ([_cardInfo.cardType intValue] == 2 || [_cardInfo.cardType intValue] == 25)
    {
        _realHeaderView.frame = CGRectMake(0, 0, kScreenWidth, 52 + 85 +kIntervalHeight);
        _playButton = [[HWSoundPlayButton alloc]initWithTitle:_cardInfo.soundTime isBig:YES];
        [_playButton setString:_cardInfo.soundTime];
        _playButton.center = CGPointMake(kScreenWidth / 2.0, 52 + 85 / 2.0f);
        [_playButton addTarget:self action:@selector(toPlay:) forControlEvents:UIControlEventTouchUpInside];
        [_realHeaderView addSubview:_playButton];
        
        if (detailPlayMode == DownloadingPlayMode)
        {
            _playButton.buttonStatus = buttonStatusStop;
        }
        else if (detailPlayMode == PlayingPlayMode)
        {
            _playButton.buttonStatus = buttonStatusPlay;
        }
        else if (detailPlayMode == PausePlayMode)
        {
            _playButton.buttonStatus = buttonStatusPause;
        }
        else if (detailPlayMode == StopPlayMode)
        {
            _playButton.buttonStatus = buttonStatusStop;
        }
        
        BOOL isMine = NO;
        if ([_cardInfo.userId isEqualToString:[HWUserLogin currentUserLogin].userId]) {
            isMine = YES;
        }
        if (isMine || _cardInfo.channelName.length > 0) {
            _channelBtn = [[HWChannelButton alloc]init];
            
            if (isMine && _cardInfo.channelName.length == 0)
            {
                [_channelBtn setString:@"+添加话题"];
                [_channelBtn removeTarget:self action:@selector(showChannel) forControlEvents:UIControlEventTouchUpInside];
                [_channelBtn removeTarget:self action:@selector(addChannel) forControlEvents:UIControlEventTouchUpInside];
                [_channelBtn addTarget:self action:@selector(addChannel) forControlEvents:UIControlEventTouchUpInside];
            }
            else
            {
                [_channelBtn setString:_cardInfo.channelName];
                [_channelBtn removeTarget:self action:@selector(showChannel) forControlEvents:UIControlEventTouchUpInside];
                [_channelBtn removeTarget:self action:@selector(addChannel) forControlEvents:UIControlEventTouchUpInside];
                [_channelBtn addTarget:self action:@selector(showChannel) forControlEvents:UIControlEventTouchUpInside];
            }
            _channelBtn.frame = CGRectMake(kScreenWidth - 15 - _channelBtn.frame.size.width, 15, _channelBtn.frame.size.width,_channelBtn.frame.size.height);
            [_realHeaderView addSubview:_channelBtn];
        }
        
    }
    else if ([_cardInfo.cardType intValue] == 4 || [_cardInfo.cardType intValue] == 7 || [_cardInfo.cardType intValue] == 8 || [_cardInfo.cardType intValue] == 26)
    {
        UIImageView *leftIV = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"leftMark"]];
        leftIV.frame = CGRectMake(10, 52 + 10, 15, 14);
        [_realHeaderView addSubview:leftIV];
        
        UIView *tipBackView = [[UIView alloc]initWithFrame:CGRectMake(leftIV.frame.origin.x + leftIV.frame.size.width + 5, leftIV.frame.size.width + leftIV.frame.origin.y - 10, kScreenWidth - 60, 45)];
        tipBackView.backgroundColor = UIColorFromRGB(0xf9f9f9);
        tipBackView.layer.cornerRadius = 5;
        [_realHeaderView addSubview:tipBackView];
        
        UIImageView *rightIV = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"rightMark"]];
        rightIV.frame = CGRectMake(kScreenWidth - 10 - 15, tipBackView.frame.size.height + tipBackView.frame.origin.y - 10, 15, 14);
        [_realHeaderView addSubview:rightIV];
        
        UILabel *tipLabel = [[UILabel alloc]init];
        tipLabel.numberOfLines = 2;
        tipLabel.backgroundColor = [UIColor clearColor];
        tipLabel.textColor = [UIColor grayColor];
        tipLabel.font = [UIFont fontWithName:FONTNAME size:THEME_FONT_SMALL12];
        tipLabel.frame = CGRectMake(10, 8, tipBackView.frame.size.width - 20, 29);
        tipLabel.text = _cardInfo.title;
        [tipBackView addSubview:tipLabel];
        
        float height = 0.0;
        
        if (IOS7)
        {
            CGRect rect = [_cardInfo.content boundingRectWithSize:CGSizeMake(kScreenWidth - 60, 1000) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:16]} context:nil];
            height = rect.size.height;
        }
        else
        {
            CGSize size = [_cardInfo.content sizeWithFont:[UIFont fontWithName:FONTNAME size:16] constrainedToSize:CGSizeMake(kScreenWidth - 60, 1000) lineBreakMode:NSLineBreakByWordWrapping];
            height = size.height;
        }
        
        UILabel *contentLabel = [[UILabel alloc]init];
        contentLabel.numberOfLines = 0;
        contentLabel.lineBreakMode = NSLineBreakByWordWrapping;
        contentLabel.backgroundColor = [UIColor clearColor];
        contentLabel.font = [UIFont fontWithName:FONTNAME size:THEME_FONT_BIG];
        contentLabel.frame = CGRectMake(30, rightIV.frame.size.height + rightIV.frame.origin.y + 10, kScreenWidth - 60, height);
        contentLabel.text = _cardInfo.content;
//        CGSize size = [contentLabel.text sizeWithFont:contentLabel.font constrainedToSize:CGSizeMake(kScreenWidth - 20, 100) lineBreakMode:NSLineBreakByWordWrapping];
        
        [_realHeaderView addSubview:contentLabel];
        
        _realHeaderView.frame = CGRectMake(0, 0, kScreenWidth, contentLabel.frame.origin.y + contentLabel.frame.size.height + kIntervalHeight + 10);
    }
//    NSLog(@"headview = %f",_realHeaderView.frame.size.height);

    _realHeaderView.frame = CGRectMake(0, 0, kScreenWidth, _realHeaderView.frame.size.height + 90);
    
    HWMarginView *marginV = [[HWMarginView alloc]initWithFrame:CGRectMake(0, _realHeaderView.frame.size.height - 100, kScreenWidth, 10.0f)];
    [_realHeaderView addSubview:marginV];
    
    //add by lzq  点赞
    if (!praise) {
        praise = [[HWPraiseView alloc] initWithFrame:CGRectMake(0, _realHeaderView.frame.size.height - 90, kScreenWidth, 90)];
    }
    [praise setBackgroundColor:[UIColor whiteColor]];
    praise.item = _cardInfo;
    praise.chuanChuanMenCanNotHandle = self.chuanChuanMenCanNotHandle;
    praise.detailType = resourceType;
    if ([_cardInfo.viewRange isEqualToString:@"2"])
    {
        praise.siftLabel.text = @"全国";
        praise.siftLabel.hidden = NO;
        praise.selectBtn.hidden = NO;
        praise.siftArrowImg.hidden = NO;
    }
    else if ([_cardInfo.viewRange isEqualToString:@"1"])
    {
        praise.siftLabel.text = @"同城";
        praise.siftLabel.hidden = NO;
        praise.selectBtn.hidden = NO;
        praise.siftArrowImg.hidden = NO;
    }
    else
    {
        praise.siftLabel.text = @"附近";
        praise.siftLabel.hidden = YES;
        praise.selectBtn.hidden = YES;
        praise.siftArrowImg.hidden = YES;
    }
    selectViewRangeStr = @"0";
    praise.delegate = self;
    [_realHeaderView addSubview:praise];
    _realHeaderView.userInteractionEnabled = YES;
    self.baseTableView.tableHeaderView = _realHeaderView;
    self.baseTableView.tableHeaderView.userInteractionEnabled = YES;
}

- (void)headImgClick
{
    /*nameLabel.text = _cardInfo.author;
     if (_cardInfo.author.length == 0) {
     nameLabel.text = @"无名的考拉";
     }
     if ([_cardInfo.anonymity isEqualToString:@"1"]) {
     nameLabel.text = @"某人";
     }
     if ([_cardInfo.creater isEqualToString:@"1"]) {
     nameLabel.text = @"考拉君";
     }*/
    if (self.personalVC != nil)
    {
        [self.navigationController popToViewController:self.personalVC animated:YES];
    }
    else
    {
        if ([_cardInfo.anonymity isEqualToString:@"1"])
        {
            if ([self.delegate isKindOfClass:[UIView class]])
            {
                UIView *view = (UIView *)self.delegate;
                [Utility showToastWithMessage:@"此用户闭关中，看看别的邻居吧~" inView:view];
            }
        }
        else
        {
            HWPersonalHomePageVC *homeVc = [[HWPersonalHomePageVC alloc] init];
            homeVc.userId = _cardInfo.creater;
            [self.navigationController pushViewController:homeVc animated:YES];
        }
    }
}


#pragma mark - HWPraiseViewDelegate
- (void)praiseBefore
{
    [self queryHeader];
}

- (void)changeLike:(NSDictionary *)dict
{
    if (self.delegate && [self.delegate respondsToSelector:@selector(changeLike:)])
    {
        [self.delegate changeLike:dict];
    }
}

/**
 *	@brief	添加筛选视图
 *
 *	@return
 */
- (void)siftClick
{
    NSArray *arrayRange;
    if ([_cardInfo.viewRange isEqualToString:@"2"])
    {
        arrayRange = @[@"全国",@"同城",@"附近"];
    }
    else if ([_cardInfo.viewRange isEqualToString:@"1"])
    {
        arrayRange = @[@"同城",@"附近"];
    }
//    else
//    {
//        arrayRange = @[@"周边",@"test1",@"test2"];
//    }
    float headHeight = _realHeaderView.frame.size.height;
    float tableScrollHeight = self.baseTableView.contentOffset.y;

    //判断head高度  移动的高度
    
    if (IPHONE4) {
        if (headHeight > CONTENT_HEIGHT - 135) {
            if (headHeight - tableScrollHeight < CONTENT_HEIGHT - 165)
            {
                [self unMoveWithTableHeight:tableScrollHeight tableHeadHeight:headHeight siftArray:arrayRange];
            }
            else
            {
                [self canMoveWithTableHeight:tableScrollHeight tableHeadHeight:headHeight siftArray:arrayRange];
            }
        }
        else
        {
            [self unMoveWithTableHeight:tableScrollHeight tableHeadHeight:headHeight siftArray:arrayRange];
        }
    }
    else if (IPHONE5)
    {
        if (headHeight > CONTENT_HEIGHT - 135) {
            if (headHeight - tableScrollHeight < CONTENT_HEIGHT - 156)
            {
                [self unMoveWithTableHeight:tableScrollHeight tableHeadHeight:headHeight siftArray:arrayRange];
            }
            else
            {
                [self canMoveWithTableHeight:tableScrollHeight tableHeadHeight:headHeight siftArray:arrayRange];
            }
        }
        else
        {
            [self unMoveWithTableHeight:tableScrollHeight tableHeadHeight:headHeight siftArray:arrayRange];
        }
    }
    else if (IPHONE6)
    {
        if (headHeight > CONTENT_HEIGHT - 135) {
            if (headHeight - tableScrollHeight < CONTENT_HEIGHT - 180)
            {
                [self unMoveWithTableHeight:tableScrollHeight tableHeadHeight:headHeight siftArray:arrayRange];
            }
            else
            {
                [self canMoveWithTableHeight:tableScrollHeight tableHeadHeight:headHeight siftArray:arrayRange];
            }
        }
        else
        {
            [self unMoveWithTableHeight:tableScrollHeight tableHeadHeight:headHeight siftArray:arrayRange];
        }
    }
    else if (IPHONE6PLUS)
    {
        
        if (headHeight > CONTENT_HEIGHT - 180) {
            if (headHeight - tableScrollHeight < CONTENT_HEIGHT - 200)
            {
                [self unMoveWithTableHeight:tableScrollHeight tableHeadHeight:headHeight siftArray:arrayRange];
            }
            else
            {
                [self canMoveWithTableHeight:tableScrollHeight tableHeadHeight:headHeight siftArray:arrayRange];
            }
        }
        else
        {
            [self unMoveWithTableHeight:tableScrollHeight tableHeadHeight:headHeight siftArray:arrayRange];
        }
        
    }
    
    praise.siftArrowImg.transform = CGAffineTransformRotate(praise.siftArrowImg.transform, M_PI);
}

- (void)canMoveWithTableHeight:(float)tableScrollHeight tableHeadHeight:(float)headHeight siftArray:(NSArray *)arrayRange
{
    float height = 0;
    if (IPHONE6PLUS || IPHONE6)
    {
        height = 100;
    }
    else if (IPHONE5)
    {
        height = 140;
    }
    else if (IPHONE4)
    {
        height = 130;
    }
    [self.baseTableView setContentOffset:CGPointMake(0, tableScrollHeight + height) animated:YES];
    HWCustomSiftView *siftView = [[HWCustomSiftView alloc] initWithTitle:arrayRange andBtnFrame:CGRectMake(kScreenWidth - 85, (headHeight - tableScrollHeight - height - 40) / kScreenRate, 70, 30)];
    siftView.delegate = self;
    __block HWPraiseView *blockPraise = praise;
    [siftView setSelectedInfo:^(NSString *title) {
        NSLog(@"title = %@",title);
        blockPraise.siftLabel.text = title;
        selectViewRangeStr = title;
        blockPraise.siftArrowImg.transform = CGAffineTransformRotate(blockPraise.siftArrowImg.transform, M_PI);
        _currentPage = 0;
        [self queryListData];
    }];
    [self.view.window addSubview:siftView];
}

- (void)unMoveWithTableHeight:(float)tableScrollHeight tableHeadHeight:(float)headHeight siftArray:(NSArray *)arrayRange
{
    HWCustomSiftView *siftView = [[HWCustomSiftView alloc] initWithTitle:arrayRange andBtnFrame:CGRectMake(kScreenWidth - 85, (headHeight - tableScrollHeight - 40) / kScreenRate, 70, 30)];
    siftView.delegate = self;
    //        [siftView setBackImageView:nil];
    __block HWPraiseView *blockPraise = praise;
    [siftView setSelectedInfo:^(NSString *title) {
        NSLog(@"title = %@",title);
        blockPraise.siftLabel.text = title;
        selectViewRangeStr = title;
        blockPraise.siftArrowImg.transform = CGAffineTransformRotate(blockPraise.siftArrowImg.transform, M_PI);
        _currentPage = 0;
        [self queryListData];
    }];
    [self.view.window addSubview:siftView];
}

- (void)arrowClick
{
    [MobClick event:@"click_zantongderen"]; //maidian_1.2.1 MYP add
    
    HWClickZanViewController *praiseVC = [[HWClickZanViewController alloc] init];
    praiseVC.topicId = _cardInfo.cardID;
    [self.navigationController pushViewController:praiseVC animated:YES];
}

#pragma mark - siftview delegate
- (void)hideSiftView
{
    praise.siftArrowImg.transform = CGAffineTransformRotate(praise.siftArrowImg.transform, M_PI);
}


#pragma mark - tableview delegate
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.dataList.count;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    HWNeighbourDetailListItemClass *detailClass = [dataList objectAtIndex:indexPath.row];
    
    return [HWNeighbourDetailCell getCellHeight:detailClass];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *cellIdentifier = @"cell";
    HWNeighbourDetailListItemClass *detailClass = [dataList objectAtIndex:indexPath.row];
//    HWNeighbourDetailCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
//    if (!cell) {
//        cell = [[HWNeighbourDetailCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdentifier];
//        
////        UILongPressGestureRecognizer *longPressGes = [[UILongPressGestureRecognizer alloc]initWithTarget:self action:@selector(longPress:)];
////        [cell addGestureRecognizer:longPressGes];
////        cell.delegare = self;
//        
//    }
    
    HWNeighbourDetailCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    if (!cell) {
        if ([[HWUserLogin currentUserLogin].userId isEqualToString:detailClass.userId])
            cell = [[HWNeighbourDetailCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdentifier containingTableView:self.baseTableView leftUtilityButtons:nil rightUtilityButtons:[self rightButtonsDelete]];
        else
            cell = [[HWNeighbourDetailCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdentifier containingTableView:self.baseTableView leftUtilityButtons:nil rightUtilityButtons:[self rightButtonsReport]];
    }
    
    if ([[HWUserLogin currentUserLogin].userId isEqualToString:detailClass.userId])
        [cell setRightUtilityButtons:[self rightButtonsDelete]];
    else
        [cell setRightUtilityButtons:[self rightButtonsReport]];
    
    
    cell.delegate = self;
    [cell rebuildWithInfo:detailClass];
    
    [cell setCellHeight:[HWNeighbourDetailCell getCellHeight:detailClass]];
    
    if (indexPath.row == dataList.count - 1) {
        [cell setFinalLine];
    }
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    [cell hideUtilityButtonsAnimated:YES];
    return cell;
}



- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (self.chuanChuanMenCanNotHandle)
    {
        return;
    }
    
    [MobClick event:@"click_pinglunliebiaodianduidian"]; //maidian_1.2.1
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    HWNeighbourDetailListItemClass *detailClass = [dataList objectAtIndex:indexPath.row];
    
    [_commentTF becomeFirstResponder];
    [self.baseTableView scrollToRowAtIndexPath:indexPath atScrollPosition:UITableViewScrollPositionBottom animated:YES];
    
    if (![detailClass.userId isEqualToString:[HWUserLogin currentUserLogin].userId])
    {
        NSString *oldString = [[NSString alloc] init];
        if (_commentTF.text.length > _commentAtStr.length)
        {
            oldString = [[_commentTF.text substringFromIndex:_commentAtStr.length] substringToIndex:_commentTF.text.length - _commentAtStr.length];
        }
        
        _commentAtLabel.text = nil;
        _commentAtLabel.text = [NSString stringWithFormat:@"@%@ ",detailClass.nickName];
        CGSize size = [Utility calculateStringWidth:_commentAtLabel.text font:_commentAtLabel.font constrainedSize:CGSizeMake(CGFLOAT_MAX, 26)];
        _commentAtLabel.frame = CGRectMake(5, 3, size.width, 26);
        
        CGSize sizeEmpty = [Utility calculateStringWidth:@" " font:_commentAtLabel.font constrainedSize:CGSizeMake(CGFLOAT_MAX, 26)];
        NSUInteger num = size.width / sizeEmpty.width;
        NSMutableString *string = [[NSMutableString alloc] init];
        for (int i = 0; i < num; i ++)
        {
            [string appendString:@" "];
        }
        //    NSLog(@"string = %@  length = %d",string,string.length);
        _commentTF.text = [NSString stringWithFormat:@"%@%@",string,oldString];
        _commentAtStr = string;
        _commentAtId = detailClass.userId;
    }
    
}

/**
 *	@brief	进入话题页面
 *
 *	@return	N/A
 */
- (void)showChannel
{
    if (self.resourceType != detailResourceNeighbour ) {
        [self.navigationController popViewControllerAnimated:YES];
        return;
    }
    
    HWTopicListViewController *topicList = [[HWTopicListViewController alloc]init];
    HWChannelModel *channelModel = [[HWChannelModel alloc]init];
    channelModel.channelId = _cardInfo.channelId;
    channelModel.channelIcon = nil;
    channelModel.channelName = _cardInfo.channelName;
    topicList.channelModel = channelModel;
    [self.navigationController pushViewController:topicList animated:YES];
}

/**
 *	@brief	添加频道
 *
 *	@return	N/A
 */
- (void)addChannel

{
    HWAddChannelViewController *addVC = [[HWAddChannelViewController alloc]init];
    addVC.delegate = self;
    [self.navigationController pushViewController:addVC animated:YES];
}

- (void)didSelectChannel:(HWChannelModel *)model
{
    NSMutableDictionary *dict = [NSMutableDictionary dictionary];
    [dict setObject:_cardInfo.cardID forKey:@"topicId"];
    [dict setObject:[HWUserLogin currentUserLogin].userId forKey:@"userId"];
    [dict setObject:model.channelId forKey:@"channelId"];
    [dict setObject:[HWUserLogin currentUserLogin].key forKey:@"key"];
    HWHTTPRequestOperationManager *managr = [HWHTTPRequestOperationManager manager];
    [managr POSTAudio:kChangeChannel parameters:dict queue:nil success:^(id responseObject)
     {
         
         if ([self.delegate respondsToSelector:@selector(setChannel:)])
         {
             [self.delegate setChannel:model];
         }
         [self queryHeader];
     } failure:^(NSString *error)
     {
         
     }];
}

/*
- (void)longPress:(UILongPressGestureRecognizer *)recognizer
{
    [MobClick event:@"longpress_comment"];
    if (recognizer.state == UIGestureRecognizerStateBegan) {
        CGPoint location = [recognizer locationInView:self.baseTableView];
        NSIndexPath *indexPath = [self.baseTableView indexPathForRowAtPoint:location];
        _longPressIndex = indexPath;
        UITableViewCell *cell = [self.baseTableView cellForRowAtIndexPath:indexPath];
        [cell becomeFirstResponder];
        UIMenuItem *itCopy = [[UIMenuItem alloc] initWithTitle:@"复制" action:@selector(doCopy:)];
        UIMenuItem *itReport = [[UIMenuItem alloc] initWithTitle:@"举报" action:@selector(startReport:)];
        UIMenuController *menu = [UIMenuController sharedMenuController];
        NSMutableArray *array = [NSMutableArray array];
        [array addObject:itCopy];
        [array addObject:itReport];
        [menu setMenuItems:array];
        [menu setTargetRect:recognizer.view.frame inView:baseTableView];
        [menu setMenuVisible:YES animated:YES];
    }
}
 */
#pragma mark - swtablecell
- (NSArray *)rightButtonsDelete
{
    NSMutableArray *rightUtilityButtons = [NSMutableArray new];
    [rightUtilityButtons sw_addUtilityButtonWithColor:
     [UIColor colorWithRed:1.0f green:0.231f blue:0.188 alpha:1.0f]
                                                title:@"删除"];
    
    return rightUtilityButtons;
}

- (NSArray *)rightButtonsReport
{
    NSMutableArray *rightUtilityButtons = [NSMutableArray new];
    [rightUtilityButtons sw_addUtilityButtonWithColor:UIColorFromRGB(0x858585) title:@"举报"];
    return rightUtilityButtons;
}

- (BOOL)swipeableTableViewCellShouldHideUtilityButtonsOnSwipe:(SWTableViewCell *)cell
{
    return YES;
}

- (void)swipeableTableViewCell:(SWTableViewCell *)cell didTriggerRightUtilityButtonWithIndex:(NSInteger)index
{
    [MobClick event:@"click_zuohuapinglun"]; //maidian_1.2.1
    //根据index和datalist判断出是删除还是举报
    //index  按钮的第几个   cell
    NSIndexPath *cellIndexPath = [self.baseTableView indexPathForCell:cell];
    currentCellIndexPath = cellIndexPath;
    
    HWNeighbourDetailListItemClass *detailClass = [dataList objectAtIndex:cellIndexPath.row];
    if ([[HWUserLogin currentUserLogin].userId isEqualToString:detailClass.userId])
    {
        replyIdDelete = detailClass.replyId;
        
        //删除
        UIAlertView *alert = [[UIAlertView alloc]initWithTitle:nil message:@"确认删除?" delegate:self cancelButtonTitle:@"取消" otherButtonTitles:@"确认", nil];
        alert.tag = kAlertDelete + 1000;
        [alert performSelectorOnMainThread:@selector(show) withObject:nil waitUntilDone:YES];
    }
    else
    {
        reportReplyId = detailClass.replyId;
        //举报
        UIAlertView *alert = [[UIAlertView alloc]initWithTitle:nil message:@"确认举报?" delegate:self cancelButtonTitle:@"取消" otherButtonTitles:@"确认", nil];
        alert.tag = kAlertReport + 1000;
        [alert performSelectorOnMainThread:@selector(show) withObject:nil waitUntilDone:YES];
    }
    
//    [cell hideUtilityButtonsAnimated:YES];
}

#pragma mark - HWNeighbourDetailCellDelegate
- (void)pasteSucceed{
    [Utility showToastWithMessage:@"已复制" inView:self.view];
}

- (void)reportWithReplyId:(NSString *)replyId
{
    _reportId = replyId;
    _reportType = @"1";
    [self doReport];
}
#pragma mark -
#pragma mark Audio Method

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

- (void)downloadAudioFinish:(NSNotification *)notification
{
    [self toPlay:nil];
}

- (void)downloadAudioFailed:(NSNotification *)notification
{
    detailPlayMode = StopPlayMode;
    [self createHeader];
    
    [Utility showToastWithMessage:@"播放失败" inView:self.view];
}

- (void)startPlayNotification:(NSNotification *)notification
{
    detailPlayMode = PlayingPlayMode;
    [self createHeader];
}

- (void)pausePlayNotification:(NSNotification *)notification
{
    detailPlayMode = StopPlayMode;
    [self createHeader];
}

- (void)stopPlayNotification:(NSNotification *)notification
{
    detailPlayMode = StopPlayMode;
    [self createHeader];
}

- (void)downloadingAudio:(NSNotification *)notification
{
    detailPlayMode = DownloadingPlayMode;
    [self createHeader];
}

- (void)toPlay:(id)sender
{
    HWAudioManager *customerAudio = [HWAudioManager shareAudioManager];
    [customerAudio playAudioUrl:[NSURL URLWithString:[NSString stringWithFormat:@"%@/hw-sq-app-web/%@&key=%@",kUrlBase ,_cardInfo.audioURL, [HWUserLogin currentUserLogin].key]] forIndexPath:nil];
}

#pragma mark -

////***** 本页面复制+举报 +删除*****
- (void)doCopy:(id)sender{
    [MobClick event:@"click_copy"];
    UIPasteboard *pasteboard = [UIPasteboard generalPasteboard];
    [pasteboard setString:((HWNeighbourDetailListItemClass *)(dataList[_longPressIndex.row])).content];
    [Utility showToastWithMessage:@"已复制" inView:self.view];
}

- (void)startReport:(id)sender{
    [MobClick event:@"click_expose_comment"];
    _reportId = ((HWNeighbourDetailListItemClass *)(dataList[_longPressIndex.row])).replyId;
    _reportType = @"1";
    [self doReport];
}

////***** 本页面复制+举报 *****

/**
 *	@brief	举报话题
 *
 *	@return	N/A
 */
- (void)reportTopic
{
    [MobClick event:@"click_more"];
    _reportId = _cardInfo.cardID;
    _reportType = @"0";
    [self doReport];
}

/**
 *	@brief	删除话题
 *
 *	@return	N/A
 */
- (void)deleteTopic

{
    [MobClick event:@"click_more"];
    _deleteId = _cardInfo.cardID;
    _deleteType = @"0";
    [self doDelete];
}

- (void)doReport
{
    UIActionSheet *act = [[UIActionSheet alloc]initWithTitle:nil delegate:self cancelButtonTitle:@"取消" destructiveButtonTitle:nil otherButtonTitles:@"举报", nil];
    act.tag = kActionReport;
    act.delegate = self;
    [act showInView:self.view];
}

- (void)doDelete
{
//    if (self.resourceType != detailResourceNeighbour) {
//        return;
//    }
    UIActionSheet *act = [[UIActionSheet alloc]initWithTitle:nil delegate:self cancelButtonTitle:@"取消" destructiveButtonTitle:nil otherButtonTitles:@"删除", nil];
    act.tag = kActionDelete;
    act.delegate = self;
    [act showInView:self.view];
}

- (void)actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex{
    if (actionSheet.tag == kActionReport) {
        if (buttonIndex == 0) {
            
            [MobClick event:@"click_expose"];
            
            
            UIAlertView *alert = [[UIAlertView alloc]initWithTitle:nil message:@"确认举报?" delegate:self cancelButtonTitle:@"取消" otherButtonTitles:@"确认", nil];
            alert.tag = kAlertReport;
            [alert performSelectorOnMainThread:@selector(show) withObject:nil waitUntilDone:YES];
        }
    }else{
        if (buttonIndex == 0) {
            UIAlertView *alert = [[UIAlertView alloc]initWithTitle:nil message:@"确认删除?" delegate:self cancelButtonTitle:@"取消" otherButtonTitles:@"确认", nil];
            alert.tag = kAlertDelete;
            [alert performSelectorOnMainThread:@selector(show) withObject:nil waitUntilDone:YES];
        }
    }
}

- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    //主题举报 删除
    if (alertView.tag == kAlertReport && buttonIndex == 1) {
        HWHTTPRequestOperationManager *manager = [HWHTTPRequestOperationManager manager];
        NSMutableDictionary *param = [NSMutableDictionary dictionary];
        [param setPObject:[HWUserLogin currentUserLogin].key forKey:@"key"];
        [param setPObject:_reportId forKey:@"commentId"];
        [param setPObject:_reportType forKey:@"type"];
        
        [manager POST:kReport parameters:param queue:nil success:^(id responObject) {
//            NSLog(@"%@",responObject);
            [Utility showToastWithMessage:@"举报成功" inView:self.view];
        } failure:^(NSString *code, NSString *error) {
            [Utility showToastWithMessage:error inView:self.view];
        }];
    }
    if (alertView.tag == kAlertDelete && buttonIndex == 1) {
        HWHTTPRequestOperationManager *manager = [HWHTTPRequestOperationManager manager];
        NSMutableDictionary *param = [NSMutableDictionary dictionary];
        [param setPObject:[HWUserLogin currentUserLogin].key forKey:@"key"];
        [param setPObject:_deleteId forKey:@"topicId"];
        [param setPObject:_deleteType forKey:@"type"];
        
        [manager POST:kDelete parameters:param queue:nil success:^(id responObject) {
            [[NSNotificationCenter defaultCenter]postNotificationName:HWNeighbourDragRefresh object:nil];
            if ([self.delegate respondsToSelector:@selector(deleteCardWithCardIndex:)]) {
                [self.delegate deleteCardWithCardIndex:_cardIndex];
                
            }
            [self.navigationController popViewControllerAnimated:YES];
            
        } failure:^(NSString *code, NSString *error) {
            
            [Utility showToastWithMessage:error inView:self.view];
        }];
    }
    
    //评论删除 举报
    if (alertView.tag == kAlertDelete + 1000)
    {
        if (buttonIndex == 1)
        {
            [Utility showMBProgress:self.view message:@"删除中..."];
            HWHTTPRequestOperationManager *manager = [HWHTTPRequestOperationManager manager];
            NSMutableDictionary *param = [NSMutableDictionary dictionary];
            [param setPObject:replyIdDelete forKey:@"replyId"];
            [param setPObject:[HWUserLogin currentUserLogin].key forKey:@"key"];
            [manager POST:kDeleteReply parameters:param queue:nil success:^(id responese) {
                [Utility hideMBProgress:self.view];
                [self queryListData];
                _cardInfo.commentCount = [NSString stringWithFormat:@"%d",[_cardInfo.commentCount intValue] - 1];
                praise.commentLabel.text = [NSString stringWithFormat:@"%@条评论",_cardInfo.commentCount];
                NSDictionary *commentDic = [NSDictionary dictionaryWithObject:_cardInfo.commentCount forKey:@"commentCount"];
                if (resourceType == detailResourceNeighbour)
                {
                    if (self.delegate && [self.delegate respondsToSelector:@selector(changeComment:)])
                    {
                        [self.delegate changeComment:commentDic];
                    }
                }
                else if (resourceType == detailResourceChannel)
                {
                    if (self.delegate && [self.delegate respondsToSelector:@selector(changeComment:)])
                    {
                        [self.delegate changeComment:commentDic];
                    }
                }
                
            } failure:^(NSString *code, NSString *error) {
                [Utility hideMBProgress:self.view];
                [Utility showToastWithMessage:error inView:self.view];
            }];
        }
        
        HWNeighbourDetailCell *cell = (HWNeighbourDetailCell *)[self.baseTableView cellForRowAtIndexPath:currentCellIndexPath];
        [cell hideUtilityButtonsAnimated:YES];
    }
    
    if (alertView.tag == kAlertReport + 1000)
    {
        if (buttonIndex == 1)
        {
            [Utility showMBProgress:self.view message:@"正在举报..."];
            HWHTTPRequestOperationManager *manager = [HWHTTPRequestOperationManager manager];
            NSMutableDictionary *param = [NSMutableDictionary dictionary];
            [param setPObject:[HWUserLogin currentUserLogin].key forKey:@"key"];
            [param setPObject:reportReplyId forKey:@"commentId"];
            [param setPObject:@"1" forKey:@"type"];
            
            [manager POST:kReport parameters:param queue:nil success:^(id responese) {
                [Utility hideMBProgress:self.view];
                [Utility showToastWithMessage:@"举报成功" inView:self.view];
            } failure:^(NSString *code, NSString *error) {
                [Utility hideMBProgress:self.view];
                [Utility showToastWithMessage:error inView:self.view];
            }];
        }
        
        HWNeighbourDetailCell *cell = (HWNeighbourDetailCell *)[self.baseTableView cellForRowAtIndexPath:currentCellIndexPath];
        [cell hideUtilityButtonsAnimated:YES];
    }
    
    
}

- (BOOL)canBecomeFirstResponder{
    return YES;
}

- (BOOL)tableView:(UITableView *)tableView shouldShowMenuForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    return _isAllowCopy;
}

- (BOOL)canPerformAction:(SEL)action withSender:(id)sender
{
    if (action == @selector(doCopy:) || action == @selector(startReport:)) {
        return _isAllowCopy;
    }
    return NO;
}

- (void)beginEdit{
    [MobClick event:@"click_comment"];
    [_commentTF becomeFirstResponder];
}
#pragma mark - keyboard notification
- (void)keyboardShow:(NSNotification *)noti
{
    float interval = [[noti.userInfo objectForKey:UIKeyboardAnimationDurationUserInfoKey]floatValue];
    float height = [[noti.userInfo objectForKey:UIKeyboardFrameEndUserInfoKey]CGRectValue].size.height;
    [UIView animateWithDuration:interval animations:^{
        baseTableView.frame = CGRectMake(0, 0, kScreenWidth, CONTENT_HEIGHT - height - _commentV.frame.size.height);
        _commentV.frame = CGRectMake(0, CONTENT_HEIGHT - _commentV.frame.size.height - height, kScreenWidth, _commentV.frame.size.height);
//        _commentTF.frame = CGRectMake(_commentTF.frame.origin.x, _commentTF.frame.origin.y, kScreenWidth - 80, 45);
        if (!_coverView) {
            _coverView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, kScreenWidth, CONTENT_HEIGHT - height - _commentV.frame.size.height - 10)];
//            [self.view insertSubview:_coverView atIndex:0];
            [self.view addSubview:_coverView];
            [self.view bringSubviewToFront:_coverView];
            UIPanGestureRecognizer *panges = [[UIPanGestureRecognizer alloc]initWithTarget:self action:@selector(resignResponder:)];
            panges.delegate = self;
            [_coverView addGestureRecognizer:panges];
            UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(resignResponder:)];
            tap.delegate = self;
            [_coverView addGestureRecognizer:tap];
        }
        _coverView.frame = CGRectMake(0, 0, kScreenWidth, CONTENT_HEIGHT - height - _commentV.frame.size.height - 10);
    } completion:^(BOOL finished) {
//        [baseTableView setContentOffset:CGPointMake(0, (baseTableView.contentSize.height - baseTableView.bounds.size.height) < 0 ? 0 :(baseTableView.contentSize.height - baseTableView.bounds.size.height)) animated:YES];
    }];
}

- (void)keyboardHide:(NSNotification *)noti
{
    [_coverView removeFromSuperview];
    
    [UIView animateWithDuration:[noti.userInfo[UIKeyboardAnimationDurationUserInfoKey]floatValue] animations:^{
        baseTableView.frame = CGRectMake(0, 0, kScreenWidth, CONTENT_HEIGHT - _commentV.frame.size.height);
//        _commentV.frame = CGRectMake(0, CONTENT_HEIGHT - _commentV.frame.size.height, kScreenWidth - 10, 45.5);
        _commentV.frame = CGRectMake(0, CONTENT_HEIGHT - _commentV.frame.size.height, kScreenWidth, 46);
//        _commentTF.frame = CGRectMake(_commentTF.frame.origin.x, _commentTF.frame.origin.y, kScreenWidth - 10, 45);
    }];
}

#pragma mark - 发表评论
- (void)sendComment
{
    [MobClick event:@"click_send_comment"];
    
    if ([[HWUserLogin currentUserLogin].coStatus isEqualToString:@"1"])
    {
        if ([HWUserLogin currentUserLogin].telephoneNum.length <= 0)
        {
            if ([HWUserLogin verifyBindMobileWithPopVC:self showAlert:YES])
            {
                if ([HWUserLogin verifyIsLoginWithPresentVC:self toViewController:nil])
                {
                    
                }
            }
            return;
        }
    }
    
    if (_commentTF.text.length == 0)
    {
        [Utility showToastWithMessage:@"写点内容再发吧~" inView:self.view];
        return;
    }
    
    //剔除加的空格
    NSString *strComment = _commentTF.text;
    NSString *currentString = [[NSString alloc] init];
    //@人时 _commentTF里加的有对应长度的空格
    if (_commentTF.text.length > _commentAtStr.length)
    {
        //目的 截取从@人之后的长度
        currentString = [_commentTF.text substringFromIndex:_commentAtStr.length];
    }
    
    //产品要求 多个空格只保留一个 多个换行只保留一个
    //去掉重复的空格
    NSArray *arrayHaveEmpty = [currentString componentsSeparatedByString:@"  "];
    NSString *strHaveEmpty = [[NSString alloc] init];
    BOOL isEmpty = NO;
    for (int i = 0; i < arrayHaveEmpty.count; i ++)
    {
        if ([arrayHaveEmpty[i] isEqualToString:@""])
        {
            if (!isEmpty && i!=0) {
                //前一个不是空 加一个空格
                strHaveEmpty = [NSString stringWithFormat:@"%@%@",strHaveEmpty,@" "];
            }
            
            isEmpty = YES;
        }
        else
        {
            //上次是空格 这次不是空格了
            if (isEmpty) {
                strHaveEmpty = [NSString stringWithFormat:@"%@%@",strHaveEmpty,@" "];
            }
            strHaveEmpty = [NSString stringWithFormat:@"%@%@",strHaveEmpty,arrayHaveEmpty[i]];
        }
    }
    strHaveEmpty = [strHaveEmpty stringByReplacingOccurrencesOfString:@"  " withString:@" "];//去掉空格后
    
    //去掉多余换行
    NSArray *arrayHaveLine = [strHaveEmpty componentsSeparatedByString:@"\n\n"];
    NSString *strHaveLine = [[NSString alloc] init];
    BOOL isLine = NO;
    for (int i = 0; i < arrayHaveLine.count; i ++)
    {
        if ([arrayHaveLine[i] isEqualToString:@""]) {
            if (!isLine && i != 0) {
                strHaveLine = [NSString stringWithFormat:@"%@%@",strHaveLine,@"\n"];
            }
            isLine = YES;
        }
        else
        {
            if (isLine) {
                strHaveLine = [NSString stringWithFormat:@"%@%@",strHaveLine,@"\n"];
            }
            strHaveLine = [NSString stringWithFormat:@"%@%@",strHaveLine,arrayHaveLine[i]];
        }
    }
    strHaveLine = [strHaveLine stringByReplacingOccurrencesOfString:@"\n\n" withString:@"\n"];//去掉了多余的空格和换行
    
    
    NSString *publishStr = strHaveLine;

    if ([publishStr stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]].length == 0)
    {
        [Utility showToastWithMessage:@"写点内容再发吧~" inView:self.view];
        _commentTF.text = strComment;
        return;
    }
    
    if ([publishStr length] == 0) {
        [Utility showToastWithMessage:@"写点内容再发吧~" inView:self.view];
        _commentTF.text = strComment;
        return;
    }
    

    [_commentTF resignFirstResponder];
    //cardId，key，comment（都为必填），atSendUserId（发送@人id，可为空），atReceiveUserId（接收@人id），topicUserId（主题作者用户id）,channelId(话题id)
    NSMutableDictionary *param = [NSMutableDictionary dictionary];
    [param setPObject:_cardInfo.cardID forKey:@"cardId"];
    [param setPObject:[HWUserLogin currentUserLogin].key forKey:@"key"];
    [param setPObject:publishStr forKey:@"comment"];
//    [param setPObject:@"0" forKey:@"isAnonymous"];  //是否匿名 0不匿名 1匿名
    [param setPObject:[HWUserLogin currentUserLogin].userId forKey:@"atSendUserId"];    //发送@人id，可为空
    if (_commentAtId != nil)
        [param setPObject:_commentAtId forKey:@"atReceiveUserId"];                      //被@人id
    
    [param setPObject:_cardInfo.userId forKey:@"topicUserId"];                          //主题作者的用户ID
    [param setPObject:_cardInfo.channelId forKey:@"channelId"];                                //频道ID
    
    [Utility showMBProgress:self.view message:LOADING_TEXT];
    HWHTTPRequestOperationManager *manager = [HWHTTPRequestOperationManager manager];
    [manager POST:kCreateReply parameters:param queue:nil success:^(id responObject)
    {
        [Utility hideMBProgress:self.view];
        if ([[[responObject dictionaryObjectForKey:@"data"] stringObjectForKey:@"status"] isEqualToString:@"1"]) {
            [Utility showToastWithMessage:[[responObject dictionaryObjectForKey:@"data"] stringObjectForKey:@"returnInfo"] inView:self.view];
            return ;
        }
        _commentTF.text = nil;
        _commentAtLabel.text = nil;
        _currentPage = 0;
        _cardInfo.commentCount = [NSString stringWithFormat:@"%d",_cardInfo.commentCount.intValue + 1];
        [self queryHeader];
        
        
        self.baseTableView.tableHeaderView.userInteractionEnabled = YES;
    } failure:^(NSString *code, NSString *error) {
        [Utility hideMBProgress:self.view];
        [Utility showToastWithMessage:error inView:self.view];
    }];
}

- (void)queryHeader
{
    NSMutableDictionary *param = [NSMutableDictionary dictionary];
    [param setPObject:[HWUserLogin currentUserLogin].key forKey:@"key"];
    [param setPObject:_cardId forKey:@"topicId"];
    
    HWHTTPRequestOperationManager *manager = [HWHTTPRequestOperationManager manager];
    [manager POST:kNeighbourDetailHead parameters:param queue:nil success:^(id responObject) {
        _cardInfo = [[HWNeighbourItemClass alloc]init];
        [_cardInfo fillObjectWithDictionary:[responObject dictionaryObjectForKey:@"data"]];
        [self createHeader];
        
        NSDictionary *commentDic = [NSDictionary dictionaryWithObject:_cardInfo.commentCount forKey:@"commentCount"];
        if (resourceType == detailResourceNeighbour)
        {
            if (self.delegate && [self.delegate respondsToSelector:@selector(changeComment:)])
            {
                [self.delegate changeComment:commentDic];
            }
        }
        else if (resourceType == detailResourceChannel)
        {
            if (self.delegate && [self.delegate respondsToSelector:@selector(changeComment:)])
            {
                [self.delegate changeComment:commentDic];
            }
        }
        [[NSNotificationCenter defaultCenter]postNotificationName:kRefreshNeighbour object:nil];
        
        [self queryListData];
    } failure:^(NSString *code, NSString *error) {
        [Utility showToastWithMessage:error inView:self.view];
    }];
}

- (void)queryListData
{
    if (!self.dataList) {
        self.dataList = [NSMutableArray array];
    }
    
    NSMutableDictionary *param = [NSMutableDictionary dictionary];
    [param setPObject:[HWUserLogin currentUserLogin].key forKey:@"key"];
    [param setPObject:_cardInfo.cardID forKey:@"topicId"];
    [param setPObject:@(kPageCount) forKey:@"size"];
    [param setPObject:@(_currentPage) forKey:@"page"];
    if ([selectViewRangeStr isEqualToString:@"全国"])
        [param setPObject:@"0" forKey:@"showLevel"];
    else if ([selectViewRangeStr isEqualToString:@"同城"])
        [param setPObject:@"1" forKey:@"showLevel"];
    else if ([selectViewRangeStr isEqualToString:@"附近"])
        [param setPObject:@"2" forKey:@"showLevel"];
    else
        [param setPObject:@"0" forKey:@"showLevel"];
    
    __block HWPraiseView *blockPraise = praise;
    HWHTTPRequestOperationManager *manager = [HWHTTPRequestOperationManager manager];
    [manager POST:kNeighbourDetailList parameters:param queue:nil success:^(id responObject)
    {
        NSString *total = [[responObject dictionaryObjectForKey:@"data"] stringObjectForKey:@"totalElements"]; //评论总数
        blockPraise.commentLabel.text = [NSString stringWithFormat:@"%@条评论",total];
        NSArray *array = [[responObject dictionaryObjectForKey:@"data"]arrayObjectForKey:@"content"];
        if (array.count < kPageCount)
        {
            isLastPage = YES;
        }
        else
        {
            isLastPage = NO;
        }
        
        if (_currentPage == 0)
        {
            [dataList removeAllObjects];
        }
        for (int i = 0; i < array.count; i++)
        {
            HWNeighbourDetailListItemClass *listClass = [[HWNeighbourDetailListItemClass alloc]init];
            [listClass fillWithDictionary:array[i]];
            listClass.topicUserId = _cardInfo.userId;
            [dataList addObject:listClass];
        }
        
        [baseTableView reloadData];
        
        [self doneLoadingTableViewData];
        
        _realHeaderView.userInteractionEnabled = YES;
        blockPraise.userInteractionEnabled = YES;
        blockPraise.praiseBtn.userInteractionEnabled = YES;
        self.baseTableView.tableHeaderView.userInteractionEnabled = YES;
        
    } failure:^(NSString *code, NSString *error) {
        [self doneLoadingTableViewData];
    }];
    
    
//    [self.baseTableView reloadData];
}

- (void)resignResponder:(UIPanGestureRecognizer *)panges
{
    [_coverView removeFromSuperview];
    _coverView = nil;
    [_commentTF resignFirstResponder];
}

#pragma mark - textview delegate
- (BOOL)textViewShouldBeginEditing:(UITextView *)textView
{
    return YES;
}

- (void)textViewDidBeginEditing:(UITextView *)textView
{
    textView.textColor = [UIColor blackColor];
    if ([textView.text isEqualToString:@"发表评论"])
    {
        textView.text = nil;
    }
    _isAllowCopy = NO;
    [MobClick event:@"get_focus_comment"];
}

- (void)textViewDidEndEditing:(UITextView *)textView
{
    if (textView.text.length == 0)
    {
        textView.text = @"发表评论";
        textView.textColor = [UIColor lightGrayColor];
    }
    _isAllowCopy = YES;
}

#pragma mark - textfield通知
- (void)textViewChangeForNoti:(NSNotification *)noti
{
    _commentButton.userInteractionEnabled = YES;
    [_commentButton setTitleColor:THEME_COLOR_CELLCOLOR forState:UIControlStateNormal];
    
    UITextView *textView = (UITextView *)noti.object;
    UITextRange *selectedRange = [textView markedTextRange];
    UITextPosition *position = [textView positionFromPosition:selectedRange.start offset:0];
    if (!position) {
        if (textView.text.length > 200 + _commentAtStr.length)
        {
            textView.text = [textView.text substringToIndex:200 + _commentAtStr.length];
//            _commentTF.text = [textView.text substringFromIndex:20 + _commentAtStr.length];
        }
    }
}

- (BOOL)textView:(UITextView *)textView shouldChangeTextInRange:(NSRange)range replacementText:(NSString *)text
{
    NSMutableString *string = [textView.text mutableCopy];
    [string replaceCharactersInRange:range withString:text];
    
    if (string.length > _commentAtStr.length)
    {
        [_commentButton setTitleColor:THEME_COLOR_CELLCOLOR forState:UIControlStateNormal];
        _commentButton.userInteractionEnabled = YES;
    }
    else
    {
        [_commentButton setTitleColor:THEME_COLOR_CELLCOLOR forState:UIControlStateNormal];
        _commentButton.userInteractionEnabled = NO;
    }
    
    //当即将要删@人时
    _commentAtLabel.backgroundColor = [UIColor clearColor];
    if (string.length == _commentAtStr.length - 1)
    {
        _commentAtLabel.textColor = THEME_COLOR_ORANGE;
        _commentAtLabel.backgroundColor = RANDGreen;
    }
    else
    {
        _commentAtLabel.textColor = THEME_COLOR_SMOKE;
    }
    
    if (_commentAtStr.length > 0)
    {
        if (string.length < _commentAtStr.length - 1)
        {
            _commentAtLabel.text = @"";
            _commentTF.text = @"";
            _commentAtStr = @"";
            _commentAtId = nil;
        }
    }
    
    if (string.length > 200 + _commentAtStr.length)
    {
        return NO;
    }
    
    return YES;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)dealloc
{
    self.delegate = nil;
    [[NSNotificationCenter defaultCenter]removeObserver:self name:UIKeyboardWillShowNotification object:nil];
    [[NSNotificationCenter defaultCenter]removeObserver:self name:UIKeyboardWillHideNotification object:nil];
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
