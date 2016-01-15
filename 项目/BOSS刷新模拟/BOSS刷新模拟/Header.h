//
//  Header.h
//  BOSS刷新模拟
//
//  Created by lizhongqiang on 16/1/10.
//  Copyright © 2016年 lizhongqiang. All rights reserved.
//

#ifndef Header_h
#define Header_h

#define CustomColor(value) ({UIColor *color=nil;\
float float1,float2,float3;\
NSScanner *scanner = [NSScanner scannerWithString:value];\
[scanner scanFloat:&float1];\
scanner.scanLocation = scanner.scanLocation+1;\
[scanner scanFloat:&float2];\
scanner.scanLocation = scanner.scanLocation+1;\
[scanner scanFloat:&float3];\
[UIColor colorWithRed:float1/255.f green:float2/255.f blue:float3/255.f alpha:1.0];color;\
})

#import "Masonry.h"
#import "AppDelegate.h"
#endif /* Header_h */
