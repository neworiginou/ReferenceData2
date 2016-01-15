//
//  CommentVC.h
//  PUClient
//
//  Created by RRLhy on 15/8/14.
//  Copyright (c) 2015年 RRLhy. All rights reserved.
//

#import "BaseViewController.h"

#import "NewsIntroModel.h"

#import "ReviewModel.h"

@interface CommentVC : BaseViewController

@property (nonatomic,strong)NewsIntroModel * infoModel;

/**
 *  收视跟剧评公用一个对象
 */
@property (nonatomic,strong)ReviewModel * reviewModel;

@end
