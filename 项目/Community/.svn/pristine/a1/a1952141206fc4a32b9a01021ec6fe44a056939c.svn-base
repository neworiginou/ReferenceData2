//
//  Define.h
//  Community
//
//  Created by caijingpeng.haowu on 14-8-27.
//  Copyright (c) 2014年 caijingpeng. All rights reserved.
//  修改记录
//      李中强 2015-01-16 14:25:08 添加颜色备注
//      陆晓波 2015-01-19 11:22:00 添加12号字体

#ifndef Community_Define_h
#define Community_Define_h


#define SHARED_APP_DELEGATE             (AppDelegate *)[UIApplication sharedApplication].delegate
#define UIColorFromRGB(rgbValue)	    [UIColor colorWithRed:((float)((rgbValue & 0xFF0000) >> 16))/255.0 green:((float)((rgbValue & 0xFF00) >> 8))/255.0 blue:((float)(rgbValue & 0xFF))/255.0 alpha:1.0]

#define UIColorFromRGBA(rgbValue,a)	    [UIColor colorWithRed:((float)((rgbValue & 0xFF0000) >> 16))/255.0 green:((float)((rgbValue & 0xFF00) >> 8))/255.0 blue:((float)(rgbValue & 0xFF))/255.0 alpha:a]
#define DocumentPath                    [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) objectAtIndex:0]

#define IOS7                            ([[[UIDevice currentDevice] systemVersion] floatValue] >= 7.0 ? YES : NO)
#define IOS7Dot0                        ([[[UIDevice currentDevice] systemVersion] floatValue] == 7.0 ? YES : NO)
#define IOS8                            ([[[UIDevice currentDevice] systemVersion] floatValue] >= 8.0 ? YES : NO)
#define IPHONE4                         ([UIScreen instancesRespondToSelector:@selector(currentMode)] ? CGSizeEqualToSize(CGSizeMake(640, 960), [[UIScreen mainScreen] currentMode].size) : NO)
#define IPHONE5                         ([UIScreen instancesRespondToSelector:@selector(currentMode)] ? CGSizeEqualToSize(CGSizeMake(640, 1136), [[UIScreen mainScreen] currentMode].size) : NO)
#define IPHONE6                         ([UIScreen instancesRespondToSelector:@selector(currentMode)] ? CGSizeEqualToSize(CGSizeMake(750, 1334), [[UIScreen mainScreen] currentMode].size) : NO)
#define IPHONE6PLUS                         ([UIScreen instancesRespondToSelector:@selector(currentMode)] ? CGSizeEqualToSize(CGSizeMake(1242, 2208), [[UIScreen mainScreen] currentMode].size) : NO)
#define kScreenRate                     ([UIScreen mainScreen].bounds.size.width / 320.0f) // 屏幕比例

// ******   样式

#define CONTENT_HEIGHT                  ([UIScreen mainScreen].bounds.size.height - 64)
#define FONTNAME                        @"Helvetica Neue"
#define kScreenWidth                    [UIScreen mainScreen].bounds.size.width
#define kScreecHeight                   [UIScreen mainScreen].bounds.size.height
#define THEME_COLOR_ORANGE              UIColorFromRGB(0x8ACF1C)            // 主色调 绿色
#define THEME_COLOR_BLUE                UIColorFromRGB(0x7bbcff) 
#define THEME_COLOR_LINE                UIColorFromRGB(0xdddddd)            //线条颜色
#define THEME_COLOR_TEXT                UIColorFromRGB(0x999999)            //浅灰
#define THEME_COLOR_GRAY_MIDDLE         UIColorFromRGB(0x666666)            //中灰  666666
#define THEME_COLOR_SMOKE               UIColorFromRGB(0x333333)            //深灰  333333
#define THEME_COLOR_TEXTBACKGROUND      UIColorFromRGB(0xf2f2f2)            //灰色背景颜色
#define THEME_COLOR_White               UIColorFromRGB(0xffffff)            //白色字体
#define THEME_COLOR_CELLCOLOR           UIColorFromRGB(0xffffff)            //白色
#define THEME_COLOR_BUTTON_INACTIVE     UIColorFromRGB(0xcdcdcd)
#define THEME_COLOR_ORANGE_HIGHLIGHT    UIColorFromRGB(0x77b218)            //绿色层（深）
#define THEME_COLOR_ORANGE_light        UIColorFromRGB(0xeffddc)            //主色调浅一点
#define THEME_COLOR_GRAY_HIGHLIGHT      UIColorFromRGB(0x747474)
#define THEME_COLOR_GRAY_HEADBACK       UIColorFromRGB(0xf0f0f0)
#define THEME_COLOR_GREEN               UIColorFromRGB(0x39c5b1)
#define THEME_COLOR_RED                 UIColorFromRGB(0xe25c5f)
#define THEME_COLOR_GRAY                UIColorFromRGB(0x848a93)
#define THEME_COLOR_PINK                UIColorFromRGB(0xfff3eb)
#define BUTTON_COLOR_GRAY               UIColorFromRGB(0xc7c7c7)            // 圆角灰色
#define BUTTON_COLOR_LIGHTGRAY          UIColorFromRGB(0xcccccc)            //社区V1.3验证码按钮颜色


