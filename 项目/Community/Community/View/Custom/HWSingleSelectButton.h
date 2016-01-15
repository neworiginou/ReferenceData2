//
//  SingleSelectButton.h
//  CallPhoneAlert
//
//  Created by lizhongqiang on 14-8-28.
//  Copyright (c) 2014年 Lizhongqiang. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface HWSingleSelectButton : UIButton

//初始化方法
- (id)initWithFrame:(CGRect)frame unSelectImage:(UIImage *)img selectImage:(UIImage *)selectImg;

//返回当前选择状态  非必须 和系统自带的一样
- (BOOL)isBtnSelected;

@end
