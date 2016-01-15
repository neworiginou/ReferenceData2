//
//  Utility.swift
//  Community
//
//  Created by WeiYuanlin on 15/2/2.
//  Copyright (c) 2015年 caijingpeng. All rights reserved.
//
//  功能描述：工具函数类
//
//  修改记录：
//      姓名         日期               修改内容
//     蔡景鹏     2015-02-11           创建文件
//     陆晓波     2015-02-15           添加带有图片的navButton
//     蔡景鹏     2015-02-15           添加日期转农历方法,画线的方法

import Foundation
import CoreLocation
var currentNav = HWBaseNavigationController()
class Utility: NSObject, UIAlertViewDelegate
{
/**
 *	@brief	获取字符串字数   汉字算两个字 英文算一个字
 *
 *	@param 	text 	内容
 *
 *	@return	NSInteger类型 字符串的字数
 */
    class func calculateTextLength(text:String)->NSInteger
    {

        var number:Float = 0.0;
        for character:Character in text
        {
            var string:String = "\(character)";
            if string.lengthOfBytesUsingEncoding(NSUTF8StringEncoding) == 3
            {
                number += 1
            }
            else
            {
                number += 0.5
            }
        }
        return NSInteger(Float(number))
    }
    
    
    
/**
*	@brief	计算两点经纬度间距离
*
*	@param 	coordinate1 	经纬度
*	@param 	coordinate2 	经纬度
*
*	@return	Int型 距离
*/
    class func rad(d: Double?) -> Double
    {
        if d == nil
        {
            return 0
        }
        return d! * M_PI / 180.0
    }
    
    class func calculateDistanceCoordinateFrom(coordinate1: CLLocationCoordinate2D?,to coordinate2: CLLocationCoordinate2D?) -> String
    {
        let earthRadius = 6378.137 // 地球半径
        //需要添加没值时的判断
        let radCoor1: Double = Utility.rad(coordinate1?.latitude)
        let radCoor2: Double = Utility.rad(coordinate2?.latitude)
        
        let a = radCoor1 - radCoor2
        let b = Utility.rad(coordinate1?.longitude) - Utility.rad(coordinate2?.longitude)
        
        var s: Double = 2 * asin(sqrt(pow(sin(a / 2), 2) + cos(radCoor1) * cos(radCoor2) * pow(sin(b / 2), 2)))
        s = s * earthRadius
        s = round(s * 10000) / 10000
        
        let result: NSString = NSString(format: "%.0fm", s)
        
        return result
    }
    
    class func reverseGeocodeLocation(coordinate: CLLocationCoordinate2D) -> Void
    {
        let location = CLLocation(latitude: coordinate.latitude, longitude: coordinate.longitude)
        
        var geocoder = CLGeocoder()
        var p: CLPlacemark?
        
        println(location)
        
        geocoder.reverseGeocodeLocation(location, completionHandler: { (placemarks, error) -> Void in
            
            if error != nil
            {
                println("reverse geodcode fail: \(error.localizedDescription)")
                return
            }
            let pm = placemarks as [CLPlacemark]
            if (pm.count > 0)
            {
                p = placemarks[0] as? CLPlacemark
                let address: NSArray! = p?.addressDictionary["FormattedAddressLines"] as NSArray
                
                let city = p?.addressDictionary["City"] as String
                let subLocality = p?.addressDictionary["SubLocality"] as String
                let addressStr = "\(city) \(subLocality)"
//                println("地址解析： \(addressStr) \(p?.addressDictionary)")
                
                NSNotificationCenter.defaultCenter().postNotificationName(kReverseGeocodeNotification, object: nil, userInfo: NSDictionary(objectsAndKeys: addressStr, "address"))
            }
            else
            {
                println("No Placemarks!")
            }
            
        })
    }
    
/**
 *	@brief	校验手机号码
 *
 *	@param 	 mobileNum	手机号
 *
 *	@return	Bool类型 true/false  正确/错误
 */
    class func validateMobile(mobileNum: String) -> Bool
    {
        if countElements(mobileNum) == 11
        {
            let indexStart = advance(mobileNum.startIndex, 0)
            let indexEnd = advance(mobileNum.startIndex, 1)
            var rang = Range<String.Index>(start: indexStart, end: indexEnd)
            var strFirstNum:String = mobileNum.substringWithRange(rang)
            if strFirstNum == "1"
            {
                return true
            }
            else
            {
                return false
            }
        }
        else
        {
            return false

        }
    }
    
/**
 *	@brief	判断固话
 *
 *	@param 	 phoneNum   电话号码
 *
 *	@return	Bool类型 true/false 正确/错误号码
 */
    class func validatePhoneTel(phoneNum:String) ->Bool
    {
        /**
        25         * 大陆地区固话及小灵通
        26         * 区号：010,020,021,022,023,024,025,027,028,029
        27         * 号码：七位或八位
        28         */
        //021-12345678  0394-12345678
        if (countElements(phoneNum) == 11 || countElements(phoneNum) == 12 || countElements(phoneNum) == 13)
        {
            var strLine:String = "-"
            //12位的固话号码
            let indexStartTwelve = advance(phoneNum.startIndex, 3)
            let indexEndTwelve = advance(phoneNum.startIndex, 4)
            var rangeTwelve = Range<String.Index>(start: indexStartTwelve, end: indexEndTwelve)
            var strNumTwelve = phoneNum.substringWithRange(rangeTwelve)
            //13位的固化号码
            let indexStartThirteen = advance(phoneNum.startIndex, 4)
            let indexEndThirteen = advance(phoneNum.startIndex, 5)
            var rangeThirteen = Range<String.Index>(start: indexStartThirteen, end: indexEndThirteen)
            var strNumThirteen = phoneNum.substringWithRange(rangeThirteen)
            if (strNumTwelve == strLine || strNumThirteen == strLine)
            {
                return true
            }
            else
            {
                return false
            }
            
        }
        else
        {
            return false
        }
    }
    
