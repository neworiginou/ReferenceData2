//
//  HWNewDetailVC.swift
//  SwiftProject
//
//  Created by zhangxun on 15/2/10.
//  Copyright (c) 2015年 zhangxun. All rights reserved.
//

import UIKit


class HWNewDetailModel {
    //活动日期
    var activityDate : NSString?
    //地址
    var address : NSString?
    //优惠
    var preferential : NSString?
    //佣金
    var brokerages : NSArray?
    //现金
    var cashAward : NSString?
    //合作数
    var cooperationBrokerNum : NSString?
    //项目Id
    var projectId : NSString?
    //项目名称
    var houseName : NSString?
    //意向客户数
    var intentionClientNum : NSString?
    //已报备客户数
    var myRecommendClientNum : NSString?
    //新房活动列表
    var newHouseActivityVoList : NSArray?
    //户型图？
    var newHouseTypeVoList : NSArray?
    //价格
    var price : NSString?
    //项目经理
    var projectManager : NSString?
    //经理电话
    var projectManagerPhone :String?
    //分享URL
    var shareUrl : NSString?
    //纬度
    var latitude : NSString?
    //经度
    var longitude : NSString?
    //楼盘图 效果图
    var housePic : NSArray?
    //户型图
    var picHx : NSArray?
    //交通图
    var picJt : NSArray?
    //实景图
    var picSj : NSArray?
    //样板图
    var picYb : NSArray?
    //房源参数URL
    var partnerURL : NSString?
    //优惠券数组
    var coupons:NSArray = NSArray()
    
    init(dictionary : NSDictionary)
    {
        activityDate = dictionary.stringObjectForKey("activityDate")
        address = dictionary.stringObjectForKey("address")
        brokerages = dictionary.arrayObjectForKey("brokerages")
        cashAward = dictionary.stringObjectForKey("cashAward")
        cooperationBrokerNum = dictionary.stringObjectForKey("cooperationBrokerNum")
        projectId = dictionary.stringObjectForKey("projectId")
        houseName = dictionary.stringObjectForKey("houseName")
        intentionClientNum = dictionary.stringObjectForKey("intentionClientNum")
        myRecommendClientNum = dictionary.stringObjectForKey("myRecommendClientNum")
        newHouseActivityVoList = dictionary.arrayObjectForKey("newHouseActivityVoList")
        newHouseTypeVoList = dictionary.arrayObjectForKey("newHouseTypeVoList")
        preferential = dictionary.stringObjectForKey("preferential")
        price = dictionary.stringObjectForKey("price")
        projectManager = dictionary.stringObjectForKey("projectManager")
        shareUrl = dictionary.stringObjectForKey("shareUrl")
        latitude = dictionary.stringObjectForKey("latitude")
        longitude = dictionary.stringObjectForKey("longitude")
        partnerURL = dictionary.stringObjectForKey("houseParamUrl")
        projectManagerPhone = dictionary.stringObjectForKey("projectManagerPhone")
        housePic = dictionary.arrayObjectForKey("housePic")
        picHx = dictionary.arrayObjectForKey("picHx")
        picJt = dictionary.arrayObjectForKey("picJt")
        picSj = dictionary.arrayObjectForKey("picSj")
        picYb = dictionary.arrayObjectForKey("picYb")
        coupons = dictionary.arrayObjectForKey("coupons")
    }
}

class HWNewDetailVC: UIViewController,UIScrollViewDelegate,UITableViewDelegate,UITableViewDataSource,UIAlertViewDelegate
{
//    let kScreenWidth : Float  = UIScreen.mainScreen().bounds.size.width
    
    var newModel : HWNewDetailModel?
    var newHouseListModel:HWNewHouseListModel = HWNewHouseListModel()
    var showAll : Bool = true
    var pageC : UIPageControl!
    var downArrow : UIImageView!
    var firEffectImageV : UIImageView?
    var addbtn : UIButton?
    var confirmBtn : UIButton?
    var mainTableView : UITableView!
    var houseId : String!
    
    var baobeiBtn : UIButton!
    var showBaobeiBtn : UIButton?
    
    var callWebView : UIWebView!
    //房源图片
    var imageArr : NSMutableArray  = NSMutableArray()
    var mapTap: UITapGestureRecognizer!
    var mapIV: UIImageView!
    var headerView: UIView!
    var titleArr:NSArray!
    var selectView:HWCustomSiftView!
    var isCollection:Bool!
    
    //MYP add v3.2.1
    var navRightItem1:UIBarButtonItem!
    var navRightItem2:UIBarButtonItem!
    var hasCollected:Bool = false
    
    override func viewDidLoad()
    {
        super.viewDidLoad()
        self.view.backgroundColor = CD_BackGroundColor
        self.navigationItem.leftBarButtonItem = Utility.navLeftBackBtn(self, _selector: "doBack")
        self.navigationItem.titleView = Utility.navTitleView("楼盘详情")
        //self.navigationItem.rightBarButtonItem = Utility.navButton(self, _selector: "doShare", _image: UIImage(named: "newhomes_share")!)
        
        //MYP add v3.2.1新增新房收藏功能
        if hasCollected == true
        {
            navRightItem1 = Utility.navButton(self, _selector: "clickCollectBtn", _image: UIImage(named: "collect2")!)
        }
        else
        {
            navRightItem1 = Utility.navButton(self, _selector: "clickCollectBtn", _image: UIImage(named: "collect1")!)
        }
        
        navRightItem2 = Utility.navButton(self, _selector: "doShare", _image: UIImage(named: "newhomes_share")!)
        self.navigationItem.rightBarButtonItems = [navRightItem2, navRightItem1]
    }
   
