//
//  HWNumberButton.h
//  Community
//
//  Created by lizhongqiang on 14-9-2.
//  Copyright (c) 2014年 caijingpeng. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface HWNumberButton : UIView
{
    UIButton *minusBtn;     //减按钮
    UIButton *addBtn;       //加按钮
    UILabel *numLabel;      //显示数字
    int number;             //数字
    int limitNum;           //最小限制数字
}
@property (nonatomic, strong) UILabel *numLabel;
@property (nonatomic) int number;
@property (nonatomic) int limitNum;
@property (nonatomic, strong) NSString *strType;                //类型  为了埋点
//初始化方法
- (id)initWithFrame:(CGRect)frame Number:(int)num LimitNum:(int)limitNumber;
//获得当前的数值  也可直接访问 number
- (int)getButtonNumber;

- (void)minusBtnClick:(id)sender;
- (void)addBtnClick:(id)sender;

@end
