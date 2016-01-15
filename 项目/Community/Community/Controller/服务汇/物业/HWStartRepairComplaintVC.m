//
//  HWStartRepairComplaintVC.m
//  Community
//
//  Created by niedi on 15/6/15.
//  Copyright (c) 2015年 caijingpeng. All rights reserved.
//

#import "HWStartRepairComplaintVC.h"
#import "HWPublishRemarkView.h"
#import "HWPicBrownerAndEditViewController.h"
#import "AppDelegate.h"

@interface HWStartRepairComplaintVC ()<HWPublishRemarkView,UIImagePickerControllerDelegate,UINavigationControllerDelegate,HWPicBrownerAndEditViewControllerDelegate>
{
    HWPublishRemarkView *remarkView;
    NSInteger _commitPicNum;
    NSString *_placeHolder;
}
@end

@implementation HWStartRepairComplaintVC

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    if (self.type == StartRepair)
    {
        _placeHolder = @"小区哪里坏了，快来跟物业报修吧！";
        self.navigationItem.titleView = [Utility navTitleView:@"报修"];
        self.navigationItem.rightBarButtonItem = [Utility navButton:self title:@"发布" action:@selector(toPublish)];
    }
    else if (self.type == StartComplaint)
    {
        _placeHolder = @"对物业有什么不满意？快来这里说说吧！";
        self.navigationItem.titleView = [Utility navTitleView:@"投诉"];
        self.navigationItem.rightBarButtonItem = [Utility navButton:self title:@"发布" action:@selector(toPublish)];
    }
    else
    {
        
        _placeHolder = @"如果有什么特殊要求，在这里说明吧~~";
        self.navigationItem.titleView = [Utility navTitleView:@"备注"];
        self.navigationItem.rightBarButtonItem = [Utility navButton:self title:@"确定" action:@selector(toPublish)];
    }
    
    remarkView = [[HWPublishRemarkView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, CONTENT_HEIGHT) withTextViewPlaceHolder:_placeHolder];
    remarkView.publishRemarkViewDelegate = self;
    if (self.beizhuImgArr != nil)
    {
        [remarkView.picView fillWithFullPicArray:(NSMutableArray *)self.beizhuImgArr];
    }
    if (self.beiZhuStr.length != 0)
    {
        remarkView.textView.text = self.beiZhuStr;
    }
    [self.view addSubview:remarkView];
}


- (void)toPublish
{
    NSString *publishStr = [[remarkView.textView.text stringByReplacingOccurrencesOfString:@"\n" withString:@" "] stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]];
    
    if (remarkView.picView.picArray.count == 0 && (publishStr == nil || [publishStr isEqualToString:@""] || [publishStr isEqualToString:@"小区哪里坏了，快来跟物业报修吧！"] || [publishStr isEqualToString:@"对物业有什么不满意？快来这里说说吧！"]))
    {
        [Utility showToastWithMessage:@"写点内容再发吧~" inView:self.view];
        return;
    }
    
    [Utility showMBProgress:self.view message:LOADING_TEXT];
    
    [self commitPicArr];
}

- (void)commitPicArr
{
    _commitPicNum = 0;
    
    if (remarkView.picView.picArray.count != 0)
    {
        for (NSMutableDictionary *dict in remarkView.picView.picArray)
        {
            if ([[dict stringObjectForKey:@"isCommit"] isEqualToString:@"0"])
            {
                [self commitPic:dict];
            }
            else
            {
                _commitPicNum += 1;
            }
        }
    }
    else
    {
        [self doPublish];
    }
}

- (void)commitPic:(NSMutableDictionary *)imgDict
{
    /*接口：hw-sq-app-web/repair/uploadFile.do上传图片接口
     入参：key：用户key，pubFile 图片附件
     出参：
     { 'status': '1','mongoKey':'83e57fe582f1', 'data': '', 'detail': '请求数据成功!', 'key': '3e801f50-10d8-44d7-9ce7-83e57fe582f1' } */
    
    NSMutableDictionary *param = [[NSMutableDictionary alloc]init];
    [param setPObject:[HWUserLogin currentUserLogin].key forKey:@"key"];
    [param setPObject:[imgDict valueForKey:@"postImgData"] forKey:@"pubFile"];
    
    HWHTTPRequestOperationManager *manager = [HWHTTPRequestOperationManager manager];
    [manager POSTImage:KCommitPic parameters:param queue:nil success:^(id responese)
     {
         NSLog(@"responese ========================= %@",responese);
         NSString *mongoKey = [[responese dictionaryObjectForKey:@"data"] stringObjectForKey:@"mongoKey"];
         
         [imgDict setValue:mongoKey forKey:@"mongoKey"];
         [imgDict setValue:@"1" forKey:@"isCommit"];
         
         _commitPicNum += 1;
         if (_commitPicNum == remarkView.picView.picArray.count)
         {
             [self doPublish];
         }
         
         
     } failure:^(NSString *error) {
         [Utility hideMBProgress:self.view];
         [Utility showToastWithMessage:error inView:self.view];
     }];
}

