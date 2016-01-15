//
//  PsdEmailVC.m
//  PUClient
//
//  Created by RRLhy on 15/7/21.
//  Copyright (c) 2015年 RRLhy. All rights reserved.
//

#import "PsdEmailVC.h"
#import "FindPsdEmailApi.h"
#import "FindPsdMobileApi.h"
@interface PsdEmailVC ()
@property (weak, nonatomic) IBOutlet UITextField *phonePsd;
@property (weak, nonatomic) IBOutlet UITextField *phoneSurePsd;
@property (weak, nonatomic) IBOutlet UIButton *phoneDone;
@property (weak, nonatomic) IBOutlet UITextField *emailTf;
@property (weak, nonatomic) IBOutlet UIButton *emailDone;
@property (weak, nonatomic) IBOutlet UIView *emailView;
@property (weak, nonatomic) IBOutlet UIView *phoneView;

@end

@implementation PsdEmailVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.navigationController.navigationBar.barStyle = UIBarStyleDefault;
    
    UIImage * imageN = [UIImage stretchImageWithName:@"btn_me_n"];
    UIImage * imageH = [UIImage stretchImageWithName:@"btn_me_h"];
    UIImage * phoneN  = [UIImage stretchImageWithName:@"btn_me_carry-out_h"];
    UIImage * phoneH = [UIImage stretchImageWithName:@"btn_me_carry-out_n"];
    
    
    [_phoneDone setBackgroundImage:phoneN forState:UIControlStateNormal];
    [_phoneDone setBackgroundImage:phoneH forState:UIControlStateHighlighted];
    
    [_emailDone setBackgroundImage:imageN forState:UIControlStateNormal];
    [_emailDone setBackgroundImage:imageH forState:UIControlStateHighlighted];
    
    if (self.isEmail) {
        _phoneView.hidden = YES;
        self.titleLabel.text = @"忘记密码";
    }else{
        _emailView.hidden = YES;
    }
}

#pragma 手机找回
- (IBAction)phoneClick:(id)sender {
    
    NSString * str1 = [_phonePsd.text replaceString];
    NSString * str2 = [_phoneSurePsd.text replaceString];
    
    if (str1.length < 6||str2.length < 6) {
        [IanAlert alertError:@"密码不能少于6位" length:1];
        return;
    }
    
    if (![str1 isEqualToString:str2]) {
        [IanAlert alertError:@"两次输入密码不一致" length:1];
        return;
    }
    [IanAlert showloading];
    FindPsdMobileApi * api = [[FindPsdMobileApi alloc]initWithUserMobile:self.phone code:self.code passWord:[_phoneSurePsd.text MD5]];
    [api startWithCompletionBlockWithSuccess:^(YTKBaseRequest *request) {
     
        NSDictionary * dic = request.responseJSONObject;
        NSLog(@"手机找回密码%@",dic);
        if (dic) {
            JsonModel * json = [JsonModel objectWithKeyValues:dic];
            
            if (json.code == SUCCESSCODE) {
                [IanAlert alertSuccess:@"修改成功" length:1];
                [self.navigationController popViewControllerAnimated:YES];
            }else{
                
                [IanAlert alertError:json.msg length:1];
            }
        }else{
            [IanAlert alertError:ERRORMSG1 length:1];
        }
        
    } failure:^(YTKBaseRequest *request) {
        [IanAlert alertError:ERRORMSG2 length:1];
    }];
    
}

#pragma mark 邮箱找回
- (IBAction)emailClick:(id)sender {
    
    BOOL isEmail = [_emailTf.text isValidateEmail:_emailTf.text];
    if (!isEmail) {
        [IanAlert alertError:@"邮箱格式不正确" length:1];
        return;
    }
    [IanAlert showloading];
    FindPsdEmailApi * api = [[FindPsdEmailApi alloc]initWithUserEmail:_emailTf.text];
    [api startWithCompletionBlockWithSuccess:^(YTKBaseRequest *request) {
        
        NSDictionary * dic = request.responseJSONObject;
        NSLog(@"邮箱找回密码%@",dic);
        if (dic) {
            JsonModel * json = [JsonModel objectWithKeyValues:dic];

            if (json.code == SUCCESSCODE) {
                
                [IanAlert alertSuccess:@"请求成功" length:1];
                
            }else{
                [IanAlert alertError:json.msg length:1];
            }
        }else{
            [IanAlert alertError:ERRORMSG1 length:1];
        }
        
    } failure:^(YTKBaseRequest *request) {
        
        [IanAlert alertError:ERRORMSG2 length:1];
        
    }];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
