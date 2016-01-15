//
//  HWGeneralControl.h
//  TestOne
//
//  Created by gusheng on 14-12-8.
//  Copyright (c) 2014年 gusheng. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
@interface HWGeneralControl : NSObject
//创建通用的UILabel
+(UILabel *)createLabel:(CGRect)generalRect font:(CGFloat)fontSize textAligment:(NSTextAlignment)textAligment labelColor:(UIColor *)labelColor;

//创建通用的UITableView
+(UIImageView *)createImageView:(CGRect)generalRect image:(NSString *)ImageStr;

//创建通用的UITextField
+(UITextField *)createTextFiledView:(CGRect)generalRect delegate:(id)delegate textAligment:(NSTextAlignment)textAligment font:(CGFloat)fontSize textColor:(UIColor *)textColor tag:(NSInteger)tag;

//创建通用的UIButton
+(UIButton *)createButton:(CGRect)generalRect font:(CGFloat)fontSize buttonTitleColor: (UIColor *)buttonColor imageStr:(NSString *)imageStr backImage:(NSString *)backImageStr title:(NSString *)titleStr;

//创建UIView
+(UIView *)createView:(CGRect)generalRect;

//创建UITextview
+(UITextView *)createTextView:(CGRect)generalRect font:(CGFloat )fontSize textColor:(UIColor *)textColor delegate:(id)delegate textAligment:(NSTextAlignment)textAligment;
//创建UITableView
+(UITableView *)createTableView:(CGRect)generalRect dataSource:(id)dataSourceDelegate delegate:(id)delegateTemp;
//计算Label的实际宽度
+(CGRect)returnLabelFactualSize:(UILabel *)caculationLabel font:(NSInteger)fontSize;
+(CGRect)returnLabelFactualHeightSize:(UILabel *)caculationLabel font:(NSInteger)fontSize;

//画线
+(void)drawLine:(CGRect)lineRect sectionOneTempView:(UIView *)sectionOneViewTemp;


@end