    //MYP add v3.2.1 收藏房源/取消收藏
    func clickCollectBtn()
    {
        //取消收藏
        if hasCollected == true
        {
            Utility.hideMBProgress(shareAppDelegate.window!)
            Utility.showMBProgress(shareAppDelegate.window!, _message: "上传中")
            
            let manager = HWHttpRequestOperationManager.baseManager()
            var param = NSMutableDictionary()
            
            param.setPObject(HWUserLogin.currentUserLogin().key, forKey: "key")
            param.setPObject(houseId, forKey: "projectId")
            
            manager.postHttpRequest(kNewHouseCancelCollect, parameters: param, queue: nil, success: { (responseObject) -> Void in
                
                Utility.hideMBProgress(shareAppDelegate.window!)
                Utility.showToastWithMessage("取消收藏成功", _view: self.view)
                
                self.hasCollected = false
                self.navRightItem1 = Utility.navButton(self, _selector: "clickCollectBtn", _image: UIImage(named: "collect1")!)
                self.navigationItem.rightBarButtonItems = [self.navRightItem2, self.navRightItem1]
                NSNotificationCenter.defaultCenter().postNotificationName("myHouseCollectRefresh", object: nil)
                }) { (code, error) -> Void in
                    
                    Utility.hideMBProgress(shareAppDelegate.window!)
                    Utility.showToastWithMessage(error, _view: self.view)
            }
        }
        //收藏房源
        else
        {
            Utility.hideMBProgress(shareAppDelegate.window!)
            Utility.showMBProgress(shareAppDelegate.window!, _message: "上传中")
            
            let manager = HWHttpRequestOperationManager.baseManager()
            var param = NSMutableDictionary()
            
            param.setPObject(HWUserLogin.currentUserLogin().key, forKey: "key")
            param.setPObject(houseId, forKey: "projectId")
            
            manager.postHttpRequest(kNewHouseCollect, parameters: param, queue: nil, success: { (responseObject) -> Void in
                
                Utility.hideMBProgress(shareAppDelegate.window!)
                Utility.showToastWithMessage("收藏成功", _view: self.view)
                
                self.hasCollected = true
                self.navRightItem1 = Utility.navButton(self, _selector: "clickCollectBtn", _image: UIImage(named: "collect2")!)
                self.navigationItem.rightBarButtonItems = [self.navRightItem2, self.navRightItem1]
                NSNotificationCenter.defaultCenter().postNotificationName("myHouseCollectRefresh", object: nil)
                }) { (code, error) -> Void in
                    
                    Utility.hideMBProgress(shareAppDelegate.window!)
                    Utility.showToastWithMessage(error, _view: self.view)
            }
        }
    }
    
    func  doShare()
    {
        MobClick.event("Newhouseshare_click")
        if self.newModel != nil
        {
            if (newHouseListModel.typeWalt?.toInt() == 1 || newHouseListModel.typeWalt?.toInt() == 2) && newHouseListModel.waitTime.integerValue == 0
                
            {
                self.shareBefore()
            }
                
            else if (newHouseListModel.typeWalt?.toInt() == 1 || newHouseListModel.typeWalt?.toInt() == 2) && newHouseListModel.waitTime.integerValue > 0
                
            {
                self.shareBefore();
            }
            else
                
            {
                self.share();
            }
        }
   }
    
    func share()
    {
        
        var imageV = UIImageView(image: UIImage(named: "shareIcon")!)
        
        if imageArr.count > 0
        {
            imageV.setImageWithURL(NSURL(string:(imageArr[0] as String)))
            
        }
        
        let houseName: NSString? = self.newModel?.houseName
        let address: NSString? = self.newModel?.address
        let shareUrl: NSString? = self.newModel?.shareUrl
    
        var shareModel : HWShareViewModel = HWShareViewModel(shareContent: "发现一个不错的楼盘 " + houseName! + " " + address!, image: imageV.image, shareUrl: shareUrl!)
        shareModel.projectId = self.houseId
        shareModel.showInView(shareAppDelegate.window, presentController: self)
    

    }
    //分享之前的回调
    func shareBefore()
    {
        Utility.showMBProgress(self.view, _message: "加载中...")
        var params = NSMutableDictionary();
        params.setPObject(Utility_OC.getUUID(), forKey: "mac");
        params.setPObject("8", forKey: "versionCode");
        params.setPObject(HWUserLogin.currentUserLogin().key, forKey: "key");
        params.setPObject(newHouseListModel.activityId, forKey: "activityId");
        var manager = HWHttpRequestOperationManager.baseManager();
        manager.postHttpRequest(kShareBefore, parameters: params, queue: nil, success: { (responObject) -> Void in
            Utility.hideMBProgress(self.view);
            
            let status = responObject.stringObjectForKey("data") as String;
            
            //随机金额
            if(status.toInt() == 1)
            {
                var imageV = UIImageView(image: UIImage(named: "shareIcon")!)
                if self.imageArr.count > 0
                {
                    imageV.setImageWithURL(NSURL(string:(self.imageArr[0] as String)))
                }
                
                let houseName: NSString? = self.newModel?.houseName
                let address: NSString? = self.newModel?.address
                let shareUrl: NSString? = self.newModel?.shareUrl
                
                var shareModel : HWShareViewModel = HWShareViewModel(shareContent: "发现一个不错的楼盘 " + houseName!  + " " + address!, image: imageV.image, shareUrl:shareUrl!)
                shareModel.projectId = self.houseId
                shareModel.showInView(shareAppDelegate.window, presentController: self)
                shareModel.shareSuccess = { type in
                    
                    self.shareSuccessWithType(type as String , model: self.newHouseListModel , status:status as String);
                    
                }
            }
                else if status.toInt() == 3
                {
//                    var imageV = UIImageView(image: UIImage(named: "shareIcon")!)
//                    if self.imageArr.count > 0
//                    {
//                        imageV.setImageWithURL(NSURL(string: self.imageArr[0] as String))
//                    }
//                    var shareModel : HWShareViewModel = HWShareViewModel(shareContent: "发现一个不错的楼盘 " + self.newModel?.houseName! + " " + self.newModel?.address!, image: imageV.image, shareUrl:self.newModel?.shareUrl!)
//                    shareModel.projectId = self.houseId
//                    shareModel.showInView(shareAppDelegate.window, presentController: self)
                    self.share()

                }

                
           
            else
            {
                var alert = UIAlertView(title:"", message: responObject.stringObjectForKey("detail") as String, delegate: self, cancelButtonTitle: "取消", otherButtonTitles: "确定")
                alert.show()
                
            }
            
            }) { (code, error) -> Void in
                Utility.showToastWithMessage(error as String, _view: self.view);
                Utility.hideMBProgress(self.view);
                
        }
        
    }
    