#define BACKGROUND_COLOR                UIColorFromRGB(0xF2F2F2)
#define THEME_COLOR_MONEY               UIColorFromRGB(0xFF6C00)

#define Neighbour_Bottom                UIColorFromRGB(0xdddddd)
#define TITLE_BIG_SIZE                  19.0f                                       // 大标题
#define THEME_FONT_SMALLTITLE           16.0f                                       //小标题文字
#define THEME_FONT_BIG                  15.0f                                       //大字号
#define THEME_FONT_SMALL                14.0f                                       //小字号
#define THEME_FONT_SMALL13              13.0f    
#define THEME_FONT_SMALL12              12.0f
#define THEME_FONT_SUPERSMALL           11.0f                                       //超级小字号
//#define THEME_FONT_SMALL12              12.0f                                       //小字
#define FONT(fontsize)                  [UIFont fontWithName:@"Helvetica Neue" size:fontsize]



//邻里圈随机颜色
#define RANDGreen                       UIColorFromRGB(0xafd96b)     //绿色层（浅）
#define RANDOrange                      UIColorFromRGB(0xf1a851)
#define RANDBlue                        UIColorFromRGB(0x64b2d6)
#define RANDPink                        UIColorFromRGB(0xf291c6)
#define RANDPurple                      UIColorFromRGB(0xb88bc7)
#define RANDGreen2                      UIColorFromRGB(0x6abfbc)

// ******* 按钮色 ********
#define THEBUTTON_GRAY_NORMAL           UIColorFromRGB(0x858585)        //灰色未点击
#define THEBUTTON_GRAY_HIGHLIGHT        UIColorFromRGB(0x747474)        //灰色已点击
#define THEBUTTON_GREEN_NORMAL          UIColorFromRGB(0x8acf1c)        //绿色未点击
#define THEBUTTON_GREEN_HIGHLIGHT       UIColorFromRGB(0x77b218)        //绿色已点击
#define THEBUTTON_BLUE_NORMAL           UIColorFromRGB(0x02b2ac)        //浅蓝未点击
#define THEBUTTON_BLUE_HIGHLIGHT        UIColorFromRGB(0x039c98)        //浅蓝已点击
#define THEBUTTON_RED_NORMAL            UIColorFromRGB(0xe45b5c)        //红色未点击
#define THEBUTTON_RED_HIGHLIGHT         UIColorFromRGB(0xca3b3c)        //红色已点击
#define THEBUTTON_YELLOW_NORMAL         UIColorFromRGB(0xffd200)        //黄色未点击
#define THEBUTTON_YELLOW_HIGHLIGHT      UIColorFromRGB(0xebc200)        //黄色已点击

#define THE_COLOR_RED                   UIColorFromRGB(0xff6600)        //红色
#define THE_COLOR_RED_FE                UIColorFromRGB(0xfe0000)        //红色

// ******  user default   **********

#define kFirstGetMoney                  @"firstGetMoney"        // 在金额达到100时提示一次是否立即提现
#define kHaveDialing                    @"haveDialing"          // 是否有拨打过的电话 没发通知
#define kFirstRent                      @"firstRents"           // 首次 租赁
#define kFirstCheckTouchID              @"checkTouchID"         // 验证touchid  和用户绑定
#define kAgreeProtocol                  @"agreeProtocal"        // 同意协议  每个账号首次进入无底线
#define kFirstLaunch                    @"firstLaunch1.7.0"          // 首次启动
#define kGuideStep                      @"guideStep"            // 新手及游客引导 步骤
#define KshowRedPoint                   @"showRedPoint"         // 新手及游客显示绑定手机红点
#define kAuthBuildingNo                 @"kAuthBuildingNo"      // 门牌认证 楼栋号
#define kAuthUnitNo                     @"kAuthUnitNo"          // 门牌认证 单元号
#define kAuthRoomNo                     @"kAuthRoomNo"          // 门牌认证 房间号
#define kAuthApplyId                    @"kAuthApplyId"         // 门牌认证 认证id
#define KLastSMSDate                    @"lastSMSDate"          //上一次发送短信时间

// ******  预设

