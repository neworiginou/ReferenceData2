//
//  FeedbackViewController.h
//  PUClient
//
//  Created by lizhongqiang on 15/7/31.
//  Copyright (c) 2015年 RRLhy. All rights reserved.
//

#import "BaseViewController.h"

@interface FeedbackViewController : BaseViewController

@property (weak, nonatomic) IBOutlet UITextView *textfiled;
@property (weak, nonatomic) IBOutlet UITextField *typeLabel;
@property (weak, nonatomic) IBOutlet UIButton *commitBtn;
@property (weak, nonatomic) IBOutlet UILabel *placeHolder;

@end