    /**
    *	@brief	判断手机号前三位 是否正确
    *
    *	@param 	mobileNum 	手机号
    *
    *	@return	Bool类型 true/false
    */
    class func validateMobileWithFirstThree(mobileNum:String)->Bool
    {
        /**
        10         * 中国移动：China Mobile
        11         * 134、135、136、137、138、139、147、150、151、152、157、158、159、182、183、187、188
        12         */
        var CM:NSString = "^1(34|3[5-9]|47|5[0127-9]|8[2378])\\d{0,}$"
        /**
        15         * 中国联通：China Unicom
        16         * 130、131、132、155、156、185、186、145
        17         */
        var CU:NSString = "^1(3[0-2]|45|5[56]|8[56])\\d{0,}$";
        /**
        20         * 中国电信：China Telecom
        21         * 133、153、180、189、177
        22         */
        var CT:NSString = "^1(33|53|77|8[09])\\d{0,}$";
        var regextestcm:NSPredicate = NSPredicate (format: "SELF MATCHES \(CM)", argumentArray: Optional.None)
        var regextestcu:NSPredicate = NSPredicate (format: "SELF MATCHES \(CU)", argumentArray: Optional.None)
        var regextestct:NSPredicate = NSPredicate (format: "SELF MATCHES \(CT)", argumentArray: Optional.None)
        if regextestcm.evaluateWithObject(mobileNum) == true || regextestcu.evaluateWithObject(mobileNum) == true || regextestct.evaluateWithObject(mobileNum) == true
        {
            return true;
        }
        else
        {
            return false
        }
    }
    
/**
 *	@brief	校检密码有效性
 *
 *	@param 	 pwd 输入的密码
 *
 *	@return	Bool类型 true/false
 */
    class func validatePassword(pwd:String)->Bool
    {
        if pwd == "112233" || pwd == "123123" || pwd == "123321" || pwd == "123456" || pwd == "654321" || pwd == "abcdef" || pwd == "abcabc"
        {
            return false
        }
        else if countElements(pwd) == 6
        {
            let indexStartFirst = advance(pwd.startIndex, 0)
            let indexEndFirst = advance(pwd.startIndex, 1)
            var rangeFirst = Range<String.Index>(start: indexStartFirst, end: indexEndFirst)
            var strOne:String = pwd.substringWithRange(rangeFirst)
            var number:Int = 0
            for character:Character in pwd
            {
                if "\(character)" == strOne
                {
                    number += 1
                }
            }
            if number >= 6
            {
                return false
            }
        }
        return true
    }
   
/**
 *	@brief	隐藏电话号码--->186****1325
 *
 *	@param 	 pNum 输入的电话号码
 *
 *	@return	String类型
 */
    class func securePhoneNumber(pNum:String)->String
    {
        if countElements(pNum) != 11
        {
            return pNum
        }
        else
        {
            let indexStart = advance(pNum.startIndex, 7)
            var startStr:String = pNum.substringFromIndex(indexStart)
            let indexEnd = advance(pNum.endIndex, -8)
            var endStr:String = pNum.substringToIndex(indexEnd)
            var reslultStr:String = "\(endStr)****\(startStr)"
            return reslultStr
        }
    }
    
/**
 *	@brief	判断内容是否全部为空
 *
 *	@param 	content 输入的内容
 *
 *	@return	Bool类型 true/false
 */
    class func isAllSpaceWithString(content:String)->Bool
    {
        for character:Character in content
        {
            if "\(character)" != " "
            {
                return false
            }
        }
        return true
    }
    
    /**
    *  删除空格字符中的空格
    *
    *  @param str:String
    *
    *  @return
    */
    
    class func deleteSpace(str:String?) -> String
    {
        if str == nil
        {
            return ""
        }
        else
        {
            let array:NSArray = str!.componentsSeparatedByString(" ")
            let newStr = array.componentsJoinedByString("")
            return newStr

        }
    }
    
/**
 *	@brief	反转素组
 *
 *	@param 	 targetArray   需要反转的数组
 *
 *	@return	N/A
 */
    class func reverseArray(var targetArray:Array<Any>)
    {
        for var i:Int = 0;i < targetArray.count / 2;i++
            {
                var element1 = targetArray[i]
                var element2 = targetArray[targetArray.count - 1 - i]
                targetArray[i] = element2
                targetArray[targetArray.count - 1 - i] = element1
            }
    }
    
/**
 *	@brief	判断是否全是中文
 *
 *	@param 	 text 需要判断的字符串
 *
 *	@return	Bool类型 true/false
 */
    class func isChineseWord(text:String)->Bool
    {
        for character:Character in text
        {
            if "\(character)".lengthOfBytesUsingEncoding(NSUTF8StringEncoding) != 3
            {
                return false
            }
        }
        return true
    }
    
/**
 *	@brief	判断是否是正确的银行卡号
 *
 *	@param 	 bankCardNumber 需要判断的银行卡号
 *
 *	@return	Bool类型 true/false
 */
    class func  isCardNo(bankCardNumber:String)->Bool
    {
        var flag:Bool
        if countElements(bankCardNumber) <= 0
        {
            flag = false
            return flag
        }
        var regex:NSString = "^(\\d{15,19})"
        var bankCardPredicate:NSPredicate = NSPredicate(format: "SELF MATCHES \(regex)", argumentArray: Optional.None)
        return bankCardPredicate.evaluateWithObject(bankCardNumber)
    }
    
/**
 *	@brief	从钥匙串获得UUID,暂时不会写。。。。
 *
 *	@param 	 N/A
 *
 *	@return	String类型 获得的UUID
 */
    class func getUUID()->String
    {
//        if ([SSKeychain passwordForService:@"haowu" account:@"haowu"])
//        {
//            return [SSKeychain passwordForService:@"haowu" account:@"haowu"];
//        }
//        else
//        {
//            CFUUIDRef uuid = CFUUIDCreate(nil);
//            CFStringRef uuidString = CFUUIDCreateString(nil, uuid);
//            NSString *result = (NSString *)CFBridgingRelease(CFStringCreateCopy(NULL, uuidString));
//            CFRelease(uuid);
//            CFRelease(uuidString);
//            [SSKeychain setPassword:result forService:@"haowu" account:@"haowu"];
//            return result;
//        }
        if SSKeychain.passwordForService("haowu", account: "haowu") != Optional.None
        {
            return String(SSKeychain.passwordForService("haowu", account: "haowu"))
        }
//        else
//        {
//            var uuid:CFUUIDRef = CFUUIDCreate(kCFAllocatorNull)
//            var uuidString:CFStringRef = CFUUIDCreateString(kCFAllocatorNull, uuid)
////            var result:String  = String(NSString(CFBridgingRelease(CFStringCreateCopy(kCFAllocatorNull, uuidString))))
//            
//        }
        return ""
    }
        
/**
 *	@brief	根据给的mongokey来拼接成完整链接
 *
 *	@param 	 mongokey 传入的图片的mongokey
 *
 *	@return	String类型 完整URL
 */
    class func imageDownloadWithMongoDbKey(mongokey:String)->String
    {
        return "\(kBaseImageUrl)/haowu-static/read/\(mongokey)"
    }
    class func imageDownload(mongokey:String)->String
    {
        return "\(kBaseImageUrl)/\(mongokey)"
    }

