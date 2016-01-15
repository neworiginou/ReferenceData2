//
//  HWSuggestTypeButton.h
//  Community
//
//  Created by zhangxun on 14-9-18.
//  Copyright (c) 2014年 caijingpeng. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface HWSuggestTypeButton : UIView
{
    UILabel *_titleLabe;
    UIImageView *sigImageV;
}

@property (nonatomic,assign)BOOL hasSelected;

- (void)setTitle:(NSString *)title;
- (void)setSel;
- (void)setUnsel;

- (void)addTarget:(id)target action:(SEL)selector;
@end
