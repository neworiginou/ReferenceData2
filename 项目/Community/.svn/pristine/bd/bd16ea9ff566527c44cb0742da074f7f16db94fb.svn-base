//
//  HWInviteCustomView.m
//  Community
//
//  Created by niedi on 15/6/12.
//  Copyright (c) 2015年 caijingpeng. All rights reserved.
//

#import "HWInviteCustomView.h"
#import "HWInviteCustomCell.h"
#import "HWInviteCustomCell1.h"
#import "HWInviteCustomCell2.h"
#import "HWInviteCustomSuccedVC.h"
#import "HWInviteCustomSuccedModel.h"

@interface HWInviteCustomView ()<HWInviteCustomCellDelegate, HWInviteCustomCell1Delegate, HWInviteCustomCell2Delegate, UIAlertViewDelegate, UITextFieldDelegate, UIScrollViewDelegate>
{
    HWInviteCustomRecordModel *_recordModel;
    
    NSInteger _selectedIndex;
    
    NSString *_dayLengthStr;
    NSString *_dateStr;
    NSString *_customIdentityStr;
    
    DTxtField *customNumTF;
    DTxtField *phoneTF;
    DTxtField *nameTF;
    DLable *xuanTianLab;
    DImageV *downImg;
}
@end

@implementation HWInviteCustomView

- (instancetype)initWithFrame:(CGRect)frame recordModel:(HWInviteCustomRecordModel *)recordModel
{
    if (self = [super initWithFrame:frame])
    {
        _recordModel = recordModel;
        
        _selectedIndex = -1;
        _dayLengthStr = @"当天";
        self.isNeedHeadRefresh = NO;
        [self loadUI];
        
        if (_recordModel != nil)
        {
            _customIdentityStr = _recordModel.relationship;
            [self performSelector:@selector(loadData) withObject:[NSNumber numberWithInteger:0] afterDelay:0.4];
        }
        
        [self performSelector:@selector(setTFBecomFirstRespon:) withObject:[NSNumber numberWithInteger:0] afterDelay:0.6];
    }
    return self;
}

- (void)loadData
{
    phoneTF.text = _recordModel.visitorMobile;
    nameTF.text = _recordModel.visitorName;
    customNumTF.text = _recordModel.visitorCount;
    if (_recordModel.visitorCount.length != 0)
    {
        xuanTianLab.hidden = YES;
    }
}

- (void)queryListDataForCommit
{
    /*URL:/hw-sq-app-web/visitor/addVisitor.do
     入参：
     key
    / 访客 名字 /
    private String visitorName ;
    /来访者 手机号码/
    private String visitorTel ;
    /预约 日期/
    @DateTimeFormat(pattern = "yyyy-MM-dd HH:mm:ss")
    private Date orderDate ;
    /有效期/
    private String validity ;   :1、2、3、7、-1
    /来访人员和业主关系/
    private String relationship;   : 直接传
    /来访人员人数/
    private Integer visitorCount ;
    出参：
    /访客手机/
    private String visitorMobile ;
    /访问小区/
    private String villageName ;
    /开始日期/
    private String visitorDate ;
    /有效天数/
    private String dateCount;
    /二维码/
    private String zxing;
    /访客名字/
    private String visitorName;
    /访客关系/
    private String relationship;
    /预约来访 – 0没有到访 1有到访/
    private String isVisit;
    /是否过期 — 0显示绿色 1显示灰色/
    private String isPast;
    /是否无效 ---- 0有效邀请 1无效邀请/
    private String isValid;
    /访客表id/
    private Long tvId;
    /按钮状态 ---------0显示 1显示/
    private String buttonStatus;
    /大于6个长期访客 ------ 0显示 1不显示/
    private String SixConunt;*/
    
    [Utility showMBProgress:self message:LOADING_TEXT];
    NSMutableDictionary *param = [[NSMutableDictionary alloc]init];
    [param setPObject:[HWUserLogin currentUserLogin].key forKey:@"key"];
    [param setPObject:nameTF.text forKey:@"visitorName"];
    [param setPObject:phoneTF.text forKey:@"visitorTel"];
    [param setPObject:[NSString stringWithFormat:@"%@ 00:00:00", _dateStr] forKey:@"orderDate"];
    [param setPObject:[self getValidity] forKey:@"validity"];
    [param setPObject:_customIdentityStr forKey:@"relationship"];
    NSString *customNumStr = customNumTF.text.length == 0 ? @"1" : customNumTF.text;
    [param setPObject:customNumStr forKey:@"visitorCount"];
    
    HWHTTPRequestOperationManager *manager = [HWHTTPRequestOperationManager manager];
    [manager POST:KInviteCustomCommit parameters:param queue:nil success:^(id responese)
     {
         [Utility hideMBProgress:self];
         
         NSDictionary *dict = [responese dictionaryObjectForKey:@"data"];
         HWInviteCustomSuccedModel *model = [[HWInviteCustomSuccedModel alloc] initWithDict:dict];
         
         HWInviteCustomSuccedVC *sVC = [[HWInviteCustomSuccedVC alloc] init];
         if (_recordModel != nil)
         {
             sVC.isExtend = YES;
         }
         else
         {
             sVC.isExtend = NO;
         }
         sVC.model = model;
         if (self.delegate && [self.delegate respondsToSelector:@selector(pushViewController:)])
         {
             [self.delegate pushViewController:sVC];
         }
         
         [self doneLoadingTableViewData];
     }
          failure:^(NSString *code, NSString *error)
     {
         [Utility hideMBProgress:self];
         [Utility showToastWithMessage:error inView:self];
         [self doneLoadingTableViewData];
     }];
}

