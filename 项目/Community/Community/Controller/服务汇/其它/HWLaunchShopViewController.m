//
//  HWLaunchShopViewController.m
//  Community
//
//  Created by caijingpeng.haowu on 14-9-7.
//  Copyright (c) 2014年 caijingpeng. All rights reserved.
//

#import "HWLaunchShopViewController.h"
#import "HWInputBackView.h"
#import "HWOpenTimeViewController.h"
#import "HWServiceCatoryViewController.h"
#import "HWCommunityViewController.h"
#import "MapLocationViewController.h"
#import "HWRequestConfig.h"
#import "HWServiceRangeClass.h"
#import "AppDelegate.h"
#import "NSString+HXAddtions.h"
#import "HWAreaClass.h"
#import "HWPhoto.h"
#import "MJPhoto.h"
#import "MJPhotoBrowser.h"
#import "HWUploadButton.h"

#define MOBILENUMBER_TAG    1001
#define PHONE_TAG           1002

@interface HWLaunchShopViewController ()<HWUploadButtonDelegate,UIAlertViewDelegate>
{
    UIScrollView *_mainSV;
    HWInputBackView *_section1;
    HWInputBackView *_section2;
    HWInputBackView *_section3;
    HWInputBackView *_section4;
    HWInputBackView *_section5;
    HWInputBackView *_section6;
    
    UITextField *_shopNameTF;
    UILabel *serviceLabel;
    UITextField *_shopAddressTF;
    UITextField *_mobileTF;
    UITextField *_servicePhoneTF;
    UIButton *_takeAwayBtn;
    UITextView *_descriptTV;
    UILabel *serviceScopeLabel;
    UILabel *serviceTimeLabel;
    UITextView *_serviceScopeDescriptTV;
    BOOL waiMaiFlag;
    
    UIScrollView *photoScroll;          //相册
    NSMutableArray *photoArr;           //图片的key
    NSMutableArray *photoId;            //图片ID
    NSMutableArray *arrPhotoName;
    NSMutableArray *arrPhotoImg;
    NSMutableArray *arrPhotoStatus;
}
@end

@implementation HWLaunchShopViewController
@synthesize remmberSelectedArry;
- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
        [self addKeyboardAbserver];
    }
    return self;
}
-(void)viewWillAppear:(BOOL)animated
{
}
- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.navigationItem.titleView = [Utility navTitleView:@"申请开店"];
    self.navigationItem.leftBarButtonItem = [Utility navLeftBackBtn:self action:@selector(backMethod)];
    self.navigationItem.rightBarButtonItem = [Utility navButton:self title:@"提交" action:@selector(submitShopInfo)];
    waiMaiFlag = YES;
    photoArr = [[NSMutableArray alloc] initWithObjects:@"0",@"0",@"0", nil];
    
    photoId = [[NSMutableArray alloc] init];
    arrPhotoName = [[NSMutableArray alloc] initWithObjects:@"门面图片",@"店内环境",@"服务菜单",@"", nil];
    UIImage *image = [UIImage imageNamed:@"openshop_addphoto"];
    arrPhotoImg = [[NSMutableArray alloc] initWithObjects:image,image,image,image, nil];
    arrPhotoStatus = [[NSMutableArray alloc] initWithObjects:@"0",@"0",@"0",@"0", nil];
    remmberSelectedArry = [[NSMutableArray alloc]init];

    
    [self initialScrollView];
    
//    _backToolBar = [[UIToolbar alloc]initWithFrame:CGRectMake(0, [UIScreen mainScreen].bounds.size.height, kScreenWidth, 40)];
//    [self.view addSubview:_backToolBar];
//    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(doResign)];
//    [_backToolBar addGestureRecognizer:tap];
    serviceCatoryStr = @"";
    openTimeStr = @"";
    closeTimeStr = @"";
    latitudeStr = @"0.0000";
    longtitudeStr = @"0.00000";
    
}

- (void)doResign{
    [_shopNameTF resignFirstResponder];
    [_shopAddressTF resignFirstResponder];
    [_mobileTF resignFirstResponder];
    [_servicePhoneTF resignFirstResponder];
    [_descriptTV resignFirstResponder];
    [_serviceScopeDescriptTV resignFirstResponder];
}


#pragma mark -
#pragma mark Initial View
-(void)tap
{
    [_descriptTV resignFirstResponder];
}
- (void)initialScrollView
{
    
    //UIImageView *backImageView = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, kScreenWidth, self.view.frame.size.height-64)];
    UITapGestureRecognizer *tapGesture = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(tap)];
    [self.view addGestureRecognizer:tapGesture];
    
    _mainSV = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, CONTENT_HEIGHT)];
    _mainSV.backgroundColor = UIColorFromRGB(0xf2f2f2);
    _mainSV.delaysContentTouches = YES;
    _mainSV.userInteractionEnabled = YES;
    [self.view addSubview:_mainSV];

    [self initialSection1];
    [self initialSection2];
    [self initialSection3];
    [self initialSection4];
    [self initialSection5];
    [self initialSection6];
    _mainSV.contentSize = CGSizeMake(kScreenWidth, CGRectGetMaxY(_section6.frame) + 60+10);
}