- (void)doPublish
{
    if (self.type == StartRepair)
    {
        [self doPublishForRepair];
    }
    else if (self.type == StartComplaint)
    {
        [self doPublishForComplaint];
    }
    else
    {
        if (self.delegate && [self.delegate respondsToSelector:@selector(didLeaveMessage:imgStr:mongokeyArr:)])
        {
            NSMutableString *mongoKeyStr = [NSMutableString stringWithFormat:@"%@", remarkView.picView.picArray.count == 0 ? @"" : [[remarkView.picView.picArray pObjectAtIndex:0] stringObjectForKey:@"mongoKey"]];
            for (int i = 1; i < remarkView.picView.picArray.count; i++)
            {
                NSDictionary *dict = [remarkView.picView.picArray pObjectAtIndex:i];
                [mongoKeyStr appendFormat:@",%@", [dict stringObjectForKey:@"mongoKey"]];
            }
            if ([remarkView.textView.text isEqualToString:@"如果有什么特殊要求，在这里说明吧~~"])
            {
                [self.delegate didLeaveMessage:@"" imgStr:mongoKeyStr mongokeyArr:remarkView.picView.picArray];
            }
            else
            {
                [self.delegate didLeaveMessage:remarkView.textView.text imgStr:mongoKeyStr mongokeyArr:remarkView.picView.picArray];
            }
            [self.navigationController popViewControllerAnimated:YES];
        }
    }
}

- (void)doPublishForRepair
{
    /*接口：hw-sq-app-web/repair/addRepair.do
     入参：key：用户key，contentImages：图片mongoKey（多张图片“,”分割），content：内容
     出参：
     { 'status': '1', 'data': '', 'detail': '请求数据成功!', 'key': '3e801f50-10d8-44d7-9ce7-83e57fe582f1' } */
    
    NSMutableDictionary *param = [[NSMutableDictionary alloc]init];
    [param setPObject:[HWUserLogin currentUserLogin].key forKey:@"key"];
    NSMutableString *mongoKeyStr = [NSMutableString stringWithFormat:@"%@", remarkView.picView.picArray.count == 0 ? @"" : [[remarkView.picView.picArray pObjectAtIndex:0] stringObjectForKey:@"mongoKey"]];
    for (int i = 1; i < remarkView.picView.picArray.count; i++)
    {
        NSDictionary *dict = [remarkView.picView.picArray pObjectAtIndex:i];
        [mongoKeyStr appendFormat:@",%@", [dict stringObjectForKey:@"mongoKey"]];
    }
    [param setPObject:mongoKeyStr forKey:@"contentImages"];
    if ([remarkView.textView.text isEqualToString:@"小区哪里坏了，快来跟物业报修吧！"])
    {
        [param setPObject:@"" forKey:@"content"];
    }
    else
    {
        [param setPObject:remarkView.textView.text forKey:@"content"];
    }
    
    HWHTTPRequestOperationManager *manager = [HWHTTPRequestOperationManager manager];
    [manager POST:KPublishRepair parameters:param queue:nil success:^(id responese)
     {
         [Utility hideMBProgress:self.view];
         NSLog(@"responese ========================= %@",responese);
         
         AppDelegate *delegate = SHARED_APP_DELEGATE;
         [Utility showToastWithMessage:@"报修发布成功" inView:delegate.window];
         
         if (self.delegate && [self.delegate respondsToSelector:@selector(setRefreshVC)])
         {
             [self.delegate setRefreshVC];
         }
         [self.navigationController popViewControllerAnimated:YES];
         
     } failure:^(NSString *code, NSString *error) {
         [Utility hideMBProgress:self.view];
         [Utility showToastWithMessage:error inView:self.view];
     }];
}

- (void)doPublishForComplaint
{
    /*接口：hw-sq-app-web/complaint/addComplaint.do 新增投诉接口
     入参：key：用户key，image：图片mongoKey（多张图片“,”分割），content：内容
     出参：
     { 'status': '1', 'data': '', 'detail': '请求数据成功!', 'key': '3e801f50-10d8-44d7-9ce7-83e57fe582f1' }
     
     接口：hw-sq-app-web/complaint/uploadFile.do上传图片接口
     入参：key：用户key，pubFile 图片附件
     出参：
     { 'status': '1','mongoKey':'83e57fe582f1', 'data': '', 'detail': '请求数据成功!', 'key': '3e801f50-10d8-44d7-9ce7-83e57fe582f1' } */
    
    NSMutableDictionary *param = [[NSMutableDictionary alloc]init];
    [param setPObject:[HWUserLogin currentUserLogin].key forKey:@"key"];
    NSMutableString *mongoKeyStr = [NSMutableString stringWithFormat:@"%@", remarkView.picView.picArray.count == 0 ? @"" : [[remarkView.picView.picArray pObjectAtIndex:0] stringObjectForKey:@"mongoKey"]];
    for (int i = 1; i < remarkView.picView.picArray.count; i++)
    {
        NSDictionary *dict = [remarkView.picView.picArray pObjectAtIndex:i];
        [mongoKeyStr appendFormat:@",%@", [dict stringObjectForKey:@"mongoKey"]];
    }
    [param setPObject:mongoKeyStr forKey:@"images"];
    
    if ([remarkView.textView.text isEqualToString:@"对物业有什么不满意？快来这里说说吧！"])
    {
        [param setPObject:@"" forKey:@"content"];
    }
    else
    {
        [param setPObject:remarkView.textView.text forKey:@"content"];
    }
    
    
    HWHTTPRequestOperationManager *manager = [HWHTTPRequestOperationManager manager];
    [manager POST:KPerpotyComplain parameters:param queue:nil success:^(id responese)
     {
         [Utility hideMBProgress:self.view];
         NSLog(@"responese ========================= %@",responese);
         
         AppDelegate *delegate = SHARED_APP_DELEGATE;
         [Utility showToastWithMessage:@"投诉发布成功" inView:delegate.window];
         if (self.delegate && [self.delegate respondsToSelector:@selector(setRefreshVC)])
         {
             [self.delegate setRefreshVC];
         }
         [self.navigationController popViewControllerAnimated:YES];
         
     } failure:^(NSString *code, NSString *error) {
         [Utility hideMBProgress:self.view];
         [Utility showToastWithMessage:error inView:self.view];
     }];
}

