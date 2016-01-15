//
//  HWShopManageViewController.m
//  Community
//
//  Created by gusheng on 14-9-16.
//  Copyright (c) 2014年 caijingpeng. All rights reserved.
//

#import "HWShopManageViewController.h"
#import "HWImageScrollView.h"
#import "MapLocationViewController.h"
#import "HWOpenTimeViewController.h"
#import "HWCommunityViewController.h"
#import "ApplyVertifyViewController.h"
#import "HWStoreDetailClass.h"
#import "HWImageScrollView.h"
#import "AppDelegate.h"
#import "HWStoreDetailClass.h"
#import "HWStoreNewsClass.h"
#import "NSString+HXAddtions.h"
#import "HWAreaClass.h"
#import "HWPhoto.h"
#import "HWServiceCatoryViewController.h"
#import "MJPhoto.h"
#import "MJPhotoBrowser.h"

@interface HWShopManageViewController ()
{
    UIView *foot;
    
    UIView *panelView;
    UIView *markView;
    UIScrollView *myScrollView;
    
    NSArray *arrImg;
    NSInteger currentIndex;
//    UIButton *btn;
    UIButton *_takeAwayBtn;
    HWInputBackView *takeAwayView;
    BOOL waiMaiFlag;
    
    NSMutableArray *photoKeyArr;        //放大大图的key
    
}
@end

@implementation HWShopManageViewController

@synthesize shopId,ipc,shopIdStr,renlinFlag,ipcShop;
- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
        waiMaiFlag = YES;
        picModifyFlag = NO;
    }
    return self;
}

