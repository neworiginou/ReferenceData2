//
//  SearchView.h
//  SearchView
//
//  Created by lizhongqiang on 15/7/7.
//  Copyright (c) 2015年 lqq. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SearchView : UIView

@property (nonatomic, copy)void(^clickButtomBtn)(NSString *string);

@property (nonatomic, copy)void(^clickTopBtn)(NSString *string);

@end
