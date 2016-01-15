//
//  Utility.m
//  Community
//
//  Created by caijingpeng.haowu on 14-8-27.
//  Copyright (c) 2014年 caijingpeng. All rights reserved.
//

#import "Utility.h"
#import "MBProgressHUD.h"
#import "SSKeychain.h"
#import "LoadingView.h"
#import <AudioToolbox/AudioToolbox.h>
#include <sys/sysctl.h>
#include <net/if.h>
#include <net/if_dl.h>
#import <AdSupport/AdSupport.h>
#import "RightButton.h"
#import "Base64.h"
#import "WXApi.h"
#import <TencentOpenAPI/QQApi.h>


@implementation Utility
/**
 *	@brief	获取字符串字数   汉字算两个字 英文算一个字
 *
 *	@param 	text 	内容
 *
 *	@return	字数
 */
+ (int)calculateTextLength:(NSString *)text
{
    float number = 0.0;
    for (int index = 0; index < [text length]; index++)
    {
        NSString *character = [text substringWithRange:NSMakeRange(index, 1)];
        if ([character lengthOfBytesUsingEncoding:NSUTF8StringEncoding] == 3)
        {
            number += 1;
        }
        else
        {
            number += 0.5f;
        }
    }
    return number;
}

/**
 *	@brief	计算两点经纬度间距离
 *
 *	@param 	coordinate1 	经纬度
 *	@param 	coordinate2 	经纬度
 *
 *	@return	距离
 */
+ (int)calculateDistanceCoordinateFrom:(CLLocationCoordinate2D)coordinate1 to:(CLLocationCoordinate2D)coordinate2
{
    return 0;
}

/**
 *	@brief	校验手机号码
 *
 *	@param 	mobileNum 	手机号
 *
 *	@return	是否正确
 */
+ (BOOL)validateMobile:(NSString *)mobileNum
{
//    /**
//     * 手机号码
//     * 移动：134[0-8],135,136,137,138,139,150,151,157,158,159,182,187,188
//     * 联通：130,131,132,152,155,156,185,186
//     * 电信：133,1349,153,180,189
//     */
////    NSString * MOBILE = @"^1(7[0-9]|4[0-9]|3[0-9]|5[0-35-9]|8[0-9])\\d{8}$";
//    /**
//     10         * 中国移动：China Mobile
//     11         * 134、135、136、137、138、139、147、150、151、152、157、158、159、182、183、187、188
//     12         */
//    NSString * CM = @"^1(34|3[5-9]|47|5[0127-9]|8[2378])\\d{8}$";
//    /**
//     15         * 中国联通：China Unicom
//     16         * 130、131、132、155、156、185、186、145
//     17         */
//    NSString * CU = @"^1(3[0-2]|45|5[56]|8[56])\\d{8}$";
//    /**
//     20         * 中国电信：China Telecom
//     21         * 133、153、180、189、177
//     22         */
//    NSString * CT = @"^1(33|53|77|8[09])\\d{8}$";
//    /**
//     25         * 大陆地区固话及小灵通
//     26         * 区号：010,020,021,022,023,024,025,027,028,029
//     27         * 号码：七位或八位
//     28         */
//    // NSString * PHS = @"^0(10|2[0-5789]|\\d{3})\\d{7,8}$";
//    
//    NSPredicate *regextestcm = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", CM];
//    NSPredicate *regextestcu = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", CU];
//    NSPredicate *regextestct = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", CT];
//    
//    if (([regextestcm evaluateWithObject:mobileNum] == YES)
//        || ([regextestct evaluateWithObject:mobileNum] == YES)
//        || ([regextestcu evaluateWithObject:mobileNum] == YES))
//    {
//        return YES;
//    }
//    else
//    {
//        return NO;
//    }
    //add lzq 2014年10月30日15:28:23 添加新的手机号判断
    
    
    
    if (mobileNum.length == 11)
    {
        NSString *strFirstNum = [[mobileNum substringFromIndex:0] substringToIndex:1];
        if ([strFirstNum isEqualToString:@"1"])
        {
            return YES;
        }
        return NO;
    }
    else
        return NO;
    
}

//判断固话
+ (BOOL)validatePhoneTel:(NSString *)phoneNum
{
    /**
     25         * 大陆地区固话及小灵通
     26         * 区号：010,020,021,022,023,024,025,027,028,029
     27         * 号码：七位或八位
     28         */
    //021-12345678  0394-12345678
    
    //先判断位数
    if (phoneNum.length == 11 || phoneNum.length == 12 || phoneNum.length == 13)
    {
        NSString *strLine = @"-";
        NSString *str1 = [[phoneNum substringFromIndex:2] substringToIndex:1];
        NSString *str2 = [[phoneNum substringFromIndex:3] substringToIndex:1];
        NSLog(@"str1 = %@\n str2 = %@",str1,str2);
        if ([str1 isEqualToString:strLine] || [str2 isEqualToString:strLine])
        {
            return YES;
        }
        else
        {
            return NO;
        }
    }
    else
    {
        return NO;
    }
    
//    NSString * PHS = @"^0(10|2[0-5789]|\\d{3})\\d{7,8}$";
//    NSPredicate *regextestphs = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", PHS];
//    if ([regextestphs evaluateWithObject:phoneNum] == YES)
//    {
//        return YES;
//    }
//    else
//    {
//        return NO;
//    }
}

/**
 *	@brief	判断手机号前三位 是否正确
 *
 *	@param 	mobileNum 	手机号
 *
 *	@return	bool
 */
+ (BOOL)validateMobileWithFirstThree:(NSString *)mobileNum
{
    /**
     10         * 中国移动：China Mobile
     11         * 134、135、136、137、138、139、147、150、151、152、157、158、159、182、183、187、188
     12         */
    NSString * CM = @"^1(34|3[5-9]|47|5[0127-9]|8[2378])\\d{0,}$";
    /**
     15         * 中国联通：China Unicom
     16         * 130、131、132、155、156、185、186、145
     17         */
    NSString * CU = @"^1(3[0-2]|45|5[56]|8[56])\\d{0,}$";
    /**
     20         * 中国电信：China Telecom
     21         * 133、153、180、189、177
     22         */
    NSString * CT = @"^1(33|53|77|8[09])\\d{0,}$";
    /**
     25         * 大陆地区固话及小灵通
     26         * 区号：010,020,021,022,023,024,025,027,028,029
     27         * 号码：七位或八位
     28         */
    // NSString * PHS = @"^0(10|2[0-5789]|\\d{3})\\d{7,8}$";
    
    NSPredicate *regextestcm = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", CM];
    NSPredicate *regextestcu = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", CU];
    NSPredicate *regextestct = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", CT];
    
    if (([regextestcm evaluateWithObject:mobileNum] == YES)
        || ([regextestct evaluateWithObject:mobileNum] == YES)
        || ([regextestcu evaluateWithObject:mobileNum] == YES))
    {
        return YES;
    }
    else
    {
        return NO;
    }
}


/**
 *	@brief	校验密码有效性
 *
 *	@param 	pwd 	密码
 *
 *	@return	
 */
+ (BOOL)validatePassword:(NSString *)pwd
{
//    if (pwd.length < 6 || pwd.length > 20)
//    {
//        return NO;
//    }
    if ([pwd isEqualToString:@"112233"] || [pwd isEqualToString:@"123123"] || [pwd isEqualToString:@"123321"] || [pwd isEqualToString:@"123456"] || [pwd isEqualToString:@"654321"] || [pwd isEqualToString:@"abcdef"] || [pwd isEqualToString:@"abcabc"])
    {
        return NO;
    }
    else if (pwd.length == 6)
    {
        NSString *strOne = [[pwd substringFromIndex:0] substringToIndex:1];
        int num = 0;
        for (int i = 0; i < 6; i++)
        {
            NSString *str = [[pwd substringFromIndex:i] substringToIndex:1];
            if ([strOne isEqualToString:str])
            {
                num++;
            }
        }
        if (num >= 6)
        {
            return NO;
        }
    }
    return YES;
}

/**
 *	@brief	隐藏电话号码
 *
 *	@param 	pNum 	电话号码
 *
 *	@return 186****1325
 */
+ (NSString *)securePhoneNumber:(NSString *)pNum
{
    if (pNum.length != 11)
    {
        return pNum;
    }
    NSString *result = [NSString stringWithFormat:@"%@****%@",[pNum substringToIndex:3],[pNum substringFromIndex:7]];
    return result;
}

