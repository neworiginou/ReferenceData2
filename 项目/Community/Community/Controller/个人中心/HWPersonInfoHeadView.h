//
//  PersonInfoHeadView.h
//  Community
//
//  Created by gusheng on 14-9-1.
//  Copyright (c) 2014年 caijingpeng. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol HWPersonInfoHeadViewDelegate <NSObject>

- (void)didClickEditHead;

@optional
- (void)didClickLoginBtn;

@end

@interface HWPersonInfoHeadView : UIView<UIActionSheetDelegate>
{
    UIImageView *headImgV;
    UILabel *nicknameLab;
    UIImageView *headPlaceHolderImgV;
    UIImageView *genderPlaceHolderImgV;
    UILabel *villageLabel;
    UIImageView *villageImgV;
}

@property (nonatomic, assign) id<HWPersonInfoHeadViewDelegate> delegate;

- (void)setHeadCenterY:(CGFloat)centerY;
- (void)refreshPersonInfo;

@end
