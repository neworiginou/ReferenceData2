//
//  BoundNextVC.m
//  PUClient
//
//  Created by RRLhy on 15/7/21.
//  Copyright (c) 2015年 RRLhy. All rights reserved.
//

#import "BoundNextVC.h"
#import "InterestingSeriesVC.h"
#import  "RegisterPlatform.h"
#import "BoundOldApi.h"
#import "LoginPlatformApi.h"
@interface BoundNextVC ()
@property (weak, nonatomic) IBOutlet UIView *freshView;
@property (weak, nonatomic) IBOutlet UITextField *thirdNick;
@property (weak, nonatomic) IBOutlet UIButton *sureBtn;
@property (weak, nonatomic) IBOutlet UIView *oldView;
@property (weak, nonatomic) IBOutlet UITextField *emailTf;
@property (weak, nonatomic) IBOutlet UITextField *psdTf;
@property (weak, nonatomic) IBOutlet UIButton *nextBtn;

@end
/*{
 iconUrl = "http://tp2.sinaimg.cn/1591507785/180/5710389372/1";
 platformName = sina;
 userName = DomiCC520;
 usid = 1591507785;
 }*/
@implementation BoundNextVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.

    if (self.isOld) {
        self.titleLabel.text = @"绑定老帐号";
        self.freshView.hidden = YES;
    }else{
        self.titleLabel.text = @"注册新账号";
        self.oldView.hidden = YES;
        self.thirdNick.text = self.userInfo[@"userName"];
    }
    
    UIImage * imageN = [UIImage stretchImageWithName:@"btn_me_n"];
    UIImage * imageH = [UIImage stretchImageWithName:@"btn_me_h"];
    UIImage * phoneN  = [UIImage stretchImageWithName:@"btn_me_carry-out_h"];
    UIImage * phoneH = [UIImage stretchImageWithName:@"btn_me_carry-out_n"];
    
    [_sureBtn setBackgroundImage:imageN forState:UIControlStateNormal];
    [_sureBtn setBackgroundImage:imageH forState:UIControlStateHighlighted];
    [_nextBtn setBackgroundImage:phoneN forState:UIControlStateNormal];
    [_nextBtn setBackgroundImage:phoneH forState:UIControlStateHighlighted];
}

#pragma mark 创建新账号
- (IBAction)creatNewCount:(id)sender {
    [IanAlert showloading];
    RegisterPlatform * api = [[RegisterPlatform alloc]initWithUserId:self.userInfo[@"usid"] PlatformName:self.userInfo[@"platformName"] NickName:self.thirdNick.text IconUrl:self.userInfo[@"iconUrl"] userName:self.userInfo[@"userName"]];
    [api startWithCompletionBlockWithSuccess:^(YTKBaseRequest *request) {
        NSDictionary * dic = request.responseJSONObject;
        NSLog(@"%@",dic);
        if (dic) {
            JsonModel * json = [JsonModel objectWithKeyValues:dic];
          
            if (json.code == SUCCESSCODE) {
                
                RrmjUser * user = [RrmjUser objectWithKeyValues:json.data[USER]];
                [[UserInfoConfig sharedUserInfoConfig] saveRRMJUser:user];
                [IanAlert hideLoading];
                [self performSelector:@selector(pushNext) withObject:nil afterDelay:1];
                
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

- (void)pushNext
{
    [self performSegueWithIdentifier:@"interestSeries" sender:self];
}

#pragma mark 绑定老帐号
- (IBAction)boundOldCount:(id)sender {
    
    [IanAlert showloading];
    BoundOldApi * api = [[BoundOldApi alloc]initWithUserId:self.userInfo[@"usid"] platformName:self.userInfo[@"platformName"] loginName:self.emailTf.text passWord:[self.psdTf.text MD5] nickName:self.userInfo[@"userName"]];
    [api startWithCompletionBlockWithSuccess:^(YTKBaseRequest *request) {
        NSDictionary * dic = request.responseJSONObject;
        NSLog(@"绑定老帐号%@",dic);
        if (dic) {
            JsonModel * json = [JsonModel objectWithKeyValues:dic];
            if (json.code == SUCCESSCODE) {
                [self platforlogin];
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

- (void)platforlogin
{
    LoginPlatformApi * api = [[LoginPlatformApi alloc]initWithUserId:self.userInfo[@"usid"] PlatformName:self.userInfo[@"platformName"]];
    [api startWithCompletionBlockWithSuccess:^(YTKBaseRequest *request) {
        NSDictionary * dic = request.responseJSONObject;
        if (dic) {
            NSLog(@"绑定成功后登陆%@",dic);
            JsonModel * json = [JsonModel objectWithKeyValues:dic];
            if (json.code == SUCCESSCODE) {
                
                RrmjUser * user = [RrmjUser objectWithKeyValues:json.data[USER]];
                [[UserInfoConfig sharedUserInfoConfig] saveRRMJUser:user];
                [IanAlert hideLoading];
                
                [self performSelector:@selector(popRootViewController) withObject:nil afterDelay:1];
            }
        }else{
            
            [IanAlert alertError:ERRORMSG1 length:1];
        }
    } failure:^(YTKBaseRequest *request) {
        
        [IanAlert alertError:ERRORMSG2 length:1];
    }];
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    if ([segue.identifier isEqualToString:@"interestSeries"]) {
        //选择剧集
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