- (NSString *)getValidity
{
    if ([_dayLengthStr isEqualToString:@"当天"])
    {
        return @"1";
    }
    else if ([_dayLengthStr isEqualToString:@"两天"])
    {
        return @"2";
    }
    else if ([_dayLengthStr isEqualToString:@"三天"])
    {
        return @"3";
    }
    else if ([_dayLengthStr isEqualToString:@"一周"])
    {
        return @"7";
    }
    else if ([_dayLengthStr isEqualToString:@"长期访客"])
    {
        return @"-1";
    }
    return @"";
}

//通讯录返回数据
- (void)phoneBookSet:(NSString *)phoneNum name:(NSString *)name
{
    NSCharacterSet *set = [NSCharacterSet characterSetWithCharactersInString:@"-"];
    NSString *phoneNumStr = [[phoneNum componentsSeparatedByCharactersInSet:set]componentsJoinedByString:@""];
    
    phoneTF.text = phoneNumStr;
    
    nameTF.text = name;
}

//访问通讯录
- (void)phoneBookBtnClick
{
    if (self.delegate && [self.delegate respondsToSelector:@selector(visitPhoneBook)])
    {
        [self.delegate visitPhoneBook];
    }
}

- (void)loadUI
{
    DView *tableHeaderV = [DView viewFrameX:0 y:0 w:kScreenWidth h:10.0f];
    DImageV *line = [DImageV imagV:@"" frameX:0 y:9.5f w:kScreenWidth h:0.5f];
    line.backgroundColor = THEME_COLOR_LINE;
    [tableHeaderV addSubview:line];
    
    self.baseTable.tableHeaderView = tableHeaderV;
    
    DButton *buttomBtn = [DButton btnTxt:@"邀请" txtFont:TF19 frameX:0 y:CONTENT_HEIGHT - 45.0f w:kScreenWidth h:45.0f target:self action:@selector(inviteBtnClick)];
    [buttomBtn setStyle:DBtnStyleMain];
    [self addSubview:buttomBtn];
}

- (void)inviteBtnClick
{
    [self endEditing:YES];
    
    if ([HWUserLogin verifyIsAuthenticationWithPopVC:self.fatherVC showAlert:YES])
    {
        if (phoneTF.text.length == 0)
        {
            [Utility showToastWithMessage:@"请输入访客手机号" inView:self];
            return;
        }
        
        if (phoneTF.text.length != 11)
        {
            [Utility showToastWithMessage:@"访客手机号输入有误" inView:self];
            return;
        }
        
        if (nameTF.text.length == 0)
        {
            [Utility showToastWithMessage:@"请输入访客称呼" inView:self];
            return;
        }
        
        if (_dateStr.length == 0)
        {
            [Utility showToastWithMessage:@"请选择来访时间" inView:self];
            return;
        }
        
        if (_dayLengthStr.length == 0)
        {
            [Utility showToastWithMessage:@"请选择来访有效期" inView:self];
            return;
        }
        
        if ([_dayLengthStr isEqualToString:@"长期访客"])
        {
            [self showInviteAlert:[NSString stringWithFormat:@"邀请 %@ (%@) 为%@长期访客", nameTF.text, phoneTF.text, [[HWUserLogin currentUserLogin] villageName]]];
        }
        else
        {
            [self showInviteAlert:[NSString stringWithFormat:@"邀请 %@ (%@) %@来%@访问", nameTF.text, phoneTF.text, _dateStr, [[HWUserLogin currentUserLogin] villageName]]];
        }
    }
}

- (void)showInviteAlert:(NSString *)str
{
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:nil message:str delegate:self cancelButtonTitle:@"取消" otherButtonTitles:@"邀请", nil];
    alert.delegate = self;
    [alert show];
}

