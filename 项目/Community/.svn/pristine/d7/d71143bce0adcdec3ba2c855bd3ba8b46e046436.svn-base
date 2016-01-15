//
//  HWPublishViewController.h
//  Community
//
//  Created by zhangxun on 14-9-8.
//  Copyright (c) 2014年 caijingpeng. All rights reserved.
//

#import "HWBaseViewController.h"
#import "HWPublishAlbumCell.h"
#import "HWCropImageViewController.h"
#import "GKImagePickerController.h"
#import "HWRecorderView.h"
#import "HWAddChannelViewController.h"

typedef enum
{
    textMode = 0,
    audioMode
}
PublishMode;

typedef enum
{
    NeighbourRoute = 0,
    PropertyRoute,
    NeighbourPhoneRoute
}
PublishRoute;

@interface HWPublishViewController : HWBaseViewController<UIScrollViewDelegate, UITableViewDataSource, UITableViewDelegate, HWPublishAlbumCellDelegate, HWCropImageViewControllerDelegate, GKImagePickerControllerDelegate, HWRecorderViewDelegate, UITextViewDelegate, HWAddChannelViewControllerDelegate>

@property (nonatomic, strong) NSMutableArray *groups;
@property (nonatomic, strong) NSMutableArray *assets;
@property (nonatomic, assign) PublishMode publishMode;
@property (nonatomic, assign) BOOL isNeedAudio;
@property (nonatomic, assign) PublishRoute publishRoute;
@property (nonatomic, assign) BOOL isOnlyAudio;         // 只有发布语音
@property (nonatomic, assign) BOOL isWriteAndPic;

//  发送电话结果
@property (nonatomic, strong) NSString *callType; // 类型  0 ：店铺  1：物业
@property (nonatomic, strong) NSString *callNumber;
@property (nonatomic, strong) NSString *callId;
@property (nonatomic, strong) NSString *callTime;
@property (nonatomic, strong) NSString *callSuccess;
@property (nonatomic, strong) NSString *historyCardId;

@property (nonatomic, strong) NSString *topic;
//默认文案
@property (nonatomic, strong) NSString *tolerantString;

@property (nonatomic, strong) HWChannelModel *curChannelModel;


@end
