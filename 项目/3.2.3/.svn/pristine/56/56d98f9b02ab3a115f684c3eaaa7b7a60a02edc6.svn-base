//
//  HWScanBorderViewController.swift
//  Partner-Swift
//
//  Created by hw500029 on 15/2/28.
//  Copyright (c) 2015年 caijingpeng.haowu. All rights reserved.
//

import UIKit
import CoreLocation

class HWScanBorderViewController: HWBaseViewController ,HWCustomAlertViewDelegate,CLLocationManagerDelegate{

    var scanResultLabel:UILabel?//扫描结果
    var locationInfoLabel:UILabel?//位置信息
    var actionBtn:UIButton?//扫描按钮
    var btnTitleLabel:UILabel?
    var locationBackView:UIView?//扫描成功后存放扫描结果头像的superView
    var indicator:UIImageView?//扫描指针
    var indicatorShadow:UIImageView?
    
    var scanResultArr = NSMutableArray()
    var isRequestSuccess = false//请求是否成功
    var isRequestFinished = false//请求是否结束
    var isStop = true//是否在扫描
    var pause = false
    var hasStarted = false
    
    var circleNum = 0 //指针旋转圈数
    var brokerId:NSString?//Hi一下入参
    
    var noPointArr = NSMutableArray()
    var pointArr = NSMutableArray()
    
    var locationInfo:locationStruct?//经度
    var currLocation:CLLocation?
    var locationManager: CLLocationManager = CLLocationManager()
    var paraLog:NSString?
    var paraLat:NSString?
    
    var sendtoLog:NSString?
    var sendtoLat:NSString?
    
    var clearView:UIView?
    
    
    
    var xMaxRange:CGFloat = (160 + 34 * 1.2 + 32)
    var yMaxRange:CGFloat = (160 + 34 * 1.2 + 32)
    var xMinRange:CGFloat = (160 - 34 * 1.2 - 32)
    var yMinRange:CGFloat = (160 - 34 * 1.2 - 32)
    
    
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        var point1 = CLLocation(latitude: 31.333155, longitude: 121.466309)
        var point2 = CLLocation(latitude: 31.329244, longitude: 121.465004)
        var distance:CLLocationDistance = point1.distanceFromLocation(point2)
        
//        println("距离 ＝＝＝＝＝＝＝＝＝＝＝＝＝＝ \(Int(distance))")
        
        
        
        
        
        
        
        self.navigationItem.titleView = Utility.navTitleView("扫描经纪人")
        
        pause = false
        
        //定位图标
        let locationImgView = UIImageView.newAutoLayoutView()
        locationImgView.backgroundColor = UIColor.clearColor()
        locationImgView.image = UIImage(named: "map_2")
        self.view.addSubview(locationImgView)
        locationImgView.autoPinEdge(ALEdge.Top, toEdge: ALEdge.Top, ofView: self.view, withOffset:15 * kRate)
        locationImgView.autoPinEdge(ALEdge.Left, toEdge: ALEdge.Left, ofView: self.view, withOffset:15 * kRate)
        locationImgView.autoSetDimension(ALDimension.Height, toSize: 24 * kScreenRate)
        locationImgView.autoSetDimension(ALDimension.Width, toSize: 24 * kScreenRate * 21 / 31)
        
        //所在位置
        locationInfoLabel = UILabel.newAutoLayoutView()
        locationInfoLabel?.backgroundColor = UIColor.clearColor()
        locationInfoLabel?.font = Define.font(TF_15)
        locationInfoLabel?.textColor = CD_Txt_Color_99
        self.view.addSubview(locationInfoLabel!)
        locationInfoLabel?.autoSetDimension(ALDimension.Height, toSize: 24 * kScreenRate)
        locationInfoLabel?.autoPinEdge(ALEdge.Left, toEdge: ALEdge.Right, ofView: locationImgView, withOffset:12)
        locationInfoLabel?.autoAlignAxis(ALAxis.Horizontal, toSameAxisOfView: locationImgView)
        locationInfoLabel?.autoSetDimension(ALDimension.Height, toSize: 24 * kScreenRate)
        //登陆时存储的全局变量获得
        //locationInfoLabel?.text = "宝山区呼兰路"
        
