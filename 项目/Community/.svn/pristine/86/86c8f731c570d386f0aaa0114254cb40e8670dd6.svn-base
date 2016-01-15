//
//  AddressTableView.m
//  Community
//
//  Created by hw500028 on 14/12/8.
//  Copyright (c) 2014年 caijingpeng. All rights reserved.
//

#import "AddressTableView.h"
#import "AddressCell.h"
#import "ModificationViewController.h"
#import "UIView+Addtions.h"
#import "Utility.h"


@implementation AddressTableView

- (id)initWithFrame:(CGRect)frame style:(UITableViewStyle)style{

    self = [super initWithFrame:frame style:style];
    if (self) {
        self.separatorStyle = UITableViewCellSeparatorStyleNone;
     
    }
    return self;
}




- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    AddressModel *model = self.dataList[indexPath.row];
    CGFloat h = [AddressCell getHeightWithModel:model];
    return h;
    
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
  return  self.dataList.count;

}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
        AddressCell *cell = [AddressCell cellWithTableView:tableView];
        cell.delegate = self;
        AddressModel *model = [self.dataList pObjectAtIndex:indexPath.row];
        cell.addressModel = model;
        cell.isDefault = model.isDefault;
        [cell setCellHeight:[AddressCell getHeightWithModel:model]];
        return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
        AddressModel *addressModel = [self.dataList objectAtIndex:indexPath.row];
        if (_returnAdress) {
            _returnAdress(addressModel);
        }
    AddressCell *cell =(AddressCell *) [tableView cellForRowAtIndexPath:indexPath];
    cell.selected = YES;
    
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
    AddressModel *model = self.dataList[cellIndexpath.row];
    
    ModificationViewController *modifyCtrl = [[ModificationViewController alloc]init];
    [self.viewController.navigationController pushViewController:modifyCtrl animated:YES];
    modifyCtrl.addressModel = model;
//    [cell hideUtilityButtonsAnimated:YES];
}

- (void)didSelectedDelete:(HWAddressManagerCell *)cell
{
    NSIndexPath *cellIndexPath = [self indexPathForCell:cell];
    /**
     *  入参：key，source，id 地址id 必填
     */
    AddressModel *model = self.dataList[cellIndexPath.row];
    [Utility showMBProgress:self message:@"删除中"];
    HWHTTPRequestOperationManager *manage = [HWHTTPRequestOperationManager cutManager];
    NSMutableDictionary *dict = [[NSMutableDictionary alloc] init];
    [dict setPObject:[HWUserLogin currentUserLogin].key forKey:@"key"];
    [dict setPObject:@"1" forKey:@"source"];
    [dict setPObject:model.addressId forKey:@"id"];
    [manage POST:KDelAddress parameters:dict queue:nil success:^(id responseObject) {
        [Utility hideMBProgress:self];
        [Utility showToastWithMessage:@"删除成功" inView:self];
        if (_returnIsDelete) {
            _returnIsDelete(model.addressId);
        }
        [self.dataList removeObjectAtIndex:cellIndexPath.row];
        [self deleteRowsAtIndexPaths:@[cellIndexPath] withRowAnimation:UITableViewRowAnimationLeft];
        
    } failure:^(NSString *code, NSString *error) {
        NSLog(@"error %@",error);
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
            AddressModel *model = self.dataList[cellIndexpath.row];

            ModificationViewController *modifyCtrl = [[ModificationViewController alloc]init];
            [self.viewController.navigationController pushViewController:modifyCtrl animated:YES];
            modifyCtrl.addressModel = model;
            [cell hideUtilityButtonsAnimated:YES];
            break;
        }
        case 1:
        {
            // Delete button was pressed
            [MobClick event:@"click_shanchudizhi"];
            NSIndexPath *cellIndexPath = [self indexPathForCell:cell];
            /**
             *  入参：key，source，id 地址id 必填
             */
            AddressModel *model = self.dataList[cellIndexPath.row];
            [Utility showMBProgress:self message:@"删除中"];
            HWHTTPRequestOperationManager *manage = [HWHTTPRequestOperationManager cutManager];
            NSMutableDictionary *dict = [[NSMutableDictionary alloc] init];
            [dict setPObject:[HWUserLogin currentUserLogin].key forKey:@"key"];
            [dict setPObject:@"1" forKey:@"source"];
            [dict setPObject:model.addressId forKey:@"id"];
            [manage POST:KDelAddress parameters:dict queue:nil success:^(id responseObject) {
                    [Utility hideMBProgress:self];
                    [Utility showToastWithMessage:@"删除成功" inView:self];
                if (_returnIsDelete) {
                    _returnIsDelete(model.addressId);
                }
                    [self.dataList removeObjectAtIndex:cellIndexPath.row];
                    [self deleteRowsAtIndexPaths:@[cellIndexPath] withRowAnimation:UITableViewRowAnimationLeft];
                
                } failure:^(NSString *code, NSString *error) {
                    NSLog(@"error %@",error);
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
