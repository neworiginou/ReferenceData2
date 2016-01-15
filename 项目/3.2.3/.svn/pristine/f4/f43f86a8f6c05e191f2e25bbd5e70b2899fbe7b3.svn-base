//
//  HWScdHouseDetailView.swift
//  Partner-Swift
//
//  Created by niedi on 15/3/7.
//  Copyright (c) 2015年 caijingpeng.haowu. All rights reserved.
//
//  功能描述：二手房房源详情 mainview
//
//  修改记录：
//      姓名         日期               修改内容
//      聂迪      2015-02-26           UI、数据请求及功能逻辑实现
//

import UIKit

protocol HWScdHouseDetailViewDelegate: NSObjectProtocol
{
    func delegateChangeNavItemImg(type: ScdHouRightNavItemType, modelDict: NSDictionary)
    func delegatePushVC(vc: UIViewController)
}

class HWScdHouseDetailView: HWBaseRefreshView, HWCustomAlertViewDelegate, UIAlertViewDelegate
{
    //MARK: 成员变量
    var _scdHouseId: String!
    var _isCollect: Bool! = false
    var _model: HWScdHouseDetailModel! = HWScdHouseDetailModel()
    var _modelDict: NSDictionary = NSDictionary()
    weak var _delegate : HWScdHouseDetailViewDelegate!
    
    var tableViewHeaderBackView: UIView!
    var topScrollView: UIScrollView!    //图片墙
    var appointBackImgView: UIImageView!
    var appointNumLab: UILabel!
    var houseStatusLab:UILabel!
    var yuyueLab: UILabel!          //"预约"
    var mapImgView: UIImageView!
    var pageControl: UIPageControl!
    var titleLab: UILabel!
    var priceLab: UILabel!
    var houseTypeLab: UILabel!
    var detailHouse:UILabel!;
    var areaLab: UILabel!
    var detailBackView: UIView!
    var villageLab: UILabel!
    var addressLab: UILabel!
    var floorLab: UILabel!
    var towardLab: UILabel!
    var UnitPriceLab: UILabel!
    var typeLab: UILabel!
    var propertyRightsLab: UILabel!
    var yearLab: UILabel!
    var signTlab: UILabel!
    var signStreamLab: HWStreamLabelView!
    var houseSourceTelLab: UILabel!
    var phoneLab: UILabel!
    var phoneIconBtn: UIButton!
    var tableViewFootBackView: UIView!
    var appointmentBtn: UIButton!
    var linkCustomBtn: UIButton!
    var imageCenter = UIImageView()
    var gotoCenterBtn = UIButton()
    var detailLab:UILabel!
    
    //MARK: init
    init(frame: CGRect, houseId: String, delegate: HWScdHouseDetailViewDelegate)
    {
        super.init(frame: frame)
        
        _scdHouseId = houseId
        _delegate = delegate
        
        self.queryListData()
        
    }
    
    //MARK: 加载UI
    func loadUI()
    {
        self.loadTableViewHeaderView()
        self.loadTableViewFootView()
    }
    
    //MARK: 房源详情数据请求
    override func queryListData()
    {
        /*url:/MyHousesInfo/findByDetails.do
        入参：houseId
        出参：
        {
        "detail": "请求数据成功!",
        "status": "1",
        "data":
        { "scdHandHousesId": 1, "brokerId": 3039003039, "villageId": 1, "housesOwnerId": 4, "housesOwnerName": "邹甲华4", "housesOwnerPhone": "13555555555", "sex": "1", "villageName": "铂金汉宫", "buildingNo": "20", "houseNo": "101", "propertyRights": "30年", "years": "2009年", "toward": "south", "type": "residence", "decorate": null, "sign": null, "title": "便", "price": 1111111, "proportion": 90, "roomCount": 5, "hallCount": 2, "roomType": null, "toiletCount": 2, "status": "putdown", "disabled": null, "createTime": null, "floor": 2, "floorSum": 3, "address": "虹口-临平路", "phoneNo": "13916359548", "brokerName": "递归", "longitude": null, "latitude": null, "myAppoint": "no", "scdHouseCount": null, "myScdHouseCount": 0, "whichOne": "collaborate", "lock": "yes", "integral": 2, "comm": [], "house": [], "effect": [], "aset": [], "temp": [], "inner": [] } */
        Utility.hideMBProgress(self)
        Utility.showMBProgress(self, _message: "请求数据")
        
        let manager = HWHttpRequestOperationManager.baseManager()
        var param = NSMutableDictionary()
        
        param.setPObject(HWUserLogin.currentUserLogin().key, forKey: "key")
        param.setPObject(_scdHouseId, forKey: "houseId")
        
        manager.postHttpRequest(KScdHouDetail, parameters: param, queue: nil, success: { (responseObject) -> Void in
            
            Utility.hideMBProgress(self)
            
            var dataDict: NSDictionary = responseObject.dictionaryObjectForKey("data")
            self._model = HWScdHouseDetailModel()
            self._model.initWithDict(dataDict)
            self._modelDict = dataDict
            
            self.loadUI()
            self.loadData()
            self.tableViewHeaderBackView .bringSubviewToFront(self.imageCenter);
            self.baseTable.reloadData()
            self.hideEmptyView()
            self.doneLoadingTableViewData()
            
            }) { (code, error) -> Void in
                
                Utility.hideMBProgress(self)
                self.doneLoadingTableViewData()
                if(self.tableViewHeaderBackView != nil)
                {
                    self.tableViewHeaderBackView.hidden = true
                    self.tableViewFootBackView.hidden = true
                }
                
                if(self.baseListArr.count == 0 && code.integerValue == kStatusFailure)
                {
                    self.showNetworkErrorView(kFailureDetail)
                }
                else
                {
                    Utility.showToastWithMessage(error, _view: self)
                }
        }
        
    }
    
