//
//  HWPersonInfoViewController.h
//  Community
//
//  Created by gusheng on 14-9-1.
//  Copyright (c) 2014年 caijingpeng. All rights reserved.
//

#import "HWBaseViewController.h"
#import "HWPersonInfoHeadView.h"

@interface HWPersonInfoViewController : HWBaseViewController<UITableViewDataSource,UITableViewDelegate,UIImagePickerControllerDelegate,UIActionSheetDelegate,UINavigationControllerDelegate>
{
    UITableView *personInfoTableView;
    HWPersonInfoHeadView *personInfoView;
    NSMutableDictionary *listDataDic;
    NSMutableDictionary *imageDataDic;
    UIView * view;
}

@property (nonatomic, strong)NSString *noReadNumStr;

@end
