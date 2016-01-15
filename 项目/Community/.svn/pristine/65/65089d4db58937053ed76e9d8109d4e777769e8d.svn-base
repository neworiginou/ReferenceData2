//
//  ApplyVertifyViewController.m
//  Community
//
//  Created by gusheng on 14-9-8.
//  Copyright (c) 2014年 caijingpeng. All rights reserved.
//

#import "ApplyVertifyViewController.h"
#import "ApplyBusinessLicenseVertifyViewController.h"
@interface ApplyVertifyViewController ()

@end

@implementation ApplyVertifyViewController
@synthesize identifyBackImageView,identifyBackSampleImageView,identifyFrontImageView,identifyFrontSampleImageView,ipc,identifyBackImageViewTemp,identifyFrontImageViewTemp,titleLabel;
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
    self.navigationItem.leftBarButtonItem = [Utility navLeftBackBtn:self action:@selector(back:)];
    self.navigationItem.rightBarButtonItem = [Utility navButton:self title:@"提交" action:@selector(submit:)];
    self.view.backgroundColor = UIColorFromRGB(0xececec);
    self.navigationItem.titleView = [Utility navTitleView:@"申请认证"];
    identifyFrontImageViewTemp = [[UIImageView alloc]init];
    identifyBackImageViewTemp = [[UIImageView alloc]init];
    [self settingimageViewCornus];
    frontAndBackFlag = YES;
}
//上传身份证正面图
-(IBAction)clickIdentifyFront:(id)sender
{
    frontAndBackFlag = YES;
    UIActionSheet *sheet = [[UIActionSheet alloc] initWithTitle:nil delegate:self cancelButtonTitle:@"取消" destructiveButtonTitle:nil otherButtonTitles:@"拍照",@"从相册中选择", nil];
    sheet.actionSheetStyle = UIActionSheetStyleBlackTranslucent;
    [sheet showInView:self.view];
}
//上传身份证反面
-(IBAction)clickIdentifyBack:(id)sender
{
    frontAndBackFlag = NO;
    UIActionSheet *sheet = [[UIActionSheet alloc] initWithTitle:nil delegate:self cancelButtonTitle:@"取消" destructiveButtonTitle:nil otherButtonTitles:@"拍照",@"从相册中选择", nil];
    sheet.actionSheetStyle = UIActionSheetStyleBlackTranslucent;
    [sheet showInView:self.view];
}
//设置imageview的边缘
-(void)settingimageViewCornus
{
    identifyFrontSampleImageView.layer.cornerRadius = 5.0f;
    identifyFrontSampleImageView.backgroundColor = [UIColor clearColor];
    identifyFrontImageView.backgroundColor = [UIColor clearColor];
    identifyFrontImageView.layer.cornerRadius = 5.0f;
    identifyBackImageView.backgroundColor = [UIColor clearColor];
    identifyBackImageView.layer.cornerRadius = 5.0f;
    identifyBackSampleImageView.backgroundColor = [UIColor clearColor];
    identifyBackSampleImageView.layer.cornerRadius = 5.0f;
    titleLabel.textColor =UIColorFromRGB(0x333333);
}
//提交
-(void)submit:(id)senderr
{
    if (!identifyFrontImageViewTemp.image) {
        [Utility showToastWithMessage:@"身份证正面不能为空" inView:self.view];
        return;
    }
    else if(!identifyBackImageViewTemp.image)
    {
        [Utility showToastWithMessage:@"身份证反面不能为空" inView:self.view];
        return;
    }
    ApplyBusinessLicenseVertifyViewController *businessLicenseView = [[ApplyBusinessLicenseVertifyViewController alloc]initWithNibName:@"ApplyBusinessLicenseVertifyViewController" bundle:nil];
    businessLicenseView.identifyFrontImageView = identifyFrontImageViewTemp;
    businessLicenseView.identifyBackImageView = identifyBackImageViewTemp;
    [self.navigationController pushViewController:businessLicenseView animated:YES];
}
//返回上一级
-(void)back:(id)sender
{
    [self.navigationController popViewControllerAnimated:YES];
}
#pragma - mark imagePickViewDelegate --代理方法
- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info
{
    //nslog(@"image info:%@",info);
    UIImage *image = [info objectForKey:UIImagePickerControllerEditedImage];
    //[AppShare getShareInstance].currentUser.localAvatar = image;//保存头像
    
    if (frontAndBackFlag) {
        identifyFrontImageView.image = image;
        identifyFrontImageViewTemp.image = image;
    }
    else
    {
        identifyBackImageView.image = image;
        identifyBackImageViewTemp.image = image;
    }
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingImage:(UIImage *)image editingInfo:(NSDictionary *)editingInfo{
    
}
//actionSheetDelegateMethod方法
#pragma mark - actionsheet
- (void)actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex
{
    if(buttonIndex ==2)
        return;
    self.ipc = [[UIImagePickerController alloc] init];
    ipc.delegate = self;
    if (buttonIndex == 0) {
        ipc.sourceType =  UIImagePickerControllerSourceTypeCamera;
    } else if (buttonIndex ==1) {
        ipc.sourceType =  UIImagePickerControllerSourceTypePhotoLibrary;
    }
    ipc.allowsEditing = YES;
    ipc.modalPresentationStyle = UIModalPresentationCurrentContext;
    [self presentViewController:ipc animated:YES completion:nil];
}

- (void)imagePickerControllerDidCancel:(UIImagePickerController *)picker
{
    //nslog(@"imagePickerControllerDidCancel");
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
