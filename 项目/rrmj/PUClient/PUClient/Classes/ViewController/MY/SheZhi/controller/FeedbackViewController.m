//
//  FeedbackViewController.m
//  PUClient
//
//  Created by lizhongqiang on 15/7/31.
//  Copyright (c) 2015年 RRLhy. All rights reserved.
//

#import "FeedbackViewController.h"

@interface FeedbackViewController ()<UITextViewDelegate>

@end

@implementation FeedbackViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = [UIColor colorWithRed:247/255.f green:248/255.f blue:249/255.f alpha:1.0];
    self.textfiled.delegate = self ;
    
    [self.commitBtn addTarget:self action:@selector(commitAction) forControlEvents:UIControlEventTouchUpInside];
}
- (void)commitAction
{
    if( [_textfiled isFirstResponder])
    {
        [_textfiled resignFirstResponder];
    }
    if([_typeLabel isFirstResponder])
    {
        [_typeLabel resignFirstResponder];
    }
    if(_textfiled.text.length)
    {
        NSLog(@"%@----%@",self.textfiled.text,_typeLabel.text);
    }
    
}
- (BOOL)textViewShouldBeginEditing:(UITextView *)textView
{
    _placeHolder.hidden = YES;
    return YES;
}
- (BOOL)textViewShouldEndEditing:(UITextView *)textView
{
    if(textView.text.length == 0)
    {
        _placeHolder.hidden = NO;
    }
    return YES;
}
- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
   if( [_textfiled isFirstResponder])
   {
       [_textfiled resignFirstResponder];
   }
   if([_typeLabel isFirstResponder])
    {
        [_typeLabel resignFirstResponder];
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