/**
 *	@brief	判断是否 全为空格
 *
 *	@param 	string
 *
 *	@return
 */
+ (BOOL)isAllSpaceWithString:(NSString *)string
{
    for (int i = 0; i < string.length; i++)
    {
        NSString *str = [string substringWithRange:NSMakeRange(i, 1)];
        if (![str isEqualToString:@" "])
        {
            return NO;
        }
    }
    return YES;
}

/**
 *	@brief	反转数组
 *
 *	@param 	targetArray 	targetArray description
 *
 *	@return	return value description
 */
+ (void)reverseArray:(NSMutableArray *)targetArray
{
    for (int i = 0; i < targetArray.count / 2.0f; i++)
    {
        
        [targetArray exchangeObjectAtIndex:i withObjectAtIndex:(targetArray.count - 1 - i)];
    }
}


/**
 *	@brief	是否全是中文
 *
 *	@param 	text 	text description
 *
 *	@return	return value description
 */
+ (BOOL)isChineseWord:(NSString *)text
{
    for (int index = 0; index < [text length]; index++)
    {
        NSString *character = [text substringWithRange:NSMakeRange(index, 1)];
        if ([character lengthOfBytesUsingEncoding:NSUTF8StringEncoding] != 3)
        {
            return NO;
        }
    }
    return YES;
}

+ (BOOL)isCardNo:(NSString *)bankCardNumber
{
    BOOL flag;
    if (bankCardNumber.length <= 0) {
        flag = NO;
        return flag;
    }
    NSString *regex2 = @"^(\\d{15,19})";
    NSPredicate *bankCardPredicate = [NSPredicate predicateWithFormat:@"SELF MATCHES %@",regex2];
    return [bankCardPredicate evaluateWithObject:bankCardNumber];
}

/**
 *	@brief	从钥匙串获得UUID
 *
 *	@return	NSString 获得的UUID
 */
+ (NSString *)getUUID
{
    if ([SSKeychain passwordForService:@"haowu" account:@"haowu"])
    {
        return [SSKeychain passwordForService:@"haowu" account:@"haowu"];
    }
    else
    {
        CFUUIDRef uuid = CFUUIDCreate(nil);
        CFStringRef uuidString = CFUUIDCreateString(nil, uuid);
        NSString *result = (NSString *)CFBridgingRelease(CFStringCreateCopy(NULL, uuidString));
        CFRelease(uuid);
        CFRelease(uuidString);
        [SSKeychain setPassword:result forService:@"haowu" account:@"haowu"];
        return result;
    }
}

/**
 *	@brief	过滤UUID中的符号
 *
 *	@return	NSString 获得 纯数字和字母的UUID
 */
+ (NSString *)getUUIDWithoutSymbol

{
    NSCharacterSet *set = [NSCharacterSet characterSetWithCharactersInString:@"@／：；（）¥「」＂、[]{}#%-*+=_\\|~＜＞$€^•'@#$%^&*()_+'\""];
    NSString *newUuid = [[[Utility getUUID] componentsSeparatedByCharactersInSet:set]componentsJoinedByString:@""];
    return newUuid;
}

+ (NSString *)imageDownloadUrl:(NSString *)subStr
{
    return [NSString stringWithFormat:@"%@/hw-sq-app-web/%@&key=%@",kUrlBase,subStr,[HWUserLogin currentUserLogin].key];
}

+ (NSString *)imageDownloadWithUrl:(NSString *)url
{
    return [NSString stringWithFormat:@"%@/%@&key=%@",kUrlBase,url,[HWUserLogin currentUserLogin].key];
}

+ (NSString *)imageDownloadWithMongoDbKey:(NSString *)strKey
{
    return [NSString stringWithFormat:@"%@/hw-sq-app-web/file/downloadByKey.do?mKey=%@&key=%@",kUrlBase,strKey,[HWUserLogin currentUserLogin].key];
}

/**
 *	@brief	创建navigation title view
 *
 *	@param 	_title 	标题
 *
 *	@return	view
 */
+ (UIView *)navTitleView:(NSString *)_title
{
    UILabel *lbl = [[UILabel alloc] initWithFrame:CGRectMake(kScreenWidth / 2 - 50, 2, 100, 40)];
    lbl.backgroundColor = [UIColor clearColor];
    lbl.textAlignment = NSTextAlignmentCenter;
    lbl.font = [UIFont fontWithName:FONTNAME size:19.0f];
    lbl.textColor = THEME_COLOR_SMOKE;
    lbl.text = _title;
    return lbl;
}

/**
 *	@brief	创建navigation title view
 *
 *	@param 	_title 	标题
    @param selector 调用方法
    @param target 目标
 *
 *	@return	view
 */
