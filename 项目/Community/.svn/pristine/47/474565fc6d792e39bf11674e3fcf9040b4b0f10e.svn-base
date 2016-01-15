//
//  HWShopManageViewController.h
//  Community
//
//  Created by gusheng on 14-9-16.
//  Copyright (c) 2014年 caijingpeng. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "HWRefreshBaseViewController.h"
#import "HWShopNewsTableViewCell.h"
#import "HWShopNews.h"
#import "ImgScrollView.h"
#import "HWRefreshBaseViewController.h"
#import "HWRequestConfig.h"
#import "HWHTTPRequestOperationManager.h"
#import "HWUserLogin.h"
#import "GKImagePicker.h"
#import "HWGKImagePickerController.h"
#import "HWImageScrollView.h"
#import "HWStoreDetailClass.h"
#import "MJPhoto.h"
#import "MJPhotoBrowser.h"

@interface HWShopManageViewController : HWRefreshBaseViewController<UITableViewDataSource,UITableViewDelegate,ImgScrollViewDelegate,UIScrollViewDelegate,UIImagePickerControllerDelegate,UIActionSheetDelegate,UINavigationControllerDelegate,UITextFieldDelegate,UITextViewDelegate,UITextViewDelegate,GKImagePickerDelegate,GKCameraManagerDelegate,HWImageScrollViewDelegate,UIImagePickerControllerDelegate,UINavigationControllerDelegate,UIAlertViewDelegate>
{
    NSMutableArray *array;
    float height;
    UIButton *footBtn;
    BOOL isMore;
    NSMutableArray *arrShopInfo;                    //商铺动态数组
    UIView *tableHeadView;                          //表格的头
    UIImageView *shopBigImg;
    UITextField *ShopNameText;
    UILabel *vertifyLabel;
    UIButton *editBtn;                              //编辑标题的输入框
    UITextField *btnCallText;                       //编辑电话信息输入框
    UITextField *phoneNumberText;                   //编辑手机号码
    UITextView *ServerDetailTextView;               //服务细节描述
    UILabel *labServerRightTextView;             //服务描述输入框
    UIView *whiteView;                              //服务时间服务范围
    UILabel *labTimeDetail;                         //营业时间
    UILabel *labCall ;
    UIButton *serviceScopeBtn;
    UITextField *textAddressDetail;
    UIImageView *serverDesIcon;
    UIImageView *serverScopeIcon;
    UIView *shopPhotoView;
    UIButton *applyVertifyBtn;
    HWImageScrollView * imageScrollView;
    UIImagePickerController *pickerC ;
    UIImageView *clickLookBigImageView;             //点击查看大图
    BOOL fangDaFlag;
    UIImageView *currentImageView;
    NSString *shopType;                             //店铺类型
    NSString *openTime;
    NSString *closeTime;
    NSArray *serviceCatoryImageArry;
    NSMutableArray *serviceArry;
    NSMutableArray *photoGetArry;                   //从服务端请求回来得图片
    NSMutableArray *addPhotoArry;                   //本地新上传的图片
    HWStoreDetailClass *detail;                     //商铺详情Model
    NSString* selectCatoryIndex;                    //选择类别的索引
    UIImageView *shopTypeImg;
    UIView *sectionOneView;                         //创建sectionOne视图
    UIView *sectionTwoView;                         //创建sectionTwo视图
    UIView *authorView;
    NSString *longTitudeStr;
    NSString *latitudeStr;
    NSMutableArray *frontSelectedCommunityArry;    //上次记忆的小区
    BOOL picModifyFlag;//图片是否修改
  
}

@property(nonatomic,strong)NSString *shopId;
@property (nonatomic, strong)UIImagePickerController *ipc;
@property (nonatomic, strong)UIImagePickerController *ipcShop;
@property(nonatomic,strong)NSString *shopIdStr;
@property(nonatomic,assign)BOOL renlinFlag;         //认领店铺
@end