    //分享成功后的回调
    func shareSuccessWithType(type : String! , model : HWNewHouseListModel! , status: String)
    {
        Utility.showMBProgress(self.view, _message: "加载中...");
        var params = NSMutableDictionary();
        params.setObject(Utility_OC.getUUID(), forKey: "mac");
        params.setPObject(type, forKey: "way");
        params.setPObject(newHouseListModel.activityId, forKey: "activityId");
        params.setPObject(HWUserLogin.currentUserLogin().key, forKey: "key");
        params.setPObject(status, forKey: "shareStatus");
        var manager = HWHttpRequestOperationManager.baseManager();
        manager.postHttpRequest(kShareSuccess, parameters: params, queue: nil, success: { (responObject) -> Void in
            Utility.hideMBProgress(self.view);
            var statusDic = responObject.dictionaryObjectForKey("data") as NSDictionary
            var statuss = statusDic .stringObjectForKey("redType")
            
            //固定金额
            if (statuss == "0")
            {
                var vc  = HWWaltMoneyViewController()
                vc.money = model.moneyWalt
                self.navigationController?.pushViewController(vc, animated: true)
                
            }
            else
            {
                var redRocketCtrl = HWRedRocketViewController();
                redRocketCtrl.moneyStr = statusDic.stringObjectForKey("totalMoney");
                redRocketCtrl.redIdStr = statusDic.stringObjectForKey("redId");
                redRocketCtrl.sourceStr = "1"
                 self.navigationController?.pushViewController(redRocketCtrl, animated: true)
            }
            
            }) { (code, error) -> Void in
                Utility.showToastWithMessage(error, _view: self.view);
                Utility.hideMBProgress(self.view);
                
        }
    }
    
    
    
    func alertView(alertView: UIAlertView, clickedButtonAtIndex buttonIndex: Int)
    {
        
        if (buttonIndex == 1)
        {
            
//            var imageV = UIImageView(image: UIImage(named: "shareIcon")!)
//            if self.imageArr.count > 0
//            {
//                imageV.setImageWithURL(NSURL(string: self.imageArr[0] as String))
//            }
//            
//            var shareModel : HWShareViewModel = HWShareViewModel(shareContent: "发现一个不错的楼盘 " + (newModel?.houseName! as String) + " " + (newModel?.address! as String), image: imageV.image, shareUrl:newModel?.shareUrl as String)
//            shareModel.projectId = self.houseId
//            shareModel.showInView(shareAppDelegate.window, presentController: self)
             self.share()
           
        }
    }
    
    


    override func didReceiveMemoryWarning()
    {
        super.didReceiveMemoryWarning()
    }
    
    func doBack()
    {
        NSNotificationCenter .defaultCenter() .postNotificationName("queryListData", object: nil)
        self.navigationController?.popViewControllerAnimated(true)
    }
    //请求数据
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        self.queryData()
    }
    func queryData()
    {
        var manager = HWHttpRequestOperationManager.baseManager()
        var dict = NSMutableDictionary()
        dict.setPObject(houseId, forKey: "projectId")
        dict.setPObject(HWUserLogin.currentUserLogin().key, forKey: "key")
        Utility.hideMBProgress(self.view)
        Utility.showMBProgress(self.view, _message: "请稍等")
        manager.postHttpRequest(kNewHouseDetail, parameters: dict, queue: nil, success: { (responObject) -> Void in
            Utility.hideMBProgress(self.view)
            self.newModel = HWNewDetailModel(dictionary: responObject.dictionaryObjectForKey("data"))
            self.createTable()
        }) { (failure, error) -> Void in
            Utility.hideMBProgress(self.view)
            Utility.showToastWithMessage(error as String, _view: self.view)
        }
        
    }