- (void)initialSection1
{
    _section1 = [[HWInputBackView alloc] initWithFrame:CGRectMake(0, 10, kScreenWidth, 135.0f) withLineCount:3];
    [_mainSV addSubview:_section1];
    
    for (int i = 0; i < 3; i++)
    {
        UILabel *titleLab = [[UILabel alloc] initWithFrame:CGRectMake(15, 7.5f + i * 45.0f, 80, 30)];
        titleLab.backgroundColor = [UIColor clearColor];
        titleLab.textColor = UIColorFromRGB(0x333333);
        titleLab.font = [UIFont fontWithName:FONTNAME size:15.0f];
        if (i == 0)
        {
            titleLab.text = @"店铺名 *";
            
            _shopNameTF = [[UITextField alloc] initWithFrame:CGRectMake(CGRectGetMaxX(titleLab.frame) + 5.0f, 7.5f, kScreenWidth - CGRectGetMaxX(titleLab.frame) - 15, 30)];
            _shopNameTF.backgroundColor = [UIColor clearColor];
            _shopNameTF.placeholder = @"必填";
            _shopNameTF.font = [UIFont fontWithName:FONTNAME size:15.0f];
            _shopNameTF.clearButtonMode = UITextFieldViewModeWhileEditing;
            _shopNameTF.delegate = self;
            _shopNameTF.textColor = UIColorFromRGB(0x999999);
            [_section1 addSubview:_shopNameTF];
            
        }
        else if (i == 1)
        {
            titleLab.text = @"服务类型 *";
            UIImageView *arrowImgV = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 8, 14)];
            arrowImgV.image = [UIImage imageNamed:@"arrow"];
            arrowImgV.center = CGPointMake(kScreenWidth - 15 + 4 - 8, titleLab.center.y);
            [_section1 addSubview:arrowImgV];
            
            serviceLabel = [[UILabel alloc]initWithFrame:CGRectMake(CGRectGetMaxX(titleLab.frame) + 5.0f, CGRectGetMinY(titleLab.frame), kScreenWidth - CGRectGetMaxX(titleLab.frame) - 40, 30)];
            serviceLabel.textAlignment = NSTextAlignmentLeft;
            serviceLabel.backgroundColor = [UIColor clearColor];
            serviceLabel.textColor = THEME_COLOR_TEXT;
            [serviceLabel setFont:[UIFont systemFontOfSize:15.0f]];
            [_section1 addSubview:serviceLabel];
        }
        else if (i == 2)
        {
            titleLab.text = @"店铺地址 *";
            _shopAddressTF = [[UITextField alloc] initWithFrame:CGRectMake(CGRectGetMaxX(titleLab.frame) + 5.0f, CGRectGetMinY(titleLab.frame), kScreenWidth - CGRectGetMaxX(titleLab.frame) - 40, 30)];
            _shopAddressTF.backgroundColor = [UIColor clearColor];
            _shopAddressTF.textColor = UIColorFromRGB(0x999999);
            _shopAddressTF.placeholder = @"请输入正确地址";
            _shopAddressTF.font = [UIFont fontWithName:FONTNAME size:15.0f];
            _shopAddressTF.clearButtonMode = UITextFieldViewModeWhileEditing;
            _shopAddressTF.delegate = self;
            [_section1 addSubview:_shopAddressTF];
            
            
            
            UIImageView *mapImageView = [[UIImageView alloc]initWithFrame:CGRectMake(kScreenWidth - 40+6, titleLab.frame.origin.y+5, 15, 18)];
            mapImageView.image = [UIImage imageNamed:@"创建小区-位置"];
            [_section1 addSubview:mapImageView];
            
            UIButton *mapBtn = [UIButton buttonWithType:UIButtonTypeCustom];
            mapBtn.frame = CGRectMake(kScreenWidth - 40, titleLab.frame.origin.y, 40, 30);
            mapBtn.backgroundColor = [UIColor clearColor];
            [mapBtn addTarget:self action:@selector(toSelectAddress:) forControlEvents:UIControlEventTouchUpInside];
            [_section1 addSubview:mapBtn];
        }
        [_section1 addSubview:titleLab];
    }
    
    UIButton *serviceCategory = [UIButton buttonWithType:UIButtonTypeCustom];
    serviceCategory.frame = CGRectMake(0, 45.0f, kScreenWidth, 45.0f);
    [serviceCategory addTarget:self action:@selector(toSelectCategory:) forControlEvents:UIControlEventTouchUpInside];
    serviceCategory.backgroundColor = [UIColor clearColor];
    [_section1 addSubview:serviceCategory];
    
}

- (void)initialSection2
{
    _section2 = [[HWInputBackView alloc] initWithFrame:CGRectMake(0, CGRectGetMaxY(_section1.frame) + 10, kScreenWidth, 90.0f) withLineCount:2];
    [_mainSV addSubview:_section2];
    
    for (int i = 0; i < 2; i++)
    {
        UILabel *titleLab = [[UILabel alloc] initWithFrame:CGRectMake(15, 7.5f + i * 45.0f, 80, 30)];
        titleLab.backgroundColor = [UIColor clearColor];
        titleLab.textColor = UIColorFromRGB(0x333333);
        titleLab.font = [UIFont fontWithName:FONTNAME size:15.0f];
        
        if (i == 0)
        {
            titleLab.tag = MOBILENUMBER_TAG;
            titleLab.text = @"手机 *";
            _mobileTF = [[UITextField alloc] initWithFrame:CGRectMake(CGRectGetMaxX(titleLab.frame) + 5.0f, 7.5f, kScreenWidth - CGRectGetMaxX(titleLab.frame) - 15, 30)];
            _mobileTF.backgroundColor = [UIColor clearColor];
            _mobileTF.placeholder = @"必填";
            _mobileTF.textColor = UIColorFromRGB(0x999999);
            _mobileTF.font = [UIFont fontWithName:FONTNAME size:15.0f];
            _mobileTF.clearButtonMode = UITextFieldViewModeWhileEditing;
            _mobileTF.keyboardType = UIKeyboardTypeNumberPad;
            _mobileTF.delegate = self;
            [_section2 addSubview:_mobileTF];
        }
        else if (i == 1)
        {
            titleLab.tag = PHONE_TAG;
            titleLab.text = @"座机 *";
            _servicePhoneTF = [[UITextField alloc] initWithFrame:CGRectMake(CGRectGetMaxX(titleLab.frame) + 5.0f, CGRectGetMinY(titleLab.frame), kScreenWidth - CGRectGetMaxX(titleLab.frame) - 15, 30)];
            _servicePhoneTF.backgroundColor = [UIColor clearColor];
            _servicePhoneTF.placeholder = @"必填";
            _servicePhoneTF.font = [UIFont fontWithName:FONTNAME size:15.0f];
            _servicePhoneTF.clearButtonMode = UITextFieldViewModeWhileEditing;
            _servicePhoneTF.delegate = self;
            _servicePhoneTF.textColor = UIColorFromRGB(0x999999);
            //_servicePhoneTF.keyboardType = UIKeyboardTypeNumberPad;
            [_section2 addSubview:_servicePhoneTF];
        }
        [_section2 addSubview:titleLab];
    }
}

- (void)initialSection3
{
    _section3 = [[HWInputBackView alloc] initWithFrame:CGRectMake(0, CGRectGetMaxY(_section2.frame) + 10, kScreenWidth, 45.0f) withLineCount:1];
    [_mainSV addSubview:_section3];
    
    UILabel *titleLab = [[UILabel alloc] initWithFrame:CGRectMake(15, 7.5f, 80, 30)];
    titleLab.backgroundColor = [UIColor clearColor];
    titleLab.textColor = UIColorFromRGB(0x333333);
    titleLab.font = [UIFont fontWithName:FONTNAME size:15.0f];
    titleLab.text = @"服务范围 *";
    [_section3 addSubview:titleLab];
    
    _serviceScopeDescriptTV = [[UITextView alloc] initWithFrame:CGRectMake(CGRectGetMaxX(titleLab.frame), 14, kScreenWidth - CGRectGetMaxX(titleLab.frame) - 22, 30.0f)];
    //            _descriptTV.scrollEnabled = NO;
    _serviceScopeDescriptTV.contentInset = UIEdgeInsetsMake(-10, 0, 0, 0);
    _serviceScopeDescriptTV.font = [UIFont fontWithName:FONTNAME size:15.0f];
    _serviceScopeDescriptTV.backgroundColor = [UIColor clearColor];
    _serviceScopeDescriptTV.textColor = THEME_COLOR_TEXT;
    _serviceScopeDescriptTV.delegate = self;
    [_section3 addSubview:_serviceScopeDescriptTV];


    
    UIImageView *arrowImgV = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 8, 14)];
    arrowImgV.image = [UIImage imageNamed:@"arrow"];
    arrowImgV.center = CGPointMake(kScreenWidth - 15 + 4 - 8, titleLab.center.y);
    [_section3 addSubview:arrowImgV];
    
    UIButton *scopeBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    scopeBtn.frame = CGRectMake(0, 0, kScreenWidth, 45.0f);
    [scopeBtn addTarget:self action:@selector(toSelectScope:) forControlEvents:UIControlEventTouchUpInside];
    [_section3 addSubview:scopeBtn];
}

