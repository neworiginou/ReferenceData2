//
//  BoundThildVC.m
//  PUClient
//
//  Created by RRLhy on 15/7/21.
//  Copyright (c) 2015年 RRLhy. All rights reserved.
//

#import "BoundThildVC.h"
#import "BoundNextVC.h"
@interface BoundThildVC ()

@property (weak, nonatomic) IBOutlet UIButton *oldBtn;
@property (weak, nonatomic) IBOutlet UIButton *freshBtn;
@property (nonatomic,assign)BOOL isOld;
@end

@implementation BoundThildVC


- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.titleLabel.text = @"第三方账户登录";
    
    UIImage * imageN = [UIImage stretchImageWithName:@"btn_me_n"];
    UIImage * imageH = [UIImage stretchImageWithName:@"btn_me_h"];
    UIImage * registerN = [UIImage stretchImageWithName:@"btn_me_to-register_h"];
    
    [_freshBtn setBackgroundImage:imageN forState:UIControlStateNormal];
    [_freshBtn setBackgroundImage:imageH forState:UIControlStateHighlighted];
    [_oldBtn setBackgroundImage:registerN forState:UIControlStateNormal];
}

#pragma mark 创建新账号
- (IBAction)newCount:(id)sender {
    
    self.isOld = NO;
    [self performSegueWithIdentifier:@"boundThird" sender:self];
}

#pragma mark 绑定老帐号
- (IBAction)oldCount:(id)sender {
    
    self.isOld = YES;
    [self performSegueWithIdentifier:@"boundThird" sender:self];
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    if ([segue.identifier isEqualToString:@"boundThird"]) {
        
        BoundNextVC * theSegue = segue.destinationViewController;
        theSegue.isOld = self.isOld;
        theSegue.userInfo = self.thirdInfo;
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
