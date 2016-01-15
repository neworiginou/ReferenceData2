//
//  HWShowOrderViewController.m
//  Community
//
//  Created by caijingpeng.haowu on 14-12-10.
//  Copyright (c) 2014年 caijingpeng. All rights reserved.
//


#import "HWShowOrderViewController.h"
#import "HWInputBackView.h"
#import "SBJson.h"
#import "AppDelegate.h"

#define INPUT_PLACEHOLDER       @"晒晒中奖心情（50字内）"

@interface HWShowOrderViewController ()<UITextViewDelegate, UIActionSheetDelegate, UIImagePickerControllerDelegate, UINavigationControllerDelegate>
{
    UIButton *photoBtn;
    HWInputBackView *photoInputBack;
    UITextView *textV;
    NSData *imgData;
    HWHTTPRequestOperationManager *manage;
}
@property (nonatomic, strong) UIImagePickerController *imagePicker;

@end

@implementation HWShowOrderViewController
@synthesize imagePicker;

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.navigationItem.leftBarButtonItem = [Utility navLeftBackBtn:self action:@selector(backMethod)];
    self.navigationItem.titleView = [Utility navTitleView:@"晒单有奖"];
    self.navigationItem.rightBarButtonItem = [Utility navButton:self title:@"提交" action:@selector(commitAction)];
    HWInputBackView *inputBack = [[HWInputBackView alloc] initWithFrame:CGRectMake(0, 10, kScreenWidth, 90) withLineCount:1];
    [self.view addSubview:inputBack];
    
    textV = [[UITextView alloc] initWithFrame:CGRectMake(15, 5, kScreenWidth - 30, inputBack.frame.size.height - 10)];
    textV.backgroundColor = [UIColor clearColor];
    textV.delegate = self;
    textV.font = [UIFont fontWithName:FONTNAME size:14.0f];
    textV.text = INPUT_PLACEHOLDER;
    textV.textColor = THEME_COLOR_SMOKE;
    [inputBack addSubview:textV];
    
    //图片
    photoInputBack = [[HWInputBackView alloc] initWithFrame:CGRectMake(0,
                                                                       CGRectGetMaxY(inputBack.frame) + 10,
                                                                       kScreenWidth,
                                                                       65) withLineCount:1];
    [self.view addSubview:photoInputBack];
    
    photoBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    photoBtn.frame = CGRectMake(0, 0, kScreenWidth, photoInputBack.frame.size.height);
    photoBtn.backgroundColor = [UIColor clearColor];
    [photoBtn setImageEdgeInsets:UIEdgeInsetsMake(0, -20, 0, 0)];
    [photoBtn setTitleEdgeInsets:UIEdgeInsetsMake(0, 0, 0, 0)];
    [photoBtn setImage:[UIImage imageNamed:@"gray_add"] forState:UIControlStateNormal];
    [photoBtn setTitle:@"添加照片" forState:UIControlStateNormal];
    [photoBtn setTitleColor:THEME_COLOR_TEXT forState:UIControlStateNormal];
    photoBtn.titleLabel.font = [UIFont fontWithName:FONTNAME size:THEME_FONT_BIG];
    [photoBtn addTarget:self action:@selector(toAddPhoto:) forControlEvents:UIControlEventTouchUpInside];
    [photoInputBack addSubview:photoBtn];
    
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(doTap:)];
    [self.view addGestureRecognizer:tap];
}

- (void)doTap:(UITapGestureRecognizer *)sender
{
    [self.view endEditing:YES];
}

- (void)toAddPhoto:(id)sender
{
    
    UIActionSheet *actionsheet = [[UIActionSheet alloc] initWithTitle:nil delegate:self cancelButtonTitle:@"取消" destructiveButtonTitle:nil otherButtonTitles:@"拍照", @"选择图片", nil];
    [actionsheet showInView:self.view];
    
    [textV resignFirstResponder];
}

#pragma mark -
#pragma mark        UITextViewDelegate

- (BOOL)textViewShouldBeginEditing:(UITextView *)textView
{
    if ([textView.text isEqualToString:INPUT_PLACEHOLDER])
    {
        textView.text = @"";
    }
    return YES;
}
- (BOOL)textViewShouldEndEditing:(UITextView *)textView
{
    if ([textView.text isEqualToString:@""])
    {
        textView.text = INPUT_PLACEHOLDER;
    }
    return YES;
}