        //扫描结果
        scanResultLabel = UILabel.newAutoLayoutView()
        scanResultLabel?.backgroundColor = UIColor.clearColor()
        scanResultLabel?.textColor = CD_Txt_Color_00
        scanResultLabel?.font = Define.font(TF_19)
        self.view.addSubview(scanResultLabel!)
        scanResultLabel?.autoAlignAxisToSuperviewAxis(ALAxis.Vertical)
        scanResultLabel?.autoPinEdge(ALEdge.Top, toEdge: ALEdge.Bottom, ofView: locationInfoLabel, withOffset: 20)
        scanResultLabel?.autoSetDimension(ALDimension.Height, toSize: TF_19)

        //位置背景图
//        let mapImgView = UIImageView(frame: CGRectMake((kScreenWidth - 310  * kScreenRate) / 2, 145 * kScreenRate, 310 * kScreenRate, 310 * kScreenRate))
//        mapImgView.backgroundColor = UIColor.clearColor()
//        mapImgView.image = UIImage(named:"scanning_bg")
//        self.view.addSubview(mapImgView)
        
        var mapImgView = UIImageView(frame: CGRectMake((kScreenWidth - 310  * kScreenRate) / 2, 145 * kScreenRate - 5, 310 * kScreenRate, 310 * kScreenRate))
        if kScreenWidth < 330
        {
            mapImgView.frame = CGRectMake(5, 145 * kScreenRate - 30, 310, 310)
        }
        mapImgView.backgroundColor = UIColor.clearColor()
        mapImgView.image = UIImage(named:"scanning_bg")
        self.view.addSubview(mapImgView)

        //指针
        indicator = UIImageView.newAutoLayoutView()
        indicator?.backgroundColor = UIColor.clearColor()
        indicator?.image = UIImage(named:"Scanning_icon4")
        mapImgView.addSubview(indicator!)
        if kScreenWidth < 330
        {
            indicator?.autoSetDimension(ALDimension.Width, toSize: 310)
            indicator?.autoSetDimension(ALDimension.Height, toSize: 310)
        }
        else
        {
            indicator?.autoSetDimension(ALDimension.Width, toSize: 310 * kScreenRate)
            indicator?.autoSetDimension(ALDimension.Height, toSize: 310 * kScreenRate)
        }
        
        indicator?.autoCenterInSuperview()
        //指针阴影
        indicatorShadow = UIImageView.newAutoLayoutView()
        indicatorShadow?.backgroundColor = UIColor.clearColor()
        indicatorShadow?.image = UIImage(named:"Scanning_icon3")
        indicator?.addSubview(indicatorShadow!)
        if kScreenWidth < 330
        {
            indicatorShadow?.autoSetDimension(ALDimension.Width, toSize: 310)
            indicatorShadow?.autoSetDimension(ALDimension.Height, toSize: 310)
        }
        else
        {
            indicatorShadow?.autoSetDimension(ALDimension.Width, toSize: 310 * kScreenRate)
            indicatorShadow?.autoSetDimension(ALDimension.Height, toSize: 310 * kScreenRate)
        }
        
        indicatorShadow?.autoCenterInSuperview()
        indicatorShadow?.hidden = true
        
        //扫描成功后显示头像的背景视图
        locationBackView = UIView(frame: CGRectMake((kScreenWidth -  320) / 2, (145 - 5) * kScreenRate - 20, 320 , 320 ))
        locationBackView?.center = mapImgView.center
        locationBackView?.backgroundColor = UIColor.clearColor()
        self.view.addSubview(locationBackView!)
        
        
        //开始/结束按钮
        actionBtn = UIButton.buttonWithType(UIButtonType.Custom) as? UIButton
        actionBtn?.setTranslatesAutoresizingMaskIntoConstraints(false)
        actionBtn?.setBackgroundImage(UIImage(named: "scanning_icon"), forState: UIControlState.Normal)
        actionBtn?.setBackgroundImage(UIImage(named: "scanning_icon"), forState: UIControlState.Highlighted)
        locationBackView?.addSubview(actionBtn!)
        actionBtn?.autoCenterInSuperview()
        actionBtn?.autoSetDimension(ALDimension.Height, toSize: kScreenWidth > 320 ? 68  * kScreenRate: 68 )
        actionBtn?.autoSetDimension(ALDimension.Width, toSize: kScreenWidth > 320 ? 68  * kScreenRate: 68 )
        actionBtn?.addTarget(self, action:"scanAction", forControlEvents: UIControlEvents.TouchUpInside)
        mapImgView.userInteractionEnabled = true
        
