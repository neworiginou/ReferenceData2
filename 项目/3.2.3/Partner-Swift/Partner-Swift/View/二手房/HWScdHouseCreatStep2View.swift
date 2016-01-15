//
//  HWScdHouseCreatStep2View.swift
//  Partner-Swift
//
//  Created by niedi on 15/3/6.
//  Copyright (c) 2015年 caijingpeng.haowu. All rights reserved.
//
//  功能描述：二手房房源发布添加图片View\房源编辑修改图片Veiw
//
//  修改记录：
//      姓名         日期               修改内容
//      聂迪      2015-02-26           UI、数据请求及功能逻辑实现
//

import UIKit
import AVKit
import AVFoundation
import MobileCoreServices

protocol HWScdHouseCreatStep2ViewDelegate: NSObjectProtocol
{
    func delegatePresentVC(vc: UIViewController)
    func delegatePopToRootVC()
    func delegatePopToScdHouDetailVC()
    func delegatePushVC(vc: UIViewController)
}


class HWScdHouseCreatStep2View: HWBaseRefreshView, HWImageScrollViewDelegate, UIActionSheetDelegate, UIImagePickerControllerDelegate, UINavigationControllerDelegate, HWImageEditVCDelegate
{
    var _isCreat: CreatOrEdit!
    var _model: HWScdHouseDetailModel!
    var _houseId: NSString! = ""
    weak var delegate: HWScdHouseCreatStep2ViewDelegate!
    
    var subScro1: HWImageScrollView!
    var subScro2: HWImageScrollView!
    var currentScro: HWImageScrollView! = nil
    var indoorImageArr: NSMutableArray! = []
    var houseStyleImageArr: NSMutableArray! = []
    var _firString: NSString! = ""
    var isHaveChanged = false
    var isDelete: Bool = false
    var titleArr:NSMutableArray = NSMutableArray()
    var detailArr:NSMutableArray = NSMutableArray()
    var isDianji:NSString = NSString()
    var btn1 = UIButton()
    var btn2 = UIButton()
    var btn3 = UIButton()
    var _permission = NSString()
    
    init(frame: CGRect, isCreat: CreatOrEdit, model: HWScdHouseDetailModel, indoorArr: NSArray, houseStyleArr: NSArray, houseId: String)
    {
        super.init(frame: frame)
        
        _isCreat = isCreat
        if(_isCreat == CreatOrEdit.Creat)
        {
            _model = model
        }
        else if(_isCreat == CreatOrEdit.EditConfig)
        {
            _model = model
            _houseId = _model.scdHandHousesId
            indoorImageArr = NSMutableArray(array: _model.inner)
            houseStyleImageArr = NSMutableArray(array: _model.house)
           
           
        }
        else
        {
            indoorImageArr = NSMutableArray(array: indoorArr)
            houseStyleImageArr = NSMutableArray(array: houseStyleArr)
            _houseId = houseId
            _model = model
            
        }
        
        titleArr = ["我的房店","所有经纪人"]
        detailArr = ["仅我自己可以看到该房源","本城市所有经纪人可以看到该房源"]
        
        isDianji = "0"
        self.loadUI()
        
    }
    
    func loadUI()
    {
        var backGroundView: UIScrollView = UIScrollView(frame: self.frame)
        backGroundView.contentSize = CGSizeMake(kScreenWidth, contentHeight + 100)
        backGroundView.backgroundColor = UIColor.clearColor()
        self.addSubview(backGroundView)
        
        var titleLab: UILabel = UILabel(frame: CGRectMake(15, 5, kScreenWidth - 2 * 15, 20))
        titleLab.font = Define.font(TF_14)
        titleLab.textColor = CD_Txt_Color_99
        titleLab.text = "添加房源图片"
        backGroundView.addSubview(titleLab)
        
        //第一层View
        var floor1View: UIView = UIView(frame: CGRectMake(0, 30, kScreenWidth, 110))
        floor1View.backgroundColor = CD_WhiteColor
        floor1View.drawTopLine()
        floor1View.drawBottomLine()
        backGroundView.addSubview(floor1View)
        
        var subTitLab1: UILabel = UILabel(frame: CGRectMake(15, 5, kScreenWidth - 2 * 15, 20))
        subTitLab1.font = Define.font(TF_15)
        subTitLab1.textColor = CD_Txt_Color_00
        subTitLab1.text = "室内图"
        floor1View.addSubview(subTitLab1)
        
        subScro1 = HWImageScrollView(frame: CGRectMake(0, 30, kScreenWidth, 110 - 30 - 10))
        subScro1.del = self
        subScro1.fillWithArray(indoorImageArr)
        floor1View.addSubview(subScro1)
        
        //第二层View
        var floor2View: UIView = UIView(frame: CGRectMake(0, 110 + 30 + 5, kScreenWidth, 110))
        floor2View.backgroundColor = CD_WhiteColor
        floor2View.drawBottomLine()
        floor2View.drawTopLine()
        backGroundView.addSubview(floor2View)
        
        var subTitLab2: UILabel = UILabel(frame: CGRectMake(15, 5, kScreenWidth, 20))
        subTitLab2.font = Define.font(TF_15)
        subTitLab2.textColor = CD_Txt_Color_00
        subTitLab2.text = "户型图"
        floor2View.addSubview(subTitLab2)
        
        subScro2 = HWImageScrollView(frame: CGRectMake(0, 30, kScreenWidth - 2 * 15, 110 - 30 - 10))
        subScro2.del = self
        subScro2.fillWithArray(houseStyleImageArr)
        floor2View.addSubview(subScro2)
        
        baseTable.frame = CGRectMake(0, CGRectGetMaxY(floor2View.frame), kScreenWidth, 160);
        backGroundView .addSubview(baseTable)
        //发布或提交按钮
        var publishBtn: UIButton = UIButton.buttonWithType(UIButtonType.Custom) as UIButton
        publishBtn.frame = CGRectMake(15, baseTable.frame.maxY + 20, kScreenWidth - 2 * 15, 45)
        publishBtn.setBackgroundImage(Utility.imageWithColor(CD_Btn_MainColor, _size: CGSizeMake(kScreenWidth - 2 * 15, 45)), forState: UIControlState.Normal)
        publishBtn.layer.cornerRadius = 3
        publishBtn.layer.masksToBounds = true
        publishBtn.titleLabel?.font = Define.font(TF_Btn_Title_19)
        if(_isCreat == CreatOrEdit.Creat)
        {
            publishBtn.setTitle("发布房源", forState: UIControlState.Normal)
        }
        else
        {
            publishBtn.setTitle("确定", forState: UIControlState.Normal)
        }
        publishBtn.addTarget(self, action: "publishBtnClick", forControlEvents: UIControlEvents.TouchUpInside)
        backGroundView.addSubview(publishBtn)
    }
    
