//
//  Utility.m
//  UtilityDemo
//
//  Created by wuxiaohong on 15/3/30.
//  Copyright (c) 2015年 hw. All rights reserved.
//
#define IOS7                            ([[[UIDevice currentDevice] systemVersion] floatValue] >= 7.0 ? YES : NO)
#define kImageBaseUrl                   @""
#import "Utility.h"
#import "Reachability.h"
#import "MBProgressHUD.h"
#import "UIView+AutoLayout.h"

@implementation Utility

/**
*  获取字符串字数   汉字算两个字 英文算一个字
*
*  @param text 传入字符串
*
*  @return 返回字符串位数
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
 *  计算字符串的宽度和高度
 *
 *  @param string 入参的字符串
 *  @param font
 *  @param cSize
 *
 *  @return 
 */
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

/**
 *  计算两点经纬度之间的距离
 *
 *  @param coordinate1 经度
 *  @param coordinate2 纬度
 *
 *  @return 返回距离
 */
+ (double)calculateDistanceCoordinateFrom:(CLLocationCoordinate2D)coordinate1 to:(CLLocationCoordinate2D)coordinate2
{
    
    if (coordinate1.longitude >0  && coordinate1.longitude < 180)
    {
        if (coordinate2.longitude >0  && coordinate2.longitude < 180)
        {
    CLLocation  *currentLocation = [[CLLocation alloc]initWithLatitude:coordinate1.latitude longitude:coordinate2.longitude];
    CLLocation *otherLocation = [[CLLocation alloc]initWithLatitude:coordinate2.latitude longitude:coordinate1.longitude];
    CLLocationDistance distance = [currentLocation distanceFromLocation:otherLocation];
    return distance;
    }
    }
    else
    {
        return 0.00;
    }
    
    return 0.00;
}
/**
 *  数字转弧度
 *
 *  @param num num
 *
 *  @return 返回弧度
 */
+(CGFloat)convertNumToArc:(double)num;
{
    if (num == 0)
    {
        return 0;
    }
    return num * M_PI/180.0;
}
/**
 *  校验手机号
 *
 *  @param mobileNum 入参string
 *
 *  @return 返回bool
 */
+ (BOOL)validateMobile:(NSString *)mobileNum
{
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
    {
        return NO;
    }
}

/**
 *  判断固定电话
 *
 *  @param phoneNum 手机号码
 *
 *  @return
 */
+ (BOOL)validatePhoneTel:(NSString *)phoneNum
{
    
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
}

/**
 *  校验密码有效性
 *
 *  @param pwd 密码
 *
 *  @return
 */
+ (BOOL)validatePassword:(NSString *)pwd
{
    if (pwd.length == 6)
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
 *  反转数组
 *
 *  @param targetArray 传入可变数组
 */

+ (void)reverseArray:(NSMutableArray *)targetArray
{
    for (int i = 0; i < targetArray.count / 2.0f; i++)
    {
        [targetArray exchangeObjectAtIndex:i withObjectAtIndex:(targetArray.count - 1 - i)];
    }
}
/**
 *  日期的显示格式
 *
 *  @param strDate 时间戳
 *
 *  @return
 */
+ (NSString *)showDateWithStringDate:(NSString *)strDate
{
    if (strDate.length < 19)
    {
        //确保格式正确，不正确的话，返回后台给的时间
        return strDate;
    }
    NSDate *dateNow = [NSDate date];
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setDateFormat:@"YYYY-MM-dd HH:mm:ss"];
    NSString *strNow = [formatter stringFromDate:dateNow];
    
    NSString *strToday = [[strNow substringFromIndex:0] substringToIndex:10];
    NSString *strDay = [[strDate substringFromIndex:0] substringToIndex:10];
    if ([strDay isEqualToString:strToday])
    {
        return [[strDate substringFromIndex:11] substringToIndex:5];
        //        return @"今天";
    }
    else
    {
        //判断是否是昨天
        NSDate *dateYesterday = [NSDate dateWithTimeIntervalSinceNow:-(24 * 60 * 60)];
        NSString *strYesterday = [formatter stringFromDate:dateYesterday];
        NSString *strYes = [[strYesterday substringFromIndex:0] substringToIndex:10];
        NSString *strYesGet = [[strDate substringFromIndex:0] substringToIndex:10];
        if ([strYes isEqualToString:strYesGet])
        {
            return @"昨天";
        }
        else
        {
            return [[strDate substringFromIndex:0] substringToIndex:10];//显示年月日
            
        }
    }
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
    UILabel *lab = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 100, 40)];
    lab.backgroundColor = [UIColor clearColor];
    lab.textAlignment = NSTextAlignmentCenter;
    lab.font = [UIFont fontWithName:@"" size:19.0f];
    lab.textColor = [UIColor blackColor];
    lab.text = _title;
    return lab;
}
/**
 *	@brief	通用navigation 右边按钮 有图片
 *
 *	@param 	_target 	接收对象
 *	@param 	selector    调用方法
 *
 *	@return	BarButtonItem
 */
