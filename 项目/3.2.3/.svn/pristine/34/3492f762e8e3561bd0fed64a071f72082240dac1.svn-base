//
//  HWImageEditVC.h
//  MoreHouse
//
//  Created by zhangxun on 14/12/2.
//  Copyright (c) 2014年 lizhongqiang. All rights reserved.
//

#import "HWBaseViewControllerOC.h"
#import "Utility-OC.h"
#import "Define-OC.h"

@protocol HWImageEditVCDelegate <NSObject>

- (void)doSetFirst:(NSString *)imageStr;

- (void)doDelete:(NSString *)imageStr;

- (void)doUnFirst;

@end

@interface HWImageEditVC : HWBaseViewControllerOC

@property (nonatomic,strong)UIImage *editImage;
@property (nonatomic,assign)BOOL hasSelected;
@property (nonatomic,assign)id <HWImageEditVCDelegate>delegate;
@property (nonatomic,strong)NSString *imageString;

- (void)setCustomer;

@end
