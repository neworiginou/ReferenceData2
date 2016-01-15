//
//  WalletView.h
//  HaoWu_4.0
//
//  Created by zhangxun on 14-5-24.
//  Copyright (c) 2014年 caijingpeng. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface WalletView : UIView
{
    UILabel *_titleLabel;
    UILabel *_detailLabe;
}

- (id)initWithFrame:(CGRect)frame title:(NSString *)theTitle detail:(NSString *)theDetail isMoney:(BOOL)isMony;
@end