        btnTitleLabel = UILabel.newAutoLayoutView()
        btnTitleLabel?.text = "开始"
        btnTitleLabel?.font = Define.font(TF_15)
        btnTitleLabel?.textColor = UIColor.whiteColor()
        btnTitleLabel?.backgroundColor = UIColor.clearColor()
        actionBtn?.addSubview(btnTitleLabel!)
        btnTitleLabel?.autoSetDimension(ALDimension.Height, toSize: 15)
        btnTitleLabel?.autoAlignAxisToSuperviewAxis(ALAxis.Vertical)
        btnTitleLabel?.autoAlignAxis(ALAxis.Horizontal, toSameAxisOfView: actionBtn, withOffset: -15 / 2)
        
        let btnTitleLabel2 = UILabel.newAutoLayoutView()
        btnTitleLabel2.text = "2公里范围内"
        btnTitleLabel2?.font = Define.font(TF_11)
        btnTitleLabel2?.textColor = UIColor.whiteColor()
        btnTitleLabel2?.backgroundColor = UIColor.clearColor()
        actionBtn?.addSubview(btnTitleLabel2)
        btnTitleLabel2?.autoSetDimension(ALDimension.Height, toSize: 15)
        btnTitleLabel2?.autoAlignAxisToSuperviewAxis(ALAxis.Vertical)
        btnTitleLabel2?.autoAlignAxis(ALAxis.Horizontal, toSameAxisOfView: actionBtn, withOffset: 15 / 2)
            
        locationManager.delegate = self
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
        locationManager.distanceFilter = kCLLocationAccuracyKilometer
        locationManager.startUpdatingLocation()