+ (UIView *)navTitleView:(NSString *)_title action:(SEL)selector target:(id)_target
{
    UIView *view = [[UIView alloc]initWithFrame:CGRectMake(kScreenWidth/2-60,2, 120, 40)];
    //UIView *view = [[UIView alloc]initWithFrame:CGRectMake(0,0, 120, 40)];
    view.backgroundColor = [UIColor clearColor];
    UILabel *lbl = [[UILabel alloc] initWithFrame:CGRectMake(15, 0, 120 - 30, 40)];
    lbl.backgroundColor = [UIColor clearColor];
    lbl.textAlignment = NSTextAlignmentCenter;
    lbl.font = [UIFont fontWithName:FONTNAME size:19.0f];
    lbl.textColor = THEME_COLOR_SMOKE;
    lbl.text = _title;
    [view addSubview:lbl];
    [lbl sizeToFit];
    lbl.center = CGPointMake(view.frame.size.width / 2.0f, view.frame.size.height / 2.0f);
    
    UIImageView *imageView = [[UIImageView alloc]initWithFrame:CGRectMake(CGRectGetMaxX(lbl.frame)+ 3, CGRectGetMidY(lbl.frame) - 4.5f, 9, 9)];
    imageView.image = [UIImage imageNamed:@"button31"];
    imageView.backgroundColor = [UIColor clearColor];
    [view addSubview:imageView];
    
    UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
    [btn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [btn setFrame:view.bounds];
    [btn addTarget:_target action:selector forControlEvents:UIControlEventTouchUpInside];
    btn.backgroundColor = [UIColor clearColor];
    [view addSubview:btn];
    
    return view;
}

/**
 *	@brief	通用navigation 返回按钮
 *
 *	@param 	_target 	接收对象
 *	@param 	selector    调用方法
 *
 *	@return	BarButtonItem
 */
+ (UIBarButtonItem*)navLeftBackBtn:(id)_target action:(SEL)selector
{
    UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
    [btn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [btn setFrame:CGRectMake(0, 0, 50, 40)];
    [btn addTarget:_target action:selector forControlEvents:UIControlEventTouchUpInside];
    [btn setImage:[UIImage imageNamed:@"navigation_back"] forState:UIControlStateNormal];
    btn.imageEdgeInsets = UIEdgeInsetsMake(5.5, 2, 5.5, 37);
//    [btn setTitleColor:UIColorFromRGB(0x000000) forState:UIControlStateNormal];
    UIBarButtonItem *left_btn = [[UIBarButtonItem alloc] initWithCustomView:btn];
    return left_btn;
}

+ (UIView *)navTitleViewSegmentCtrlWithItems:(NSArray *)items target:(id)target selector:(SEL)selector
{
    UISegmentedControl *segCtrl = [[UISegmentedControl alloc] initWithItems:items];
    segCtrl.tintColor = THEME_COLOR_ORANGE;
    segCtrl.frame = CGRectMake(0, 0, 170, 30);
    segCtrl.selectedSegmentIndex = 0;
    [segCtrl setTitleTextAttributes:[NSDictionary dictionaryWithObject:[UIFont fontWithName:FONTNAME size:15.0f] forKey:UITextAttributeFont] forState:UIControlStateNormal];
    
    [segCtrl addTarget:target action:selector forControlEvents:UIControlEventValueChanged];
    return segCtrl;
}

+ (UIBarButtonItem *)navWalletButton:(id)_target action:(SEL)selector{
    UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
    btn.frame = CGRectMake(280, 0, 50, 44);
    //    [btn setTitle:@"提现" forState:UIControlStateNormal];
    //    [btn setTitleColor:[UIColor orangeColor] forState:UIControlStateNormal];
    [btn setImage:[UIImage imageNamed:@"moneyMore"] forState:UIControlStateNormal];
    //    btn.backgroundColor  = [UIColor blueColor];
    //    btn.imageView.backgroundColor = [UIColor redColor];
    btn.imageEdgeInsets = UIEdgeInsetsMake(16, 11+6, 16, 11-6);
    //    btn.imageView.frame = CGRectMake(0, 0, 20, 5);
    [btn addTarget:_target action:selector forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem *item = [[UIBarButtonItem alloc]initWithCustomView:btn];
    return item;
}
+ (UIBarButtonItem *)navShareButton:(id)_target action:(SEL)selector{
    UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
    btn.frame = CGRectMake(kScreenWidth-44, 0, 50, 44);
    [btn setImage:[UIImage imageNamed:@"export"] forState:UIControlStateNormal];
    //    btn.backgroundColor  = [UIColor blueColor];
    //    btn.imageView.backgroundColor = [UIColor redColor];
    btn.imageEdgeInsets = UIEdgeInsetsMake(11, 27, 11, 0);
    //    btn.imageView.frame = CGRectMake(0, 0, 20, 5);
    [btn addTarget:_target action:selector forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem *item = [[UIBarButtonItem alloc] initWithCustomView:btn];
    return item;
}
+ (UIBarButtonItem *)navButton:(id)_target title:(NSString*)title action:(SEL)selector
{
    UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
    btn.frame = CGRectMake(270, 0, 50, 44);
    [btn setTitle:title forState:UIControlStateNormal];
    btn.titleLabel.font = [UIFont fontWithName:FONTNAME size:15.0f];
    
    [btn setTitleColor:THEME_COLOR_ORANGE forState:UIControlStateNormal];
    [btn setTitleColor:[UIColor colorWithRed:30.0 / 255.0 green:120.0 / 255.0 blue:60.0 / 255.0 alpha:1] forState:UIControlStateHighlighted];
    btn.titleEdgeInsets = UIEdgeInsetsMake(0, 0, 0, -15);
    [btn addTarget:_target action:selector forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem *item = [[UIBarButtonItem alloc]initWithCustomView:btn];
    return item;
}

+ (UIBarButtonItem *)navButton:(id)_target title:(NSString*)title action:(SEL)selector count:(int)count
{
    UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
    btn.frame = CGRectMake(270, 0, 50, 44);
    [btn setTitle:title forState:UIControlStateNormal];
    btn.titleLabel.font = [UIFont fontWithName:FONTNAME size:15.0f];
    [btn setTitleColor:THEME_COLOR_ORANGE forState:UIControlStateNormal];
    btn.titleEdgeInsets = UIEdgeInsetsMake(0, 0, 0, -15);
    [btn addTarget:_target action:selector forControlEvents:UIControlEventTouchUpInside];
    
    if (count != 0)
    {
        UILabel *badgeLab = [[UILabel alloc] initWithFrame:CGRectMake(50 - 10, 8, 14, 14)];
        badgeLab.layer.cornerRadius = 7.0f;
        badgeLab.layer.masksToBounds = YES;
        badgeLab.backgroundColor = THEME_COLOR_GREEN;
        badgeLab.textColor = [UIColor whiteColor];
        badgeLab.textAlignment = NSTextAlignmentCenter;
        badgeLab.font = [UIFont fontWithName:FONTNAME size:12.0f];
        badgeLab.text = [NSString stringWithFormat:@"%d",count];
        [btn addSubview:badgeLab];
    }
    
    UIBarButtonItem *item = [[UIBarButtonItem alloc]initWithCustomView:btn];
    return item;
}

+ (UIBarButtonItem *)navPublishButton:(id)_target action:(SEL)selector
{
    UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
    btn.frame = CGRectMake(kScreenWidth - 40, 0, 50, 44);
    [btn setImage:[UIImage imageNamed:@"publishIcon"] forState:UIControlStateNormal];
    btn.imageEdgeInsets = UIEdgeInsetsMake(27 / 2.0f, 23 / 2.0f + 17, 27 / 2.0f, 23 / 2.0f - 17);
    [btn addTarget:_target action:selector forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem *item = [[UIBarButtonItem alloc]initWithCustomView:btn];
    return item;
}

+ (UIBarButtonItem *)navButton:(id)_target image:(NSString *)imgName action:(SEL)selector
{
    UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
    btn.frame = CGRectMake(0, 0, 50, 44);
    [btn setImage:[UIImage imageNamed:imgName] forState:UIControlStateNormal];
    btn.imageEdgeInsets = UIEdgeInsetsMake(27 / 2.0f, 23 / 2.0f + 17, 27 / 2.0f, 23 / 2.0f - 17);
    [btn addTarget:_target action:selector forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem *item = [[UIBarButtonItem alloc]initWithCustomView:btn];
    return item;
}

+ (void)showLoadingAnimationInView:(UIView *)view{
    LoadingView *loadV = [[LoadingView alloc]initWithFrame:view.frame];
    loadV.tag = 345;
    [view addSubview:loadV];
}

+ (void)hideLoadingAnimationInView:(UIView *)view{
    if (view) {
        for (UIView *animationView in view.subviews) {
            if (animationView.tag == 345) {
                [animationView removeFromSuperview];
            }
        }
        view.userInteractionEnabled = YES;
    }else{
        UIWindow *window = [UIApplication sharedApplication].keyWindow;
        if (!window) {
            window = [[UIApplication sharedApplication].windows objectAtIndex:0];
        }
        for (UIView *view in window.subviews) {
            if (view.tag == 345) {
                [view removeFromSuperview];
            }
        }
        window.userInteractionEnabled = YES;
    }
}


/**
 *	@brief	显示toast提示框 1秒后自动消失
 *
 *	@param 	message 	提示信息
 *
 *	@return	
 */
+ (void)showToastWithMessage:(NSString *)message inView:(UIView *)view
{
    [self showToastWithMessage:message inView:view yoffest:-100.0f];
}

+ (void)showToastWithMessage:(NSString *)message inView:(UIView *)view yoffest:(CGFloat)offest
{
    MBProgressHUD *progressHUD = [[MBProgressHUD alloc] initWithView:view];
    [view addSubview:progressHUD];
    progressHUD.detailsLabelText = message;
    progressHUD.mode = MBProgressHUDModeText;
    
    //指定距离中心点的X轴和Y轴的偏移量，如果不指定则在屏幕中间显示
    progressHUD.yOffset = offest;
    
    [progressHUD showAnimated:YES whileExecutingBlock:^{
        sleep(2);
    } completionBlock:^{
        [progressHUD removeFromSuperview];
    }];
}

/**
 *	@brief	显示toast提示框 1秒后自动消失
 *
 *	@param 	message 	提示信息
 *
 *	@return
 */
+ (void)show3SecondToastWithMessage:(NSString *)message inView:(UIView *)view
{
    MBProgressHUD *progressHUD = [[MBProgressHUD alloc] initWithView:view];
    [view addSubview:progressHUD];
    progressHUD.detailsLabelText = message;
    progressHUD.mode = MBProgressHUDModeText;
    
    //指定距离中心点的X轴和Y轴的偏移量，如果不指定则在屏幕中间显示
    progressHUD.yOffset = -100.0f;
    //    HUD.xOffset = 100.0f;
    
    [progressHUD showAnimated:YES whileExecutingBlock:^{
        sleep(4);
    } completionBlock:^{
        [progressHUD removeFromSuperview];
    }];
}

/**
 *	@brief	图像保存路径
 *
 *	@param 	无
 *
 *	@return
 */
+ (NSString *)savedPath
{
    NSArray *paths=NSSearchPathForDirectoriesInDomains(NSDocumentDirectory,NSUserDomainMask,YES);
    NSString *documentsDirectory=[paths objectAtIndex:0];
    return documentsDirectory;
}

/**
 *	@brief	系统提示框
 *
 *	@param 	message 	提示信息
 *
 *	@return
 */
+ (void)showAlertWithMessage:(NSString *)message
{
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"提示" message:message delegate:nil cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
    [alert performSelectorOnMainThread:@selector(show) withObject:nil waitUntilDone:YES];
}
/**
 *  展示提示框
 *
 *  @param message   提示信息
 *
 */
+ (void)showAlertWithMessageAndSureCancelBtn:(NSString *)messagecancelStr delegate:(id)delegate
{
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"提示" message:messagecancelStr delegate:delegate cancelButtonTitle:@"取消" otherButtonTitles:@"确定", nil];
    [alert performSelectorOnMainThread:@selector(show) withObject:nil waitUntilDone:YES];
}
+ (void)showMBProgress:(UIView *)_targetView message:(NSString *)_msg
{
//    UIView *customView = [UIView alloc] initWithFrame:CGRectMake(0, 0, 80, <#CGFloat height#>)
    
    UIImageView *imgV = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 60, 48)];
    imgV.animationImages = [NSArray arrayWithObjects:
                            [UIImage imageNamed:@"dataLoading1"],
                            [UIImage imageNamed:@"dataLoading2"],
                            [UIImage imageNamed:@"dataLoading3"],
                            [UIImage imageNamed:@"dataLoading4"],
                            [UIImage imageNamed:@"dataLoading5"],
                            [UIImage imageNamed:@"dataLoading6"],
                            [UIImage imageNamed:@"dataLoading7"],
                            [UIImage imageNamed:@"dataLoading8"],
                            [UIImage imageNamed:@"dataLoading9"],
                            [UIImage imageNamed:@"dataLoading10"], nil];
    imgV.animationDuration = 1.0f;
    imgV.animationRepeatCount = 0;
    [imgV startAnimating];
    
    MBProgressHUD *progressHUD = [[MBProgressHUD alloc] initWithView:_targetView];
    progressHUD.mode = MBProgressHUDModeCustomView;
    progressHUD.customView = imgV;
    [progressHUD show:YES];
    progressHUD.labelText = _msg;
    [_targetView addSubview:progressHUD];
//    MBProgressHUD *progressHUD = [MBProgressHUD showHUDAddedTo:_targetView animated:YES];
//    progressHUD.labelText = _msg;
}

+(void)showToastMBProgress:(UIView *)_targetView message:(NSString *)_msg imageName:(NSString *)_imgName
{
    UIImageView *imgView = [[UIImageView alloc]initWithImage:[UIImage imageNamed:_imgName]];
    MBProgressHUD *progressHUD = [[MBProgressHUD alloc]initWithView:_targetView];
    progressHUD.mode = MBProgressHUDModeCustomView;
    progressHUD.customView = imgView;
    progressHUD.yOffset = -100.0f;
    progressHUD.labelText = _msg;
    [_targetView addSubview:progressHUD];
    [progressHUD showAnimated:YES whileExecutingBlock:^{
        sleep(2);
    } completionBlock:^{
        [progressHUD removeFromSuperview];
    }];
}

+ (void)hideMBProgress:(UIView*)_targetView
{
    [MBProgressHUD hideHUDForView:_targetView animated:YES];
}

// 根据nib创建对象
id loadObjectFromNib(NSString *nib, Class cls, id owner)
{
    NSArray *nibs = [[NSBundle mainBundle] loadNibNamed:nib owner:owner options:nil];
    for (id oneObj in nibs)
    {
        if ([oneObj isKindOfClass:cls])
        {
            return oneObj;
        }
    }
    return nil;
}

+ (UIImage *)imageWithColor:(UIColor *)color andSize:(CGSize)size
{
    CGRect rect = CGRectMake(0.0f, 0.0f, size.width, size.height);    
    UIGraphicsBeginImageContextWithOptions(rect.size, NO, [UIScreen mainScreen].scale);
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextSetFillColorWithColor(context, [color CGColor]);
    CGContextFillRect(context, rect);
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return image;
}

+ (UIImage *)imageWithColor:(UIColor *)color andSize:(CGSize)size withString:(NSString *)string
{
    CGRect rect = CGRectMake(0.0f, 0.0f, size.width, size.height);
    UIGraphicsBeginImageContextWithOptions(size, NO, 0.0f);
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextSetFillColorWithColor(context, [color CGColor]);
    CGContextFillRect(context, rect);
    NSMutableParagraphStyle *style = [[NSMutableParagraphStyle alloc]init];
    style.alignment = NSTextAlignmentCenter;
    
    CGFloat stringW =((sqrt(2) * (rect.size.width/2))/2) * (3/2.0f);
    CGFloat stringX = (rect.size.width - stringW)/2;
    
    UIFont *font = [UIFont fontWithName:FONTNAME size:stringW];
    
    
    CGSize strSize = [Utility calculateStringWidth:string font:font constrainedSize:CGSizeMake(100, 1000)];
    
    
    if (IOS7)
    {
        [string drawInRect:CGRectMake(stringX, (size.height - strSize.height) / 2.0f, stringW, strSize.height) withAttributes:@{NSForegroundColorAttributeName:[UIColor whiteColor],NSFontAttributeName:[UIFont fontWithName:FONTNAME size:stringW],NSParagraphStyleAttributeName:style}];
    }
    else
    {
        NSAttributedString *str = [[NSAttributedString alloc]initWithString:string attributes:@{NSForegroundColorAttributeName:[UIColor whiteColor],NSFontAttributeName:[UIFont fontWithName:FONTNAME size:stringW],NSParagraphStyleAttributeName:style}];
        [str drawInRect:CGRectMake(stringX, (size.height - strSize.height) / 2.0f, stringW, strSize.height)];
    }


    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return image;
    
}

//获取当前版本号
+ (NSString *)getLocalAppVersion {
    NSString *path = [[NSBundle mainBundle] pathForResource:@"Info" ofType:@"plist"];
    NSDictionary *dict = [NSDictionary dictionaryWithContentsOfFile:path];
    NSString *version = [dict stringObjectForKey:@"CFBundleVersion"];
    return version;
}
//获取城市Id
+(NSString*)getCityId:(NSString *)cityName
{
    NSMutableArray *fileDataArry = [HWUserLogin currentUserLogin].cities;
    for (int j = 0; j < fileDataArry.count; j++)
        {
            HWCityClass *cityClass = [fileDataArry objectAtIndex:j];
            if ([cityClass.cityName isEqualToString:cityName]) {
                return cityClass.cityId;
            }
        }

    return nil;
}

+ (NSString *)getCityNameById:(NSString *)cityId
{
    NSMutableArray *fileDataArry = [HWUserLogin currentUserLogin].cities;
    for (int j = 0; j < fileDataArry.count; j++)
    {
        HWCityClass *cityClass = [fileDataArry objectAtIndex:j];
        if ([cityClass.cityId isEqualToString:cityId])
        {
            return cityClass.cityName;
        }
    }
    return @"";
}
//获取区域的Id
+(NSString *)getCityAreaId:(NSString *)areaName city:(NSString *)cityName
{
    NSString *path = [[NSBundle mainBundle] pathForResource:@"city" ofType:@"txt"];
    NSDictionary *fileDataDic = [NSDictionary dictionaryWithContentsOfFile:path];
    NSArray *provinceArr = [[fileDataDic objectForKey:@"china"] objectForKey:@"provinces"];
    for (int i = 0; i < provinceArr.count; i++)
    {
        NSDictionary *dic = [provinceArr objectAtIndex:i];
        NSArray *city = [dic arrayObjectForKey:@"citys"];
        for (int j = 0; j < city.count; j++)
        {
            NSDictionary *cityDic = [city pObjectAtIndex:j];
            HWCityClass *cityClass = [[HWCityClass alloc] initWithDictionary:cityDic];
            if ([cityClass.cityName isEqualToString:cityName]) {
                NSArray *areas = [cityDic arrayObjectForKey:@"areas"];
                for (int k = 0; k < areas.count; k++) {
                    NSDictionary *areaDic = [areas pObjectAtIndex:k];
                    NSString *areaNameTemp = [areaDic objectForKey:@"area_name"];
                    if ([areaNameTemp isEqualToString:areaName]) {
                        return [areaDic objectForKey:@"id"];
                    }
                    
                }
            }
        }
    }
    return nil;
}
//判读是否已登录--自动登录
+ (BOOL)isUserLogin {
    if([HWUserLogin currentUserLogin].key==nil||[[HWUserLogin currentUserLogin].key isKindOfClass:[NSNull class]]||[HWUserLogin currentUserLogin].key.length==0)
        return NO;
    else
        return YES;
}


//判断是否游客登录
+ (BOOL)isGuestLogin
{
    if ([HWUserLogin currentUserLogin].deviceId.length > 0 && [HWUserLogin currentUserLogin].telephoneNum.length == 0)
    {
        return YES;
    }
    else
    {
        return NO;
    }
}

//判断是否是微信登录（且未绑定手机号）
+ (BOOL)isWeiXinUser
{
    if ([[HWUserLogin currentUserLogin].source isEqualToString:@"2"] && [HWUserLogin currentUserLogin].telephoneNum.length == 0)
    {
        return YES;
    }
    else
    {
        return NO;
    }
}

+ (NSString *)getDateWithTimestamp:(NSString *)strTimestamp
{
    long long time = [strTimestamp longLongValue] / 1000;
    NSDate *date = [NSDate dateWithTimeIntervalSince1970:time];
    
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setDateFormat:@"MM-dd"];
    
    NSString *strTime = [formatter stringFromDate:date];
    
    return strTime;
}

+ (NSString *)getDetailTimeWithTimestamp:(NSString *)strTimestamp
{
    long long time = [strTimestamp longLongValue] / 1000;
    NSDate *date = [NSDate dateWithTimeIntervalSince1970:time];
    
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
    
    NSString *strTime = [formatter stringFromDate:date];
    
    return strTime;
}
+ (NSString *)getMinTimeWithTimestamp:(NSString *)strTimestamp
{
    long long time = [strTimestamp longLongValue] / 1000;
    NSDate *date = [NSDate dateWithTimeIntervalSince1970:time];
    
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setDateFormat:@"yyyy-MM-dd HH:mm"];
    
    NSString *strTime = [formatter stringFromDate:date];
    
    return strTime;
}

+ (NSString *)getTimeWithTimestamp:(NSString *)strTimestamp
{
    long long time = [strTimestamp longLongValue] / 1000;
    NSDate *date = [NSDate dateWithTimeIntervalSince1970:time];
    
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setDateFormat:@"yyyy-MM-dd"];
    
    NSString *strTime = [formatter stringFromDate:date];
    
    return strTime;
}

+ (NSString *)getTimeWithTimestampChinese:(NSString *)strTimestamp
{
    long long time = [strTimestamp longLongValue] / 1000;
    NSDate *date = [NSDate dateWithTimeIntervalSince1970:time];
    
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setDateFormat:@"yyyy年MM月dd日"];
    
    NSString *strTime = [formatter stringFromDate:date];
    
    return strTime;
}

