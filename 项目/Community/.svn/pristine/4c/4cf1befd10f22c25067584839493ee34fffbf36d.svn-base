//
//  HWOrderTypeVC.h
//  Community
//
//  Created by lizhongqiang on 14-9-3.
//  Copyright (c) 2014年 caijingpeng. All rights reserved.
//  预约物业上门维修  服务类型

#import "HWBaseViewController.h"
#import "HWServerTypeCell.h"
#import "HWOrderData.h"
#import "HWServiceBaseDataClass.h"

@protocol HWOrderTypeVCDelegeate <NSObject>

- (void)getOrderType;

@end



@interface HWOrderTypeVC : HWBaseViewController<UICollectionViewDataSource,UICollectionViewDelegate,UITextViewDelegate,UICollectionViewDelegateFlowLayout>
{
    
    UITextView *customText;                 //自定义问题输入
    NSString *strQuestion;                  //问题
    BOOL isCustom;                          //是否自定义
}

@property (nonatomic, assign) id <HWOrderTypeVCDelegeate> delegate;

@end