//    创建表格
    func createTable()
    {
        if mainTableView != Optional.None
        {
            mainTableView.removeFromSuperview()
            mainTableView = nil
            
            baobeiBtn.removeFromSuperview()
            baobeiBtn = nil
            
            showBaobeiBtn?.removeFromSuperview()
            showBaobeiBtn = nil
        }
        mainTableView = UITableView(frame: CGRectMake(0, 0, kScreenWidth, contentHeight - 45))
        mainTableView.delegate = self
        mainTableView.dataSource = self
        mainTableView.backgroundColor = CD_BackGroundColor
        mainTableView.separatorStyle = UITableViewCellSeparatorStyle.None
        self.view.addSubview(mainTableView)
        self.createHeader()
        self.createFooter()
        
        baobeiBtn = UIButton.buttonWithType(UIButtonType.Custom) as UIButton
        baobeiBtn.frame = CGRectMake(0, contentHeight - 45, kScreenWidth, 45)
        baobeiBtn.setBackgroundImage(Utility.imageWithColor("ff6600".UIColor, _size: CGSizeMake(1, 1)), forState: UIControlState.Normal)
        baobeiBtn.setTitle("报备客户", forState: UIControlState.Normal)
        baobeiBtn.addTarget(self, action: "baobeiCustomer", forControlEvents: UIControlEvents.TouchUpInside)
        self.view.addSubview(baobeiBtn)
        var showBaobei : Bool = false
        if newModel?.myRecommendClientNum?.integerValue > 0
        {
            showBaobei = true
        }
        if showBaobei{
            baobeiBtn.frame = CGRectMake(kScreenWidth / 2.0, contentHeight - 45, kScreenWidth / 2.0, 45)
            showBaobeiBtn = UIButton(frame: CGRectMake(0, contentHeight - 45, kScreenWidth / 2.0, 45))
            showBaobeiBtn?.setBackgroundImage(Utility.imageWithColor("999999".UIColor, _size: CGSizeMake(1, 1)), forState: UIControlState.Normal)
            showBaobeiBtn?.setBackgroundImage(Utility.imageWithColor("878787".UIColor, _size: CGSizeMake(1, 1)), forState: UIControlState.Highlighted)
            var str : NSString? = newModel?.myRecommendClientNum
            
            showBaobeiBtn?.setTitle("已报备客户\(str!)", forState: UIControlState.Normal)
            showBaobeiBtn?.addTarget(self, action: "getBaoBeiCustomer", forControlEvents: UIControlEvents.TouchUpInside)
            self.view.addSubview(showBaobeiBtn!)
        }
    }
