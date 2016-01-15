//
//  HWLaunchShopViewController.h
//  Community
//
//  Created by caijingpeng.haowu on 14-9-7.
//  Copyright (c) 2014年 caijingpeng. All rights reserved.
//

#import "HWBaseViewController.h"
#import "GKImagePicker.h"
#import "HWGKImagePickerController.h"
#import "HWImageScrollView.h"
#import "ImgScrollView.h"


@interface HWLaunchShopViewController : HWBaseViewController<UITextFieldDelegate, UITextViewDelegate, UIActionSheetDelegate,GKImagePickerDelegate,GKCameraManagerDelegate,HWImageScrollViewDelegate,UIImagePickerControllerDelegate,UINavigationControllerDelegate,ImgScrollViewDelegate>
{
//    UIToolbar *_backToolBar;
    NSMutableArray *serviceArry;
    UIView *foot;
    
    UIView *panelView;
    UIView *markView;
    UIScrollView *myScrollView;
    NSString *serviceCatoryStr;
    NSArray *arrImg;
    NSInteger currentIndex;     //当前点击相册按钮的索引
    UIButton *btn;
    HWImageScrollView * imageScrollView;
    UIImagePickerController *pickerC ;
    NSString *openTimeStr;
    NSString *closeTimeStr;
    NSString *latitudeStr;
    NSString *longtitudeStr;
    
}
@property(nonatomic,strong)NSMutableArray *remmberSelectedArry;//记住上一次选中好
@property(nonatomic,copy)void(^refershShopStatus)();
@end
