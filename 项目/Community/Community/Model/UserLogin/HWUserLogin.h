//
//  HWUserLogin.h
//  Community
//
//  Created by caijingpeng.haowu on 14-8-27.
//  Copyright (c) 2014年 caijingpeng. All rights reserved.
//
//  当前登录用户 单例 类    保存当前用户基本信息
//

#import <Foundation/Foundation.h>
#import "HWCityClass.h"
#import "HWUser.h"
#import <CoreLocation/CoreLocation.h>
#import <CoreLocation/CLLocationManagerDelegate.h>
#import "HWAlertModel.h"

#define kHWKeychainServiceName    @"haowu_last_login"
#define kHWKeychainAccount        @"haowu_account"
#define kHWKeychainPassword       @"haowu_password"

@interface HWUserLogin : NSObject<CLLocationManagerDelegate>

/*Swift中的属性（Properties），就类似于其他面向对象语言中的成员变量
 
 （1）存储属性:存储属性就是存储在对象（实例）中的一个变量或者常量
 
 （2）计算属性:延迟存储属性是第一次使用时才进行初始化的属性
 
   延迟存储属性的使用注意：延迟存储属性必须是变量，不能是常量
 
   延迟存储属性的好处：让某些资源用到时再去加载，避免一些不必要的资源浪费
 
 （3）类型属性:跟存储属性不一样的是，计算属性不是直接存储值，而是提供get和set
 
    get：用来取值，封装取值的过程
 
    set：用来设值，封装设值的过程
 
*/
/*
 字符串属性描述:
 var username: NSString = ""
 @IBOutlet weak var username:   NSString!
 @IBOutlet weak var password:   NSString!
 @IBOutlet weak var sessionKey:   NSString!
 @IBOutlet weak var avatar:   NSString!
 @IBOutlet weak var gender:   NSString!
 @IBOutlet weak var favorite:   NSString!
 @IBOutlet weak var key:   NSString!
 @IBOutlet weak var cityId:   NSString!
 @IBOutlet weak var cityName:   NSString!
 @IBOutlet weak var villageId:   NSString!
 @IBOutlet weak var villageName:   NSString!
 @IBOutlet weak var villageAddress:   NSString!
 @IBOutlet weak var tenementId:   NSString!
 @IBOutlet weak var shopId:   NSString!
 @IBOutlet weak var areaId:   NSString!
 @IBOutlet weak var telephoneNum:   NSString!
 @IBOutlet weak var totalMoney:   NSString!
 @IBOutlet weak var dataVersion:   NSString!
 @IBOutlet weak var userId:   NSString!
 @IBOutlet weak var residendId:   NSString!
 @IBOutlet weak var address:   NSString!
 @IBOutlet weak var gpsCityName:   NSString!

 @IBOutlet weak var gpsCityId:   NSString!
 @IBOutlet weak var notificationOnOrOff:   NSString!
 @IBOutlet weak var acceptNotify:   NSString!
 @IBOutlet weak var propertyNotify:   NSString!
 @IBOutlet weak var shopNotify:   NSString!
 @IBOutlet weak var shakeNotify:   NSString!
 @IBOutlet weak var changeCity:   NSString!
 @IBOutlet weak var saveFrontGpsCityIdStr:   NSString!
 @IBOutlet weak var isSettingPayPasswardFlag:   NSString!
 @IBOutlet weak var openId:   NSString!
 @IBOutlet weak var weixinNickname:   NSString!
 @IBOutlet weak var isBindMobile:   NSString!
 @IBOutlet weak var isBindWeixin:   NSString!
 数组
 @IBOutlet weak var cities:   NSMutableArray!
 @IBOutlet weak var hotArry:   NSMutableArray!
 float属性描述:
   var latitude: Float = 0.0
 weak var latitude:   Float!
 weak var longitude:   Float!
 int属性描述:
   var age: Int = 1
 double属性描述:
   var height: Double = 0.0
 bool属性描述:
    var ss :Bool = true
   var locationFailureFlag:   Bool!
 UIImageView属性描述:
    var shopAvatar: UIImageView!
 @IBOutlet  weak var shopAvatar:   UIImageView!
  UIImage属性描述:
     var image: UIImage!
 @IBOutlet  weak var headImage:   UIImage!
 类的描述不需要导入头文件 属性描述:
     var currentCity: HWCityClass!
      @IBOutlet  weak var currentCity:   HWCityClass!
      @IBOutlet  weak var manager:   CLLocationManager!
*/