- (BOOL)textView:(UITextView *)textView shouldChangeTextInRange:(NSRange)range replacementText:(NSString *)text
{
    NSMutableString *resultText = [textView.text mutableCopy];
    [resultText replaceCharactersInRange:range withString:text];
    
//    NSLog(@"text : %d %@ ",[Utility calculateTextLength:resultText], resultText);
    
    if (resultText.length > 100 && range.length == 0) // 50 个 汉字
    {
        return NO;
    }
    return YES;
}

#pragma mark -
#pragma mark        UIActionSheetDelegate

- (void)actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex
{
    if (buttonIndex == 0)
    {
//        GKImagePickerController *imagePicker = [[GKImagePickerController alloc] init];
//        imagePicker.delegate = self;
//        UINavigationController *nav = [[UINavigationController alloc] initWithRootViewController:imagePicker];
//        [self presentViewController:nav animated:YES completion:nil];
        self.imagePicker = [[UIImagePickerController alloc] init];
        imagePicker.delegate = self;
        imagePicker.sourceType =  UIImagePickerControllerSourceTypeCamera;
        imagePicker.allowsEditing = NO;
        imagePicker.modalPresentationStyle = UIModalPresentationCurrentContext;
        [self presentViewController:imagePicker animated:YES completion:nil];
    }
    else if (buttonIndex == 1)
    {
        self.imagePicker = [[UIImagePickerController alloc] init];
        imagePicker.delegate = self;
        imagePicker.sourceType =  UIImagePickerControllerSourceTypePhotoLibrary;
        imagePicker.allowsEditing = NO;
        imagePicker.modalPresentationStyle = UIModalPresentationCurrentContext;
        [self presentViewController:imagePicker animated:YES completion:nil];
    }
}

#pragma mark -
#pragma mark        UIImagePickerControllerDelegate

- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info
{
    UIImage *image = [info objectForKey:UIImagePickerControllerOriginalImage];

    imgData = UIImageJPEGRepresentation(image, 0);
    
    photoBtn.frame = CGRectMake(15, 5, kScreenWidth - 30, 220);
    
    CGRect frame = photoInputBack.frame;
    frame.size.height = 230;
    photoInputBack.frame = frame;
    
    [photoBtn setImageEdgeInsets:UIEdgeInsetsMake(0, 0, 0, 0)];
    photoBtn.imageView.contentMode = UIViewContentModeScaleAspectFit;
    [photoBtn setImage:image forState:UIControlStateNormal];
    [photoBtn setTitle:@"" forState:UIControlStateNormal];

    [self dismissViewControllerAnimated:YES completion:nil];
}

#pragma mark --- 提交

- (void)commitAction{
    
    
    [MobClick event:@"click_submit my show"];
    
    /**
     *  key
     productId 低价产品id
     lowUserId 砍价低价用户id
     file 或者showContent最少选一项
     */
    if (textV.text.length == 0 || [textV.text isEqualToString:INPUT_PLACEHOLDER])
    {
        [Utility showToastWithMessage:@"请输入文字" inView:self.view];
        return;
    }
    
    if (imgData == nil) {
        [Utility showToastWithMessage:@"请插入图片" inView:self.view];
        return;
    }
    
    
    [Utility showMBProgress:self.view message:@"提交中..."];
    if ([textV.text isEqualToString:INPUT_PLACEHOLDER] && imgData.length == 0) {
        [Utility showMBProgress:self.view message:@"图片和内容至少写一项"];
    }
    
    manage = [HWHTTPRequestOperationManager cutManager];
    NSMutableDictionary *dict = [[NSMutableDictionary alloc] init];
    [dict setPObject:[HWUserLogin currentUserLogin].key forKey:@"key"];
    [dict setPObject:self.productID forKey:@"productId"];
    [dict setPObject:[HWUserLogin currentUserLogin].userId forKey:@"lowUserId"];
    [dict setPObject:@"1" forKey:@"source"];
    
    if (textV.text.length != 0) {
        [dict setPObject:textV.text forKey:@"showContent"];
    }
    
    [dict setPObject:imgData forKey:@"file"];
    [manage POSTShowImage:kShowOrder parameters:dict queue:nil success:^(id responseObject) {
        
        [Utility hideMBProgress:self.view];
        [Utility showToastWithMessage:@"提交成功" inView:self.view];
        [self.navigationController popViewControllerAnimated:YES];
//        NSArray *respList = [[responseObject dictionaryObjectForKey:@"data"] arrayObjectForKey:@"content"];
        
    } failure:^(NSString *error) {
        
        NSLog(@"error %@",error);
        [Utility hideMBProgress:self.view];
        [Utility showToastWithMessage:error inView:self.view];
        
    }];
    
    
}

@end