    /**
    调用方法
    
    :param: title 不用传值
    
    :returns: 返回 kConsultUrl
    */
    
    
    class func getConsultUrl()->NSString
    {
        return kConsultUrl;
    }
/**
 *	@brief	设置导航栏的标题
 *
 *	@param 	title  需要设置的标题名称
 *
 *	@return	UIView类型 返回一个label
 */
    class func navTitleView(title:String)->UIView
    {
        var titleLabel:UILabel = UILabel(frame: CGRectMake(kScreenWidth / 2 - 50.0, 2, 100, 40))
        titleLabel.backgroundColor = UIColor.clearColor()
        titleLabel.textAlignment = NSTextAlignment.Center
        titleLabel.font = Define.font(19.0)
        //颜色待定
        titleLabel.textColor = "0x000000".UIColor
        titleLabel.text = title
        return titleLabel
    }

/**
 *	@brief	创建带selector的NavTitle
 *
 *	@param 	 title:String    标题
 *	@param 	_selector:Selector 	selector事件
 *	@param 	_target:AnyObject 	实现方
 *
 *	@return	UIView类型
 */
    class func navTitleView(title:String, _selector:Selector, _target:AnyObject)->UIView
    {
        var view = UIView(frame: CGRectMake(kScreenWidth / 2 - 60.0, 2, 120, 40))
        view.backgroundColor = UIColor.clearColor()
        
        var label = UILabel(frame: CGRectMake(15, 0, 120 - 30, 40))
        label.text = title
        label.textAlignment = NSTextAlignment.Center
        label.backgroundColor = UIColor.clearColor()
        label.font = Define.font(19)
        //颜色待定
        label.textColor = "0x333333".UIColor
        view.addSubview(label)
        label.sizeToFit()
        label.center = CGPointMake(view.frame.size.width / 2.0, view.frame.size.height / 2.0)
        
        var imageView = UIImageView(frame: CGRectMake(CGRectGetMaxX(label.frame) + 3, CGRectGetMidY(label.frame) - 4.5, 9, 9))
        imageView.image = UIImage(named: "button31")
        imageView.backgroundColor = UIColor.clearColor()
        view.addSubview(imageView)
        
        var button = UIButton.buttonWithType(UIButtonType.Custom) as UIButton
        button.frame = view.bounds
        button.setTitleColor(UIColor.blackColor(), forState: UIControlState.Normal)
        button.addTarget(_target, action: _selector, forControlEvents: UIControlEvents.TouchUpInside)
        button.backgroundColor = UIColor.clearColor()
        view.addSubview(button)

        return view
    }
    
/**
 *	@brief	自定义导航栏返回左按钮
 *
 *	@param  target:AnyObject   实现方
 *	@param 	_selector:Selector	selector方法
 *
 *	@return	UIBarButtonItem类型
 */
    class func navLeftBackBtn(target:AnyObject, _selector:Selector)->UIBarButtonItem
    {
        let leftButton = UIButton()
        leftButton.frame = CGRectMake(0, 0, 10, 20);
        leftButton.addTarget(target, action: _selector, forControlEvents: UIControlEvents.TouchUpInside)
        leftButton.setImage(UIImage(named: "arrow_return"), forState: .Normal)
        let releaseButtonItem = UIBarButtonItem(customView: leftButton)
        
        return releaseButtonItem
    }
    

/**
 *	@brief	创建一个segmentcontrol
 *
 *	@param 	items:[AnyObject]  存放标签内容的数组
 *	@param 	_target:AnyObject 	事件
 *	@param 	_selector:Selector"] 	selector响应事件
 *
 *	@return	UIView类型
 */
    class func navTitleViewSegmentCtrlWithItems(items:[AnyObject], _target:AnyObject, _selector:Selector)->UIView
    {
        var segContr:UISegmentedControl = UISegmentedControl(items: items)
        //颜色待定
        segContr.tintColor = "0x8ACF1C".UIColor
        segContr.frame = CGRectMake(0, 0, 170, 30)
        segContr.selectedSegmentIndex = 0
        segContr.setTitleTextAttributes([NSFontAttributeName:Define.font(19)], forState: UIControlState.Normal)
        segContr.addTarget(_target, action: _selector, forControlEvents: UIControlEvents.ValueChanged)
        
        return segContr
    }
    
/**
 *	@brief	创建统一navBar右上角的钱包按钮
 *
 *	@param  target:AnyObject
 *	@param 	_selector:Selector"	响应事件
 *
 *	@return	UIBarButtonItem类型
 */
    class func navWalletButton(target:AnyObject, _selector:Selector)->UIBarButtonItem
    {
        var btn = UIButton.buttonWithType(UIButtonType.Custom) as UIButton
        btn.frame = CGRectMake(280, 0, 50, 44)
        btn.backgroundColor = UIColor.clearColor()
        
        var imageV = UIImageView()
//        var imageV = UIImageView(image: UIImage(named: "moneyMore")!)
        imageV.image = UIImage(named: "moneyMore")
        imageV.frame = CGRectMake(17, 16, btn.frame.size.width - 22, btn.frame.size.height - 32)
        imageV.backgroundColor = UIColor.clearColor()
        btn.addSubview(imageV)
        
        btn.addTarget(target, action: _selector, forControlEvents: UIControlEvents.TouchUpInside)
        var navWalletItem = UIBarButtonItem(customView: btn)
        
        return navWalletItem
    }
    
/**
 *	@brief	统一创建自定义样式的分享按钮
 *
 *	@param 	 target:AnyObject
 *	@param 	_selector:Selector"	响应事件
 *
 *	@return	UIBarButtonItem类型
 */
    class func navShareButton(target:AnyObject, _selector:Selector)->UIBarButtonItem
    {
        var btn = UIButton.buttonWithType(UIButtonType.Custom) as UIButton
        btn.frame = CGRectMake(kScreenWidth-44, 0, 50, 44)
        
        var imageV = UIImageView(image: UIImage(named: "export")!)
        imageV.frame = CGRectMake(27, 11, btn.frame.size.width - 27, btn.frame.size.height - 22)
        btn.addSubview(imageV)
        
        btn.addTarget(target, action: _selector, forControlEvents: UIControlEvents.TouchUpInside)
        var navShareItem = UIBarButtonItem(customView: btn)
        