@property (nonatomic, strong) NSString *username;               //用户名称
@property (nonatomic, strong) NSString *password;               //用户密码
@property (nonatomic, strong) NSString *sessionKey;
@property (nonatomic, strong) NSString *avatar;                 //头像
@property (nonatomic, strong) NSString *nickname;               //用户昵称
@property (nonatomic, strong) NSString *gender;                 //性别
@property (nonatomic, strong) NSString *favorite;               //爱好
@property (nonatomic, strong) NSString *key;                    //用户Key
@property (nonatomic, retain) NSString *cityId;                 //城市ID
@property (nonatomic, strong) NSString *cityName;               //城市名字
@property (nonatomic, retain) NSString *villageId;              //小区ID
@property (nonatomic, retain) NSString *villageName;            //小区名称
@property (nonatomic, retain) NSString *villageAddress;         //小区地址
@property (nonatomic, retain) NSString *tenementId;
@property (nonatomic, retain) NSString *shopId;                 //商铺ID
@property (nonatomic, strong) UIImageView *shopAvatar;          //商铺照片
@property (nonatomic, assign) float latitude;                   //用户经度
@property (nonatomic, assign) float longitude;                  //用户维度
@property (nonatomic, strong) NSString *areaId;
@property (nonatomic, strong) NSString *telephoneNum;           //电话号码
@property (nonatomic, strong) NSString *totalMoney;
@property (nonatomic, strong) NSString *dataVersion;            //版本号
@property (nonatomic, strong) NSString *userId;                 //用户ID
@property (nonatomic, strong) NSString *residendId;
@property (nonatomic, strong) NSString *address;                //用户地址
@property (nonatomic, strong) NSMutableArray *hotArry;          //热门城市
@property (nonatomic, strong) NSString *gpsCityName;            //定位城市名称
@property (nonatomic, strong) NSString *gpsCityId;              //定位城市ID
@property (nonatomic, strong) NSString *notificationOnOrOff;    //应用的通知开还是关，开-1
@property (nonatomic, strong)  NSMutableArray *cities;
@property (nonatomic, strong) HWCityClass *currentCity;
@property (strong, nonatomic) CLLocationManager *manager;
@property (nonatomic, strong) NSString *acceptNotify;
@property (nonatomic, strong) NSString *propertyNotify;
@property (nonatomic, strong) NSString *shopNotify;
@property (nonatomic, strong) NSString *soundNotify;
@property (nonatomic, strong) NSString *shakeNotify;
@property (nonatomic, assign) BOOL locationFailureFlag;         //yes代表第一次定位失败，no代表不是第一次定位
@property (nonatomic, strong) NSString *changeCity;             //记录记忆城市
@property (nonatomic, strong) NSString *saveFrontGpsCityIdStr;  //保存上一次定位城市的Cityid
@property (nonatomic, strong) NSString *isSettingPayPasswardFlag;   //1代表已经设置0代表未设置
@property (nonatomic, strong) NSString *openId;
@property (nonatomic, strong) NSString *weixinNickname;
@property (nonatomic, strong) NSString *isBindMobile;
@property (nonatomic, strong) NSString *isBindWeixin;
@property (nonatomic, strong) UIImage *headImage;               //用户头像
@property (nonatomic, strong) NSString *deviceId;
@property (nonatomic, strong) NSString *coStatus; //用户是否在物业合作小区 0是 1不是
@property (nonatomic, strong) NSString *isAuth;     //用户是否在当前小区认证 0认证 1非认证
@property (nonatomic, strong) NSString *source;      //来源(用户来源：0，考拉社区APP注册；1，抢钱宝同步过来的；2，微信；3，游客)

@property (nonatomic, assign) BOOL isLoginToWeiXin; //用于触发登录后判断是否是选择的微信登录，若是则返回不跳转

@property (nonatomic, strong) NSMutableArray *alertTimeArray;  // 提醒时间 数组

/*

 Swift中的方法可以分为2大类：
 
 （1）实例方法（Instance Methods）
 
 　　在OC中，实例方法以减号（-）开头
 
 实例方法：就是只能用对象实例调用的方法，也可以称为“对象方法”
 
 实例方法的语法跟函数基本一样
 
 （2）类型方法（Type Methods）
 
 　　在OC中，类型方法以加号（+）开头
    被关键字class修饰的方法，也可以称为“类方法”
 
 在类名后面加小括号来创建类的实例化，使用.（点号连接符）来访问实例的方法和属性：
 
*/


+ (HWUserLogin *)currentUserLogin;

// 验证是否绑定过手机号
+ (BOOL)verifyBindMobileWithPopVC:(UIViewController *)viewController showAlert:(BOOL)isShow;

// 验证是否认证
+ (BOOL)verifyIsAuthenticationWithPopVC:(UIViewController *)viewController showAlert:(BOOL)isShow;

// 验证是否登录
+ (BOOL)verifyIsLoginWithPresentVC:(UIViewController *)viewController toViewController:(UIViewController *)toViewController;

// 注销
- (void)userLogout;

- (BOOL)getLastLogin;
- (void)updateLastLogin;

//初始化userLogin数据
-(void)initUserLogin:(NSDictionary *)user;
- (void)startLocating;

- (void)handleLoginInfo:(NSDictionary *)dataDic operationController:(UIViewController *)ctrl;

//获得用户头像
- (void)getUserPhotoImage:(NSString *)avatarUrlStr;

- (void)registSucceed;

//本地推送相关
- (void)loadUserAlertTime;
- (void)saveUserAlertTime:(HWAlertModel *)model;
- (void)removeAlertItemById:(NSString *)goodsId;
+ (BOOL)isExistAlertByGoodsId:(NSString *)goodsId;  // 判断是否存在提醒

@end
