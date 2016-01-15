//
//  HWWeChatOldConfirmBindView.h
//  Community
//
//  Created by caijingpeng.haowu on 15/1/14.
//  Copyright (c) 2015年 caijingpeng. All rights reserved.
//

#import "HWBaseRefreshView.h"

@protocol HWWeChatOldConfirmBindViewDelegate <NSObject>

- (void)didConfirmBindWeChatByUserInfo:(NSDictionary *)userInfo;

@end

@interface HWWeChatOldConfirmBindView : HWBaseRefreshView <UITextFieldDelegate>
{
    HWTextField *_passwordTF;
    UIView *_headerView;
    UIImageView *_logoLeftImgV;
    UILabel *_leftLabel;
    UIImageView *_logoRightImgV;
    UILabel *_rightLabel;
}

@property (nonatomic, strong)HWWeChatAccountModel *weChatAccount;
@property (nonatomic, strong)NSString *accountStr;
@property (nonatomic, strong)NSString *passwordStr;
@property (nonatomic, assign)id<HWWeChatOldConfirmBindViewDelegate> delegate;

- (void)initialView;

@end
