//
//  LoginVC.m
//  PUClient
//
//  Created by RRLhy on 15/7/18.
//  Copyright (c) 2015年 RRLhy. All rights reserved.
//

#import "LoginVC.h"
#import "LoginTopView.h"
#import "LoginBottomView.h"
#import "PsdEmailVC.h"
#import "RegisterVC.h"
#import "BoundThildVC.h"
#import "LoginEmailApi.h"
#import "LoginMobileApi.h"
#import "LoginPlatformApi.h"

@interface LoginVC ()<UIScrollViewDelegate,UMSocialUIDelegate>
{
    LoginTopView * titleView;
}
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *viewHeight;
@property (weak, nonatomic) IBOutlet UIScrollView *mainScrollView;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *viewWidth;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *secondViewLeadding;
@property (weak, nonatomic) IBOutlet UIView *loginView1;
@property (weak, nonatomic) IBOutlet UIView *loginView2;
@property (weak, nonatomic) IBOutlet UIButton *loginBtn;
@property (weak, nonatomic) IBOutlet UIButton *registerBtn;
@property (weak, nonatomic) IBOutlet UIButton *lostPsdBtn;
@property (weak, nonatomic) IBOutlet UIButton *emailLoginBtn;
@property (weak, nonatomic) IBOutlet UIButton *emailRegisterBtn;
@property (weak, nonatomic) IBOutlet UIButton *emailLostBtn;
@property (weak, nonatomic) IBOutlet UITextField *phoneTf;
@property (weak, nonatomic) IBOutlet UITextField *phonePsdTf;
@property (weak, nonatomic) IBOutlet UITextField *emailTf;
@property (weak, nonatomic) IBOutlet UITextField *emailPsdTf;
@property (nonatomic,assign)NSInteger isType;
@property (nonatomic,retain)NSDictionary * currentDic;
@end

@implementation LoginVC

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];

}
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup a
    
    self.mainScrollView.delegate = self;
    [self showBottomView];
    [self showTopView];
    [self showPhoneLogin];
    
}
/**
 *  顶部选项卡
 */
- (void)showTopView
{
    NSArray * array = @[@"手机登录",@"邮箱登陆"];
    __weak LoginVC * weakself = self;
    titleView = [[LoginTopView alloc]initWithFrame:CGRectMake((App_Frame_Width - 200)/2, 28, 200, 27) items:array];
    titleView.indexBlock = ^(NSInteger index){
        
        [weakself.mainScrollView setContentOffset:CGPointMake(App_Frame_Width*index, 0) animated:YES];
    };
    [self.navImage addSubview:titleView];
}

- (void)showPhoneLogin
{
    UIImage * imageN = [UIImage stretchImageWithName:@"btn_me_n"];
    UIImage * imageH = [UIImage stretchImageWithName:@"btn_me_h"];
    UIImage * lostN  = [UIImage stretchImageWithName:@"btn_me_to-register_h"];
    UIImage * registerN = [UIImage stretchImageWithName:@"btn_me_to-register_n"];
    
    [_loginBtn setBackgroundImage:imageN forState:UIControlStateNormal];
    [_loginBtn setBackgroundImage:imageH forState:UIControlStateHighlighted];
    [_loginBtn setFrame:CGRectMake(10, 220, App_Frame_Width - 20, 37)];
    
    [_registerBtn setBackgroundImage:lostN forState:UIControlStateNormal];
    [_registerBtn setFrame:CGRectMake(110, 268, App_Frame_Width - 220, 32)];
    
    [_lostPsdBtn setTitleColor:RGBCOLOR(0.000, 0.729, 0.988) forState:UIControlStateNormal];
    
    [_emailLoginBtn setBackgroundImage:imageN forState:UIControlStateNormal];
    [_emailLoginBtn setBackgroundImage:imageH forState:UIControlStateHighlighted];
    
    [_emailRegisterBtn setBackgroundImage:registerN forState:UIControlStateNormal];
    
    [_emailLostBtn setTitleColor:RGBCOLOR(0.000, 0.729, 0.988) forState:UIControlStateNormal];
    UITapGestureRecognizer * gesture = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(resignText)];
    [_loginView1 addGestureRecognizer:gesture];
}
/**
 *  底部三方登录
 */
