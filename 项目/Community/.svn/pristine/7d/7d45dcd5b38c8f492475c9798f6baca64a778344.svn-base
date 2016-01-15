//
//  HWUploadButton.h
//  Community
//
//  Created by lizhongqiang on 14-10-14.
//  Copyright (c) 2014年 caijingpeng. All rights reserved.
//

#import <UIKit/UIKit.h>
typedef enum{
    HWUploadNormal = 0,
    HWUploading,
    HWUploadSuccess,
    HWUploadFaile,
} HWUploadStatus;


@protocol HWUploadButtonDelegate <NSObject>

- (void)tapBigIndex:(NSInteger)index Status:(HWUploadStatus)btnStatus;
- (void)tapSmallIndex:(NSInteger)index Status:(HWUploadStatus)btnStatus;

@end


@interface HWUploadButton : UIView
{
    HWUploadStatus _status;
    NSInteger index;
    //加载完成图     加载状态        加载成功        加载失败
    UIImageView *imagePhoto;
    UIView *loadingView;
    UIView *loadSuccessView;
    UIView *loadFaileView;
    
    UIImageView *smallView;
//    UILabel *name;
}

//@property (nonatomic, assign)HWUploadStatus _status;
@property (nonatomic) NSInteger index;
@property (nonatomic, strong) UILabel *name;
@property (nonatomic, strong) UIImageView *imagePhoto;
@property (nonatomic, assign) id <HWUploadButtonDelegate> delegate;
@property (nonatomic, strong) UIImageView *bigView;
@property (nonatomic, strong) UIImageView *photoImgView;
- (void)setStatus:(HWUploadStatus)aStatus;

-(void)setFrame:(CGRect)frame;

@end