+ (NSString *)getMonthTimeWithTimestamp:(NSString *)strTimestamp
{
    long long time = [strTimestamp longLongValue] / 1000;
    NSDate *date = [NSDate dateWithTimeIntervalSince1970:time];
    
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setDateFormat:@"yyyy年MM月"];
    
    NSString *strTime = [formatter stringFromDate:date];
    
    return strTime;
}

+ (NSString *)getHourTimeWithTimestamp:(NSString *)strTimestamp
{
    long long time = [strTimestamp longLongValue] / 1000;
    NSDate *date = [NSDate dateWithTimeIntervalSince1970:time];
    
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setDateFormat:@"HH:mm:ss"];
    
    NSString *strTime = [formatter stringFromDate:date];
    
    return strTime;
}

//将时间戳转换为时间
+ (NSString *)getTimeWithTimestamp:(NSString *)strTimestamp WithDateFormat:(NSString *)strDateFormat
{
    long long time = [strTimestamp longLongValue] / 1000;
    NSDate *date = [NSDate dateWithTimeIntervalSince1970:time];
    
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setDateFormat:strDateFormat];
    NSString *strTime = [formatter stringFromDate:date];
    
    return strTime;
}

+ (NSString *)getTimeStampForUnix
{
    NSTimeInterval  a = [[NSDate date] timeIntervalSince1970];
    NSString * timeString = [NSString stringWithFormat:@"%.0f",a];
    return timeString;
}

