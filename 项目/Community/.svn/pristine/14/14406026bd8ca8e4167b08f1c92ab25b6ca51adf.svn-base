//
//  HWCropImageViewController.m
//  Community
//
//  Created by caijingpeng.haowu on 14-9-12.
//  Copyright (c) 2014年 caijingpeng. All rights reserved.
//

#import "HWCropImageViewController.h"
#import "KICropImageView.h"

@interface HWCropImageViewController ()
{
    KICropImageView *_cropImageView;
}
@end

@implementation HWCropImageViewController
@synthesize delegate;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.navigationItem.titleView = [Utility navTitleView:@"选择"];
    self.navigationItem.leftBarButtonItem = [Utility navLeftBackBtn:self action:@selector(backMethod)];
    self.navigationItem.rightBarButtonItem = [Utility navButton:self title:@"确定" action:@selector(doneCropImage:)];

    _cropImageView = [[KICropImageView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, CONTENT_HEIGHT)];
    [_cropImageView setCropSize:CGSizeMake(kScreenWidth, CROP_HEIGHT)];
    [_cropImageView setImage:self.stillImage];
    [self.view addSubview:_cropImageView];
}

- (void)backMethod
{
    [self.navigationController dismissViewControllerAnimated:YES completion:nil];
}

- (void)doneCropImage:(id)sender
{
    [MobClick event:@"click_OK"];
    if (delegate && [delegate respondsToSelector:@selector(didCropImage:)])
    {
        UIImage *cropImage = [_cropImageView cropImage];
        [delegate didCropImage:cropImage];
    }
    
    [self.navigationController dismissViewControllerAnimated:YES completion:nil];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
