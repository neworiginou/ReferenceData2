//
//  HWEditAddressViewController.m
//  Community
//
//  Created by ryder on 8/3/15.
//  Copyright (c) 2015 caijingpeng. All rights reserved.
//
//  功能描述：
//      天天团编辑收货地址
//  修改记录：
//      姓名         日期              修改内容
//     程耀均     2015-07-30           创建文件

#import "HWEditAddressViewController.h"
#import "UIViewExt.h"
#import "BasePickView.h"
#import "NSString+Helper.h"
#import "Utility.h"
#import "NSDictionary+Utils.h"
#import "Define.h"
#define kCellTextColor 65/255.0f

@interface HWEditAddressViewController ()
{
    
    UITextField *_userNameTF;
    UITextField *_userNumTF;
    UITextField *_userAddTF;
    //    UITextView  *_textView;
    UITableView *_tableView;
    UIView      *backgroundView;
    
}
@property (nonatomic, strong) UITextView * textView;

@end

@implementation HWEditAddressViewController

- (id)init{
    self = [super init];
    if (self)
    {
        self.navigationItem.rightBarButtonItem = [Utility navButton:self title:@"保存" action:@selector(saveAction)];
        self.navigationItem.leftBarButtonItem = [Utility navLeftBackBtn:self action:@selector(backMethod)];
        self.navigationItem.titleView = [Utility navTitleView:@"收货地址"];
        
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    _tableView = [[UITableView alloc]initWithFrame:self.view.bounds style:UITableViewStyleGrouped];
    _tableView.dataSource = self;
    _tableView.delegate = self;
    [self.view addSubview:_tableView];
    
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    return 3;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    UITextField *textField;
    NSString *identify = [NSString stringWithFormat:@"identify%zd",indexPath.row];
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identify];
    //    UITableViewCell *cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleValue2 reuseIdentifier:nil];
    if (cell == nil)
    {
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identify];
        textField = [[UITextField alloc]initWithFrame:CGRectMake(100, 0, 200, 45)];
        [cell.contentView addSubview:textField];
        textField.delegate = self;
        textField.font = [UIFont systemFontOfSize:15];
        textField.tag = indexPath.row;
        //
        if (indexPath.row == 0)
        {
            cell.textLabel.text = @"收货人姓名";
            textField.text = self.addressModel.name;
            _userNameTF = textField;
        }
        else if (indexPath.row == 1)
        {
            cell.textLabel.text = @"手机号码";
            textField.text = self.addressModel.mobile;
            _userNumTF = textField;
            
        }
        else
        {
            BasePickView *picker = [[BasePickView alloc] init];
            picker.showsSelectionIndicator = YES;
            textField.inputView = picker;
            picker.addressdelegate = self;
            cell.textLabel.text = @"省市区";
            _userAddTF = textField;
        }
        
        
        
    }
    
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    
    
    //底部线
    
    UIView *line = [[UIView alloc] initWithFrame:CGRectMake(0, 44 - 0.5f, kScreenWidth, 0.5f)];
    line.backgroundColor = THEME_COLOR_LINE;
    [cell.contentView addSubview:line];
    //编辑框
    cell.textLabel.textAlignment = NSTextAlignmentLeft;
    cell.textLabel.textColor = [UIColor colorWithRed:kCellTextColor green:kCellTextColor blue:kCellTextColor alpha:1];
    cell.textLabel.font = [UIFont systemFontOfSize:15.0f];
    
    return cell;
    
}

- (void)sentAddress:(NSString *)address{
    
    _userAddTF.text = address;
    self.textView.text = [NSString stringWithFormat:@"%@",[address trimString]];
    
}

- (BOOL)textViewShouldBeginEditing:(UITextView *)textView{
    
    if (textView.text.length == 0) {
        self.textView.text = [NSString stringWithFormat:@"%@",textView.text];
        
    }
    return YES;
}

//创建尾视图

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    
    return 1.0f;
}
- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section
{
    UIView *view = [[UIView alloc]initWithFrame:CGRectMake(0, 0, kScreenWidth, 300)];
    view.backgroundColor = [UIColor clearColor];
    backgroundView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, kScreenWidth, 44)];
    [view addSubview:backgroundView];
    backgroundView.backgroundColor = [UIColor whiteColor];
    [backgroundView addSubview:self.textView];
    return view;
    
}

- (UITextView *)textView
{
    if (_textView == nil) {
        
        _textView = [[UITextView alloc]initWithFrame:CGRectMake(10, 0, kScreenWidth - 10, 44)];
        _textView.font = [UIFont systemFontOfSize:15.0f];
        _textView.textColor = [UIColor blackColor];
        _textView.backgroundColor = [UIColor whiteColor];
        _textView.delegate = self;
        _textView.contentMode = UIViewContentModeTopLeft;
        _textView.text = [NSString stringWithFormat:@"%@",self.addressModel.address];
        
    }
    return _textView;
}
- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    return 200;
}

#pragma mark - textFieldDelegate
- (BOOL)textFieldShouldReturn:(UITextField *)textField{
    if (textField == _userNameTF) {
        [_userNumTF becomeFirstResponder];
    }else if (textField == _userNumTF){
        
        [_userAddTF becomeFirstResponder];
    }else if(textField == _userAddTF){
        [self.textView becomeFirstResponder];
        
    }
    //    [textField resignFirstResponder];
    return YES;
}

- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string{
    
    if (textField == _userNumTF)
    {
        NSMutableString *text = [textField.text mutableCopy];
        [text replaceCharactersInRange:range withString:string];
        
        if (text.length > 11 && range.length == 0)
        {
            return NO;
        }
    }
    return YES;
}

