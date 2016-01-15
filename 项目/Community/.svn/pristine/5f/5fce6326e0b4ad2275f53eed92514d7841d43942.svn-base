//
//  HWOrderCoinView.h
//  TestOne
//
//  Created by gusheng on 14-12-9.
//  Copyright (c) 2014年 gusheng. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol HWOrderCoinViewDelegate <NSObject>

- (void)confirmPayMoney:(NSString *)payMoney coinCount:(int)count;

@end

@interface HWOrderCoinView : UIView<UITextFieldDelegate>
{
     UIView *_backGroundView;
     UIView *_view;
     UILabel *_needPayMoneyLabel;
     int _kaolaCoinNum;
     NSString * _totalPayMoneyStr;
     NSString * _coinTypeStr;
     UITextField  *valueTextFileld;
}

@property (nonatomic, assign) id<HWOrderCoinViewDelegate> delegate;
-(void)moveInputBarWithKeyboardHeight:(float)_CGRectHeight withDuration:(NSTimeInterval)_NSTimeInterval;
-(instancetype)initWithFrame:(CGRect)generalRect coinType:(NSString *)coinTypeStr coinImageV:(NSString *)coinImageVUrl;
@end