        return navShareItem
    }
    
/**
*	@brief	创建一个带图片的导航自定义样式的BarbuttonItem
*
*	@param 	 target:AnyObject
*	@param 	_selector:Selector   响应事件
*	@param 	__image:UIImage   图片
*
*	@return	UIBarButtonItem类型
*/
    class func navButton(_target:AnyObject, _selector:Selector , _image:UIImage) -> UIBarButtonItem
    {
        var btn = UIButton.buttonWithType(UIButtonType.Custom) as UIButton
        btn.frame = CGRectMake(0, 0, 25, 44)
        btn.setImage(_image, forState: UIControlState.Normal)
        btn.imageEdgeInsets = UIEdgeInsetsMake(0, 5, 0, -5)
        btn.addTarget(_target, action: _selector, forControlEvents: UIControlEvents.TouchUpInside)
        var item = UIBarButtonItem(customView: btn)
        return item
    }
    
/**
 *	@brief	创建一个单纯文字导航自定义样式的BarbuttonItem
 *
 *	@param 	 target:AnyObject
 *	@param 	_title:String 	标题
 *	@param 	_selector:Selector   响应事件
 *
 *	@return	UIBarButtonItem类型
 */
    class func navButton(target:AnyObject, _title:String, _selector:Selector) -> UIBarButtonItem
    {
        var btn = UIButton.buttonWithType(UIButtonType.Custom) as UIButton
        btn.frame = CGRectMake(270, 0, 50, 44)
        btn.setTitle(_title, forState: UIControlState.Normal)
        btn.titleLabel?.font = Define.font(16.0)
        btn.setTitleColor(CD_MainColor, forState: UIControlState.Normal)
        btn.setTitleColor(CD_Btn_MainColor_Clicked, forState: UIControlState.Highlighted)
        btn.titleEdgeInsets = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: -15)
        btn.addTarget(target, action: _selector, forControlEvents: UIControlEvents.TouchUpInside)
        var navItem = UIBarButtonItem(customView: btn)
        
        return navItem
    }
    
/**
 *	@brief	创建显示角标数字的自定义导航item
 *
 *	@param 	target:AnyObject
 *	@param 	_title:String 	标题
 *	@param 	_selector:Selector 	响应事件
 *	@param 	_count:Int  
 *
 *	@return	UIBarButtonItem类型
 */
    class func navButton(target:AnyObject, _title:String, _selector:Selector, _count:Int) -> UIBarButtonItem
    {
        var btn = UIButton.buttonWithType(UIButtonType.Custom) as UIButton
        btn.frame = CGRectMake(270, 0, 50, 44)
        btn.setTitle(_title, forState: UIControlState.Normal)
        btn.titleLabel?.font = Define.font(15)
        btn.setTitleColor("0x8ACF1C".UIColor, forState: UIControlState.Normal)
        btn.titleEdgeInsets = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: -15)
        
        btn.addTarget(target, action: _selector, forControlEvents: UIControlEvents.TouchUpInside)
        var navItem = UIBarButtonItem(customView: btn)
        
        if _count != 0
        {
            var badgeLab = UILabel(frame: CGRectMake(50 - 10, 8, 14, 14))
            badgeLab.layer.cornerRadius = 7.0;
            badgeLab.layer.masksToBounds = true;
            badgeLab.backgroundColor = "0x39c5b1".UIColor;
            badgeLab.textColor = UIColor.whiteColor()
            badgeLab.textAlignment = NSTextAlignment.Center
            badgeLab.font = Define.font(12.0)
            badgeLab.text = "\(_count)"
            btn.addSubview(badgeLab)
        }
        return navItem
    }
    
/**
 *	@brief	创建自定义发布按钮
 *
 *	@param 	 target:AnyObject
 *	@param 	_selector:Selector 选中事件
 *
 *	@return	UIBarButtonItem类型
 */
    class func navPublishButton(target:AnyObject, _selector:Selector)->UIBarButtonItem
    {
        var btn = UIButton.buttonWithType(UIButtonType.Custom) as UIButton
        btn.frame = CGRectMake(kScreenWidth - 40, 0, 50, 44);
        btn.setImage(UIImage(named:"publishIcon"), forState:UIControlState.Normal)
        btn.imageEdgeInsets = UIEdgeInsetsMake(27 / 2.0, 23 / 2.0 + 10, 27 / 2.0, 23 / 2.0 - 10);
        btn.addTarget(target, action:_selector, forControlEvents:UIControlEvents.TouchUpInside)
        var navPublishitem = UIBarButtonItem(customView: btn)
        
        return navPublishitem;
    }
    
    /**
    *	@brief	显示toast提示框 1秒后自动消失
    *
    *	@param 	message 	提示信息
    *
    *	@return
    */
    class func showToastWithMessage(message:String, _view:UIView)
    {
        var progressHUD:MBProgressHUD = MBProgressHUD(view: _view)
        _view.addSubview(progressHUD)
        progressHUD.detailsLabelText = message;
        progressHUD.mode = MBProgressHUDModeText
        //指定距离中心点的X轴和Y轴的偏移量，如果不指定则在屏幕中间显示
        progressHUD.yOffset = -100.0
        //    HUD.xOffset = 100.0f;
        
        progressHUD.showAnimated(true, whileExecutingBlock: { () -> Void in
            sleep(1)
            return
        }) { () -> Void in
            progressHUD.removeFromSuperview()
        }
        

    }
    
    /**
    *	@brief	图像保存路径
    *
    *	@param 	无
    *
    *	@return
    */
    class func savedPath()->String
    {
        var paths = NSSearchPathForDirectoriesInDomains(NSSearchPathDirectory.DocumentDirectory, NSSearchPathDomainMask.UserDomainMask, true)
        var documentsDirectory = paths[0] as String
       return documentsDirectory;
    }
    
    /**
    *	@brief	系统提示框,
    *
    *	@param 	message 	提示信息
    *
    *	@return
    */
    class func showAlertWithMessage(message:String)
    {
        var alert = UIAlertView(title: "提示", message: message, delegate: Optional.None, cancelButtonTitle: "确定")
        //OC 
        // [alert performSelectorOnMainThread:@selector(show) withObject:nil waitUntilDone:YES];
        alert.show()
    }
    
/**
 *	@brief	创建确定取消提示框
 *
 *	@param  messagecancelStr:String 提示内容
 *	@param 	_delegate:AnyObject？  代理对象
 *
 *	@return	N/A
 */
    class func showAlertWithMessageAndSureCancelBtn(messagecancelStr:String, _delegate:AnyObject?)
    {
        var alert = UIAlertView(title: "提示", message: messagecancelStr, delegate: _delegate as? UIAlertViewDelegate, cancelButtonTitle: "取消", otherButtonTitles: "确定")
        alert.show()
    }
    
