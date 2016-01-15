//
//  WYYC.h
//  无忧云车司机
//
//  Created by luosai19910103@163.com on 15/7/1.
//  Copyright (c) 2015年 wuyouyunche. All rights reserved.
//

#ifndef _______WYYC_h
#define _______WYYC_h
#define WYYC_PREFIX_ @"http://192.168.2.90:8001/"
#define WYYC_PREFIX @"http://120.26.217.149:7000/"
#define WYYC_PREFIX_PRODUCT @"http://121.43.230.217:8000/"
#define ORDER_SUBMIT @"order_submit"
#define DRIVER_STATE_SYNCHRONOUS  @"driver_state_synchronous"

#define WYColor(r,g,b)     [UIColor colorWithRed:(r)/255.0 green:(g)/255.0 blue:(b)/255.0 alpha:1.0]
#define BLUE_COLOR  WYColor(0, 179, 221)
#define ORANGE_COLOR WYColor(237, 115, 76)
#define DARKGRAY_COLOR WYColor(102, 102, 102)
#define WHITE_COLOR WYColor(234, 234, 234)
#define DARKBLUE_COLOR WYColor(61, 140, 211)
#define WYYCNOTIFICATION  [NSNotificationCenter defaultCenter]
#define kIsDriving @"isDriving"
#endif