    //发布或提交按钮 点击事件
    @objc private func publishBtnClick()
    {
        //发布
        if(_isCreat == CreatOrEdit.Creat)
        {
            MobClick.event("SubmitSCDhouse-OK_click")//maidian_3.0_niedi
            
            self.publishScdHouseQuery()
        }
        else if(_isCreat == CreatOrEdit.EditConfig)
        {
            self.editHouse()
            if(isHaveChanged == true)
            {
                self.editScdHouPicQuery()
            }
            else
            {
                delegate.delegatePopToScdHouDetailVC()
            }

        }
        else
        {
            if(isHaveChanged == true)
            {
                self.editScdHouPicQuery()
                 self.editHouse()
                
            }
            else
            {
                delegate.delegatePopToScdHouDetailVC()
            }
        }
    }
    //编辑按钮 点击事件
     func editHouse()
    {
        /*URL:myStore/editHouses.do
        入参：
        key:*** --用户key
        id:***, -二手房id
        housesOwnerName:***, -业主名字
        housesOwnerPhone:***, -业主电话
        sex:***, --业主性别
        buildingNo:***, --楼号
        houseNo:***, --门牌
        propertyRights:***, --产权
        years:***, --年代
        toward:***, --朝向
        type:***, --类型
        decorate:***, --装修
        sign:***, --标签
        title:***, --标题
        price:***, --价格
        proportion:***, --面积
        roomCount:***, --几室
        hallCount:***, --几厅
        roomType:***, --户型
        toiletCount:***, --卫生间
        floor:***, --楼层
        floorSum:***, --共几层
        出参：
        {"detail":"请求数据成功!","status":"1","data":"房源编辑成功"} */
        Utility.hideMBProgress(self)
        Utility.showMBProgress(self, _message: "上传中")
        
        let manager = HWHttpRequestOperationManager.baseManager()
        var param = NSMutableDictionary()
        
        param.setPObject(HWUserLogin.currentUserLogin().key, forKey: "key")
        param.setPObject(_model.scdHandHousesId, forKey: "id")
        if(_model.title == "")
        {
            param.setPObject(_model.villageName, forKey: "title")
        }
        else
        {
            param.setPObject(_model.title, forKey: "title")
        }
        param.setPObject(_model.buildingNo, forKey: "buildingNo")
        param.setPObject(_model.houseNo, forKey: "houseNo")
        var priceFloat = (_model.price as NSString).doubleValue
        param.setPObject(NSString(format:"%.2f",priceFloat * 10000.0), forKey: "price")
        param.setPObject(_model.area, forKey: "proportion")
        param.setPObject(_model.propertyRights, forKey: "propertyRights")
        param.setPObject(_model.years, forKey: "years")
        param.setPObject(_model.type, forKey: "type")
        param.setPObject(_model.roomCount, forKey: "roomCount")
        param.setPObject(_model.hallCount, forKey: "hallCount")
        param.setPObject(_model.toiletCount, forKey: "toiletCount")
        param.setPObject(_model.floor, forKey: "floor")
        param.setPObject(_model.floorSum, forKey: "floorSum")
        param.setPObject(_model.toward, forKey: "toward")
        param.setPObject(_model.decorate, forKey: "decorate")
        param.setPObject(_model.name, forKey: "housesOwnerName")
        param.setPObject(_model.phone, forKey: "housesOwnerPhone")
        param.setPObject(_model.sex, forKey: "sex")
        param.setPObject(_model.housesDescription, forKey: "housesDescription")
        if btn3.imageView?.image == UIImage(named: "choose_2_2")
        {
            _permission = "C"
        }
        if btn1.imageView?.image == UIImage(named: "choose_2_2")
        {
            _permission = "A"
        }

        param .setObject(_permission, forKey: "permission")
        var tmpStr = ""
        for var i = 0; i < _model.sign.count; i++
        {
            tmpStr = "\(tmpStr)\(_model.sign[i]),"
        }
        
        if (tmpStr.hasPrefix(","))
        {
            tmpStr = (tmpStr as NSString).substringFromIndex(1)
        }
        if (tmpStr.hasSuffix(","))
        {
            tmpStr = (tmpStr as NSString).substringToIndex(countElements(tmpStr) - 1)
        }
        
//        if(countElements(tmpStr) > 0)
//        {
//            tmpStr = tmpStr.substringToIndex(advance(tmpStr.endIndex, -1))
//        }
        param.setPObject(tmpStr, forKey: "sign")
        
        manager.postHttpRequest(KScdHouEdit, parameters: param, queue: nil, success: { (responseObject) -> Void in
            
            Utility.hideMBProgress(self)
            Utility.showToastWithMessage("编辑成功", _view: self)
            self.delegate.delegatePopToScdHouDetailVC()            
            
            }) { (code, error) -> Void in
                
                Utility.hideMBProgress(self)
                
                Utility.showToastWithMessage(error, _view: self)
        }
    }

