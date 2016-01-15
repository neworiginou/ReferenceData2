//
//  HWUploadButton.m
//  Community
//
//  Created by lizhongqiang on 14-10-14.
//  Copyright (c) 2014年 caijingpeng. All rights reserved.
//

#import "HWUploadButton.h"

@implementation HWUploadButton
@synthesize delegate;
@synthesize index;
@synthesize name;
@synthesize imagePhoto;
@synthesize bigView;
@synthesize photoImgView;

-(id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        
    }
    return self;
}

static float centerSize = 20.0f;

-(void)setFrame:(CGRect)frame
{
    [super setFrame:frame];
//    self.userInteractionEnabled = YES;
//    photoImgView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 5, 80, 80)];
//    photoImgView.tag = index;
//    photoImgView.layer.cornerRadius = 10;
//    photoImgView.layer.masksToBounds = YES;
//    [self addSubview:photoImgView];
    
    bigView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 5, 80, 80)];
    bigView.layer.cornerRadius = 10;
    bigView.layer.masksToBounds = YES;
    [bigView setBackgroundColor:[UIColor clearColor]];
    bigView.userInteractionEnabled = YES;
    bigView.tag = index;
    [bigView setImage:[UIImage imageNamed:@"openshop_addphoto"]];
    UITapGestureRecognizer *tapBig = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapBigView)];
    [bigView addGestureRecognizer:tapBig];
    [self addSubview:bigView];
    
    
    smallView = [[UIImageView alloc] initWithFrame:CGRectMake(60, 5, 20, 20)];
    [smallView setBackgroundColor:[UIColor clearColor]];
    smallView.image = [UIImage imageNamed:@"del"];
    smallView.userInteractionEnabled = YES;
    smallView.hidden = YES;
    UITapGestureRecognizer *tapSmall = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapSmallView)];
    [smallView addGestureRecognizer:tapSmall];
    [self addSubview:smallView];
    
    //加载完成图     加载状态        加载成功        加载失败
    imagePhoto = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 80, 80)];
    imagePhoto.userInteractionEnabled = YES;
//    imagePhoto.image = [UIImage imageNamed:@"openshop_addphoto"];
    [bigView addSubview:imagePhoto];
    
    loadingView = [[UIView alloc] initWithFrame:CGRectMake((bigView.frame.size.width / 2 - 22 / 2), (bigView.frame.size.width / 2 - 22 / 2) + 5, 22, 22)];
    UIActivityIndicatorView *activity = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleGray];
    [activity startAnimating];
    loadingView.center = CGPointMake(bigView.frame.size.width / 2, bigView.frame.size.width / 2 + 5 / 2);
    [loadingView addSubview:activity];
    loadingView.hidden = YES;
    [bigView addSubview:loadingView];
    
    loadSuccessView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, centerSize, centerSize)];
    loadSuccessView.center = CGPointMake(bigView.frame.size.width / 2, bigView.frame.size.width / 2 + 5 /2);
    loadSuccessView.hidden = YES;
    UIImageView *imgSuccess = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, centerSize, centerSize)];
    [imgSuccess setImage:[UIImage imageNamed:@"succeed"]];
    [loadSuccessView addSubview:imgSuccess];
    [bigView addSubview:loadSuccessView];
    
    loadFaileView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, centerSize, centerSize)];
    loadFaileView.center = CGPointMake(bigView.frame.size.width / 2, bigView.frame.size.width / 2 + 5 /2);
    loadFaileView.hidden = YES;
    UIImageView *imgFaile = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, centerSize, centerSize)];
    [imgFaile setImage:[UIImage imageNamed:@"lose"]];
    [loadFaileView addSubview:imgFaile];
    [bigView addSubview:loadFaileView];
    
    name = [[UILabel alloc] initWithFrame:CGRectMake(0, 60, 80, 20)];
    [name setBackgroundColor:[UIColor clearColor]];
    name.textColor = THEME_COLOR_TEXT;
    [name setFont:[UIFont fontWithName:FONTNAME size:13]];
    [name setTextAlignment:NSTextAlignmentCenter];
    [bigView addSubview:name];
    
}

-(void)setStatus:(HWUploadStatus)aStatus
{
    switch (aStatus) {
        case HWUploadNormal:
        {
            
            imagePhoto.hidden = NO;
            loadingView.hidden = YES;
            loadSuccessView.hidden = YES;
            loadFaileView.hidden = YES;
            smallView.hidden = YES;
            
        }
            break;
            case HWUploading:
        {
            loadingView.hidden = NO;
//            imagePhoto.hidden = YES;
            loadSuccessView.hidden = YES;
            loadFaileView.hidden = YES;
            smallView.hidden = NO;
        }
            break;
            case HWUploadSuccess:
        {
            loadSuccessView.hidden = NO;
//            imagePhoto.hidden = YES;
            loadingView.hidden = YES;
            loadFaileView.hidden = YES;
            smallView.hidden = NO;
        }
            break;
            case HWUploadFaile:
        {
            loadFaileView.hidden = NO;
//            imagePhoto.hidden = YES;
            loadSuccessView.hidden = YES;
            loadingView.hidden = YES;
            smallView.hidden = NO;
        }
            break;
        default:
            break;
    }
    
    _status = aStatus;
}

- (void)setIndex:(NSInteger)aIndex
{
    index = aIndex;
    
}

- (void)tapBigView
{
    [delegate tapBigIndex:index Status:_status];
}

- (void)tapSmallView
{
    [delegate tapSmallIndex:index Status:_status];
}

@end
