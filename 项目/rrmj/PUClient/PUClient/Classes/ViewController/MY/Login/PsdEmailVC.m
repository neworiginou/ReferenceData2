//
//  PsdEmailVC.m
//  PUClient
//
//  Created by RRLhy on 15/7/21.
//  Copyright (c) 2015年 RRLhy. All rights reserved.
//

#import "PsdEmailVC.h"

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
    }else{
        _emailView.hidden = YES;
    }
    
    
}

#pragma 手机找回
- (IBAction)phoneClick:(id)sender {
    
    
    
}

#pragma mark 邮箱找回
- (IBAction)emailClick:(id)sender {
    
    
    
    
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
