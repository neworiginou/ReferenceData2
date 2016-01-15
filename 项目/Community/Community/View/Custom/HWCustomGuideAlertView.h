//
//  HWCustomGuideAlertView.h
//  Community
//
//  Created by hw500027 on 15/4/17.
//  Copyright (c) 2015年 caijingpeng. All rights reserved.
//

#import <UIKit/UIKit.h>


typedef void(^CompleteBlock) (NSInteger buttonTag);

@interface HWCustomGuideAlertView : UIView
-(id)initWithAlertType:(NSInteger)type customContent:(NSString *)content;
-(id)initWithAlertType:(NSInteger)type;
// 用Block的方式回调，这时候会默认用self作为Delegate
@property (nonatomic, strong) CompleteBlock completeBlock;
- (void)showCustomGuideAlertViewWithCompleteBlock:(CompleteBlock) block;
@property (nonatomic, copy) NSString *contentText;
@end