//    创建header
    func createHeader()
    {
        headerView = UIView(frame: CGRectMake(0, 0, kScreenWidth, kScreenWidth * 0.5 + 155 * kRate - 3 * kRate))
        headerView.backgroundColor = UIColor.whiteColor()
        
        var sv : UIScrollView = UIScrollView(frame: CGRectMake(0, 0, kScreenWidth, kScreenWidth * 0.5))
        sv.backgroundColor = UIColor.blackColor()
        sv.delegate = self
        sv.pagingEnabled = true
        sv.showsHorizontalScrollIndicator = false
        sv.showsVerticalScrollIndicator = false
        
        imageArr = NSMutableArray()
        if(newModel?.housePic != nil)
        {
            imageArr.addObjectsFromArray(newModel?.housePic! as [AnyObject])
        }
//        newModel?.picHx!.count + newModel?.picJt!.count + newModel?.picSj!.count + newModel?.picYb!.count
        for var i = 0; i < newModel?.picHx!.count; i++
        {
            let dict : NSDictionary = newModel?.picHx?.pObjectAtIndex(i) as NSDictionary
            imageArr.addObject(dict.stringObjectForKey("pic"))
        }
        imageArr.addObjectsFromArray(newModel?.picJt! as [AnyObject])
        imageArr.addObjectsFromArray(newModel?.picSj! as [AnyObject])
        imageArr.addObjectsFromArray(newModel?.picYb! as [AnyObject])
        
        for (var i = 0; i < imageArr.count; i++)
        {
            var imageV = UIImageView(frame: CGRectMake(kScreenWidth * CGFloat(i), 0, kScreenWidth, kScreenWidth * 0.5))
            imageV.setImageWithURL((NSURL(string: imageArr[i] as String)), placeholderImage: Utility.getPlaceHolderImage(CGSizeMake(kScreenWidth, kScreenWidth / 2.0), imageName: placeHolderBigImage))
            imageV.contentMode = UIViewContentMode.ScaleAspectFill
            
            if i == 0
            {
                firEffectImageV = imageV
            }
            sv.addSubview(imageV)
            
        }
        if imageArr.count == 0
        {
            var imageV = UIImageView(frame: CGRectMake(0, 0, kScreenWidth,kScreenWidth * 0.5))
            imageV.image = Utility.getPlaceHolderImage(CGSizeMake(kScreenWidth, kScreenWidth / 2.0), imageName: placeHolderBigImage)
            imageV.contentMode = UIViewContentMode.ScaleAspectFill
            sv.addSubview(imageV)
        }
        sv.contentSize = CGSizeMake(kScreenWidth * CGFloat(imageArr.count), kScreenWidth * 0.5)
        headerView.addSubview(sv)
        
        var tapGes : UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: "showPictureBrowse:")
        sv.addGestureRecognizer(tapGes)
        
        pageC = UIPageControl(frame: CGRectMake(95 * kRate, CGRectGetMaxY(sv.frame) - 25 * kRate, kScreenWidth - 95 * kRate, 20 * kRate))
        pageC.backgroundColor = UIColor.clearColor()
        pageC.numberOfPages = imageArr.count
        headerView.addSubview(pageC)
        
        var countStr : NSMutableString = "共张"
        countStr.insertString("\(imageArr.count)", atIndex: 1)
        var font : UIFont = Define.font(10)
        var size : CGSize = Utility.calculateStringSize(countStr as String, textFont: font, constrainedSize: CGSizeMake(1000, 20))
        
        var countLabel = UILabel(frame: CGRectMake(kScreenWidth - 25 * kRate - size.width * kRate, pageC.frame.origin.y + 2.5 * kRate, (size.width + 10) * kRate, 15 * kRate))
        countLabel.backgroundColor = UIColor(white: 0, alpha: 0.3)
        countLabel.layer.cornerRadius = 3.0
        countLabel.layer.masksToBounds = true
        countLabel.font = font
        countLabel.textAlignment = NSTextAlignment.Center
        countLabel.text = countStr as String
        countLabel.textColor = UIColor.whiteColor()
        headerView.addSubview(countLabel)
        
        var whiteBackView = UIView(frame: CGRectMake(0, sv.frame.size.height, kScreenWidth, 95))
        whiteBackView.backgroundColor = CD_WhiteColor
        headerView.addSubview(whiteBackView)
        
        //地图img 底部阴影view
        var shadowView = UIView(frame: CGRectMake(0, 0, 80 * kRate, 80 * kRate))
        shadowView.center = CGPointMake(shadowView.frame.size.width / 2.0 + 15 * kRate, sv.frame.size.height + 10 * kRate)
        shadowView.backgroundColor = CD_Txt_Color_99
        shadowView.layer.shadowColor = CD_Txt_Color_99.CGColor
        shadowView.layer.shadowOffset = CGSizeMake(0, 2)
        shadowView.layer.shadowOpacity = 0.9
        shadowView.layer.cornerRadius = 40
        shadowView.layer.shadowRadius = 2
        headerView.addSubview(shadowView)
        
        mapIV = UIImageView(frame: CGRectMake(0, 0, 80 * kRate, 80 * kRate))
        mapIV.layer.cornerRadius = mapIV.frame.size.width / 2.0
        mapIV.center = CGPointMake(mapIV.frame.size.width / 2.0 + 15 * kRate, sv.frame.size.height + 10 * kRate)
        mapIV.layer.masksToBounds = true
        mapIV.userInteractionEnabled = true
        mapIV.layer.cornerRadius = 40
        mapIV.image = UIImage(named: "bitmap")
        mapTap = UITapGestureRecognizer(target: self, action: "showMap")
        mapIV.addGestureRecognizer(mapTap)
        
        weak var weakImgV: UIImageView! = mapIV
        
        let longitude: NSString? = newModel?.longitude
        let latitude: NSString? = newModel?.latitude
        
        var l = CLLocationCoordinate2DMake(longitude!.doubleValue, latitude!.doubleValue)
        var url: NSURL = Utility_OC.getStaticMapUrlByCoordinate2D(l)
        mapIV.setImageWithURL(url, placeholderImage: Utility.getPlaceHolderImage(weakImgV.frame.size, imageName: "bitmap")) { (image, error, imageCacheType) -> Void in
            if (error != nil)
            {
                let size: CGSize! = weakImgV.frame.size
                weakImgV?.image = Utility.getPlaceHolderImage(size, imageName: "bitmap")
            }
            else
            {
                weakImgV?.image = image
            }
        }
        headerView.addSubview(mapIV)
        
        var nameLabel = UILabel(frame: CGRectMake(CGRectGetMaxX(mapIV.frame) + 10 * kRate, sv.frame.size.height + 5 * kRate, kScreenWidth - (mapIV.frame.origin.x + mapIV.frame.size.width + 20) * kRate - 15 * kRate, 20 * kRate))
        nameLabel.font = Define.font(16)
        nameLabel.textColor = CD_Txt_Color_33
        nameLabel.backgroundColor = UIColor.clearColor()
        nameLabel.text = newModel?.houseName as? String
        headerView.addSubview(nameLabel)
        
        var priceLabel = UILabel(frame: CGRectMake(nameLabel.frame.origin.x, nameLabel.frame.origin.y + nameLabel.frame.size.height + 5 * kRate, nameLabel.frame.size.width, 20 * kRate))
        priceLabel.backgroundColor = UIColor.clearColor()
        var priceString : NSMutableString = NSMutableString(string: "均价：元/㎡")
        priceString.insertString(newModel?.price! as String, atIndex: 3)
        var attStr : NSMutableAttributedString = NSMutableAttributedString(string: priceString as String)
        attStr.addAttribute(NSForegroundColorAttributeName, value: CD_Txt_MainColor, range: NSMakeRange(0, attStr.length))
        attStr.addAttribute(NSFontAttributeName, value: Define.font(16), range: NSMakeRange(0, attStr.length))
        attStr.addAttribute(NSForegroundColorAttributeName, value: CD_Txt_Color_66, range: NSMakeRange(0, 3))
        attStr.addAttribute(NSFontAttributeName, value: Define.font(12), range: NSMakeRange(0, 3))
        priceLabel.attributedText = attStr
        headerView.addSubview(priceLabel)
        
        var rightArrowIV = UIImageView(image: UIImage(named: "arrow_next"))
        rightArrowIV.frame = CGRectMake(kScreenWidth - 8 - 15 * kRate, priceLabel.frame.origin.y, 8, 14)
        headerView.addSubview(rightArrowIV)
        
        var showDetailBtn : UIButton = UIButton.buttonWithType(UIButtonType.Custom) as UIButton
        showDetailBtn.backgroundColor = UIColor.clearColor()
        showDetailBtn.frame = CGRectMake(nameLabel.frame.origin.x, nameLabel.frame.origin.y, nameLabel.frame.size.width, 50);
        showDetailBtn.addTarget(self, action: "showParameter", forControlEvents: UIControlEvents.TouchUpInside)
        headerView.addSubview(showDetailBtn)
        
        var locationIV = UIImageView(image: UIImage(named: "positioning"))
        locationIV.frame = CGRectMake(20 * kRate, mapIV.frame.size.height + mapIV.frame.origin.y + 9 * kRate, 16, 16);
        headerView.addSubview(locationIV)
        
        var locationLabel : UILabel = UILabel(frame: CGRectMake(locationIV.frame.origin.x + locationIV.frame.size.width + 5 * kRate, locationIV.frame.origin.y, kScreenWidth - 80 * kRate, 16 * kRate))
        locationLabel.backgroundColor = UIColor.clearColor()
        locationLabel.font = Define.font(13)
        let address : NSString? = newModel?.address
        locationLabel.text = "地址：\(address!)"
        locationLabel.textColor = CD_Txt_Color_66
        headerView.addSubview(locationLabel)
    
        var countArr : Array = [newModel?.cooperationBrokerNum!,newModel?.intentionClientNum!]
        var titleArr : Array = ["合作经纪人","意向客户"]
        for (var i = 0; i < 2; i++)
        {
            let count: NSString? = countArr[i]
            var detailView : HWNewDetailView = HWNewDetailView(frame: CGRectMake(kScreenWidth / CGFloat(titleArr.count) * CGFloat(i), CGRectGetMaxY(locationLabel.frame) + 10, kScreenWidth / CGFloat(titleArr.count), 57), title: titleArr[i], count: count!)
            headerView.addSubview(detailView)
        }
        var lineV1 =  UIView(frame:CGRectMake(0, CGRectGetMaxY(locationLabel.frame) + 10, kScreenWidth, 0.5))
        lineV1.backgroundColor = CD_LineColor
        headerView.addSubview(lineV1)
        
        var middleLineV = UIView(frame: CGRectMake(0, CGRectGetMaxY(locationLabel.frame) + 67, kScreenWidth, 10 * kRate))
        middleLineV.backgroundColor = CD_BackGroundColor
        headerView.addSubview(middleLineV)
        
        var lineV =  UIView(frame:CGRectMake(0, headerView.frame.size.height - 0.5, kScreenWidth, 0.5))
        lineV.backgroundColor = CD_LineColor
        headerView.addSubview(lineV)
        mainTableView.tableHeaderView = headerView
    }
    
    func showMap(){
        var mapVC = HWMapViewController()
        mapVC.la = newModel?.latitude
        mapVC.lo = newModel?.longitude
        self.navigationController?.pushViewController(mapVC, animated: true)
    }
    
    func createFooter()
    {
        if newModel?.picHx?.count == 0
        {
            mainTableView.tableFooterView = nil
            return
        }
        
        var view = UIView(frame: CGRectMake(0, 0, kScreenWidth, 22))
        view.backgroundColor = "e5e5e5".UIColor
        mainTableView.tableFooterView = view
        
        downArrow = UIImageView(frame: CGRectMake((kScreenWidth - 14) / 2.0, 5, 14, 6))
        downArrow.image = UIImage(named: "arrow_down")
        view.addSubview(downArrow)
        
        var tap = UITapGestureRecognizer(target: self, action: "doShow")
        view.addGestureRecognizer(tap)
    }
    
    func doShow(){
        showAll = !showAll
        if showAll{
            downArrow.image = UIImage(named: "arrow_up")
        }else{
            downArrow.image = UIImage(named: "arrow_down")
        }
        mainTableView.reloadSections(NSIndexSet(index: 4), withRowAnimation: UITableViewRowAnimation.Fade)
    }
    
    //MARK: 报备客户点击事件
    func baobeiCustomer()
    {
        MobClick.event("Newhouse-clientmatch_click")
        var baobeiVC : HWBaoBeiVC = HWBaoBeiVC()
        baobeiVC.houseId = self.houseId
        baobeiVC.houseName = newModel?.houseName
        self.navigationController?.pushViewController(baobeiVC, animated: true)
    }
    
    //MARK: 已报备客户点击事件
    func getBaoBeiCustomer()
    {
        var baobeiVC = HWHasBaoBeiVC()
        baobeiVC.houseId = self.houseId
        self.navigationController?.pushViewController(baobeiVC, animated: true)
    }
