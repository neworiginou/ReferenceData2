//
//  ApplyBusinessLicenseVertifyViewController.m
//  Community
//
//  Created by gusheng on 14-9-8.
//  Copyright (c) 2014年 caijingpeng. All rights reserved.
//

#import "ApplyBusinessLicenseVertifyViewController.h"
#import "HWRequestConfig.h"
#import "HWHTTPRequestOperationManager.h"
@interface ApplyBusinessLicenseVertifyViewController ()

@end

@implementation ApplyBusinessLicenseVertifyViewController
@synthesize businessLinceseImageView,businessLinceseSampleImageView,ipc,businessLinceseImageViewTemp,identifyFrontImageView,identifyBackImageView,titleLabel;
- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}
//绘制Imageview的圆边
-(void)createImageViewConrnus
{
    businessLinceseSampleImageView.layer.cornerRadius = 5.0f;
    businessLinceseImageView.backgroundColor = [UIColor clearColor];
    businessLinceseImageView.layer.cornerRadius = 5.0f;
    businessLinceseSampleImageView.backgroundColor = [UIColor clearColor];
}
//上传营业执照的图片
-(IBAction)clickSubmitBusinessLicense:(id)sender
{
    UIActionSheet *sheet = [[UIActionSheet alloc] initWithTitle:nil delegate:self cancelButtonTitle:@"取消" destructiveButtonTitle:nil otherButtonTitles:@"拍照",@"从相册中选择", nil];
    sheet.actionSheetStyle = UIActionSheetStyleBlackTranslucent;
    [sheet showInView:self.view];
}
//提交
-(void)submit:(id)senderr
{
    [self modifyIdentifyAndBusinessImage];
}
//返回上一级
-(void)back:(id)sender
{
    [self.navigationController popViewControllerAnimated:YES];
}
- (void)viewDidLoad
{
    [super viewDidLoad];
    self.navigationItem.leftBarButtonItem = [Utility navLeftBackBtn:self action:@selector(back:)];
    self.navigationItem.rightBarButtonItem = [Utility navButton:self title:@"提交" action:@selector(submit:)];
    self.view.backgroundColor = UIColorFromRGB(0xececec);
    self.navigationItem.titleView = [Utility navTitleView:@"申请认证"];
    businessLinceseImageViewTemp = [[UIImageView alloc]init];
    titleLabel.textColor = UIColorFromRGB(0x333333);
    [self createImageViewConrnus];
}
#pragma - mark imagePickViewDelegate --代理方法
- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info
{
    //nslog(@"image info:%@",info);
    UIImage *image = [info objectForKey:UIImagePickerControllerEditedImage];
    //[AppShare getShareInstance].currentUser.localAvatar = image;//保存头像
    businessLinceseImageView.image = image;
    businessLinceseImageViewTemp.image = image;
//    NSString *documentsDirectory = [Utility savedPath];
//    //NSString *savedImagePath=[documentsDirectory stringByAppendingPathComponent:[NSString stringWithFormat:@"%@.jpg",[AppShare getShareInstance].currentUser.telephone]];
//    NSString *savedImagePath=[documentsDirectory stringByAppendingPathComponent:[NSString stringWithFormat:@"%@.jpg",@"18021859455"]];
//    NSData *imgData = UIImageJPEGRepresentation(image, 1.0f);
//    [imgData writeToFile:savedImagePath atomically:YES];
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingImage:(UIImage *)image editingInfo:(NSDictionary *)editingInfo{
    
}
//actionSheetDelegateMethod方法
#pragma mark - actionsheet
- (void)actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex
{
    if (buttonIndex == 0)
    {
        self.ipc = [[UIImagePickerController alloc] init];
        ipc.delegate = self;
        ipc.sourceType =  UIImagePickerControllerSourceTypeCamera;
        ipc.allowsEditing = YES;
        ipc.modalPresentationStyle = UIModalPresentationCurrentContext;
        [self presentViewController:ipc animated:YES completion:nil];
    }
    else if (buttonIndex == 1)
    {
        self.ipc = [[UIImagePickerController alloc] init];
        ipc.delegate = self;
        ipc.sourceType =  UIImagePickerControllerSourceTypePhotoLibrary;
        ipc.allowsEditing = YES;
        ipc.modalPresentationStyle = UIModalPresentationCurrentContext;
        [self presentViewController:ipc animated:YES completion:nil];
    }
    
    
}

- (void)imagePickerControllerDidCancel:(UIImagePickerController *)picker
{
    //nslog(@"imagePickerControllerDidCancel");
    [self dismissViewControllerAnimated:YES completion:nil];
}
#pragma mark - 发送身份证 店铺营业证请求

-(void)modifyIdentifyAndBusinessImage
{
    if (!businessLinceseImageViewTemp.image) {
        [Utility showToastWithMessage:@"未选择营业执照" inView:self.view];
        return;
    }
    [Utility showMBProgress:self.view.window message:@"提交认证信息"];
    HWHTTPRequestOperationManager *manager = [HWHTTPRequestOperationManager manager];
    NSMutableDictionary *dict = [NSMutableDictionary dictionary];
    NSData *businessLinceseImageData = UIImageJPEGRepresentation(businessLinceseImageView.image, 1.0);
    NSData *identifyFrontImageData = UIImageJPEGRepresentation(identifyFrontImageView.image, 1.0);
    NSData *identifyBackImageData = UIImageJPEGRepresentation(identifyBackImageView.image, 1.0);
    //[dict setPObject:[HWUserLogin currentUserLogin].key forKey:@"key"];//接口里面已经包了key
    [dict setPObject:businessLinceseImageData forKey:@"yyzzFile"];
    [dict setPObject:identifyFrontImageData forKey:@"idCard0File"];
    [dict setPObject:identifyBackImageData forKey:@"idCard1File"];
    [dict setPObject:[HWUserLogin currentUserLogin].shopId forKey:@"shopId"];
    
    [manager POSTIndentifyAndBusinessVertifyImage:kUploadVertify parameters:dict queue:nil success:^(id responseObject) {
        [Utility hideMBProgress:self.view.window];
        [Utility showToastWithMessage:@"你的店铺认证申请已经提交，审核通过后店铺资料更真实可信" inView:self.view];
        [self.navigationController popToRootViewControllerAnimated:YES];
        
    } failure:^(NSString *error) {
        [Utility hideMBProgress:self.view.window];
        NSLog(@"error");
    }];
}
- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
