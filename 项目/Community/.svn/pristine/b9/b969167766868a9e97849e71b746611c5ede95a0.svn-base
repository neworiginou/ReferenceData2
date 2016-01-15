//
//  HWShopListTableView.m
//  Community
//
//  Created by lizhongqiang on 15/4/8.
//  Copyright (c) 2015年 caijingpeng. All rights reserved.
//

#import "HWShopListTableView.h"

@interface HWShopListTableView ()
{
    NSString *_typeId;
    
}
@end

@implementation HWShopListTableView

- (instancetype)initWithFrame:(CGRect)frame typeId:(NSString *)type
{
    self = [super initWithFrame:frame];
    if (self)
    {
        _typeId = type;
        [self addCallStateNotification];
        [self queryListData];
    }
    return self;
}



- (void)queryListData
{
    [Utility showMBProgress:self message:LOADING_TEXT];
    HWUserLogin *user = [HWUserLogin currentUserLogin];
    HWHTTPRequestOperationManager *manage = [HWHTTPRequestOperationManager manager];
    NSMutableDictionary *dict = [[NSMutableDictionary alloc] init];
    [dict setPObject:user.villageId forKey:@"villageId"];
    [dict setPObject:user.key forKey:@"key"];
    [dict setPObject:_typeId forKey:@"type"];
    [dict setPObject:[NSString stringWithFormat:@"%d",kPageCount] forKey:@"size"];
    [dict setPObject:[NSString stringWithFormat:@"%d",self.currentPage] forKey:@"page"];
    
    [manage POST:KShopListByType parameters:dict queue:nil success:^(id responese) {
        [Utility hideMBProgress:self];
        NSDictionary *dict = [responese dictionaryObjectForKey:@"data"];
        NSDictionary *dictShop = [dict dictionaryObjectForKey:@"serviceGatherIndexVO"];
        NSArray *arrShop = [dictShop arrayObjectForKey:@"shop"];
        if (arrShop.count < kPageCount)
        {
            isLastPage = YES;
        }
        else
        {
            isLastPage = NO;
        }
        
        if (self.currentPage == 0)
        {
            [self.baseListArr removeAllObjects];
        }
        
        for (int i = 0; i < arrShop.count; i ++)
        {
            HWShopItemClass *shop = [[HWShopItemClass alloc] initWithDictionary:arrShop[i]];
            [self.baseListArr addObject:shop];
        }
        
        if (self.baseListArr.count > 0)
        {
            [self hideEmptyView];
        }
        else
        {
            [self showEmptyView:@"暂无数据"];
        }
        
        [self.baseTable reloadData];
        [self doneLoadingTableViewData];
    } failure:^(NSString *code, NSString *error) {
        [self doneLoadingTableViewData];
        [Utility hideMBProgress:self];
        [Utility showToastWithMessage:error inView:self];
    }];
}

#define tableview delegate
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.baseListArr.count;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 70.0f;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    HWServeTableViewCell *cell = (HWServeTableViewCell *)[tableView dequeueReusableCellWithIdentifier:@"cell"];
    if (!cell)
    {
        cell = [[HWServeTableViewCell alloc] init];
    }
    
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    
    cell.delegate = self;
    cell.tag = indexPath.row;
    [cell setCellDataWithShopItem:[self.baseListArr objectAtIndex:indexPath.row]];
    
    return cell;
}


#define cell delegate
- (void)callPhone:(int)index
{
    HWShopItemClass *shopItem = [self.baseListArr objectAtIndex:index];
    if (callWebView == nil)
    {
        callWebView = [[UIWebView alloc] init];
        [self addSubview:callWebView];
    }
    
    NSString *strPhone = @"";
    if (shopItem.mobileNumber.length > 0)
    {
        BOOL isPhone = [Utility validateMobile:shopItem.mobileNumber];
        if (isPhone) {
            strPhone = shopItem.mobileNumber;
        }
    }
    else if (shopItem.phoneNumber.length > 0)
    {
        strPhone = shopItem.phoneNumber;
    }
    
    if (strPhone.length <= 0)
    {
        [Utility showToastWithMessage:@"这个商店还没有电话哦~" inView:self];
        return;
    }
    
    
    strPhoneNumber = strPhone;
    strShopId = shopItem.shopId;
    
    NSURL *telURL = [NSURL URLWithString:[NSString stringWithFormat:@"tel:%@",strPhone]];
    [callWebView loadRequest:[NSURLRequest requestWithURL:telURL]];
    
}

#pragma mark -
#pragma mark HWServerCellDelegate

- (void)addCallStateNotification
{
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(dialingNotify:) name:HWCallDetectCenterStateDialingNotification object:nil];
}

- (void)removeCallStateNotification
{
    [[NSNotificationCenter defaultCenter] removeObserver:self name:HWCallDetectCenterStateDialingNotification object:nil];
}

#pragma mark -
#pragma mark HWCallDetectCenter Notification

- (void)dialingNotify:(NSNotification *)notification
{
    NSUserDefaults *userDefault = [NSUserDefaults standardUserDefaults];
    [userDefault setObject:@"1" forKey:kHaveDialing];
    
    // *** 发送接口
    
    NSMutableDictionary *param = [NSMutableDictionary dictionary];
    [param setPObject:[HWUserLogin currentUserLogin].key forKey:@"key"];
    [param setPObject:strPhoneNumber forKey:@"phoneCalled"];
    [param setPObject:strShopId forKey:@"toId"];
    
    [param setPObject:@"0" forKey:@"type"];         //0:拨打给店铺,1是拨打给物业
    [param setPObject:[HWUserLogin currentUserLogin].residendId forKey:@"residentId"];
    
    HWHTTPRequestOperationManager *manage = [HWHTTPRequestOperationManager manager];
    [manage POST:kMakeTelContent parameters:param queue:nil success:^(id responseObject) {
        
        NSLog(@"%@", responseObject);
        //        [Utility showToastWithMessage:@"cheng gong" inView:self.view];
        
    } failure:^(NSString *code, NSString *error) {
        NSLog(@"%@", error);
        //        [Utility showToastWithMessage:@"shi bai" inView:self.view];
    }];
    
//    _phoneNum = @"";
}

- (void)dealloc
{
//    [super dealloc];
    [self removeCallStateNotification];
}


- (void)selectCell:(int)index
{
    //去掉了详情页
}

@end