- (NSString *)getDateStr:(NSDate *)date
{
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    formatter.dateFormat = @"yyyy-MM-dd";
    NSString *dateStr = [formatter stringFromDate:date];
    return dateStr;
}

#pragma mark - UIAlertViewDelegate
- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    if (buttonIndex == 0)
    {
        
    }
    else
    {
        
        [self queryListDataForCommit];
    }
}

#pragma mark - CellDelegate
- (void)datePickerDateChanged:(NSDate *)date
{
    _dateStr = [self getDateStr:date];
}

- (void)getSlideChoseDateString:(NSString *)dateStr
{
    _dayLengthStr = dateStr;
}

- (void)didSelectBtn:(NSString *)btnTitle
{
    _customIdentityStr = btnTitle;
}

#pragma mark - UIScrollViewDelegate
- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    [super scrollViewDidScroll:scrollView];
    [self endEditing:YES];
}

#pragma mark - tableViewDelegate
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 6;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSInteger row = indexPath.row;
    NSString *cellId = [NSString stringWithFormat:@"%ld", (long)row];
    if (row == 0 || row == 1 || row == 5)
    {
        HWBaseTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellId];
        if (cell == nil)
        {
            cell = [[HWBaseTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellId];
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
            [self creatCell:cell indexPath:indexPath.row];
        }
        return cell;
    }
    else if (row == 2)
    {
        HWInviteCustomCell *cell = [tableView dequeueReusableCellWithIdentifier:cellId];
        if (!cell)
        {
            cell = [[HWInviteCustomCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellId];
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
            cell.delegate = self;
        }
        return cell;
    }
    else if (row == 3)
    {
        HWInviteCustomCell1 *cell = [tableView dequeueReusableCellWithIdentifier:cellId];
        if (!cell)
        {
            cell = [[HWInviteCustomCell1 alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellId];
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
            cell.delegate = self;
        }
        return cell;
    }
    else if (row == 4)
    {
        HWInviteCustomCell2 *cell = [tableView dequeueReusableCellWithIdentifier:cellId];
        if (!cell)
        {
            cell = [[HWInviteCustomCell2 alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellId];
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
            cell.delegate = self;
        }
        
        if (_customIdentityStr.length != 0)
        {
            [cell setBtnSelectedWithTitle:_customIdentityStr];
        }
        
        return cell;
    }
    return nil;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSInteger row = indexPath.row;
    NSInteger selectRow = _selectedIndex;
    
    if (row == 0 || row == 1 || row == 5)
    {
        return 45;
    }
    else if (row == 2)
    {
        return [HWInviteCustomCell getCellHeight:selectRow == row ? NO : YES];
    }
    else if (row == 3)
    {
        return [HWInviteCustomCell1 getCellHeight:selectRow == row ? NO : YES];
    }
    else if (row == 4)
    {
        return [HWInviteCustomCell2 getCellHeight:selectRow == row ? NO : YES];
    }
    
    return 0;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSInteger row = indexPath.row;
    NSInteger selectRow = _selectedIndex;
    
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
    if (row == 1)
    {
        if ([nameTF isFirstResponder])
        {
            [nameTF resignFirstResponder];
        }
        else
        {
            [self performSelector:@selector(setTFBecomFirstRespon:) withObject:[NSNumber numberWithInteger:row] afterDelay:0.2];
        }
    }
    if (row == 5)
    {
        if ([customNumTF isFirstResponder])
        {
            [customNumTF resignFirstResponder];
        }
        else
        {
            [self performSelector:@selector(setTFBecomFirstRespon:) withObject:[NSNumber numberWithInteger:row] afterDelay:0.2];
        }
    }
    
    if (_selectedIndex != -1)
    {
        _selectedIndex = -1;
        [self foldOrNotCell:YES index:selectRow];
    }
    
    if (selectRow != indexPath.row)
    {
        _selectedIndex = row;
        [self foldOrNotCell:NO index:row];
    }
}

- (void)setTFBecomFirstRespon:(NSNumber *)rowValue
{
    NSInteger row = [rowValue integerValue];
    if (row == 5)
    {
        [customNumTF becomeFirstResponder];
    }
    else if (row == 0)
    {
        [phoneTF becomeFirstResponder];
    }
    else if (row == 1)
    {
        [nameTF becomeFirstResponder];
    }
}

- (void)foldOrNotCell:(BOOL)isFold index:(NSInteger)row
{
    NSIndexPath *indexPath = [NSIndexPath indexPathForRow:row inSection:0];
    if (row == 2)
    {
        HWInviteCustomCell *cell = (HWInviteCustomCell *)[self.baseTable cellForRowAtIndexPath:indexPath];
        [cell setFold:isFold];
        [self.baseTable reloadData];
    }
    else if (row == 3)
    {
        HWInviteCustomCell1 *cell = (HWInviteCustomCell1 *)[self.baseTable cellForRowAtIndexPath:indexPath];
        [cell setFold:isFold];
        [self.baseTable reloadData];
    }
    else if (row == 4)
    {
        HWInviteCustomCell2 *cell = (HWInviteCustomCell2 *)[self.baseTable cellForRowAtIndexPath:indexPath];
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
        leftLab.text = @"请输入访客手机号";
        phoneTF = [DTxtField fieldTxt:@"" frameX:kScreenWidth - 150 y:15 w:110 h:20];
        phoneTF.font = [UIFont fontWithName:FONTNAME size:TF13];
        phoneTF.textColor = THEME_COLOR_TEXT;
        phoneTF.keyboardType = UIKeyboardTypePhonePad;
        phoneTF.tag = 1111;
        phoneTF.delegate = self;
        [cell addSubview:phoneTF];
        
        DImageV *phoneIconImgV = [DImageV imagV:@"icon_16_11" frameX:0 y:15 w:20 h:20];
        DButton *phoneBookBtn = [DButton btnImg:@"" frameX:kScreenWidth - 35 y:0 w:35 h:45.0f target:self action:@selector(phoneBookBtnClick)];
        [phoneBookBtn addSubview:phoneIconImgV];
        [cell addSubview:phoneBookBtn];
    }
    else if (row == 1)
    {
        leftLab.text = @"请输入访客称呼";
        nameTF = [DTxtField fieldTxt:@"" frameX:kScreenWidth - 150 y:15 w:110 h:20];
        nameTF.font = [UIFont fontWithName:FONTNAME size:TF13];
        nameTF.textColor = THEME_COLOR_TEXT;
        nameTF.tag = 2222;
        [cell addSubview:nameTF];
    }
    else if (row == 5)
    {
        leftLab.text = @"请选择预估访客人数";
        customNumTF = [DTxtField fieldTxt:@"" frameX:kScreenWidth - 150 y:15 w:110 h:20];
        customNumTF.font = [UIFont fontWithName:FONTNAME size:TF15];
        customNumTF.textColor = THEME_COLOR_TEXT;
        customNumTF.textAlignment = NSTextAlignmentRight;
        customNumTF.keyboardType = UIKeyboardTypeNumberPad;
        customNumTF.delegate = self;
        [cell addSubview:customNumTF];
        
        xuanTianLab = [DLable LabTxt:@"(选填)" txtFont:TF15 txtColor:THEME_COLOR_TEXT frameX:kScreenWidth - 36 - 200 y:15 w:200 h:15];
        xuanTianLab.textAlignment = NSTextAlignmentRight;
        [cell addSubview:xuanTianLab];
        
        downImg = [DImageV imagV:@"arrow3" frameX:kScreenWidth - 16 - 15 y:(45.0f - 9.0f) / 2.0f w:16 h:9];
        [cell addSubview:downImg];
    }
}

#pragma mark - UITextFieldDelegate
- (BOOL)textFieldShouldBeginEditing:(UITextField *)textField
{
    if (textField == customNumTF)
    {
        xuanTianLab.hidden = YES;
        downImg.image = [UIImage imageNamed:@"arrow4"];
        
        [self foldOrNotCell:YES index:_selectedIndex];
        
        if (_selectedIndex != 5)
        {
            _selectedIndex = 5;
        }
        [self performSelector:@selector(setTFBecomFirstRespon:) withObject:[NSNumber numberWithInteger:5] afterDelay:0.2];
        if (IPHONE4)
        {
            [self showViewInscreen:YES];
        }
    }
    
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
    if (textField == customNumTF)
    {
        if (customNumTF.text.length == 0)
        {
            xuanTianLab.hidden = NO;
        }
        downImg.image = [UIImage imageNamed:@"arrow3"];
        if (IPHONE4)
        {
            [self showViewInscreen:NO];
        }
    }
    
    return YES;
}

#pragma mark - showViewInScreen
- (void)showViewInscreen:(BOOL)isShow
{
    if (isShow)
    {
        [UIView animateWithDuration:0.3f animations:^{
            self.center = CGPointMake(self.center.x, self.center.y - 214.0f);
        } completion:^(BOOL finished) {
            
        }];
    }
    else
    {
        [UIView animateWithDuration:0.3f animations:^{
            self.center = CGPointMake(self.center.x, self.center.y + 214.0f);
        } completion:^(BOOL finished) {
            
        }];
    }
}

@end