    //提交按钮 点击事件
    func editScdHouPicQuery()
    {
        /*url:/MyHousesInfo/updateHousePic.do
        入参：scdHandHousesId=6
        comm[0].picKey=url
        comm[0].picType=comm_img
        comm[0].isMain=yes
        comm[1].picKey=url
        comm[1].picType=comm_img
        comm[1].isMain=no
        出参：
        {"detail":"请求数据成功!","status":"1","data":"修改图片成功"} */
        
        Utility.hideMBProgress(self)
        if(self.isDelete == true)
        {
            Utility.showMBProgress(self, _message: "保存修改中")
        }
        else
        {
            Utility.showMBProgress(self, _message: "上传中")
        }
        
        let manager = HWHttpRequestOperationManager.baseManager()
        var param = NSMutableDictionary()
        
        var isHasFirst = false
        for dict in indoorImageArr
        {
            var d = dict as NSDictionary
            var pickey = d.stringObjectForKey("picKey")
            if(pickey as NSString == _firString)
            {
                isHasFirst = true
            }
        }
        
        for dict in houseStyleImageArr
        {
            var d = dict as NSDictionary
            var pickey = d.stringObjectForKey("picKey")
            if(pickey as NSString == _firString)
            {
                isHasFirst = true
            }
        }
        
        /*comm[0].picType", inner_img
        "comm[0].picKey", picKey
        "comm[0].isMain", yes*/
        
        /*comm[0].picType", house_img
        "comm[0].picKey", picKey
        "comm[0].isMain", yes*/
        
        if(isHasFirst == true)
        {
            for var i = 0; i < indoorImageArr.count; i++
            {
                var tmpDict: NSDictionary = indoorImageArr.objectAtIndex(i) as NSDictionary
                var pick = tmpDict.stringObjectForKey("picKey")
                
                param.setPObject("inner_img", forKey: "comm[\(i)].picType")
                
                if(pick == _firString)
                {
                    param.setPObject("yes", forKey: "comm[\(i)].isMain")
                }
                else
                {
                    param.setPObject("no", forKey: "comm[\(i)].isMain")
                }
                param.setPObject(pick, forKey: "comm[\(i)].picKey")
            }
            
            for var i = 0; i < houseStyleImageArr.count; i++
            {
                var tmpDict: NSDictionary = houseStyleImageArr.objectAtIndex(i) as NSDictionary
                var pick = tmpDict.stringObjectForKey("picKey")
                
                param.setPObject("house_img", forKey: "comm[\(indoorImageArr.count + i)].picType")
                if(isHasFirst == true)
                {
                    if(pick == _firString)
                    {
                        param.setPObject("yes", forKey: "comm[\(indoorImageArr.count + i)].isMain")
                    }
                    else
                    {
                        param.setPObject("no", forKey: "comm[\(indoorImageArr.count + i)].isMain")
                    }
                }
                else
                {
                    if(i == 0 && indoorImageArr.count == 0)
                    {
                        param.setPObject("yes", forKey: "comm[\(indoorImageArr.count + i)].isMain")
                    }
                    else
                    {
                        param.setPObject("no", forKey: "comm[\(indoorImageArr.count + i)].isMain")
                    }
                }
                
                param.setPObject(pick, forKey: "comm[\(indoorImageArr.count + i)].picKey")
            }
        }
        else
        {
            for var i = 0; i < indoorImageArr.count; i++
            {
                var tmpDict: NSDictionary = indoorImageArr.objectAtIndex(i) as NSDictionary
                var pick = tmpDict.stringObjectForKey("picKey")
                
                param.setPObject("inner_img", forKey: "comm[\(i)].picType")
                if(i == 0)
                {
                    param.setPObject("yes", forKey: "comm[\(i)].isMain")
                }
                else
                {
                    param.setPObject("no", forKey: "comm[\(i)].isMain")
                }
                
                param.setPObject(pick, forKey: "comm[\(i)].picKey")
            }
            for var i = 0; i < houseStyleImageArr.count; i++
            {
                var tmpDict: NSDictionary = houseStyleImageArr.objectAtIndex(i) as NSDictionary
                var pick = tmpDict.stringObjectForKey("picKey")
                
                param.setPObject("house_img", forKey: "comm[\(indoorImageArr.count + i)].picType")
                
                if(i == 0 && indoorImageArr.count == 0)
                {
                    param.setPObject("yes", forKey: "comm[\(indoorImageArr.count + i)].isMain")
                }
                else
                {
                    param.setPObject("no", forKey: "comm[\(indoorImageArr.count + i)].isMain")
                }
                
                param.setPObject(pick, forKey: "comm[\(indoorImageArr.count + i)].picKey")
            }
        }
        param.setPObject(_houseId, forKey: "scdHandHousesId")
        if btn3.imageView?.image == UIImage(named: "choose_2_2")
        {
            _permission = "C"
        }
        if btn1.imageView?.image == UIImage(named: "choose_2_2")
        {
            _permission = "A"
        }

        param .setPObject(_permission, forKey: "permission")
        manager.postHttpRequest(kscdHoueEditImg, parameters: param, queue: nil, success: { (responseObject) -> Void in
            
            Utility.hideMBProgress(self)
            Utility.showToastWithMessage("图片编辑成功", _view: self)
            self.isHaveChanged = false
            if(self.isDelete == false)
            {
                self.delegate.delegatePopToScdHouDetailVC()
            }
            self.isDelete = false
            
            }) { (code, error) -> Void in
                
                Utility.hideMBProgress(self)
                self.doneLoadingTableViewData()
                
                Utility.showToastWithMessage(error, _view: self)
        }
    }
    
