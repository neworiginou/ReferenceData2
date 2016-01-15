//
//  HWAddCardViewController.m
//  HaoWu_4.0
//
//  Created by caijingpeng.haowu on 14-5-24.
//  Copyright (c) 2014年 caijingpeng. All rights reserved.
//
//  修改记录：
//      蔡景鹏  2014-7-8   修改持卡人姓名可编辑

#import "HWAddCardViewController.h"
#import "HWbankViewController.h"
#import "HWProvinceViewController.h"
#import "HWCityListViewController.h"
#import "ExtractViewController.h"
#import "HWInputBackView.h"

@interface HWAddCardViewController ()
{
    UITextField *_passwordTF;
    BOOL _isDefault;
    UILabel *_bankName;
    UIImageView *_blockImgV;
    NSDictionary *Bdic;
    NSDictionary *Pdic;
    NSDictionary *Cdic;
    UITextField *_usernameTF;
    UIScrollView *_mainSV;
}

@end

@implementation HWAddCardViewController
@synthesize logic;
@synthesize popToViewController;

-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
}
-(void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    [_passwordTF resignFirstResponder];
    self.navigationItem.rightBarButtonItem = nil;
}
- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    
//    self.navigationItem.title = @"添加银行卡";
    self.navigationItem.titleView =[Utility navTitleView:@"绑定银行卡"];
    self.navigationItem.leftBarButtonItem = [Utility navLeftBackBtn:self action:@selector(doBack:)];
    
    _mainSV = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, CONTENT_HEIGHT)];
    _mainSV.backgroundColor = [UIColor clearColor];
    [self.view addSubview:_mainSV];
    
    HWInputBackView *backView = [[HWInputBackView alloc] initWithFrame:CGRectMake(0, 10, kScreenWidth, 90) withLineCount:2];
    [_mainSV addSubview:backView];
    
    _usernameTF = [[UITextField alloc] initWithFrame:CGRectMake(backView.frame.origin.x + 10, CGRectGetMinY(backView.frame) + 7.5f , kScreenWidth - 70, 30)];
    _usernameTF.font = [UIFont fontWithName:FONTNAME size:15.0f];
    _usernameTF.textColor = THEME_COLOR_SMOKE;
    _usernameTF.placeholder = @"请输入持卡人姓名";
    _usernameTF.returnKeyType = UIReturnKeyDone;
    _usernameTF.delegate = self;
    [_mainSV addSubview:_usernameTF];
    
    _passwordTF = [[UITextField alloc] initWithFrame:CGRectMake(backView.frame.origin.x + 10, CGRectGetMaxY(backView.frame) - 7.5f - 30, kScreenWidth - 70, 30)];
    _passwordTF.font = [UIFont fontWithName:FONTNAME size:15.0f];
    _passwordTF.placeholder = @"请输入卡号";
    _passwordTF.delegate =self;
    _passwordTF.textColor = THEME_COLOR_SMOKE;
    [_passwordTF setKeyboardType:UIKeyboardTypeNumberPad];
    [_mainSV addSubview:_passwordTF];
    
    
    HWInputBackView *backView1 = [[HWInputBackView alloc] initWithFrame:CGRectMake(0, CGRectGetMaxY(backView.frame) + 10, kScreenWidth, 135) withLineCount:3];
    [_mainSV addSubview:backView1];
    
    NSArray *titleArr = @[@"请选择开户银行",@"开户银行所在省份",@"开户银行所在城市"];
    for (int i = 0; i<3; i++) {
        
        UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(CGRectGetMinX(backView1.frame) + 10, CGRectGetMinY(backView1.frame) + 7.5f + i*45, self.view.frame.size.width - 70, 30)];
        label.backgroundColor = [UIColor clearColor];
        label.text = [titleArr pObjectAtIndex:i];
        label.font = [UIFont fontWithName:FONTNAME size:15.0f];
        label.tag = 10+i;
        label.textColor = THEME_COLOR_SMOKE;
        [_mainSV addSubview:label];
        
        UIImageView *imgV = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 12.5f, 12.5f)];
        imgV.backgroundColor = [UIColor clearColor];
        imgV.image = [UIImage imageNamed:@"icon_jianotu"];
        imgV.center = CGPointMake(kScreenWidth - 25.0f, label.center.y);
        [_mainSV addSubview:imgV];
        
        UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
