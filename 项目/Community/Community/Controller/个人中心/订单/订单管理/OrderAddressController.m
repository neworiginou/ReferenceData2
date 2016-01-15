//
//  OrderAddressController.m
//  Community
//
//  Created by hw500028 on 14/12/8.
//  Copyright (c) 2014年 caijingpeng. All rights reserved.
//

#import "OrderAddressController.h"
#import "Utility.h"
#import "UIViewExt.h"
#import "CreatAddressController.h"
#define kScreenHeight [UIScreen mainScreen].bounds.size.height
#define kScreenWidth  [UIScreen mainScreen].bounds.size.width


@interface OrderAddressController ()

@end

@implementation OrderAddressController
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
    self.tableView = [[AddressTableView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, CONTENT_HEIGHT - 50) style:UITableViewStylePlain];
    __weak OrderAddressController *myself = self;
    [myself.tableView setReturnAdress:^(AddressModel *addressModel) {
        if(_returnSelectedAddress) {
            _returnSelectedAddress(addressModel);
        }
        [myself.navigationController popViewControllerAnimated:YES];
        _addressModel = addressModel;
    }];
    
    [myself.tableView setReturnIsDelete:^(NSString *addressIdStr) {
        if(_deletedAddressId) {
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
- (void)initViews{
//    UIView *bottomView = [[UIView alloc]initWithFrame:CGRectMake(0, kScreenHeight - 50 - 64, kScreenWidth, 50)];
//    bottomView.backgroundColor = THEME_COLOR_ORANGE;
//    [self.view addSubview:bottomView];
    UIButton *creatButton = [UIButton buttonWithType:UIButtonTypeCustom];
    creatButton.frame = CGRectMake(0, kScreenHeight - 50 - 64, kScreenWidth, 50);
    [creatButton setButtonOrangeStyle];
    [creatButton setTitle:@"添加新地址" forState:UIControlStateNormal];
    creatButton.layer.cornerRadius = 0;
    [creatButton addTarget:self action:@selector(createAddress) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:creatButton];

}

#pragma mark Actions

//添加新地址
- (void)createAddress{

    NSLog(@"添加新地址");
    [MobClick event:@"click_xinzengdizhi"];
    CreatAddressController *createCtrl = [[CreatAddressController alloc]init];
    [self.navigationController pushViewController:createCtrl animated:YES];

}

#pragma mark Data
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    
}
- (void)queryListData
{
    [Utility showMBProgress:self.view message:@"获取数据"];
    
    HWHTTPRequestOperationManager *manage = [HWHTTPRequestOperationManager cutManager];
    NSMutableDictionary *dict = [[NSMutableDictionary alloc] init];
    [dict setPObject:[HWUserLogin currentUserLogin].key forKey:@"key"];
    [dict setPObject:@"1" forKey:@"source"];
    
    [manage POST:kOrderAddress parameters:dict queue:nil success:^(id responseObject) {
        
        [Utility hideMBProgress:self.view];
        [self.tableView.dataList removeAllObjects];
        NSArray *respList = [[responseObject dictionaryObjectForKey:@"data"] arrayObjectForKey:@"content"];
        for (NSDictionary *dic in respList) {
            AddressModel *model = [[AddressModel alloc] initWithDic:dic];
            [self.tableView.dataList addObject:model];
        }
        [self.tableView reloadData];
        
    } failure:^(NSString *code, NSString *error) {
        NSLog(@"error %@",error);
        [Utility hideMBProgress:self.view];
        [Utility showToastWithMessage:error inView:self.view];
        
    }];
}



- (void)dealloc
{
    [[NSNotificationCenter defaultCenter]removeObserver:self];

}


@end
