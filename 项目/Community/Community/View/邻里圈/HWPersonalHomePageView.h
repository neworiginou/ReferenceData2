//
//  HWPersonalHomePageView.h
//  Community
//
//  Created by niedi on 15/4/13.
//  Copyright (c) 2015年 caijingpeng. All rights reserved.
//

#import "HWBaseRefreshView.h"
#import "HWSignView.h"


@protocol HWPersonalHomePageViewDelegate <NSObject>

- (void)personalHomePageClickIndex:(NSInteger)index;
- (void)personalHomePageVcChangeTitle:(NSString *)title;

@end



@interface HWPersonalHomePageView : HWBaseRefreshView
{
    UIImageView *_backImgV;
    NSString *_headerMongodbKey;
    UIImageView *_headerImg;
    NSArray *_TaTitleArr;
    NSArray *_WoTitleArr;
    NSArray *_TitleImgArr;
}

@property (nonatomic, weak) id<HWPersonalHomePageViewDelegate> delegate;
@property (nonatomic, strong) NSString *userId;


- (instancetype)initWithFrame:(CGRect)frame userId:(NSString *)userId;

@end
