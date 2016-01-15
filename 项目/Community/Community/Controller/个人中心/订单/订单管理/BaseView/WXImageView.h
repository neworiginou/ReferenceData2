//
//  WXImageView.h
//  weibo1
//
//  Copyright (c) 2014年 yang. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void(^ImageBlovk)(void);
@interface WXImageView : UIImageView
@property (nonatomic,copy)ImageBlovk touchBlock;

@end