    //MARK: 数据填充
    func loadData()
    {
        detailLab.text = _model.housesDescription
        
        if _model.isRental == "1"
        {
            imageCenter.hidden = false
        }
            
        else
        {
            imageCenter.hidden = true
        }

        if(_model.status == "putdown")
        {
            _delegate.delegateChangeNavItemImg(ScdHouRightNavItemType.PutDown, modelDict: _modelDict)
        }
        
        else
        {
            if(_model.whichOne == "Mine")
            {
                _delegate.delegateChangeNavItemImg(ScdHouRightNavItemType.Mine, modelDict: _modelDict)
            }
            else if(_model.whichOne == "myFavorite")
            {
                _delegate.delegateChangeNavItemImg(ScdHouRightNavItemType.Collected, modelDict: _modelDict)
            }
            else if(_model.whichOne == "collaborate")
            {
                _delegate.delegateChangeNavItemImg(ScdHouRightNavItemType.Collecting, modelDict: _modelDict)
            }
        }
        
        //图片墙
        var headImgArr = NSMutableArray()
        headImgArr.addObjectsFromArray(_model.inner)
        headImgArr.addObjectsFromArray(_model.house)
        
        topScrollView.contentSize = CGSizeMake(CGFloat(headImgArr.count) * kScreenWidth, kScreenWidth * 0.5)
        
        for var i = 0; i < headImgArr.count; i++
        {
            var tmpDict: NSDictionary = headImgArr.objectAtIndex(i) as NSDictionary
            if(tmpDict.stringObjectForKey("isMain") == "yes")
            {
                headImgArr.insertObject(tmpDict, atIndex: 0)
                headImgArr.removeObjectAtIndex(i + 1)
            }
        }
        
        for var i = 0; i < headImgArr.count; i++
        {
            var tmpDict: NSDictionary = headImgArr.objectAtIndex(i) as NSDictionary
            
            var imageV = UIImageView(frame: CGRectMake(kScreenWidth * CGFloat(i), 0, kScreenWidth, topScrollView.frame.height))
            imageV.contentMode = UIViewContentMode.ScaleAspectFill
            weak var weakImgV: UIImageView! = imageV
            //MYP add v3.2.2修改图片加载方式
             //let url = NSURL(string:Utility.imageDownloadWithMongoDbKey(tmpDict.stringObjectForKey("picKey")))
            let url = NSURL(string:tmpDict.stringObjectForKey("picKey"))
            imageV.setImageWithURL(url, placeholderImage:  Utility.getPlaceHolderImage(weakImgV.frame.size, imageName: placeHolderBigImage)) { (image, error, imageCacheType) -> Void in
                if (error != nil)
                {
                    let size: CGSize! = weakImgV.frame.size
                    weakImgV?.image = Utility.getPlaceHolderImage(size, imageName: failedBigImage)
                }
                else
                {
                    weakImgV?.image = image
                }
            }
            topScrollView.addSubview(imageV)
        }
        
        if(headImgArr.count == 0)
        {
            var imageV = UIImageView(frame: CGRectMake(0, 0, kScreenWidth, topScrollView.frame.height))
            imageV.image = Utility.getPlaceHolderImage(imageV.frame.size, imageName:placeHolderBigImage)
            imageV.contentMode = UIViewContentMode.ScaleAspectFill
            
            topScrollView.addSubview(imageV)
        }
        
        pageControl = UIPageControl(frame: CGRectMake(0, CGRectGetMaxY(topScrollView.frame) - 25 * kRate, kScreenWidth, 20 * kRate))
        pageControl.backgroundColor = UIColor.clearColor()
        pageControl.numberOfPages = headImgArr.count == 1 ? 0 : headImgArr.count
        tableViewHeaderBackView.addSubview(pageControl)
        
        if(_model.status == "putup")
        {
            var tap = UITapGestureRecognizer(target: self, action: "showScdHouPicDetail")
            topScrollView.addGestureRecognizer(tap)
        }
        
        //预约人数
        var tmpAppointNum = _model.scdHouseCount == "" ? "0" : _model.scdHouseCount
        appointNumLab.text = "\(tmpAppointNum)人"
        appointBackImgView.image = UIImage(named: "reservation_bg")
        //房源状态
        if(_model.status == "putup")
        {
            houseStatusLab.text = "已上架";
        }
        else if(_model.status == "putdown")
        {
            houseStatusLab.text = "已下架";
        }
        else if(_model.status == "audit")
        {
            houseStatusLab.text = "审核中";
        }
        else if(_model.status == "deal")
        {
             houseStatusLab.text = "已成交";
        }
        //"共几张" 图片个数
        var countStr : NSMutableString = "共张"
        countStr.insertString("\(_model.house.count + _model.inner.count)", atIndex: 1)
        var font : UIFont = Define.font(10)
        var size : CGSize = Utility.calculateStringSize(countStr, textFont: font, constrainedSize: CGSizeMake(1000, 20))
        var countLabel = UILabel(frame: CGRectMake(kScreenWidth - 25 * kRate - size.width * kRate, pageControl.frame.origin.y + 2.5 * kRate, (size.width + 10) * kRate, 15 * kRate))
        countLabel.backgroundColor = UIColor(white: 0, alpha: 0.5)
        countLabel.layer.cornerRadius = 3.0
        countLabel.layer.masksToBounds = true
        countLabel.font = font
        countLabel.textAlignment = NSTextAlignment.Center
        countLabel.text = countStr
        countLabel.textColor = UIColor.whiteColor()
        tableViewHeaderBackView.addSubview(countLabel)
        
        //地图
        weak var weakImgV: UIImageView! = mapImgView
        var l = CLLocationCoordinate2DMake(NSString(string: _model.longitude).doubleValue, NSString(string: _model.latitude).doubleValue)
        var url: NSURL = Utility_OC.getStaticMapUrlByCoordinate2D(l)
        mapImgView.setImageWithURL(url, placeholderImage: Utility.getPlaceHolderImage(weakImgV.frame.size, imageName: "bitmap")) { (image, error, imageCacheType) -> Void in
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
        
        var tap2 = UITapGestureRecognizer(target: self, action: "showMapDetail")
        mapImgView.addGestureRecognizer(tap2)
        if _model.title == ""
        {
            titleLab.text = _model.villageName
        }
        else
        {
        titleLab.text = _model.title
        }
        
        var priceFloat = (_model.price as NSString).doubleValue
        var priceStr: NSString = priceFloat > 10000 ? NSString(format:"%.2f万",priceFloat / 10000.0) : NSString(format:"%.f元",priceFloat)
        if(priceStr.length >= 5)
        {
            var tmpStr = priceStr.substringWithRange(NSMakeRange(priceStr.length - 4, 4))
            if(tmpStr == ".00万")
            {
                priceStr = priceStr.substringToIndex(priceStr.length - 4)
                priceStr = "\(priceStr)万"
            }
        }
        priceLab.text = priceStr
        
        houseTypeLab.text = "\(_model.roomCount)室\(_model.hallCount)厅\(_model.toiletCount)卫"
        
        areaLab.text = "\(_model.proportion)㎡"
        
        villageLab.attributedText = self.setAttributeString("小区: ", ContentForLab: _model.villageName)
        if(_model.whichOne == "Mine")
        {
            var addStr = NSString()
            if _model.buildingNo == ""
            {
                 addStr = "\(_model.address)\(_model.houseNo)室"
            }
             if _model.houseNo == ""
            {
                addStr = "\(_model.address)\(_model.buildingNo)号"
            }
            if  _model.buildingNo == "" && _model.houseNo == ""
            {
                addStr = _model.address
            }
             if _model.buildingNo != "" && _model.houseNo != ""
            {
                addStr = "\(_model.address)\(_model.buildingNo)号\(_model.houseNo)室"
                
            }
            
            addressLab.attributedText = self.setAttributeString("地址: ", ContentForLab: addStr)
        }
        else
        {
            addressLab.attributedText = self.setAttributeString("地址: ", ContentForLab: _model.address)
        }
        
        floorLab.attributedText = self.setAttributeString("楼层: ", ContentForLab: "\(_model.floor)/\(_model.floorSum)")
        
        var tmpTowardStr = ""
        for var i = 0; i < HWScdHouConfigCenter.defaultCenter().towardArr_E.count; i++
        {
            if(_model.toward == HWScdHouConfigCenter.defaultCenter().towardArr_E.pObjectAtIndex(i) as String)
            {
                tmpTowardStr = HWScdHouConfigCenter.defaultCenter().towardArr_C.pObjectAtIndex(i) as String
            }
        }
        towardLab.attributedText = self.setAttributeString("朝向: ", ContentForLab: tmpTowardStr)
        
        var unitPriceFloat = priceFloat / (_model.proportion as NSString).doubleValue
        var unitPrice = rintf(Float(unitPriceFloat))
        UnitPriceLab.attributedText = self.setAttributeString("单价: ", ContentForLab: NSString(format:"%.f元/㎡",unitPrice))
        
        
        var tmpTypeStr = ""
        for var i = 0; i < HWScdHouConfigCenter.defaultCenter().typeArr_E.count; i++
        {
            if(_model.type == HWScdHouConfigCenter.defaultCenter().typeArr_E.pObjectAtIndex(i) as String)
            {
                tmpTypeStr = HWScdHouConfigCenter.defaultCenter().typeArr_C.pObjectAtIndex(i) as String
            }
        }
        typeLab.attributedText = self.setAttributeString("类型: ", ContentForLab: tmpTypeStr)
        propertyRightsLab.attributedText = self.setAttributeString("产权: ", ContentForLab: _model.propertyRights == "" ? "" : "\(_model.propertyRights)年")
        yearLab.attributedText = self.setAttributeStrings("建成年代: ", ContentForLab: _model.years)
        
        if (signStreamLab != nil)
        {
            signStreamLab.removeFromSuperview()
        }
        var tmpSignCArr = NSMutableArray()
        for var i = 0; i < _model.sign.count; i++
        {
            var tmpS = _model.sign.pObjectAtIndex(i) as NSString
            
            for var j = 0; j < HWScdHouConfigCenter.defaultCenter().sign_E.count; j++
            {
                if(tmpS == HWScdHouConfigCenter.defaultCenter().sign_E.pObjectAtIndex(j) as NSString)
                {
                    tmpSignCArr.addObject(HWScdHouConfigCenter.defaultCenter().sign_C.pObjectAtIndex(j) as NSString)
                }
            }
        }
        signStreamLab = HWStreamLabelView(item: tmpSignCArr, constrainedFrame: CGRectMake(55, signTlab.frame.minY, kScreenWidth - 65, 1000), constrainedItemSize: CGSizeMake(1000, 18));
        signStreamLab.itemBorderColor = CD_MainColor.CGColor;
        signStreamLab.itemBorderWidth = 1.0;
        signStreamLab.itemCornerRadius = 3.0;
        signStreamLab.itemTitleColor = CD_MainColor;
        signStreamLab.itemFont = Define.font(TF_12)
        detailBackView.addSubview(signStreamLab)
        //add by gusheng
        detailHouse.frame = CGRectMake(15, signStreamLab.frame.maxY+10, kScreenWidth - 15 * 2, 20);
        detailLab.frame = CGRectMake(15, detailHouse.frame.maxY, kScreenWidth - 15 * 2, 40)
        detailBackView.addSubview(Utility.drawLine(CGPointMake(15, detailLab.frame.maxY + 5), width: kScreenWidth - 15))
        //end by gusheng
        
        if(_model.status == "putdown")//房屋已下架
        {
            appointNumLab.hidden = true
            yuyueLab.hidden = true
            linkCustomBtn.hidden = true
            appointmentBtn.hidden = true
            tableViewFootBackView.hidden = true
            
            appointBackImgView.frame = CGRectMake(kScreenWidth - 60, 35, 60, 60)
            appointBackImgView.image = UIImage(named: "status1")
            appointBackImgView.hidden = true;
            
        }
        
        //分情况： 我的房源、 合作房源: 对方同意预约 对方未同意预约 未发起预约
        if(_model.whichOne == "Mine")
        {
            houseSourceTelLab.text = "业主信息"
             gotoCenterBtn = UIButton(frame: CGRectMake(kScreenWidth-15-30, houseSourceTelLab.frame.origin.y-8, 30, 30));
            gotoCenterBtn .setImage(UIImage(named: "mail2"), forState:.Normal)
            gotoCenterBtn .addTarget(self, action: "gotoRental", forControlEvents:.TouchUpInside)
            detailBackView .bringSubviewToFront(gotoCenterBtn)
            detailBackView .addSubview(gotoCenterBtn);
            
            
//            var phoneLabStr = ""
//            if(_model.housesOwnerName != "")
//            {
//                phoneLabStr += _model.housesOwnerName
//                if(_model.housesOwnerPhone != "")
//                {
//                    phoneLabStr += "  " + _model.housesOwnerPhone
//                }
//            }
//            else
//            {
//                phoneLabStr = _model.housesOwnerPhone
//            }
//            phoneLab.text = phoneLabStr
            
            
            
            if(_model.housesOwnerPhone == "")
            {
                phoneIconBtn.hidden = true  //打电话按钮 图标
                phoneLab.hidden = true
                phoneLab.frame = CGRectMake(15, houseSourceTelLab.frame.origin.y, kScreenWidth - 2 * 15, phoneLab.frame.height)
            }
            else
            {
                phoneLab.text = _model.housesOwnerPhone
                phoneIconBtn.frame = CGRectMake(kScreenWidth-15-30-30-8, houseSourceTelLab.frame.origin.y-8, 30, 30)
                phoneLab.frame = CGRectMake(kScreenWidth-15-30-30-8-100-8, houseSourceTelLab.frame.origin.y-8, 100, 30)
                phoneIconBtn.setImage(UIImage(named: "phone2"), forState: UIControlState.Normal)
            }
//            var relatedBtn = UIButton()
//            relatedBtn.backgroundColor = CD_Btn_GrayColor_Clicked;
//            relatedBtn .setTitle("关联客户", forState: .Normal);
//            relatedBtn .addTarget(self, action: "linkCustomBtnClick", forControlEvents: .TouchUpInside);
//            relatedBtn.frame = CGRectMake(0, appointmentBtn.frame.origin.y, kScreenWidth/2, appointmentBtn.frame.size.height);
//            tableViewFootBackView .addSubview(relatedBtn);
//            
//            var turnoverBtn = UIButton()
//            turnoverBtn.frame = CGRectMake(CGRectGetMaxX(relatedBtn.frame), appointmentBtn.frame.minY, kScreenWidth/2, appointmentBtn.frame.height)
//            
//            turnoverBtn .setTitle("成交确认", forState: .Normal);
//            turnoverBtn .addTarget(self, action: "turnoverBtn", forControlEvents: .TouchUpInside);
//            turnoverBtn.layer.masksToBounds = false;
//            turnoverBtn.setBackgroundImage(Utility.imageWithColor(CD_Btn_MainColor, _size: linkCustomBtn.frame.size), forState: UIControlState.Normal)
//            tableViewFootBackView .addSubview(turnoverBtn);
//            
            
             var relatedBtn = UIButton()
            relatedBtn = UIButton.buttonWithType(UIButtonType.Custom) as UIButton
            relatedBtn.frame = CGRectMake(15, 20, (kScreenWidth - 3 * 15) / 2, 45)
            relatedBtn.layer.cornerRadius = 3
            relatedBtn.layer.masksToBounds = true
            relatedBtn.setTitle("关联客户", forState: UIControlState.Normal)
            relatedBtn.titleLabel?.font = Define.font(TF_Btn_Title_19)
             relatedBtn.setBackgroundImage(Utility.imageWithColor(CD_Btn_GrayColor, _size: relatedBtn.frame.size), forState: UIControlState.Normal)
            relatedBtn.addTarget(self, action: "linkCustomBtnClick", forControlEvents: UIControlEvents.TouchUpInside)
            tableViewFootBackView.addSubview(relatedBtn)
              var turnoverBtn = UIButton()
            turnoverBtn = UIButton.buttonWithType(UIButtonType.Custom) as UIButton
            turnoverBtn.frame = CGRectMake(appointmentBtn.frame.maxX + 15, appointmentBtn.frame.minY, appointmentBtn.frame.width, 45)
            turnoverBtn.layer.cornerRadius = 3
            turnoverBtn.layer.masksToBounds = true
            turnoverBtn.setBackgroundImage(Utility.imageWithColor(CD_Btn_MainColor, _size: linkCustomBtn.frame.size), forState: UIControlState.Normal)
            turnoverBtn.setTitle("成交确认", forState: UIControlState.Normal)
            turnoverBtn.titleLabel?.font = Define.font(TF_Btn_Title_19)
            turnoverBtn.addTarget(self, action: "turnoverBtn", forControlEvents: UIControlEvents.TouchUpInside)
            tableViewFootBackView.addSubview(turnoverBtn)

        }
        else
        {
            houseSourceTelLab.text = "房源方电话"
            
            if(_model.myAppoint == "yes")
            {
                phoneLab.text = _model.phoneNo
                
                phoneIconBtn.setImage(UIImage(named: "phone2"), forState: UIControlState.Normal)
                //预约看房按钮
                phoneIconBtn.removeTarget(self, action: "phoneBtnClick", forControlEvents: UIControlEvents.TouchUpInside);
                phoneIconBtn.addTarget(self, action: "brokerPhoneBtnClick", forControlEvents: UIControlEvents.TouchUpInside);
                appointmentBtn.setBackgroundImage(Utility.imageWithColor(CD_Btn_GreenColor, _size: appointmentBtn.frame.size), forState: UIControlState.Normal)
            }
            else
            {
                phoneLab.text = _model.phoneNo;
                
                phoneIconBtn.setImage(UIImage(named: "phone2"), forState: UIControlState.Normal)
            }
            
            if(_model.lock == "no")
            {
                appointmentBtn.setBackgroundImage(Utility.imageWithColor(CD_Btn_GreenColor, _size: appointmentBtn.frame.size), forState: UIControlState.Normal)
            }
            else
            {
                appointmentBtn.setBackgroundImage(Utility.imageWithColor(CD_Btn_GreenColor, _size: appointmentBtn.frame.size), forState: UIControlState.Normal)
//                appointmentBtn.setImage(UIImage(named: "lock1"), forState: UIControlState.Normal)
//                appointmentBtn.titleEdgeInsets = UIEdgeInsetsMake(0, -30, 0, 0)
                if(iPhone6plus)
                {
                    appointmentBtn.imageEdgeInsets = UIEdgeInsetsMake(-1, 130, 0, 0)
                }
                else
                {
                    appointmentBtn.imageEdgeInsets = UIEdgeInsetsMake(-1, 100, 0, 0)
                }
            }
        }
        if _model.isRental == "1"
        {
            gotoCenterBtn.hidden = false
        }
        else
        {
            gotoCenterBtn.hidden = true
        }
    }
    
    //MARK: pageControl设置
    func scrollViewDidEndDecelerating(scrollView: UIScrollView)
    {
         if _model.inner.count == 0 || _model.house.count == 0
         {
            return
         }
        if(topScrollView == scrollView)
        {
            pageControl.currentPage = Int(scrollView.contentOffset.x / kScreenWidth)
        }
    }
    
    //MARK: 显示大图
    func showScdHouPicDetail()
    {
        var arr = NSArray(objects: ["title" : "室内图", "sourceArr" : _model.inner], ["title" : "户型图","sourceArr" : _model.house])
        
        var pictureBarwserVC = HWPictureBrowseViewController()
        pictureBarwserVC.sourceArray = arr
    
        if(_model.whichOne == "Mine")
        {
            pictureBarwserVC.showEditBtn = true
            pictureBarwserVC.innerArr = _model.inner
            pictureBarwserVC.houseArr = _model.house
            pictureBarwserVC.houseId = _model.scdHandHousesId
            pictureBarwserVC.permission = _model.permission
        }
//        var index = Int(topScrollView.contentOffset.x / kScreenWidth)
//        pictureBarwserVC.selectType = index//不知怎么用
        _delegate.delegatePushVC(pictureBarwserVC)
    }
    
    //MARK: 显示地图
    func showMapDetail()
    {
        var mapVC = HWMapViewController()
        mapVC.la = _model.latitude
        mapVC.lo = _model.longitude
        _delegate.delegatePushVC(mapVC)
    }
    
    //MARK: 电话按钮点击事件
    @objc private func phoneBtnClick()
    {
        if(_model.whichOne == "Mine")
        {
            var callWebView = UIWebView()
            self.addSubview(callWebView)
            
            if(_model.housesOwnerPhone == "")
            {
                Utility.showToastWithMessage("手机号未空", _view: self)
            }
            else
            {
                var telUrl = NSURL(string: "tel:\(_model.housesOwnerPhone)")
                callWebView.loadRequest(NSURLRequest(URL: telUrl!))
            }
        }
        else if(_model.myAppoint == "yes")
        {
            var callWebView = UIWebView()
            self.addSubview(callWebView)
            
            if(_model.phoneNo == "")
            {
                Utility.showToastWithMessage("手机号未空", _view: self)
            }
            else
            {
                var telUrl = NSURL(string: "tel:\(_model.phoneNo)")
                callWebView.loadRequest(NSURLRequest(URL: telUrl!))
            }
        }
        else
        {
            return
        }
    }
    func brokerPhoneBtnClick()
    {
        var callWebView = UIWebView()
        self.addSubview(callWebView)
        
        if(_model.phoneNo == "")
        {
            Utility.showToastWithMessage("手机号未空", _view: self)
        }
        else
        {
            var telUrl = NSURL(string: "tel:\(_model.phoneNo)")
            callWebView.loadRequest(NSURLRequest(URL: telUrl!))
        }

    }
    
    //MARK: 预约看房 点击事件
    @objc private func appointBtnClick()
    {
        MobClick.event("SCDhousereserve_click")//maidian_3.0_niedi
        
//        if(_model.lock == "yes")
//        {
//            var alertView = UIAlertView(title: "积分预约", message: "解锁经纪人联系方式\n消费：\(_model.integral)个积分", delegate: self, cancelButtonTitle: "取消", otherButtonTitles: "确认")
//            alertView.show()
//        }
//        else
//        {
            var makeAppointVC = HWScdHouMakeAppointVC()
            makeAppointVC.houseId = _scdHouseId
            makeAppointVC.integral = _model.integral
            _delegate.delegatePushVC(makeAppointVC)
//        }
    }
    
    //MARK: UIAlertViewDelegate
    func alertView(alertView: UIAlertView, clickedButtonAtIndex buttonIndex: Int)
    {
        if(buttonIndex == 1)
        {
            MobClick.event("SCDhouseunlock_click")//maidian_3.0_niedi
            
            /*url：/appointment/judgeIntegrate.do
            入参： Integral  预约需要扣的积分
            出参：
            { "detail": "请求数据成功!", "status": "1", "data": "操作成功" } */
            Utility.hideMBProgress(self)
            
//            let manager = HWHttpRequestOperationManager.baseManager()
//            var param = NSMutableDictionary()
//            
//            param.setPObject(HWUserLogin.currentUserLogin().key, forKey: "key")
//            param.setPObject(self._model.integral, forKey: "Integral")
//            
//            manager.postHttpRequest(kScdHouCheckIntegrate, parameters: param, queue: nil, success: { (responseObject) -> Void in
//                
//                Utility.hideMBProgress(self)
            
                var makeAppointVC = HWScdHouMakeAppointVC()
                makeAppointVC.houseId = self._scdHouseId
                makeAppointVC.integral = self._model.integral
                self._delegate.delegatePushVC(makeAppointVC)
                
//                }) { (code, error) -> Void in
//                    
//                    Utility.hideMBProgress(self)
//                    Utility.showToastWithMessage(error, _view: self)
//            }
        }
    }
    
    //MARK: HWCustomAlertViewDelegate 投诉
    func ConfirmInPut(content: NSString)
    {
        if(content.length == 0)
        {
            Utility.showToastWithMessage("请输入投诉内容", _view: self)
            return
        }
        
        
        /*url：/MyHousesInfo/houseComplain.do
        入参：
        scdhandHousesId：*** --二手房Id,
        appealReason：*** --投诉详情
        出参：
        { "detail": "请求数据成功!", "status": "1", "data": "操作成功" } */
        
        Utility.hideMBProgress(self)
        Utility.showMBProgress(self, _message: "上传中")
        
        let manager = HWHttpRequestOperationManager.baseManager()
        var param = NSMutableDictionary()
        
        param.setPObject(HWUserLogin.currentUserLogin().key, forKey: "key")
        param.setPObject(_scdHouseId, forKey: "scdhandHousesId")
        param.setPObject(content, forKey: "appealReason")
        
        manager.postHttpRequest(kScdHouComplain, parameters: param, queue: nil, success: { (responseObject) -> Void in
            
            Utility.hideMBProgress(self)
            Utility.showToastWithMessage("投诉成功", _view: self)
            self.refreshData()
            
            NSNotificationCenter.defaultCenter().postNotificationName("scdHouListRefeshData", object: nil)
            
            }) { (code, error) -> Void in
                
                Utility.hideMBProgress(self)
                Utility.showToastWithMessage(error, _view: self)
        }
    }
    
    //MARK: 关联客户 点击事件
    //跳转关联客户页面
    @objc private func linkCustomBtnClick()
    {
        MobClick.event("SCDhouse-clientmatch_click")//maidian_3.0_niedi
        
        var linkCustomVC = HWScdHouLinkCustomVC()
        linkCustomVC.houseId = _model.scdHandHousesId
        linkCustomVC.houseName = _model.villageName
        linkCustomVC.isMultipleChoice = true
        _delegate.delegatePushVC(linkCustomVC)
    }
    //MARK: 成交确认 点击事件

    func turnoverBtn()
    {
        let turnoverVC = HWTurnoverVC()
        turnoverVC.houseId = _model.scdHandHousesId
        _delegate .delegatePushVC(turnoverVC)
    }
     //MARK: 跳转租售中心 点击事件
    func gotoRental()
    {
//        Utility.showMBProgress(self, _message: "加载中")
//        let manager = HWHttpRequestOperationManager.baseManager()
//        var param: NSMutableDictionary = NSMutableDictionary()
//        param.setPObject(HWUserLogin.currentUserLogin().key, forKey: "key")
//        param .setObject(_model.token, forKey: "token")
//        param .setObject(_model.customerId, forKey: "customerId")
//        param .setObject(_model.orderId, forKey: "orderId")
//        param .setObject(_model.orderType, forKey: "orderType")
//        param .setObject(_model.brokerId, forKey: "brokerId")
//        
//        manager .postHttpRequest(KgoToRental, parameters: param, queue: nil, success: { (responseObject) -> Void in
//            Utility .hideMBProgress(self);
//            Utility .showToastWithMessage("请求成功", _view: self)
//            let dict: NSDictionary = responseObject as NSDictionary
//            let dataArr: NSArray = dict.arrayObjectForKey("data")
//            
//            
//            }, failure: { (error, code) -> Void in
//                Utility .hideMBProgress(self);
//                Utility .showToastWithMessage(error, _view: self)
//        })

        Utility.showMBProgress(self, _message: "加载中")
        let manager = HWHttpRequestOperationManager.baseManager()
        var param: NSMutableDictionary = NSMutableDictionary()
        param.setPObject(HWUserLogin.currentUserLogin().key, forKey: "key")
        param .setObject(_model.messageId, forKey: "messageId")
        param .setObject(_model.messageSource, forKey: "source")
        manager .postHttpRequest(kMessageDetail, parameters: param, queue: nil, success: { (responseObject) -> Void in
            Utility .hideMBProgress(self);
            Utility .showToastWithMessage("请求成功", _view: self)
            var dataDic = NSDictionary()
            let dict: NSDictionary = responseObject as NSDictionary
            var dataArr:NSArray = dict.arrayObjectForKey("data")
            dataDic = dataArr.objectAtIndex(0) as NSDictionary
            var webVC = HWWebViewController()
            webVC.messageModel.messageId = self._model.messageId
            webVC.messageModel.source = self._model.messageSource
            webVC.urlStr = dataDic.stringObjectForKey("imUrl")
            if dataDic.stringObjectForKey("imUrl").length == 0
            {
                Utility .showToastWithMessage("不可跳转", _view:self)
                return
            }
            else
            {
                self._delegate.delegatePushVC(webVC);
                
            }
            
            
            }, failure: { (error, code) -> Void in
                Utility .hideMBProgress(self);
                if (error.integerValue == kStatusFailure )
                {
                    Utility .showToastWithMessage("网络未连接", _view: self)
                }
                else
                {
                    Utility .showToastWithMessage(error, _view: self)
                    
                }
        })

//        var webVC = HWWebViewController()
//        webVC.urlStr = _model.phpImUrl;
//        webVC.type = "二手房";
//        webVC.messageModel.messageId = _model.messageId
//        webVC.messageModel.source = _model.messageSource
//        webVC.secondId = _scdHouseId;
//        _delegate.delegatePushVC(webVC);
    }
    //MARK: tableView Delegate
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int
    {
        if(_model.whichOne == "Mine"||_model.myAppoint == "yes")
        {
            return 1
        }
        
        return 0
    }
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell
    {
        let cellId = "cellid"
        var cell: HWScdHouseDetailCell? = tableView.dequeueReusableCellWithIdentifier(cellId) as? HWScdHouseDetailCell
        if(cell == nil)
        {
            cell = HWScdHouseDetailCell(style: UITableViewCellStyle.Default, reuseIdentifier: cellId)
        }
        cell?.setContent(_model)
        cell?.contentView.drawBottomLine()
        cell?.contentView.drawTopLine()
        
        return cell!
    }
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath)
    {
        tableView.deselectRowAtIndexPath(indexPath, animated: true)
        
        if(_model.whichOne == "Mine")
        {
            if(!(_model.scdHouseCount == "0" || _model.scdHouseCount == ""))
            {
                var appointListVC = HWScdHouAppointListVC()
                if(_model.status == "putdown")
                {
                    appointListVC.isPutDown = true
                }
                appointListVC.houseId = _scdHouseId
                _delegate.delegatePushVC(appointListVC)
            }
        }
        else if(_model.lock == "no")
        {
            if(_model.complaint == "0")
            {
                let al = HWCustomAlertView(type: AlertViewType.EditComplain)
                shareAppDelegate.window?.addSubview(al)
                al.delegate = self
                al.showAnimate()
            }
        }
    }
    
