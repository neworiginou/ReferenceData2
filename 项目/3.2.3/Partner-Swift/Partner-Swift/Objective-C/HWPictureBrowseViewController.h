//
//  HWPictureBrowseViewController.h
//  MoreHouse
//
//  Created by caijingpeng on 14/11/24.
//  Copyright (c) 2014年 lizhongqiang. All rights reserved.
//

#import "HWBaseViewControllerOC.h"
#import "Utility-OC.h"
#import "Define-OC.h"
#import "UIImageView+WebCache.h"


typedef enum
{
    picTypeSecodnHouse = 0,
    picTypeNewHouse
    
}resourceType;

@interface HWPictureBrowseViewController : UIViewController

@property (nonatomic, assign) NSInteger selectType;
@property (nonatomic, strong) NSArray *sourceArray;

@property (nonatomic,strong)NSArray *innerArr;
@property (nonatomic,strong)NSArray *houseArr;
@property (nonatomic,assign)BOOL showEditBtn;

@property (nonatomic,strong)NSString *houseId;
@property (nonatomic,strong)NSString *permission;
@property (nonatomic,assign)resourceType picType;

- (void)doChangeTypeWithIndex:(int)index;

@end