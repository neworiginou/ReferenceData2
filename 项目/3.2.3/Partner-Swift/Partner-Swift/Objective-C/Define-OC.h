//
//  Define-OC.h
//  Partner-Swift
//
//  Created by caijingpeng.haowu on 15/2/11.
//  Copyright (c) 2015年 caijingpeng.haowu. All rights reserved.
//

#ifndef Partner_Swift_Define_OC_h
#define Partner_Swift_Define_OC_h

#define UIColorFromRGB(rgbValue)	    [UIColor colorWithRed:((float)((rgbValue & 0xFF0000) >> 16))/255.0 green:((float)((rgbValue & 0xFF00) >> 8))/255.0 blue:((float)(rgbValue & 0xFF))/255.0 alpha:1.0]

#define FONTNAME                            @"Helvetica Neue"
#define LOADING_TEXT                        @"请求数据"

#define TITLE_COLOR_33                      UIColorFromRGB(0x333333)
#define TITLE_COLOR_66                      UIColorFromRGB(0x666666)
#define TITLE_COLOR_99                      UIColorFromRGB(0x999999)
#define THEME_COLOR_ORANGE_NORMAL           UIColorFromRGB(0xf89e00)
#define THEME_COLOR_RED_NORMAL              UIColorFromRGB(0xff6600)
#define THEME_COLOR_BACKGROUND_2            UIColorFromRGB(0x999999)
#define THEME_COLOR_GREEN_NORMAL            UIColorFromRGB(0x999999)
#define CD_BackGroundColor                  UIColorFromRGB(0xf5f5f5)
#define CD_LineColor                        UIColorFromRGB(0xd7d7d7)
#define CD_MainColor                        UIColorFromRGB(0xff6600)
#define THEME_COLOR_LINE                    UIColorFromRGB(0xd6d6d6)       // 线条颜色
#define CD_Btn_GrayColor                    UIColorFromRGB(0x999999)
#define CD_Btn_GrayColor_Clicked            UIColorFromRGB(0x878787)
#define CD_Btn_MainColor                    UIColorFromRGB(0xff6600)
#define CD_Btn_MainColor_Clicked            UIColorFromRGB(0xe85700)
#define CD_RedPaperColor            UIColorFromRGB(0xe52b14)//刮红包的背景色

#define THEME_COLOR_BACKGROUND_1            UIColorFromRGB(0xeaeaea)       // 主背景色
#define TITLE_COLOR_99                      UIColorFromRGB(0x999999)


#define IOS7                                ([[[UIDevice currentDevice] systemVersion] floatValue] >= 7.0 ? YES : NO)
#define kPageCount      10
#define kScreenWidth                    [UIScreen mainScreen].bounds.size.width
#define IOS8                            ([[[UIDevice currentDevice] systemVersion] floatValue] >= 8.0 ? YES : NO)


typedef enum{
    
    LogicLine_GetMoney = 1, // 点击提现-->提示绑定-->提示设置提现密码-->设置提现密码-->绑定银行卡-->提现
    LogicLine_BindCard = 2,  // 点击绑定银行卡-->提示验证提现密码-->验证-->绑定银行卡
    LoginLine_UnBindCard = 3  // 解绑银行卡
    
}LogicLine;

#define IPHONE4                         ([UIScreen instancesRespondToSelector:@selector(currentMode)] ? CGSizeEqualToSize(CGSizeMake(640, 960), [[UIScreen mainScreen] currentMode].size) : NO)
#define IPHONE5                         ([UIScreen instancesRespondToSelector:@selector(currentMode)] ? CGSizeEqualToSize(CGSizeMake(640, 1136), [[UIScreen mainScreen] currentMode].size) : NO)
#define IPHONE6                         ([UIScreen instancesRespondToSelector:@selector(currentMode)] ? CGSizeEqualToSize(CGSizeMake(750, 1334), [[UIScreen mainScreen] currentMode].size) : NO)
#define IPHONE6PLUS                         ([UIScreen instancesRespondToSelector:@selector(currentMode)] ? CGSizeEqualToSize(CGSizeMake(1242, 2208), [[UIScreen mainScreen] currentMode].size) : NO)
#define IPHONE6PLUSFangda               ([UIScreen instancesRespondToSelector:@selector(currentMode)] ? CGSizeEqualToSize(CGSizeMake(1125, 2001), [[UIScreen mainScreen] currentMode].size) : NO)
#define CONTENT_HEIGHT                  ([UIScreen mainScreen].bounds.size.height - 64)

