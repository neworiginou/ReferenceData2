//
//  HWCommitHomeServiceView.m
//  Community
//
//  Created by niedi on 15/6/15.
//  Copyright (c) 2015年 caijingpeng. All rights reserved.
//

#import "HWCommitHomeServiceView.h"
#import "HWCommitHomeServiceCell.h"
#import "HWCommitHomeServiceCell1.h"
#import "HWServiceListDetailViewController.h"

@interface HWCommitHomeServiceView ()<HWCommitHomeServiceCellDelegate, HWCommitHomeServiceCell1Delegate, UITextFieldDelegate, UIScrollViewDelegate, UIAlertViewDelegate>
{
    NSInteger _selectedIndex;
    NSString *_serviceId;
    NSString *_serviceTime;
    NSString *_serviceType;
    NSString *_leaveMessage;
    NSArray *_leaveImgArr;
    NSString *_imgStr;
    NSString *_orderId;
    
    UITextField *phoneTF;
    NSString *phoneStr;
    UITextField *addressTF;
    NSString *addressStr;
    DLable *beiZhuLab;
}
@end

@implementation HWCommitHomeServiceView

- (instancetype)initWithFrame:(CGRect)frame serviceId:(NSString *)serviceId
{
    if (self = [super initWithFrame:frame])
    {
        _selectedIndex = -1;
        _serviceId = serviceId;
        _serviceType = @"3";
        
        [self loadUI];
        [self queryListData];
        [self.baseTable reloadData];
        
        [self performSelector:@selector(setTFBecomFirstRespon:) withObject:[NSNumber numberWithInteger:1] afterDelay:0.7];
    }
    
    return self;
}

- (void)setLeaveMessage:(NSString *)message imgStr:(NSString *)imgStr mongokeyArr:(NSArray *)mongokeyArr
{
    _leaveMessage = message;
    beiZhuLab.text = message;
    _imgStr = imgStr;
    _leaveImgArr = mongokeyArr;
}

- (void)queryListData
{
    /*接口：hw-sq-app-web/comeDoorService/showUserInfo.do 用户信息查询
     入参：key：用户key
     
     输出参数：
     {
     "status": "1",
     "data":
     { "mobile": "18717969623",电话 "buildingNo": "80",楼号 "unitNo": "1",单元号 "roomNo": "404",房间号 "villageName": 爱爱爱,小区名称 "houseId": 104631152 房屋id }
     
     ,
     "detail": "请求数据成功!",
     "key": "3a956781-6179-47af-8af3-d28d4554b87d"
     }*/
    
    NSMutableDictionary *param = [[NSMutableDictionary alloc]init];
    [param setPObject:[HWUserLogin currentUserLogin].key forKey:@"key"];
    
    HWHTTPRequestOperationManager *manager = [HWHTTPRequestOperationManager manager];
    [manager POST:KHomeServiceUserInfoCheck parameters:param queue:nil success:^(id responese)
     {
         NSLog(@"responese ========================= %@",responese);
         isLastPage = YES;
         
         NSDictionary *dict = [responese dictionaryObjectForKey:@"data"];
         phoneStr = [dict stringObjectForKey:@"mobile"];
         
         NSString *buildingNo = [dict stringObjectForKey:@"buildingNo"];
         NSString *unitNo = [dict stringObjectForKey:@"unitNo"];
         NSString *roomNo = [dict stringObjectForKey:@"roomNo"];
         NSString *villageName = [dict stringObjectForKey:@"villageName"];
         if (unitNo.length != 0)
         {
             addressStr = [NSString stringWithFormat:@"%@%@号%@单元%@室", villageName, buildingNo, unitNo, roomNo];
         }
         else
         {
             if (buildingNo.length != 0)
             {
                 addressStr = [NSString stringWithFormat:@"%@%@号%@室", villageName, buildingNo, roomNo];
             }
             else
             {
                 addressStr = [NSString stringWithFormat:@"%@", villageName];
             }
         }
         
         [self.baseTable reloadData];
         [self doneLoadingTableViewData];
     } failure:^(NSString *code, NSString *error) {
         [self doneLoadingTableViewData];
         [Utility showToastWithMessage:error inView:self];
     }];
}