/**
 *	@brief	创建一个活动指示器
 *
 *	@param  targetView:UIView  加载的目标View
 *	@param 	_message:String  提示消息
 *
 *	@return	N/A
 */
    class func showMBProgress(targetView:UIView, _message:String)
    {
        var progressHUD = MBProgressHUD(view: targetView)
//        progressHUD.mode = MBProgressHUDModeCustomView;
//        progressHUD.mode = MBProgressHUDModeCustomView
//        progressHUD.customView = imgV;
        progressHUD.show(true)
        progressHUD.hide(true, afterDelay: 10);
        progressHUD.labelText = _message
        targetView.addSubview(progressHUD)
    }
    
/**
 *	@brief	隐藏活动指示器提示框
 *
 *	@param targetView:UIView 目标View
 *
 *	@return	N/A
 */
    class func hideMBProgress(targetView:UIView)
    {
        MBProgressHUD.hideHUDForView(targetView, animated: true)
    }
    
/**
 *	@brief	设置图片的填充色以及尺寸
 *
 *	@param 	color:UIColor  颜色
 *	@param 	_size:CGSize   尺寸
 *
 *	@return	<#return value description#>
 */
    class func imageWithColor(color: UIColor, _size: CGSize) -> UIImage
    {
        var rect = CGRectMake(0.0, 0.0, _size.width * UIScreen.mainScreen().scale, _size.height * UIScreen.mainScreen().scale)
        UIGraphicsBeginImageContext(_size)
        var context: CGContextRef! = UIGraphicsGetCurrentContext()
        CGContextSetFillColorWithColor(context, color.CGColor)
        CGContextFillRect(context, rect)
        var image: UIImage! = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        
        return image
    }
    
    /**
    *	@brief	计算字符串宽度高度
    *
    *	@param 	text:String  字符串
    *	@param 	textFont:UIFont   字体
    *   @param 	constrainedSize:CGSize   约束
    *
    *	@return 大小 size
    */
    
    class func calculateStringSize(text:String, textFont:UIFont, constrainedSize:CGSize) -> CGSize
    {
        if iOS7 == true
        {
            let options: NSStringDrawingOptions = Utility_OC.combine()
            var rect: CGRect = (text as NSString).boundingRectWithSize(constrainedSize, options: options , attributes: [NSFontAttributeName: textFont], context: nil) as CGRect
            
            return rect.size
        }
        return CGSizeZero
    }
    
    /**
    *	@brief	显示千位符
    *
    *	@param 	string: NSString  数字
    *
    *	@return 千位符字符串
    */
    
    class func conversionThousandth(string: NSString) -> NSString
    {
        let value = string.doubleValue
        let numberFormatter = NSNumberFormatter()
        numberFormatter.positiveFormat = "###,##0.00;"
        let formattedNumberStr = numberFormatter.stringFromNumber(NSNumber(double: value))
        return formattedNumberStr!
    }
    
/**
 *	@brief	获取当前版本号
 *
 *	@param
 *
 *	@return
 */
    class func getLocalAppVersion() -> NSString
    {
        let path = NSBundle.mainBundle().pathForResource("Info", ofType: "plist")
        let dict = NSDictionary(contentsOfFile: path!)
        let version = dict?.stringObjectForKey("CFBundleShortVersionString")
        return version!
    }
    
/**
 *	@brief	日期 转 农历 方法
 *
 *	@param  date: NSDate    要转的日期
 *
 *	@return	格式化的农历日期  exp： 农历二月初七
 */
    class func getChineseCalendar(date: NSDate?) -> NSString
    {
        if (date == nil)
        {
            return ""
        }
        
        let chineseYears: NSArray = NSArray(objects:
            "甲子", "乙丑", "丙寅", "丁卯",  "戊辰",  "己巳",  "庚午",  "辛未",  "壬申",  "癸酉",
            "甲戌", "乙亥", "丙子", "丁丑",  "戊寅",  "己卯",  "庚辰",  "辛己",  "壬午",  "癸未",
            "甲申", "乙酉", "丙戌", "丁亥",  "戊子",  "己丑",  "庚寅",  "辛卯",  "壬辰",  "癸巳",
            "甲午", "乙未", "丙申", "丁酉",  "戊戌",  "己亥",  "庚子",  "辛丑",  "壬寅",  "癸丑",
            "甲辰", "乙巳", "丙午", "丁未",  "戊申",  "己酉",  "庚戌",  "辛亥",  "壬子",  "癸丑",
            "甲寅", "乙卯", "丙辰", "丁巳",  "戊午",  "己未",  "庚申",  "辛酉",  "壬戌",  "癸亥")
        let chineseMonths: NSArray = NSArray(objects:"正月", "二月", "三月", "四月", "五月", "六月", "七月", "八月",
        "九月", "十月", "冬月", "腊月");
        
        let chineseDays: NSArray = NSArray(objects:
            "初一", "初二", "初三", "初四", "初五", "初六", "初七", "初八", "初九", "初十",
            "十一", "十二", "十三", "十四", "十五", "十六", "十七", "十八", "十九", "二十",
            "廿一", "廿二", "廿三", "廿四", "廿五", "廿六", "廿七", "廿八", "廿九", "三十")
        
        let localeCalendar = NSCalendar(calendarIdentifier: NSChineseCalendar)
        
        let unitFlags = NSCalendarUnit.CalendarUnitYear | NSCalendarUnit.CalendarUnitMonth |  NSCalendarUnit.CalendarUnitDay
        
        let localeComp: NSDateComponents? = localeCalendar?.components(unitFlags, fromDate: date!)
        
        let y_str: NSString? = chineseYears.pObjectAtIndex(localeComp!.year - 1) as? NSString
        let m_str: NSString? = chineseMonths.pObjectAtIndex(localeComp!.month - 1) as? NSString
        let d_str: NSString? = chineseDays.pObjectAtIndex(localeComp!.day - 1) as? NSString
        
        let chineseCal_str = "农历\(m_str!)\(d_str!)"
        return chineseCal_str
    }
    
/**
 *	@brief	画线 方法
 *
 *	@param 	position: CGPoint  线的位置
 *  @param  width: CGFloat    线的宽度
 *
 *	@return UIImageView
 */
    class func drawLine(position: CGPoint, width: CGFloat) -> UIImageView
    {
        var line: UIImageView! = UIImageView(frame: CGRectMake(position.x, position.y, width, lineHeight))
        line.layer.masksToBounds = true
        line.image = Utility.imageWithColor(CD_LineColor, _size: CGSizeMake(width, 1))
        line.tag = 4259
        return line
    }
    
