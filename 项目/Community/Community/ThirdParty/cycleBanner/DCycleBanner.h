//
//  DCycleBanner.h
//  Community
//
//  Created by niedi on 15/5/4.
//  Copyright (c) 2015年 caijingpeng. All rights reserved.
//
//  功能描述：轮播banner封装
//
//  修改记录：
//      姓名          日期                      修改内容
//      聂迪        2015-05-04                 创建文件
//      聂迪        2015-05-05                 完善
//

#import <UIKit/UIKit.h>

@interface DCycleBanner : UIView
{
    
}
@property (nonatomic, copy) void (^ImageViewAtIndex)(UIImageView *bannerImageView, NSUInteger indexAtBanner); //设置imageView
@property (nonatomic, copy) void(^imageTapAction)(NSUInteger indexAtBanner);    //设置imageView点击事件


+ (instancetype)cycleBannerWithFrame:(CGRect)frame bannerImgCount:(NSUInteger)bannerImgCount;     //初始化 传ImageView个数

- (void)setImageViewAtIndex:(void (^)(UIImageView *bannerImageView, NSUInteger))ImageViewAtIndex; //设置不同Index的imageView的图片(从0开始)

- (void)setImageTapAction:(void (^)(NSUInteger))indexAtBanner;  //设置imageView的点击事件(从0开始)

- (void)setScroTimeInterval:(float)interval;    //设置timerAction执行间隔  不设置默认5s

- (void)setTimerFire:(BOOL)isFire;      //设置是否开始滚动




@end
/*//轮播banner
 DCycleBanner *banner = [DCycleBanner cycleBannerWithFrame:CGRectMake(0, 0, kScreenWidth, 165 * kScreenRate) bannerImgCount:self.bannerModelArr.count];
 [banner setImageViewAtIndex:^(UIImageView *bannerImageView, NSUInteger indexAtBanner) {
 HWNeighbourBannerModel *model = [_bannerModelArr pObjectAtIndex:indexAtBanner];
 bannerImageView.backgroundColor = IMAGE_DEFAULT_COLOR;
 __weak UIImageView *weakImgV = bannerImageView;
 [bannerImageView setImageWithURL:[NSURL URLWithString:[Utility imageDownloadWithUrl:model.activityPictureURL]] placeholderImage:[UIImage imageNamed:IMAGE_PLACE] completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType) {
 if (error == nil)
 {
 weakImgV.image = image;
 }
 else
 {
 weakImgV.image = [UIImage imageNamed:IMAGE_BREAK_CUBE];
 }
 }];
 }];
 [banner setImageTapAction:^(NSUInteger indexAtBanner) {
 [self bannerImgVClickAtIndex:indexAtBanner];
 }];
 [banner setTimerFire:YES];
 [tableViewHeaderView addSubview:banner];*/

