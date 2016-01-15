//
//  CreatAddressController.m
//  Community
//
//  Created by hw500028 on 14/12/8.
//  Copyright (c) 2014年 caijingpeng. All rights reserved.
//

#import "CreatAddressController.h"
#import "UIViewExt.h"
#import "BasePickView.h"
#import "NSString+Helper.h"
#import "Utility.h"
#import "AppDelegate.h"
#define kCellTextColor 65/255.0f
#define TextFieldTag 100
@interface CreatAddressController ()

{
    UITableView *_tableView;
    UITextField *_userNameTF;
    UITextField *_userNumTF;
    UITextField *_userAddTF;
    NSMutableDictionary *dic ;
   
}



@end

@implementation CreatAddressController

- (id)init{
    self = [super init];
    if (self) {
        self.navigationItem.titleView = [Utility navTitleView:@"创建收货地址"];

    }
    return self;
}


- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.leftBarButtonItem = [Utility navLeftBackBtn:self action:@selector(back)];
    dic = [[NSMutableDictionary alloc]init];
    [self initViews];
}


#pragma mark - Views

- (CGFloat )tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{

    return 45;
}

- (void)initViews{
    _tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, kScreenWidth,CONTENT_HEIGHT) style:UITableViewStyleGrouped];
    _tableView.delegate = self;
    _tableView.dataSource = self;
    _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    [self.view addSubview:_tableView];
 

}


#pragma mark - TableViewdelegate

- (NSInteger )tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{

    return 3;
    
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    NSString *indentify = [NSString stringWithFormat:@"cell%d%d",(int)indexPath.section,(int)indexPath.row];
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:nil];
    //    UITableViewCell *cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:indentify];
    if (cell == nil)
    {
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:indentify];
    }
    
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    //底部线
    
    UIView *line = [[UIView alloc] initWithFrame:CGRectMake(0, 44 - 0.5f, kScreenWidth, 0.5f)];
    line.backgroundColor = THEME_COLOR_LINE;
    [cell.contentView addSubview:line];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    
    //编辑框
    UITextField *texfield = [[UITextField alloc]initWithFrame:CGRectMake(100, 0, 200, 45)];
    texfield.contentVerticalAlignment = UIControlContentVerticalAlignmentCenter;
    texfield.delegate = self;
    
    if (indexPath.row == 0) {
        cell.textLabel.text = @"收货人姓名";
        _userNameTF = texfield;
        _userNameTF.text = [dic objectForKey:@"name"];
        
    }
    if (indexPath.row == 1) {
        cell.textLabel.text = @"手机号码";
        
        _userNumTF = texfield;
        _userNumTF.text = [dic objectForKey:@"num"];
        
        
    }
    if (indexPath.row == 2) {
        
        cell.textLabel.text = @"省市区";
        BasePickView *picker = [[BasePickView alloc] init];
        picker.showsSelectionIndicator = YES;
        picker.addressdelegate = self;
        texfield.inputView = picker;
        _userAddTF = texfield;
        _userAddTF.text = [dic objectForKey:@"address"];
        _userAddTF.textAlignment = NSTextAlignmentLeft;
        
        
        
    }
    [cell.contentView addSubview:texfield];
    cell.textLabel.textAlignment = NSTextAlignmentLeft;
    cell.textLabel.textColor = [UIColor colorWithRed:kCellTextColor green:kCellTextColor blue:kCellTextColor alpha:1];
    cell.textLabel.font = [UIFont systemFontOfSize:15.0f];
    
    return cell;
    
}

#pragma mark -- AddressDelegate
- (void)sentAddress:(NSString *)address{
    _userAddTF.text = address;
    _textView.text = [NSString stringWithFormat:@"%@",[address trimString]];
    
    
}
//头视图高度
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    
    return 1;
}
//尾视图高度

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    
    return 300;
}

- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section{
    UIView *view = [[UIView alloc]initWithFrame:CGRectMake(0, 0, kScreenWidth, 200)];
    UIView *leftView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, 10, 100)];
    leftView.backgroundColor = [UIColor whiteColor];
    [view addSubview:leftView];
    
        _textView = [[UITextView alloc]initWithFrame:CGRectMake(10, 0, kScreenWidth - 10, 100)];
        _textView.contentMode = UIViewContentModeTopLeft;
        _textView.text = @"详细地址";
        _textView.font = [UIFont systemFontOfSize:15.0f];
        _textView.textColor = [UIColor blackColor];
        _textView.backgroundColor = [UIColor whiteColor];
        _textView.delegate = self;
        [view addSubview:_textView];
        //创建按钮
        UIButton *button = [UIButton buttonWithType: UIButtonTypeCustom];
        button.frame = CGRectMake(15, _textView.bottom + 20,kScreenWidth - 30,45);
        [button setTitle:@"创建" forState:UIControlStateNormal];
        [button addTarget:self action:@selector(createAction) forControlEvents:UIControlEventTouchUpInside];
        [button setButtonOrangeStyle];
        [view addSubview:button];

    
    return view;

}

#pragma mark - TextFieldDelegate