- (void)initialSection4
{
    _section4 = [[HWInputBackView alloc] initWithFrame:CGRectMake(0, CGRectGetMaxY(_section3.frame) + 10, kScreenWidth, 90.0f) withLineCount:2];
    [_mainSV addSubview:_section4];
    
    for (int i = 0; i < 2; i++)
    {
        UILabel *titleLab = [[UILabel alloc] initWithFrame:CGRectMake(15, 7.5f + i * 45.0f, 80, 30)];
        titleLab.backgroundColor = [UIColor clearColor];
        titleLab.textColor = UIColorFromRGB(0x333333);
        titleLab.font = [UIFont fontWithName:FONTNAME size:15.0f];
        if (i == 0)
        {
            titleLab.text = @"营业时间 *";
            UIImageView *arrowImgV = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 8, 14)];
            arrowImgV.image = [UIImage imageNamed:@"arrow"];
            arrowImgV.center = CGPointMake(kScreenWidth - 15 + 4 - 8, titleLab.center.y);
            [_section4 addSubview:arrowImgV];
            
            serviceTimeLabel = [[UILabel alloc]initWithFrame:CGRectMake(CGRectGetMaxX(titleLab.frame) + 5.0f, CGRectGetMinY(titleLab.frame), kScreenWidth - CGRectGetMaxX(titleLab.frame) - 40, 30)];
            serviceTimeLabel.textAlignment = NSTextAlignmentLeft;
            serviceTimeLabel.backgroundColor = [UIColor clearColor];
            serviceTimeLabel.textColor = THEME_COLOR_TEXT;
            [serviceTimeLabel setFont:[UIFont systemFontOfSize:15.0f]];
            [_section4 addSubview:serviceTimeLabel];

        }
        else if (i == 1)
        {
            titleLab.text = @"服务描述";
            
            _descriptTV = [[UITextView alloc] initWithFrame:CGRectMake(CGRectGetMaxX(titleLab.frame) + 5.0f, 45.0f + 15.0f, kScreenWidth - CGRectGetMaxX(titleLab.frame) - 15, 25.0f)];
//            _descriptTV.scrollEnabled = NO;
            _descriptTV.contentInset = UIEdgeInsetsMake(-10, 0, 0, 0);
            _descriptTV.font = [UIFont fontWithName:FONTNAME size:15.0f];
            _descriptTV.backgroundColor = [UIColor clearColor];
            _descriptTV.textColor = THEME_COLOR_TEXT;
            _descriptTV.delegate = self;
            [_section4 addSubview:_descriptTV];
        }
        [_section4 addSubview:titleLab];
    }
    
    UIButton *openBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    openBtn.frame = CGRectMake(0, 0, kScreenWidth, 45.0f);
    openBtn.backgroundColor = [UIColor clearColor];
    [openBtn addTarget:self action:@selector(toSelectOpenTime:) forControlEvents:UIControlEventTouchUpInside];
    [_section4 addSubview:openBtn];
}

- (void)initialSection5
{
    //_section5 = [[HWInputBackView alloc] initWithFrame:CGRectMake(0, CGRectGetMaxY(_section4.frame) + 10, kScreenWidth, 128.0f) withLineCount:1];
    _section5 = [[HWInputBackView alloc] initWithFrame:CGRectMake(0, CGRectGetMaxY(_section4.frame) + 10, kScreenWidth, 148.0f) withLineCount:1];
    [_mainSV addSubview:_section5];
    
    UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(15, 4.5f, kScreenWidth - 30, 30)];
    label.textColor = UIColorFromRGB(0x333333);
    label.font = [UIFont fontWithName:FONTNAME size:15.0f];
    label.backgroundColor = [UIColor clearColor];
    label.text = @"店铺相册 *";
    [_section5 addSubview:label];
    
    [self createShopPhoto];
//    [self createZoomImage];
}

- (void)initialSection6
{
    _section6 = [[HWInputBackView alloc] initWithFrame:CGRectMake(0, CGRectGetMaxY(_section5.frame) + 10, kScreenWidth, 45.0f) withLineCount:1];
    [_mainSV addSubview:_section6];
    
    UILabel *titleLab = [[UILabel alloc] initWithFrame:CGRectMake(15, 7.5f, 80, 30)];
    titleLab.backgroundColor = [UIColor clearColor];
    titleLab.textColor = UIColorFromRGB(0x333333);
    titleLab.font = [UIFont fontWithName:FONTNAME size:15.0f];
    titleLab.text = @"外送";
    [_section6 addSubview:titleLab];
    
    _takeAwayBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    _takeAwayBtn.frame = CGRectMake(kScreenWidth - 24 - 15, (45 - 24) / 2.0f, 24, 24);
    [_takeAwayBtn setBackgroundImage:[UIImage imageNamed:@"persionuncheck"] forState:UIControlStateNormal];
    [_takeAwayBtn setImage:[UIImage imageNamed:@"persionCheck"] forState:UIControlStateNormal];
    [_takeAwayBtn addTarget:self action:@selector(toCheck:) forControlEvents:UIControlEventTouchUpInside];
    [_section6 addSubview:_takeAwayBtn];
}

#pragma mark -
#pragma mark Private method

- (void)refreshSectionViewFrame
{
    CGRect frame = _section2.frame;
    frame.origin.y = CGRectGetMaxY(_section1.frame) + 10;
    _section2.frame = frame;
    
    CGRect frame1 = _section3.frame;
    frame1.origin.y = CGRectGetMaxY(_section2.frame) + 10;
    _section3.frame = frame1;
    
    CGRect frame2 = _section4.frame;
    frame2.origin.y = CGRectGetMaxY(_section3.frame) + 10;
    _section4.frame = frame2;
    
    CGRect frame3 = _section5.frame;
    frame3.origin.y = CGRectGetMaxY(_section4.frame) + 10;
    _section5.frame = frame3;
    
    CGRect frame4 = _section6.frame;
    frame4.origin.y = CGRectGetMaxY(_section5.frame) + 10;
    _section6.frame = frame4;
    
    _mainSV.contentSize = CGSizeMake(kScreenWidth, CGRectGetMaxY(_section6.frame) + 40);
}