//    显示大图
    func showPictureBrowse(sender : AnyObject)
    {
        var localPicHouse: NSMutableArray = NSMutableArray()
        var localPicHx : NSMutableArray = NSMutableArray()
        var localPicJt : NSMutableArray = NSMutableArray()
        var localPicSj : NSMutableArray = NSMutableArray()
        var localPicYb : NSMutableArray = NSMutableArray()
        
        if(newModel?.housePic != nil)
        {
            for (var i = 0; i < newModel?.housePic?.count; i++)
            {
                var dict = NSDictionary(object: newModel?.housePic?.pObjectAtIndex(i) as NSString, forKey: "picKey")
                localPicHouse.addObject(dict)
            }
        }
        
        for (var i = 0; i < newModel?.picHx?.count; i++)
        {
            var dict = NSDictionary(object: (newModel!.picHx?.pObjectAtIndex(i) as NSDictionary).stringObjectForKey("pic"), forKey: "picKey")
            localPicHx.addObject(dict)
        }
        for (var i = 0; i < newModel?.picJt?.count; i++)
        {
            var dict = NSDictionary(object: newModel?.picJt?.pObjectAtIndex(i) as NSString, forKey: "picKey")
            localPicJt.addObject(dict)
        }
        for (var i = 0; i < newModel?.picSj?.count; i++)
        {
            var dict = NSDictionary(object: newModel?.picSj?.pObjectAtIndex(i) as NSString, forKey: "picKey")
            localPicSj.addObject(dict)
        }
        for (var i = 0; i < newModel?.picYb?.count; i++)
        {
            var dict = NSDictionary(object: newModel?.picYb?.pObjectAtIndex(i) as NSString, forKey: "picKey")
            localPicYb.addObject(dict)
        }
        let arr = NSArray(objects: ["title":"户型图","sourceArr":localPicHx],["title":"效果图","sourceArr":localPicHouse],["title":"交通图","sourceArr":localPicJt],["title":"实景图","sourceArr":localPicSj],["title":"样板图","sourceArr":localPicYb])
        
        
        var picBrowserVC = HWPictureBrowseViewController()
        picBrowserVC.sourceArray = arr as NSArray as [AnyObject]
        picBrowserVC.picType = picTypeNewHouse
        self.navigationController?.pushViewController(picBrowserVC, animated: true)
        
    }