- (void)didSelectImageToEditWithPicArray:(NSMutableArray *)picArrcy andSelectIndex:(NSInteger)index
{
    HWPicBrownerAndEditViewController *vc = [[HWPicBrownerAndEditViewController alloc] init];
    vc.delegate = self;
    vc.picArray = picArrcy;
    vc.selectIndex = index;
    [self.navigationController pushViewController:vc animated:YES];
}

- (void)didDeleteSelctedImg:(NSMutableArray *)picArray
{
    [remarkView.picView fillWithFullPicArray:picArray];
}

- (void)didSelectImageWithActionSheet:(NSInteger)index
{
    if (index == 0)
    {
        //拍照
        if (![UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeCamera])
        {
            [Utility showToastWithMessage:@"设备不支持拍照" inView:self.view];
            return;
        }
        if (IOS7)
        {
            AVAuthorizationStatus status = [AVCaptureDevice authorizationStatusForMediaType:AVMediaTypeVideo];
            if(status == AVAuthorizationStatusAuthorized)
            {
                [self presentImgPickVC];
            }
            else if(status == AVAuthorizationStatusDenied)
            {
                [Utility showToastWithMessage:@"请在设置-隐私中开启相机权限" inView:[(AppDelegate *)SHARED_APP_DELEGATE window]];
                return ;
            }
            else if(status == AVAuthorizationStatusRestricted)
            {
                // restricted
                [Utility showToastWithMessage:@"请在设置-隐私中开启相机权限" inView:[(AppDelegate *)SHARED_APP_DELEGATE window]];
                return ;
            }
            else if(status == AVAuthorizationStatusNotDetermined)
            {
                [AVCaptureDevice requestAccessForMediaType:AVMediaTypeVideo completionHandler:^(BOOL granted) {
                    if(granted)
                    {
                        [self presentImgPickVC];
                    }
                    else
                    {
                        [Utility showToastWithMessage:@"请在设置-隐私中开启相机权限" inView:[(AppDelegate *)SHARED_APP_DELEGATE window]];
                        return;
                    }
                }];
            }
        }
    }
    else
    {
        //从相册选取
        UIImagePickerController *imgPicker = [[UIImagePickerController alloc] init];
        imgPicker.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
        imgPicker.delegate = self;
        imgPicker.allowsEditing = YES;
        imgPicker.modalPresentationStyle = UIModalPresentationCurrentContext;
        [self presentViewController:imgPicker animated:YES completion:nil];
    }
}

- (void)presentImgPickVC
{
    UIImagePickerController *imgPicker = [[UIImagePickerController alloc] init];
    imgPicker.sourceType = UIImagePickerControllerSourceTypeCamera;
    imgPicker.delegate = self;
    imgPicker.allowsEditing = YES;
    imgPicker.modalPresentationStyle = UIModalPresentationCurrentContext;
    [self presentViewController:imgPicker animated:YES completion:nil];
}

- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info
{
    UIImage *image = [info objectForKey:UIImagePickerControllerEditedImage];
    //上传图片
    
    NSData *imageData = UIImageJPEGRepresentation(image, 1.0f);
    NSData *postImgData = [Utility convertImgTo256K:image];
    
    NSMutableDictionary *dict = [[NSMutableDictionary alloc] init];
    [dict setValue:imageData forKey:@"selectImage"];
    [dict setValue:postImgData forKey:@"postImgData"];
    [dict setValue:@"aaa" forKey:@"selectKey"];
    [dict setValue:@"0" forKey:@"isCommit"];
    [remarkView.picView fillWithPicDic:dict];
    
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (void)imagePickerControllerDidCancel:(UIImagePickerController *)picker
{
    [self dismissViewControllerAnimated:YES completion:nil];
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
