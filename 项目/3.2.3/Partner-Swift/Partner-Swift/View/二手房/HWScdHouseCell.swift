//
//  HWScdHouseCell.swift
//  Partner-Swift
//
//  Created by niedi on 15/2/26.
//  Copyright (c) 2015年 caijingpeng.haowu. All rights reserved.
//
//  功能描述：二手房首页列表Cell 我的房店收藏列表Cell HWRelateHouseRefreshView Cell
//
//  修改记录：
//      姓名         日期               修改内容
//      聂迪      2015-02-26           UI、简单功能实现
//      陆晓波    2015-03-04           添加cell显示-我的房店-我的收藏列表
//

import UIKit

class HWScdHouseCell: HWBaseTableViewCell {

    //MARK: 成员变量
    var headImg: UIImageView!
    var appointImg: UIImageView! //预约人数图标
    var appointNumLab: UILabel! //预约人数lab
    var statusImg: UIImageView! //已预约图标
    var titleLab: UILabel!  //标题
    var addressLab: UILabel!//地址 第二行
    var detailLab: UILabel!//详情 末行
    
    //MARK: 初始化方法
    override init(style: UITableViewCellStyle, reuseIdentifier: String?)
    {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        headImg = UIImageView()
        headImg.frame = CGRectMake(15 * kRate, 10 * kRate, 95 * kRate, 75 * kRate)
        headImg.image = Utility.getPlaceHolderImage(headImg.frame.size, imageName:placeHolderBigImage)
        headImg.layer.cornerRadius = 3
        headImg.layer.masksToBounds = true
        headImg.backgroundColor = CD_Txt_Color_99
        self.contentView.addSubview(headImg)
        
        titleLab = UILabel(frame: CGRectMake(headImg.frame.maxX + 6 * kRate, CGRectGetMinY(headImg.frame) + 5 * kRate, kScreenWidth - (headImg.frame.maxX + 7 * kRate) - 15, 18 * kRate))
        titleLab.font = Define.font(TF_15)
        titleLab.textColor = CD_Txt_Color_00
        self.contentView.addSubview(titleLab)
        
        addressLab = UILabel(frame: CGRectMake(titleLab.frame.minX, CGRectGetMaxY(titleLab.frame) + 8 * kRate, titleLab.frame.width, 15 * kRate))
        addressLab.font = Define.font(TF_13)
        addressLab.textColor = CD_Txt_Color_99
        self.contentView.addSubview(addressLab)
        
        detailLab = UILabel(frame: CGRectMake(titleLab.frame.minX, addressLab.frame.maxY + 8 * kRate, titleLab.frame.width, 15 * kRate))
        detailLab.font = Define.font(TF_13)
        detailLab.textColor = CD_Txt_MainColor
        self.contentView.addSubview(detailLab)
        
        appointImg = UIImageView()
        appointImg.frame = CGRectMake(kScreenWidth - 10 - 15, detailLab.frame.minY + 2, 10, 12)
        appointImg.image = UIImage(named: "small_list")
        self.contentView.addSubview(appointImg)
        
        appointNumLab = UILabel(frame: CGRectMake(titleLab.frame.minX, detailLab.frame.minY , titleLab.frame.width, 15 * kRate))
        appointNumLab.textColor = CD_Txt_Color_99
        appointNumLab.font = Define.font(TF_12)
        appointNumLab.textAlignment = NSTextAlignment.Right
        self.contentView.addSubview(appointNumLab)
        
        statusImg = UIImageView()
        statusImg.frame = CGRectMake(kScreenWidth - 48 * kRate, 0, 48 * kRate, 48 * kRate)
        statusImg.image = UIImage(named: "status3")
        statusImg.hidden = true
        self.contentView.addSubview(statusImg)
    }
    