    //发布按钮 点击事件
    func publishScdHouseQuery()
    {
        /*url：/MyHousesInfo/saveScdHandHouses.do
        入参：
        key: *** --用户key
        villageId:*** --小区id
        villageName:*** --小区名称
        title:*** --标题
        buildingNo:*** --楼号
        houseNo:*** --门牌号
        price:*** --价格
        area:*** --面积
        propertyRights:*** --产权
        years:*** --年代
        type:*** --类型 residence:住宅 villa:别墅 commercial:商住
        roomCount:*** --室
        hallCount:*** --厅
        toiletCount:*** --卫生间
        floor:*** --楼层
        toward:*** --朝向 south:朝南 north:朝北 east:朝东 west:朝西 east_west:东西向 south_north:南北通透
        decorate:*** --装修 workblank:毛坯 simple:简装修 refined:精装修 luxury:豪华装修
        sign:*** --标签
        
        '图片类型 comm_img:小区图;house_img:户型图;effect_img:效果图;aset_img:配套图;temp_img:样板图;inner_img:室内图',
        comm[0].picType", picType
        "comm[0].picKey", picKey
        "comm[0].isMain", isMain
        comm[1].picType", picType
        小区图数组
        house[0].picType", house_img
        "house[0].picKey", picKey
        "house[0].isMain", yes
        house[1].picType", picType
        户型图数组
        effect[0].picType", picType
        "effect[0].picKey", picKey
        "effect[0].isMain", isMain
        effect[1].picType", picType
        效果图数组
        aset[0].picType", picType
        "aset[0].picKey", picKey
        "aset[0].isMain", isMain
        aset[1].picType", picType
        配套图数组
        temp[0].picType", picType
        "temp[0].picKey", picKey
        "temp[0].isMain", isMain
        temp[1].picType", picType
        样板图数组
        inner[0].picType", inner_img
        "inner[0].picKey", picKey
        "inner[0].isMain", yes
        inner[1].picType", picType
        室内图数组
        
        name:*** --业主姓名
        phone:*** --电话
        sex:*** --性别 0女，1男
        返回参数：
        { "detail": "请求数据成功!", "status": "1", "data": "操作成功" }
        toward:*** --朝向 south:朝南 north:朝北 east:朝东 west:朝西 east_west:东西向 south_north:南北通透
        decorate:*** --装修 workblank:毛坯 simple:简装修 refined:精装修 luxury:豪华装修
        sign:*** --标签
        */
        
        Utility.hideMBProgress(self)
        Utility.showMBProgress(self, _message: "上传中")
        
        let manager = HWHttpRequestOperationManager.baseManager()
        var param = NSMutableDictionary()
        
        param.setPObject(HWUserLogin.currentUserLogin().key, forKey: "key")
        param.setPObject("\(_model.villageId)", forKey: "villageId")
        param.setPObject("\(_model.villageName)", forKey: "villageName")
        if(_model.title == "")
        {
            param.setPObject(_model.villageName, forKey: "title")
        }
        else
        {
            param.setPObject(_model.title, forKey: "title")
        }
        param.setPObject(_model.buildingNo, forKey: "buildingNo")
        param.setPObject(_model.houseNo, forKey: "houseNo")
        var priceFloat = (_model.price as NSString).doubleValue
        param.setPObject(NSString(format:"%.2f",priceFloat * 10000.0), forKey: "price")
        param.setPObject(_model.area, forKey: "area")
        param.setPObject(_model.propertyRights, forKey: "propertyRights")
        param.setPObject(_model.years, forKey: "years")
        param.setPObject(_model.type, forKey: "type")
        param.setPObject(_model.roomCount, forKey: "roomCount")
        param.setPObject(_model.hallCount, forKey: "hallCount")
        param.setPObject(_model.toiletCount, forKey: "toiletCount")
        param.setPObject(_model.floor, forKey: "floor")
        param.setPObject(_model.floorSum, forKey: "floorSum")
        param.setPObject(_model.toward, forKey: "toward")
        param.setPObject(_model.decorate, forKey: "decorate")
        param.setPObject(_model.name, forKey: "name")
        param.setPObject(_model.phone, forKey: "phone")
        param.setPObject(_model.sex, forKey: "sex")
        param.setPObject(_model.housesDescription, forKey: "housesDescription")
        if btn3.imageView?.image == UIImage(named: "choose_2_2")
        {
            _permission = "C"
        }
        param .setPObject(_permission, forKey: "permission")
        
        var tmpStr = ""
        for var i = 0; i < _model.sign.count; i++
        {
            tmpStr = "\(tmpStr)\(_model.sign[i]),"
        }
        if(countElements(tmpStr) > 0)
        {
            
            tmpStr = tmpStr.substringToIndex(advance(tmpStr.endIndex, -1))
        }
        param.setPObject(tmpStr, forKey: "sign")
        
        
        var isHasFirst = false
        for dict in indoorImageArr
        {
            var d = dict as NSDictionary
            var pickey = d.stringObjectForKey("picKey")
            if(pickey as NSString == _firString)
            {
                isHasFirst = true
            }
        }
        
        for dict in houseStyleImageArr
        {
            var d = dict as NSDictionary
            var pickey = d.stringObjectForKey("picKey")
            if(pickey as NSString == _firString)
            {
                isHasFirst = true
            }
        }
        
        /*inner[0].picType", inner_img
        "inner[0].picKey", picKey
        "inner[0].isMain", yes*/
        
        /*house[0].picType", house_img
        "house[0].picKey", picKey
        "house[0].isMain", yes*/
        if(isHasFirst == true)
        {
            for var i = 0; i < indoorImageArr.count; i++
            {
                var tmpDict: NSDictionary = indoorImageArr.objectAtIndex(i) as NSDictionary
                var pick = tmpDict.stringObjectForKey("fileKey")
                
                param.setPObject("inner_img", forKey: "inner[\(i)].picType")
                
                if(pick == _firString)
                {
                    param.setPObject("yes", forKey: "inner[\(i)].isMain")
                }
                else
                {
                    param.setPObject("no", forKey: "inner[\(i)].isMain")
                }
                param.setPObject(pick, forKey: "inner[\(i)].picKey")
            }
            
            for var i = 0; i < houseStyleImageArr.count; i++
            {
                var tmpDict: NSDictionary = houseStyleImageArr.objectAtIndex(i) as NSDictionary
                var pick = tmpDict.stringObjectForKey("fileKey")
                
                param.setPObject("house_img", forKey: "house[\(i)].picType")
                if(isHasFirst == true)
                {
                    if(pick == _firString)
                    {
                        param.setPObject("yes", forKey: "house[\(i)].isMain")
                    }
                    else
                    {
                        param.setPObject("no", forKey: "house[\(i)].isMain")
                    }
                }
                else
                {
                    if(i == 0 && indoorImageArr.count == 0)
                    {
                        param.setPObject("yes", forKey: "house[\(i)].isMain")
                    }
                    else
                    {
                        param.setPObject("no", forKey: "house[\(i)].isMain")
                    }
                }
                
                param.setPObject(pick, forKey: "house[\(i)].picKey")
            }
        }
        else
        {
            for var i = 0; i < indoorImageArr.count; i++
            {
                var tmpDict: NSDictionary = indoorImageArr.objectAtIndex(i) as NSDictionary
                var pick = tmpDict.stringObjectForKey("fileKey")
                
                param.setPObject("inner_img", forKey: "inner[\(i)].picType")
                if(i == 0)
                {
                    param.setPObject("yes", forKey: "inner[\(i)].isMain")
                }
                else
                {
                    param.setPObject("no", forKey: "inner[\(i)].isMain")
                }
                
                param.setPObject(pick, forKey: "inner[\(i)].picKey")
            }
            for var i = 0; i < houseStyleImageArr.count; i++
            {
                var tmpDict: NSDictionary = houseStyleImageArr.objectAtIndex(i) as NSDictionary
                var pick = tmpDict.stringObjectForKey("fileKey")
                
                param.setPObject("house_img", forKey: "house[\(i)].picType")
                
                if(i == 0 && indoorImageArr.count == 0)
                {
                    param.setPObject("yes", forKey: "house[\(i)].isMain")
                }
                else
                {
                    param.setPObject("no", forKey: "house[\(i)].isMain")
                }
                
                param.setPObject(pick, forKey: "house[\(i)].picKey")
            }
        }
        
        manager.postHttpRequest(KScdHouCreatPublish, parameters: param, queue: nil, success: { (responseObject) -> Void in
            
            Utility.hideMBProgress(self)
            Utility.showToastWithMessage("发布成功", _view: self)
            if (self.delegate != nil && self.delegate.respondsToSelector("delegatePopToRootVC") == true)
            {
                self.delegate.delegatePopToRootVC()
            }
            
            }) { (code, error) -> Void in
                
                Utility.hideMBProgress(self)
                Utility.showToastWithMessage(error, _view: self)
                // self.doneLoadingTableViewData()
                
                
        }
    }
    