- (BOOL)textFieldShouldReturn:(UITextField *)textField{
    if (textField == _userNameTF) {
        [_userNumTF becomeFirstResponder];
    }else if (textField == _userNumTF){
        
        [_userAddTF becomeFirstResponder];
        
    }else if (textField == _userAddTF){
        [_textView becomeFirstResponder];
        
    }
    
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

- (void)textFieldDidEndEditing:(UITextField *)textField{
    
    if (textField.text != 0)
    {
        if (textField == _userNameTF)
        {
            
            [dic setObject:textField.text forKey:@"name"];
        }
        if (textField == _userNumTF )
        {
            [dic setObject:textField.text forKey:@"num"];
            
        }
        if(textField == _userAddTF)
        {
            
            [dic setObject:textField.text forKey:@"address"];
        }

    }
    

}


- (void)textFieldDidBeginEditing:(UITextField *)textField{
    if (textField == _userNameTF) {
        
        [MobClick event:@"click_shouhuorenxingming"];
    }
    if (textField == _userNumTF) {
        [MobClick event:@"click_shoujihaoma"];

    }else{
        [MobClick event:@"click_shengshiqu"];
    
    }

}


#pragma mark textViewDelegate



- (void)textViewDidBeginEditing:(UITextView *)textView{
    [MobClick event:@"click_xiangxidizhi"];
    if ([textView.text isEqualToString:@"详细地址"]) {
        textView.text = [_userAddTF.text trimString];
    
    }

    [UIView animateWithDuration:0.25 animations:^{
        self.tableView.contentOffset = CGPointMake(0, 100);
 
    }];
}
- (BOOL)textView:(UITextView *)textView shouldChangeTextInRange:(NSRange)range replacementText:(NSString *)text {
    if ([text isEqualToString:@"\n"]) {
        [_textView resignFirstResponder];
        return NO;
    }
    return YES;
}
- (void)textViewDidEndEditing:(UITextView *)textView{
    if (textView.text.length == 0) {
        textView.text = @"详细地址";
    }
    else{
        textView.text =[NSString stringWithFormat:@"%@", _textView.text];

    }

[UIView animateWithDuration:0.25 animations:^{
    self.tableView.contentOffset = CGPointMake(0, 0);
 
}];
}




#pragma mark - scrollViewDelegate

- (void)scrollViewWillBeginDragging:(UIScrollView *)scrollView{

    [_userAddTF resignFirstResponder];
    [_userNameTF resignFirstResponder];
    [_userNumTF resignFirstResponder];
    [_textView resignFirstResponder];
    
}


#pragma mark - actions

- (void)back{

    [self.navigationController popViewControllerAnimated:YES];
}

#pragma mark -- 保存地址
/**
 *  没有写请求参数
 */
- (void)createAction{
    
    [MobClick event:@"click_chaungjiandizhi"];

    
    NSString *name = [_userNameTF.text trimString];
    NSString *num = [_userNumTF.text trimString];
    NSString *address = [_textView.text trimString];
    BOOL ret = [Utility validateMobile:num];
    if ([name length]==0)
    {
        [Utility showToastWithMessage:@"姓名不能为空" inView:self.view];
        return;
    }
    if (!ret) {
        
        [Utility showToastWithMessage:@"请输入正确的电话" inView:self.view];
        return;
    }
    if ([address isEqualToString:@"详细地址"])
    {
        [Utility showToastWithMessage:@"详细地址不能为空" inView:self.view];
        return;
    }
    [Utility showMBProgress:self.view message:@"提交中"];
        
    HWHTTPRequestOperationManager *manage = [HWHTTPRequestOperationManager cutManager];
    
    NSMutableDictionary *dict = [[NSMutableDictionary alloc] init];
    
    [dict setPObject:[HWUserLogin currentUserLogin].key forKey:@"key"];
    /**
     *  入参：key，source，address 地址，mobile 手机号，name姓名，isDefault是否默认 都是必填
     *
     */
    [dict setPObject:name forKey:@"name"];
    [dict setPObject:num forKey:@"mobile"];
    [dict setPObject:address forKey:@"address"];
    [dict setPObject:@"0" forKey:@"isDefault"];
    [dict setPObject:@"1" forKey:@"source"];
    [manage POST:kAddAddress parameters:dict queue:nil success:^(id responseObject) {
        NSLog(@"保存成功");
        
        [Utility hideMBProgress:self.view];
        
        
        AppDelegate *del =(AppDelegate *)[UIApplication sharedApplication].delegate;
        [Utility showToastWithMessage:@"提交成功" inView:del.window];
        
        [[NSNotificationCenter defaultCenter]postNotificationName:@"refresh" object:nil];
        NSDictionary *dataDic = [responseObject objectForKey:@"data"];
        //add by gusheng
        HWAddressModel *addressModel = [[HWAddressModel alloc]init];
        addressModel.address = [dataDic stringObjectForKey:@"address"];
        addressModel.name = [dataDic stringObjectForKey:@"name"];
        //地址Id
        addressModel.addressId = [dataDic stringObjectForKey:@"id"];
        addressModel.mobile = [dataDic stringObjectForKey:@"mobile"];
        addressModel.cutUserId = [dataDic stringObjectForKey:@"cutUserId"];
//        if (_returnAddress)
//        {
//            _returnAddress(addressModel);
//        }
        //end
        [self.navigationController popViewControllerAnimated:YES];

    } failure:^(NSString *code, NSString *error) {
        
        NSLog(@"error %@",error);
        [Utility hideMBProgress:self.view];
        [Utility showToastWithMessage:error inView:self.view];

    }];
    
    
}


@end