#define TITLE_ZHENGWEN_SIZE                 15                             // 正文文字
#define TITLE_FUBIAOTI_SIZE                 13                             // 副标题
#define kScreenReverseRate0C  [UIScreen mainScreen].bounds.size.width / 375.0//相对于6屏幕尺寸的比例
#define kIphone6RateOC        1920/1136.0
#define TITLE_SMALL_SIZE_2                  14                             // 小标题，切换兰


//接口    我的钱包
#define kBindValidate                   @"/partner-mobile-app/bank/bindCreditCardValidate.do"               // 申请提现前是否绑定银行卡校验 V
#define kCheckMoneyPassword             @"/partner-mobile-app/withdraw/validateWithdrawPasswd.do"           // 验证提现密码 V
#define kSetNewMoneyPassword            @"/partner-mobile-app/withdraw/setWithdrawPasswd.do"                // 设置新提现密码 V
#define kCheckLoginPassword             @"/partner-mobile-app/withdraw/validateLoginPasswd.do"              // 验证登录密码 V
#define kTiyong                         @"/partner-mobile-app/withdraw/applyWithdraw.do"                            //提佣操作
#define kDeleteCard                     @"/partner-mobile-app/bank/unBindCreditCard.do"                     //银行卡解除绑定 V
#define kMyYongjin                      @"/partner-mobile-app/wallets/dealList.do"                       //我的佣金列表  V
#define kGetNewRed                      @"/partner-mobile-app/app6/activity/newRedNum.do"
#define kAddCreditCardValidate          @"/partner-mobile-app/bank/addCreditCardValidate.do"                //添加银行卡前需要提取密码的校验 V
#define kRecordDetail                   @"/partner-mobile-app/wallets/dealDetail.do"                      // 返现详情
//#define kGetRedPocketList               @"/hoss-society/app5/activity/myRedPackage.do"                      //获取红包列表
//#define kOpenRedPackage                 @"/hoss-society/app5/activity/openRedPackage.do"                    //打开红包
#define kGetLastPay                     @"/partner-mobile-app/withdraw/getLastApplayTime.do"                //最后（上次）提佣时间 V
#define kCreditCardList                 @"/partner-mobile-app/bank/getCreditCardList.do"                    //银行卡列表 V
#define kSetDefaultCreditCard           @"/partner-mobile-app/bank/setDefaultCreditCard.do"                 //设置默认银行卡号 V
#define AddCardID_V4                    @"/partner-mobile-app/bank/addCreditCard.do"                        //添加银行卡 V
#define GetBankList                     @"/partner-mobile-app/bank/getBankList.do"                          //获取银行列表 V
#define GetProvinceList                 @"/partner-mobile-app/bank/province.do"                              //省份
#define GetCityList                     @"/partner-mobile-app/bank/citybyprovince.do"                        //城市
#define GetProvinceAndCity              @"/partner-mobile-app/city/findAllCity.do"                          //3.0新版省+城市
                                        //申请提现  是否设置提现密码 
#define OpenRedPocket                   @"/partner-mobile-app/app6/activity/openRedPackage.do"
//#define kDelRedPackage                  @"/hoss-society/app5/activity/delRedPackage.do"          //删除红包
//#define kActiveList                     @"/hoss-society/app5/activity/getActivities.do" //活动列表   // 首页推广活动列表
//#define kShareBefore                    @"/hoss-society/app5/activity/beforeShare.do" //分享前判断是否有返现
//#define kShareSuccess                   @"/hoss-society/app5/activity/sucessShare.do"//分享成功回调
//#define kGetShareContent                @"/hoss-society/app5/activity/activityContent.do"
//#define kHouseDetail                    @"/hoss-society/app5/activity/getNewHousesDetail.do"         //楼盘详情
//#define kNewRedNumber                   @"/hoss-society/app5/activity/newRedNum.do"

#endif