    //MARK: headerView
    func loadTableViewHeaderView()
    {
        tableViewHeaderBackView = UIView(frame: CGRectMake(0, 0, kScreenWidth, 400 + 205 * kScreenRate + 70))
        tableViewHeaderBackView.backgroundColor = UIColor.clearColor()
        tableViewHeaderBackView.drawBottomLine()
        
        //图片墙
        topScrollView = UIScrollView(frame: CGRectMake(0, 0, kScreenWidth, 205 * kScreenRate))
        topScrollView.backgroundColor = UIColor.whiteColor()
        topScrollView.delegate = self
        topScrollView.pagingEnabled = true
        topScrollView.showsHorizontalScrollIndicator = false
        tableViewHeaderBackView.addSubview(topScrollView)
        //房源状态
        var houseStatusBackImgView:UIImageView = UIImageView(frame: CGRectMake(kScreenWidth - 80, 0, 80, 35))
        houseStatusBackImgView.backgroundColor = CD_Btn_GreenColor
        tableViewHeaderBackView.addSubview(houseStatusBackImgView)
        
        houseStatusLab = UILabel(frame: CGRectMake(0, 10, houseStatusBackImgView.frame.width, 15))
        houseStatusLab.font = Define.font(TF_15)
        houseStatusLab.textColor = UIColor.whiteColor();
        houseStatusLab.textAlignment = NSTextAlignment.Center
        houseStatusLab.lineBreakMode = NSLineBreakMode.ByTruncatingMiddle
        houseStatusBackImgView.addSubview(houseStatusLab)
        
        
        
        //共几人 预约 背景图片
        appointBackImgView = UIImageView(frame: CGRectMake(kScreenWidth - 80, 35, 80, 50))
        tableViewHeaderBackView.addSubview(appointBackImgView)
        
        appointNumLab = UILabel(frame: CGRectMake(0, 10, appointBackImgView.frame.width, 15))
        appointNumLab.font = Define.font(TF_15)
        appointNumLab.textColor = CD_Txt_MainColor
        appointNumLab.textAlignment = NSTextAlignment.Center
        appointNumLab.lineBreakMode = NSLineBreakMode.ByTruncatingMiddle
        appointBackImgView.addSubview(appointNumLab)
        
        yuyueLab = UILabel(frame: CGRectMake(0, appointNumLab.frame.maxY + 3, appointNumLab.frame.width, 15))
        yuyueLab.font = Define.font(TF_14)
        yuyueLab.textColor = CD_Txt_Color_ff
        yuyueLab.text = "预约"
        yuyueLab.textAlignment = NSTextAlignment.Center
        appointBackImgView.addSubview(yuyueLab)
        
        //"标题"白色背景 View
        var titleBackView: UIView! = UIView(frame: CGRectMake(0, topScrollView.frame.maxY, kScreenWidth, 125))
        titleBackView.backgroundColor = UIColor.whiteColor()
//        titleBackView.drawTopLine()
        titleBackView.drawBottomLine()
        tableViewHeaderBackView.addSubview(titleBackView)
        
        //标题 lab
        titleLab = UILabel(frame: CGRectMake(80 * kScreenRate + 25, 0, kScreenWidth - 15 - 80 * kScreenRate - 25, 66))
        titleLab.font = Define.font(TF_16)
        titleLab.textColor = CD_Txt_Color_00
        titleLab.numberOfLines = 0
        titleLab.text = ""
        titleBackView.addSubview(titleLab)
        
        //划线
        titleBackView.addSubview(Utility.drawLine(CGPointMake(0, 67), width: kScreenWidth))
        titleBackView.addSubview(Utility.drawVerticalLine(CGPointMake(kScreenWidth / 3.0, 67), height: titleBackView.frame.height - 67))
        titleBackView.addSubview(Utility.drawVerticalLine(CGPointMake(kScreenWidth / 3.0 * 2.0, 67), height: titleBackView.frame.height - 67))
        
        //"售价" 标签
        var priceTitleLab = UILabel(frame: CGRectMake(0, 67 + 10, kScreenWidth / 3, 15))
        priceTitleLab.font = Define.font(TF_15)
        priceTitleLab.textColor = CD_Txt_Color_00
        priceTitleLab.text = "售价"
        priceTitleLab.textAlignment = NSTextAlignment.Center
        titleBackView.addSubview(priceTitleLab)
        
        priceLab = UILabel(frame: CGRectMake(0, priceTitleLab.frame.maxY + 8, kScreenWidth / 3, 15))
        priceLab.font = Define.font(TF_16)
        priceLab.textColor = CD_Txt_MainColor
        priceLab.textAlignment = NSTextAlignment.Center
        titleBackView.addSubview(priceLab)
        
        //"房型" 标签
        var typeTitleLab = UILabel(frame: CGRectMake(kScreenWidth / 3, priceTitleLab.frame.minY, kScreenWidth / 3, 15))
        typeTitleLab.font = Define.font(TF_15)
        typeTitleLab.textColor = CD_Txt_Color_00
        typeTitleLab.text = "房型"
        typeTitleLab.textAlignment = NSTextAlignment.Center
        titleBackView.addSubview(typeTitleLab)
        
        houseTypeLab = UILabel(frame: CGRectMake(kScreenWidth / 3, priceLab.frame.minY, kScreenWidth / 3, 15))
        houseTypeLab.font = Define.font(TF_16)
        houseTypeLab.textColor = CD_Txt_MainColor
        houseTypeLab.textAlignment = NSTextAlignment.Center
        titleBackView.addSubview(houseTypeLab)
        
        //"面积" 标签
        var areaTitleLab = UILabel(frame: CGRectMake(kScreenWidth / 3 * 2, priceTitleLab.frame.minY, kScreenWidth / 3, 15))
        areaTitleLab.font = Define.font(TF_15)
        areaTitleLab.textColor = CD_Txt_Color_00
        areaTitleLab.text = "面积"
        areaTitleLab.textAlignment = NSTextAlignment.Center
        titleBackView.addSubview(areaTitleLab)
        
        areaLab = UILabel(frame: CGRectMake(kScreenWidth / 3 * 2, priceLab.frame.minY, kScreenWidth / 3, 15))
        areaLab.font = Define.font(TF_16)
        areaLab.textColor = CD_Txt_MainColor
        areaLab.textAlignment = NSTextAlignment.Center
        titleBackView.addSubview(areaLab)
        
        tableViewHeaderBackView.addSubview(Utility.drawLine(CGPointMake(0, topScrollView.frame.maxY), width: kScreenWidth))
        
        //地图img 底部阴影view
        var shadowView = UIView(frame: CGRectMake(13, (205 - 23) * kScreenRate, 80 * kScreenRate, 80 * kScreenRate))
        shadowView.backgroundColor = CD_Txt_Color_99
        shadowView.layer.cornerRadius = shadowView.frame.width / 2.0
        shadowView.layer.shadowColor = CD_Txt_Color_99.CGColor
        shadowView.layer.shadowOffset = CGSizeMake(0, 2)
        shadowView.layer.shadowOpacity = 0.9
        shadowView.layer.shadowRadius = 2
        shadowView.userInteractionEnabled = false
        tableViewHeaderBackView.addSubview(shadowView)
        
        //地图img View
        mapImgView = UIImageView(frame: CGRectMake(13, (205 - 23) * kScreenRate, 80 * kScreenRate, 80 * kScreenRate))
        mapImgView.image = UIImage(named: "bitmap")
        mapImgView.layer.cornerRadius = mapImgView.frame.width / 2.0
        mapImgView.layer.masksToBounds = true
        mapImgView.userInteractionEnabled = true
        tableViewHeaderBackView.addSubview(mapImgView)
         imageCenter = UIImageView(frame: CGRectMake(mapImgView.center.x+10, topScrollView.frame.maxY-27, 90, 27))
//        imageCenter.backgroundColor = UIColor.whiteColor();
        imageCenter.image = UIImage(named: "label_12")
        tableViewHeaderBackView .addSubview(imageCenter)
        //房源详情backView
        detailBackView = UIView(frame: CGRectMake(0, topScrollView.frame.maxY + 125 + 10 , kScreenWidth, 265+70))
        detailBackView.backgroundColor = CD_WhiteColor
        detailBackView.drawTopLine()
        tableViewHeaderBackView.addSubview(detailBackView)
        
        //小区
        villageLab = UILabel(frame: CGRectMake(15, 17, kScreenWidth - 2 * 15, 20))
        villageLab.font = Define.font(TF_15)
        villageLab.text = "小区: "
        detailBackView.addSubview(villageLab)
        
        //地址
        addressLab = UILabel(frame: CGRectMake(15, villageLab.frame.maxY + 10, kScreenWidth - 2 * 15, 20))
        addressLab.font = Define.font(TF_15)
        addressLab.text = "地址: "
        detailBackView.addSubview(addressLab)
        
        //楼层
        floorLab = UILabel(frame: CGRectMake(15, addressLab.frame.maxY + 10, 170 - 15, 20))
        floorLab.font = Define.font(TF_15)
        floorLab.text = "楼层: "
        detailBackView.addSubview(floorLab)
        
        //朝向
        towardLab = UILabel(frame: CGRectMake(170, floorLab.frame.minY, kScreenWidth - 170 - 15, 20))
        towardLab.font = Define.font(TF_15)
        towardLab.text = "朝向: "
        detailBackView.addSubview(towardLab)
        
        //单价
        UnitPriceLab = UILabel(frame: CGRectMake(15, floorLab.frame.maxY + 10, 170 - 15, 20))
        UnitPriceLab.font = Define.font(TF_15)
        UnitPriceLab.text = "单价: "
        detailBackView.addSubview(UnitPriceLab)
        
        //类型
        typeLab = UILabel(frame: CGRectMake(170, UnitPriceLab.frame.minY, kScreenWidth - 170 - 15, 20))
        typeLab.font = Define.font(TF_15)
        typeLab.text = "类型: "
        detailBackView.addSubview(typeLab)
        
        //产权
        propertyRightsLab = UILabel(frame: CGRectMake(15, UnitPriceLab.frame.maxY + 10, 170 - 15, 20))
        propertyRightsLab.font = Define.font(TF_15)
        propertyRightsLab.text = "产权: "
        detailBackView.addSubview(propertyRightsLab)
        
        //年代
        yearLab = UILabel(frame: CGRectMake(170, propertyRightsLab.frame.minY, kScreenWidth - 15 - 170, 20))
        yearLab.font = Define.font(TF_15)
        yearLab.text = "建成年代: "
        detailBackView.addSubview(yearLab)
        
        //标签
        signTlab = UILabel(frame: CGRectMake(15, propertyRightsLab.frame.maxY + 10, kScreenWidth - 15 * 2, 20))
        signTlab.font = Define.font(TF_15)
        signTlab.text = "标签: "
        detailBackView.addSubview(signTlab)
        //房源描述
        detailHouse = UILabel(frame: CGRectMake(15, signTlab.frame.maxY+10, kScreenWidth - 15 * 2, 20))
        detailHouse.text = "房源描述: "
        detailHouse.font = Define.font(TF_15)
        detailHouse.textColor = CD_Txt_Color_00;
        detailBackView .addSubview(detailHouse)
        
        detailLab = UILabel(frame: CGRectMake(15, detailHouse.frame.maxY, kScreenWidth - 15 * 2, 40))
        detailLab.text = ""
        detailLab.numberOfLines = 2
        detailLab.font = Define.font(TF_15)
        detailLab.textColor = CD_Txt_Color_99;
        detailBackView .addSubview(detailLab)
        //画线

        
        //取“房源方电话”标签的水平中心
        var centerpoint: CGPoint = CGPoint()
        centerpoint.y = detailLab.frame.maxY + 20 + (detailBackView.frame.height - detailLab.frame.maxY - 20 - 10) / 2.0
        
        //“房源方电话“标签
        houseSourceTelLab = UILabel(frame: CGRectMake(15, detailLab.frame.maxY + 35, kScreenWidth - 2 * 15, 15))
        centerpoint.x = houseSourceTelLab.center.x
        houseSourceTelLab.center = centerpoint
        houseSourceTelLab.font = Define.font(TF_15)
        houseSourceTelLab.textColor = CD_Txt_Color_00
        detailBackView.addSubview(houseSourceTelLab)
        
        //电话
        phoneLab = UILabel(frame: CGRectMake(95, houseSourceTelLab.frame.minY, kScreenWidth - 15 - 100 - 30 - 5, 15))
        centerpoint.x = phoneLab.center.x
        phoneLab.center = centerpoint
        phoneLab.font = Define.font(TF_15)
        phoneLab.textColor = CD_Txt_Color_99
        phoneLab.textAlignment = NSTextAlignment.Right
        phoneLab.text = "电话"
        detailBackView.addSubview(phoneLab)
        
        phoneIconBtn = UIButton.buttonWithType(UIButtonType.Custom) as UIButton
        phoneIconBtn.frame = CGRectMake(phoneLab.frame.maxX + 8, houseSourceTelLab.frame.minY - 8, 30, 30)
        centerpoint.x = phoneIconBtn.center.x
        phoneIconBtn.center = centerpoint
        phoneIconBtn.addTarget(self, action: "phoneBtnClick", forControlEvents: UIControlEvents.TouchUpInside)
        detailBackView.addSubview(phoneIconBtn)
        
        var cellHeaderView = UIView(frame: CGRectMake(0, detailBackView.frame.height - 10, kScreenWidth, 10))
        cellHeaderView.backgroundColor = CD_BackGroundColor
        cellHeaderView.drawTopLine()
        detailBackView.addSubview(cellHeaderView)
        
        baseTable.tableHeaderView = tableViewHeaderBackView
    }
    
