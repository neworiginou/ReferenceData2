//
//  WYYCAdviceViewController.m
//  无忧云车司机
//
//  Created by luosai19910103@163.com on 15/6/19.
//  Copyright (c) 2015年 wuyouyunche. All rights reserved.
//

#import "WYYCAdviceViewController.h"
#import "MBProgressHUD.h"




@interface WYYCAdviceViewController ()<UITextViewDelegate>
@property (weak, nonatomic)   IBOutlet UITextView *commentTextView;
- (IBAction)send:(UIButton *)sender;

@end

@implementation WYYCAdviceViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title=@"意见反馈";
    
    
//    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(textViewDidChange) name:UITextViewTextDidBeginEditingNotification object:nil];
    self.commentTextView.delegate=self;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)textViewDidBeginEditing:(UITextView *)textView
{
    self.commentTextView.text=@"";
}

-(BOOL)textView:(UITextView *)textView shouldChangeTextInRange:(NSRange)range replacementText:(NSString *)text
{
    NSLog(@"shouldChangeTextInRange");
    if([text isEqualToString:@"\n"]) {
        [textView resignFirstResponder];
        return NO;
    }
    return YES;
}
/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

- (IBAction)send:(UIButton *)sender {
    
 //   [MBProgressHUD ]
}

/**
 * 监听文字改变
 */
- (void)textDidChange
{
    self.navigationItem.rightBarButtonItem.enabled = self.commentTextView.hasText;
}


- (void)viewWillAppear:(BOOL)animated
{
    self.tabBarController.tabBar.hidden=YES;
    
}

- (void)viewWillDisappear:(BOOL)animated
{
    self.tabBarController.tabBar.hidden=NO;
    
}
@end