- (void)loadUI
{
    DView *tableHeaderV = [DView viewFrameX:0 y:0 w:kScreenWidth h:10.0f];
    DImageV *line = [DImageV imagV:@"" frameX:0 y:9.5f w:kScreenWidth h:0.5f];
    line.backgroundColor = THEME_COLOR_LINE;
    [tableHeaderV addSubview:line];
    
    self.baseTable.tableHeaderView = tableHeaderV;
    
    DButton *commitRepairBtn = [DButton btnTxt:@"提交" txtFont:TF18 frameX:0 y:CONTENT_HEIGHT - 45.0f w:kScreenWidth h:45.0f target:self action:@selector(commitOrderBtnClick)];
    [commitRepairBtn setStyle:DBtnStyleMain];
    [self addSubview:commitRepairBtn];
}

- (void)commitOrderBtnClick
{
    if (phoneTF.text.length == 0)
    {
        [Utility showToastWithMessage:@"请输入手机号" inView:self];
        return;
    }
    
    if (phoneTF.text.length != 11)
    {
        [Utility showToastWithMessage:@"手机号输入有误" inView:self];
        return;
    }
    
    if (addressTF.text.length == 0)
    {
        [Utility showToastWithMessage:@"请输入服务地址" inView:self];
        return;
    }
    if (_serviceTime.length == 0)
    {
        [Utility showToastWithMessage:@"请输入服务时间" inView:self];
        return;
    }
    if (_serviceType.length == 0)
    {
        [Utility showToastWithMessage:@"请输入服务时间段" inView:self];
        return;
    }
    
    
    [self commitQuery];
}

- (void)commitQuery
{
    /*接口：hw-sq-app-web/comeDoorService/createComeServiceOrder.do 生成服务单
     入参：key：用户key，
     serviceId：服务id，
     serviceTimeSection：(0全天,1,上午,2下午,3晚上)
     serviceAddress：服务地址
     remark：用户留言
     remarkImages：留言图片，多张图片注意“,”分割
     mobileNumber：业主电话
     
     出参：
     { 'status': '1', 'data': '', 'detail': '请求数据成功!', 'key': '3e801f50-10d8-44d7-9ce7-83e57fe582f1' } */
    
    NSMutableDictionary *param = [[NSMutableDictionary alloc]init];
    [param setPObject:[HWUserLogin currentUserLogin].key forKey:@"key"];
    [param setPObject:_serviceId forKey:@"serviceId"];
    [param setPObject:_serviceType forKey:@"serviceTimeSection"];
    [param setPObject:[NSString stringWithFormat:@"%@ 00:00:00", _serviceTime] forKey:@"serviceTime"];
    [param setPObject:addressStr forKey:@"serviceAddress"];
    [param setPObject:_leaveMessage forKey:@"remark"];
    [param setPObject:_imgStr forKey:@"remarkImages"];
    [param setPObject:phoneStr forKey:@"mobileNumber"];
    
    HWHTTPRequestOperationManager *manager = [HWHTTPRequestOperationManager manager];
    [manager POST:KHomeServiceCommit parameters:param queue:nil success:^(id responese)
     {
         NSLog(@"responese ========================= %@",responese);
         isLastPage = YES;
         
         _orderId = [responese stringObjectForKey:@"data"];
         
         UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"成功提交订单" message:@"服务人员会在24小时内联系您确认信息，请注意接听电话" delegate:self cancelButtonTitle:@"确定" otherButtonTitles:@"查看订单", nil];
         [alert show];
         
     } failure:^(NSString *code, NSString *error) {
         
         [Utility showToastWithMessage:error inView:self];
     }];
}

#pragma mark - UIAlertViewDelegate
- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    if (buttonIndex == 1)
    {
        HWServiceListDetailViewController *vc = [[HWServiceListDetailViewController alloc] init];
        vc.orderID = _orderId;
        vc.pushType = pushHomeServiceDetailTypeWY;
        if (self.delegate && [self.delegate respondsToSelector:@selector(pushVC:)])
        {
            [self.delegate pushVC:vc];
        }
    }
    else if (buttonIndex == 0)
    {
        if (self.delegate && [self.delegate respondsToSelector:@selector(popVCAction)])
        {
            [self.delegate popVCAction];//点确定返回 上门服务前一页
        }
    }
}

