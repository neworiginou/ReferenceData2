//
//  MyBoundVC.m
//  PUClient
//
//  Created by RRLhy on 15/8/4.
//  Copyright (c) 2015年 RRLhy. All rights reserved.
//

#import "MyBoundVC.h"
#import "Bound3rdApi.h"
#import "Bound3Api.h"
#import "ClearCountApi.h"
#import "MyBounding.h"
#import "RegisterVC.h"

@interface MyBoundVC ()<UMSocialUIDelegate>
@property (weak, nonatomic) IBOutlet UILabel *introLabel;
@property (weak, nonatomic) IBOutlet UILabel *mobileLabel;
@property (weak, nonatomic) IBOutlet UILabel *weixinLabel;
@property (weak, nonatomic) IBOutlet UILabel *weiboLabel;
@property (weak, nonatomic) IBOutlet UILabel *qqLabel;
@property (nonatomic,retain)MyBounding * myBound;
@end

@implementation MyBoundVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.titleLabel.text = @"账号绑定";
    
    RrmjUser * user = [UserInfoConfig sharedUserInfoConfig].userInfo;
    if ([user.loginFrom isEqualToString:@"mobile"]) {
        _introLabel.text = @"你正在使用手机账号登录";
    }else if([user.loginFrom isEqualToString:@"sina"]){
        _introLabel.text = @"你正在使用sina登录";
    }else if([user.loginFrom isEqualToString:@"wxsession"]){
        _introLabel.text = @"你正在使用微信登录";
    }else if([user.loginFrom isEqualToString:@"qq"]){
        _introLabel.text = @"你正在使用QQ登录";
    }else if ([user.loginFrom isEqualToString:@"email"]){
        _introLabel.text = @"你正在使用邮箱登录";
    }
    
    //获取绑定信息
    [IanAlert showloadingAllowUserInteraction:NO];
    [self requestMyCountInformation];
}