- (void)resetScrollViewFrameByKeyboardHeight:(float)height
{
    [UIView animateWithDuration:0.4 animations:^{
        
        
        _mainSV.frame = CGRectMake(0, 0, kScreenWidth, CONTENT_HEIGHT - height);
//        _backToolBar.frame = CGRectMake(0, CONTENT_HEIGHT - height - toolHeight, kScreenWidth, 40);
        //        UIWindow *keyWindow = [[UIApplication sharedApplication] keyWindow];
        //        UIView   *firstResponder = [keyWindow performSelector:@selector(firstResponder)];
        //        CGRect abRect = [firstResponder convertRect:firstResponder.frame toView:self.view];
        //        NSLog(@"%@",firstResponder);
        //        _mainSV.contentOffset = CGPointMake(0, abRect.origin.y + firstResponder.frame.size.height - 50);
        //        NSLog(@"%f",abRect.origin.y + firstResponder.frame.size.height - 50);
    }];
}

- (void)toSelectAddress:(id)sender
{
    MapLocationViewController *mapLocationView = [[MapLocationViewController alloc]initWithNibName:@"MapLocationViewController" bundle:nil];
    [self doResign];
    [mapLocationView setClickReturnLocation:^(NSString *posizition,NSString *latitude,NSString *longtitude) {
        
        _shopAddressTF.text = posizition;
        longtitudeStr = longtitude;
        latitudeStr = latitude;
    }];
    [self.navigationController pushViewController:mapLocationView animated:YES];
}

- (void)toCheck:(id)sender
{
    [MobClick event:@"click_change_doortodoor"];
    UIButton *checkBtn = (UIButton *)sender;
    if(![checkBtn imageForState:UIControlStateNormal])
    {
        [checkBtn setImage:[UIImage imageNamed:@"persionCheck"]  forState:UIControlStateNormal];
        waiMaiFlag = YES;
    }
    else
    {
        [checkBtn setImage:nil forState:UIControlStateNormal];
        waiMaiFlag = NO;
    }
}

- (void)addPhoto:(id)sender
{
    [self endEdit];
    
    UIActionSheet *actionSheet = [[UIActionSheet alloc] initWithTitle:nil delegate:self cancelButtonTitle:@"取消" destructiveButtonTitle:nil otherButtonTitles:@"拍照",@"相册", nil];
    [actionSheet showInView:self.view];
}

- (void)toSelectCategory:(id)sender
{
    [MobClick event:@"click_change_shoptype"];
    [self doResign];
    HWServiceCatoryViewController *serviceCatoryView = [[HWServiceCatoryViewController alloc]initWithNibName:@"HWServiceCatoryViewController" bundle:nil];
    [serviceCatoryView setSelectCatory:^(NSString *serviceCatory,NSString* index,NSURL *catoryImage) {
        NSLog(@"%@",serviceCatory);
        serviceLabel.text = serviceCatory;
        serviceCatoryStr = index;
    }];
    [self.navigationController pushViewController:serviceCatoryView animated:YES];
}

- (void)toSelectScope:(id)sender
{
    [MobClick event:@"click_change_shopvillage"];
    [self doResign];
    HWCommunityViewController * selectCommunityView = [[HWCommunityViewController alloc]init];
    [selectCommunityView setSlectedCommunity:^(NSString * communityStrS,NSMutableArray *arry) {
    _serviceScopeDescriptTV.text = communityStrS;
    serviceArry  = arry;
    [self serviceScopeChange];
    }];
    if (!serviceArry) {
        serviceArry = [[NSMutableArray alloc]init];
    }
    if ([serviceArry count]!=0) {
        selectCommunityView.frontArry = serviceArry;
    }
    [self.navigationController pushViewController:selectCommunityView animated:YES];
}

- (void)toSelectOpenTime:(id)sender
{
    [MobClick event:@"click_change_shopopentime"];
    [self doResign];
    HWOpenTimeViewController *openTimeVC = [[HWOpenTimeViewController alloc] init];
    [openTimeVC setSelectTime:^(NSString *openTime,NSString *closeTime) {
        NSMutableString *timeStr = [NSMutableString string];
        [timeStr appendString:openTime];
        [timeStr appendString:@"-"];
        [timeStr appendString:closeTime];
        serviceTimeLabel.text = timeStr;
        openTimeStr = openTime;
        closeTimeStr = closeTime;
    }];
    [self.navigationController pushViewController:openTimeVC animated:YES];
}

- (void)endEdit
{
    [_shopNameTF resignFirstResponder];
    [_shopAddressTF resignFirstResponder];
    [_mobileTF resignFirstResponder];
    [_servicePhoneTF resignFirstResponder];
    [_descriptTV resignFirstResponder];
    [_serviceScopeDescriptTV resignFirstResponder];
}
#pragma mark -
#pragma mark zoom image

- (void)createShopPhoto
{
    [photoScroll removeFromSuperview];
    photoScroll = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, 150)];
    [photoScroll setBackgroundColor:[UIColor clearColor]];
    [_section5 addSubview:photoScroll];
    
    
    for (int i = 0; i < arrPhotoName.count; i ++)
    {
        HWUploadButton *uploadBtn = [[HWUploadButton alloc] initWithFrame:CGRectMake(15 + 100 * i, 30, 90, 100)];
        [uploadBtn setStatus:[[arrPhotoStatus objectAtIndex:i] intValue]];
        uploadBtn.index = i + 100;
        uploadBtn.delegate = self;
        uploadBtn.tag = i + 100;
        uploadBtn.userInteractionEnabled = YES;
        uploadBtn.name.text = arrPhotoName[i];
        uploadBtn.imagePhoto.image = arrPhotoImg[i];
        [photoScroll addSubview:uploadBtn];
    }
    CGFloat width = fmaxf(kScreenWidth, arrPhotoName.count * 100 + 15);
    [photoScroll setContentSize:CGSizeMake(width, 150)];
}

- (void)tapBigIndex:(NSInteger)index Status:(HWUploadStatus)btnStatus
{
    currentIndex = index;
    if (btnStatus == HWUploadNormal)
    {
        //点击去选择照片
        [self showPicker];
    }
    else if (btnStatus == HWUploading)
    {
        //无
    }
    else if (btnStatus == HWUploadSuccess)
    {
        //点击可放大
        NSMutableArray *photos = [[NSMutableArray alloc] init];
        NSMutableArray *arrPhoto = [[NSMutableArray alloc] init];
        NSInteger col = 0;
        for (int i = 0; i < photoArr.count; i ++)
        {
            NSString *str = [photoArr objectAtIndex:i];
            if (![str isEqualToString:@"0"]) {
                [arrPhoto addObject:str];
            }
            else
            {
                col++;
            }
        }
        for (int i = 0; i < arrPhoto.count; i ++)
        {
            MJPhoto *photo = [[MJPhoto alloc] init];
            NSString *strUrl = [NSString stringWithFormat:@"%@/hw-sq-app-web/file/downloadByKey.do?mKey=%@&key=%@",kUrlBase,arrPhoto[i],[HWUserLogin currentUserLogin].key];
            photo.url = [NSURL URLWithString:strUrl];
            HWUploadButton *button = (HWUploadButton *)[photoScroll viewWithTag:index];
            UIImageView *imgView = button.imagePhoto;
            photo.srcImageView = imgView;
            [photos addObject:photo];
        }
        
        MJPhotoBrowser *browser = [[MJPhotoBrowser alloc] init];
       
        
        if (index > 102)
        {
            browser.currentPhotoIndex = index - 100 - col;
        }
        else
        {
            browser.currentPhotoIndex = index - 100;
        }
        
        browser.photos = photos;
        [browser show];
    }
    else if (btnStatus == HWUploadFaile)
    {
        //点击可重新上传
        HWUploadButton *button;
        for (UIView *view in photoScroll.subviews)
        {
            if (view.tag == currentIndex)
            {
                button = (HWUploadButton *)view;
                [button setStatus:HWUploading];
                [self uploadOnePhotoButton:button];
            }
        }
        
        
        
    }
}