#pragma mark - HWCommitHomeServiceCellDelegate
- (void)datePickerDateChanged:(NSDate *)date
{
    _serviceTime = [self getDateStr:date];
}

#pragma mark - HWCommitHomeServiceCell1Delegate
- (void)pickerDateChanged:(NSInteger)selectedRow
{
    if (selectedRow == 3)
    {
        _serviceType = [NSString stringWithFormat:@"%d", 0];
    }
    else
    {
        _serviceType = [NSString stringWithFormat:@"%ld", (long)selectedRow + 1];
    }
}

#pragma mark - UITableViewDelegate
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 2;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (section == 0)
    {
        return 4;
    }
    else
    {
        return 1;
    }
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSInteger row = indexPath.row;
    NSString *cellId = [NSString stringWithFormat:@"%ld", (long)row];
    
    if (indexPath.section == 0)
    {
        if (row == 0 || row == 1)
        {
            HWBaseTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellId];
            if (cell == nil)
            {
                cell = [[HWBaseTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellId];
                cell.selectionStyle = UITableViewCellSelectionStyleNone;
                [self creatCell:cell indexPath:indexPath.row];
            }
            
            if (row == 0)
            {
                phoneTF.text = phoneStr;
            }
            else if (row == 1)
            {
                addressTF.text = addressStr;
            }
            
            return cell;
        }
        else if (row == 2)
        {
            HWCommitHomeServiceCell *cell = [tableView dequeueReusableCellWithIdentifier:cellId];
            if (!cell)
            {
                cell = [[HWCommitHomeServiceCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellId];
                cell.selectionStyle = UITableViewCellSelectionStyleNone;
                cell.delegate = self;
            }
            return cell;
        }
        else if (row == 3)
        {
            HWCommitHomeServiceCell1 *cell = [tableView dequeueReusableCellWithIdentifier:cellId];
            if (!cell)
            {
                cell = [[HWCommitHomeServiceCell1 alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellId];
                cell.selectionStyle = UITableViewCellSelectionStyleNone;
                cell.delegate = self;
            }
            return cell;
        }
    }
    else
    {
        HWBaseTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellId];
        if (cell == nil)
        {
            cell = [[HWBaseTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellId];
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
            [self creatCell:cell indexPath:4];
        }
        return cell;
    }
    
    return nil;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSInteger row = indexPath.row;
    NSInteger selectRow = _selectedIndex;
    
    if (indexPath.section == 0)
    {
        if (row == 0 || row == 1)
        {
            return 45;
        }
        else if (row == 2)
        {
            return [HWCommitHomeServiceCell getCellHeight:selectRow == row ? NO : YES];
        }
        else if (row == 3)
        {
            return [HWCommitHomeServiceCell1 getCellHeight:selectRow == row ? NO : YES];
        }
    }
    else
    {
        return 45;
    }
    
    return 0;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSInteger row = indexPath.row;
    
    if (indexPath.section == 0)
    {
        if (row == 0)
        {
            if ([phoneTF isFirstResponder])
            {
                [phoneTF resignFirstResponder];
            }
            else
            {
                [self performSelector:@selector(setTFBecomFirstRespon:) withObject:[NSNumber numberWithInteger:row] afterDelay:0.2];
            }
        }
        else if (row == 1)
        {
            if ([addressTF isFirstResponder])
            {
                [addressTF resignFirstResponder];
            }
            else
            {
                [self performSelector:@selector(setTFBecomFirstRespon:) withObject:[NSNumber numberWithInteger:row] afterDelay:0.2];
            }
        }
    }
    else
    {
        if (self.delegate && [self.delegate respondsToSelector:@selector(cellClickForAddLeaveMessage:mongokeyArr:)])
        {
            [self.delegate cellClickForAddLeaveMessage:_leaveMessage mongokeyArr:_leaveImgArr];
        }
    }
    
    [self foldOrNotCell:YES index:_selectedIndex];
    
    if (_selectedIndex != indexPath.row)
    {
        [self foldOrNotCell:NO index:indexPath.row];
        _selectedIndex = indexPath.row;
    }
    else
    {
        _selectedIndex = -1;
    }
}

- (void)setTFBecomFirstRespon:(NSNumber *)rowValue
{
    NSInteger row = [rowValue integerValue];
    if (row == 0)
    {
        [phoneTF becomeFirstResponder];
    }
    else if (row == 1)
    {
        [addressTF becomeFirstResponder];
    }
}

- (void)foldOrNotCell:(BOOL)isFold index:(NSInteger)row
{
    NSIndexPath *indexPath = [NSIndexPath indexPathForRow:row inSection:0];
    if (row == 2)
    {
        HWCommitHomeServiceCell *cell = (HWCommitHomeServiceCell *)[self.baseTable cellForRowAtIndexPath:indexPath];
        [cell setFold:isFold];
        [self.baseTable reloadData];
    }
    else if (row == 3)
    {
        HWCommitHomeServiceCell1 *cell = (HWCommitHomeServiceCell1 *)[self.baseTable cellForRowAtIndexPath:indexPath];
        [cell setFold:isFold];
        [self.baseTable reloadData];
    }
}

- (void)creatCell:(HWBaseTableViewCell *)cell indexPath:(NSInteger)row
{
    DLable *leftLab = [DLable LabTxt:@"" txtFont:TF15 txtColor:THEME_COLOR_SMOKE frameX:15 y:15 w:200 h:15];
    [cell.contentView addSubview:leftLab];
    
    DImageV *line = [DImageV imagV:@"" frameX:0 y:44.5f w:kScreenWidth h:0.5f];
    line.backgroundColor = THEME_COLOR_LINE;
    [cell addSubview:line];
    
    if (row == 0)
    {
        leftLab.text = @"联系电话";
        phoneTF = [DTxtField fieldTxt:phoneStr frameX:90 y:15 w:kScreenWidth - 90 - 36 h:20];
        phoneTF.font = [UIFont fontWithName:FONTNAME size:TF15];
        phoneTF.textColor = THEME_COLOR_TEXT;
        phoneTF.keyboardType = UIKeyboardTypePhonePad;
        phoneTF.delegate = self;
        [cell addSubview:phoneTF];
    }
    else if (row == 1)
    {
        leftLab.text = @"服务地址";
        addressTF = [DTxtField fieldTxt:addressStr frameX:90 y:15 w:kScreenWidth - 90 - 36 h:20];
        addressTF.font = [UIFont fontWithName:FONTNAME size:TF15];
        addressTF.textColor = THEME_COLOR_TEXT;
        addressTF.delegate = self;
        [cell addSubview:addressTF];
    }
    else if (row == 4)
    {
        leftLab.text = @"备注";
        
        beiZhuLab = [DLable LabTxt:_leaveMessage txtFont:TF15 txtColor:THEME_COLOR_TEXT frameX:90 y:12 w:kScreenWidth - 90 - 36 h:19];
        beiZhuLab.numberOfLines = 1;
        beiZhuLab.textAlignment = NSTextAlignmentLeft;
        [cell addSubview:beiZhuLab];
        
        DImageV *rightImg = [DImageV imagV:@"arrow" frameX:kScreenWidth - 9 - 15 y:(45.0f - 16.0f) / 2.0f w:9 h:16];
        [cell addSubview:rightImg];
    }
}

#pragma mark - UIScrollViewDelegate
- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    [super scrollViewDidScroll:scrollView];
    [self endEditing:YES];
}

#pragma mark - UITextFieldDelegate
- (BOOL)textFieldShouldBeginEditing:(UITextField *)textField
{
    return YES;
}

- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string
{
    if (textField == phoneTF)
    {
        if ([string isEqualToString:@""])
        {
            return YES;
        }
        else
        {
            NSMutableString *tmpStr = [NSMutableString stringWithString:textField.text];
            [tmpStr replaceCharactersInRange:range withString:string];
            if (tmpStr.length > 11)
            {
                return NO;
            }
            else
            {
                return YES;
            }
        }
    }
    return YES;
}

- (BOOL)textFieldShouldEndEditing:(UITextField *)textField
{
    if (textField == addressTF)
    {
        addressStr = textField.text;
    }
    
    if (textField == phoneTF)
    {
        phoneStr = textField.text;
    }
    
    return YES;
}



- (NSString *)getDateStr:(NSDate *)date
{
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    formatter.dateFormat = @"yyyy-MM-dd";
    NSString *dateStr = [formatter stringFromDate:date];
    return dateStr;
}

@end