#define DEFAULTSHARECONTENT             @"和我一起做一只懒懒的考拉 你的朋友邀请你一起玩考拉社区"
#define SHARE_TITLE                     @"和我一起做一只懒懒的考拉"
#define SHARE_CONTENT                   @"邀请你一起玩考拉社区"
#define SHARE_TEXT                      @"考拉社区"
#define ShARE_DESCRIPTION               @""
#define CURUPDATE_TAG                   333
#define pLocatedCityChanged             @"cityChange"
#define APP_DOWNLOAD_URL                @"**************************************"
#define LOADING_TEXT                    @"发送数据"
#define CROP_HEIGHT                     kScreenWidth * 0.67f
#define RECORD_MAX_TIME                 (1 * 60)            // 1分钟
#define RECORD_MIN_TIME                 2                   // 2秒
#define APP_CHECKUPDATE                 @"http://itunes.apple.com/lookup?id=921449753"
#define ITUNSE_DOWNLOAD_URL             @"https://itunes.apple.com/us/app/hao-wu-zhong-guo/id921449753?mt=8&uo=4"

#define REQUEST_APPKEY                  @"kaola"
#define REQUEST_SECRET                  @"1413440105815511746"
#define APPLEID                         @"921449753"

#define IMAGE_PLACE                     @"placeImage"
#define IMAGE_BREAK_CUBE                @"picture_break_cube"
#define IMAGE_DEFAULT_COLOR             UIColorFromRGB(0xececec)

// ***   第三方  key

#define UMENG_APP_KEY                   @"5406edc1fd98c589cf005300"
#define WECHAT_KEY                      @"wx957310cb04aee1be"
#define WECHAT_SECRET                   @"c27e678ed6f7263b6c29aec527335c65"
#define QZONE_APPID                     @"1102968215"
#define QZONE_APPKEY                    @"zdmD0aAtpAhEoNLy"

// *****

#define kPickerWidth 300
#define kPickerHeight 80
#define kShopManageSectionOneHeight 125
#define kJianJu  12

#define ksearchArr     @"historyArr"


// *******  通知 key

#define HWAudioDownloaderFinishedNotification           @"HWAudioDownloaderFinishedNotification"
#define HWAudioDownloaderFailedNotification             @"HWAudioDownloaderFailedNotification"
#define HWAudioDownloaderDownloadindNotification        @"HWAudioDownloaderDownloadindNotification"
#define HWAudioPlayCenterStartPlayNotification          @"HWAudioPlayCenterStartPlayNotification"
#define HWAudioPlayCenterPausePlayNotification          @"HWAudioPlayCenterPausePlayNotification"
#define HWAudioPlayCenterStopPlayNotification           @"HWAudioPlayCenterStopPlayNotification"
#define RELOAD_APP_DATA                                 @"ReloadApplicationDataNotification"
#define CutAgainNotification                            @"CutAgainNotification"

#define RELOAD_PRIVILEDGELIST                           @"ReloadPriviledgeList"
#define RELOAD_MONEYView                                @"ReloadMoneyAndKaoLaCoin"
#define RELOAD_ORDER                                    @"RELOADoRDER"
#define kRefreshNeighbour                               @"refreshList"
#define PAY_SUCCESS                                     @"pay_success"


//赞
#define HWLikeNotification                              @"HWLikeNotification"
//评论
#define HWCommontNotification                           @"HWCommontNotification"


//话题赞
#define HWCHannelLikeNotification                       @"HWCHannelLikeNotification"
//话题评论
#define HWChannelCommontNotification                    @"HWChannelCommontNotification"
//发布完成后发通知
#define HWNeighbourDragRefresh                          @"HWNeighbourDragRefresh"
#define InitialGuideViewAfterPublish                    @"initialGuideViewAfterPublish"
//本地通知
#define HWAlertItemNotification                         @"cutAlertNoti"


#endif


//服务类别枚举
typedef  enum
{
    SHOP = 0,
    DINNER,
    FRUITE,
    WASHING,
    HOMEMAKING,
    LOCK,
    EXPRESS,
    HARDWARE,
    FOOD,
    WATERCAR,
    MOVEHOUSE,
    SENDERWATER,
    BEAUTIFUL,
    COLLECTSCRAP,
    PIPLE,
    HOUSEHOLD,
    OTHER
} SERVICECATAORY;


// 播放状态  加载  播放  停止
typedef enum
{
    StopPlayMode = 0,
    PlayingPlayMode,
    PausePlayMode,
    DownloadingPlayMode
}PlayMode;

//邻里圈 or 话题 进入详情
typedef enum{
    detailResourceNeighbour = 0,
    detailResourceChannel
}detailResource;
