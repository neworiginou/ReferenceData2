//
//  FiltButton.h
//  HaoWu_4.0
//
//  Created by zhangxun on 14-5-24.
//  Copyright (c) 2014年 caijingpeng. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface FiltButton : UIView
{
    
}

@property (nonatomic, strong)UIImageView *titleIV;
@property (nonatomic, strong)UILabel *titleLabe;

- (void)setTitle:(NSString *)title;
- (void)addTarget:(id)target action:(SEL)action;
- (void)setTitleRightAlignment;

@end
