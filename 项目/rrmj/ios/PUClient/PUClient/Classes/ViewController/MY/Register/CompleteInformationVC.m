//
//  CompleteInformationVC.m
//  PUClient
//
//  Created by RRLhy on 15/7/20.
//  Copyright (c) 2015年 RRLhy. All rights reserved.
//

#import "CompleteInformationVC.h"
#import "RegisterApi.h"

@interface CompleteInformationVC ()
@property (weak, nonatomic) IBOutlet UIButton *completeBtn;
@property (weak, nonatomic) IBOutlet UITextField *psdTf;
@property (weak, nonatomic) IBOutlet UITextField *psdSureTf;
@property (weak, nonatomic) IBOutlet UITextField *countTf;

@end

@implementation CompleteInformationVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.titleLabel.text = @"完善资料";
    UIImage * doneN = [UIImage stretchImageWithName:@"btn_me_carry-out_n"];
    UIImage * doneH = [UIImage stretchImageWithName:@"btn_me_carry-out_h"];
    
    [_completeBtn setBackgroundImage:doneN forState:UIControlStateNormal];
    [_completeBtn setBackgroundImage:doneH forState:UIControlStateHighlighted];
}
- (IBAction)completeClick:(id)sender {
    
    NSLog(@"完成");
    [self registerOneCount];
}

- (void)registerOneCount
{
    if (![self.psdTf.text isEqualToString:self.psdSureTf.text]) {
        [IanAlert alertError:@"两次密码不一致" length:1];
        return;
    }
    NSString *username = [self.countTf.text replaceString];
    NSString *password = [self.psdSureTf.text replaceString];

    if (username.length > 0 && password.length > 0) {
        [IanAlert showLoading:@"注册中..."];
        RegisterApi *api = [[RegisterApi alloc] initWithMobile:self.mobile nickName:_countTf.text passWord:[_psdSureTf.text MD5] Code:self.code];
        [api startWithCompletionBlockWithSuccess:^(YTKBaseRequest *request) {
            // 你可以直接在这里使用 self
            NSDictionary * dic = request.responseJSONObject;
            NSLog(@"手机完善信息%@",dic);
            
            if (dic) {
                JsonModel * json = [JsonModel objectWithKeyValues:dic];

                if (json.code == SUCCESSCODE) {
                    RrmjUser * user = [RrmjUser objectWithKeyValues:json.data[USER]];
                    [[UserInfoConfig sharedUserInfoConfig] saveRRMJUser:user];
                    [IanAlert alertSuccess:@"注册成功" length:1];
                    [self performSelector:@selector(pushVC) withObject:nil afterDelay:1];
                    
                }else{
                    [IanAlert alertError:json.msg length:1];
                }
            }else{
                [IanAlert alertError:ERRORMSG1 length:1];
            }
            
        } failure:^(YTKBaseRequest *request) {
            // 你可以直接在这里使用 self
            [IanAlert alertError:ERRORMSG2 length:1];
        }];
    }
}

- (void)pushVC
{
    [self performSegueWithIdentifier:@"interest1" sender:self];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}


@end
