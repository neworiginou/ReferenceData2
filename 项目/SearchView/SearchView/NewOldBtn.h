//
//  NewOldBtn.h
//  SearchView
//
//  Created by lizhongqiang on 15/7/7.
//  Copyright (c) 2015年 lqq. All rights reserved.
//

#import <UIKit/UIKit.h>

@class NewOldBtn;

@protocol NewOldBtnDelegate <NSObject>

- (void)clickNewOldBtn:(NewOldBtn *)btn;

@end

@interface NewOldBtn : UIView

@property (nonatomic, assign)int temp;

@property (nonatomic, copy)NSString *title;

@property (nonatomic, assign)id<NewOldBtnDelegate> delegate;


@end