/**
 *	@brief	画竖直线 方法
 *
 *	@param 	position 	线的位置
 *	@param 	height 	线的高度
 *
 *	@return UIImageView
 */
    class func drawVerticalLine(position: CGPoint, height: CGFloat) -> UIImageView
    {
        var line: UIImageView! = UIImageView(frame: CGRectMake(position.x, position.y, lineHeight, height))
        line.layer.masksToBounds = true
        line.image = Utility.imageWithColor(CD_LineColor, _size: CGSizeMake(height, 1))
        return line
    }
    
    /**
    *  视图添加顶部线
    *
    *  @param contentView:UIView 需要添加顶部线的View
    *
    *  @return
    */
    class func topLine(contentView:UIView)->Void
    {
        let line  = UIView.newAutoLayoutView()
        contentView.addSubview(line)
        line.autoPinEdgesToSuperviewEdgesWithInsets(UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0), excludingEdge: ALEdge.Bottom)
        line.autoSetDimension(ALDimension.Height, toSize: 0.5)
        line.backgroundColor = CD_LineColor
    }
    
    /**
    *  视图添加底部线
    *
    *  @param contentView:UIView 需要添加顶部线的View
    *
    *  @return
    */
   class func bottomLine(contentView:UIView)->Void
    {
        let line  = UIView.newAutoLayoutView()
        contentView.addSubview(line)
        line.autoPinEdgesToSuperviewEdgesWithInsets(UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0), excludingEdge: ALEdge.Top)
        line.autoSetDimension(ALDimension.Height, toSize: 0.5)
        line.backgroundColor = CD_LineColor
    }
    
    class func buttonStyle(button:UIButton,color:UIColor,title:String)->Void
    {
        let image = imageWithColor(color, _size: CGSize(width: kScreenWidth - 30, height: 45))
        button.setBackgroundImage(image, forState: UIControlState.Normal)
        button.layer.cornerRadius = 3
        button.layer.masksToBounds = true
        button.setTitle(title, forState: UIControlState.Normal)
    }
    
/**
 *	@brief	判断日期是否相等  精确到 “天”
 *
 *	@param
 *	@param
 *
 *	@return
 */
    class func isEqualDate(date: NSDate, otherDate: NSDate) -> Bool
    {
        let dateFormat: NSDateFormatter = NSDateFormatter()
        dateFormat.dateFormat = "yyyy-MM-dd"
        let dateStr: NSString = dateFormat.stringFromDate(date)
        let otherDateStr: NSString = dateFormat.stringFromDate(otherDate)
        
        return dateStr.isEqualToString(otherDateStr)
    }
    
/**
 *	@brief	通过 日期格式 将日期字符串 转化为 NSDate 日期
 *
 *	@param 	dateString 	需要转化的字符串
 *	@param 	formate 	日期格式
 *
 *	@return	NSDate类型的 日期
 */
    class func convertDateFromString(dateString: String?, formate: String) -> NSDate?
    {
        if (dateString == nil)
        {
            return NSDate()
        }
        let dateFormat: NSDateFormatter! = NSDateFormatter()
        dateFormat.dateFormat = formate
        let string: String! = "\(dateString!)"
        let finishDate: NSDate? = dateFormat.dateFromString(string)
        return finishDate
    }
    
/**
 *	@brief	通过 日期格式 将日期NSDate类 转化为 日期字符串
 *
 *	@param 	date        需要转化的日期
 *	@param 	formate		日期格式
 *
 *	@return  String类型的 日期
 */
    class func convertStringFromDate(date: NSDate?, formate: String) -> String?
    {
        if (date == nil)
        {
            return nil
        }
        
        let dateFormat: NSDateFormatter! = NSDateFormatter()
        dateFormat.dateFormat = formate
        let finishDateStr: String? = dateFormat.stringFromDate(date!)
        return finishDateStr
    }
    
/**
 *	@brief	生成指定大小的图片 图片中心为指定显示的图片
 *
 *	@param 	size   图片大小
 *	@param 	imageName 	图片中心显示的图片名字
 *
 *	@return	图片 UIImage
 */
    class func getPlaceHolderImage(size: CGSize, imageName: String) -> UIImage?
    {
        return self.getPlaceHolderImage(size, imageName: imageName, backColor: nil)
    }
    
    //重写
    class func getPlaceHolderImage(size: CGSize, imageName: String, backColor: UIColor?) -> UIImage?
    {
        if (size.width == 0 || size.height == 0)
        {
            return nil
        }
//        let size = CGSizeMake(200, 200)
//        println(UIImage(named: "pic_wait_big")?.size)
        let view = UIView(frame: CGRectMake(0, 0, size.width, size.height))
        if(backColor != nil)
        {
            view.backgroundColor = backColor
        }
        else
        {
            view.backgroundColor = CD_BackGroundColor
        }
        let imageView = UIImageView(image: UIImage(named: imageName))
//        imageView.image =
        imageView.center = CGPointMake(CGRectGetWidth(view.frame) / 2.0, CGRectGetHeight(view.frame) / 2.0)
        view.addSubview(imageView)
        
        UIGraphicsBeginImageContextWithOptions(size, true, UIScreen.mainScreen().scale)
        view.layer.renderInContext(UIGraphicsGetCurrentContext())
        let image = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        
        return image
    }
    
/**
 *	@brief	拨打电话
 *
 *	@param 	phoneNumber 	电话号码
 *
 *	@return	是否成功
 */
    class func callPhone(phoneNumber: NSString?) -> Bool
    {
        if (phoneNumber == nil || phoneNumber!.length == 0)
        {
            return false
        }
        
        let callWebView = UIWebView()
        shareAppDelegate.window?.addSubview(callWebView)
        
        let telUrl = NSURL(string: "tel:\(phoneNumber!)")
        callWebView.loadRequest(NSURLRequest(URL: telUrl!))
        return true
    }
    
    class func textFeildStyle(textFeild:UITextField,placeHoderstr:String,superView:UIView) -> Void
    {
        superView.addSubview(textFeild)
        textFeild.autoPinEdgesToSuperviewEdgesWithInsets(UIEdgeInsets(top: 0, left: 15, bottom: 0, right: 0))
        textFeild.placeholder = placeHoderstr
        textFeild.font = Define.font(TF_15)
    }
    