- (void)showBottomView
{
    NSArray * array1 = @[@"btn_share_weibo_n",@"btn_share_weixin_n",@"btn_share_qq_n"];
    NSArray * array2 = @[@"btn_share_weibo_h",@"btn_share_weixin_h",@"btn_share_qq_h"];
    NSArray * array3 = @[@"微博",@"微信",@"QQ"];
    NSArray * array = [NSArray arrayWithObjects:array1,array2,array3, nil];
    __weak LoginVC * weakself = self;
    LoginBottomView * bottomView = [[LoginBottomView alloc]initWithFrame:CGRectMake(0,Main_Screen_Height - kTopBarHeight - 190 - kStatusBarHeight, App_Frame_Width, 190) item:array];
    bottomView.thirdIndex = ^(NSInteger index){
        
        [weakself thirdLoginWithItemIndex:index];
    };
    [_loginView1 addSubview:bottomView];
}

- (IBAction)loginButtonClick:(id)sender {
    
    UIButton * btn = (UIButton*)sender;
    switch (btn.tag) {
        case 10:
        {
            //手机登录
            BOOL isPhone = [self.phoneTf.text isTelPhoneNub:self.phoneTf.text];
            if (!isPhone) return;
            
            if (self.phonePsdTf.text.length == 0){
                [IanAlert alertError:@"密码不能为空" length:1];
                return;
            }
            [IanAlert showLoading:@"登录中..."];
            [self phoneLogin];
        }
            break;
        case 20:
        {
            //邮箱登录
            
            BOOL isEmail = [self.emailTf.text isValidateEmail:self.emailTf.text];
            if (!isEmail){
                UIAlertView* alert = [[UIAlertView alloc] initWithTitle:@"提示" message:@"请输入正确的邮箱号" delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
                [alert show];
                return;
            };
            
            if (self.emailPsdTf.text.length == 0){
                [IanAlert alertError:@"密码不能为空" length:1];
                return;
            }
            [IanAlert showLoading:@"登录中..."];
            [self emailLogin];
        }
            break;
            
        default:
            break;
    }
}

- (void)phoneLogin
{
    LoginMobileApi * api = [[LoginMobileApi alloc]initWithUserMobile:_phoneTf.text password:[_phonePsdTf.text MD5]];
    
    [api startWithCompletionBlockWithSuccess:^(YTKBaseRequest *request) {
        NSDictionary * dic = request.responseJSONObject;
        NSLog(@"手机登陆%@",dic);
        if (dic) {
            JsonModel * json = [JsonModel objectWithKeyValues:dic];
            if (json.code == SUCCESSCODE) {
                [IanAlert alertSuccess:@"登录成功" length:1];
                RrmjUser * model = [RrmjUser objectWithKeyValues:json.data[USER]];
                [[UserInfoConfig sharedUserInfoConfig] saveRRMJUser:model];
                [self performSelector:@selector(popRootViewController) withObject:nil afterDelay:1];
                
            }else{
                
                [IanAlert alertError:json.msg length:1];
            }
        }else{
            [IanAlert alertError:ERRORMSG1 length:1];
        }
        
    } failure:^(YTKBaseRequest *request) {
        
        [IanAlert alertError:ERRORMSG2];
    }];
}

- (void)emailLogin
{
    LoginEmailApi * api = [[LoginEmailApi alloc]initWithUserEmail:_emailTf.text password:[_emailPsdTf.text MD5]];
    [api startWithCompletionBlockWithSuccess:^(YTKBaseRequest *request) {
        NSDictionary * dic = request.responseJSONObject;
        NSLog(@"邮箱登录%@",dic);
        if (dic) {
            JsonModel * json = [JsonModel objectWithKeyValues:dic];
            if (json.code == SUCCESSCODE) {
                [IanAlert alertSuccess:@"登录成功" length:1];
                RrmjUser * user = [RrmjUser objectWithKeyValues:json.data[USER]];
                [[UserInfoConfig sharedUserInfoConfig] saveRRMJUser:user];
                
                if (user.mobile.length>0) {
                    
                    [self performSelector:@selector(popRootViewController) withObject:nil afterDelay:1];
                    
                }else{
                    
                    UIAlertView * view = [[UIAlertView alloc]initWithTitle:@"提示" message:@"绑定手机号后可以直接用手机登录，是否立即绑定" delegate:self cancelButtonTitle:nil otherButtonTitles:@"立即绑定",@"暂不绑定", nil];
                    [view show];
                }
                
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

- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    switch (buttonIndex) {
        case 0:
        {
            //立即绑定
            self.isType = 2;
            [self performSegueWithIdentifier:@"authCode" sender:self];
        }
            break;
        case 1:
        {
            //暂不绑定
            [self popRootViewController];
        }
            break;
            
        default:
            break;
    }
}

- (IBAction)registerClick:(id)sender {
    
    self.isType = 0;
    [self performSegueWithIdentifier:@"authCode" sender:self];
}

- (IBAction)lostPsdClick:(id)sender {
   
    UIButton * btn = (UIButton*)sender;
    switch (btn.tag) {
        case 100:
        {
            //手机找回
            self.isType = 1;
            [self performSegueWithIdentifier:@"authCode" sender:self];
        }
            break;
        case 200:
        {
            //邮箱找回
            [self performSegueWithIdentifier:@"findPsd" sender:sender];
        }
            break;
            
        default:
            break;
    }
    
}

#pragma mark 三方登录
- (void)thirdLoginWithItemIndex:(NSInteger)index
{
    [UMSocialControllerService defaultControllerService].socialUIDelegate = self;
    __weak LoginVC * weakself = self;
    NSArray * array = @[UMShareToSina,UMShareToWechatSession,UMShareToQQ];
    //sina微博
    UMSocialSnsPlatform * snsPlatform = [UMSocialSnsPlatformManager getSocialPlatformWithName:array[index]];
    snsPlatform.loginClickHandler(self,[UMSocialControllerService defaultControllerService],YES,^(UMSocialResponseEntity *response){
        
        if (response.responseCode == UMSResponseCodeSuccess) {
            UMSocialAccountEntity *snsAccount = [[UMSocialAccountManager socialAccountDictionary] valueForKey:array[index]];
            
            if (!snsAccount) {
                [IanAlert alertError:@"授权失败" length:1.5];
                return ;
            }
            
            weakself.currentDic = @{@"userName":snsAccount.userName,
                                    @"iconUrl":snsAccount.iconURL,
                                    @"usid":snsAccount.usid,
                                    @"platformName":snsAccount.platformName};
            
            [self platformLoginWithplatformName:snsAccount.platformName userId:snsAccount.usid];
            
        }
    });
}

- (void)platformLoginWithplatformName:(NSString*)platform userId:(NSString*)userId
{
    LoginPlatformApi * api = [[LoginPlatformApi alloc]initWithUserId:userId PlatformName:platform];
    [api startWithCompletionBlockWithSuccess:^(YTKBaseRequest *request) {
        
        NSDictionary * dic  = request.responseJSONObject;
        NSLog(@"微信三方登陆%@",dic);
        if (dic) {
            JsonModel * json = [JsonModel objectWithKeyValues:dic];
   
            if (json.code == SUCCESSCODE) {
                
                [IanAlert alertSuccess:@"登陆成功" length:1];
                RrmjUser * user = [RrmjUser objectWithKeyValues:json.data[USER]];
                [[UserInfoConfig sharedUserInfoConfig] saveRRMJUser:user];
                [self popRootViewController];
                
            }else{
                
                [IanAlert alertError:json.msg length:1];
                if ([json.msg isEqualToString:@"账号未被绑定"]) {
                    [self performSelector:@selector(pushVC) withObject:nil afterDelay:1];
                }
            }
                
        }else{
            
            [IanAlert alertError:ERRORMSG1 length:1];
        }
        
    } failure:^(YTKBaseRequest *request) {

        [IanAlert alertError:ERRORMSG2 length:1];
        
    }];
}

#pragma mark 注册新账号
- (void)pushVC
{
     [self performSegueWithIdentifier:@"thirdLogin" sender:self];
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    [self.loginView1 endEditing:YES];
    [self.loginView2 endEditing:YES];
}

- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView
{
    titleView.currentIndex = scrollView.contentOffset.x/App_Frame_Width;
}

- (void)resignText
{
    [self.loginView1 endEditing:YES];
}

#pragma mark 传值
-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    if([segue.identifier isEqualToString:@"findPsd"]) //"goView2"是SEGUE连线的标识
    {
        //邮箱找回密码
        PsdEmailVC *  theSegue = segue.destinationViewController;
        theSegue.isEmail = YES;
        
    }else if([segue.identifier isEqualToString:@"authCode"]){
        
        RegisterVC * theSegue = segue.destinationViewController;
        theSegue.type = self.isType;
    
    }else if([segue.identifier isEqualToString:@"thirdLogin"]){
        
        BoundThildVC * theSegue = segue.destinationViewController;
        theSegue.thirdInfo = self.currentDic;
    }
    
}
- (void)updateViewConstraints
{
    [super updateViewConstraints];
    self.viewWidth.constant = Main_Screen_Width*2;
    self.viewHeight.constant = Main_Screen_Height - 64;
    self.secondViewLeadding.constant = App_Frame_Width;
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