- (void)requestMyCountInformation
{
    Bound3rdApi * api = [[Bound3rdApi alloc]initWithUserToken:[UserInfoConfig sharedUserInfoConfig].userInfo.token];
    [api startWithCompletionBlockWithSuccess:^(YTKBaseRequest *request) {
        
        NSDictionary * dic = request.responseJSONObject;
        if (dic) {
            JsonModel * json = [JsonModel objectWithKeyValues:dic];
            
            if (json.code == SUCCESSCODE) {
                [IanAlert hideLoading];
                
                _myBound = [MyBounding objectWithKeyValues:json.data];
                _mobileLabel.text = _myBound.mobile.length?_myBound.mobile:@"立即绑定";
                _weixinLabel.text = _myBound.wxsession.length?_myBound.wxsession:@"立即绑定";
                _weiboLabel.text = _myBound.sina.length?_myBound.sina:@"立即绑定";
                _qqLabel.text = _myBound.qq.length?_myBound.qq:@"立即绑定";
                
            }else{
                
                [IanAlert alertError:json.msg length:1];
            }
            NSLog(@"%@",dic);
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

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    //先判断什么方式登陆
    RrmjUser * me = [UserInfoConfig sharedUserInfoConfig].userInfo;
    NSArray  * typeArray = @[@"mobile",@"wxsession",@"sina",@"qq"];
    NSArray  * wayArray = @[_myBound.mobile,_myBound.wxsession,_myBound.sina,_myBound.qq];
    NSString * type = typeArray[indexPath.row];

    
    if (indexPath.row == 0) {
        if ([type isEqualToString:me.loginFrom]) {
            
            UIAlertView * view = [[UIAlertView alloc]initWithTitle:@"提示" message:@"是否更换手机号" delegate:self cancelButtonTitle:nil otherButtonTitles:@"是",@"否", nil];
            view.tag = indexPath.row;
            [view show];
            
        }else{
            
            [self BoundMobile];
        }
        
    }else{
        
        if ([type isEqualToString:me.loginFrom]) {
            
            return;
        }
        
        NSString * boundWay = wayArray[indexPath.row];
        if (boundWay.length == 0) {
            //绑定第三方
            NSArray * array = @[UMShareToWechatSession,UMShareToSina,UMShareToQQ];
            [UMSocialControllerService defaultControllerService].socialUIDelegate = self;
            //sina微博
            UMSocialSnsPlatform * snsPlatform = [UMSocialSnsPlatformManager getSocialPlatformWithName:array[indexPath.row - 1]];
            snsPlatform.loginClickHandler(self,[UMSocialControllerService defaultControllerService],YES,^(UMSocialResponseEntity *response){
                
                if (response.responseCode == UMSResponseCodeSuccess) {
                    UMSocialAccountEntity *snsAccount = [[UMSocialAccountManager socialAccountDictionary] valueForKey:array[indexPath.row - 1]];
                    NSLog(@"%@",snsAccount);
                    if (!snsAccount) {
                        [IanAlert alertError:@"授权失败" length:1.5];
                        return ;
                    }
                    NSDictionary * dic = @{@"userName":snsAccount.userName,
                                           @"iconUrl":snsAccount.iconURL,
                                           @"usid":snsAccount.usid,
                                           @"platformName":snsAccount.platformName};
                    
                    [self boundOrClearThirdCount:dic];
                    
                }
            });
            
        }else{
            
            UIAlertView * view = [[UIAlertView alloc]initWithTitle:@"提示" message:@"是否立即解绑" delegate:self cancelButtonTitle:nil otherButtonTitles:@"是",@"否", nil];
            view.tag = indexPath.row;
            [view show];
        }
    }

}

- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    if (alertView.tag == 0) {
        //更换手机
        if (buttonIndex == 0) {
            
            [self BoundMobile];
        }
    }else{
        //解绑
        if (buttonIndex == 0) {
            
            [self unBoundWithIndex:alertView.tag];
        }
    }
}

- (void)BoundMobile
{
    UIStoryboard * storyboard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
    RegisterVC * registerVC = [storyboard instantiateViewControllerWithIdentifier:@"mobileBind"];
    [self.navigationController pushViewController:registerVC animated:YES];
}

#pragma mark 绑定第三方
- (void)boundOrClearThirdCount:(NSDictionary *)data
{
    NSString * token = [UserInfoConfig sharedUserInfoConfig].userInfo.token;
    Bound3Api * api = [[Bound3Api alloc]initWith3rdPlatName:data[@"platformName"] uid:data[@"usid"] userName:data[@"userName"] token:token];
    [api startWithCompletionBlockWithSuccess:^(YTKBaseRequest *request) {
        NSDictionary * dic = request.responseJSONObject;
        if (dic) {
            NSLog(@"绑定第三方%@",dic);
            JsonModel * json = [JsonModel objectWithKeyValues:dic];
            if (json.code == SUCCESSCODE) {
                [IanAlert alertSuccess:@"绑定成功" length:1];
                [self requestMyCountInformation];
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

#pragma mark 解绑
- (void)unBoundWithIndex:(NSInteger)index
{
    NSArray * nameArray = @[@"mobile",@"wxsession",@"sina",@"qq"];
    NSString * token = [UserInfoConfig sharedUserInfoConfig].userInfo.token;
    ClearCountApi * api = [[ClearCountApi alloc]initWithUserToken:token platName:nameArray[index]];
    [api startWithCompletionBlockWithSuccess:^(YTKBaseRequest *request) {
        
        NSDictionary * dic = request.responseJSONObject;
        if (dic) {
            NSLog(@"解除绑定%@",dic);
            JsonModel * json = [JsonModel objectWithKeyValues:dic];
            if (json.code == SUCCESSCODE) {
                [IanAlert alertSuccess:@"取消成功" length:1];
                [self requestMyCountInformation];
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

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 0.1;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    return 0.1;
}

#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}


@end