//        [btn setTitle:[titleArr objectAtIndex:i] forState:UIControlStateNormal];
        btn.titleLabel.font = [UIFont fontWithName:FONTNAME size:15.0f];
        btn.tag = 100+i;
        [btn addTarget:self action:@selector(doSelect:) forControlEvents:UIControlEventTouchUpInside];
        btn.frame = CGRectMake(CGRectGetMinX(backView1.frame) + 10, CGRectGetMinY(backView1.frame) + 7.5f + i * 45, self.view.frame.size.width, 30);
        [_mainSV addSubview:btn];
    }
    
    _blockImgV = [[UIImageView alloc] initWithFrame:CGRectMake(backView1.frame.origin.x + 2, CGRectGetMaxY(backView1.frame) + 10, 23, 23)];
    _blockImgV.image = [UIImage imageNamed:@"kou"];
    _blockImgV.layer.masksToBounds = YES;
    _blockImgV.layer.cornerRadius = _blockImgV.frame.size.width/2;
    _blockImgV.backgroundColor = [UIColor whiteColor];
    [_mainSV addSubview:_blockImgV];
    
    UIButton *setDefaultBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    setDefaultBtn.frame = CGRectMake(backView1.frame.origin.x + 2, CGRectGetMaxY(backView1.frame) + 10, 100, 30);
    [setDefaultBtn addTarget:self action:@selector(setDefault:) forControlEvents:UIControlEventTouchUpInside];
    [_mainSV addSubview:setDefaultBtn];
    
    UILabel *infoLab = [[UILabel alloc] initWithFrame:CGRectMake(CGRectGetMaxX(_blockImgV.frame) + 5, CGRectGetMinY(_blockImgV.frame)+4, 100, 15)];
    infoLab.text = @"设为默认使用";
    infoLab.font = [UIFont fontWithName:FONTNAME size:15.0f];
    infoLab.textColor = THEME_COLOR_TEXT;
    [_mainSV addSubview:infoLab];
    
    
    UIButton *confirmButton = [UIButton buttonWithType:UIButtonTypeCustom];
    confirmButton.frame = CGRectMake(12, CGRectGetMaxY(infoLab.frame) + 20, self.view.frame.size.width - 24, 50);
    [confirmButton setTitle:@"立即绑定" forState:UIControlStateNormal];
    [confirmButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [confirmButton setButtonOrangeStyle];
    [confirmButton addTarget:self action:@selector(clickConfirm:) forControlEvents:UIControlEventTouchUpInside];
    [_mainSV addSubview:confirmButton];
    
    _isDefault = NO;
    
}


- (void)doSelect:(UIButton*)sender
{
    [_usernameTF resignFirstResponder];
    [_passwordTF resignFirstResponder];
    switch (sender.tag) {
        case 100:
        {
            [MobClick event:@"choose_bank"];
            HWbankViewController *bankVC = [[HWbankViewController alloc]init];
            [bankVC setSetBank:^(NSDictionary *dic) {
//                //NSLog(@"dic = %@",dic);
                Bdic = dic;
                UILabel *lable = (UILabel *)[_mainSV viewWithTag:10];
//                lable.textColor = [UIColor blackColor];
                lable.text = [dic stringObjectForKey:@"name"];
            }];
            [self.navigationController pushViewController:bankVC animated:YES];
        }
            break;
        case 101:
        {
            [MobClick event:@"choose_bank_province"];
            HWProvinceViewController *provinceVC = [[HWProvinceViewController alloc]init];
            [provinceVC setProvince:^(NSDictionary *dic)
            {
//                //NSLog(@"dic = %@",dic);
                Pdic = dic;
                UILabel *lable = (UILabel *)[_mainSV viewWithTag:11];
                UILabel *lable2 = (UILabel *)[_mainSV viewWithTag:12];
                lable2.text = @"开启银行所在城市";
//                lable.textColor = [UIColor blackColor];
                lable.text = [dic stringObjectForKey:@"provinceName"];
            }];
            [self.navigationController pushViewController:provinceVC animated:YES];
        }
            break;
        case 102:
        {
            [MobClick event:@"choose_bank_city"];
            if (Pdic==nil) {
                [Utility showToastWithMessage:@"请先选择省份" inView:self.view];
                return;
            }
            HWCityListViewController *cityVC = [[HWCityListViewController alloc]init];
            if ([[Pdic objectForKey:@"id"] isKindOfClass:[NSNull class]]) {
                cityVC.province_id = 0;
            }
            else {
                cityVC.province_id = [[NSString stringWithFormat:@"%@",[Pdic objectForKey:@"id"]] integerValue];
            }
            
            [cityVC setCity:^(NSDictionary *dic)
             {
//                 //NSLog(@"dic = %@",dic);
                 Cdic = dic;
                 UILabel *lable = (UILabel *)[_mainSV viewWithTag:12];
//                 lable.textColor = [UIColor blackColor];
                 lable.text = [dic stringObjectForKey:@"cityName"];
             }];
            [self.navigationController pushViewController:cityVC animated:YES];
        }
            break;

        default:
            break;
    }
    
}

- (void)setDefault:(UIButton *)sender
{
    
    if (_isDefault) {
        // 关闭默认
//        _blockImgV.backgroundColor = [UIColor whiteColor];
        _blockImgV.image = [UIImage imageNamed:@"kou"];
    }
    else
    {   // 打开默认
        [MobClick event:@"click_set_default"];
        _blockImgV.image = [UIImage imageNamed:@"gou"];
    }
    _isDefault = !_isDefault;
}

