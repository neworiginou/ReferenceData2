//
//  UMContactViewController.m
//  Demo
//
//  Created by liuyu on 4/2/13.
//  Copyright (c) 2013 iOS@Umeng. All rights reserved.
//

#import "UMContactViewController.h"

@implementation UMContactViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil {
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)backToPrevious
{
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)updateContactInfo
{
    if ([self.delegate respondsToSelector:@selector(updateContactInfo:contactInfo:)]) {
        [self.delegate updateContactInfo:self contactInfo:self.textView.text];
    }

    [self backToPrevious];
}

- (void)setupCancelBtn
{
    self.navigationItem.leftBarButtonItem = [Utility navLeftBackBtn:self action:@selector(backToPrevious)];
}

- (void)setupSaveBtn
{
    self.navigationItem.rightBarButtonItem = [Utility navButton:self title:@"保存" action:@selector(updateContactInfo)];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.navigationItem.titleView = [Utility navTitleView:@"填写联系信息"];
    
    self.view.backgroundColor = [UIColor colorWithRed:238.0 / 255 green:238.0 / 255 blue:238.0 / 255 alpha:1.0];

    [self setupCancelBtn];
    [self setupSaveBtn];

    self.textView.text = @"我的手机号";
    [self.textView selectAll:self];
}

- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];

    [self.textView becomeFirstResponder];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