//    显示楼盘参数
    func showParameter()
    {
        var newPara : HWNewParametersVC = HWNewParametersVC()
        newPara.houseURL = self.newModel?.partnerURL
        self.navigationController?.pushViewController(newPara, animated: true)
    }
    
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 5
    }
    
    func scrollViewDidScroll(scrollView: UIScrollView) {
        pageC.currentPage = Int(scrollView.contentOffset.x / kScreenWidth)
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        switch section
        {
        case 0:
            if(HWUserLogin.currentUserLogin().brokerType == "C")
            {
                return 1
            }
            else
            {
                return 2
            }
        case 1:
            return 1
        case 2:
            if newModel?.coupons.count > 0
            {
                let arr: NSArray? = newModel?.coupons
                return arr!.count
            }
            else
            {
                return 1
            }
        case 3:
            return 2
        case 4:
            let arr: NSArray? = newModel?.picHx
            if showAll
            {
                
                return arr!.count
            }
            if newModel?.picHx!.count > 3
            {
                return 3
            }
            return arr!.count
        default:
            return 3
        }
        
    }
    func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        switch indexPath.section
        {
        case 0:
            return 45
        case 1:
            return 45
        case 2:
            return 45
        case 3:
            
            if indexPath.row == 0
            {
                let arr: NSArray? = newModel?.preferential?.componentsSeparatedByString(",")
                return CGFloat(28 + 17 * arr!.count)
            }
            if newModel?.brokerages != nil && newModel?.brokerages?.count > 1
            {
                let arr: NSArray? = newModel?.brokerages
                return CGFloat(28 + 17 * Int(arr!.count))
            }
            return 45 * kRate
        case 4:
            return 105 * kRate
        default:
            return 65 * kRate
        }
    }
    
    func tableView(tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        if section == 4
        {
            return 30
        }
        if section == 0
        {
            return 0
        }
        return 10
    }
    
    func tableView(tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        if section == 4
        {
            var view : UIView = UIView(frame: CGRectMake(0, 0, kScreenWidth, 30))
            view.backgroundColor = CD_BackGroundColor
            
            var label = UILabel(frame:CGRectMake(15, 0, kScreenWidth - 30, 30))
            label.backgroundColor = UIColor.clearColor()
            label.textColor = "666666".UIColor
            label.text = "户型图"
            label.font = UIFont(name: FONTNAME, size: 13)
            view.addSubview(label)
            
            var lineV1 = UIView(frame:CGRectMake(0, 0, kScreenWidth, 0.5))
            lineV1.backgroundColor = CD_LineColor
            view.addSubview(lineV1)
            
            var lineV2 = UIView(frame:CGRectMake(0, 30 - 0.5, kScreenWidth, 0.5))
            lineV2.backgroundColor = CD_LineColor
            view.addSubview(lineV2)
            return view
        }
        if section == 0
        {
            return UIView()
        }
        
        var view = UIView(frame: CGRectMake(0, 0, kScreenWidth, 10))
        view.backgroundColor = UIColor.clearColor()
        var lineV =  UIView(frame:CGRectMake(0, 9.5, kScreenWidth, 0.5))
        lineV.backgroundColor = CD_LineColor
        view.addSubview(lineV)
        return view
    }
    
    func doCall()
    {
        var  phoneUrl:String = newModel?.projectManagerPhone as String!;
        if(countElements(phoneUrl)>0)
        {
            callWebView = UIWebView()
            self.view .addSubview(callWebView)
            
            
            var telUrl = NSURL(string: "tel://" + phoneUrl);
            callWebView .loadRequest(NSURLRequest(URL:telUrl!))
        }
       
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cellIdentifier1 : String = "cell1"
        let cellIdentifier2 : String = "cell2"
        let cellIdentifier3 : String = "cell3"
        
        if indexPath.section == 0 || indexPath.section == 1 || indexPath.section == 2
        {

//            tableView.registerClass(HWCustomerDetailTableViewCell.self, forCellReuseIdentifier: cellIdentifier1)
            var cell : HWNewDetailCell1? = tableView.dequeueReusableCellWithIdentifier(cellIdentifier1) as? HWNewDetailCell1
            if cell == Optional.None
            {
                cell = HWNewDetailCell1(style: UITableViewCellStyle.Default, reuseIdentifier:cellIdentifier1)
            }
            if indexPath.section == 0 && indexPath.row == 0
            {
                cell?.titleLabel.text = "活动日期："
                let stamp: NSString? = newModel?.activityDate
                cell?.subTitleLabel.text = (Utility.getTimeWithTimestamp(stamp!, dateFormatStr: "yyyy-MM-dd") as String) + "  截止"
                cell?.accessoryView = nil
                var btn : UIButton?
                for btn in cell!.contentView.subviews
                {
                    btn.removeFromSuperview()
                }
            }
            else if indexPath.section == 0 && indexPath.row == 1
            {
                if(HWUserLogin.currentUserLogin().brokerType == "A")
                {
                    cell?.titleLabel.text = "合伙人专员："
                }
                else
                {
                    cell?.titleLabel.text = "大客户经理："
                }
                cell?.subTitleLabel.text = newModel?.projectManager as? String
                var btn : UIButton?
                for btn in cell!.contentView.subviews
                {
                    btn.removeFromSuperview()
                }
                btn = UIButton()
                //btn = UIButton.buttonWithType(UIButtonType.Custom) as? UIButton
                btn!.backgroundColor = UIColor.clearColor()
                if(newModel?.projectManagerPhone == "")
                {
                    btn!.setImage(UIImage(named:"phone1"), forState: UIControlState.Normal)
                }
                else
                {
                    btn!.setImage(UIImage(named:"phone2"), forState: UIControlState.Normal)
                }
                btn!.addTarget(self, action: "doCall", forControlEvents: UIControlEvents.TouchUpInside)
                btn!.frame = CGRectMake(kScreenWidth - 38 * kRate - 15, 0, 45 * kRate, 45 * kRate)
                cell!.contentView.addSubview(btn!)
            }
            else if indexPath.section == 1
            {
                if indexPath.row == 0
                {
                   cell?.titleLabel.text = "楼盘活动："
                   if newModel?.newHouseActivityVoList?.count > 0
                  {
                    var dict = newModel?.newHouseActivityVoList?.pObjectAtIndex(0) as NSDictionary
                    cell?.subTitleLabel.text = dict.stringObjectForKey("title") as String
                   }
                    else
                   {
                       cell?.subTitleLabel.text = ""
                   }
                    var button = UIButton.buttonWithType(UIButtonType.Custom) as UIButton
                    button.backgroundColor = UIColor.whiteColor()
                    button.setImage(UIImage(named: "arrow_next"), forState: UIControlState.Normal)
                    button.imageEdgeInsets = UIEdgeInsetsMake(0, 20, 0, -20)
                    button.frame = CGRectMake(0, 0, 45 * kRate, 43 * kRate)
                    cell?.accessoryView = button

                }
                
                
                
            }
             else if indexPath.section == 2
            {
                
                if newModel?.coupons.count == 0
                {
                    cell?.subTitleLabel.text = "暂无优惠券"
                }
                else
                {
                    var dict = newModel?.coupons.pObjectAtIndex(indexPath.row) as NSDictionary
                    cell?.subTitleLabel.text = dict.stringObjectForKey("couponContent") as String
                }
                cell?.titleLabel.text = "优惠券："
                var button = UIButton.buttonWithType(UIButtonType.Custom) as UIButton
                button.backgroundColor = UIColor.whiteColor()
                button.setImage(UIImage(named: "arrow_next"), forState: UIControlState.Normal)
                button.imageEdgeInsets = UIEdgeInsetsMake(0, 20, 0, -20)
                button.frame = CGRectMake(0, 0, 45 * kRate, 43 * kRate)
                cell?.accessoryView = button

                
            }
            cell?.selectionStyle = UITableViewCellSelectionStyle.None
            return cell!
        }
     
        else if indexPath.section == 3
        {
            var cell : HWNewDetailCell2? = tableView.dequeueReusableCellWithIdentifier(cellIdentifier2) as? HWNewDetailCell2
            if cell == Optional.None
            {
                cell = HWNewDetailCell2(style: UITableViewCellStyle.Default, reuseIdentifier: cellIdentifier2)
            }
            if indexPath.row == 0
            {
                let arr: NSArray? = newModel?.preferential?.componentsSeparatedByString(",")
                cell?.set(arr!, index: indexPath.row)
//                cell?.set((newModel?.preferential as NSString).componentsSeparatedByString(","), index: indexPath.row)
            }
            else if indexPath.row == 1
            {
                var arr : NSArray? = newModel?.brokerages
                cell?.set(arr!, index: indexPath.row)
            }
            else if indexPath.row == 2
            {
//                cell?.set(["现金奖"], index: indexPath.row)
            }
            cell?.selectionStyle = UITableViewCellSelectionStyle.None
            return cell!
        }
        else
        {
            var cell : HWNewDetailCell3? = tableView.dequeueReusableCellWithIdentifier(cellIdentifier3) as? HWNewDetailCell3
            if cell == Optional.None
            {
                cell = HWNewDetailCell3(style: UITableViewCellStyle.Default, reuseIdentifier: cellIdentifier3)
            }
            var dict : NSDictionary = newModel?.picHx?.pObjectAtIndex(indexPath.row) as NSDictionary
            cell?.houseIV.setImageWithURL(NSURL(string: dict.stringObjectForKey("pic") as String), placeholderImage: Utility.getPlaceHolderImage(CGSizeMake(80, 80), imageName: placeHolderSmallImage))
            cell?.nameLabel.text = dict.stringObjectForKey("area") as String
            cell?.houseStyleLabel.text = dict.stringObjectForKey("room") as String
            cell?.houseSizeLabel.text = (dict.stringObjectForKey("reference") as String) + "㎡"
            cell?.selectionStyle = UITableViewCellSelectionStyle.None
            return cell!
        }
    }
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        if indexPath.section == 1
        {
            if newModel?.newHouseActivityVoList?.count == 0
            {
                Utility.showToastWithMessage("暂无活动", _view: self.view)
                return
            }
            var dict = newModel?.newHouseActivityVoList?.pObjectAtIndex(0) as NSDictionary
            var activityVC : HWactivityVC = HWactivityVC()
            activityVC.actUrl = dict.stringObjectForKey("activityUrl")
            var webView : UIWebView = UIWebView(frame: CGRectMake(0, 0, kScreenWidth, contentHeight))

            self.navigationController?.pushViewController(activityVC, animated: true)
        }
        else if indexPath.section == 4
        {
            self.showPictureBrowse("3")
        }
        
        else if indexPath.section == 2
        {
            if newModel?.coupons.count == 0
            {
                tableView.deselectRowAtIndexPath(indexPath, animated: true)
            }
            else
            {
                var dict  =  newModel?.coupons.pObjectAtIndex(indexPath.row) as NSDictionary
               let vc = HWDisCountDetailViewController()
               vc.couponId = dict.stringObjectForKey("couponId")
               vc.webViewUrlStr = dict.stringObjectForKey("detailPath")
               vc.brokerId = HWUserLogin.currentUserLogin().brokerId
               vc.fromVCName = "首页"
               self.navigationController?.pushViewController(vc, animated: true)
            }
        }
    }
}
