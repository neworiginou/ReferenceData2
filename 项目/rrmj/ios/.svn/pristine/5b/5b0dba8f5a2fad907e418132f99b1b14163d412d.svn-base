//
//  ChangePsdVC.m
//  PUClient
//
//  Created by RRLhy on 15/8/4.
//  Copyright (c) 2015年 RRLhy. All rights reserved.
//

#import "ChangePsdVC.h"
#import "ModifiedPwdApi.h"
@interface ChangePsdVC ()
@property (weak, nonatomic) IBOutlet UITextField *oldPsd;
@property (weak, nonatomic) IBOutlet UITextField *nowPsd;
@property (weak, nonatomic) IBOutlet UITextField *surePsd;

@end

@implementation ChangePsdVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.titleLabel.text = @"修改密码";
    
}
- (IBAction)complete:(id)sender {
    
    NSString * str1 = [_oldPsd.text replaceString];
    NSString * str2 = [_nowPsd.text replaceString];
    NSString * str3 = [_surePsd.text replaceString];
    
    if (str1.length==0||str2.length ==0||str3.length==0) {
        [IanAlert alertError:@"密码不能为空" length:1];
        return;
    }
    
    if (![str2 isEqualToString:str3]) {
        [IanAlert alertError:@"新密码两次输入有误" length:1];
        return;
    }
    
    ModifiedPwdApi * resetApi = [[ModifiedPwdApi alloc]initWithUserId:[UserInfoConfig sharedUserInfoConfig].userInfo.Id oldPwd:[_oldPsd.text MD5] newPwd:[_surePsd.text MD5]];
    [IanAlert showloadingAllowUserInteraction:NO];
    [resetApi startWithCompletionBlockWithSuccess:^(YTKBaseRequest *request) {
        
        NSDictionary * dic = request.responseJSONObject;
        if (dic) {
            NSLog(@"%@",dic);
            JsonModel * json = [JsonModel objectWithKeyValues:dic];
            if (json.code == SUCCESSCODE) {
                
                [IanAlert alertSuccess:@"修改成功" length:1];
                
            }else{
                
                [IanAlert alertSuccess:json.msg length:1];
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