#pragma - mark Date
//程序中使用的，将日期显示成  2011年4月4日
+ (NSString *)DateToStr:(NSDate *)indate
{
    NSDateFormatter* dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setLocale:[[NSLocale alloc] initWithLocaleIdentifier:@"zh_CN"] ];
    dateFormatter.dateFormat =@"yyyy'-'MM'-'dd";
    NSString *tempstr = [dateFormatter stringFromDate:indate];
    return tempstr;
}
//日期转换
+(NSString*)DateOfConversion:(NSString*)dateStr
{
    //2014-06-13 19:44:58
    NSArray *arr = [dateStr componentsSeparatedByString:@" "];
    NSString *str = arr[0];
    NSString *now = [[self class]DateToStr:[NSDate date]];
    if ([str isEqualToString:now]) {
        return @"今日";
    }
    return str;
}
+(NSString *)DateToMDMSAndToday:(NSString *)DateStr
{
    if ([[self DateOfConversion:DateStr]isEqualToString:@"今天"])
    {
        //2014-06-13 19:44:58
        NSArray *arr = [DateStr componentsSeparatedByString:@" "];
        NSString *str = arr[1];
        NSString *tempStr = [NSString stringWithFormat:@"%@ %@",@"今天",str];
        return tempStr;
    }
    else{
        return DateStr;
    }
}
/*少于1分钟前发送的，显示刚刚
 
 1分钟前~1小时前发送的，显示几分钟前
 
 1小时前~24小时前发送的，显示几小时前
 
 超过24点发送的，显示昨天，超过昨天24点发送显示前天
 
 大于30天，显示*月*日
 
 超过今年，显示20**年*月*日*/
+ (NSString *)getTimeStampToStrRule:(NSString *)strTimestamp
{
    long long time = [strTimestamp longLongValue] / 1000;
    NSDate *date = [NSDate dateWithTimeIntervalSince1970:time];
    NSDate *currentDate = [NSDate date];
    float timeInterval = [currentDate timeIntervalSinceDate:date];
    
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setDateFormat:@"yyyy年MM月dd日"];
    NSString *strTimestampY = [formatter stringFromDate:currentDate];
    
    if (timeInterval < 60)
    {
        return @"刚刚";
    }
    else if (timeInterval < 60 * 60)
    {
        return [NSString stringWithFormat:@"%d分钟前", (int)(timeInterval / 60)];
    }
    else if (timeInterval < 60 * 60 * 24)
    {
        return [NSString stringWithFormat:@"%d小时前", (int)(timeInterval / 60 / 60)];
    }
    else if ([[self getDateStr:strTimestamp dayInterval:1] isEqualToString:strTimestampY])
    {
        return @"昨天";
    }
    else if ([[self getDateStr:strTimestamp dayInterval:2] isEqualToString:strTimestampY])
    {
        return @"前天";
    }
    else
    {
        [formatter setDateFormat:@"yyyy年"];
        
        NSString *strTimeY = [formatter stringFromDate:currentDate];
        NSString *strTimestampY = [formatter stringFromDate:date];
        if ([strTimeY isEqualToString:strTimestampY])
        {
            [formatter setDateFormat:@"MM月dd日"];
            NSString *strTimestampD = [formatter stringFromDate:date];
            return strTimestampD;
        }
        else
        {
            return [self getTimeWithTimestampChinese:strTimestamp];
        }
    }
}

+ (NSString *)getDateStr:(NSString *)strTimestamp dayInterval:(int)dayCount
{
    NSCalendar *initCalendar = [[NSCalendar alloc]initWithCalendarIdentifier:NSCalendarIdentifierGregorian];
    long long time = [strTimestamp longLongValue] / 1000;
    NSDate *currentDate = [NSDate dateWithTimeIntervalSince1970:time];
    NSDateComponents *comps = [[NSDateComponents alloc] init];
    [comps setDay:dayCount];
    NSDate *toDate = [initCalendar dateByAddingComponents:comps toDate:currentDate options:0];
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setDateFormat:@"yyyy年MM月dd日"];
    NSString *strDate = [formatter stringFromDate:toDate];
    return strDate;
}

//end by gusheng

+ (NSString *)getRandomString
{
    int NUMBER_OF_CHARS = 5;
    char data[NUMBER_OF_CHARS];
    for (int i = 0 ; i < NUMBER_OF_CHARS ; i++)
        data[i] = ('A' + (arc4random_uniform(26)));
    NSString *dataPoint = [[NSString alloc] initWithBytes:data length:NUMBER_OF_CHARS encoding:NSUTF8StringEncoding];
    
    return dataPoint;
}

