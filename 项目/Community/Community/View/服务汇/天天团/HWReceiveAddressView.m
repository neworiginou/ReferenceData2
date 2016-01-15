//
//  HWReceiveAddressView.m
//  Community
//
//  Created by ryder on 8/3/15.
//  Copyright (c) 2015 caijingpeng. All rights reserved.
//
//  功能描述：
//      天天团收货地址管理
//  修改记录：
//      姓名         日期              修改内容
//     程耀均     2015-08-3           创建文件

#import "HWReceiveAddressView.h"
#import "HWReceiveAddressCell.h"
#import "HWEditAddressViewController.h"
#import "UIView+Addtions.h"
#import "Utility.h"

@implementation HWReceiveAddressView

- (id)initWithFrame:(CGRect)frame style:(UITableViewStyle)style{
    
    self = [super initWithFrame:frame style:style];
    if (self) {
        self.separatorStyle = UITableViewCellSeparatorStyleNone;
    }
    return self;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    HWAddressInfo *model = self.dataList[indexPath.row];
    CGFloat h = [HWReceiveAddressCell getHeightWithModel:model];
    return h;
    
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return  self.dataList.count;
    
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    HWReceiveAddressCell *cell = [HWReceiveAddressCell cellWithTableView:tableView];
    cell.delegate = self;
    HWAddressInfo *model = [self.dataList pObjectAtIndex:indexPath.row];
    cell.addressModel = model;
    cell.isDefault = model.isDefault;
    [cell setCellHeight:[HWReceiveAddressCell getHeightWithModel:model]];
    return cell;
    
//    AddressCell *cell = [AddressCell cellWithTableView:tableView];
//    cell.delegate = self;
//    AddressModel *model = [self.dataList pObjectAtIndex:indexPath.row];
//    cell.addressModel = model;
//    cell.isDefault = model.isDefault;
//    [cell setCellHeight:[AddressCell getHeightWithModel:model]];
//    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    HWAddressInfo *addressModel = [self.dataList objectAtIndex:indexPath.row];
    if (_returnAdress) {
        _returnAdress(addressModel);
    }
//    HWReceiveAddressCell *cell =(HWReceiveAddressCell *) [tableView cellForRowAtIndexPath:indexPath];
//    cell.selected = YES;
//    
//    // 更新确认订单的页面的收货地址信息
//    if ([self.commondityDelegate respondsToSelector:@selector(updateReceiverInfo:)]) {
//        [self.commondityDelegate updateReceiverInfo:addressModel];
//    }
    
    
}
- (void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath {
    // Set background color of cell here if you don't want default white
    
}
#pragma mark - SWTableViewDelegate

- (void)swipeableTableViewCell:(SWTableViewCell *)cell scrollingToState:(SWCellState)state
{
    [MobClick event:@"slide_dizhiliebiao_left"];
    switch (state) {
        case 0:
            NSLog(@"utility buttons closed");
            break;
        case 1:
            NSLog(@"left utility buttons open");
            break;
        case 2:
            NSLog(@"right utility buttons open");
            //            cell.selected = YES;
            
            break;
        default:
            break;
    }
}

- (void)didSelectedEdit:(HWAddressManagerCell *)cell
{
    NSIndexPath *cellIndexpath = [self indexPathForCell:cell];
    HWAddressInfo *model = self.dataList[cellIndexpath.row];
    
    HWEditAddressViewController *editorController = [[HWEditAddressViewController alloc] init];
    [self.viewController.navigationController pushViewController:editorController animated:YES];
    editorController.addressModel = model;
}

- (void)didSelectedDelete:(HWAddressManagerCell *)cell
{
    NSIndexPath *cellIndexPath = [self indexPathForCell:cell];
    
    /*接口名称：删除地址
     接口地址：hw-sq-app-web/user/delReceiveAddressByUser.do
     入参：key,addressId
     出参：
     {"status":"1","data":null,"detail":"请求数据成功!","key":"788f4790-b3af-48ff-8e42-f60e30a5714e"} */
    
    AddressModel *model = self.dataList[cellIndexPath.row];
    [Utility showMBProgress:self message:@"删除中"];
    HWHTTPRequestOperationManager *manage = [HWHTTPRequestOperationManager manager];
    NSMutableDictionary *dict = [[NSMutableDictionary alloc] init];
    [dict setPObject:[HWUserLogin currentUserLogin].key forKey:@"key"];
    [dict setPObject:model.addressId forKey:@"addressId"];
    
    [manage POST:kTianTianTuanDelReceiveAddressByUser
      parameters:dict
           queue:nil
         success:^(id responseObject) {
        [Utility hideMBProgress:self];
        [Utility showToastWithMessage:@"删除成功" inView:self];
        if (_returnIsDelete) {
            _returnIsDelete(model.addressId);
        }
        [self.dataList removeObjectAtIndex:cellIndexPath.row];
        [self deleteRowsAtIndexPaths:@[cellIndexPath] withRowAnimation:UITableViewRowAnimationLeft];
        
    } failure:^(NSString *code, NSString *error) {
        NSLog(@"删除地址失败error %@",error);
        [Utility hideMBProgress:self];
        [Utility showToastWithMessage:error inView:self];
        
    }];
}

- (void)swipeableTableViewCell:(SWTableViewCell *)cell didTriggerRightUtilityButtonWithIndex:(NSInteger)index
{
    switch (index) {
        case 0:
        {
            [MobClick event:@"click_bianjidizhi "];
            NSIndexPath *cellIndexpath = [self indexPathForCell:cell];
            HWAddressInfo *model = self.dataList[cellIndexpath.row];
            
            HWEditAddressViewController *editController = [[HWEditAddressViewController alloc]init];
            [self.viewController.navigationController pushViewController:editController animated:YES];
            editController.addressModel = model;
            [cell hideUtilityButtonsAnimated:YES];
            break;
        }
        case 1:
        {
            // Delete button was pressed
            [MobClick event:@"click_shanchudizhi"];
            NSIndexPath *cellIndexPath = [self indexPathForCell:cell];
            /**
             *  入参：key，id 地址id 必填
             */
            HWAddressInfo *model = self.dataList[cellIndexPath.row];
            [Utility showMBProgress:self message:@"删除中"];
            HWHTTPRequestOperationManager *manage = [HWHTTPRequestOperationManager manager];
            NSMutableDictionary *dict = [[NSMutableDictionary alloc] init];
            [dict setPObject:[HWUserLogin currentUserLogin].key forKey:@"key"];
            [dict setPObject:model.addressId forKey:@"addressId"];
            [manage POST:kTianTianTuanDelReceiveAddressByUser
              parameters:dict
                   queue:nil
                 success:^(id responseObject) {
                    [Utility hideMBProgress:self];
                    [Utility showToastWithMessage:@"删除成功" inView:self];
//                    if (_returnIsDelete) {
//                        _returnIsDelete(model.addressId);
//                    }
                    [self.dataList removeObjectAtIndex:cellIndexPath.row];
                    [self deleteRowsAtIndexPaths:@[cellIndexPath] withRowAnimation:UITableViewRowAnimationLeft];
                
            } failure:^(NSString *code, NSString *error) {
                NSLog(@"删除地址失败error %@",error);
                [Utility hideMBProgress:self];
                [Utility showToastWithMessage:error inView:self];
                
            }];
            break;
        }
        default:
            break;
    }
}

- (BOOL)swipeableTableViewCellShouldHideUtilityButtonsOnSwipe:(SWTableViewCell *)cell
{
    // allow just one cell's utility button to be open at once
    return YES;
}

- (BOOL)swipeableTableViewCell:(SWTableViewCell *)cell canSwipeToState:(SWCellState)state
{
    switch (state) {
        case 1:
            // set to NO to disable all left utility buttons appearing
            return YES;
            break;
        case 2:
            // set to NO to disable all right utility buttons appearing
            return YES;
            break;
        default:
            break;
    }
    
    return YES;
}


@end