- (void)back:(id)sender
{
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    if (renlinFlag == YES) {
         self.navigationItem.titleView = [Utility navTitleView:@"认领店铺"];
    }
    else
    {
         self.navigationItem.titleView = [Utility navTitleView:@"店铺管理"];
    }
    self.navigationItem.leftBarButtonItem = [Utility navLeftBackBtn:self action:@selector(back:)];
    if (renlinFlag == YES)
    {
        [MobClick event:@"click_claim_shop"];
         self.navigationItem.rightBarButtonItem = [Utility navButton:self title:@"保存" action:@selector(sumitRenlinInfo)];
    }
    else
    {
         self.navigationItem.rightBarButtonItem = [Utility navButton:self title:@"保存" action:@selector(submitEditInfo)];
    }
   
    self.view.backgroundColor =  UIColorFromRGB(0xf2f2f2);
    //创建UIimageView
    fangDaFlag = YES;
    photoKeyArr = [[NSMutableArray alloc] init];
    
    clickLookBigImageView = [[UIImageView alloc]initWithFrame:self.view.frame];
    clickLookBigImageView.backgroundColor = [UIColor clearColor];
    clickLookBigImageView.alpha = 0.0;
    clickLookBigImageView.userInteractionEnabled = YES;
    [self.view addSubview:clickLookBigImageView];
    [self queryListData:shopIdStr];
     serviceCatoryImageArry = @[@"sshop",@"srestruant",@"sfruit",@"slaundry",@"shomemaking",@"sunlock",@"shipping",@"shardware",@"sexpress",@"scarwash",@"smove",@"swater",@"sbeauty",@"swaste",@"spipeline",@"sservice",@"sother"];
    frontSelectedCommunityArry = [[NSMutableArray alloc]init];
    arrShopInfo = [[NSMutableArray alloc] initWithCapacity:array.count];
    currentImageView = [[UIImageView alloc]init];
    for (int i = 0; i < [array count]; i ++)
    {
        HWShopNews *shop = [[HWShopNews alloc] initWithAttributes:array[i]];
        
        [arrShopInfo addObject:shop];
    }
    
//    btn = [UIButton buttonWithType:UIButtonTypeCustom];
//    btn.alpha = 0;
//    [btn setFrame:CGRectMake(kScreenWidth - 60, self.view.frame.size.height - 130, 44, 44)];
//    [btn setBackgroundImage:[UIImage imageNamed:@"top"] forState:UIControlStateNormal];
//    [btn addTarget:self action:@selector(btnClick:) forControlEvents:UIControlEventTouchUpInside];
//    [self.view addSubview:btn];
    //编辑按钮显示
    photoGetArry = [NSMutableArray array];
    addPhotoArry = [NSMutableArray array];
    
    longTitudeStr = @"0.000";
    latitudeStr = @"0.000";
    
}
//获取类别的图片
-(void)getCatoryPic:(NSString*)catoryUrl
{
    NSURL *avatarUrl = [NSURL URLWithString:[NSString stringWithFormat:@"%@/hw-sq-app-web/%@&key=%@",kUrlBase,catoryUrl,[HWUserLogin currentUserLogin].key]];
    
    __weak UIImageView *blockImgV = shopTypeImg;
    
    [shopTypeImg setImageWithURL:avatarUrl placeholderImage:[UIImage imageNamed:@"shopDefault"] completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType) {
        if (error)
        {
            NSLog(@"Error : load image fail.");
            blockImgV.image = [UIImage imageNamed:@"shopDefault"];
        }
        else
        {
            blockImgV.image = image;
            if (cacheType == 0)
            { // request url
                CATransition *transition = [CATransition animation];
                transition.duration = 1.0f;
                transition.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut];
                transition.type = kCATransitionFade;
                [blockImgV.layer addAnimation:transition forKey:nil];
            }
        }
    }];

}
//获取商铺信息
-(void)queryListData:(NSString *)shopIdStrTemp
{
    //HWUserLogin *user = [HWUserLogin currentUserLogin];
    [Utility showMBProgress:self.view message:@"请求店铺信息"];
    HWHTTPRequestOperationManager *manage = [HWHTTPRequestOperationManager manager];
    NSMutableDictionary *dict = [[NSMutableDictionary alloc] init];
    [dict setPObject:[HWUserLogin currentUserLogin].key forKey:@"key"];
    if (shopIdStrTemp.length > 0) {
        [dict setPObject:shopIdStrTemp forKey:@"shopId"];
    }
    [dict setPObject:[NSString stringWithFormat:@"%d",kPageCount] forKey:@"size"];
    [dict setPObject:[NSString stringWithFormat:@"%d",0] forKey:@"page"];//0全部动态
    [manage POST:kShopDetail parameters:dict queue:nil success:^(id responseObject) {
        NSLog(@"%@",responseObject);
        [Utility hideMBProgress:self.view];
        NSDictionary *dic = (NSDictionary *)responseObject;
        detail = [[HWStoreDetailClass alloc] initWithDictionary:[dic dictionaryObjectForKey:@"data"]];
        longTitudeStr = detail.longitude;
        latitudeStr = detail.latitude;
        if (!serviceArry) {
            serviceArry = [NSMutableArray array];
        }
        for (int i = 0; i < detail.arrServiceRange.count; i++) {
            HWAreaClass *areaClass = [[HWAreaClass alloc]initWithDic:[[[dic dictionaryObjectForKey:@"data"] arrayObjectForKey:@"serviceRange"] objectAtIndex:i]];
            areaClass.flag = YES;
            [serviceArry addObject:areaClass];
        }
//        [self.dataList addObjectsFromArray:detail.arrServiceTrack];
//        NSLog(@"数据源长度 = %d",self.dataList.count);
        [self initTableHeadView];
        [self initTableHeadView:detail];
        NSArray *photoUrls = [NSArray arrayWithArray:detail.picUrls];
        photoKeyArr = [[NSMutableArray alloc] initWithArray:detail.pikKeys];
        NSArray *photoKeys = [NSArray arrayWithArray:detail.pikKeys];
        [self getPhotosFromServer:photoUrls photoKeyS:photoKeys];
        [self getShopCatoryImage:detail.shopType];
    } failure:^(NSString *code, NSString *error) {
        [Utility hideMBProgress:self.view];
        [Utility showToastWithMessage:error inView:self.view];
        NSLog(@"%@",error);
    }];
}
//获取店铺类型
-(void)getShopCatoryImage:(NSString *)catoryId
{
    HWHTTPRequestOperationManager *manage = [HWHTTPRequestOperationManager manager];
    NSMutableDictionary *dict = [[NSMutableDictionary alloc] init];
    [dict setPObject:[HWUserLogin currentUserLogin].key forKey:@"key"];
    [dict setPObject:catoryId forKey:@"dictId"];
    [manage POST:kShopCatory parameters:dict queue:nil success:^(id responseObject) {
        NSDictionary *dic = [responseObject dictionaryObjectForKey:@"data"];
        NSString *url = [dic stringObjectForKey:@"iconMongodbUrl"];
        [self refershShopCatory:url];
        
    } failure:^(NSString *code, NSString *error) {
        NSLog(@"");
    }];
}
//封装从服务端获取的图像
-(void)getPhotosFromServer:(NSArray *)photoUrlArry photoKeyS:(NSArray *)photoKeysArry
{
    [photoGetArry removeAllObjects];
    for (int i = 0; i < [photoKeysArry count]; i++)
    {
        HWPhoto *photoObject = [[HWPhoto alloc]init];
        NSURL *photoUrlTemp = [NSURL URLWithString:[NSString stringWithFormat:@"%@/hw-sq-app-web/%@&key=%@",kUrlBase,[photoUrlArry objectAtIndex:i],[HWUserLogin currentUserLogin].key]];
        photoObject.photoUrl = photoUrlTemp;
        photoObject.photoKey = [photoKeysArry objectAtIndex:i];
        if ([detail.bannerUrl length]==0 && i==0)
        {
            [self getShopImage:[photoUrlArry objectAtIndex:i]];
        }
        photoObject.localPhotoImage = nil;
        [photoGetArry addObject:photoObject];
    }
    for(HWPhoto *photo in photoGetArry)
    {
        [imageScrollView addImage:(id)photo];
    }
    
}
//获取店铺照片
- (void)getShopImage:(NSString *)shopUrl
{
    NSURL *avatarUrl = [NSURL URLWithString:[NSString stringWithFormat:@"%@/hw-sq-app-web/%@&key=%@",kUrlBase,shopUrl,[HWUserLogin currentUserLogin].key]];
    
    __weak UIImageView *blockImgV = shopBigImg;
    [shopBigImg setImageWithURL:avatarUrl placeholderImage:[UIImage imageNamed:@"shopTopDefault"] completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType) {
        if (error)
        {
            NSLog(@"Error : load image fail.");
            blockImgV.image = [UIImage imageNamed:@"shopTopDefault"];
        }
        else
        {
            blockImgV.image = image;
            if (cacheType == 0)
            { // request url
                CATransition *transition = [CATransition animation];
                transition.duration = 1.0f;
                transition.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut];
                transition.type = kCATransitionFade;
                [blockImgV.layer addAnimation:transition forKey:nil];
            }
        }
    }];

}
//初始化店铺信息
-(void)initTableHeadView:(HWStoreDetailClass *)shopDetail
{
    if([shopDetail.bannerUrl length]!=0)
    {
         [self getShopImage:shopDetail.bannerUrl];
    }
    if ([ShopNameText.text length] == 0) {
        ShopNameText.text = @"请添加店铺名称";
    }
    else
    {
        ShopNameText.text = shopDetail.shopName;
    }
    
    if([shopDetail.authorize isEqualToString:@""])
    {
        vertifyLabel.text = @"未认证";
        [applyVertifyBtn setBackgroundImage: [UIImage imageNamed:@"button"] forState:UIControlStateNormal];
        
    }
    else if([shopDetail.authorize isEqualToString:@"0"])
    {
        vertifyLabel.text = @"认证中";
        applyVertifyBtn.backgroundColor = UIColorFromRGB(0x727272);
        applyVertifyBtn.userInteractionEnabled = NO;
    }
    else if([shopDetail.authorize isEqualToString:@"1"])
    {
        [applyVertifyBtn setBackgroundImage: [UIImage imageNamed:@"button"] forState:UIControlStateNormal];
        vertifyLabel.text = @"认证失败";
    }
    else if([shopDetail.authorize isEqualToString:@"2"])
    {
        applyVertifyBtn.backgroundColor = UIColorFromRGB(0x727272);
        applyVertifyBtn.userInteractionEnabled = NO;
        vertifyLabel.text = @"已认证";
    }
    //ServerDetailTextView.text = shopDetail.serviceDetail;
    textAddressDetail.text = shopDetail.shopAddress;
    selectCatoryIndex = shopDetail.shopType;
    labTimeDetail.text = shopDetail.shopTime;
    labServerRightTextView.text = [self pinJieServiceScope:shopDetail.arrServiceRange];
    btnCallText.text = shopDetail.shopPhone;
    phoneNumberText.text = shopDetail.mobile;
    
    if([shopDetail.connectionRate intValue]!=0)
    {
        labCall.text = [NSString stringWithFormat:@"接通率%@%%",shopDetail.connectionRate];
    }
    if ([shopDetail.outSell isEqualToString:@"1"]) {
        [_takeAwayBtn setImage:[UIImage imageNamed:@"persionCheck"]  forState:UIControlStateNormal];
        waiMaiFlag = YES;
    }
    else
    {
        [_takeAwayBtn setImage:nil forState:UIControlStateNormal];
        waiMaiFlag = NO;
    }
//    [baseTableView reloadData];
}
//更新商铺类别
-(void)refershShopCatory:(NSString *)url
{
        
    [self getCatoryPic:url];

}
//拼接服务范围
-(NSMutableString *)pinJieServiceScope:(NSMutableArray *)arry
{
    NSMutableString *communityStrS = [[NSMutableString alloc]init];
    
    for (int i = 0; i < [arry count]; i++) {
        HWServiceRangeClass *community = [arry objectAtIndex:i];
        NSString *villiageName = community.villageName;
//        HWAreaClass *scope = [[HWAreaClass alloc]init];
//        scope.villageAddressStr = community.villageId;
//        scope.villageNameStr = community.villageName;
//        scope.distanceStr = community.distance;
//        scope.flag = YES;
//        [frontSelectedCommunityArry addObject:scope];
        [communityStrS appendString:villiageName];
        if (i < [arry count] - 1) {
            [communityStrS appendString:@","];
        }
    }
    return communityStrS;
    

}
//拼接服务范围
-(NSArray *)pinJieServiceScope:(NSMutableArray *)arry :(NSString *)shopIdStrTemp
{
    NSMutableArray *serviceArryTemp = [NSMutableArray array];
    for (int i = 0; i < [arry count]; i++) {
        HWAreaClass *community = [arry objectAtIndex:i];
        NSString *villiageIdStr = community.villageIdStr;
        NSString *distanceStr = community.distanceStr;
        NSDictionary *dic = [[NSDictionary alloc]initWithObjectsAndKeys:villiageIdStr,@"villageId",distanceStr,@"distance",shopIdStrTemp,@"shopId",nil];
        [serviceArryTemp addObject:dic];
        
    }
    return serviceArryTemp;
    
}
#pragma mark - 拍照
#pragma mark - 
- (void)doEditHead
{
    if (renlinFlag)
    {
        [MobClick event:@"click_upload_banner"];
    }
    else
    {
        [MobClick event:@"click_upload_banner"];
    }
    UIActionSheet *sheet = [[UIActionSheet alloc] initWithTitle:nil delegate:self cancelButtonTitle:@"取消" destructiveButtonTitle:nil otherButtonTitles:@"拍照",@"从相册中选择", nil];
    sheet.tag = 5001;
    sheet.actionSheetStyle = UIActionSheetStyleBlackTranslucent;
    [sheet showInView:self.view];
}
#pragma mark - actionsheet
#pragma mark - actionsheet
- (void)actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex
{
    if (actionSheet.tag == 5001) {
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
    else if(actionSheet.tag == 5000)
    {
        if(buttonIndex ==2)
            return;
        self.ipcShop = [[UIImagePickerController alloc] init];
        ipcShop.delegate = self;
        if (buttonIndex == 0) {
            ipcShop.sourceType =  UIImagePickerControllerSourceTypeCamera;
        } else if (buttonIndex ==1) {
            ipcShop.sourceType =  UIImagePickerControllerSourceTypePhotoLibrary;
        }
        ipcShop.allowsEditing = YES;
        ipcShop.modalPresentationStyle = UIModalPresentationCurrentContext;
        [self presentViewController:ipcShop animated:YES completion:nil];
    }
}
#pragma mark - UIImagePickerController delegate
- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info
{
    picModifyFlag = YES;
    //nslog(@"image info:%@",info);
     UIImage *image = [info objectForKey:UIImagePickerControllerEditedImage];
    if (picker == ipc) {
        
        [HWUserLogin currentUserLogin].shopAvatar.image = image;
        shopBigImg.image = image;
        [self dismissViewControllerAnimated:YES completion:nil];

    }
    else
    {
      
        HWPhoto *newLocalPhoto = [[HWPhoto alloc]initWithUrlAndKey:nil key:nil image:image];
        [imageScrollView addImage:(id)newLocalPhoto];
        [picker dismissViewControllerAnimated:YES completion:nil];
        currentImageView.image = image;
        if (renlinFlag)
        {
            [MobClick event:@"click_claim_servepicture"];
        }
        else
        {
            [MobClick event:@"click_upload_servepicture"];
        }
//        kAddOnePhoto
        HWHTTPRequestOperationManager *manage = [HWHTTPRequestOperationManager manager];
        NSMutableDictionary *dict = [[NSMutableDictionary alloc] init];
        [dict setPObject:shopIdStr forKey:@"shopId"];
        NSData *imgData = UIImageJPEGRepresentation(image, 0);
        [dict setPObject:imgData forKey:@"pic1"];
        [dict setPObject:@"2" forKey:@"type"];
        [manage POSTPhotoImage:kAddOnePhoto parameters:dict queue:nil success:^(id responseObject) {
            NSLog(@"%@",responseObject);
            
            NSDictionary *myDic = [responseObject dictionaryObjectForKey:@"data"];
            NSString *strKey = [NSString stringWithFormat:@"%@",[myDic stringObjectForKey:@"imgMongodbKey"]];
            [photoKeyArr addObject:strKey];
            
//            [Utility showMBProgress:self.view message:@"更新数据"];
//            [self performSelector:@selector(afterDelayFun) withObject:nil afterDelay:3];
            
        } failure:^(NSString *error) {
            NSLog(@"%@",error);
        }];
    }
}

//- (void)afterDelayFun
//{
//    [Utility hideMBProgress:self.view];
//    [self queryListData:shopIdStr];
//}

- (void)imagePickerControllerDidCancel:(UIImagePickerController *)picker
{
    [picker dismissViewControllerAnimated:YES completion:nil];
}

//- (void)btnClick:(id)sender
//{
//    [self.baseTableView setContentOffset:CGPointMake(0, 0) animated:YES];
//}
//获取服务列表的头像
-(UIImage *)getServiceCatoryImage:(NSString *)indexStr
{
    NSInteger index = [indexStr intValue];
    if (index >= 0 && index < [serviceCatoryImageArry count]) {
        return [UIImage imageNamed:[serviceCatoryImageArry objectAtIndex:index]] ;
    }
    else
    {
        return nil;
    }
    
}
//自适应商户名称
-(void)autoFitSize:(UITextField *)textField str:(NSString *)strTemp
{
    CGRect frame = textField.frame;
    textField.text = strTemp;
    [textField sizeToFit];
    NSInteger width = textField.frame.size.width;
    if (width > kScreenWidth - 20-18) {
        width = kScreenWidth - 20-18;
    }
    textField.textAlignment = NSTextAlignmentCenter;
    textField.frame = frame;
    editBtn.frame = CGRectMake(CGRectGetMaxX(textField.frame), textField.frame.origin.y-10, 20+20, 20+20);
    editBtn.imageEdgeInsets = UIEdgeInsetsMake(10,10,10,10);
}
//点击弹起textView以及textfiled
-(void)tapClick:(id)sender
{
     [textAddressDetail resignFirstResponder];
     [ShopNameText resignFirstResponder];
     editBtn.hidden = NO;
     [ServerDetailTextView resignFirstResponder];//服务细节描述
     [labServerRightTextView resignFirstResponder];
     [btnCallText resignFirstResponder];
     [phoneNumberText resignFirstResponder];
}

#pragma mark -
#pragma mark 创建视图

//创建head的main视图
-(void)createMainView
{
    tableHeadView = [[UIView alloc] init];
    [tableHeadView setBackgroundColor:THEME_COLOR_ORANGE];
    UITapGestureRecognizer *tapGesture = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(tapClick:)];
    [tableHeadView addGestureRecognizer:tapGesture];
}
//创建section1
-(void)createSectionOne
{
    sectionOneView = [[UIView alloc]init];
    sectionOneView.backgroundColor = [UIColor clearColor];
    [sectionOneView setFrame:CGRectMake(0, -kShopManageSectionOneHeight, kScreenWidth-kShopManageSectionOneHeight, kScreenWidth)];
    
    //商户大图
    shopBigImg = [[UIImageView alloc] initWithFrame:CGRectMake(0, 125-kScreenWidth, kScreenWidth,kScreenWidth)];
    [shopBigImg setImage:[UIImage imageNamed:@"shopTopDefault"]];
    [shopBigImg setBackgroundColor:[UIColor clearColor]];
    shopBigImg.userInteractionEnabled = YES;
    
    
    [sectionOneView addSubview:shopBigImg];
    
    
    //拍照
    UIButton *shopAvatarBtn = [[UIButton alloc]initWithFrame:CGRectMake(kScreenWidth-28-15, kShopManageSectionOneHeight-28-kJianJu, 28, 28)];
    shopAvatarBtn.layer.cornerRadius = 14.0f;
    shopAvatarBtn.layer.masksToBounds = YES;
    [shopAvatarBtn addTarget:self action:@selector(doEditHead) forControlEvents:UIControlEventTouchUpInside];
    [shopAvatarBtn setImage:[UIImage imageNamed:@"shop_photo"] forState:UIControlStateNormal];
    [sectionOneView addSubview:shopAvatarBtn];
    
    //中间类型图
    shopTypeImg = [[UIImageView alloc] initWithFrame:CGRectMake((kScreenWidth-80)/2, kShopManageSectionOneHeight - 40, 80, 80)];
    [shopTypeImg setBackgroundColor:[UIColor clearColor]];
    shopTypeImg.userInteractionEnabled  = YES;
    shopTypeImg.layer.borderWidth = 2.0f;
    shopTypeImg.layer.cornerRadius = 40;
    shopTypeImg.layer.borderColor = [UIColor whiteColor].CGColor;
    [shopTypeImg setImage:[self getServiceCatoryImage:0]];//店铺类型的图片
    shopTypeImg.layer.masksToBounds = YES;
    [sectionOneView addSubview:shopTypeImg];
    
    
    UIButton *selectCatoryBtn = [[UIButton alloc]initWithFrame:CGRectMake(100, kShopManageSectionOneHeight-60, 80, 80)];
    selectCatoryBtn.center = shopTypeImg.center;
    [selectCatoryBtn addTarget:self action:@selector(selectCatory) forControlEvents:UIControlEventTouchUpInside];
    [selectCatoryBtn setBackgroundColor:[UIColor clearColor]];
    [sectionOneView addSubview:selectCatoryBtn];
    
    
    //店名
    ShopNameText = [[UITextField alloc] initWithFrame:CGRectMake(10, CGRectGetMaxY(shopTypeImg.frame) + 15, kScreenWidth-70, 21)];
    ShopNameText.clearButtonMode = UITextFieldViewModeWhileEditing;
    [ShopNameText setBackgroundColor:[UIColor clearColor]];
    //[ShopNameText setText:@"阿纳达的咖啡店"];
    ShopNameText.delegate = self;
    ShopNameText.center = CGPointMake(kScreenWidth/2, CGRectGetMaxY(shopTypeImg.frame) + 20);
    [ShopNameText setFont:[UIFont systemFontOfSize:18.0f]];
    [ShopNameText setTextAlignment:NSTextAlignmentCenter];
    ShopNameText.textColor = UIColorFromRGB(0x333333);
    ShopNameText.userInteractionEnabled = NO;
    [sectionOneView addSubview:ShopNameText];
    
    //编辑
    editBtn = [[UIButton alloc]initWithFrame:CGRectMake(230, CGRectGetMaxY(shopTypeImg.frame) + 10, 18, 18)];
    [editBtn addTarget:self action:@selector(modifyShopName) forControlEvents:UIControlEventTouchUpInside];
    [editBtn setImage:[UIImage imageNamed:@"edit"] forState:UIControlStateNormal];
    [sectionOneView addSubview:editBtn];
    
    [self autoFitSize:ShopNameText str:detail.shopName];
    
//    UIImageView *vertifyImageView = [[UIImageView alloc]initWithFrame:CGRectMake((kScreenWidth - 46)/2, CGRectGetMaxY(ShopNameText.frame)+kJianJu, 46, 15)];
//    vertifyImageView.image = [UIImage imageNamed:@"shop_approve"];
//    [sectionOneView addSubview:vertifyImageView];
    
    
    vertifyLabel = [[UILabel alloc]init];
    vertifyLabel.layer.masksToBounds = YES;
    vertifyLabel.textAlignment = NSTextAlignmentCenter;
    vertifyLabel.layer.masksToBounds = YES;
    vertifyLabel.font = [UIFont systemFontOfSize:13.0];
    vertifyLabel.text = @"未认证";
    vertifyLabel.layer.cornerRadius = 17 / 2.0f;
    vertifyLabel.layer.borderColor = THEME_COLOR_TEXT.CGColor;
    vertifyLabel.layer.borderWidth = 1.0f;
    [vertifyLabel setTextColor:THEME_COLOR_TEXT];
    [vertifyLabel setFrame:CGRectMake((kScreenWidth - 53) / 2.0f, CGRectGetMaxY(ShopNameText.frame) + kJianJu, 53, 17)];
    vertifyLabel.adjustsFontSizeToFitWidth = YES;
    [sectionOneView addSubview:vertifyLabel];
    
    
    if ([ShopNameText.text length] == 0)
    {
        ShopNameText.text = @"请添加店铺名称";
    }
    
    if ([detail.authorize isEqualToString:@""])
    {
        vertifyLabel.text = @"未认证";
//        [applyVertifyBtn setBackgroundImage: [UIImage imageNamed:@"button"] forState:UIControlStateNormal];
    }
    else
    {
//        [applyVertifyBtn setBackgroundImage:nil forState:UIControlStateNormal];
//        applyVertifyBtn.backgroundColor = [UIColor lightGrayColor];
//        applyVertifyBtn.userInteractionEnabled = NO;
        vertifyLabel.layer.borderColor = THEME_COLOR_GREEN.CGColor;
        [vertifyLabel setTextColor:THEME_COLOR_GREEN];
        vertifyLabel.text = @"已认证";
    }
    
    //接通率
    labCall = [[UILabel alloc] initWithFrame:CGRectMake(0, CGRectGetMaxY(vertifyLabel.frame) + 5, kScreenWidth, 21)];
    [labCall setBackgroundColor:[UIColor clearColor]];
    [labCall setTextAlignment:NSTextAlignmentCenter];
    [labCall setTextColor:THEME_COLOR_TEXT];
    [labCall setFont:[UIFont fontWithName:FONTNAME size:12.0f]];
    if ([detail.connectionRate intValue] != 0) {
        labCall.text = [NSString stringWithFormat:@"接通率%@%%",detail.connectionRate];
    }
    [sectionOneView addSubview:labCall];
    
    //拨打电话
    btnCallText = [[UITextField alloc]init];
    btnCallText.delegate = self;
    btnCallText.textColor = THEME_COLOR_TEXT;
    [btnCallText setFrame:CGRectMake((kScreenWidth/2 - 140-10), ([detail.connectionRate intValue] == 0 ? CGRectGetMaxY(vertifyLabel.frame) + 10 : CGRectGetMaxY(labCall.frame) + 5), 140, 36)];
    btnCallText.placeholder = @"请输入座机号码";
    btnCallText.textAlignment = NSTextAlignmentCenter;
    btnCallText.clearButtonMode = UITextFieldViewModeAlways;
    btnCallText.backgroundColor = [UIColor whiteColor];
    btnCallText.layer.cornerRadius = 5.0f;
    btnCallText.delegate = self;
    btnCallText.layer.masksToBounds = YES;
    btnCallText.keyboardType = UIKeyboardTypeNumberPad;
    btnCallText.text = detail.shopPhone;
    [sectionOneView addSubview:btnCallText];
    
    
    phoneNumberText = [[UITextField alloc]init];
    phoneNumberText.delegate = self;
    phoneNumberText.textColor = THEME_COLOR_TEXT;
    [phoneNumberText setFrame:CGRectMake(kScreenWidth/2+10, ([detail.connectionRate intValue] == 0 ? CGRectGetMaxY(vertifyLabel.frame) + 10 : CGRectGetMaxY(labCall.frame) + 5), 140, 36)];
    phoneNumberText.placeholder = @"请输入电话号码";
    phoneNumberText.textAlignment = NSTextAlignmentCenter;
    phoneNumberText.clearButtonMode = UITextFieldViewModeAlways;
    phoneNumberText.backgroundColor = [UIColor whiteColor];
    phoneNumberText.layer.cornerRadius = 5.0f;
    phoneNumberText.delegate = self;
    phoneNumberText.layer.masksToBounds = YES;
    phoneNumberText.keyboardType = UIKeyboardTypeNumberPad;
    phoneNumberText.text = detail.shopPhone;
    [sectionOneView addSubview:phoneNumberText];
    
    
    [sectionOneView setFrame:CGRectMake(0, 0, kScreenWidth, CGRectGetMaxY(btnCallText.frame)+15)];
    UIImageView *line = [[UIImageView alloc]initWithFrame:CGRectMake(0, CGRectGetMaxY(sectionOneView.frame)-0.5, kScreenWidth, 0.5)];
    line.backgroundColor = THEME_COLOR_LINE;
    [sectionOneView addSubview:line];
    [tableHeadView addSubview:sectionOneView];
}
//创建secton2
-(void)createTwoView
{
    //detail.serviceDetail = @"圣诞节饭卡上";
    //UIFont *leftFont = [UIFont fontWithName:FONTNAME size:14.0f];
    UIFont *rightFont = [UIFont fontWithName:FONTNAME size:14.0f];
    CGSize size;
    if (IOS7)
    {
        NSDictionary *attribute = @{NSFontAttributeName: rightFont};
        size = [detail.serviceDetail boundingRectWithSize:CGSizeMake(kScreenWidth - 75 - 15, CGFLOAT_MAX) options: NSStringDrawingTruncatesLastVisibleLine | NSStringDrawingUsesLineFragmentOrigin | NSStringDrawingUsesFontLeading attributes:attribute context:nil].size;
    }
    else
    {
        size = [detail.serviceDetail sizeWithFont:rightFont constrainedToSize:CGSizeMake(kScreenWidth - 75 - 15, CGFLOAT_MAX) lineBreakMode:NSLineBreakByCharWrapping];
    }
//    NSLog(@"%f",size.height);
    
    if (size.height < 30)
    {
        size.height = 30;
    }
    size.height += 15;
    sectionTwoView =  [[UIView alloc]initWithFrame:CGRectMake(0, CGRectGetMaxY(sectionOneView.frame), kScreenWidth, size.height)];
    sectionTwoView.backgroundColor = [UIColor whiteColor];
    //服务描述
    
    UILabel *labServerLeft = [[UILabel alloc] initWithFrame:CGRectMake(15, 11, 70, 21)];
    labServerLeft.textAlignment = NSTextAlignmentLeft;
    [labServerLeft setBackgroundColor:[UIColor clearColor]];
    [labServerLeft setText:@"服务描述:"];
    [labServerLeft setFont:[UIFont systemFontOfSize:15.0]];
    labServerLeft.textColor = UIColorFromRGB(0x333333);
    //[labServerLeft setFont:leftFont];
    [sectionTwoView addSubview:labServerLeft];
    
    ServerDetailTextView = [[UITextView alloc] initWithFrame:CGRectMake(75, -15, kScreenWidth - 75 - 15, MAX(33, size.height))];
    [ServerDetailTextView setBackgroundColor:[UIColor clearColor]];
    [ServerDetailTextView setText:detail.serviceDetail];
    [ServerDetailTextView setFont:rightFont];
//    [ServerDetailTextView sizeToFit];
    ServerDetailTextView.delegate  = self;
    [ServerDetailTextView setTextColor:THEME_COLOR_TEXT];
    [sectionTwoView addSubview:ServerDetailTextView];
    ServerDetailTextView.frame = CGRectMake(75, 6, kScreenWidth - 75, size.height);
//    NSLog(@"%f",ServerDetailTextView.contentSize.height);
    
//    UIImageView * line3 = [[UIImageView alloc]initWithFrame:CGRectMake(0, CGRectGetMaxY(sectionTwoView.frame)-1, kScreenWidth, 1)];
//    line3.backgroundColor = THEME_COLOR_LINE;
//    [sectionTwoView addSubview:line3];
    
    serverDesIcon = [[UIImageView alloc]init];
    [serverDesIcon setImage:[UIImage imageNamed:@"edit_text"]];
    [serverDesIcon setFrame: CGRectMake(CGRectGetMaxX(sectionTwoView.frame)-11,sectionTwoView.frame.size.height-11, 11, 11)];
    [sectionTwoView addSubview:serverDesIcon];
    [tableHeadView addSubview:sectionTwoView];
    
}
//创建第三个视图
-(void)createThreeView
{
   // UIFont *leftFont = [UIFont fontWithName:FONTNAME size:14.0f];
    shopPhotoView = [[UIView alloc]initWithFrame:CGRectMake(0, CGRectGetMaxY(sectionTwoView.frame), kScreenWidth, 126)];
    shopPhotoView.backgroundColor =  UIColorFromRGB(0xf0f0f0);
    [tableHeadView addSubview:shopPhotoView];
    
    UIImageView * line = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, kScreenWidth, 0.5)];
    line.backgroundColor = THEME_COLOR_LINE;
    [shopPhotoView addSubview:line];
    
    UILabel *labShopPhoto = [[UILabel alloc] initWithFrame:CGRectMake(15, 10, 100, 21)];
    [labShopPhoto setBackgroundColor:[UIColor clearColor]];
    [labShopPhoto setText:@"店铺相册"];
    [labShopPhoto setFont:[UIFont systemFontOfSize:15.0]];
    labShopPhoto.textColor = UIColorFromRGB(0x333333);
    [shopPhotoView addSubview:labShopPhoto];
