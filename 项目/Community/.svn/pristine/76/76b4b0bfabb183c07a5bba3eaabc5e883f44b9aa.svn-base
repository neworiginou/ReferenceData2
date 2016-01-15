//
//  BaseTableview.m
//  Community
//
//  Created by hw500028 on 14/12/8.
//  Copyright (c) 2014年 caijingpeng. All rights reserved.
//

#import "BaseTableview.h"

@implementation BaseTableview

- (id)initWithFrame:(CGRect)frame style:(UITableViewStyle)style{
    self = [super initWithFrame:frame style:style];
    if (self) {
        self.dataSource =self;
        self.delegate = self;
        _dataList = [[NSMutableArray alloc] init];
    }
    return self;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.dataList.count;

}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{

    UITableViewCell *cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:nil];
    return cell;

}


@end
