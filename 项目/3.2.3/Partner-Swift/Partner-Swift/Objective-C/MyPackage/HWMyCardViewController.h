//
//  HWMyCardViewController.h
//  HaoWu_4.0
//
//  Created by caijingpeng.haowu on 14-5-24.
//  Copyright (c) 2014年 caijingpeng. All rights reserved.
//

#import "HWRefreshBaseViewController.h"
#import "HWMyCardCell.h"


@protocol HWMyCardViewControllerDelegate <NSObject>

- (void)selectedMyCardWithInfo:(NSDictionary *)cardInfo;

@end


@interface HWMyCardViewController : HWRefreshBaseViewController<HWMyCardCellDelegate,UIAlertViewDelegate>

{
    int _selectIndex;
}

@property (nonatomic, strong)NSDictionary *defaultDic;
@property (nonatomic, strong)NSDictionary *selectedBank;
@property (nonatomic, assign)BOOL isSelectMode;
@property (nonatomic, assign)id<HWMyCardViewControllerDelegate> delegate;


@end
