//
//  RegisterVC.m
//  PUClient
//
//  Created by RRLhy on 15/7/20.
//  Copyright (c) 2015年 RRLhy. All rights reserved.
//

#import "RegisterVC.h"
#import "CompleteInformationVC.h"
#import "PsdEmailVC.h"
#import "CompleteInformationVC.h"
#import "JKCountDownButton.h"
@interface RegisterVC ()

@property (weak, nonatomic) IBOutlet UITextField *phoneTf;
@property (weak, nonatomic) IBOutlet UITextField *autoCodeTf;
@property (weak, nonatomic) IBOutlet UIButton *nextBtn;
@property (weak, nonatomic) IBOutlet JKCountDownButton *authCodeBtn;
@property (weak, nonatomic) IBOutlet UIImageView *bottomline;
@property (nonatomic,copy)  NSString * authCode;
@property (nonatomic,assign)BOOL isSucces;
@end

@implementation RegisterVC

- (void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:YES];
    
    [_authCodeBtn stop];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    if (self.isFindPsd) {
        self.title = @"忘记密码";
    }
    
    UIImage * imageN = [UIImage stretchImageWithName:@"btn_me_n"];
    UIImage * imageH = [UIImage stretchImageWithName:@"btn_me_h"];
    UIImage * authN  = [UIImage stretchImageWithName:@"btn_me_resend__bg_h"];
    UIImage * authH  = [UIImage stretchImageWithName:@"btn_me_resend__bg_h"];
    
    [_nextBtn setBackgroundImage:imageN forState:UIControlStateNormal];
    [_nextBtn setBackgroundImage:imageH forState:UIControlStateHighlighted];
    [_authCodeBtn setBackgroundImage:authN forState:UIControlStateNormal];
    [_authCodeBtn setBackgroundImage:authH forState:UIControlStateDisabled];
    
    _bottomline.hidden = YES;
    _autoCodeTf.hidden = YES;
    _authCodeBtn.hidden = YES;

}

#pragma mark 下一步操作
- (IBAction)nextClick:(id)sender {
    
    if (self.isSucces) {
        
//        if ([self.authCode isEqualToString:self.autoCodeTf.text]) {
        
            if (self.isFindPsd) {
                
                [self performSegueWithIdentifier:@"findPsd1" sender:self];
                
            }else{
                
                [self performSegueWithIdentifier:@"completeInformation" sender:self];
            }
            
//        }

    }else{
        
        self.isSucces = YES;
        
        __weak RegisterVC * weakself = self;
        [UIView animateWithDuration:0.2 animations:^{
            
            _bottomline.hidden = NO;
            _autoCodeTf.hidden = NO;
            _authCodeBtn.hidden = NO;
            _nextBtn.frame = CGRectMake(10, 200, Main_Screen_Width - 20, 40);
            
        } completion:^(BOOL finished) {
            
            [weakself getCode];
        }];
    }
}

#pragma mark 获取验证码
- (IBAction)getAuthCode:(JKCountDownButton*)sender {
    
    [self getCode];
}

- (void)getCode{
    
    _authCodeBtn.enabled = NO;
    //button type要 设置成custom 否则会闪动
    [_authCodeBtn startWithSecond:60];
    
    [_authCodeBtn didChange:^NSString *(JKCountDownButton *countDownButton,int second) {
        NSString *title = [NSString stringWithFormat:@"重发(%d)",second];
        return title;
    }];
    [_authCodeBtn didFinished:^NSString *(JKCountDownButton *countDownButton, int second) {
        countDownButton.enabled = YES;
        return @"重新获取";
        
    }];
    
}

#pragma makr segue 传值
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    if ([segue.identifier isEqualToString:@"completeInformation"]) {
        
        CompleteInformationVC * theSegue = segue.destinationViewController;
        theSegue.mobile = _phoneTf.text;
        
    }else if([segue.identifier isEqualToString:@"findPsd1"]){
        //手机获得
        PsdEmailVC * theSegue = segue.destinationViewController;
        theSegue.isEmail = NO;
    }
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
