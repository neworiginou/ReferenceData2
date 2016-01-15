//
//  Utility-OC.m
//  Partner-Swift
//
//  Created by caijingpeng.haowu on 15/2/23.
//  Copyright (c) 2015年 caijingpeng.haowu. All rights reserved.
//
//  修改记录：
//      姓名         日期               修改内容
//     陆晓波     2015-02-28           添加isPureInt,isPureFloat用于判断是否纯数字

#import "Utility-OC.h"
#import "Partner_Swift-Swift.h"

@implementation Utility_OC

+ (NSStringDrawingOptions)combine
{
    return NSStringDrawingTruncatesLastVisibleLine | NSStringDrawingUsesLineFragmentOrigin | NSStringDrawingUsesFontLeading;
}

+ (BOOL)isPureInt:(NSString*)string{
    NSScanner* scan = [NSScanner scannerWithString:string];
    int val;
    return[scan scanInt:&val] && [scan isAtEnd];
}

+ (BOOL)isPureFloat:(NSString*)string{
    NSScanner* scan = [NSScanner scannerWithString:string];
    float val;
    return[scan scanFloat:&val] && [scan isAtEnd];
}


// 根据nib创建对象
id loadObjectFromNib(NSString *nib, Class cls, id owner) {
    NSArray *nibs = [[NSBundle mainBundle] loadNibNamed:nib owner:owner options:nil];
    for (id oneObj in nibs) {
        if ([oneObj isKindOfClass:cls]) {
            return oneObj;
        }
    }
    return nil;
}

+ (NSValue *)valueWithPoint:(CGPoint)pos
{
    return [NSValue valueWithCGPoint:pos];
}

+ (NSNumber *)numberWithFloat:(CGFloat)y
{
    return [NSNumber numberWithFloat:y];
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
    [btn setImage:[UIImage imageNamed:@"arrow_return"] forState:UIControlStateNormal];
    btn.imageEdgeInsets = UIEdgeInsetsMake(6, -3, 6, 35);
    //    [btn setTitleColor:UIColorFromRGB(0x000000) forState:UIControlStateNormal];
    UIBarButtonItem *left_btn = [[UIBarButtonItem alloc] initWithCustomView:btn];
    return left_btn;
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
    UILabel *lbl = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 100, 40)];
    lbl.backgroundColor = [UIColor clearColor];
    lbl.textAlignment = NSTextAlignmentCenter;
    lbl.font = [UIFont fontWithName:@"Helvetica Neue" size:19.0f];
    lbl.textColor = [UIColor blackColor];
    lbl.text = _title;
    return lbl;
}

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


+ (UIBarButtonItem *)navButton:(id)_target title:(NSString*)title action:(SEL)selector
{
    UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
    btn.frame = CGRectMake(270, 0, 50, 44);
    [btn setTitle:title forState:UIControlStateNormal];
    btn.titleLabel.font = [UIFont fontWithName:@"Helvetica Neue" size:16];
    //添加自定义
    [btn setTitleColor:UIColorFromRGB(0xff6600) forState:UIControlStateNormal];
    [btn setTitleColor:UIColorFromRGB(0xe85700) forState:UIControlStateHighlighted];
    btn.titleEdgeInsets = UIEdgeInsetsMake(0, 0, 0, -15);
    [btn addTarget:_target action:selector forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem *item = [[UIBarButtonItem alloc]initWithCustomView:btn];
    return item;
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

+ (NSURL *)getStaticMapUrlByCoordinate2D:(CLLocationCoordinate2D)coordinate
{
    //http://www.baidu.com/link?url=4pUici5aU4kaQlBkxj7MgDAnbgzdRXIbFR-jGzd5u2TqXRqqEuF_AfSF19XQbXcAo-CVEfJfX4k8Uzg9_Qzuea
    NSString *staticMapUrl = [NSString stringWithFormat:@"http://api.map.baidu.com/staticimage?center=%f,%f&width=200&height=200&zoom=11&markers=%f,%f&markerStyles=l,A|m",
                              coordinate.latitude, coordinate.longitude,coordinate.latitude, coordinate.longitude];
    NSURL *mapUrl = [NSURL URLWithString:[staticMapUrl stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding]];
    return mapUrl;
}



+ (NSString *)conversionThousandth:(NSString *)string
{
    double value = [string doubleValue];
    NSNumberFormatter *numberFormatter = [[NSNumberFormatter alloc] init];
    [numberFormatter setPositiveFormat:@"###,##0.00;"];
    NSString *formattedNumberString = [numberFormatter stringFromNumber:[NSNumber numberWithDouble:value]];
    return formattedNumberString;
}

+ (NSString *)getMoneyTypeWithStr:(NSString *)str
{
    if ([str isEqualToString:@"所有"])
    {
        return @"0";
    }
    else if ([str isEqualToString:@"分享返现"])
    {
        return @"1";
    }
    else if ([str isEqualToString:@"提现记录"])
    {
        return @"4";
    }
    else if ([str isEqualToString:@"成交记录"])
    {
        return @"7";
    }
    else if ([str isEqualToString:@"上线奖励"])
    {
        return @"8";
    }
    else if ([str isEqualToString:@"权证、金融奖励"])
    {
        return @"9";
    }
    else if ([str isEqualToString:@"其他奖励"])
    {
        return @"10";
    }
    else if ([str isEqualToString:@"0"])
    {
        return @"所有";
    }
    else if ([str isEqualToString:@"4"])
    {
        return @"提现记录";
    }
    else if ([str isEqualToString:@"7"])
    {
        return @"成交记录";
    }
    else if ([str isEqualToString:@"8"])
    {
        return @"上线奖励";
    }
    else if ([str isEqualToString:@"9"])
    {
        return @"权证、金融奖励";
    }
    else if ([str isEqualToString:@"10"])
    {
        return @"其他奖励";
    }
    else
    {
        return @"";
    }
}

+ (NSString *)encryptParameter:(NSMutableDictionary *)parDict
{
    NSString *timestamp = [NSString stringWithFormat:@"%lld",(long long)[[NSDate date] timeIntervalSince1970] * 1000];
    //    [parDict setPObject:timestamp forKey:@"timestamp"];
//    [parDict removeObjectForKey:@"digest"];
    
    NSMutableString *sign = [NSMutableString string];
    NSArray* arr = [parDict allKeys];
    NSMutableSet *mutArr = [NSMutableSet set];
    for (int i = 0; i < arr.count; i++) {
        NSString *key = [arr objectAtIndex:i];
        NSString *value = [parDict stringObjectForKey:key];
        
        // 去掉空格
        NSString *operateStr = [value stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];
//        if (operateStr.length == 0)
//        {
////            [parDict removeObjectForKey:key];
//            continue;
//        }
        
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
    
    NSString *str = [Utility_OC md5:(NSString *)sign];
    NSData *data = [[str uppercaseString] dataUsingEncoding:NSUTF8StringEncoding];
    NSString *codestr=[[NSString alloc] initWithData:[Base64 encodeData:data] encoding:NSUTF8StringEncoding];
    return codestr;
}

+ (NSString *)md5:(NSString *)str
{
    const char *cStr = [str UTF8String];
    unsigned char result[16];
    CC_MD5(cStr, strlen(cStr), result); // This is the md5 call
    return [NSString stringWithFormat:
            @"%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x",
            result[0], result[1], result[2], result[3],
            result[4], result[5], result[6], result[7],
            result[8], result[9], result[10], result[11],
            result[12], result[13], result[14], result[15]
            ];
}
+(NSString *)getUUID
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
@end