    //MARK: cell显示
    func setSecondHouseInfo(model: HWScdHouseModel)
    {
        
        weak var weakImgV: UIImageView! = headImg
        //MYP add v3.2.2修改图片加载方式
        //let url = NSURL(string:Utility.imageDownloadWithMongoDbKey(model.picKey))
        let url = NSURL(string:model.picKey)
        headImg.setImageWithURL(url, placeholderImage:  Utility.getPlaceHolderImage(weakImgV.frame.size, imageName: placeHolderSmallImage)) { (image, error, imageCacheType) -> Void in
            if (error != nil)
            {
                let size: CGSize! = weakImgV.frame.size
                weakImgV?.image = Utility.getPlaceHolderImage(size, imageName: failedSmallImage)
            }
            else
            {
                weakImgV?.image = image
            }
        }
        
        if(model.appointNum == "")
        {
            model.appointNum = "0"
            appointNumLab.text = "0"
        }
        else
        {
            appointNumLab.text = model.appointNum
        }
        
        var frame: CGRect = appointImg.frame
        frame.origin.x = kScreenWidth - 10 - 15 - 11 * CGFloat((model.appointNum as NSString).length)
        appointImg.frame = frame
        
        if model.title == ""
        {
            titleLab.text = model.villageName
        }
        else
        {
             titleLab.text = model.title
        }
       
        
        //数据适应缺失
        if(model.areaName != "" || model.plateName != "")
        {
            if(model.plateName == "")
            {
                addressLab.text = model.villageName + "[" + model.areaName + "]"
            }
            else if(model.areaName == "")
            {
                addressLab.text = model.villageName + "[" + model.plateName + "]"
            }
            else
            {
                addressLab.text = model.villageName + "[" + model.areaName + " " + model.plateName + "]"
            }
        }
        else
        {
            addressLab.text = model.villageName
        }
        
        
//        println("\(model.price)")
        var priceFloat = (model.price as NSString).doubleValue
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
        
        if(model.roomCount == "0" && model.hallCount == "0")
        {
            detailLab.text = "\(model.proportion!)㎡   \(priceStr)"
        }
        else
        {
            detailLab.text = "\(model.roomCount)室\(model.hallCount)厅   \(model.proportion!)㎡   \(priceStr)"
        }
        
        
        if(model.isAppoint == "yes")
        {
            statusImg.hidden = false
        }
        else
        {
            statusImg.hidden = true
        }
    }
    