    //MARK: footView
    private func loadTableViewFootView()
    {
        tableViewFootBackView = UIView(frame: CGRectMake(0, 0, kScreenWidth, 85))
        
        appointmentBtn = UIButton.buttonWithType(UIButtonType.Custom) as UIButton
        appointmentBtn.frame = CGRectMake(15, 20, (kScreenWidth - 3 * 15) / 2, 45)
        appointmentBtn.layer.cornerRadius = 3
        appointmentBtn.layer.masksToBounds = true
        appointmentBtn.setTitle("预约看房", forState: UIControlState.Normal)
        appointmentBtn.titleLabel?.font = Define.font(TF_Btn_Title_19)
        appointmentBtn.addTarget(self, action: "appointBtnClick", forControlEvents: UIControlEvents.TouchUpInside)
        tableViewFootBackView.addSubview(appointmentBtn)
        
        linkCustomBtn = UIButton.buttonWithType(UIButtonType.Custom) as UIButton
        linkCustomBtn.frame = CGRectMake(appointmentBtn.frame.maxX + 15, appointmentBtn.frame.minY, appointmentBtn.frame.width, 45)
        linkCustomBtn.layer.cornerRadius = 3
        linkCustomBtn.layer.masksToBounds = true
        linkCustomBtn.setBackgroundImage(Utility.imageWithColor(CD_Btn_MainColor, _size: linkCustomBtn.frame.size), forState: UIControlState.Normal)
        linkCustomBtn.setTitle("关联客户", forState: UIControlState.Normal)
        linkCustomBtn.titleLabel?.font = Define.font(TF_Btn_Title_19)
        linkCustomBtn.addTarget(self, action: "linkCustomBtnClick", forControlEvents: UIControlEvents.TouchUpInside)
        tableViewFootBackView.addSubview(linkCustomBtn)
        
        baseTable.tableFooterView = tableViewFootBackView
    }
    
