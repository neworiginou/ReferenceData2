//
//  DateSelectView.h
//  PUClient
//
//  Created by RRLhy on 15/8/15.
//  Copyright (c) 2015年 RRLhy. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void (^TouchActionBlock)(NSInteger itemIndex);

@interface DateSelectView : UIView
/*
 //item数据
 */
@property (nonatomic,retain)NSArray * titleArray;//item数据
/*
 //当前选中的item索引
 */
@property (nonatomic,assign)NSInteger  currentIndex;//当前选中的item
/*
 block代理
 */
@property (nonatomic,copy)TouchActionBlock itemBlock;
/*
 //当前选中的按钮
 */
@property (nonatomic,assign)UIButton * currentBtn;//当前选中的按钮
/*
 滚动view
 */
@property (nonatomic,retain)UIImageView * scrollImg;

//- (id)initWithFrame:(CGRect)frame items:(NSArray*)titles;

- (id)initWithFrame:(CGRect)frame items:(NSArray*)titles complete:(TouchActionBlock)block;
@end