- (void)tapSmallIndex:(NSInteger)index Status:(HWUploadStatus)btnStatus
{
    currentIndex = index;
    if (btnStatus == HWUploadNormal)
    {
        //此状态无叉
    }
    else if (btnStatus == HWUploading)
    {
        //点击取消上传
        HWUploadButton *button;
        for (UIView *view in photoScroll.subviews)
        {
            if (view.tag == currentIndex)
            {
                button = (HWUploadButton *)view;
                [button setStatus:HWUploadNormal];
                [[self class] cancelPreviousPerformRequestsWithTarget:self selector:@selector(uploadOnePhotoButton:) object:button];
                button.imagePhoto.image = [UIImage imageNamed:@"openshop_addphoto"];
                
                if (currentIndex >= 103)
                {
                    [arrPhotoName removeObjectAtIndex:currentIndex - 100];
                    [arrPhotoImg removeObjectAtIndex:currentIndex - 100];
                    [arrPhotoStatus removeObjectAtIndex:currentIndex - 100];
                    [photoArr removeObjectAtIndex:currentIndex - 100];
                    [self createShopPhoto];
                    
                }
                else
                {
                    HWUploadButton *button;
                    for (UIView *view in photoScroll.subviews)
                    {
                        if (view.tag == currentIndex)
                        {
                            button = (HWUploadButton *)view;
                            [button setStatus:HWUploadNormal];
                            button.imagePhoto.image = nil;
                            UIImage *image = [UIImage imageNamed:@"openshop_addphoto"];
                            [arrPhotoImg replaceObjectAtIndex:currentIndex - 100 withObject:image];
                            [arrPhotoStatus replaceObjectAtIndex:currentIndex - 100 withObject:@"0"];
                            [photoArr replaceObjectAtIndex:currentIndex - 100 withObject:@"0"];
                        }
                    }
                }
                
            }
        }
    }
    else if (btnStatus == HWUploadSuccess || btnStatus == HWUploadFaile)
    {
        //点击删掉
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"提示" message:@"你确定要删除吗？" delegate:self cancelButtonTitle:@"取消" otherButtonTitles:@"删除", nil];
        alert.tag = 1000;
        [alert show];
    }
}

-(void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    if (alertView.tag == 1000)
    {
        if (buttonIndex == 1)
        {
            if (currentIndex >= 103)
            {
                [arrPhotoName removeObjectAtIndex:currentIndex - 100];
                [arrPhotoImg removeObjectAtIndex:currentIndex - 100];
                [arrPhotoStatus removeObjectAtIndex:currentIndex - 100];
                [photoArr removeObjectAtIndex:currentIndex - 100];
                [self createShopPhoto];
                
            }
            else
            {
                HWUploadButton *button;
                for (UIView *view in photoScroll.subviews)
                {
                    if (view.tag == currentIndex)
                    {
                        button = (HWUploadButton *)view;
                        [button setStatus:HWUploadNormal];
                        button.imagePhoto.image = nil;
                        UIImage *image = [UIImage imageNamed:@"openshop_addphoto"];
                        [arrPhotoImg replaceObjectAtIndex:currentIndex - 100 withObject:image];
                        [arrPhotoStatus replaceObjectAtIndex:currentIndex - 100 withObject:@"0"];
                        [photoArr replaceObjectAtIndex:currentIndex - 100 withObject:@"0"];
                    }
                }
            }
        }
    }
}

#pragma mark - UIImagePickerController delegate
- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info
{
    
    UIImage *image = [info objectForKey:UIImagePickerControllerEditedImage];
    [picker dismissViewControllerAnimated:YES completion:nil];
    NSLog(@"index = %i",currentIndex);
    if (currentIndex >= 103)
    {
        //多生成一个按钮
        [arrPhotoName insertObject:@"" atIndex:currentIndex - 100];
        [arrPhotoImg insertObject:image atIndex:currentIndex - 100];
        [arrPhotoStatus insertObject:@"0" atIndex:currentIndex - 100];
        [self createShopPhoto];
        
    }
    else
    {
        [arrPhotoImg replaceObjectAtIndex:currentIndex - 100 withObject:image];
    }
    
    HWUploadButton *button;
    for (UIView *view in photoScroll.subviews)
    {
        NSLog(@"view = %@",view);
        if (view.tag == currentIndex)
        {
            button = (HWUploadButton *)view;
            [button setStatus:HWUploading];
            [arrPhotoStatus replaceObjectAtIndex:currentIndex - 100 withObject:@"1"];
        }
    }
    
    button.imagePhoto.image = image;
    [self uploadOnePhotoButton:button];
    
}

- (void)uploadOnePhotoButton:(HWUploadButton *)btnPhoto
{
    [MobClick event:@"click_upload_servepicture"];
    HWHTTPRequestOperationManager *manage = [HWHTTPRequestOperationManager manager];
    NSMutableDictionary *dict = [[NSMutableDictionary alloc] init];
    NSData *imgData = UIImageJPEGRepresentation(btnPhoto.imagePhoto.image, 0);
    [dict setPObject:imgData forKey:@"pic1"];
    [dict setPObject:@"2" forKey:@"type"];
    [dict setPObject:[HWUserLogin currentUserLogin].key forKey:@"key"];
    
    [manage POSTPhotoImage:kAddPhotoAsyn parameters:dict queue:nil success:^(id responseObject) {
        NSLog(@"%@",responseObject);
        NSDictionary *dic = [responseObject dictionaryObjectForKey:@"data"];
//        [photoArr addObject:[dic stringObjectForKey:@"imgMongodbKey"]];
        if (btnPhoto.tag >= 103)
        {
            if (btnPhoto.tag - 100 >= photoArr.count)
            {
                [photoArr addObject:[dic stringObjectForKey:@"imgMongodbKey"]];
            }
            else
            {
                [photoArr replaceObjectAtIndex:btnPhoto.tag - 100 withObject:[dic stringObjectForKey:@"imgMongodbKey"]];
            }
        }
        else
        {
            //前三张为替换
            [photoArr replaceObjectAtIndex:btnPhoto.tag - 100 withObject:[dic stringObjectForKey:@"imgMongodbKey"]];
        }
        
        
        
        [photoId addObject:[dic stringObjectForKey:@"shopPhotoId"]];
        NSLog(@"%@",photoId);
        [arrPhotoStatus replaceObjectAtIndex:currentIndex - 100 withObject:@"2"];
        [btnPhoto setStatus:HWUploadSuccess];
        
    } failure:^(NSString *error) {
        NSLog(@"%@",error);
        [arrPhotoStatus replaceObjectAtIndex:currentIndex - 100 withObject:@"3"];
        [btnPhoto setStatus:HWUploadFaile];
    }];
}


