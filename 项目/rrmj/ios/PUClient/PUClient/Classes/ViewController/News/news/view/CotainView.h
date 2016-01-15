//
//  CotainView.h
//  PUClient
//
//  Created by RRLhy on 15/8/14.
//  Copyright (c) 2015年 RRLhy. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "HPGrowingTextView.h"

@interface CotainView : UIView<HPGrowingTextViewDelegate>
/**
 *  同步
 */
@property (nonatomic,strong)UIButton * syncBtn;

/**
 *  发送按钮
 */
@property (nonatomic,strong)UIButton * sendBtn;

/**
 *  字数
 */
@property (nonatomic,strong)UILabel * markNum;

/**
 *  输入框
 */
@property (nonatomic,strong)HPGrowingTextView * textTf;

@end