- (void)clickConfirm:(id)sender
{
    [MobClick event:@"click_finish_add_card"];
    [_passwordTF resignFirstResponder];
    
    NSMutableString *cardNo = [NSMutableString stringWithString:_passwordTF.text];
    [cardNo replaceOccurrencesOfString:@" " withString:@"" options:0 range:NSMakeRange(0, cardNo.length)];
    
    
    
    if (![Utility isChineseWord:_usernameTF.text])
    {
        [Utility showToastWithMessage:@"持卡人姓名必须为汉字" inView:self.view];
        return;
    }
    else if (_usernameTF.text.length < 2 || _usernameTF.text.length > 5)
    {
        [Utility showToastWithMessage:@"持卡人姓名必须为2-5个汉字" inView:self.view];
        return;
    }
    else if(Bdic==nil)
    {
        [Utility showToastWithMessage:@"请选择银行" inView:self.view];
        return;
    }
    else if (Pdic==nil)
    {
        [Utility showToastWithMessage:@"请选择省份" inView:self.view];
        return;
    }
    else if (Cdic==nil)
    {
        [Utility showToastWithMessage:@"请选择城市" inView:self.view];
        return;
    }
    else if(_passwordTF.text.length<=0)
    {
        [Utility showToastWithMessage:@"请输入银行卡号" inView:self.view];
        return;
    }
    else if (![Utility isCardNo:cardNo])
    {
        [Utility showToastWithMessage:@"输入的银行卡号不符合规则" inView:self.view];
        return;
    }
    [Utility showMBProgress:self.view message:LOADING_TEXT];
    HWHTTPRequestOperationManager *manager = [HWHTTPRequestOperationManager societyManager];
    
    NSMutableDictionary *dict = [NSMutableDictionary dictionary];
    [dict setPObject:[HWUserLogin currentUserLogin].key forKey:@"key"];
    [dict setPObject:cardNo forKey:@"cardNo"];
    [dict setPObject:_usernameTF.text forKey:@"name"];
    [dict setPObject:[Bdic stringObjectForKey:@"name"] forKey:@"bankName"];
    [dict setPObject:[Pdic objectForKey:@"id"] forKey:@"provinceId"];
    [dict setPObject:[Cdic objectForKey:@"id"] forKey:@"cityId"];    
    [dict setPObject:(_isDefault ? @"on" : @"off") forKey:@"isDefault"];
    [dict setPObject:[Bdic objectForKey:@"bankId"] forKey:@"bankId"];
    [dict setPObject:@"1" forKey:@"channel"];
    
    [manager POST:AddCardID_V4 parameters:dict queue:nil success:^(id responseObject) {
        [Utility hideMBProgress:self.view];
        
        
        NSString *data = [responseObject stringObjectForKey:@"data"];
        if ([data isEqualToString:@"-1"])
        {
            [Utility showToastWithMessage:@"银行卡已存在" inView:self.view];
        }
        else if ([data isEqualToString:@"1"])
        {
            [Utility showToastWithMessage:@"添加成功" inView:self.view];
            
            if (self.logic == LogicLine_GetMoney)
            {
                ExtractViewController *getMoneyVC = [[ExtractViewController alloc] init];
                [self.navigationController pushViewController:getMoneyVC animated:YES];
            }
            else if (self.logic == LogicLine_BindCard)
            {
                if (self.popToViewController != nil) {
                    [self.navigationController popToViewController:self.popToViewController animated:YES];
                }
            }
            else
            {
//                [[NSNotificationCenter defaultCenter]postNotificationName:@"addCardOK" object:nil];
                [self.navigationController popViewControllerAnimated:YES];
            }
        }
        else
        {
            [Utility showToastWithMessage:@"发送失败" inView:self.view];
        }
        
    } failure:^(NSString *code, NSString *error) {
        
        [Utility hideMBProgress:self.view];
        [Utility showToastWithMessage:error inView:self.view];
    }];
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
    [textField resignFirstResponder];
    return YES;
}

- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string
{
    if (textField == _usernameTF)
    {
        return YES;
    }
    
    int count = 0;
    for (int i = 0; i < textField.text.length; i++) {
        NSString *s = [textField.text substringWithRange:NSMakeRange(i, 1)];
        if ([s isEqualToString:@" "]) {
            count ++;
        }
    }
//    count = count/2;
    int a = count/2 + 1;
    
    if (range.location != 0 &&
        range.location % (4 * a + count) == 0 &&
        textField.text.length <= range.location &&
        textField.text.length <= 27)
    {
       textField.text = [textField.text stringByAppendingString:@"  "];
    }
    if ([string isEqualToString:@""])
    {
        return YES;
    }
    if (textField.text.length > 26)
    {
        return NO;
    }
    return YES;
}

- (void)doBack:(id)sender
{
    if (self.popToViewController != nil)
    {
        [self.navigationController popToViewController:self.popToViewController animated:YES];
    }
    else
    {
        if (self.logic == LogicLine_GetMoney)
        {
            [self.navigationController popToRootViewControllerAnimated:YES];
        }
        else
        {
            [self.navigationController popViewControllerAnimated:YES];
        }
    }
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
-(void)dealloc
{
    [[NSNotificationCenter defaultCenter]removeObserver:self];
}
/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