- (void)deleteOnePhoto:(NSString *)shopIdStrTemp
{
    [Utility showMBProgress:self.view message:@"删除图片"];
    HWHTTPRequestOperationManager *manager = [HWHTTPRequestOperationManager manager];
    NSMutableDictionary *dict = [NSMutableDictionary dictionary];
    [dict setObject:[HWUserLogin currentUserLogin].key forKey:@"key"];
    [dict setObject:shopIdStrTemp forKey:@"photoIds"];
    [manager POST:kDeleteOnePhoto parameters:dict queue:nil success:^(id responseObject){
        [Utility hideMBProgress:self.view];
        
        NSLog(@"sucess");
    }failure:^(NSString *code, NSString *error) {
        [Utility hideMBProgress:self.view];
        [Utility showToastWithMessage:error inView:self.view];
        NSLog(@"error %@",error);
    }];
}


#pragma mark -
#pragma mark - scrollview delegate
- (void) scrollViewDidEndDecelerating:(UIScrollView *)scrollView
{
//    NSLog(@"停止时 y = %f",scrollView.contentOffset.y);
    if (scrollView.contentOffset.y == 0) {
        return;
    }
    if (btn.alpha == 0) {
        [UIView animateWithDuration:1.0f animations:^{
            btn.alpha = 1;
        }];
    }
    
}

-(void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    [UIView animateWithDuration:1.0f animations:^{
        btn.alpha = 0;
    }];
}

//拼接服务范围
-(NSArray *)pinJieServiceScope:(NSMutableArray *)arry
{
    NSMutableArray *serviceArryTemp = [NSMutableArray array];
    for (int i = 0; i < [arry count]; i++) {
        HWAreaClass *community = [arry objectAtIndex:i];
        NSString *villiageIdStr = community.villageIdStr;
        NSString *distanceStr = community.distanceStr;
        NSDictionary *dic = [[NSDictionary alloc]initWithObjectsAndKeys:villiageIdStr,@"villageId",distanceStr,@"distance", nil];
        [serviceArryTemp addObject:dic];
        
    }
    return serviceArryTemp;
    
}

- (void)showPicker
{
    [self doResign];
    UIActionSheet *sheet = [[UIActionSheet alloc] initWithTitle:nil delegate:self cancelButtonTitle:@"取消" destructiveButtonTitle:nil otherButtonTitles:@"拍照",@"从相册中选择", nil];
    sheet.actionSheetStyle = UIActionSheetStyleBlackTranslucent;
    [sheet showInView:self.view];
}

#pragma mark - 
#pragma mark - 提交店铺请求
- (void)submitShopInfo
{
    [MobClick event:@"click_upload_servepicture"];
    /*
     入参:
     name:店铺名称,address:店铺地址,type:店铺类型,mobile:手机,phone:座机,serviceDesc:服务描述,
     longitude:经度,latitude:纬度,provinceId:省id,cityId:城市id,districtId:区id,营业时间开始:opentime,营业结束时间:endtime,shangmen:上门,0,1subdistrictId:街道id,pics:图片附件,
     serviceVillage:服务小区信息 [{villageId:1,distance:100},{villageId:3,distance:200}]
     */
    
    
    if ([_shopNameTF.text length] == 0)
    {
        [Utility showToastWithMessage:@"请输入店铺名称" inView:self.view];
        return;
    }
    
    if (serviceCatoryStr.length == 0)
    {
        [Utility showToastWithMessage:@"请输入服务类别" inView:self.view];
        return;
    }
    
    if (_shopAddressTF.text.length == 0)
    {
        [Utility showToastWithMessage:@"请输入店铺地址" inView:self.view];
        return;
    }
    
    if ([_mobileTF.text length] == 0 && [_servicePhoneTF.text length] == 0)
    {
        [Utility showToastWithMessage:@"手机号码或服务号码不能全部为空" inView:self.view];
        return;
    }
    
    if (_mobileTF.text.length > 0)
    {
        if (![Utility validateMobile:_mobileTF.text]) {
            [Utility showToastWithMessage:@"请输入正确的手机号码" inView:self.view];
            return;
        }
    }
    
    if (_servicePhoneTF.text.length > 0)
    {
        if (![Utility validatePhoneTel:_servicePhoneTF.text])
        {
            [Utility showToastWithMessage:@"请输入正确的座机号" inView:self.view];
            return;
        }
    }
    
    if (serviceArry.count == 0)
    {
        [Utility showToastWithMessage:@"请输入服务范围" inView:self.view];
        return;
    }
    
    if (openTimeStr.length == 0 && closeTimeStr.length == 0)
    {
        [Utility showToastWithMessage:@"请输入营业时间" inView:self.view];
        return;
    }
    
//    NSMutableArray *picArr = [self crapPicData];
    
//    if (picArr.count == 0)
//    {
//        [Utility showToastWithMessage:@"请上传店铺相册" inView:self.view];
//        return;
//    }
    if (photoId.count == 0)
    {
        [Utility showToastWithMessage:@"请上传店铺相册" inView:self.view];
        return;
    }
    
    
    HWHTTPRequestOperationManager *manager = [HWHTTPRequestOperationManager manager];
    NSMutableDictionary *dict = [NSMutableDictionary dictionary];
//    [dict setPObject:[HWUserLogin currentUserLogin].key forKey:@"key"];
    [dict setPObject:_shopNameTF.text forKey:@"name"];
    [dict setPObject:_shopAddressTF.text forKey:@"address"];
    [dict setPObject:serviceCatoryStr forKey:@"type"];
    [dict setPObject:_mobileTF.text forKey:@"mobile"];
    [dict setPObject:_servicePhoneTF.text forKey:@"phone"];
    [dict setPObject:_descriptTV.text forKey:@"serviceDesc"];
    [dict setPObject:longtitudeStr forKey:@"longitude"];
    [dict setPObject:latitudeStr forKey:@"latitude"];
    //[dict setPObject:[HWUserLogin currentUserLogin] forKey:@"provinceId"];
    [dict setPObject:[HWUserLogin currentUserLogin].cityId forKey:@"cityId"];
    //[dict setPObject:[HWUserLogin currentUserLogin].dis forKey:@"districtId"];
    //[dict setPObject:@"是电风扇的" forKey:@"subdistrictId"];
    
    [dict setPObject:openTimeStr forKey:@"opentime"];
    [dict setPObject:closeTimeStr forKey:@"endtime"];
    if (waiMaiFlag == YES) {
        [dict setPObject:@"1" forKey:@"shangmen"];
    }
    else
    {
        [dict setPObject:@"0" forKey:@"shangmen"];
    }

//    [dict setPObject:[self crapPicData] forKey:@"pics"];
    NSString *strPhoto = @"";
    for (int i = 0; i < photoId.count; i ++)
    {
        NSString *str = [NSString stringWithFormat:@"%@,",photoId[i]];
        strPhoto = [strPhoto stringByAppendingString:str];
    }
    
    NSString *photos = [[strPhoto substringFromIndex:0] substringToIndex:strPhoto.length - 1];
    [dict setPObject:photos forKey:@"pics"];
    [dict setPObject:[NSString jsonStringWithArray:[self pinJieServiceScope:serviceArry]] forKey:@"serviceVillage"];
    
    [Utility showMBProgress:self.view.window message:@"提交店铺信息"];
    [manager POSTManagerPhotoImage:kSubmitShopInfo parameters:dict queue:nil success:^(id responseObject) {
        NSLog(@"responseObject = %@",responseObject);
        [Utility hideMBProgress:self.view.window];
        AppDelegate *appDel = (AppDelegate *)SHARED_APP_DELEGATE;
        [Utility showToastWithMessage:@"你的开店申请已经提交，审核通过后店铺信息将在服务汇展示" inView:appDel.window];
        NSDictionary *dataTemp = (NSDictionary *)responseObject;
        NSDictionary *dataDic = [dataTemp dictionaryObjectForKey:@"data"];
        [HWUserLogin currentUserLogin].shopId = [dataDic stringObjectForKey:@"shopId"];
        [HWCoreDataManager saveUserInfo];
        if (_refershShopStatus) {
            _refershShopStatus();
        }
        [self.navigationController popViewControllerAnimated:YES];
         NSLog(@"sucess");
        
    } failure:^(NSString *error) {
        
        [Utility hideMBProgress:self.view.window];
        [Utility showToastWithMessage:error inView:self.view];
        
        NSLog(@"error %@",error);
    }];
    
}
//封装发送多图的请求数据
-(NSMutableArray *)crapPicData
{
    NSMutableArray *picArryS = [[NSMutableArray alloc]init];
    for (int i = 0; i < [imageScrollView.imageArray count]-2; i++) {
        UIImage *avatarImage = [imageScrollView.imageArray objectAtIndex:i];
        NSData *avatarImageData = UIImageJPEGRepresentation(avatarImage, 1.0);
        [picArryS addObject:avatarImageData];
    }
    return picArryS;
}
////拼接服务范围
//-(NSArray *)pinJieServiceScope:(NSMutableArray *)arry
//{
//    NSMutableArray *serviceArryTemp = [NSMutableArray array];
//    for (int i = 0; i < [arry count]; i++) {
//        HWAreaClass *community = [arry objectAtIndex:i];
//        NSString *villiageIdStr = community.villageIdStr;
//        NSString *distanceStr = community.distanceStr;
//        NSDictionary *dic = [[NSDictionary alloc]initWithObjectsAndKeys:villiageIdStr,@"villageId",distanceStr,@"distance",nil];
//        [serviceArryTemp addObject:dic];
//        
//    }
//    return serviceArryTemp;
//    
//}

