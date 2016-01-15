//
//  HWAuthenticateWaitMailView.m
//  Community
//
//  Created by hw500027 on 15/6/15.
//  Copyright (c) 2015年 caijingpeng. All rights reserved.
//

#import "HWAuthenticateWaitMailView.h"

@interface HWAuthenticateWaitMailView()
{
    UIView *headView;
}
@end

@implementation HWAuthenticateWaitMailView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self)
    {
        self.isNeedHeadRefresh = YES;
        [self queryListData];
    }
    return self;
}

- (void)queryListData
{
    isLastPage = YES;
    [Utility hideMBProgress:self];
    [Utility showMBProgress:self message:@"请求数据"];
    
    
    NSMutableDictionary *parame = [[NSMutableDictionary alloc] init];
    [parame setPObject:[HWUserLogin currentUserLogin].key forKey:@"key"];
    
    HWHTTPRequestOperationManager *manager = [HWHTTPRequestOperationManager manager];
    [manager POST:kQueryAuthenticationInfo parameters:parame queue:nil success:^(id responese)
     {
         [Utility hideMBProgress:self];
         
         if ([[responese stringObjectForKey:@"status"] isEqual:@"1"])
         {
             NSMutableDictionary *dic = [[NSMutableDictionary alloc] initWithDictionary:[responese dictionaryObjectForKey:@"data"]];
             _dic = dic;
             [self configUI];
         }
         [self doneLoadingTableViewData];
     } failure:^(NSString *code, NSString *error)
     {
         [self doneLoadingTableViewData];
         [Utility hideMBProgress:self];
         [Utility showToastWithMessage:error inView:self];
     }];
}

- (void)addInfoView:(CGFloat)originY
{
    UIView *view = [UIView newAutoLayoutView];
    view.backgroundColor = [UIColor whiteColor];
    [headView addSubview:view];
    [view autoPinEdge:ALEdgeTop toEdge:ALEdgeTop ofView:headView withOffset:originY];
    [view autoPinEdge:ALEdgeLeft toEdge:ALEdgeLeft ofView:headView withOffset:0];
    [view autoPinEdge:ALEdgeRight toEdge:ALEdgeRight ofView:headView withOffset:0];
    
    //收件地址
    UILabel *addressLabel = [UILabel newAutoLayoutView];
    [view addSubview:addressLabel];
    addressLabel.numberOfLines = 0;
    
    if ([_dic stringObjectForKey:@"unitNo"] == 0 || [NSString stringWithFormat:@"%@",[_dic stringObjectForKey:@"unitNo"]].length == 0)
    {
        addressLabel.text = [NSString stringWithFormat:@"%@\n%@号楼%@室",[_dic stringObjectForKey:@"address"],[_dic stringObjectForKey:@"buildingNo"],[_dic stringObjectForKey:@"roomNo"]];//@"上海市虹口区景瑞路18号\n花园城40号楼203室";
    }
    else
    {
        addressLabel.text = [NSString stringWithFormat:@"%@\n%@号楼%@单元%@室",[_dic stringObjectForKey:@"address"],[_dic stringObjectForKey:@"buildingNo"],[_dic stringObjectForKey:@"unitNo"],[_dic stringObjectForKey:@"roomNo"]];//@"上海市虹口区景瑞路18号\n花园城40号楼203室";
    }
    
    addressLabel.font = FONT(15);
    addressLabel.textColor = THEME_COLOR_SMOKE;
    [addressLabel autoPinEdge:ALEdgeTop toEdge:ALEdgeTop ofView:view withOffset:15];
    [addressLabel autoPinEdge:ALEdgeLeft toEdge:ALEdgeLeft ofView:view withOffset:15];
    [addressLabel autoPinEdge:ALEdgeRight toEdge:ALEdgeRight ofView:view withOffset:- 15];
    [addressLabel setPreferredMaxLayoutWidth:kScreenWidth - 30];
    
    //中线
    UIView *midLine = [UIView newAutoLayoutView];
    [view addSubview:midLine];
    [midLine autoPinEdge:ALEdgeTop toEdge:ALEdgeBottom ofView:addressLabel withOffset:15];
    [midLine autoPinEdge:ALEdgeLeft toEdge:ALEdgeLeft ofView:view withOffset:15];
    [midLine autoPinEdge:ALEdgeRight toEdge:ALEdgeRight ofView:view withOffset:0];
    [midLine autoSetDimension:ALDimensionHeight toSize:0.5f];
    midLine.backgroundColor = THEME_COLOR_LINE;
    
    //收件人姓名
    UILabel *nameLabel = [UILabel newAutoLayoutView];
    [view addSubview:nameLabel];
    nameLabel.text = [NSString stringWithFormat:@"收件人：%@",[_dic stringObjectForKey:@"name"]];//@"收件人：王尼玛";
    nameLabel.font = FONT(15);
    nameLabel.textColor = THEME_COLOR_SMOKE;
    [nameLabel autoPinEdge:ALEdgeTop toEdge:ALEdgeBottom ofView:midLine withOffset:12];
    [nameLabel autoPinEdge:ALEdgeLeft toEdge:ALEdgeLeft ofView:view withOffset:15];
    [nameLabel autoPinEdge:ALEdgeBottom toEdge:ALEdgeBottom ofView:view withOffset:- 15];
    
    UILabel *phoneLabel = [UILabel newAutoLayoutView];
    [view addSubview:phoneLabel];
    phoneLabel.text = [_dic stringObjectForKey:@"mobile"];
    phoneLabel.font = FONT(15);
    phoneLabel.textColor = THEME_COLOR_SMOKE;
    phoneLabel.textAlignment = NSTextAlignmentRight;
    [phoneLabel autoPinEdge:ALEdgeLeft toEdge:ALEdgeRight ofView:nameLabel withOffset:0];
    [phoneLabel autoPinEdge:ALEdgeRight toEdge:ALEdgeRight ofView:view withOffset:-15];
    [phoneLabel autoPinEdge:ALEdgeTop toEdge:ALEdgeTop ofView:nameLabel withOffset:0];
    
    [Utility topLine:view];
    [Utility bottomLine:view];
}

//提示信息
- (CGFloat)addLabel
{
    UILabel *label = [UILabel newAutoLayoutView];
    [headView addSubview:label];
    label.text = @"正在焦急等待考拉君寄信...";
    label.textColor = THEME_COLOR_TEXT;
    label.font = FONT(14);
    label.numberOfLines = 0;
    [label setPreferredMaxLayoutWidth:kScreenWidth - 30];
    
    [label autoPinEdge:ALEdgeTop toEdge:ALEdgeTop ofView:headView withOffset:12];
    [label autoPinEdge:ALEdgeLeft toEdge:ALEdgeLeft ofView:headView withOffset:15];
    
    return 12 * 2 + [label systemLayoutSizeFittingSize:UILayoutFittingCompressedSize].height;
}

- (void)configUI
{
    headView = [[UIView alloc] initWithFrame:self.frame];
    self.baseTable.tableHeaderView = headView;
    //提示信息
    CGFloat height = [self addLabel];
    //收件人信息
    [self addInfoView:height];
}

@end