    //MARK:cell显示-我的房店-我的收藏列表
    func setMyCollectionInfo(model:HWMyCollectionModel)
    {
        weak var weakImgV: UIImageView! = headImg
         let url = NSURL(string:Utility.imageDownloadWithMongoDbKey(model.picKey!))
        headImg.setImageWithURL(url, placeholderImage:  Utility.getPlaceHolderImage(weakImgV.frame.size, imageName: "pic_wait_small")) { (image, error, imageCacheType) -> Void in
            if (error != nil)
            {
                let size: CGSize! = weakImgV.frame.size
                weakImgV?.image = Utility.getPlaceHolderImage(size, imageName: "pic_wait_small_no-")
            }
            else
            {
                weakImgV?.image = image
            }
        }
        
        titleLab.text = model.title
        
        var areaName:NSString = ""
        if (model.areaName!.length > 0 && model.plateName!.length > 0)
        {
            areaName = "[\(model.areaName!) \(model.plateName!)]"
        }
        else if (model.areaName!.length == 0 && model.plateName!.length > 0)
        {
            areaName = "[\(model.plateName!)]"
        }
        else if (model.areaName!.length > 0 && model.plateName!.length == 0)
        {
            areaName = "[\(model.areaName!)]"
        }
        else if (model.areaName!.length == 0 && model.plateName!.length == 0)
        {
            areaName = ""
        }
        
        addressLab.text = model.villageName! + areaName
        
        var priceFloat = (model.price! as NSString).doubleValue
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
        
        detailLab.text = "\(priceStr)   \(model.roomCount!)室\(model.hallCount!)厅   \(model.proportion!)㎡"

        appointImg.setTranslatesAutoresizingMaskIntoConstraints(true)
        appointImg.image = UIImage(named: "small_star")
        appointImg.autoPinEdge(ALEdge.Bottom, toEdge: ALEdge.Bottom, ofView: self.contentView, withOffset: CGRectGetMaxY(detailLab.frame) - 95)
        appointImg.autoPinEdge(ALEdge.Right, toEdge: ALEdge.Right, ofView: self.contentView, withOffset: -36)
        
        appointNumLab.setTranslatesAutoresizingMaskIntoConstraints(true)
        appointNumLab.autoPinEdge(ALEdge.Left, toEdge: ALEdge.Right, ofView: appointImg, withOffset: 5)
        appointNumLab.autoPinEdge(ALEdge.Bottom, toEdge: ALEdge.Bottom, ofView: appointImg)
        appointNumLab.autoSetDimension(ALDimension.Height, toSize: TF_12)
        appointNumLab.text = model.collectNum
    }
    
    
    //MARK:cell显示-我的房店-我的收藏列表
    func setRelativeHouseCollectionInfo(model:HWScdHouseModel)
    {
        headImg.backgroundColor = CD_Txt_Color_99
        
        titleLab.text = model.title
        addressLab.text = model.villageName! + "[" + model.areaName! + " " + model.plateName! + "]"
        detailLab.text = "\(model.roomCount!)室\(model.hallCount!)厅      \(model.proportion!)㎡    \(model.price!)万"
        
        appointImg.setTranslatesAutoresizingMaskIntoConstraints(true)
        appointImg.image = UIImage(named: "small_star")
        appointImg.autoPinEdge(ALEdge.Bottom, toEdge: ALEdge.Bottom, ofView: self.contentView, withOffset: -17)
        appointImg.autoPinEdge(ALEdge.Right, toEdge: ALEdge.Right, ofView: self.contentView, withOffset: -36)
        
        appointNumLab.setTranslatesAutoresizingMaskIntoConstraints(true)
        appointNumLab.autoPinEdge(ALEdge.Left, toEdge: ALEdge.Right, ofView: appointImg, withOffset: 5)
        appointNumLab.autoPinEdge(ALEdge.Bottom, toEdge: ALEdge.Bottom, ofView: appointImg)
        appointNumLab.autoSetDimension(ALDimension.Height, toSize: TF_12)
    }
    
    //MARK: HWRelateHouseRefreshView Cell
    func setRelateHouse(model: HWRelateHouseModel)
    {
        headImg.backgroundColor = CD_Txt_Color_99
        if(model.appointNum? == "")
        {
            model.appointNum = "0"
            appointNumLab.text = "0"
        }
        else
        {
            appointNumLab.text = model.appointNum
        }
        
        var frame: CGRect = appointImg.frame
        frame.origin.x = kScreenWidth - 10 - 15 - 11 * CGFloat((model.appointNum as NSString).length)
        appointImg.frame = frame
        
        titleLab.text = model.title
        
        //数据适应缺失
        if(model.areaName != "" || model.plateName != "")
        {
            if(model.plateName == "")
            {
                addressLab.text = model.villageName + "[" + model.areaName + "]"
            }
            else if(model.areaName == "")
            {
                addressLab.text = model.villageName + "[" + model.plateName + "]"
            }
            else
            {
                addressLab.text = model.villageName + "[" + model.areaName + " " + model.plateName + "]"
            }
        }
        else
        {
            addressLab.text = model.villageName
        }
        
        var priceFloat = (model.price! as NSString).doubleValue
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
        detailLab.text = "\(model.roomCount)室\(model.hallCount)厅   \(model.proportion!)㎡   \(priceStr)"
        if(model.isAppoint == "1")
        {
            statusImg.hidden = false
        }
        else
        {
            statusImg.hidden = true
        }
    }

    //MARK: 返回cell高度
    class func getCellHeight(model: HWScdHouseModel?) -> CGFloat
    {
        return 95.0
    }
    
    //MARK: getIdentify
    class func getIdentify() -> NSString {
        return "secondHouse"
    }

    required init(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

}