+ (NSString *)calculateRemainedTimeWithTimeInterval:(long long)interval
{
    NSInteger second = interval % 60;
    NSInteger minute = interval / 60 % 60;
    NSInteger hour = interval / 60 / 60 % 24;
    NSInteger day = interval / (60 * 60 * 24);
    
    NSString *remainTimeStr = @"";
    if (day > 0)
    {
        remainTimeStr = [remainTimeStr stringByAppendingString:[NSString stringWithFormat:@"%zd天",day]];
    }
    
    if (hour > 0)
    {
        if (hour < 10)
        {
            remainTimeStr = [remainTimeStr stringByAppendingString:[NSString stringWithFormat:@"0%zd时",hour]];
        }
        else
        {
            remainTimeStr = [remainTimeStr stringByAppendingString:[NSString stringWithFormat:@"%zd时",hour]];
        }
    }
    
    if (minute > 0)
    {
        if (minute < 10)
        {
            remainTimeStr = [remainTimeStr stringByAppendingString:[NSString stringWithFormat:@"0%zd分",minute]];
        }
        else
        {
            remainTimeStr = [remainTimeStr stringByAppendingString:[NSString stringWithFormat:@"%zd分",minute]];
        }
    }
    
    if (!day)
    {
        if (second < 10)
        {
            remainTimeStr = [remainTimeStr stringByAppendingString:[NSString stringWithFormat:@"0%zd秒",second]];
        }
        else
        {
            remainTimeStr = [remainTimeStr stringByAppendingString:[NSString stringWithFormat:@"%zd秒",second]];
        }
    }
    
    return [NSString stringWithFormat:@"剩余%@", remainTimeStr];
}

+ (void)playShake
{
    AudioServicesPlaySystemSound(kSystemSoundID_Vibrate);
}

+ (void)playAudioEffect
{
    NSString *filename = @"";
    
    NSURL *fileURL = [[NSBundle mainBundle] URLForResource:filename withExtension:nil];
    SystemSoundID theSoundID;
    if (fileURL != nil)
    {
        OSStatus error = AudioServicesCreateSystemSoundID((__bridge CFURLRef)fileURL, &theSoundID);
        if (error == kAudioServicesNoError)
        {
            AudioServicesPlaySystemSound(theSoundID);
        }
        else
        {
            NSLog(@"Failed to create sound ");
        }
    }
}

+ (BOOL)stringContainsEmoji:(NSString *)string
{
    __block BOOL returnValue = NO;
    [string enumerateSubstringsInRange:NSMakeRange(0, [string length]) options:NSStringEnumerationByComposedCharacterSequences usingBlock:
     ^(NSString *substring, NSRange substringRange, NSRange enclosingRange, BOOL *stop) {
         
         const unichar hs = [substring characterAtIndex:0];
         // surrogate pair
         if (0xd800 <= hs && hs <= 0xdbff) {
             if (substring.length > 1) {
                 const unichar ls = [substring characterAtIndex:1];
                 const int uc = ((hs - 0xd800) * 0x400) + (ls - 0xdc00) + 0x10000;
                 if (0x1d000 <= uc && uc <= 0x1f77f) {
                     returnValue = YES;
                 }
             }
         } else if (substring.length > 1) {
             const unichar ls = [substring characterAtIndex:1];
             if (ls == 0x20e3) {
                 returnValue = YES;
             } else if (ls == 0xfe0f) {
                 returnValue = YES;
             } else if (ls == 0x2708) {
                 returnValue = YES;
             }
             
             
         } else {
             // non surrogate
             if (0x2100 <= hs && hs <= 0x27ff) {
                 if (hs >= 0x278b && hs <= 0x2792) {
                     returnValue = NO;
                 } else {
                     returnValue = YES;
                 }
             } else if (0x2B05 <= hs && hs <= 0x2b07) {
                 returnValue = YES;
             } else if (0x2934 <= hs && hs <= 0x2935) {
                 returnValue = YES;
             } else if (0x3297 <= hs && hs <= 0x3299) {
                 returnValue = YES;
             } else if (hs == 0xa9 || hs == 0xae || hs == 0x303d || hs == 0x3030 || hs == 0x2b55 || hs == 0x2b1c || hs == 0x2b1b || hs == 0x2b50) {
                 returnValue = YES;
             }
         }
     }];
    
    return returnValue;
}

//获得屏幕图像
+ (UIImage *)imageFromView:(UIView *)theView
{
//    UIGraphicsBeginImageContext(theView.frame.size);
    UIGraphicsBeginImageContextWithOptions(theView.frame.size, YES, [UIScreen mainScreen].scale);
    CGContextRef context = UIGraphicsGetCurrentContext();
    [theView.layer renderInContext:context];
    UIImage *theImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    return theImage;
}

//获得某个范围内的屏幕图像
+ (UIImage *)imageFromView:(UIView *)theView atFrame:(CGRect)r
{
    UIGraphicsBeginImageContext(theView.frame.size);
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextSaveGState(context);
    UIRectClip(r);
    [theView.layer renderInContext:context];
    UIImage *theImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    return  theImage;//[self getImageAreaFromImage:theImage atFrame:r];
}

+ (NSString *)getMacAddress
{
    int                 mib[6];
    size_t              len;
    char                *buf;
    unsigned char       *ptr;
    struct if_msghdr    *ifm;
    struct sockaddr_dl  *sdl;
    
    mib[0] = CTL_NET;
    mib[1] = AF_ROUTE;
    mib[2] = 0;
    mib[3] = AF_LINK;
    mib[4] = NET_RT_IFLIST;
    
    if ((mib[5] = if_nametoindex("en0")) == 0) {
        printf("Error: if_nametoindex error/n");
        return NULL;
    }
    
    if (sysctl(mib, 6, NULL, &len, NULL, 0) < 0) {
        printf("Error: sysctl, take 1/n");
        return NULL;
    }
    
    if ((buf = malloc(len)) == NULL) {
        printf("Could not allocate memory. error!/n");
        return NULL;
    }
    
    if (sysctl(mib, 6, buf, &len, NULL, 0) < 0) {
        printf("Error: sysctl, take 2");
        return NULL;
    }
    
    ifm = (struct if_msghdr *)buf;
    sdl = (struct sockaddr_dl *)(ifm + 1);
    ptr = (unsigned char *)LLADDR(sdl);
    NSString *outstring = [NSString stringWithFormat:@"%02x:%02x:%02x:%02x:%02x:%02x", *ptr, *(ptr+1), *(ptr+2), *(ptr+3), *(ptr+4), *(ptr+5)];
    
    //    NSString *outstring = [NSString stringWithFormat:@"%02x%02x%02x%02x%02x%02x", *ptr, *(ptr+1), *(ptr+2), *(ptr+3), *(ptr+4), *(ptr+5)];
    
    NSLog(@"outString:%@", outstring);
    
    free(buf);
    
    return [outstring uppercaseString];
}

+ (NSString *)getIDFA
{
    NSString *IDFA = [[[ASIdentifierManager sharedManager] advertisingIdentifier] UUIDString];
    return IDFA;
}

+ (CGSize)calculateStringHeight:(NSString *)string font:(UIFont *)font constrainedSize:(CGSize)cSize
{
    if (IOS7)
    {
        NSDictionary *attribute = @{NSFontAttributeName: font};
        CGRect rect = [string boundingRectWithSize:cSize options:NSStringDrawingTruncatesLastVisibleLine | NSStringDrawingUsesLineFragmentOrigin | NSStringDrawingUsesFontLeading attributes:attribute context:nil];
        return rect.size;
    }
    else
    {
        CGSize size = [string sizeWithFont:font constrainedToSize:cSize lineBreakMode:NSLineBreakByWordWrapping];
        return size;
    }
    return CGSizeZero;
}
+ (CGSize)calculateStringWidth:(NSString *)string font:(UIFont *)font constrainedSize:(CGSize)cSize
{
    if (IOS7)
    {
        NSDictionary *attribute = @{NSFontAttributeName: font};
        CGRect rect = [string boundingRectWithSize:cSize options: NSStringDrawingTruncatesLastVisibleLine | NSStringDrawingUsesLineFragmentOrigin | NSStringDrawingUsesFontLeading attributes:attribute context:nil];
        return rect.size;
    }
    else
    {
        CGSize size = [string sizeWithFont:font constrainedToSize:cSize lineBreakMode:NSLineBreakByCharWrapping];
        return size;
    }
    return CGSizeZero;
}


+ (NSString *)parseProductStatus:(NSString *)status
{
//    0:未开始；1：进行中；2：流标；3.已开奖；4.活动结束；5.已中奖
    if (status.intValue == 0)
    {
        // 未开始
        return @"未开始";
    }
    else if (status.intValue == 1)
    {
        // 进行中
        return @"等待开奖";
    }
    else if (status.intValue == 2)
    {
        // 流标
        return @"已流标";
    }
    else if (status.intValue == 3)
    {
        // 已开奖
        return @"已开奖";
    }
    else if (status.intValue == 4)
    {
        // 活动结束
        return @"活动结束";
    }
    else if (status.intValue == 5)
    {
        // 已中奖
        return @"已中奖";
    }
    return @"";
}

