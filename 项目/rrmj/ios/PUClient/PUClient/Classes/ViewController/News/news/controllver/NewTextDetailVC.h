//
//  NewTextDetailVC.h
//  PUClient
//
//  Created by RRLhy on 15/8/13.
//  Copyright (c) 2015年 RRLhy. All rights reserved.
//

#import "BaseViewController.h"
#import "NewsIntroModel.h"
#import "ReviewModel.h"

typedef NS_ENUM(NSInteger, InfoType) {
    InfoTypeNew          = 0,//资讯
    InfoTypeReview       = 1,//剧评
    InfoTypeRating       = 2,//收视率
};
@interface NewTextDetailVC : BaseViewController

@property (nonatomic,assign)InfoType  type;

@property (nonatomic,strong)NewsIntroModel * infoModel;

@property (nonatomic,strong)ReviewModel * reviewModel;

@end