    //MARK: HWImageScrollViewDelegate
    func showPickerWithSV(imageScrollview: HWImageScrollView!)
    {
        if(_model != nil)
        {
            if(_model.sourceWay == "")
            {
                currentScro = imageScrollview
                var actionSheet: UIActionSheet = UIActionSheet(title: nil, delegate: self, cancelButtonTitle: "取消", destructiveButtonTitle: nil, otherButtonTitles: "拍照","从相册选择")
                actionSheet.showInView(self)
            }
        }
        else
        {
            currentScro = imageScrollview
            var actionSheet: UIActionSheet = UIActionSheet(title: nil, delegate: self, cancelButtonTitle: "取消", destructiveButtonTitle: nil, otherButtonTitles: "拍照","从相册选择")
            actionSheet.showInView(self)
        }
      
    }
    
    func imageScrollView(imageScrollview: HWImageScrollView!, tapImageView imageView: UIImageView!)
    {
        currentScro = imageScrollview
        
        var imageEditVC: HWImageEditVC = HWImageEditVC()
        imageEditVC.editImage = imageView.image
        imageEditVC.delegate = self
        
        if(currentScro == subScro1)
        {
            var tmpDict: NSDictionary = indoorImageArr.objectAtIndex(imageView.tag) as NSDictionary
            imageEditVC.imageString = tmpDict.stringObjectForKey("picKey")
            if(_firString == imageEditVC.imageString)
            {
                imageEditVC.setCustomer()
            }
        }
        else
        {
            var tmpDict: NSDictionary = houseStyleImageArr.objectAtIndex(imageView.tag) as NSDictionary
            imageEditVC.imageString = tmpDict.stringObjectForKey("picKey")
            if(_firString == imageEditVC.imageString)
            {
                imageEditVC.setCustomer()
            }
        }
        
        delegate.delegatePushVC(imageEditVC)
    }
    