//    [self initWithForPhoto];
    [self createZoomImage];
}
//创建视图4
-(void)createFourView
{
     [self initAddressTime];
}

- (void)createAuthorView
{
    
    authorView = [[UIView alloc] initWithFrame:CGRectMake(0, CGRectGetMaxY(whiteView.frame) , kScreenWidth, 85)];
    authorView.backgroundColor = [UIColor clearColor];
    [tableHeadView addSubview:authorView];
    
    UIView *line = [[UIView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, 0.5)];
    line.backgroundColor = THEME_COLOR_LINE;
    [authorView addSubview:line];
    
    if (renlinFlag)         //认领商铺时无申请认证按钮
    {
        authorView.frame = CGRectMake(0, CGRectGetMaxY(whiteView.frame), kScreenWidth, 10);
        return;
    }
    
    applyVertifyBtn = [[UIButton alloc]initWithFrame:CGRectMake(15, 20, kScreenWidth - 30, 45)];
    [applyVertifyBtn setBackgroundImage: [UIImage imageNamed:@"button"] forState:UIControlStateNormal];
    applyVertifyBtn.layer.cornerRadius = 3.0f;
    applyVertifyBtn.layer.masksToBounds = YES;
    
    if ([detail.authorize isEqualToString:@""]||[detail.authorize isEqualToString:@"1"])
    {
        [applyVertifyBtn setBackgroundImage:[UIImage imageNamed:@"button"] forState:UIControlStateNormal];
        [applyVertifyBtn setTitle:@"申请认证" forState:UIControlStateNormal];
    }
    else if([detail.authorize isEqualToString:@"0"])
    {
        [applyVertifyBtn setBackgroundImage:[Utility imageWithColor:[UIColor lightGrayColor] andSize:CGSizeMake(kScreenWidth - 30, 45)] forState:UIControlStateNormal];
        applyVertifyBtn.backgroundColor = UIColorFromRGB(0x727272);
        applyVertifyBtn.userInteractionEnabled = NO;
        [applyVertifyBtn setTitle:@"认证中" forState:UIControlStateNormal];
    }
    else
    {
        [applyVertifyBtn setBackgroundImage:[Utility imageWithColor:[UIColor lightGrayColor] andSize:CGSizeMake(kScreenWidth - 30, 45)] forState:UIControlStateNormal];
        applyVertifyBtn.backgroundColor = UIColorFromRGB(0x727272);
        applyVertifyBtn.userInteractionEnabled = NO;
        [applyVertifyBtn setTitle:@"已认证" forState:UIControlStateNormal];
    }
    
    [applyVertifyBtn.titleLabel setFont:[UIFont systemFontOfSize:19.0f]];
    [applyVertifyBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [applyVertifyBtn addTarget:self action:@selector(clickApplyVertify:) forControlEvents:UIControlEventTouchUpInside];
    [authorView addSubview:applyVertifyBtn];
}

- (void)initTableHeadView
{
    [self createMainView];
    [self createSectionOne];
    [self createTwoView];
    [self createThreeView];
    [self createFourView];
    [self createAuthorView];
    
   
    [tableHeadView setFrame:CGRectMake(0, 0, kScreenWidth, CGRectGetMaxY(authorView.frame))];
    self.baseTableView.showsVerticalScrollIndicator = NO;
    whiteView.backgroundColor = [UIColor whiteColor];
    tableHeadView.backgroundColor = [UIColor clearColor];
    self.baseTableView.tableHeaderView = tableHeadView;
    self.baseTableView.tableFooterView = [[UIView alloc] init];
}
-(void)clickApplyVertify:(id)sender
{
    if (renlinFlag)
    {
        [MobClick event:@"click_certificate"];
    }
    else
    {
        [MobClick event:@"click_certificate"];
    }
    
    ApplyVertifyViewController *applyVertifyView = [[ApplyVertifyViewController alloc]init];
    [self.navigationController pushViewController:applyVertifyView animated:YES];
}
-(void)createShopPhoto
{
//    imageScrollView = [[HWImageScrollView alloc]initWithFrame:CGRectMake(0, 26, 320, 85)];
    imageScrollView = [[HWImageScrollView alloc]initWithFrame:CGRectMake(0, 26, 320, 85) flag:NO];
    imageScrollView.backgroundColor = UIColorFromRGB(0xf0f0f0);
    imageScrollView.del = self;
    imageScrollView.scrollEnabled = YES;
    [shopPhotoView addSubview:imageScrollView];
}
- (void)showPicker{
    [self tapClick:nil];
    UIActionSheet *sheet = [[UIActionSheet alloc] initWithTitle:nil delegate:self cancelButtonTitle:@"取消" destructiveButtonTitle:nil otherButtonTitles:@"拍照",@"从相册中选择", nil];
    sheet.tag = 5000;
    sheet.actionSheetStyle = UIActionSheetStyleBlackTranslucent;
    [sheet showInView:self.view];
}

#pragma mark -
#pragma mark TextView Delegate
- (void)textViewDidBeginEditing:(UITextView *)textView
{
    if (textView == ServerDetailTextView) {
        if (renlinFlag)
        {
            [MobClick event:@"click_claim_servedescription"];
        }
        else
        {
            [MobClick event:@"click_change_servedescription"];
        }
        
        CGContextRef context = UIGraphicsGetCurrentContext(); //返回当前视图堆栈顶部的图形上下文
        [UIView beginAnimations:nil context:context];
        [UIView setAnimationCurve:UIViewAnimationCurveEaseOut];
        [baseTableView setContentOffset:CGPointMake(0, 280)];
        [UIView setAnimationDuration:1.0];
        //设置属性的变换，可以对frame的位置进行变换来实现移动的效果
        [UIView commitAnimations];      //执行动画
    }
}
- (void)textViewDidChange:(UITextView *)textView
{
    NSLog(@"%@",[NSValue valueWithCGSize:textView.contentSize]);
    
    if (textView == ServerDetailTextView) {
        CGRect frame = textView.frame;
        frame.size.height = textView.contentSize.height;
        textView.frame = frame;
        CGRect sFrame = sectionTwoView.frame;
        sFrame.size.height = CGRectGetMaxY(ServerDetailTextView.frame);
        sectionTwoView.frame = sFrame;
        [serverDesIcon setFrame: CGRectMake(CGRectGetMaxX(sectionTwoView.frame)-11,sectionTwoView.frame.size.height-11, 11, 11)];
        [sectionTwoView addSubview:serverDesIcon];
        [self refreshSectionViewFrame];
    }
    
}
- (void)textViewDidEndEditing:(UITextView *)textView
{
    if (textView == ServerDetailTextView)
    {
        CGContextRef context = UIGraphicsGetCurrentContext(); //返回当前视图堆栈顶部的图形上下文
        [UIView beginAnimations:nil context:context];
        [UIView setAnimationCurve:UIViewAnimationCurveEaseOut];
        [UIView setAnimationDuration:1.0];
        [baseTableView setContentOffset:CGPointMake(0, 0)];
        //设置属性的变换，可以对frame的位置进行变换来实现移动的效果
        [UIView commitAnimations];      //执行动画
    }
   
}

-(BOOL)textView:(UITextView *)textView shouldChangeTextInRange:(NSRange)range replacementText:(NSString *)text
{
    if (textView == ServerDetailTextView)
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

#pragma mark -

-(void)refreshSectionViewFrame
{
    CGRect frame1 = shopPhotoView.frame;
    frame1.origin.y = CGRectGetMaxY(sectionTwoView.frame);
    shopPhotoView.frame = frame1;
    
    CGRect frame2 = whiteView.frame;
    frame2.origin.y = CGRectGetMaxY(shopPhotoView.frame);
    whiteView.frame = frame2;
    
    CGRect frame3 = authorView.frame;
    frame3.origin.y = CGRectGetMaxY(whiteView.frame);
    authorView.frame = frame3;
    
//    [serverScopeIcon setFrame: CGRectMake(CGRectGetMaxX(whiteView.frame)-11,whiteView.frame.size.height-11, 11, 11)];
    CGRect frame4 = tableHeadView.frame;
    frame4.size.height = CGRectGetMaxY(authorView.frame);
    tableHeadView.frame = frame4;
    
    baseTableView.tableHeaderView = tableHeadView;
    baseTableView.backgroundColor = [UIColor clearColor];

}
- (void)initAddressTime
{
    UIFont *bigFont = [UIFont fontWithName:FONTNAME size:14.0f];
    UIFont *smallFont = [UIFont fontWithName:FONTNAME size:14.0f];
    float rightY = 85;
    
    whiteView = [[UIView alloc] initWithFrame:CGRectMake(0, CGRectGetMaxY(shopPhotoView.frame), kScreenWidth, 44*4)];
    [whiteView setBackgroundColor:[UIColor whiteColor]];
    [tableHeadView addSubview:whiteView];
    
    UILabel *labAddress = [[UILabel alloc] initWithFrame:CGRectMake(15, kJianJu, 100, 20)];
    [labAddress setBackgroundColor:[UIColor clearColor]];
    [labAddress setFont:bigFont];
    [labAddress setText:@"店铺地址:"];
    labAddress.font = [UIFont systemFontOfSize:15.0];
    labAddress.textColor = UIColorFromRGB(0x333333);
    [whiteView addSubview:labAddress];
    
    
    textAddressDetail = [[UITextField alloc] initWithFrame:CGRectMake(rightY, kJianJu, kScreenWidth - 80 - 25, 21)];
    textAddressDetail.delegate = self;
    [textAddressDetail setBackgroundColor:[UIColor clearColor]];
    [textAddressDetail setText:detail.shopAddress];
    [textAddressDetail setFont:smallFont];
    [textAddressDetail setTextColor:THEME_COLOR_TEXT];
    [whiteView addSubview:textAddressDetail];
    
    UIButton *locationBtn = [[UIButton alloc]initWithFrame:CGRectMake(kScreenWidth - 35, 2, 15+20, 18+20)];
    locationBtn.backgroundColor = [UIColor clearColor];
    [locationBtn setImage:[UIImage imageNamed:@"创建小区-位置"] forState:UIControlStateNormal];
    locationBtn.contentEdgeInsets = UIEdgeInsetsMake(10, 10, 10, 10);
    [locationBtn addTarget:self action:@selector(locationBtnClick) forControlEvents:UIControlEventTouchUpInside];
    [whiteView addSubview:locationBtn];
    
    UIImageView * line = [[UIImageView alloc]initWithFrame:CGRectMake(0, CGRectGetMaxY(textAddressDetail.frame)+kJianJu + 1, kScreenWidth, 0.5)];
    line.backgroundColor = THEME_COLOR_LINE;
    [whiteView addSubview:line];
    
    UIImageView *sectionAddressIcon = [[UIImageView alloc]init];
    [sectionAddressIcon setImage:[UIImage imageNamed:@"edit_text"]];
    sectionAddressIcon.backgroundColor = [UIColor clearColor];
    [sectionAddressIcon setFrame: CGRectMake(kScreenWidth-11,CGRectGetMaxY(line.frame)-11, 11, 11)];
    [whiteView addSubview:sectionAddressIcon];

    
    
    UILabel *labTime = [[UILabel alloc] initWithFrame:CGRectMake(15, CGRectGetMaxY(line.frame)+kJianJu, 100, 21)];
    [labTime setBackgroundColor:[UIColor clearColor]];
    [labTime setText:@"营业时间："];
    labTime.font = [UIFont systemFontOfSize:15.0];
    labTime.textColor = UIColorFromRGB(0x333333);
    [whiteView addSubview:labTime];
    
    UIButton *clickOpenTimeBtn = [[UIButton alloc]initWithFrame:CGRectMake(0, CGRectGetMaxY(textAddressDetail.frame), kScreenWidth, 21+kJianJu)];
    [clickOpenTimeBtn addTarget:self action:@selector(toSelectOpenTime) forControlEvents:UIControlEventTouchUpInside];
    clickOpenTimeBtn.backgroundColor = [UIColor clearColor];
    [whiteView addSubview:clickOpenTimeBtn];
    
    UIImageView * lineOne = [[UIImageView alloc]initWithFrame:CGRectMake(0, CGRectGetMaxY(labTime.frame)+kJianJu, kScreenWidth, 0.5)];
    lineOne.backgroundColor = THEME_COLOR_LINE;
    [whiteView addSubview:lineOne];
    
    UIImageView *sectionTimeIcon = [[UIImageView alloc]init];
    sectionTimeIcon.backgroundColor = [UIColor clearColor];
    [sectionTimeIcon setImage:[UIImage imageNamed:@"edit_text"]];
    [sectionTimeIcon setFrame: CGRectMake(kScreenWidth-11,CGRectGetMaxY(lineOne.frame)-11, 11, 11)];
    [whiteView addSubview:sectionTimeIcon];
    
    labTimeDetail = [[UILabel alloc] initWithFrame:CGRectMake(rightY,CGRectGetMaxY(textAddressDetail.frame)+2*kJianJu+6, kScreenWidth - 90, 21)];
    [labTimeDetail setBackgroundColor:[UIColor clearColor]];
    labTimeDetail.text = detail.shopTime;
    [labTimeDetail setTextColor:THEME_COLOR_TEXT];
    [labTimeDetail setFont:smallFont];
    labTimeDetail.numberOfLines = 0;
    CGSize sizeTime = [labTimeDetail.text sizeWithFont:smallFont constrainedToSize:CGSizeMake(kScreenWidth - 90, CGFLOAT_MAX)];
    [labTimeDetail sizeToFit];
    [labTimeDetail setFrame:CGRectMake(rightY, CGRectGetMaxY(textAddressDetail.frame)+2*kJianJu + 4, kScreenWidth - 90, sizeTime.height)];
    [whiteView addSubview:labTimeDetail];
    
    UILabel *labServer = [[UILabel alloc] initWithFrame:CGRectMake(15, CGRectGetMaxY(labTimeDetail.frame) + 2 * kJianJu - 3, 100, 21)];
    [labServer setBackgroundColor:[UIColor clearColor]];
    [labServer setText:@"服务范围:"];
    labServer.font = [UIFont systemFontOfSize:15.0];
    labServer.textColor = UIColorFromRGB(0x333333);
    [whiteView addSubview:labServer];
    
    
    labServerRightTextView = [[UILabel alloc] initWithFrame:CGRectMake(rightY, CGRectGetMaxY(labTimeDetail.frame) + 2 * kJianJu - 3, kScreenWidth - rightY - 15, 45)];
    labServerRightTextView.userInteractionEnabled = NO;
//    labServerRightTextView.delegate = self;
    labServerRightTextView.text = [self pinJieServiceScope:detail.arrServiceRange];
    labServerRightTextView.numberOfLines = 0;
    [labServerRightTextView sizeToFit];
    [labServerRightTextView setFrame:CGRectMake(rightY-5, CGRectGetMaxY(labTimeDetail.frame) + 2 * kJianJu - 3, kScreenWidth - 90, labServerRightTextView.frame.size.height > 18 ? labServerRightTextView.frame.size.height : 18)];
    [labServerRightTextView setBackgroundColor:[UIColor clearColor]];
    [labServerRightTextView setFont:smallFont];
    [labServerRightTextView setTextColor:THEME_COLOR_TEXT];
    [whiteView addSubview:labServerRightTextView];
    
    whiteView.userInteractionEnabled = YES;
    
    serviceScopeBtn = [[UIButton alloc]initWithFrame:labServerRightTextView.frame];
    serviceScopeBtn.backgroundColor = [UIColor clearColor];
    [serviceScopeBtn addTarget:self action:@selector(toSelectScope:) forControlEvents:UIControlEventTouchUpInside];
//    [serviceScopeBtn setFrame:CGRectMake(0, CGRectGetMaxY(labTimeDetail.frame)+2*kJianJu,labServerRightTextView.frame.size.width, labServerRightTextView.frame.size.height)];
    [whiteView addSubview:serviceScopeBtn];
    
    serverScopeIcon = [[UIImageView alloc]init];
    serverScopeIcon.backgroundColor = [UIColor clearColor];
    [whiteView addSubview:serverScopeIcon];
    [serverScopeIcon setImage:[UIImage imageNamed:@"edit_text"]];
    whiteView.backgroundColor = [UIColor clearColor];
    
    [serverScopeIcon setFrame:CGRectMake(kScreenWidth - 11,CGRectGetMaxY(labServerRightTextView.frame) + 10, 11, 11)];
    
    [self initialSection6];
}

- (void)initialSection6
{
    takeAwayView = [[HWInputBackView alloc] initWithFrame:CGRectMake(0, CGRectGetMaxY(labServerRightTextView.frame) + 10 + 10, kScreenWidth, 50.0f) withLineCount:1];
    [whiteView addSubview:takeAwayView];
    
    UILabel *titleLab = [[UILabel alloc] initWithFrame:CGRectMake(15, 10.0f, 80, 30)];
    titleLab.backgroundColor = [UIColor clearColor];
    titleLab.textColor = UIColorFromRGB(0x333333);
    titleLab.font = [UIFont fontWithName:FONTNAME size:15.0f];
    titleLab.text = @"外送";
    [takeAwayView addSubview:titleLab];
    
    _takeAwayBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    _takeAwayBtn.frame = CGRectMake(kScreenWidth - 24 - 25, (50 - 24) / 2.0f, 24, 24);
    [_takeAwayBtn setBackgroundImage:[UIImage imageNamed:@"persionuncheck"] forState:UIControlStateNormal];
    [_takeAwayBtn setImage:[UIImage imageNamed:@"persionCheck"] forState:UIControlStateNormal];
    
    [_takeAwayBtn addTarget:self action:@selector(toCheck:) forControlEvents:UIControlEventTouchUpInside];
    [takeAwayView addSubview:_takeAwayBtn];

    [whiteView setFrame:CGRectMake(0, whiteView.frame.origin.y, kScreenWidth, CGRectGetMaxY(takeAwayView.frame))];
}

- (void)toCheck:(id)sender
{
    if (renlinFlag)
    {
        [MobClick event:@"click_change_doortodoor"];
    }
    else
    {
        [MobClick event:@"click_change_doortodoor"];
    }
    
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

#pragma mark -
#pragma 选择方法
//选择类别
-(void)selectCatory
{
    if (renlinFlag)
    {
        [MobClick event:@"click_claim_shoptype"];
    }
    else
    {
        [MobClick event:@"click_change_shoptype"];
    }
    
    HWServiceCatoryViewController *serviceCatoryView = [[HWServiceCatoryViewController alloc]initWithNibName:@"HWServiceCatoryViewController" bundle:nil];
    [serviceCatoryView setSelectCatory:^(NSString *catoryNameStr, NSString*index,NSURL *catoryUrlTemp) {
        selectCatoryIndex = index;
        __weak UIImageView *shopTypeImgTmep = shopTypeImg;
        [shopTypeImgTmep setImageWithURL:catoryUrlTemp placeholderImage:[UIImage imageNamed:@"other"] completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType) {
            if (error)
            {
                NSLog(@"Error : load image fail.");
                shopTypeImgTmep.image = [UIImage imageNamed:@"other"];
            }
            else
            {
                shopTypeImgTmep.image = image;
                if (cacheType == 0)
                { // request url
                    CATransition *transition = [CATransition animation];
                    transition.duration = 1.0f;
                    transition.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut];
                    transition.type = kCATransitionFade;
                    [shopTypeImgTmep.layer addAnimation:transition forKey:nil];
                }
            }
        }];
    }];
    [self.navigationController pushViewController:serviceCatoryView animated:YES];
}
//修改店铺名称
-(void)modifyShopName
{
    if (renlinFlag)
    {
        [MobClick event:@"click_claim_shopname"];
    }
    else
    {
        [MobClick event:@"click_change_shopname"];
    }
    
    ShopNameText.userInteractionEnabled = YES;
    
    editBtn.hidden = YES;
    [ShopNameText becomeFirstResponder];
}

- (void)toSelectOpenTime
{
    if (renlinFlag)
    {
        [MobClick event:@"click_claim_shopopentime"];
    }
    else
    {
        [MobClick event:@"click_change_shopopentime"];
    }
    
    HWOpenTimeViewController *openTimeVC = [[HWOpenTimeViewController alloc] init];
    [openTimeVC setSelectTime:^(NSString *openTimeStr,NSString *closeTimeStr) {
        NSMutableString *timeStr = [NSMutableString string];
        [timeStr appendString:openTimeStr];
        [timeStr appendString:@"~"];
        [timeStr appendString:closeTimeStr];
        labTimeDetail.text = timeStr;
        openTime = openTimeStr;
        closeTime = closeTimeStr;
    }];
    [self.navigationController pushViewController:openTimeVC animated:YES];
}
//点击编辑地址
-(void)locationBtnClick
{
    if (renlinFlag)
    {
        [MobClick event:@"click_claimshopaddress"];
    }
    else
    {
        [MobClick event:@"click_change_shopaddress"];
    }
    
    
    MapLocationViewController *mapLocationView = [[MapLocationViewController alloc]initWithNibName:@"MapLocationViewController" bundle:nil];
    [mapLocationView setClickReturnLocation:^(NSString *posizition,NSString *latitude,NSString *longtitude) {
        
        textAddressDetail.text = posizition;
        latitudeStr = latitude;
        longTitudeStr = longtitude;
    }];
    [self.navigationController pushViewController:mapLocationView animated:YES];
}
//选择服务范围
- (void)toSelectScope:(id)sender
{
    if (renlinFlag)
    {
        [MobClick event:@"click_claim_shopvillage"];
    }
    else
    {
        [MobClick event:@"click_change_shopvillage"];
    }
    
    HWCommunityViewController * selectCommunityView = [[HWCommunityViewController alloc]init];
    [selectCommunityView setSlectedCommunity:^(NSString * communityStrS,NSMutableArray *arry) {
        labServerRightTextView.text = communityStrS;
        serviceArry = [NSMutableArray array];
        serviceArry  = arry;
       [self serviceScopeChange];
    }];
    if ([serviceArry count]!=0) {
        selectCommunityView.frontArry = serviceArry;
    }
//    else
//    {
//        selectCommunityView.frontArry = frontSelectedCommunityArry;
//    }

    
    [self.navigationController pushViewController:selectCommunityView animated:YES];
}//添加图片请求
//服务描述动态改变整体的尺寸
//-(void)serviceDescription
//{
//    CGRect frame = labServerRightTextView.frame;
//    frame.size.height = labServerRightTextView.contentSize.height;
//    labServerRightTextView.frame = frame;
//    CGRect sFrame = serverView.frame;
//    sFrame.size.height = CGRectGetMaxY(labServerRightTextView.frame);
//    serverView.frame = sFrame;
//    lineServer.frame = CGRectMake(lineServer.frame.origin.x,sFrame.size.height-0.5,lineServer.frame.size.width,0.5);
//    [serverDesIcon setFrame: CGRectMake(CGRectGetMaxX(serverView.frame)-11, serverView.frame.size.height-11, 11, 11)];
//    [self refreshSectionViewFrame];
//}
#pragma mark -
#pragma mark 服务范围内容动态改变改变整体的尺寸
-(void)serviceScopeChange
{
    labServerRightTextView.numberOfLines = 0;
    [labServerRightTextView sizeToFit];
    CGRect frame = labServerRightTextView.frame;
    frame.size.width = kScreenWidth - frame.origin.x - 15;
    frame.size.height = frame.size.height > 22 ? frame.size.height : 22;
    labServerRightTextView.frame = frame;
    
    serviceScopeBtn.frame = frame;
    
    CGRect tFrame = takeAwayView.frame;
    tFrame.origin.y = CGRectGetMaxY(labServerRightTextView.frame) + 10 + 10;
    takeAwayView.frame = tFrame;
    
    CGRect sFrame = whiteView.frame;
    sFrame.size.height = CGRectGetMaxY(takeAwayView.frame);
    whiteView.frame = sFrame;
    
    CGRect tempFrame = authorView.frame;
    tempFrame.origin.y = CGRectGetMaxY(whiteView.frame);
    authorView.frame = tempFrame;
    
    [serverScopeIcon setFrame: CGRectMake(kScreenWidth - 11, CGRectGetMaxY(labServerRightTextView.frame) + 10, 11, 11)];

    CGRect headFrame = tableHeadView.frame;
    headFrame.size.height = CGRectGetMaxY(authorView.frame);
    tableHeadView.frame = headFrame;
    
    self.baseTableView.showsVerticalScrollIndicator = YES;
    whiteView.backgroundColor = [UIColor whiteColor];
    self.baseTableView.tableHeaderView = tableHeadView;
}
#pragma mark -
#pragma mark - zoom image
- (void)createZoomImage
{
    imageScrollView = [[HWImageScrollView alloc]initWithFrame:CGRectMake(0, 30, kScreenWidth, 90) flag:NO];
    imageScrollView.tag = 999;
    imageScrollView.backgroundColor = UIColorFromRGB(0xf0f0f0);
    imageScrollView.del = self;
    imageScrollView.userInteractionEnabled = YES;
    imageScrollView.scrollEnabled = YES;
    [shopPhotoView addSubview:imageScrollView];
    
    CGFloat width = fmaxf(290, 80 * photoKeyArr.count);
    [imageScrollView setContentSize:CGSizeMake(width, 80)];
}

- (void)returnClickImage:(NSMutableArray *)arry currentIndex:(NSInteger)currentIndexTemp gesture:(UITapGestureRecognizer *)tap
{
    //add by gusheng
    //    UIImageView *img = (UIImageView *)tap.view;
    //    currentIndex = currentIndexTemp;
    
    NSMutableArray *photos = [[NSMutableArray alloc] init];
//    NSArray *arrBigImage = detail.picUrls;
    for (int i = 0; i < photoKeyArr.count; i ++)
    {
        NSString *strUrl = [Utility imageDownloadWithMongoDbKey:[photoKeyArr objectAtIndex:i]];
        MJPhoto *photo = [[MJPhoto alloc] init];
        photo.url = [NSURL URLWithString:strUrl];
        UIImageView *imgView = (UIImageView *)[self.view viewWithTag:tap.view.tag];
        photo.srcImageView = imgView;
        [photos addObject:photo];
    }
    
    MJPhotoBrowser *browser = [[MJPhotoBrowser alloc] init];
    browser.currentPhotoIndex = tap.view.tag - 100;
    browser.photos = photos;
    [browser show];
}
#pragma mark -
#pragma mark - scrollview delegate
- (void) scrollViewDidEndDecelerating:(UIScrollView *)scrollView
{
//    NSLog(@"停止时 y = %f",scrollView.contentOffset.y);
    if (scrollView.contentOffset.y == 0) {
        return;
    }
//    if (btn.alpha == 0) {
//        [UIView animateWithDuration:1.0f animations:^{
//            btn.alpha = 1;
//        }];
//    }
}

-(void)scrollViewDidScroll:(UIScrollView *)scrollView
{
//    [UIView animateWithDuration:1.0f animations:^{
//        btn.alpha = 0;
//    }];
}
#pragma mark -
#pragma mark - TextFieldDelegate
-(void)textFieldDidBeginEditing:(UITextField *)textField
{
    if (textField == btnCallText) {
        [MobClick event:@"click_change_shopphone"];
         [baseTableView setContentOffset:CGPointMake(0, 100)];
    }
    else if (textField == phoneNumberText)
    {
        [baseTableView setContentOffset:CGPointMake(0, 100)];
    }
    else if(textField == textAddressDetail)
    {
        [baseTableView setContentOffset:CGPointMake(0, 300)];
    }
    else if(textField == ShopNameText)
    {
        editBtn.hidden = YES;
    }
    else if (textField == phoneNumberText)
    {
        if (renlinFlag)
        {
            [MobClick event:@"click_claim_shopmobilephone"];
        }
        else
        {
            [MobClick event:@"click_change_shopmobilephone"];
        }
    }
    else if (textField == btnCallText)
    {
        if (renlinFlag)
        {
            [MobClick event:@"click_claim_shopphone"];
        }
        else
        {
            [MobClick event:@"click_change_shopphone"];
        }
    }
   
}

- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string
{
   if(textField ==btnCallText)
    {
      
        if ([btnCallText.text length] >= 13 && range.length == 0)
        {
            return NO;
        }
        
    }
    else if(textField == phoneNumberText)
    {
        if ([phoneNumberText.text length] >= 11 && range.length == 0)
        {
            return NO;
        }
    }
    else if (textField == textAddressDetail)
    {
        if (textAddressDetail.text.length > 50 && range.length == 0)
        {
            return NO;
        }
    }
    return YES;
}
-(BOOL)textFieldShouldReturn:(UITextField *)textField
{
    if (textField == ShopNameText) {
        [ShopNameText resignFirstResponder];
        editBtn.hidden = NO;
    }
    else if(textField == btnCallText)
    {
        [btnCallText resignFirstResponder];
        [baseTableView setContentOffset:CGPointMake(0, 0)];
    }
    else if(textField == phoneNumberText)
    {
        [phoneNumberText resignFirstResponder];
        [baseTableView setContentOffset:CGPointMake(0, 0)];
    }
    else
    {
        [textAddressDetail resignFirstResponder];
    }
    
    return YES;
}
-(BOOL)textFieldShouldEndEditing:(UITextField *)textField
{
    [baseTableView setContentOffset:CGPointMake(0, 0)];
    return YES;
}
#pragma mark -
#pragma mark tableview delegate

#pragma mark -
#pragma mark -

- (void)deleteOnePhoto:(NSString *)shopIdStrTemp index:(NSInteger)index
{
    [Utility showMBProgress:self.view message:@"删除图片"];
    HWHTTPRequestOperationManager *manager = [HWHTTPRequestOperationManager manager];
    NSMutableDictionary *dict = [NSMutableDictionary dictionary];
    [dict setObject:[HWUserLogin currentUserLogin].key forKey:@"key"];
    [dict setPObject:shopIdStr forKey:@"shopId"];
    [dict setObject:shopIdStrTemp forKey:@"photoIds"];
    [manager POST:kDeleteOnePhoto parameters:dict queue:nil success:^(id responseObject){
        NSLog(@"%@",responseObject);
        [Utility hideMBProgress:self.view];
        //[self.navigationController popViewControllerAnimated:YES];
        //成功后 删掉key
        [photoKeyArr removeObjectAtIndex:index];
        NSLog(@"sucess");
    }failure:^(NSString *code, NSString *error) {
        [Utility hideMBProgress:self.view];
        [Utility showToastWithMessage:error inView:self.view];
        NSLog(@"error %@",error);
    }];
}
-(void)sumitRenlinInfo
{
    /*
     入参:
     shopId:必填,
     name:店铺名称,
     address:店铺地址,
     type:店铺类型,
     mobile:手机,
     phone:座机,
     serviceDesc:服务描述,
     longitude:经度,
     latitude:纬度,
     provinceId:省id,
     cityId:城市id,
     districtId:区id,
     营业时间开始:opentime,
     营业结束时间:endtime,
     shangmen:上门,0,1
     subdistrictId:街道id,
     pics:图片附件,
     serviceVillage:服务小区信息 [
     {villageId:1,distance:100}
     ,
     {villageId:3,distance:200}
     ]
     */
    
    
//    NSLog(@"手机 = %@",phoneNumberText.text);
//    NSLog(@"座机 = %@",btnCallText.text);
    
    
    if(!ShopNameText)
    {
        return;
    }
    if ([ShopNameText.text length]==0) {
        [Utility showToastWithMessage:@"店铺名不能为空" inView:self.view];
        return;
    }
    if (phoneNumberText.text.length == 0 && btnCallText.text.length == 0)
    {
        [Utility showToastWithMessage:@"手机或座机至少填写一个" inView:self.view];
        return;
    }
    HWHTTPRequestOperationManager *manager = [HWHTTPRequestOperationManager manager];
    NSMutableDictionary *dict = [NSMutableDictionary dictionary];
    [dict setPObject:ShopNameText.text forKey:@"name"];
    [dict setPObject: selectCatoryIndex forKey:@"type"];
    [dict setPObject:textAddressDetail.text forKey:@"address"];
    [dict setPObject:phoneNumberText.text forKey:@"mobile"];
    [dict setPObject:btnCallText.text forKey:@"phone"];
    [dict setPObject:ServerDetailTextView.text forKey:@"serviceDesc"];
    [dict setPObject:longTitudeStr forKey:@"longitude"];
    [dict setPObject:latitudeStr forKey:@"latitude"];
    //[dict setPObject:@"" forKey:@"provinceId"];
     [dict setPObject:[HWUserLogin currentUserLogin].cityId forKey:@"cityId"];
    //[dict setPObject:@"" forKey:@"districtId"];
    if (detail.shopTime) {
        NSArray *arryTemp = [detail.shopTime componentsSeparatedByString:@"~"];
        if (arryTemp && [arryTemp count]>=1) {
            openTime = [arryTemp objectAtIndex:0];
            [dict setPObject:openTime forKey:@"opentime"];
        }
        if (arryTemp && [arryTemp count]>=2) {
            closeTime = [arryTemp objectAtIndex:1];
            [dict setPObject:closeTime forKey:@"endtime"];
        }
    }

    [dict setPObject:(waiMaiFlag ? @"1" : @"0") forKey:@"shangmen"]; // 1:外送  0:不外送
    //[dict setPObject:@"" forKey:@"subdistrictId"];
    [dict setPObject:shopIdStr forKey:@"shopId"];
//    [dict setPObject:@"100" forKey:@"dateVersion"];
    if (shopBigImg) {
        NSData *shopImageData = UIImageJPEGRepresentation(shopBigImg.image, 1.0);
        [dict setObject:shopImageData forKey:@"banners"];
    }
    [dict setPObject:[NSString jsonStringWithArray:[self pinJieServiceScope:serviceArry :shopIdStr]] forKey:@"serviceVillage"];
//    [dict setPObject:[self crapPicData] forKey:@"pics"];
    AppDelegate *app = (AppDelegate *)[UIApplication sharedApplication].delegate;
    [Utility showMBProgress:app.window message:@"提交修改"];
    [manager POSTManyAndShopImagePhotoImage:kRenLinShop parameters:dict queue:nil success:^(id responseObject) {
        [Utility hideMBProgress:app.window];
        [HWUserLogin currentUserLogin].shopId = shopIdStr;
        [HWCoreDataManager saveUserInfo];
//        AppDelegate *app = (AppDelegate *)[UIApplication sharedApplication].delegate;
        [Utility showToastWithMessage:@"提交成功" inView:app.window];
        [self.navigationController popViewControllerAnimated:YES];
        NSLog(@"submit sucess");
    }failure:^(NSString *error) {
        [Utility hideMBProgress:app.window];
        [Utility showToastWithMessage:error inView:self.view];
//        [Utility showToastWithMessage:error inView:self.view];
        NSLog(@"error %@",error);
    }];
}
-(BOOL)isModifyPersonInfo
{
    if (picModifyFlag) {
        return YES;
    }
    else if(![ShopNameText.text isEqualToString:detail.shopName])
    {
        return YES;
    }
    else if(![phoneNumberText.text isEqualToString:detail.mobile])
    {
        return YES;
    }
    else if(![btnCallText.text isEqualToString:detail.shopPhone])
    {
        return YES;
    }
    else if((waiMaiFlag&&[detail.outSell isEqualToString:@"0"])||(!waiMaiFlag&&[detail.outSell isEqualToString:@"1"]))
    {
        return YES;
    }
    else if(![ServerDetailTextView.text isEqualToString:detail.serviceDetail])
    {
        return YES;
    }
    else if(![textAddressDetail.text isEqualToString:detail.shopAddress])
    {
        return YES;
    }
    else if(![selectCatoryIndex isEqualToString:detail.shopType])
    {
        return YES;
    }
    else if(![labServerRightTextView.text isEqualToString:[self pinJieServiceScope:detail.arrServiceRange]])
    {
        return YES;
    }
    else if(![labTimeDetail.text isEqualToString:detail.shopTime])
    {
        return YES;
    }
    return NO;
}
-(void)submitEditInfo
{
    /*
     type:店铺类型,
     mobile:手机,
     phone:座机,
     serviceDesc:服务描述,
     longitude:经度,
     latitude:纬度,
     provinceId:省id,
     cityId:城市id,
     districtId:区id,
     营业时间开始:openTime,
     营业结束时间:endTime,
     shangmen:是否上门,0,1
     subdistrictId:街道id,
     serviceVillage:服务小区信息 [
     {shopId:1,villageId:1,distance:100}
     ,
     {shopId:1,villageId:3,distance:200}
     */
    if (![self isModifyPersonInfo]) {
        [self.navigationController popViewControllerAnimated:YES];
        return;
    }
    
    NSLog(@"%@",phoneNumberText.text);
    NSLog(@"%@",btnCallText.text);
    
    if(!ShopNameText)
    {
        return;
    }
    if ([ShopNameText.text length]==0) {
        [Utility showToastWithMessage:@"店铺名不能为空" inView:self.view];
        return;
    }
    
    if (phoneNumberText.text.length == 0 && btnCallText.text.length == 0)
    {
        [Utility showToastWithMessage:@"手机或座机至少填写一个" inView:self.view];
        return;
    }
    
    HWHTTPRequestOperationManager *manager = [HWHTTPRequestOperationManager manager];
    NSMutableDictionary *dict = [NSMutableDictionary dictionary];
    [dict setPObject:ShopNameText.text forKey:@"name"];
    [dict setPObject: selectCatoryIndex forKey:@"type"];
    [dict setPObject:textAddressDetail.text forKey:@"address"];
    
    [dict setPObject:phoneNumberText.text forKey:@"mobile"];
    [dict setPObject:btnCallText.text forKey:@"phone"];

    //[dict setPObject:@"0" forKey:@"phone"];
    [dict setPObject:ServerDetailTextView.text forKey:@"serviceDesc"];
    [dict setPObject:longTitudeStr forKey:@"longitude"];
    [dict setPObject:latitudeStr forKey:@"latitude"];
//    [dict setPObject:@"" forKey:@"provinceId"];
    [dict setPObject:[HWUserLogin currentUserLogin].cityId forKey:@"cityId"];
//    [dict setPObject:@"" forKey:@"districtId"];
    if (![labTimeDetail.text isEqualToString:detail.shopTime]) {
        [dict setPObject:openTime forKey:@"opentime"];
        [dict setPObject:closeTime forKey:@"endtime"];
    }
    [dict setPObject:(waiMaiFlag ? @"1" : @"0") forKey:@"shangmen"]; // 1:外送  0:不外送
  //  [dict setPObject:@"0" forKey:@"shangmen"];
    //[dict setPObject:@"" forKey:@"subdistrictId"];
    [dict setPObject:shopIdStr forKey:@"shopId"];
    [dict setPObject:textAddressDetail.text forKey:@"address"];
    if (shopBigImg.image) {
        NSData *shopImageData = UIImageJPEGRepresentation(shopBigImg.image, 1.0);
        [dict setObject:shopImageData forKey:@"banners"];
    }
    [dict setPObject:[NSString jsonStringWithArray:[self pinJieServiceScope:serviceArry :shopIdStr]] forKey:@"serviceVillage"];
//    [dict setPObject:[self crapPicData] forKey:@"pics"];
    AppDelegate *app = (AppDelegate *)[UIApplication sharedApplication].delegate;
    [Utility showMBProgress:self.view.window message:@"提交修改"];
    [manager POSTManyAndShopImagePhotoImage:kEditShop parameters:dict queue:nil success:^(id responseObject) {
        [Utility hideMBProgress:self.view.window];
        [Utility showToastWithMessage:@"提交成功" inView:app.window];
        [self.navigationController popViewControllerAnimated:YES];
        NSLog(@"submit sucess");
    }failure:^(NSString *error) {
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
        HWPhoto *temp = [imageScrollView.imageArray objectAtIndex:i];
        if (!temp.photoUrl) {
            [addPhotoArry addObject:temp.localPhotoImage];
            UIImage *avatarImage = temp.localPhotoImage;
            NSData *avatarImageData = UIImageJPEGRepresentation(avatarImage, 1.0);
            [picArryS addObject:avatarImageData];
        }
        
    }
    return picArryS;
}
#pragma mark - 删除图片请求
//删除图片请求
-(void)deleLocalOnePic:(NSInteger)Deleteindex
{
    NSMutableArray *testArry = [NSMutableArray arrayWithArray:imageScrollView.imageArray];
//    for (int j= 0; j<[testArry count]; j++) {
        HWPhoto *temp = [[HWPhoto alloc]init];
//    NSInteger length = [testArry count];
//        temp = [testArry objectAtIndex:j];
//        NSLog(@"%@,%@",temp.photoUrl,temp.photoKey);
//    }
//    NSLog(@"%@",[[imageScrollView.imageArray objectAtIndex:Deleteindex]photoUrl]);
    NSLog(@"%i",Deleteindex);
    temp = [testArry objectAtIndex:Deleteindex];
    if (temp.photoUrl) {
        [self deleteOnePhoto:temp.photoKey index:Deleteindex];
    }

}


- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
