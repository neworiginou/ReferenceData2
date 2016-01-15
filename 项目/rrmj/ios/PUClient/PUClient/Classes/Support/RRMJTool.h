//
//  RRMJTool.h
//  PUClient
//
//  Created by RRLhy on 15/7/31.
//  Copyright (c) 2015年 RRLhy. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface RRMJTool : NSObject
/**
 *  通过城市名称获得城市代号
 *
 *  @param city 城市
 *
 *  @return 返回城市代号
 */
+ (NSString *)getValueWithCity:(NSString*)city;
/**
 *  通过城市代号，获取城市名称
 *
 *  @param value 代号
 *
 *  @return 返回城市名称
 */
+ (NSString *)getKeyWith:(NSString * )value;

/**
 *  获取等级图片
 *
 *  @param level 等级
 *
 *  @return image
 */
+ (UIImage*)levelImageWith:(NSInteger)level;
/**
 *  获取性别图片
 *
 *  @param sex 性别
 *
 *  @return 返回图片
 */
+ (UIImage*)sexImageWith:(NSString*)sex;
/**
 *  设置label的行间距
 *
 *  @param spacing 行间距高度
 *  @param text    label要显示的文字
 *
 *  @return 返回
 */
+ (NSMutableAttributedString*)setLineSpacing:(CGFloat)spacing string:(NSString *)text;

@end
