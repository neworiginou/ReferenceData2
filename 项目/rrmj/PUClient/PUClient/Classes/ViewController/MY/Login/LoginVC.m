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
@property (nonatomic,assign)BOOL isFindPsd;
@property (nonatomic,retain)NSDictionary * currentDic;
@end

@implementation LoginVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
 
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
    titleView = [[LoginTopView alloc]initWithFrame:CGRectMake((App_Frame_Width - 200)/2, 8, 200, 27) items:array];
    titleView.indexBlock = ^(NSInteger index){
        
        [weakself.mainScrollView setContentOffset:CGPointMake(App_Frame_Width*index, 0) animated:YES];
    };
    self.navigationItem.titleView = titleView;
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
    [IanAlert showLoading:@"登陆中..."];
    switch (btn.tag) {
        case 10:
        {
            //手机登录
            [self phoneLogin];
        }
            break;
        case 20:
        {
            //邮箱登录
            [self emailLogin];
        
//            UIAlertView * view = [[UIAlertView alloc]initWithTitle:@"提示" message:@"绑定手机号后可以直接用手机登录，是否立即绑定" delegate:self cancelButtonTitle:nil otherButtonTitles:@"立即绑定",@"暂不绑定", nil];
//            [view show];
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
            JsonModel * json = [[JsonModel alloc]init];
            [json setValuesForKeysWithDictionary:dic];
            if (json.success) {
                [IanAlert alertSuccess:@"登陆成功" length:1];
                RrmjUser * model = [RrmjUser objectWithKeyValues:json.data];
                [[UserInfoConfig sharedUserInfoConfig] saveRRMJUser:model];
            }else{
                [IanAlert alertError:json.errorCode length:1];
            }
        }else{
            [IanAlert alertError:ERRORMSG1 length:1];
        }
        
    } failure:^(YTKBaseRequest *request) {
        
        NSLog(@"手机登陆fial");
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
            JsonModel * json = [[JsonModel alloc]init];
            [json setValuesForKeysWithDictionary:dic];
            if (json.success) {
                [IanAlert alertSuccess:@"登陆成功" length:1];
                RrmjUser * user = [RrmjUser objectWithKeyValues:json.data];
                [[UserInfoConfig sharedUserInfoConfig] saveRRMJUser:user];
            }else{
                [IanAlert alertError:json.errorCode length:1];
            }
        }else{
            [IanAlert alertError:ERRORMSG1 length:1];
        }
        
    } failure:^(YTKBaseRequest *request) {
        NSLog(@"邮箱登录fial");
        [IanAlert alertError:ERRORMSG2 length:1];

    }];
}

- (IBAction)registerClick:(id)sender {
    
    self.isFindPsd = NO;
    [self performSegueWithIdentifier:@"authCode" sender:self];
}

- (IBAction)lostPsdClick:(id)sender {
   
    UIButton * btn = (UIButton*)sender;
    switch (btn.tag) {
        case 100:
        {
            //手机找回
            self.isFindPsd = YES;
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
    switch (index) {
        case 0:
        {
            //sina微博
            UMSocialSnsPlatform * snsPlatform = [UMSocialSnsPlatformManager getSocialPlatformWithName:UMShareToSina];
            snsPlatform.loginClickHandler(self,[UMSocialControllerService defaultControllerService],YES,^(UMSocialResponseEntity *response){
                
                if (response.responseCode == UMSResponseCodeSuccess) {
                    UMSocialAccountEntity *snsAccount = [[UMSocialAccountManager socialAccountDictionary] valueForKey:UMShareToSina];
                    
                    weakself.currentDic = @{@"userName":snsAccount.userName,
                                            @"iconUrl":snsAccount.iconURL,
                                            @"usid":snsAccount.usid,
                                            @"platformName":snsAccount.platformName};
    
                    [self platformLoginWithplatformName:snsAccount.platformName userId:snsAccount.usid];
                    
                }
            });

        }
            break;
        case 1:
        {
            //weixin登录
            UMSocialSnsPlatform * snsPlatform = [UMSocialSnsPlatformManager getSocialPlatformWithName:UMShareToWechatSession];
            snsPlatform.loginClickHandler(self,[UMSocialControllerService defaultControllerService],YES,^(UMSocialResponseEntity *response){
                if (response.responseCode == UMSResponseCodeSuccess) {
                    UMSocialAccountEntity *snsAccount = [[UMSocialAccountManager socialAccountDictionary] valueForKey:UMShareToWechatSession];
                    
                    weakself.currentDic = @{@"userName":snsAccount.userName,
                                            @"iconUrl":snsAccount.iconURL,
                                            @"usid":snsAccount.usid,
                                            @"platformName":snsAccount.platformName};
                    [self platformLoginWithplatformName:snsAccount.platformName userId:snsAccount.usid];
                }
            });
        }
            break;
        case 2:
        {
            //QQ登录
        
            UMSocialSnsPlatform * snsPlatform = [UMSocialSnsPlatformManager getSocialPlatformWithName:UMShareToQQ];
            snsPlatform.loginClickHandler(self,[UMSocialControllerService defaultControllerService],YES,^(UMSocialResponseEntity *response){
                
                if (response.responseCode == UMSResponseCodeSuccess) {
                    UMSocialAccountEntity *snsAccount = [[UMSocialAccountManager socialAccountDictionary] valueForKey:UMShareToSina];
                    
                    weakself.currentDic = @{@"userName":snsAccount.userName,
                                            @"iconUrl":snsAccount.iconURL,
                                            @"usid":snsAccount.usid,
                                            @"platformName":snsAccount.platformName};
                    
                    [self platformLoginWithplatformName:snsAccount.platformName userId:snsAccount.usid];
                }
            });

        }
            break;
            
        default:
            break;
    }
}

- (void)platformLoginWithplatformName:(NSString*)platform userId:(NSString*)userId
{
    LoginPlatformApi * api = [[LoginPlatformApi alloc]initWithUserId:userId PlatformName:platform];
    [api startWithCompletionBlockWithSuccess:^(YTKBaseRequest *request) {
        
        NSDictionary * dic  = request.responseJSONObject;
        NSLog(@"微信三方登陆%@",dic);
        if (dic) {
            JsonModel * json = [[JsonModel alloc]init];
            [json setValuesForKeysWithDictionary:dic];
            
            if (json.success) {
                
                [IanAlert alertSuccess:@"登陆成功" length:1];
                RrmjUser * user = [RrmjUser objectWithKeyValues:json.data];
                [[UserInfoConfig sharedUserInfoConfig] saveRRMJUser:user];
                [self popRootViewController];
                
            }else{
                
                [IanAlert alertError:json.errorCode length:1];
                if ([json.errorCode isEqualToString:@"该账号未被绑定！"]) {
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
        PsdEmailVC *  theSegue = segue.destinationViewController;
        
        theSegue.isEmail = YES;
    }else if([segue.identifier isEqualToString:@"authCode"]){
        
        RegisterVC * theSegue = segue.destinationViewController;
        theSegue.isFindPsd = self.isFindPsd;
        
    }else if([segue.identifier isEqualToString:@"thirdLogin"]){
        
        BoundThildVC * theSegue = segue.destinationViewController;
        theSegue.thirdInfo = self.currentDic;
    }
    
}
- (void)updateViewConstraints
{
    [super updateViewConstraints];
    self.viewWidth.constant = App_Frame_Width*2;
    self.secondViewLeadding.constant = App_Frame_Width;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
