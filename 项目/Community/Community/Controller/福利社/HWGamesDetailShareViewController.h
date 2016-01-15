//
//  HWGamesDetailShareViewController.h
//  Community
//
//  Created by WeiYuanlin on 15/1/15.
//  Copyright (c) 2015年 caijingpeng. All rights reserved.
//

#import "HWBaseViewController.h"
#import "HWGameNameView.h"
#import "HWShareView.h"
#import "HWGameOneClickSpreadVC.h"
#import "HWGameNameModel.h"

@interface HWGamesDetailShareViewController : HWBaseViewController <HWGameNameViewDelegate>

@property (nonatomic, strong) NSString *gameId;
@property (nonatomic, strong) NSString *appkey;
@property (nonatomic, strong) NSString *code;
@property (nonatomic, strong) UIImageView *gameImgV;
@property (nonatomic, strong) NSString *gameName;

@end