/**
 *	@brief	解析 客户类别 文本及代号 对应关系
 *
 *	@param
 *
 *	@return
 */
    class func parseClientCategory(key: NSString?) -> NSString
    {
//        (0默认，11已报备，12已到访，13已下定，14已成交，21下线客户，22分享客户，23合作客户，24抢到客户，31无意向客户，25租售中心)
        if (key?.isEqualToString("0") == true)
        {
            return "默认"
        }
        else if (key?.isEqualToString("11") == true)
        {
            return "已报备"
        }
        else if (key?.isEqualToString("12") == true)
        {
            return "已到访"
        }
        else if (key?.isEqualToString("13") == true)
        {
            return "已下定"
        }
        else if (key?.isEqualToString("14") == true)
        {
            return "已成交"
        }
        else if (key?.isEqualToString("21") == true)
        {
            return "下线客户"
        }
        else if (key?.isEqualToString("22") == true)
        {
            return "分享客户"
        }
        else if (key?.isEqualToString("23") == true)
        {
            return "合作客户"
        }
        else if (key?.isEqualToString("24") == true)
        {
            return "抢到客户"
        }
        else if (key?.isEqualToString("31") == true)
        {
            return "无意向"
        }
            
       else if (key?.isEqualToString("25") == true)
        {
             return "租售中心"
        }
        else if (key?.isEqualToString("默认") == true)
        {
            return "0"
        }
        else if (key?.isEqualToString("已报备") == true)
        {
            return "11"
        }
        else if (key?.isEqualToString("已到访") == true)
        {
            return "12"
        }
        else if (key?.isEqualToString("已下定") == true)
        {
            return "13"
        }
        else if (key?.isEqualToString("已成交") == true)
        {
            return "14"
        }
        else if (key?.isEqualToString("下线客户") == true)
        {
            return "21"
        }
        else if (key?.isEqualToString("分享客户") == true)
        {
            return "22"
        }
        else if (key?.isEqualToString("合作客户") == true)
        {
            return "23"
        }
        else if (key?.isEqualToString("抢到客户") == true)
        {
            return "24"
        }
        else if (key?.isEqualToString("无意向") == true)
        {
            return "31"
        }
            
       else if (key?.isEqualToString("租售中心") == true)
        {
             return "25"
        }
        else
        {
            return ""
        }
       
    }
    /**
    时间戳转时间
    
    :param: timestampStr  后台返回的时间戳字符串
    :param: dateFormatStr 你要得到的时间格式
    
    :returns: 返回指定格式的时间
    */
    class func getTimeWithTimestamp(timestampStr: NSString, dateFormatStr:String) -> NSString
    {
        if timestampStr.length < 10
        {
            return ""
        }
        let s: NSString = timestampStr.substringToIndex(10)
        var t: NSTimeInterval = s.doubleValue
        var date: NSDate = NSDate(timeIntervalSince1970: t)
        
        let formatter = NSDateFormatter()
        formatter.dateFormat = dateFormatStr
        
        let dateString: NSString = formatter.stringFromDate(date)
//        println(dateString)
        return dateString
    }
    
    /**
    根据时间获得时间戳 13位
    
    :param: dateStr 要转换的时间
    
    :returns: 时间戳
    */
    class func getTimestampWithTime(dateStr: NSString) -> NSString
    {
        var strTime: NSString?
        if dateStr.length > 19
        {
            strTime = dateStr.substringToIndex(19)
        }
        else
        {
            strTime = dateStr
        }
        let formatter = NSDateFormatter()
        formatter.dateFormat = "yyyy-MM-dd HH:mm:ss"
        let date: NSDate = formatter.dateFromString(strTime!)!
//        println(date)
        let t = date.timeIntervalSince1970 * 1000
//        println(t)
        var timestamp: NSString = "\(t)"
        timestamp = timestamp.substringToIndex(timestamp.length - 2)
//        println(timestamp)
        return timestamp
    }
    /**
    根据返回的值判断是女生还是男生
    
    :param: value 判断
    
    :returns: 女生还是男生
    */
    class func parseGenderValue(value:NSString) -> NSString
    {
        if value == "0"
        {
            return "女"
        }
        if value == "1"
        {
            return "男"
        }
        return ""
    }
    
    /**
    *  是否登录
    */
    
    class func isUsrLogin() -> Bool
    {
        if (HWUserLogin.currentUserLogin().key.isEmpty)
    {
            return false
    }
        else
            
    {
//        println("key == \(HWUserLogin.currentUserLogin().key)")
            return true
        }
    
    }
    
    /**
    根据时间戳获得按规则显示的时间
    
    :param: dateStr 要转换的时间戳
    
    :returns: 当天显示为：时+分 昨天显示：昨天 其他：显示YYYY-MM-dd
    */
    class func getTimeFormattWithTimeStamp(dateStr: NSString) -> NSString
    {
        if dateStr.length <= 3
        {
            return "";
        }
        
        let formatter = NSDateFormatter()
        formatter.dateFormat = "yyyy-MM-dd"
        
        let formatter2 = NSDateFormatter()
        formatter2.dateFormat = "HH:mm"
        
        let s: NSString = dateStr.substringToIndex(dateStr.length - 3)
        let t: NSTimeInterval = s.doubleValue
        var date: NSDate = NSDate(timeIntervalSince1970: t)
        let dateToday: NSDate = NSDate()
        
        //判断是否是今天
        let dateStr: NSString = formatter.stringFromDate(date)
        let dateTodayStr: NSString = formatter.stringFromDate(dateToday)    //今天
        
        let dateYesterday: NSDate = NSDate(timeIntervalSinceNow: -(24 * 60 * 60))
        let strYesterday: NSString = formatter.stringFromDate(dateYesterday)
        
        if dateStr.isEqualToString(dateTodayStr)
        {
            return formatter2.stringFromDate(date)
        }
        else if dateStr.isEqualToString(strYesterday)
        {
            let yesterday: NSString = "昨天"
            return yesterday
        }
        else
        {
            return dateStr
        }
        
        
        
//        //判断是否是昨天
//        let calendar: NSCalendar = NSCalendar.currentCalendar()
//        
//        var dateY: NSDateComponents = NSDateComponents()
//        dateY.day -= 1
//        var newDate:NSDate = calendar.dateByAddingComponents(dateY, toDate: dateToday, options: NSCalendarOptions.allZeros)!
//        println(newDate)
//        
//
//        if dateStr.isEqualToString(dateTodayStr)
//        {
//            return formatter2.stringFromDate(date)
//        }
//        else if calendar.isDateInYesterday(date)
//        {
//            let yesterday: NSString = "昨天"
//            return yesterday
//        }
//        else
//        {
//            return dateStr
//        }
    }
    
    //切换控制器
    class func transController(oldCtrl:HWBaseNavigationController,newCtrl:HWBaseNavigationController)
    {
        
        var frame = newCtrl.view.bounds
        let originFrame = newCtrl.view.bounds
        frame.origin.y = UIScreen.mainScreen().bounds.height
        newCtrl.view.frame = frame
        shareAppDelegate.window?.rootViewController?.addChildViewController(newCtrl)
        shareAppDelegate.window?.rootViewController?.transitionFromViewController(oldCtrl, toViewController: newCtrl, duration: 0.5, options: UIViewAnimationOptions.CurveEaseIn, animations: { () -> Void in
            newCtrl.view.frame = originFrame
            
            }, completion: { (finish) -> Void in
                
                if finish == true
                {
                    newCtrl.didMoveToParentViewController(shareAppDelegate.window?.rootViewController)
                    oldCtrl.willMoveToParentViewController(nil)
                    oldCtrl.removeFromParentViewController()
                    currentNav = newCtrl
                    shareAppDelegate.window?.rootViewController?.view.addSubview(newCtrl.view)
                    
                }
                else
                {
                    currentNav = oldCtrl
                }
        })
        
    }

    