//上传多图的请求
//-(void)addManyPic:(NSString *)shopIdStr
//{
//    HWHTTPRequestOperationManager *manager = [HWHTTPRequestOperationManager manager];
//    NSMutableDictionary *dict = [NSMutableDictionary dictionary];
//    [dict setPObject:[HWUserLogin currentUserLogin].key forKey:@"key"];
//    NSData *avatarImageData = UIImageJPEGRepresentation(currentImageView.image, 1.0);
//    NSMutableArray *avatarImageDataArry = [[NSMutableArray alloc]init];
//    [avatarImageDataArry addObject:avatarImageData];
//    [avatarImageDataArry addObject:avatarImageData];
//    [avatarImageDataArry addObject:avatarImageData];
//    [dict setPObject:avatarImageDataArry forKey:@"pics"];
//    [dict setPObject:@"886899" forKey:@"shopId"];
//    [dict setPObject:@"2" forKey:@"type"];
//    [manager POSTManagerPhotoImage:kAddPhotos parameters:dict queue:nil success:^(id responseObject) {
//        NSLog(@"sucess");
//    } failure:^(NSString *error) {
//        [self.navigationController popViewControllerAnimated:YES];
//        NSLog(@"error");
//    }];
//}

#pragma mark -
#pragma mark Notification Method

- (void)addKeyboardAbserver
{
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardWasShown:) name:UIKeyboardWillShowNotification object:nil];
    
    [[NSNotificationCenter defaultCenter]  addObserver:self selector:@selector(keyboardWasHidden:) name:UIKeyboardWillHideNotification object:nil];
    
    [[NSNotificationCenter defaultCenter]  addObserver:self selector:@selector(keyboardWillChangeFrame:) name:UIKeyboardWillChangeFrameNotification object:nil];
}
- (void)removeKeyboardAbserver
{
    [[NSNotificationCenter defaultCenter] removeObserver:self name:UIKeyboardWillShowNotification object:nil];
    [[NSNotificationCenter defaultCenter] removeObserver:self name:UIKeyboardWillHideNotification object:nil];
    [[NSNotificationCenter defaultCenter] removeObserver:self name:UIKeyboardWillChangeFrameNotification object:nil];
}

- (void)keyboardWasShown:(NSNotification *)notification
{
    NSDictionary *info = [notification userInfo];
    NSValue *value = [info objectForKey:UIKeyboardFrameEndUserInfoKey];
    CGSize keyboardSize = [value CGRectValue].size;
    
    [self resetScrollViewFrameByKeyboardHeight:keyboardSize.height];
    
}

- (void)keyboardWasHidden:(NSNotification *)notification
{
//    NSDictionary *info = [notification userInfo];
//    NSValue *value = [info objectForKey:UIKeyboardFrameEndUserInfoKey];
//    CGSize keyboardSize = [value CGRectValue].size;
    
    [self resetScrollViewFrameByKeyboardHeight:0];
    
//    _mainSV.frame = CGRectMake(0, 0, kScreenWidth, CONTENT_HEIGHT);
//    _backToolBar.frame = CGRectMake(0, CONTENT_HEIGHT , kScreenWidth, 40);
//    
//    
//    [UIView animateWithDuration:[notification.userInfo[UIKeyboardAnimationDurationUserInfoKey]floatValue] animations:^{
//        _mainSV.frame = CGRectMake(0, 0, kScreenWidth, CONTENT_HEIGHT);
//        
//    }];
    
}
//创建headview
-(UIView *)createHeaderView
{
    UIView *headerView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, 320, 10)];
    headerView.backgroundColor = UIColorFromRGB(0xececec);
    return headerView;
}
- (void)keyboardWillChangeFrame:(NSNotification *)notification
{
    NSDictionary *info = [notification userInfo];
    NSValue *value = [info objectForKey:UIKeyboardFrameEndUserInfoKey];
    CGSize keyboardSize = [value CGRectValue].size;
    
    [self resetScrollViewFrameByKeyboardHeight:keyboardSize.height];
}

