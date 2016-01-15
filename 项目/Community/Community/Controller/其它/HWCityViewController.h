//
//  HWCityViewController.h
//  Community
//
//  Created by caijingpeng.haowu on 14-9-6.
//  Copyright (c) 2014年 caijingpeng. All rights reserved.
//
//  城市列表
//

#import "HWBaseViewController.h"
#import "HWSearchBarView.h"

@interface HWCityViewController : HWBaseViewController<UITableViewDataSource, UITableViewDelegate, UISearchBarDelegate, UISearchDisplayDelegate, HWSearchBarViewDelegate,UIAlertViewDelegate>
{
    UIImageView *_refreshImgV;
    UITableView *mainTV;
    UITableView *mainSerachTv;
    NSIndexPath *selectCell;
    UIView *noCommentGpsLocationView;
}

@property (nonatomic, strong)NSArray *cityList;
@property (nonatomic, strong)NSMutableArray *chooseCities;
@property (nonatomic, strong)NSMutableArray *keys;
@property (nonatomic, strong)NSMutableDictionary *list;
@property (nonatomic, strong)NSString *selecedCityId;
@property (nonatomic, strong)NSString *selecedCityName;
@property (nonatomic, strong)NSMutableArray *hotCityArry;
@property (nonatomic, copy )void(^selectedCity)(NSString *cityId);
@property (nonatomic, assign)BOOL isRegisterChangeCity;
@property (nonatomic,strong)NSString *cityIdStrTemp;
- (void)startLocating;
@end