- (void)textFieldDidBeginEditing:(UITextField *)textField{
    if (textField == _userNameTF) {
        [MobClick event:@"click_bianjishouhuorenxingming"];
        
    }else if (textField == _userNumTF){
        
        [MobClick event:@"click_bianjishoujihaoma"];
        
    }else{
        [MobClick event:@"click_bianjishengshiqu"];
        
        
    }
    
}

#pragma mark - TextViewDelegate

- (BOOL)textView:(UITextView *)textView shouldChangeTextInRange:(NSRange)range replacementText:(NSString *)text {
    if ([text isEqualToString:@"\n"]) {
        [self.textView resignFirstResponder];
        return NO;
    }
    return YES;
}

- (void)textViewDidChange:(UITextView *)textView{
    
    CGRect rect = textView.frame;
    CGRect leftRect = backgroundView.frame;
    CGSize size = [Utility calculateStringHeight:textView.text font:[UIFont systemFontOfSize:15.0f] constrainedSize:CGSizeMake(kScreenWidth - 15, 1000)];
    
    if (size.height >= 44.0f) {
        rect.size.height = size.height;
        leftRect.size.height = size.height;
        
    }else{
        rect.size.height = 44.0f;
        
    }
    textView.frame = rect;
    backgroundView.frame = leftRect;
    
    
}

- (void)textViewDidBeginEditing:(UITextView *)textView{
    [MobClick event:@"click_bianjixiangxidizhi"];
    
}
#pragma mark scrollviewDelegate
- (void)scrollViewWillBeginDragging:(UIScrollView *)scrollView{
    [_userNumTF resignFirstResponder];
    [_userNameTF resignFirstResponder];
    [_userAddTF resignFirstResponder];
    [self.textView resignFirstResponder];
    
}

#pragma mark -- Actions


- (void)saveAction{
    
    
    [MobClick event:@"click_baocundizhi"];
    
    /**
     *  key，source，id 地址id，address地址，mobile手机，name收货人姓名，isDefault是否默认 都是必填
     */
    
    NSString *address = [NSString stringWithFormat:@"%@",[self.textView.text trimString]];
    
    NSString *addressid = _addressModel.addressId;
    NSString *mobile = _userNumTF.text;
    NSString *name = _userNameTF.text;
    
    /**
     *  省，市，区
     */
    NSString *separated = @" ";
    NSString *city = @"";
    NSString *province = @"";
    NSString *area = @"";
    NSString *splitString = [_userAddTF.text stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]];
    
    // 区
    NSRange range = [splitString rangeOfString:separated options:NSBackwardsSearch];
    if (range.length) {
        area = [splitString substringFromIndex:range.location + 1];
    }
    
    
    // 市
    if (range.length) {
        splitString = [splitString substringToIndex:range.location-1];
        range = [splitString rangeOfString:separated options:NSBackwardsSearch];
        
        city = splitString;
        if (range.length) {
            city = [splitString substringFromIndex:range.location + 1];
        }
    }
    
    
    
    // 省
    if (range.length) {
        splitString = [splitString substringToIndex:range.location-1];
        splitString = city;
        if (range.length) {
            range = [splitString rangeOfString:separated options:NSBackwardsSearch];
            province = [splitString substringFromIndex:range.location + 1];
        }
    }
    
    
    BOOL ret = [Utility validateMobile:mobile];
    if (!ret) {
        [Utility showAlertWithMessage:@"亲输入正确的电话"];
        return;
    }
    if(address.length == 0 || name.length == 0 ){
        
        [Utility showAlertWithMessage:@"请检查地址"];
        return;
    }
    
    NSMutableDictionary *dict = [[NSMutableDictionary alloc] init];
    
    
    /*接口名称：修改地址
     接口地址：hw-sq-app-web/user/editReceiveAddressByUser.do
     入参：key,addressId,mobile,name,address,province,city,area,isDefault(0，不是默认 1，默认)
     出参：
     {"status":"1","data":null,"detail":"请求数据成功!","key":"788f4790-b3af-48ff-8e42-f60e30a5714e"} */
    
    [Utility showMBProgress:self.view message:@"保存中"];
    HWHTTPRequestOperationManager *manage = [HWHTTPRequestOperationManager manager];
    
    [dict setPObject:[HWUserLogin currentUserLogin].key forKey:@"key"];
    [dict setPObject:name forKey:@"name"];
    [dict setPObject:mobile forKey:@"mobile"];
    [dict setPObject:address forKey:@"address"];
    [dict setPObject:@"0" forKey:@"isDefault"];
    [dict setPObject:province forKey:@"province"];
    [dict setPObject:city forKey:@"city"];
    [dict setPObject:area forKey:@"area"];
    [dict setPObject:addressid forKey:@"addressId"];
    
    [manage POST:kTianTianTuanEditReceiveAddressByUser parameters:dict queue:nil success:^(id responseObject) {
        NSLog(@"保存成功");
        
        [[NSNotificationCenter defaultCenter] postNotificationName:@"refresh" object:nil];
        
        [self.navigationController popViewControllerAnimated:YES];
        [Utility hideMBProgress:self.view];
        
    } failure:^(NSString *code, NSString *error) {
        
        NSLog(@"error %@",error);
        [Utility showToastWithMessage:error inView:self.view];
        [Utility hideMBProgress:self.view];
        [Utility showToastWithMessage:error inView:self.view];
        
        
        
    }];
    
}

@end
