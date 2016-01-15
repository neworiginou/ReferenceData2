//
//  ScanImageViewCtr.h
//  HaoWu
//
//  Created by PengHuang on 13-9-16.
//  Copyright (c) 2013年 PengHuang. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ETShowBigImageView.h"

@interface ScanImageViewCtr : UIViewController<ETShowBigImageViewDelegate> {
    NSArray *hxArray;           //户型图
    NSArray *xgArray;           //效果图
    NSArray *jtArray;           //交通图
    NSArray *sjArray;           //实景图
    NSArray *ybArray;           //样板图
    
    UIView *_tabView;
    
    ETShowBigImageView *_bigImgV;
    UIView *_navigationView;
}

@property (nonatomic,strong) NSArray *hxArray;
@property (nonatomic,strong) NSArray *xgArray;
@property (nonatomic,strong) NSArray *jtArray;
@property (nonatomic,strong) NSArray *sjArray;
@property (nonatomic,strong) NSArray *ybArray;

@property (nonatomic, assign) int page;

- (void)setDefaultTabBtn:(int)tabNum;

@end