// 获取当前登录城市的区域列表
    class func getAearList()
    {
       
        for item in  HWUserLogin.currentUserLogin().cities
        {
            var cityClass = item as HWCityClass
            
            if HWUserLogin.currentUserLogin().cityName == cityClass.cityName!
            {
                HWUserLogin.currentUserLogin().areas = cityClass.areas!
            }
        }
    }


//字符串转为人民币符号
  class  func convertRMBStr(str:NSString) -> NSString
    {
        let number = str.doubleValue
        var numberFormatter = NSNumberFormatter()
        numberFormatter.numberStyle = NSNumberFormatterStyle.CurrencyStyle
        let formatterStr:NSString = numberFormatter.stringFromNumber(number)!
        return formatterStr
    }
    
    /**
    *  金额转换成万元或元
    */
    class func stringFrom(priceStr:NSString) -> NSString
    {
        
        var priceFloat = (priceStr as NSString).doubleValue
        var priceStr: NSString = priceFloat >= 10000 ? NSString(format:"%.2f万",priceFloat / 10000.0) : NSString(format:"%.f元",priceFloat)
        if(priceStr.length >= 5)
        {
            var tmpStr = priceStr.substringWithRange(NSMakeRange(priceStr.length - 4, 4))
            if(tmpStr == ".00万")
            {
                priceStr = priceStr.substringToIndex(priceStr.length - 4)
               priceStr = "\(priceStr)万"
            }
        }
        
        return priceStr
    
    }
    
    /**
    *  判断密码的有效性(必须位字母和数字组合)
    *
    *  @param passWord:String?
    *
    *  @return
    */
    class func validatePassWord(passWord:String?) -> Bool
    {
        if passWord == nil
        {
            return false
        }
        else
        {
            if (countElements(passWord!) > 20 || countElements(passWord!) < 6)
            {
                return false
            }
            else
            {
                if (isAllCharacter(passWord!) == true || isAllNumber(passWord!) == true)
                {
                    return false
                }
                else
                {
                    return true
                }
            }
        }
        
    }
    /**
    *  判断是否全为数字
    *
    *  @param str:String
    *
    *  @return
    */
  class  func isAllNumber(str:String) -> Bool
    {
        for chara in str
        {
            if ("0" <= chara && chara <= "9") == false
            {
                return false
            }
        }
        return true
    }
    
    /**
    *  判断是否全为字符
    *
    *  @param str:String
    *
    *  @return 
    */
   class func isAllCharacter(str:String) -> Bool
    {
        for chara in str
        {
            if ("A" <= chara && chara <= "z") == false
            {
                return false
            }
        }
        return true
    }
    
    /**
    *  延迟函数
    *
    *  @param ) 时间Double类型
    *
    *  @return 执行的block块
    */
    class func delay(#seconds: Double, completion:()->()) {
        let popTime = dispatch_time(DISPATCH_TIME_NOW, Int64( Double(NSEC_PER_SEC) * seconds ))
        dispatch_after(popTime, dispatch_get_main_queue()) {
            completion()
        }
    }

    
    class func setYuanAttibuteString(str:NSString, font:CGFloat) -> NSString
    {
        var achievement:NSString = ""
        if str.isEqualToString("")
        {
            achievement = "￥0.00"
        }
        else
        {
            var numberFormatter = NSNumberFormatter()
            numberFormatter.positiveFormat = "0.00"
            var str:NSString = numberFormatter.stringFromNumber(NSNumber(double:str.doubleValue))!
            achievement = "￥\(str)"
        }
        return achievement
//        var attriStr = NSMutableAttributedString(string: achievement)
//        attriStr.addAttribute(NSFontAttributeName, value: Define.font(font), range: NSMakeRange(0, 1))
//        return attriStr
    }

    /*
    prama:   dateStr 时间戳字符串
    returen: 所要显示的时间的字符串 格式：1、HH:mm（当天）2、MM-dd（年内）3、yyyy-MM-dd（其他）
    */
    class func getIssueTimeStr(dateStr: NSString) -> NSString
    {
        let formatter = NSDateFormatter()
        formatter.dateFormat = "yyyy-MM-dd"
        
        let formatter2 = NSDateFormatter()
        formatter2.dateFormat = "HH:mm"
        
        let formatter3 = NSDateFormatter()
        formatter3.dateFormat = "MM-dd"
        
        let formatter4 = NSDateFormatter()
        formatter4.dateFormat = "yyyy"
        
        if dateStr.length < 10
        {
            return ""
        }
        let s: NSString = dateStr.substringToIndex(10)
        var t: NSTimeInterval = s.doubleValue
        var date: NSDate = NSDate(timeIntervalSince1970: t)
        let dateToday: NSDate = NSDate()
        
        //判断是否是今天
        let dateString: NSString = formatter.stringFromDate(date)//传入时间的
        let dateTodayString: NSString = formatter.stringFromDate(dateToday)    //今天
        let yearString: NSString = formatter4.stringFromDate(date)
        let yearTodayString: NSString = formatter4.stringFromDate(dateToday)
        
        let dateYesterday: NSDate = NSDate(timeIntervalSinceNow: -(24 * 60 * 60))
        let strYesterday: NSString = formatter.stringFromDate(dateYesterday)
        
        if yearString.isEqualToString(yearString)
        {
            if dateString.isEqualToString(dateTodayString)
            {
                //今天
                return formatter2.stringFromDate(date)
            }
            else
            {
                //年内
                return formatter3.stringFromDate(date)
            }
        }
        else
        {
            //今年以外时间
            return dateString
        }
    }
    
}

















