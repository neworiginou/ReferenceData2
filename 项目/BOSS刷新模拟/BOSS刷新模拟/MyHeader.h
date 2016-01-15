//
//  MyHeader.h
//  BOSS刷新模拟
//
//  Created by lizhongqiang on 16/1/8.
//  Copyright © 2016年 lizhongqiang. All rights reserved.
//

#import <MJRefresh/MJRefresh.h>

@interface MyHeader : MJRefreshHeader
- (void)refreshHeaderView:(CGFloat)contentOffY;
- (void)startAnimations;
@end