+ (UIColor *)parseProductStatusTextColor:(NSString *)status
{
    if (status.intValue == 0)
    {
        // 未开始
        return THEME_COLOR_SMOKE;
    }
    else if (status.intValue == 1)
    {
        // 进行中
        return THEME_COLOR_ORANGE;
    }
    else if (status.intValue == 2)
    {
        // 流标
        return THEME_COLOR_SMOKE;
    }
    else if (status.intValue == 3)
    {
        // 已开奖
        return THEME_COLOR_SMOKE;
    }
    else if (status.intValue == 4)
    {
        // 活动结束
        return THEME_COLOR_SMOKE;
    }
    else if (status.intValue == 5)
    {
        // 已中奖
        return THEME_COLOR_MONEY;
    }
    return THEME_COLOR_SMOKE;
}

+ (NSString *)formatTimeDisplay:(int)timestamp
{

    int second = timestamp % 60;
    int minus = timestamp / 60 % 60;
    int hour = timestamp / 60 / 60 % 24;
    int day = timestamp / 60 / 60 / 24;
    
    NSString *formatStr;
    
    if (day != 0)
    {
        formatStr = [NSString stringWithFormat:@"%d 天 %d 时 %d 分 %d 秒", day, hour, minus, second];
    }
    else if (hour != 0)
    {
        formatStr = [NSString stringWithFormat:@"%d 时 %d 分 %d 秒", hour, minus, second];
    }
    else if (minus != 0)
    {
//        formatStr = [NSString stringWithFormat:@"%d 分 %d 秒", minus, second];
        
        formatStr = [NSString stringWithFormat:@"%d 时 %d 分 %d 秒", hour, minus, second];
    }
    else
    {
//        formatStr = [NSString stringWithFormat:@"%d 秒", second];
        formatStr = [NSString stringWithFormat:@"%d 时 %d 分 %d 秒", hour, minus, second];
    }
    
    return formatStr;
}

+ (NSString *)format2TimeDisplay:(int)timestamp
{
    
    int second = timestamp % 60;
    int minus = timestamp / 60 % 60;
    int hour = timestamp / 60 / 60 % 24;
    int day = timestamp / 60 / 60 / 24;
    
    NSString *formatStr;
    
    if (day != 0)
    {
        formatStr = [NSString stringWithFormat:@"%d 天 %02d:%02d:%02d", day, hour, minus, second];
    }
    else if (hour != 0)
    {
        formatStr = [NSString stringWithFormat:@"%02d:%02d:%02d", hour, minus, second];
    }
    else if (minus != 0)
    {
        formatStr = [NSString stringWithFormat:@"%02d:%02d:%02d", hour, minus, second];
    }
    else
    {
        formatStr = [NSString stringWithFormat:@"%02d:%02d:%02d", hour, minus, second];
    }
    
    return formatStr;
}

//获取随机颜色
+ (UIColor *)randColor
{
    static int i = 0;
    NSArray *array = @[@[RANDBlue, RANDGreen], @[RANDGreen2, RANDPink], @[RANDOrange, RANDPurple]];
    NSInteger index = arc4random()%2;
    i++;
    return  array[i%3][index];
}


+ (NSString *)parseGenderByValue:(NSString *)value
{
    NSInteger index = [value intValue];
    switch (index)
    {
        case 1:
        {
            return @"男";
            break;
        }
        case 2:
        {
            return @"女";
            break;
        }
        case 0:
        {
            return @"保密";
            break;
        }
        default:
        {
            return @"";
            break;
        }
    }
    return @"";
}

+ (NSString *)parseGenderByString:(NSString *)string
{
    if ([string isEqualToString:@"男"])
    {
        return @"1";
    }
    else if ([string isEqualToString:@"女"])
    {
        return @"2";
    }
    else if ([string isEqualToString:@"保密"])
    {
        return @"0";
    }
    else
    {
        return @"-1";
    }
}


+ (UIView *)drawLineWithFrame:(CGRect)rect
{
    UIView *line = [[UIView alloc] initWithFrame:rect];
    line.backgroundColor = THEME_COLOR_LINE;
    return line;
}

+ (NSString *)conversionThousandth:(NSString *)string
{
    double value = [string doubleValue];
    NSNumberFormatter *numberFormatter = [[NSNumberFormatter alloc] init];
    [numberFormatter setPositiveFormat:@"###,##0.00;"];
    NSString *formattedNumberString = [numberFormatter stringFromNumber:[NSNumber numberWithDouble:value]];
    return formattedNumberString;
}


