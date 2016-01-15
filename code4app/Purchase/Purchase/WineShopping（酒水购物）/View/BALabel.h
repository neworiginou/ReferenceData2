//
//  BALabel.h
//  BarAssistant
//
//  Created by 叶星龙 on 15/5/13.
//  Copyright (c) 2015年 北京局外者科技有限公司. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef NS_ENUM(NSInteger, BALabelControlEvents) {
    BALabelControlEventTap,
    BALabelControlEventLongPressBegan,
    BALabelControlEventLongPressEnd,
};

@interface BALabel : UILabel


- (void)addTarget:(id)target action:(SEL)action forControlEvents:(BALabelControlEvents)controlEvents;
@end
// 版权属于原作者
// http://code4app.com (cn) http://code4app.net (en)
// 发布代码于最专业的源码分享网站: Code4App.com