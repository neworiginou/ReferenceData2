//
//  BARightTableView.m
//  酒吧助手
//
//  Created by 叶星龙 on 15/5/22.
//  Copyright (c) 2015年 北京局外者科技有限公司. All rights reserved.
//

#import "BARightTableView.h"
#import "BARightCell.h"
#import "Header.h"
@interface BARightTableView ()<UITableViewDelegate,UITableViewDataSource>


@end

@implementation BARightTableView


-(id)initWithFrame:(CGRect)frame
{
    self =[super initWithFrame:frame];
    if (self) {
        self.dataSource=self;
        self.delegate=self;
        
       
       
    }
    
    return self;
}




- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    
    return _rightArray.count;
    
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    BARightCell *cell =[BARightCell cellWithTableView:tableView];
    cell.TapActionBlock=^(NSInteger pageIndex ,NSInteger money,NSString *key){
        if ([self.rightDelegate respondsToSelector:@selector(quantity:money:key:)]) {
            [self.rightDelegate quantity:pageIndex money:money key:key];
        }
        
    };
    
    cell.backgroundColor=UIColorRGBA(246, 246, 246, 1);
    cell.rightData=_rightArray[indexPath.row];
    return cell;
 
    
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    
}

@end
// 版权属于原作者
// http://code4app.com (cn) http://code4app.net (en)
// 发布代码于最专业的源码分享网站: Code4App.com