    //MARK: 更改字体属性 setAttributeString
    private func setAttributeString(labText: String, ContentForLab: String) -> NSAttributedString
    {
        var attributeStr = NSMutableAttributedString(string: "\(labText)\(ContentForLab)")
        attributeStr.addAttributes([NSFontAttributeName : Define.font(TF_15)], range: NSMakeRange(0, countElements(labText + ContentForLab)))
        attributeStr.addAttributes([NSForegroundColorAttributeName : CD_Txt_Color_00], range: NSMakeRange(0, 4))
        attributeStr.addAttributes([NSForegroundColorAttributeName: CD_Txt_Color_99], range: NSMakeRange(4, countElements(ContentForLab)))
        
        return attributeStr
    }
    private func setAttributeStrings(labText: String, ContentForLab: String) -> NSAttributedString
    {
        var attributeStr = NSMutableAttributedString(string: "\(labText)\(ContentForLab)")
        attributeStr.addAttributes([NSFontAttributeName : Define.font(TF_15)], range: NSMakeRange(0, countElements(labText + ContentForLab)))
        attributeStr.addAttributes([NSForegroundColorAttributeName : CD_Txt_Color_00], range: NSMakeRange(0, 6))
        attributeStr.addAttributes([NSForegroundColorAttributeName: CD_Txt_Color_99], range: NSMakeRange(6, countElements(ContentForLab)))
        
        return attributeStr
    }

    required init(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

}
