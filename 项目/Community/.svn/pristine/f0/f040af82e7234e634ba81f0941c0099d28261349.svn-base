//
//  HWShopInputViewController.m
//  Community
//
//  Created by caijingpeng.haowu on 14-12-9.
//  Copyright (c) 2014年 caijingpeng. All rights reserved.
//

#import "HWShopInputViewController.h"
#import "HWInputBackView.h"
#import "AppDelegate.h"

@interface HWShopInputViewController ()<UITextFieldDelegate>
{
    UITextField *_shopNameTF;
    UITextField *_shopTelephoneTF;
    UITextField *_shopAddressTF;
}
@end

@implementation HWShopInputViewController

- (id)init{
    if (self = [super init]) {
        [self initViews];
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.navigationItem.titleView = [Utility navTitleView:@"添加商店"];
    self.navigationItem.leftBarButtonItem = [Utility navLeftBackBtn:self action:@selector(backMethod)];
    self.navigationItem.rightBarButtonItem = [Utility navButton:self title:@"提交" action:@selector(toComfirm:)];
    
}


- (void)initViews
{
    HWInputBackView *inputBack = [[HWInputBackView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, 45.0f * 3) withLineCount:3];
    [self.view addSubview:inputBack];
    
    for (int i = 0; i < 3; i++)
    {
        UITextField *textField = [[UITextField alloc] initWithFrame:CGRectMake(15, i * 45.0f + 3, kScreenWidth - 30, 40.0f)];
        textField.backgroundColor = [UIColor clearColor];
        textField.font = [UIFont fontWithName:FONTNAME size:THEME_FONT_BIG];
        textField.textColor = THEME_COLOR_SMOKE;
        textField.clearButtonMode = UITextFieldViewModeWhileEditing;
        //changed by niedi 20141208
        textField.contentVerticalAlignment = UIControlContentVerticalAlignmentCenter;
        [self.view addSubview:textField];
        
        if (i == 0)
        {
            textField.placeholder = @"输入水果店名";
            _shopNameTF = textField;
            _shopNameTF.delegate = self;
        }
        else if (i == 1)
        {
            textField.placeholder = @"输入电话";
            _shopTelephoneTF = textField;
            _shopTelephoneTF.delegate = self;
        }
        else if (i == 2)
        {
            textField.placeholder = @"商家地址";
            _shopAddressTF = textField;
            _shopAddressTF.delegate = self;
        }
    }
}

- (void)toComfirm:(id)sender

{
    
    [MobClick event:@"click_submit_chuangjiandianpuhaoma"];
    if (_shopNameTF.text.length == 0)
    {
        [Utility showToastWithMessage:@"请输入店名" inView:self.view];
    }
    else if (_shopTelephoneTF.text.length == 0)
    {
        [Utility showToastWithMessage:@"请输入电话" inView:self.view];
    }
    else if (_shopAddressTF.text.length == 0)
    {
        [Utility showToastWithMessage:@"请输入商店地址" inView:self.view];
    }
    else
    {
        [self queryListData];
    }
}

//重写model的setter方法并给_shopNameTF赋值
-(void)setModel:(HWAddShopNumModel *)model{
    if (_model != model) {
        _model = model;
    }
    _shopNameTF.placeholder = [NSString stringWithFormat:@"请输入%@店名",_model.dictCodeText];

}

- (void)queryListData
{
    
    
    [self.view endEditing:YES];
    
    NSString *phoneNum = _shopTelephoneTF.text;
//    BOOL ret = [Utility validateMobile:phoneNum];
//    if (!ret)
//    {
//        [Utility showToastWithMessage:@"请输入正确的电话" inView:self.view];
//        return;
//    }
    
    [Utility showMBProgress:self.view message:@"提交中..."];
    
    HWHTTPRequestOperationManager *manage = [HWHTTPRequestOperationManager manager];
    NSMutableDictionary *dict = [[NSMutableDictionary alloc] init];
    [dict setPObject:[HWUserLogin currentUserLogin].key forKey:@"key"];
    [dict setPObject:_shopNameTF.text forKey:@"shopName"];
    [dict setPObject:_shopTelephoneTF.text forKey:@"phone"];
    [dict setPObject:_shopAddressTF.text forKey:@"address"];
    [dict setPObject:self.model.dictId forKey:@"shopType"];
    [manage POST:kInsertShop parameters:dict queue:nil success:^(id responseObject) {
        
        [Utility hideMBProgress:self.view];
        
        AppDelegate *appDel = SHARED_APP_DELEGATE;
        [Utility showToastWithMessage:@"提交成功" inView:appDel.window];
        
        NSLog(@"%@",responseObject);
        [self.navigationController popToRootViewControllerAnimated:YES];
//        NSArray *respList = [[responseObject dictionaryObjectForKey:@"data"] arrayObjectForKey:@"content"];
        
    } failure:^(NSString *code, NSString *error) {
        [Utility hideMBProgress:self.view];
        [Utility showToastWithMessage:error inView:self.view];
    }];
}

#pragma mark - textFieldDelegate

- (void)textFieldDidBeginEditing:(UITextField *)textField{
    
    if (textField == _shopNameTF) {
        [MobClick event:@"get_focus_dianpumingcheng"];
    }else if (textField == _shopTelephoneTF){
    
        [MobClick event:@"get_focus_dianpuhaoma"];
    }else {
    
        [MobClick event:@"get_focus_dianpudizhi"];
    }
}

- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string
{
    NSMutableString *text = [textField.text mutableCopy];
    [text replaceCharactersInRange:range withString:string];
    int length = [Utility calculateTextLength:text];
    
    if (textField == _shopNameTF)
    {
        if (length > 15 && range.length == 0)
        {
            return NO;
        }
        return YES;
    }
    else if (textField == _shopAddressTF)
    {
        if (length > 100 && range.length == 0)
        {
            return NO;
        }
        return YES;
    }
    else if (textField == _shopTelephoneTF)
    {
        
    }
    
    return YES;
}

@end
