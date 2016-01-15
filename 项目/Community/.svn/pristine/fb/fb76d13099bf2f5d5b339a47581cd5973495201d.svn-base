//
//  HWReceiveAddressViewController.m
//  Community
//
//  Created by ryder on 8/3/15.
//  Copyright (c) 2015 caijingpeng. All rights reserved.
//
//  功能描述：
//      天天团收货地址管理页面
//  修改记录：
//      姓名         日期              修改内容
//     程耀均     2015-07-30           创建文件

#import "HWReceiveAddressViewController.h"
#import "Utility.h"
#import "UIViewExt.h"
#import "HWAddReceiveAddressController.h"

@implementation HWReceiveAddressViewController
@synthesize _addressModel;

- (id)init
{
    if (self = [super init])
    {
        [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(queryListData) name:@"refresh" object:nil];
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    //标示是否选择地址
    self.navigationItem.titleView = [Utility navTitleView:@"选择收货地址"];
    self.navigationItem.leftBarButtonItem = [Utility navLeftBackBtn:self action:@selector(backMethod)];
    self.tableView = [[HWReceiveAddressView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, CONTENT_HEIGHT - 50) style:UITableViewStylePlain];
    
    __weak HWReceiveAddressViewController *myself = self;
    [myself.tableView setReturnAdress:^(HWAddressInfo *addressModel) {
        
        if(_returnSelectedAddress)
        {
            _returnSelectedAddress(addressModel);
        }
        
        [myself.navigationController popViewControllerAnimated:YES];
        _addressModel = addressModel;
        if ([self.commondityDelegate respondsToSelector:@selector(updateReceiverInfo:)])
        {
            [self.commondityDelegate updateReceiverInfo:addressModel];
        }
    }];
    
    [myself.tableView setReturnIsDelete:^(NSString *addressIdStr) {
        if(_deletedAddressId)
        {
            _deletedAddressId(addressIdStr);
        }
        [myself.navigationController popViewControllerAnimated:YES];
    }];
    [self.view addSubview:self.tableView];
    [self initViews];
    //加载数据
    
    [self queryListData];
}
#pragma mark - Views
- (void)initViews
{
    UIButton *creatButton = [UIButton buttonWithType:UIButtonTypeCustom];
    creatButton.frame = CGRectMake(0, kScreecHeight - 50 - 64, kScreenWidth, 50);
    [creatButton setButtonOrangeStyle];
    [creatButton setTitle:@"添加新地址" forState:UIControlStateNormal];
    creatButton.layer.cornerRadius = 0;
    [creatButton addTarget:self action:@selector(createAddress) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:creatButton];
}

#pragma mark Actions

//添加新地址
- (void)createAddress
{
    NSLog(@"添加新地址");
    [MobClick event:@"click_xinzengdizhi"];
    HWAddReceiveAddressController *addController = [[HWAddReceiveAddressController alloc]init];
    [self.navigationController pushViewController:addController animated:YES];
}

#pragma mark Data
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    
}

- (void)queryListData
{
    /*接口名称：收货地址列表
     接口地址：hw-sq-app-web/user/showReceiveAddressByUser.do
     入参：key,page,size
     出参：{
     "status": "1",
     "data": {
     "content": [
     { "addressId": 2069710,地址id "userId": 1030431030435,用户id "isDefault": null,是否默认地址 "name": "dddd",收货人姓名 "province": "fff",省 "city": "eee",市 "area": "rrr",区 "address": "abcdeddf",详细地址 "mobile": "15821114540",电话 }
     
     ],
     "size": 10,
     "number": 0,
     "sort": null,
     "totalElements": 1,
     "lastPage": true,
     "firstPage": true,
     "totalPages": 1,
     "numberOfElements": 1
     },
     "detail": "请求数据成功!",
     "key": "788f4790-b3af-48ff-8e42-f60e30a5714e"
     }*/
    
    HWHTTPRequestOperationManager *manage = [HWHTTPRequestOperationManager manager];
    NSMutableDictionary *dict = [[NSMutableDictionary alloc] init];
    [dict setPObject:[HWUserLogin currentUserLogin].key forKey:@"key"];
    
    [manage POST:kTianTianTuanShowReceiveAddressByUser parameters:dict queue:nil success:^(id responseObject) {
        
        [Utility hideMBProgress:self.view];
        
        [self.tableView.dataList removeAllObjects];
        HWReceiveAddressModel *model = [[HWReceiveAddressModel alloc] initWithDictionary:responseObject];
        
        for (HWAddressInfo *addressModel in model.addressArray)
        {
            if ([self.selectedAddressId isEqualToString: addressModel.addressId])
            {
                addressModel.isSelected = @"1";
            }
        }
        
        self.tableView.dataList = model.addressArray;
        [self.tableView reloadData];
        
        NSLog(@"地址管理....%@", responseObject);
        
    } failure:^(NSString *code, NSString *error) {
        
        NSLog(@"地址管理错误error %@",error);
        [Utility hideMBProgress:self.view];
        [Utility showToastWithMessage:error inView:self.view];
    }];
}



@end
