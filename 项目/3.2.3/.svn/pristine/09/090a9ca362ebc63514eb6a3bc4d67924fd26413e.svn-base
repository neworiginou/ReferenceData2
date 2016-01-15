//
//  UMContactViewController.m
//  Demo
//
//  Created by liuyu on 4/2/13.
//  Copyright (c) 2013 iOS@Umeng. All rights reserved.
//

#import "UMContactViewController.h"
#import "Partner_Swift-Swift.h"

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

- (void)updateContactInfo {

    if ([self.delegate respondsToSelector:@selector(updateContactInfo:contactInfo:)]) {
        [self.delegate updateContactInfo:self contactInfo:self.textView.text];
    }
    
    [self backToPrevious];
}

- (void)setupCancelBtn
{
    UIButton *cancelBarBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [cancelBarBtn setBackgroundImage:[UIImage imageNamed:@"item_cancel.png"] forState:UIControlStateNormal];
    [cancelBarBtn setBackgroundImage:[UIImage imageNamed:@"item_cancel_selected.png"] forState:UIControlStateHighlighted];
//    [cancelBarBtn setTitle:@"取消" forState:UIControlStateNormal];
//    [cancelBarBtn setTitleColor:[UIColor redColor] forState:UIControlStateNormal];
    cancelBarBtn.frame = CGRectMake(0, 0, 40.0f, 40.0f);
    [cancelBarBtn addTarget:self action:@selector(backToPrevious) forControlEvents:UIControlEventTouchUpInside];

    UIBarButtonItem *cancelButtonItem = [[UIBarButtonItem alloc] initWithCustomView:cancelBarBtn];
    self.navigationItem.leftBarButtonItem = cancelButtonItem;
}

- (void)setupSaveBtn
{
    UIButton *saveBarBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [saveBarBtn setBackgroundImage:[UIImage imageNamed:@"item_ok.png"] forState:UIControlStateNormal];
    [saveBarBtn setBackgroundImage:[UIImage imageNamed:@"item_ok_selected.png"] forState:UIControlStateHighlighted];
    [saveBarBtn setTitle:@"保存" forState:UIControlStateNormal];
    [saveBarBtn setTitleColor:[UIColor redColor] forState:UIControlStateNormal];
    saveBarBtn.frame = CGRectMake(0, 0, 40.0f, 40.0f);
    [saveBarBtn addTarget:self action:@selector(updateContactInfo) forControlEvents:UIControlEventTouchUpInside];

    UIBarButtonItem *saveButtonItem = [[UIBarButtonItem alloc] initWithCustomView:saveBarBtn];
    self.navigationItem.rightBarButtonItem = saveButtonItem;
}



- (void)viewDidLoad
{
    
    [super viewDidLoad];
//    self.navigationItem.title = NSLocalizedString(@"Fill in the Contact1", @"填写联系信息");
    self.navigationItem.titleView = [Utility navTitleView:@"填写手机号"];

    self.navigationItem.leftBarButtonItem = [Utility navLeftBackBtn:self _selector:@selector(backToPrevious)];
    self.navigationItem.rightBarButtonItem = [Utility navButton:self _title:@"保存" _selector:@selector(updateContactInfo)];
    
    self.view.backgroundColor = [UIColor colorWithRed:238.0 / 255 green:238.0 / 255 blue:238.0 / 255 alpha:1.0];

//    [self setupCancelBtn];
//    [self setupSaveBtn];
    
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