    func setFirstWithString(string: String!)
    {
        _firString = string;
    }
    
    //MARK: HWImageEditVCDelegate
    func doSetFirst(imageStr: String!)
    {
        if(_firString != imageStr)
        {
            _firString = imageStr
            
            if(_isCreat == CreatOrEdit.EditPicture)
            {
                var setFirstPicId = ""
                for var i = 0; i < indoorImageArr.count; i++
                {
                    var dict: NSDictionary = indoorImageArr.pObjectAtIndex(i) as NSDictionary
                    if(_firString == dict.stringObjectForKey("picKey"))
                    {
                        setFirstPicId = dict.stringObjectForKey("id")
                    }
                }
                
                for var i = 0; i < houseStyleImageArr.count; i++
                {
                    var dict: NSDictionary = houseStyleImageArr.pObjectAtIndex(i) as NSDictionary
                    if(_firString == dict.stringObjectForKey("picKey"))
                    {
                        setFirstPicId = dict.stringObjectForKey("id")
                    }
                }
                
                if(setFirstPicId != "")     //非新增图片 因新增的图片没有id（非pickey）
                {
                    self.setImgFirstQuery(setFirstPicId)
                }
            }
        }
    }
    
    //设置首图
    func setImgFirstQuery(imgId: String)
    {
        /*url:/MyHousesInfo/pic.do
        入参：
        houseId=6
        scdhousePicId=4
        出参：
        {"detail":"请求数据成功!","status":"1","data":"首页设置成功"} */
        Utility.hideMBProgress(self)
//        Utility.showMBProgress(self, _message: "设置中")
        
        let manager = HWHttpRequestOperationManager.baseManager()
        var param = NSMutableDictionary()
        
        param.setPObject(HWUserLogin.currentUserLogin().key, forKey: "key")
        param.setPObject(imgId, forKey: "scdhousePicId")
        param.setPObject(_houseId, forKey: "houseId")
        
        manager.postHttpRequest(kScdHouDetailSetFirstImg, parameters: param, queue: nil, success: { (responseObject) -> Void in
            
            Utility.hideMBProgress(self)
//            Utility.showToastWithMessage("设置首图成功", _view: self)
            
            
            }) { (code, error) -> Void in
                
                Utility.hideMBProgress(self)
                
                Utility.showToastWithMessage(error, _view: self)
        }
    }
    
    func doUnFirst()
    {
        _firString = ""
        isHaveChanged = true
    }
    