+ (UIBarButtonItem *)navrightDownBtn:(id)_target withTitle:(NSString *)title sel:(SEL)selector{
    RightButton *button = [RightButton buttonWithType:UIButtonTypeCustom];
    [button setImage:[UIImage imageNamed:@"under_03"] forState:UIControlStateNormal];
    [button setTitle:title forState:UIControlStateNormal];
    [button setTitleColor:THEME_COLOR_SMOKE forState:UIControlStateNormal];
    button.frame = CGRectMake(100, 100, 65, 20);
    
    button.titleLabel.font = [UIFont fontWithName:FONTNAME size:THEME_FONT_BIG];
    [button addTarget:_target action:selector forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem *item = [[UIBarButtonItem alloc] initWithCustomView:button];
    return item;
}

+ (BOOL)isConnectionAvailable
{
    BOOL isExistenceNetwork = YES;
    Reachability *reach = [Reachability reachabilityWithHostName:@"www.baidu.com"];
    switch ([reach currentReachabilityStatus])
    {
        case NotReachable:
            isExistenceNetwork = NO;
            break;
        case ReachableViaWiFi:
            isExistenceNetwork = YES;
            break;
        case ReachableViaWWAN:
            isExistenceNetwork = YES;
            break;
            
        default:
            break;
    }
    
    return isExistenceNetwork;
}


+ (void)bottomLine:(UIView *)aView
{
    UIView *bottomLine = [UIView newAutoLayoutView];
    [aView addSubview:bottomLine];
    [bottomLine autoPinEdgesToSuperviewEdgesWithInsets:UIEdgeInsetsMake(0, 0, 0, 0) excludingEdge:ALEdgeTop];
    [bottomLine autoSetDimension:ALDimensionHeight toSize:0.5f];
    bottomLine.backgroundColor = THEME_COLOR_LINE;
}

+ (void)topLine:(UIView *)aView;
{
    UIView *topLine = [UIView newAutoLayoutView];
    [aView addSubview:topLine];
    [topLine autoPinEdgesToSuperviewEdgesWithInsets:UIEdgeInsetsMake(0, 0, 0, 0) excludingEdge:ALEdgeBottom];
    topLine.backgroundColor = THEME_COLOR_LINE;
    [topLine autoSetDimension:ALDimensionHeight toSize:0.5f];
}


//!!!!: 画横线
/**
 *  画线
 *
 *  @param position 传入位置
 *
 *  @return
 */
+(UIImageView *)drawLine:(CGPoint)position width:(CGFloat)width
{
    UIImageView * line = [[UIImageView alloc]initWithFrame:CGRectMake(position.x, position.y, width, 0.5)];
    line.layer.masksToBounds = true;
    line.image = [self imageWithColor:UIColorFromRGB(0x666666) andSize:CGSizeMake(width, 0.5)];
    return line;
    
}

//!!!!: 画竖直线
/**
 *	@brief	画竖直线 方法
 *
 *	@param 	position 	线的位置
 *	@param 	height 	线的高度
 *
 *	@return UIImageView
 */
+(UIImageView *)drawVerticalLine:(CGPoint)position height:(CGFloat)height
{
    UIImageView * line = [[UIImageView alloc]initWithFrame:CGRectMake(position.x, position.y, 0.5, height)];
    line.layer.masksToBounds = true;
    line.image = [self imageWithColor:UIColorFromRGB(0x666666) andSize:CGSizeMake(0.5, height)];
    return line;
}

+ (NSString *)getCountDownStr:(int)time
{
    int seconds = 0;
    int minute = 0;
    int hour = 0;
    NSString * secondStr = @"00:";
    NSString * minuteStr = @"00:";
    NSString * hourStr = @"00:";
    seconds = time % 60;
    secondStr = [self getTimeStr:seconds];
    if (time / 60 > 0)
    {
        minute = (time / 60) % 60;
        minuteStr = [self getTimeStr:minute];
    }
    if (minute / 60 > 0)
    {
        hour = minute / 60;
        hourStr = [self getTimeStr:hour];
    }


    return [NSString stringWithFormat:@"%@%@%@",hourStr,minuteStr,secondStr];
}

+ (NSString * )getTimeStr:(int)time
{
    if (time < 10)
    {
        return [NSString stringWithFormat:@"0%d",time];
    }
    else
    {
        return [NSString stringWithFormat:@"%d",time];
    }
}

/**
 *	@brief	指定字符串中 改变指定字符字体及颜色
 *
 *	@param 	fullStr 	    原本字符串
 *	@param 	fullStrFont 	原本字符串的字体
 *	@param 	fullStrColor 	原本字符串的颜色
 *	@param 	changeStrArray 	数组，元素是需要改变字体及颜色的字符
 *	@param 	changeStrFont 	需要改变的字体
 *	@param 	changeStrColor 	需要改变的颜色
 *
 *	@return	NSMutableAttributedString
 */
+(NSMutableAttributedString *)setFullStr:(NSString *)fullStr fullStrWithFont:(UIFont *)fullStrFont fullStrWithColor:(UIColor *)fullStrColor needChangeStrArray:(NSArray *)changeStrArray changeStrWithFont:(UIFont *)changeStrFont changeStrColor:(UIColor *)changeStrColor
{
    NSMutableAttributedString *str = [[NSMutableAttributedString alloc]initWithString:fullStr];
    [str addAttribute:NSForegroundColorAttributeName value:fullStrColor range:NSMakeRange(0, fullStr.length)];
    [str addAttribute:NSFontAttributeName value:fullStrFont range:NSMakeRange(0, fullStr.length)];
    
    for (int i = 0; i < fullStr.length; i++)
    {
        NSString *temp = [fullStr substringWithRange:NSMakeRange(i, 1)];
        if ([changeStrArray containsObject:temp] == YES)
        {
            [str addAttribute:NSForegroundColorAttributeName value:changeStrColor range:NSMakeRange(i, 1)];
            [str addAttribute:NSFontAttributeName value:changeStrFont range:NSMakeRange(i, 1)];
        }
    }
    return str;
}


//红包加密接口

+ (NSString *)encryptParameter:(NSMutableDictionary *)parDict
{
    
    NSMutableString *sign = [NSMutableString string];
    NSArray* arr = [parDict allKeys];
    NSMutableSet *mutArr = [NSMutableSet set];
    for (int i = 0; i < arr.count; i++) {
        NSString *key = [arr objectAtIndex:i];
        NSString *value = [parDict stringObjectForKey:key];
        
        // 去掉空格
        NSString *operateStr = [value stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];
        if (operateStr.length == 0)
        {
            //            [parDict removeObjectForKey:key];
            continue;
        }
        
        [mutArr addObject:key];
        [mutArr addObject:value];
    }
    //    [mutArr sortedArrayUsingDescriptors:nil];
    
    NSArray *sortDesc = @[[[NSSortDescriptor alloc] initWithKey:nil ascending:YES]];
    NSArray *sortArr = [mutArr sortedArrayUsingDescriptors:sortDesc];
    
    
    for (int i = 0 ; i < sortArr.count ; i++)
    {
        [sign appendFormat:@"%@", [sortArr objectAtIndex:i]];
    }
    
    
    [sign appendString:@"999a7a5593324cdb889d9d679d1c5745"];
    
    
    //    NSString *str = [Utility md5:(NSString *)sign];
    NSString * str = [(NSString *)sign md5:(NSString *)sign];
    NSData *data = [[str uppercaseString] dataUsingEncoding:NSUTF8StringEncoding];
    
    NSString *codestr=[[NSString alloc] initWithData:[Base64 encodeData:data] encoding:NSUTF8StringEncoding];
    
    
    return [Utility convertStr:codestr];
}



+ (NSString *)convertStr:(NSString *)str
{
    
    NSMutableString * temp = [[NSMutableString alloc]init];
    for (int i = 0; i < [str length]; i++) {
        
        UniChar  ch = [str characterAtIndex:i];
        if (ch >= 65 && ch <= 90)
        {
            ch = ch + 32;
            [temp appendFormat:@"%C",ch];
        }
        else if (ch >= 97 && ch <= 122)
        {
            ch = ch - 32;
            [temp appendFormat:@"%C",ch];
        }
        else if ( ch >= 48 && ch <= 57 )
        {
            NSMutableString * tempStr = [NSMutableString stringWithFormat:@"%C",ch];
            int tempInt = [tempStr intValue];
            tempInt += 1;
            tempStr = [NSMutableString stringWithFormat:@"%d",tempInt];
            [temp appendString:tempStr];
        }
        else
        {
            [temp appendFormat:@"%C",ch];
        }
    }
    
    NSString * str1 = [temp substringToIndex:5];
    NSString * str2 = [temp substringFromIndex:5];
    temp = [NSMutableString stringWithFormat:@"%@%@",str2,str1];
    NSLog(@"temp == %@",temp);
    return temp;
}

+ (void)removeAlertItemWithProductId:(NSString *)productId
{
    UIApplication *applicat = [UIApplication sharedApplication];
    NSArray *localArray = [applicat scheduledLocalNotifications];
//    NSLog(@"当前通知数 %lu",localArray.count);
    UILocalNotification *localNotification;
    if (localArray) {
        for (UILocalNotification *noti in localArray)
        {
            NSDictionary *dict = noti.userInfo;
            if (dict) {
                NSString *inKey = [dict stringObjectForKey:@"goodsId"];
                if ([inKey isEqualToString:productId])
                {
                    NSLog(@"找到了这个通知");
                    if (localNotification) {
                        localNotification = nil;
                    }
                    localNotification = noti;
                    [applicat cancelLocalNotification:localNotification];
//                    break;
                }
            }
        }
    }
    
//    if (!localNotification)
//    {
//        localNotification = [[UILocalNotification alloc] init];
//    }
//    
//    if (localNotification) {
//        NSLog(@"取消这个通知");
//        [applicat cancelLocalNotification:localNotification];
//        NSLog(@"删除后通知数 %lu",localArray.count);
//        return;
//    }
    
}

//1.5.4添加
//是否同时不存在微信和QQ
+ (BOOL)isInstalledQQAndInstalledWX
{
    if ([WXApi isWXAppInstalled] && [QQApi isQQInstalled])
    {
        return YES;
    }
    else
    {
        return NO;
    }
}

+ (BOOL)isNullQQAndWX
{
    if (![WXApi isWXAppInstalled] && ![QQApi isQQInstalled])
    {
        return YES;
    }
    else
    {
        return NO;
    }
}

+ (BOOL)isInstalledQQ
{
    return [QQApi isQQInstalled];
}

+ (BOOL)isInstalledWX
{
    return [WXApi isWXAppInstalled];
}

//毛玻璃效果
//+ (UIImage *)createMao
//{
//    CIContext *context = [CIContext contextWithOptions:nil];
//    CIImage *inputImage = [[CIImage alloc] initWithImage:[UIImage imageNamed:@"1.png"]];
//    // create gaussian blur filter
//    CIFilter *filter = [CIFilter filterWithName:@"CIGaussianBlur"];
//    [filter setValue:inputImage forKey:kCIInputImageKey];
//    [filter setValue:[NSNumber numberWithFloat:10.0] forKey:@"inputRadius"];
//    // blur image
//    CIImage *result = [filter valueForKey:kCIOutputImageKey];
//    CGImageRef cgImage = [context createCGImage:result fromRect:[result extent]];
//    UIImage *image = [UIImage imageWithCGImage:cgImage];
//    CGImageRelease(cgImage);
//    
//    return image;
//}

+ (NSData *)convertImgTo256K:(UIImage *)img
{
    return [self convertImgWithImg:img targetLength:500 * 1024 rate:0.5];
}

+ (NSData *)convertImgWithImg:(UIImage *)img targetLength:(NSUInteger)targetLength rate:(float)rate
{
    UIImage *newImg = nil;
    NSData *newData = UIImageJPEGRepresentation(img, rate);
    NSUInteger difLength = [UIImageJPEGRepresentation(img, 1.0) length] - newData.length;
    NSUInteger lastLength = newData.length;
    
    while (difLength >= (targetLength / 10.0f))
    {
        if (lastLength > targetLength)
        {
            newImg = [UIImage imageWithData:newData];
            newData = UIImageJPEGRepresentation(newImg, rate);
        }
        
        difLength = lastLength - newData.length;
        lastLength = newData.length;
    }
    
    return newData;
}

@end