+ (UIBarButtonItem *)navRightBackBtn:(id)_target action:(SEL)selector imageStr:(NSString *)imageStr
{
    UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
    btn.frame = CGRectMake(280, 0, 50, 18);
    [btn setImage:[UIImage imageNamed:imageStr] forState:UIControlStateNormal];
    [btn addTarget:_target action:selector forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem *item = [[UIBarButtonItem alloc]initWithCustomView:btn];
    return item;
}
/**
 *	@brief	通用navigation 返回按钮
 *
 *	@param 	_target 	接收对象
 *	@param 	selector    调用方法
 *
 *	@return	BarButtonItem
 */
+ (UIBarButtonItem *)navLeftBackBtn:(id)_target action:(SEL)selector
{
    UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
    [btn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [btn setFrame:CGRectMake(0, 0, 50, 30)];
    [btn addTarget:_target action:selector forControlEvents:UIControlEventTouchUpInside];
    [btn setImage:[UIImage imageNamed:@"navigation_back"] forState:UIControlStateNormal];
    btn.imageEdgeInsets = UIEdgeInsetsMake(6, -3, 6, 35);
    //    [btn setTitleColor:UIColorFromRGB(0x000000) forState:UIControlStateNormal];
    UIBarButtonItem *left_btn = [[UIBarButtonItem alloc] initWithCustomView:btn];
    return left_btn;
}
/**
 *  右按钮是图片的
 *
 *  @param _target  对象
 *  @param selector 方法
 *  @param image    图片
 *
 *  @return
 */
+ (UIBarButtonItem *)navButton:(id)_target action:(SEL)selector image:(UIImage *)image
{
    UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
    //    btn.backgroundColor = [UIColor greenColor];
    btn.frame = CGRectMake(0, 0, 25, 44);
    [btn setImage:image forState:UIControlStateNormal];
    btn.imageEdgeInsets = UIEdgeInsetsMake(0, 5, 0, -5);
    [btn addTarget:_target action:selector forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem *item = [[UIBarButtonItem alloc]initWithCustomView:btn];
    return item;
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
    MBProgressHUD *progressHUD = [[MBProgressHUD alloc] initWithView:view];
    [view addSubview:progressHUD];
    progressHUD.detailsLabelText = message;
    progressHUD.mode = MBProgressHUDModeText;
    
    //指定距离中心点的X轴和Y轴的偏移量，如果不指定则在屏幕中间显示
    progressHUD.yOffset = -100.0f;
    //    HUD.xOffset = 100.0f;
    
    [progressHUD showAnimated:YES whileExecutingBlock:^{
        sleep(1);
    } completionBlock:^{
        [progressHUD removeFromSuperview];
    }];
}
/**
 *	@brief	系统提示框
 *
 *	@param 	message 	提示信息
 *
 *	@return
 */
+ (void)showAlertWithMessage:(NSString *)message delegate:(id)delegate
{
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"提示" message:message delegate:delegate cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
    [alert performSelectorOnMainThread:@selector(show) withObject:nil waitUntilDone:YES];
}
/**
 *  风火轮加载信息
 *
 *  @param _targetView 对象
 *  @param _msg        提示信息
 */
+ (void)showMBProgress:(UIView *)_targetView message:(NSString *)_msg
{
    
    MBProgressHUD *progressHUD = [[MBProgressHUD alloc] initWithView:_targetView];
    progressHUD.mode = MBProgressHUDModeIndeterminate;
    [progressHUD show:YES];
    progressHUD.labelText = _msg;
    [_targetView addSubview:progressHUD];
   
}

+ (void)hideMBProgress:(UIView*)_targetView
{
    //[MBProgressHUD hideHUDForView:_targetView animated:YES];
}
/**
 *  设置图片的颜色和尺寸
 *
 *  @param color 颜色
 *  @param size  尺寸
 *
 *  @return 
 */
+ (UIImage *)imageWithColor:(UIColor *)color andSize:(CGSize)size
{
    CGRect rect = CGRectMake(0.0f, 0.0f, size.width, size.height);
    UIGraphicsBeginImageContext(rect.size);
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextSetFillColorWithColor(context, [color CGColor]);
    CGContextFillRect(context, rect);
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return image;
}
/**
 *  获取当前版本
 *
 *  @return
 */
+ (NSString *)getLocalAppVersion
{
    NSString *path = [[NSBundle mainBundle] pathForResource:@"Info" ofType:@"plist"];
    NSDictionary *dict = [NSDictionary dictionaryWithContentsOfFile:path];
    NSString *version = [dict objectForKey:@"CFBundleVersion"];
    return version;
}
/**
 *  图像保存路径
 *
 *  @return
 */
+ (NSString *)savedPath
{
    NSArray *paths=NSSearchPathForDirectoriesInDomains(NSDocumentDirectory,NSUserDomainMask,YES);
    NSString *documentsDirectory=[paths objectAtIndex:0];
    return documentsDirectory;
}
+ (BOOL)isUserLogin
{
    //先注释掉
//    if([HWUserLogin currentUserLogin].key.length == 0)
//        return NO;
//    else
        return YES;
    
    
}

/**
 *  将时间戳转换为时间
 *
 *  @param strTimestamp  传入的时间戳
 *  @param strDateFormat 时间的格式
 *
 *  @return 返回的时间
 */
+ (NSString *)getTimeWithTimestamp:(NSString *)strTimestamp WithDateFormat:(NSString *)strDateFormat
{
    if ([strTimestamp isEqualToString:@"0"]||[strTimestamp length]==0)
    {
        return @"";
    }
    
    
    long long time;
    if (strTimestamp.length == 10) {
        time = [strTimestamp longLongValue];
    }
    else if (strTimestamp.length == 13){
        time = [strTimestamp longLongValue]/1000;
    }
    
    NSDate *date = [NSDate dateWithTimeIntervalSince1970:time];
    
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setDateFormat:strDateFormat];
    NSString *strTime = [formatter stringFromDate:date];
    return strTime;
}

/**
 *  通过时间获得时间戳     传入时间格式为YYYY-MM-dd HH:mm:ss
 *
 *  @param strDate 时间戳
 *
 *  @return 时间
 */
+ (NSString *)getTimeStampWithDate:(NSString *)strDate
{
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setDateFormat:@"yyyy-MM-dd HH:mm"];
    NSDate *date = [formatter dateFromString:strDate];
    
    NSString *timeStamp = [NSString stringWithFormat:@"%ld",(long)[date timeIntervalSince1970]];
    NSString * str  = [NSString stringWithFormat:@"%@000",timeStamp];
    return str;
}
/**
 *  拼接图片url
 *
 *  @param url 入参
 *
 *  @return
 */
+ (NSString *)imageDownloadUrl:(NSString *)url
{
    if ([url hasPrefix:@"http://"])
    {
        return url;
    }
    return [NSString stringWithFormat:@"%@%@", kImageBaseUrl, url];
}
/**
 *  千分位格式
 *
 *  @param string 入参
 *
 *  @return
 */
+ (NSString *)conversionThousandth:(NSString *)string
{
    double value = [string doubleValue];
    NSNumberFormatter *numberFormatter = [[NSNumberFormatter alloc] init];
    [numberFormatter setPositiveFormat:@"###,##0.00;"];
    NSString *formattedNumberString = [numberFormatter stringFromNumber:[NSNumber numberWithDouble:value]];
    return formattedNumberString;
}
/**
 *  判断网络
 *
 *  @return 
 */
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
/**
 *  画底部的线
 *
 *  @param aView
 */
+ (void)bottomLine:(UIView *)aView
{
    UIView *bottomLine = [UIView newAutoLayoutView];
    [aView addSubview:bottomLine];
    [bottomLine autoPinEdgesToSuperviewEdgesWithInsets:UIEdgeInsetsMake(0, 0, 0, 0) excludingEdge:ALEdgeTop];
    [bottomLine autoSetDimension:ALDimensionHeight toSize:0.5f];
    //定义颜色之后再换
    bottomLine.backgroundColor = [UIColor whiteColor];
    
}
/**
 *  画顶部的线
 *
 *  @param aView 
 */
+ (void)topLine:(UIView *)aView;
{
    UIView *topLine = [UIView newAutoLayoutView];
    [aView addSubview:topLine];
    [topLine autoPinEdgesToSuperviewEdgesWithInsets:UIEdgeInsetsMake(0, 0, 0, 0) excludingEdge:ALEdgeBottom];
    topLine.backgroundColor = [UIColor whiteColor];
    [topLine autoSetDimension:ALDimensionHeight toSize:0.5f];
    
    
}
/**
 *  画线
 *
 *  @param position 传入位置
 *
 *  @return
 */
+(UIImageView *)drawLine:(CGPoint)position width:(CGFloat)width
{
    UIImageView * line = [[UIImageView alloc]initWithFrame:CGRectMake(position.x, position.y, width, lineHeight)];
    line.layer.masksToBounds = true;
    line.image = [self imageWithColor:CD_LineColor andSize:CGSizeMake(width, lineHeight)];
    return line;

}
/**
 *  生成指定大小的图片 图片中心为指定显示的图片
 *
 *  @param size      尺寸
 *  @param imageName 图片名字
 *
 *  @return
 */
+(UIImage * )getPlaceHolderImage:(CGSize)size string:(NSString *)imageName
{
    if(size.height < 0 || size.width <0)
    {
        return nil;
    }
    UIView * view = [[UIView alloc]initWithFrame:CGRectMake(0, 0, size.width, size.height)];
    view.backgroundColor = [UIColor clearColor];
    UIImageView * imageView = [[UIImageView alloc]init];
    imageView.image = [UIImage imageNamed:imageName];
    imageView.center = CGPointMake(CGRectGetWidth(view.frame)/2.0, CGRectGetHeight(view.frame)/2.0);
    [view addSubview:imageView];
    UIGraphicsBeginImageContextWithOptions(size, YES, [UIScreen mainScreen].scale);
    [view.layer renderInContext:UIGraphicsGetCurrentContext()];
    UIImage * image = UIGraphicsGetImageFromCurrentImageContext();
    
    return image;

}

@end