    func doDelete(imageStr: String!)
    {
        isHaveChanged = true
        var deleteImgId = ""
        for var i = 0; i < indoorImageArr.count; i++
        {
            var dict: NSDictionary = indoorImageArr.pObjectAtIndex(i) as NSDictionary
            if(imageStr == dict.stringObjectForKey("picKey"))
            {
                deleteImgId = dict.stringObjectForKey("id")
                indoorImageArr.removeObjectAtIndex(i)
            }
        }
        subScro1.fillWithArray(indoorImageArr)
        
        for var i = 0; i < houseStyleImageArr.count; i++
        {
            var dict: NSDictionary = houseStyleImageArr.pObjectAtIndex(i) as NSDictionary
            if(imageStr == dict.stringObjectForKey("picKey"))
            {
                deleteImgId = dict.stringObjectForKey("id")
                houseStyleImageArr.removeObjectAtIndex(i)
            }
        }
        subScro2.fillWithArray(houseStyleImageArr)
        
        if(_isCreat == CreatOrEdit.EditPicture)
        {
            self.isDelete = true
            self.editScdHouPicQuery()
        }
    }
    
//    func deleteImgQuery(picId: String)
//    {
//        /*url：/MyHousesInfo/deleteHousePic.do
//        入参：houseId=6
//        picId=1
//        出参：
//        {"detail":"请求数据成功!","status":"1","data":"删除图片成功"} */
//        Utility.hideMBProgress(self)
//        Utility.showMBProgress(self, _message: "删除中")
//        
//        let manager = HWHttpRequestOperationManager.baseManager()
//        var param = NSMutableDictionary()
//        
//        param.setPObject(HWUserLogin.currentUserLogin().key, forKey: "key")
//        param.setPObject(picId, forKey: "picId")
//        param.setPObject(_houseId, forKey: "houseId")
//        
//        manager.postHttpRequest(kScdHouDetailDeleteImg, parameters: param, queue: nil, success: { (responseObject) -> Void in
//            
//            Utility.hideMBProgress(self)
//            Utility.showToastWithMessage("删除成功", _view: self)
//            
//            
//            }) { (code, error) -> Void in
//                
//                Utility.hideMBProgress(self)
//                
//                Utility.showToastWithMessage(error, _view: self)
//        }
//        
//    }
    
    //MARK: actionSheetDelegate
    func actionSheet(actionSheet: UIActionSheet, clickedButtonAtIndex buttonIndex: Int)
    {
        if(buttonIndex == 1)
        {
            self.showImagePickerWithCamera()
        }
        else if(buttonIndex == 2)
        {
            self.showImagePickerWithPicture()
        }
    }
    
    //MARK: 相机拍照
    func showImagePickerWithCamera()
    {
        var imgPickVC: UIImagePickerController = UIImagePickerController()
        imgPickVC.delegate = self
        imgPickVC.allowsEditing = true
        if(UIImagePickerController.isSourceTypeAvailable(UIImagePickerControllerSourceType.Camera))
        {
            imgPickVC.sourceType = UIImagePickerControllerSourceType.Camera
        }
        else
        {
            Utility.showToastWithMessage("设备不支持拍照", _view: self)
            return
        }
        
        if(iOS7)
        {
            var status: AVAuthorizationStatus = AVCaptureDevice.authorizationStatusForMediaType(AVMediaTypeVideo)
            if(status == AVAuthorizationStatus.Authorized)
            {
                delegate.delegatePresentVC(imgPickVC)
            }
            else if(status == AVAuthorizationStatus.Denied || status == AVAuthorizationStatus.Restricted)
            {
                Utility.showToastWithMessage("请在设置-隐私中开启相机权限", _view: self)
                return
            }
            else if(status == AVAuthorizationStatus.NotDetermined)
            {
                AVCaptureDevice.requestAccessForMediaType(AVMediaTypeVideo, completionHandler: { (granted) -> Void in
                    if(granted)
                    {
                        self.delegate.delegatePresentVC(imgPickVC)
                    }
                    else
                    {
                        Utility.showToastWithMessage("请在设置-隐私中开启相机权限", _view: self)
                        return
                    }
                })
            }
        }
    }
    
    //MARK: 选择照片
    func showImagePickerWithPicture()
    {
        var imgPickVC: UIImagePickerController = UIImagePickerController()
        imgPickVC.delegate = self
        imgPickVC.allowsEditing = true
        imgPickVC.sourceType = UIImagePickerControllerSourceType.PhotoLibrary
        
        delegate.delegatePresentVC(imgPickVC)
    }
    
    //MARK: UIImagePickerControllerDelegate
    func imagePickerController(picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [NSObject : AnyObject])
    {
        /*sys/upload.do
        入参:
        file 文件
        出参
        {
        "detail": "请求数据成功!",
        "status": "",
        "data":
        { "fileKey":"" -保存的文件键值 }
        
        }*/
        picker.dismissViewControllerAnimated(true, completion: nil)
        
        var dict: NSDictionary = info as NSDictionary
        var img: UIImage = dict.objectForKey(UIImagePickerControllerEditedImage) as UIImage
        
        Utility.hideMBProgress(self)
        Utility .showMBProgress(self, _message: "上传中")
        
        let manager = HWHttpRequestOperationManager.baseManager()
        var param = NSMutableDictionary()
        
        param.setPObject(UIImageJPEGRepresentation(img, 1), forKey: "file")
        param.setPObject(HWUserLogin.currentUserLogin().key, forKey: "key")
        
        manager.postImageHttpRequest(kUploadImageUrl, parameters: param, queue: nil, success: { (responseObject) -> Void in
            
            Utility.hideMBProgress(self)
            
            let responseDic: NSDictionary? = responseObject as? NSDictionary
            let picKey: NSString! = responseDic?.dictionaryObjectForKey("data").stringObjectForKey("fileKey")
            //MYP add v3.2.2 上传图片成功后使用picUrl去加载图片
            let picUrl:NSString! = responseDic?.dictionaryObjectForKey("data").stringObjectForKey("picUrl")
            let fileKey:NSString! = responseDic?.dictionaryObjectForKey("data").stringObjectForKey("fileKey")
            var tmpDict = NSMutableDictionary()
            if(self.currentScro == self.subScro1)
            {
                tmpDict.setObject("no", forKey: "isMain")
                //MYP add v3.2.2
                //tmpDict.setObject(picKey, forKey: "picKey")
                tmpDict.setObject(picUrl, forKey: "picKey")
                tmpDict.setObject(fileKey, forKey: "fileKey")
                self.indoorImageArr.addObject(tmpDict)
                self.subScro1.fillWithArray(self.indoorImageArr)
            }
            else
            {
                tmpDict.setObject("no", forKey: "isMain")
                //MYP add v3.2.2
                //tmpDict.setObject(picKey, forKey: "picKey")
                tmpDict.setObject(picUrl, forKey: "picKey")
                tmpDict.setObject(fileKey, forKey: "fileKey")
                self.houseStyleImageArr.addObject(tmpDict)
                self.subScro2.fillWithArray(self.houseStyleImageArr)
            }
            self.isHaveChanged = true
            
            }) { (code, error) -> Void in
                
                Utility .hideMBProgress(self)
                Utility .showToastWithMessage(error, _view: self)
        }
        
    }
    