#pragma mark -
#pragma mark TextField Delegate

- (void)textFieldDidBeginEditing:(UITextField *)textField
{
    if (textField == _shopNameTF) {
//        [MobClick event:@"_shopNameTF"];
        [MobClick event:@"click_change_shopname"];
    }
    else if(textField == _shopAddressTF)
    {
        [MobClick event:@"click_change_shopaddress"];
    }
    else if(textField == _mobileTF)
    {
        [MobClick event:@"click_change_shopmobilephone"];
    }
    else if(textField == _servicePhoneTF)
    {
        [MobClick event:@"click_change_shopphone"];
    }
    
}
-(BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string
{
    if (textField == _mobileTF) {
        if ([_mobileTF.text length] >= 11 && range.length == 0)
        {
            return NO;
        }
    }
    
    if (textField == _shopAddressTF) {
        if ([_shopAddressTF.text length] > 50 && range.length == 0)
        {
            return NO;
        }
    }
    
    if (textField == _servicePhoneTF) {
        if ([_servicePhoneTF.text length] >= 13 && range.length == 0) {
            return NO;
        }
    }
    return YES;
}
- (void)textFieldDidEndEditing:(UITextField *)textField
{
    if (textField == _mobileTF)
    {
        UILabel *label = (UILabel *)[_section2 viewWithTag:PHONE_TAG];
        if (textField.text == nil || [textField.text isEqualToString:@""])
        {
            _servicePhoneTF.placeholder = @"必填";
            label.text = @"座机 *";
        }
        else
        {
            _servicePhoneTF.placeholder = @"";
            label.text = @"座机";
        }
    }
    else if (textField == _servicePhoneTF)
    {
        UILabel *label = (UILabel *)[_section2 viewWithTag:MOBILENUMBER_TAG];
        if (textField.text == nil || [textField.text isEqualToString:@""])
        {
            _mobileTF.placeholder = @"必填";
            label.text = @"手机 *";
        }
        else
        {
            _mobileTF.placeholder = @"";
            label.text = @"手机";
        }
    }
}
#pragma mark -
#pragma mark 服务范围内容动态改变改变整体的尺寸
-(void)serviceScopeChange
{
    CGRect frame = _serviceScopeDescriptTV.frame;
    frame.size.height = _serviceScopeDescriptTV.contentSize.height;
    _serviceScopeDescriptTV.frame = frame;
    
    CGRect sFrame = _section3.frame;
    sFrame.size.height = CGRectGetMaxY(_serviceScopeDescriptTV.frame) + 6;
    _section3.frame = sFrame;
    [self refreshSectionViewFrame];
    CGRect frameTemp = _mainSV.frame;
    frameTemp.size.height = CONTENT_HEIGHT;
    _mainSV.frame = frameTemp;
}
#pragma mark -
#pragma mark TextView Delegate
- (void)textViewDidBeginEditing:(UITextView *)textView
{
    if (textView == _descriptTV)
    {
        [MobClick event:@"click_change_servedescription"];
       // [_mainSV scrollRectToVisible:CGRectMake(0, 0, kScreenWidth, self.view.frame.size.height+50) animated:YES];
//        [MobClick event:@"click_change_servedescription"];
        CGContextRef context = UIGraphicsGetCurrentContext(); //返回当前视图堆栈顶部的图形上下文
        [UIView beginAnimations:nil context:context];
        [UIView setAnimationCurve:UIViewAnimationCurveEaseOut];
        [_mainSV setContentOffset:CGPointMake(0, 200)];
        [UIView setAnimationDuration:1.0];
        //设置属性的变换，可以对frame的位置进行变换来实现移动的效果
        [UIView commitAnimations];      //执行动画
    }
    
}

-(BOOL)textView:(UITextView *)textView shouldChangeTextInRange:(NSRange)range replacementText:(NSString *)text
{
    if (textView == _descriptTV)
    {
        NSString *temp = [textView.text stringByReplacingCharactersInRange:range withString:text];
        if (temp.length > 200)
        {
            return NO;
        }
        else
        {
            return YES;
        }
    }
    return YES;
}
- (void)textViewDidChange:(UITextView *)textView
{
    NSLog(@"%@",[NSValue valueWithCGSize:textView.contentSize]);
    
    if (textView == _descriptTV)
    {
        CGRect frame = textView.frame;
        frame.size.height = textView.contentSize.height - 11;
        textView.frame = frame;
        
        CGRect sFrame = _section4.frame;
        sFrame.size.height = CGRectGetMaxY(textView.frame) + 6;
        _section4.frame = sFrame;
        [self refreshSectionViewFrame];
    }

}
-(void)textViewDidEndEditing:(UITextView *)textView
{
    if (textView == _descriptTV) {
        CGContextRef context = UIGraphicsGetCurrentContext(); //返回当前视图堆栈顶部的图形上下文
        [UIView beginAnimations:nil context:context];
        [UIView setAnimationCurve:UIViewAnimationCurveEaseOut];
        [UIView setAnimationDuration:1.0];
        [_mainSV setContentOffset:CGPointMake(0, 0)];
        //设置属性的变换，可以对frame的位置进行变换来实现移动的效果
        [UIView commitAnimations];      //执行动画
    }
}

#pragma mark -
#pragma mark ActionSheet Delegate

- (void)actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex
{
//    if(buttonIndex ==2)
//        return;
    if (buttonIndex == 0)
    {
        UIImagePickerController *ipc = [[UIImagePickerController alloc] init];
        ipc.delegate = self;
        ipc.sourceType =  UIImagePickerControllerSourceTypeCamera;
        ipc.allowsEditing = YES;
        ipc.modalPresentationStyle = UIModalPresentationCurrentContext;
        [self presentViewController:ipc animated:YES completion:nil];
    }
    else if (buttonIndex == 1)
    {
        UIImagePickerController *ipc = [[UIImagePickerController alloc] init];
        ipc.delegate = self;
        ipc.sourceType =  UIImagePickerControllerSourceTypePhotoLibrary;
        ipc.allowsEditing = YES;
        ipc.modalPresentationStyle = UIModalPresentationCurrentContext;
        [self presentViewController:ipc animated:YES completion:nil];
    }
}

#pragma mark -
#pragma mark System method

- (void)viewDidDisappear:(BOOL)animated
{
    [self endEdit];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)dealloc
{
    [self removeKeyboardAbserver];
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