        clearView = UIView(frame:CGRectMake(0, 0, kScreenWidth, contentHeight))
        clearView?.backgroundColor = UIColor.clearColor()
        self.view.addSubview(clearView!)
        var tapGas = UITapGestureRecognizer(target: self, action:"showLocationAlert")
        clearView?.addGestureRecognizer(tapGas)
    }

    func showLocationAlert()
    {
        Utility.showAlertWithMessage("定位失败")
    }
    
    func locationManager(manager: CLLocationManager!, didUpdateLocations locations: [AnyObject]!) {
        manager.stopUpdatingLocation()
//        println("定位成功 locations=========\(locations)")
        
        locationInfoLabel?.text = "位置信息解析中..."
        currLocation = locations.last as? CLLocation
        if currLocation != nil
        {
            let coordinate: CLLocationCoordinate2D = currLocation!.coordinate
            
            paraLog = "\(coordinate.longitude)"
            paraLat = "\(coordinate.latitude)"

        }
        
        if HWUserLogin.currentUserLogin().key.isEmpty == false
        {
            var params = NSMutableDictionary()
            params.setPObject(HWUserLogin.currentUserLogin().key, forKey: "key")
            params.setPObject(paraLat, forKey: "latitude")
            params.setPObject(paraLog, forKey: "longitude")
            params.setPObject(HWUserLogin.currentUserLogin().key, forKey: "key")

            var manager = HWHttpRequestOperationManager.baseManager()
            manager.postHttpRequest(kSaveLaLongitude, parameters: params, queue: nil, success: { (responseObject) -> Void in
                
                
                }, failure: { (code, error) -> Void in
                    
            })
        }

        self.clearView?.removeFromSuperview()

        var p:CLPlacemark?
        var geocoder = CLGeocoder()
        geocoder.reverseGeocodeLocation(currLocation, completionHandler: { (placemarks, error) -> Void in
            
            
            if error != nil
            {
//                println("reverse geodcode fail: \(error.localizedDescription)")
                self.locationInfoLabel?.text = "位置信息解析失败"

                return
            }
            let pm = placemarks as [CLPlacemark]
            if (pm.count > 0)
            {
                p = placemarks[0] as? CLPlacemark
                //self.locationInfoLabel?.text = p?.addressDictionary["State"] as? NSString
                
                self.locationInfoLabel?.text = "\(p!.subLocality!) \(p!.thoroughfare!)" as NSString
            }
            else
            {
                println("No Placemarks!")
                self.locationInfoLabel?.text = "位置信息解析失败"
            }
        })
    }
    
    func locationManager(manager: CLLocationManager!, didFailWithError error: NSError!) {
        Utility.showAlertWithMessage("定位失败")
        println("定位失败")
    }
    
    //MARK:数据请求
    func startScanAction()
    {
        scanResultArr.removeAllObjects()
        
        var parma = NSMutableDictionary()
        parma.setPObject(HWUserLogin.currentUserLogin().key, forKey: "key")
        parma.setPObject(paraLog, forKey: "longitude")
        parma.setPObject(paraLat, forKey: "latitude")
        var manager = HWHttpRequestOperationManager.baseManager()
        manager.postHttpRequest(kScanBrokers, parameters: parma, queue: nil, success:
            { (responseObject) -> Void in
                let responseDic = responseObject as NSDictionary
                let arrDic = responseDic.dictionaryObjectForKey("data")
                let dataArr = arrDic.arrayObjectForKey("brokerList")
                
//                println("brokerList.count ================ \(dataArr.count)")
                var maxCount = 0
                if dataArr.count > 20
                {
                    maxCount = 20
                }
                else
                {
                    maxCount = dataArr.count
                }
                
                for var i = 0; i < maxCount; i++
                {
                    var brocker = HWScanBrokerModel()
                    let dataDic: NSDictionary? = dataArr.pObjectAtIndex(i) as? NSDictionary
                    brocker.fetchData(dataDic!)
                    self.scanResultArr.addObject(brocker)
                }
                
                self.isRequestSuccess = true
                self.isRequestFinished = true
            }) { (failure, error) -> Void in
                println("请求失败")
                self.isRequestSuccess = false
                self.isRequestFinished = true
        }
    }

    
    
    func loadData1()
    {
        //预存九个可能覆盖中间Btn的坐标
        for var i:CGFloat = 3; i<6; i++
        {
            for var j:CGFloat = 3 ; j<6; j++
            {
                var rect = NSValue(CGRect: CGRectMake(i * 35 * kScreenRate, j * 35 * kScreenRate, 35 * kScreenRate, 35 * kScreenRate))
                noPointArr.addObject(rect)
            }
        }
        
        //目前扫描结果不能多于72个
        var isBreak = false
        for var i = 0; i<scanResultArr.count ;i++
        {
            isBreak = false
            
            var rect = NSValue(CGRect: CGRectMake(CGFloat(arc4random()%9) * 35 * kScreenRate, CGFloat(arc4random()%9) * 35 * kScreenRate, 35 * kScreenRate, 35 * kScreenRate))
            
            for b in noPointArr
            {
                if rect == b as NSValue
                {
                    isBreak = true
                    break
                }
            }
            
            for a in pointArr
            {
                if rect == a as NSValue
                {
                    isBreak = true
                    break
                }
            }
    
            if isBreak
            {
                i--
                continue
            }
            
            pointArr.addObject(rect)

        }
//        var current = CLLocation(latitude: 1.12233, longitude: 2222.33333)
//        var before = CLLocation(latitude: 1.221111, longitude: 3.33333)
//        var metre = CLLocationDistance(distance(current, before
//            ))
        self.showScanResult()
    }
    
    
    //显示扫描结果
    func showScanResult()
    {
        for var i = 0; i < scanResultArr.count; i++
        {
            var model: HWScanBrokerModel? = scanResultArr.pObjectAtIndex(i) as? HWScanBrokerModel
            var urlStr = model?.picKey as String
            var imgURL = NSURL(string: Utility.imageDownloadWithMongoDbKey(urlStr))
            var headBtn: UIButton = UIButton.buttonWithType(UIButtonType.Custom) as UIButton
            headBtn.layer.cornerRadius = 32 / 2
            headBtn.layer.masksToBounds = true
            headBtn.layer.borderWidth = 2.0
            headBtn.layer.borderColor = UIColor.whiteColor().CGColor
            headBtn.backgroundColor = UIColor.clearColor()
            let rectValue = pointArr.pObjectAtIndex(i) as NSValue
            headBtn.frame = rectValue.CGRectValue()
            locationBackView?.addSubview(headBtn)
            
            headBtn.setImageWithURL(imgURL, forState: UIControlState.Normal, placeholderImage: UIImage(named:"personal_2"))
            
            headBtn.transform = CGAffineTransformMakeScale(0, 0)
            UIView.animateWithDuration(0.3, animations: { () -> Void in
                headBtn.transform = CGAffineTransformMakeScale(1, 1)
            }, completion: { (Bool) -> Void in
            
            })
            headBtn.tag = 100 + i
            headBtn.addTarget(self, action: "SendHiAction:", forControlEvents: UIControlEvents.TouchUpInside)
        }
        scanResultLabel?.attributedText = self.setResultText("\(pointArr.count)")
        
        pause = false
    }
    
    func setFrame()
    {
        var isBreak = false
        for var i:CGFloat = 0; i < CGFloat(scanResultArr.count); i++
        {
            isBreak = false
            var rect = NSValue(CGRect: CGRectMake(CGFloat(arc4random()%(320 - 32)), CGFloat(arc4random()%(320 - 32)), 32, 32))
            
            
            var x1 = rect.CGRectValue().origin.x
            var y1 = rect.CGRectValue().origin.y
            
            if x1 > xMinRange && x1 < xMaxRange && y1 > yMinRange && y1 < yMaxRange
            {
                isBreak = true
            }
            
            
            for b in pointArr
            {
                var rectbV = b.CGRectValue()
                
                if fabs(rectbV.origin.x - x1) < 32 && fabs(rectbV.origin.y - y1) < 32
                {
                    isBreak = true
                    break
                }
            }
            
            if isBreak
            {
                i--
                continue
            }
            
            pointArr.addObject(rect)
        }
        
        self.showScanResult()
        
        
    }

    
    //MARK:搜索开启/停止
    func scanAction()
    {
        //M_PI_2
//        println("pause =========== \(pause)")
        
        //MYP add 埋点: 扫描经纪人－ 点击扫描
        MobClick.event("Brokerdetails_click")
        
        if isStop == true
        {
            btnTitleLabel?.text = "暂停"
            var animation:CABasicAnimation = rotation(1 / 2, degree: 3.1415926 * 0.5, direction: -1.0, repeateCount: 4)
            animation.delegate = self
            indicator?.layer.addAnimation(animation, forKey: Optional.None);
            pointArr.removeAllObjects()
            scanResultLabel?.attributedText = Optional.None
            
            for b in locationBackView!.subviews
            {
                if b as? UIButton == actionBtn
                {
                    continue
                }
                b.removeFromSuperview()
            }
            indicatorShadow?.hidden = false
            isRequestFinished = false
            circleNum = 0
            
            self.startScanAction()
        }
        else
        {
            pause = true
            btnTitleLabel?.text = "即将暂停"
            return
        }
    
        isStop = false
    }
    
    override func animationDidStop(anim: CAAnimation!, finished flag: Bool)
    {
        //println(flag)
        //动画是否完成
        if flag == true
        {
            circleNum += 1
            
            //是否点了暂停
            if pause == true
            {
                indicator?.layer.removeAllAnimations()
                btnTitleLabel?.text = "开始"
                pause = false
                isStop = true
                indicatorShadow?.hidden = true
            }
            else
            {
                //请求已结束情况下
                if isRequestFinished == true
                {
                    if isRequestSuccess == true
                    {
                        indicator?.layer.removeAllAnimations()
                        //self.loadData1()
                        self.setFrame()
                        btnTitleLabel?.text = "开始"
                        isStop = true
                        pause = false
                        isRequestSuccess == false
                        indicatorShadow?.hidden = true
                        circleNum = 0
                    }
                    else
                    {
                        indicator?.layer.removeAllAnimations()
                        btnTitleLabel?.text = "开始"
                        isStop = true
                        indicatorShadow?.hidden = true
                        circleNum = 0
                    }
                }
                else
                {
                    if circleNum == 15
                    {
                        indicator?.layer.removeAllAnimations()
                        btnTitleLabel?.text = "开始"
                        pause = false
                        isStop = true
                        indicatorShadow?.hidden = true
                        circleNum = 0
                        return
                    }
                    else
                    {
                        indicator?.layer.removeAllAnimations()
                        var animation:CABasicAnimation = rotation(1 / 2, degree: 3.1415926 * 0.5, direction: -1.0, repeateCount: 4)
                        animation.delegate = self
                        indicator?.layer.addAnimation(animation, forKey: Optional.None);
                    }
                }
            }
        }
    }

    //旋转动画
    func rotation(dur:Double,degree:CGFloat,direction:CGFloat,repeateCount:Float)->CABasicAnimation
    {
        var rotationTransform:CATransform3D = CATransform3DMakeRotation(degree, 0, 0, direction);
        var animation:CABasicAnimation = CABasicAnimation();
        var animationValue:NSValue = NSValue(CATransform3D: rotationTransform);
        animation.keyPath = "transform";
        animation.delegate = self
        animation.toValue = animationValue;
        animation.duration = dur;
        animation.autoreverses = false;
        animation.cumulative = true;
        animation.repeatCount = repeateCount;
        return animation;
    }

    //设置扫描结果颜色
    func setResultText(num:NSString) ->NSMutableAttributedString
    {
        println(num.length)
        var attriStr = NSMutableAttributedString(string:"共扫描 \(num) 个经纪人")
        attriStr.addAttribute(NSForegroundColorAttributeName, value:CD_MainColor, range: NSMakeRange(4, num.length))
        return attriStr
    }

    //MARK:Hi相关
    func SendHiAction(sender:UIButton)
    {
        //MYP add 埋点：扫描经纪人－Hi一下
        MobClick.event("Hi_click")
        
        var model: HWScanBrokerModel? = scanResultArr.pObjectAtIndex(sender.tag - 100) as? HWScanBrokerModel
        
        brokerId = model?.brockerID
        var dic = NSMutableDictionary()
        dic.setPObject(model?.picKey, forKey: "picKey")
        dic.setPObject(model?.brockerName, forKey: "brokerName")
        if model != nil
        {
            sendtoLat = model!.latitude
            sendtoLog = model!.longitude
        }
        dic.setPObject(sendtoLat as String, forKey: "lat")
        dic.setPObject(sendtoLog as String, forKey: "log")
        
        dic.setPObject(paraLat as String, forKey: "currLat")
        dic.setPObject(paraLog as String, forKey: "currLog")
        
        let al = HWCustomAlertView(type: AlertViewType.HiToOther, infoDic: dic)
        shareAppDelegate.window?.addSubview(al)
        al.delegate = self
        al.showAnimate()
    }
    
    
    func didSelectdConfirm() {
        println("回调成功")
        //1000002002245
        var parma = NSMutableDictionary()
        parma.setPObject(HWUserLogin.currentUserLogin().key, forKey: "key")
        parma.setPObject(brokerId, forKey: "brokerId")
        parma.setPObject(paraLat, forKey: "latitude")
        parma.setPObject(paraLog, forKey: "longitude")
//        parma.setPObject("0.0", forKey: "latitude")
//        parma.setPObject("0.0", forKey: "longitude")
        var manager = HWHttpRequestOperationManager.baseManager()
        manager.postHttpRequest(kSendHiToOther, parameters: parma, queue: nil, success:
            { (responseObject) -> Void in
                println("Hi成功")
            
            }) { (failure, error) -> Void in
                println("请求失败")

        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