    func imagePickerControllerDidCancel(picker: UIImagePickerController)
    {
        picker.dismissViewControllerAnimated(true, completion: nil)
        
    }
    //MARK:tab的代理
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int
    {
        return titleArr.count
    }
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell
    {
        let cellId = "cellid"
        var cell: HWSecEditPhotoTableViewCell? = tableView.dequeueReusableCellWithIdentifier(cellId) as? HWSecEditPhotoTableViewCell
        if(cell == nil)
        {
            cell = HWSecEditPhotoTableViewCell(style: UITableViewCellStyle.Default, reuseIdentifier: cellId)
        }
        cell?.titleLab.text = titleArr[indexPath.row] as? String
        cell?.detailLab.text = detailArr[indexPath.row] as? String
        cell?.contentView.drawBottomLine()
        let btn = UIButton()
        btn.frame = CGRectMake(kScreenWidth-30-19,(60-19)/2, 19, 19)
        btn.tag = indexPath.row+100
        btn .addTarget(self, action: "doSelect:", forControlEvents: UIControlEvents.TouchUpInside)
             if indexPath.row == 0
        {
            btn1 = btn
            
            if _model.permission == "A"
            {
                btn .setImage(UIImage(named: "choose_2_2"), forState: UIControlState.Normal)
                _permission = "A"
            }
                
            else
            {
                btn .setImage(UIImage(named: "choose_2_1"), forState: UIControlState.Normal)
            }
            
        }
         else  if indexPath.row == 1
        {
            btn3 = btn
            if  _model.permission == "C"
                {
                    btn .setImage(UIImage(named: "choose_2_2"), forState: UIControlState.Normal)
                }
                    
                else
                {
                    btn .setImage(UIImage(named: "choose_2_1"), forState: UIControlState.Normal)
                }

            }
        
        cell?.addSubview(btn)

        return cell!

    }
    
    func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat
    {
        return HWSecEditPhotoTableViewCell .getCellHeight()
    }
     func tableView(tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat
    {
        return 30
    }
     func tableView(tableView: UITableView, viewForHeaderInSection section: Int) -> UIView?
    {
        var view = UIView(frame: CGRectMake(0, 0, kScreenWidth, 30))
        view.backgroundColor = UIColor .clearColor()
        var lab = UILabel(frame: CGRectMake(15, 0, kScreenWidth, 30))
        lab.textColor = CD_Txt_Color_99
        lab.font = Define.font(TF_14)
        lab.text  = "添加房源到"
        view .drawBottomLine()
        view.addSubview(lab)
        return view
        
    }
    
      func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath)
     {
        tableView .deselectRowAtIndexPath(indexPath, animated: true)
        if indexPath.row == 0
        {
             _permission = "A"
              btn1 .setImage(UIImage(named: "choose_2_2"), forState: UIControlState.Normal)
              btn3 .setImage(UIImage(named: "choose_2_1"), forState: UIControlState.Normal)
        }
        else  if indexPath.row == 1
        {
            //isDianji = "1"
            _permission = "C"
          
            btn1 .setImage(UIImage(named: "choose_2_1"), forState: UIControlState.Normal)
          
            btn3 .setImage(UIImage(named: "choose_2_2"), forState: UIControlState.Normal)

        }
      
       // baseTable .reloadData()
     }
    
    func doSelect(sender:UIButton!)
    {
        if sender.tag % 100 == 0
        {
            _permission = "A"
            btn1 .setImage(UIImage(named: "choose_2_2"), forState: UIControlState.Normal)

            btn3 .setImage(UIImage(named: "choose_2_1"), forState: UIControlState.Normal)

        }
      else  if sender.tag % 100 == 1
        {
             _permission = "C"
            btn1 .setImage(UIImage(named: "choose_2_1"), forState: UIControlState.Normal)
            btn3 .setImage(UIImage(named: "choose_2_2"), forState: UIControlState.Normal)

        }
  
        
       // baseTable .reloadData()

        
    }
       required init(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
