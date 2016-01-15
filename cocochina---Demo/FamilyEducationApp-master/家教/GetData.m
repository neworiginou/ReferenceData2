//
//  GetData.m
//  家教
//
//  Created by goofygao on 15/11/14.
//  Copyright © 2015年 goofyy. All rights reserved.
//

#import "GetData.h"


@interface GetData ()

@property (nonatomic, strong) NSMutableArray *statuses;

@end

@implementation GetData

- (instancetype)init
{
    self = [super init];
    if (self) {
        [self loadMoreStatus];
    }
    return self;
}

//@property (nonatomic, strong) NSMutableArray *statuses;
- (NSMutableArray *)statuses
{
    if (_statuses == nil) {
        _statuses = [NSMutableArray array];
    }
    return _statuses;
}

- (void)loadMoreStatus
{
    // 创建请求管理者
    AFHTTPRequestOperationManager *mgr = [AFHTTPRequestOperationManager manager];
    // 创建一个参数字典
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    if (self.statuses.count) { // 有微博数据，才需要下拉刷新
//        long long maxId = [[[self.statuses lastObject] idstr] longLongValue] - 1;
        params[@"num"] = @"0";
    }
    
    // 发送get请求
    [mgr POST:@"http://115.29.54.119:888/Post/requryInfo" parameters:params success:^(AFHTTPRequestOperation *operation, id responseObject) { // 请求成功的时候调用
        
        // 结束上拉刷新
//        [self.tableView footerEndRefreshing];
        
        // 获取到微博数据 转换成模型
        // 获取微博字典数组
        NSArray *dictArr = responseObject[@"stu"];
        // 把字典数组转换成模型数组
        NSArray *statuses = (NSMutableArray *)[Student objectArrayWithKeyValuesArray:dictArr];
        
        // 把数组中的元素添加进去
        [self.statuses addObjectsFromArray:statuses];
        
        // 刷新表格
//        [self.tableView reloadData];
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        
    }];
    
}





@end
