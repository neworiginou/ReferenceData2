//
//  FeedbackViewController.m
//  PUClient
//
//  Created by lizhongqiang on 15/7/31.
//  Copyright (c) 2015年 RRLhy. All rights reserved.
//

#import "FeedbackViewController.h"
#import "SuggestApi.h"

@interface FeedbackViewController ()<UITextViewDelegate>

@end

@implementation FeedbackViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.titleLabel.text = @"意见反馈";
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
    NSString * str = [_textfiled.text replaceString];
    if(str.length)
    {
        SuggestApi * suggest = [[SuggestApi alloc]initWithWithContent:_textfiled.text Contact:_typeLabel.text Source:nil];
        [IanAlert showloadingAllowUserInteraction:NO];
        [suggest startWithCompletionBlockWithSuccess:^(YTKBaseRequest *request) {
            
            NSDictionary * dic = request.responseJSONObject;
            if (dic) {
                NSLog(@"%@",dic);
                JsonModel * json = [JsonModel objectWithKeyValues:dic];
                if (json.code == SUCCESSCODE) {
                    
                    [IanAlert alertSuccess:@"提交成功" length:1];
                    
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
