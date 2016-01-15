//
//  SCViewController.m
//  SoapWebServices
//
//  Created by SC2 on 14-2-28.
//  Copyright (c) 2014年 北京士昌信息技术有限公司. All rights reserved.
//

#import "SCViewController.h"
#import "SCHttpClient.h"
@interface SCViewController ()

@end

@implementation SCViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)pushButtonPressed:(id)sender {
    SCHttpClient *client=[SCHttpClient new];
    [client postRequestWithPhoneNumber:_phoneNumber.text];
}
@end
