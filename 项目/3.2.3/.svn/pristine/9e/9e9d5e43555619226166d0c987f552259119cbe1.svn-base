//
//  HWPersonalCenterTableView.swift
//  HaoWuPartner
//
//  Created by WeiYuanlin on 15/2/15.
//  Copyright (c) 2015年 WeiYuanlin. All rights reserved.
//

import UIKit

// MARK : 表头、表尾、cell点击的代理
protocol HWPersonalCenterTableViewDelegate
{
    func headerDidSelected()
    func headerDidSigned()
    func cellDidSelected(index:NSIndexPath, customerType:String, DiscountCoupon:Bool)//回传当前本本优惠券做不做以及用户类型
    func footerBtnDidSelected(tag:NSInteger)
}

class HWPersonalCenterTableView: HWBaseRefreshView
{
    var currentVersionDiscountCoupon:Bool = true//当前3.0版本优惠券，默认不做
    var customerType:String!//用户类型(A中介，B直客下线，C直客) V
    var delegate:HWPersonalCenterTableViewDelegate?
    var dataDic:NSDictionary?
    var headImgV: UIImageView! = UIImageView()
    var brokerNameLab = UILabel()
    var headerView:UIView!
    
    override init(frame: CGRect)
    {
        super.init(frame: frame)
//        self.baseTable.separatorStyle = UITableViewCellSeparatorStyle.None
        self.baseTable.backgroundColor = UIColor.clearColor()
        self.setIsNeedHeadRefresh(false)
        self.currentPage = 1
        self.addSubview(self.baseTable)
        dataDic = NSDictionary()
        customerType = HWUserLogin.currentUserLogin().brokerType
        
        self.creatTableHeaderView()
        self.creatTableFooterView()
        self.queryListData()
        NSNotificationCenter.defaultCenter().addObserver(self, selector: "uploadHeadImage", name: kGetUserInfo, object: nil)
        NSNotificationCenter.defaultCenter().addObserver(self, selector: "changeName", name: kUpdateUserInfo, object: nil)
        NSNotificationCenter.defaultCenter().addObserver(self, selector: "changeIntegral", name: kGetIntegral, object: nil)
         NSNotificationCenter.defaultCenter().addObserver(self, selector: "changeIntegral", name: "kGetIntegral", object: nil)
    }
    
    deinit
    {
        NSNotificationCenter.defaultCenter().removeObserver(self, name: kGetUserInfo, object: nil)
        NSNotificationCenter.defaultCenter().removeObserver(self, name: kUpdateUserInfo, object: nil)
        NSNotificationCenter.defaultCenter().removeObserver(self, name: kGetIntegral, object: nil)
    }
    
    // MARK: 创建表头，表尾视图
    func creatTableHeaderView()
    {
        headerView = UIView(frame: CGRectMake(0, 0, kScreenWidth, 120 * kScreenWidth / 320 ))
        headerView.drawTopLine()
        headerView.drawBottomLine()
        self.baseTable.tableHeaderView = headerView
        
        var headerImgV = UIImageView(image: UIImage(named: "head_bg2")!)
        headerImgV.frame = headerView.frame
        headerImgV.contentMode = UIViewContentMode.ScaleAspectFit
        headerImgV.backgroundColor = UIColor.clearColor()
        headerImgV.userInteractionEnabled = true
        headerView.addSubview(headerImgV)
    
        
        var signButton = UIButton.buttonWithType(UIButtonType.Custom) as UIButton
        signButton.frame = CGRectMake(kScreenWidth - 28  - 65 , 20, 65 , 90 )
        signButton.backgroundColor = UIColor.clearColor()
        signButton.addTarget(self, action: "toSignIn", forControlEvents: UIControlEvents.TouchUpInside)
        headerView.addSubview(signButton)
        
        var signImgV = UIImageView(image: UIImage(named: "registration2"))
        signImgV.frame = CGRectMake(15 , 25, 35 , 35 )
        signImgV.backgroundColor = UIColor.clearColor()
        signImgV.contentMode = UIViewContentMode.ScaleAspectFit
        signButton.addSubview(signImgV)

        
        //积分
        var signLabel = UILabel()
        signLabel.text = "签到赚积分"
        signLabel.textColor = CD_Txt_Color_ff
        signLabel.font = Define.font(TF_12)
        signLabel.sizeToFit()
        signLabel.frame = CGRectMake(0, CGRectGetMaxY(signImgV.frame) + 5 , signLabel.frame.size.width, signLabel.frame.size.height)
        signLabel.textAlignment = NSTextAlignment.Center
        signButton.addSubview(signLabel)

        var tap = UITapGestureRecognizer(target: self, action: "enterPersonCenterInfo")
        headerView.addGestureRecognizer(tap)
        //headImgV = UIImageView(frame: CGRectMake(15, 35, 70, 70))
      //  headImgV.backgroundColor = UIColor.clearColor()
        headerView.addSubview(headImgV)
        headImgV.layer.borderColor = CD_WhiteColor.CGColor
        headImgV.layer.borderWidth = 2
        headImgV.layer.cornerRadius = 35
        headImgV.layer.masksToBounds = true
         
        headImgV.setTranslatesAutoresizingMaskIntoConstraints(true)
        headImgV.autoPinEdge(ALEdge.Left, toEdge: ALEdge.Left, ofView: headerView, withOffset: 15)
        headImgV.autoAlignAxis(ALAxis.Horizontal, toSameAxisOfView: headerView)
        headImgV.autoSetDimension(ALDimension.Height, toSize: 70)
        headImgV.autoSetDimension(ALDimension.Width, toSize: 70)
        
        let headImgViewSize = headImgV.systemLayoutSizeFittingSize(UILayoutFittingCompressedSize)
        
        // * kScreenRate
        weak var weakImgV: UIImageView? = headImgV
        //MYP add v3.2.2修改图片加载方式
        let url = NSURL(string:HWUserLogin.currentUserLogin().brokerPicKey)
        headImgV.setImageWithURL(url, placeholderImage: Utility.getPlaceHolderImage(headImgViewSize, imageName: "personal_2")) { (image, error, imageCacheType) -> Void in
            if (error != nil)
            {
                //let size: CGSize! = self.headImgV.frame.size
                weakImgV?.image = Utility.getPlaceHolderImage(headImgViewSize, imageName: "personal_2")
            }
            else
            {
                weakImgV?.image = image
            }
        }
        
        brokerNameLab.text = HWUserLogin.currentUserLogin().brokerName//用户姓名
        brokerNameLab.font = Define.font(22)
        brokerNameLab.textColor = UIColor.whiteColor()
        brokerNameLab.backgroundColor = UIColor.clearColor()
//        brokerNameLab.sizeToFit()
//        brokerNameLab.frame = CGRectMake(CGRectGetMaxX(headImgV.frame) + 15 * kScreenRate, 38 * kScreenRate, 150, brokerNameLab.frame.size.height)
        headerView.addSubview(brokerNameLab)
        
        var companyNameLab = UILabel()
        companyNameLab.text = HWUserLogin.currentUserLogin().orgName//机构名称
        companyNameLab.font = Define.font(TF_15)
        companyNameLab.textColor = UIColor.whiteColor()
        companyNameLab.backgroundColor = UIColor.clearColor()
//        companyNameLab.sizeToFit()
//        companyNameLab.frame = CGRectMake(CGRectGetMinX(brokerNameLab.frame), CGRectGetMaxY(brokerNameLab.frame) + 5, companyNameLab.frame.size.width, companyNameLab.frame.size.height)
        headerView.addSubview(companyNameLab)
        
        brokerNameLab.setTranslatesAutoresizingMaskIntoConstraints(true)
        companyNameLab.setTranslatesAutoresizingMaskIntoConstraints(true)
        let orgName:NSString = HWUserLogin.currentUserLogin().orgName
        let brokerNameLabHeight:CGFloat = 22
        let companyNameLabHeight:CGFloat = 15
        let HeightBetweenLabel:CGFloat = 10
        let width:CGFloat = kScreenWidth - 15 - 70 - 15 - 28 - signLabel.frame.size.width
        if (orgName.length == 0)
        {
            brokerNameLab.autoPinEdge(ALEdge.Left, toEdge: ALEdge.Right, ofView: headImgV, withOffset: 15)
            brokerNameLab.autoSetDimension(ALDimension.Height, toSize: brokerNameLabHeight)
            brokerNameLab.autoSetDimension(ALDimension.Width, toSize: width)
            brokerNameLab.autoAlignAxis(ALAxis.Horizontal, toSameAxisOfView: headerView)
        }
        else
        {
            brokerNameLab.autoPinEdge(ALEdge.Left, toEdge: ALEdge.Right, ofView: headImgV, withOffset: 15)
            brokerNameLab.autoSetDimension(ALDimension.Height, toSize: brokerNameLabHeight)
            brokerNameLab.autoSetDimension(ALDimension.Width, toSize: width)
            
            companyNameLab.autoPinEdge(ALEdge.Left, toEdge: ALEdge.Left, ofView: brokerNameLab)
            companyNameLab.autoPinEdge(ALEdge.Top, toEdge: ALEdge.Bottom, ofView: brokerNameLab, withOffset: HeightBetweenLabel)
            companyNameLab.autoSetDimension(ALDimension.Height, toSize: companyNameLabHeight)
            companyNameLab.autoSetDimension(ALDimension.Width, toSize: width)
            
            brokerNameLab.autoAlignAxis(ALAxis.Horizontal, toSameAxisOfView: headerView, withOffset: -(HeightBetweenLabel+TF_15)/2)
            companyNameLab.autoAlignAxis(ALAxis.Horizontal, toSameAxisOfView: headerView, withOffset: (HeightBetweenLabel+brokerNameLabHeight) / 2)
        }
        
    }
    //MARK: 签到
    func toSignIn()
    {
         self.delegate?.headerDidSigned()
    }
    

    func creatTableFooterView()
    {
        var footerView = UIView(frame: CGRectMake(0, 0, kScreenWidth, 100 * kScreenRate))
        footerView.backgroundColor = UIColor.clearColor()
        self.baseTable.tableFooterView = footerView
        
        var footBackView = UIView(frame: CGRectMake(0, 10 * kScreenRate, kScreenWidth, 90 * kScreenRate))
        footBackView.drawTopLine()
        footBackView.backgroundColor = UIColor.whiteColor()
        footerView.addSubview(footBackView)

        for var i = 0;i < 3; i++
        {
            var button = UIButton.buttonWithType(UIButtonType.Custom) as UIButton
            button.backgroundColor = UIColor.clearColor()
            button.frame = CGRectMake(kScreenWidth / 3 * CGFloat(i), 0, kScreenWidth / 3, footerView.frame.size.height)
            button.addTarget(self, action: "btnIsClick:", forControlEvents: UIControlEvents.TouchUpInside)
            button.tag = 1001 + i
            footBackView.addSubview(button)
            
            var footBtnImgV = UIImageView(frame: CGRectMake((button.frame.size.width - 40 * kScreenRate) / 2, 10 * kScreenRate, 40 * kScreenRate, 40 * kScreenRate))
            footBtnImgV.image = UIImage(named: "personal_center_0\(7 + i)")
            footBtnImgV.contentMode = UIViewContentMode.ScaleAspectFit
            footBtnImgV.backgroundColor = UIColor.clearColor()
            button.addSubview(footBtnImgV)
            
            var footBtnLabel = UILabel(frame: CGRectMake(0, CGRectGetMaxY(footBtnImgV.frame) + 10 * kScreenRate, kScreenWidth / 3, 20 * kScreenRate))
            if i == 0
            {
                footBtnLabel.text = "扫描经纪人"
            }
            else if i == 1
            {
                footBtnLabel.text = "房贷计算器"
            }
            else
            {
                footBtnLabel.text = "税费计算器"
            }
            footBtnLabel.textAlignment = NSTextAlignment.Center
            footBtnLabel.textColor = CD_Txt_Color_00
            footBtnLabel.font = Define.font(15)
            footBtnLabel.backgroundColor = UIColor.clearColor()
            button.addSubview(footBtnLabel)
            
            if i != 2
            {
                var middleLine = UIView(frame: CGRectMake(kScreenWidth / 3 - 0.5, 10 * kScreenRate, 0.5, footBackView.frame.size.height - 10 * kScreenRate * 2))
                middleLine.backgroundColor = CD_LineColor
                button.addSubview(middleLine)
            }
            footerView.drawBottomLine()
        }

    }
    
    //表头的触摸事件
    func enterPersonCenterInfo()
    {
        self.delegate?.headerDidSelected()
    }
    
    //表尾的每个按钮的点击事件
    func btnIsClick(button:UIButton)
    {
        self.delegate?.footerBtnDidSelected(button.tag)
    }
    
    // MARK: 数据请求
    override func queryListData()
    {
        
        Utility.showMBProgress(self, _message: "数据加载中")
        var param:NSDictionary = ["key":HWUserLogin.currentUserLogin().key]
        var manager = HWHttpRequestOperationManager.baseManager()
        
        manager.postHttpRequest(kPersonCenter, parameters: param, queue: nil, success: { (responseObject) -> Void in
            Utility.hideMBProgress(self)
//            var responseObject = ["data":["result":"522902229", "integrate":"200", "brokerAccount":"1000", "mySubNum":"7"]] as NSDictionary
//            println(responseObject)
            self.dataDic = responseObject["data"] as? NSDictionary
            self.baseTable.reloadData()
//            var result = self.dataDic?.stringObjectForKey("result") as String//业绩
//            var integrate = self.dataDic?.stringObjectForKey("integrate") as String//积分
//            var brokerAccount = self.dataDic?.stringObjectForKey("brokerAccount") as String//钱包
//            var mySubNum = self.dataDic?.stringObjectForKey("mySubNum") as String//我的下线

            //MYP add v3.2.2修改
            self.changeHeadImage()
            
        }) { (failure, error) -> Void in
            Utility.hideMBProgress(self)
            println(failure + error)
//            Utility.showToastWithMessage(error, _view: self)
        }
//
    }
    
    // MARK: UITableView Delegate
    func tableView(tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat
    {
        return 10 * kScreenRate

    }
    
//    func tableView(tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat
//    {
//        if section == 1
//        {
//            return 10 * kScreenRate
//        }
//        return 0
//    }
    
    func tableView(tableView: UITableView, viewForHeaderInSection section: Int) -> UIView?
    {
        var sectionHeaderView = UIView(frame: CGRectMake(0, 0, kScreenWidth, 10 * kScreenRate))
        sectionHeaderView.drawBottomLine()
        sectionHeaderView.backgroundColor = UIColor.clearColor()
        
        return sectionHeaderView
    }
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int
    {
        if section == 0
        {
            return 3
        }
        else if section == 1
        {
            //优惠券不做、客户经纪人是直客专员
            if currentVersionDiscountCoupon == false && customerType == "C"
            {
                return 2
            }
            else if currentVersionDiscountCoupon == false && customerType != "C"
            {
                return 1
            }
            else if currentVersionDiscountCoupon == true && customerType == "C"
            {
                return 3
            }
            else if currentVersionDiscountCoupon == true && customerType != "C"
            {
                return 2
            }
            return 0
        }
      else if section == 2
        {
            return 1
        }
        return 0
    }
    
    override func numberOfSectionsInTableView(tableView: UITableView) -> Int
    {
        return 3
    }
    
    func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat
    {
         return HWPersonalCenterTableViewCell.getCellHeight()
    }
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell
    {
        let cellIdentify = "cell"
        var cell : HWPersonalCenterTableViewCell? = tableView.dequeueReusableCellWithIdentifier(cellIdentify) as? HWPersonalCenterTableViewCell
        if cell == Optional.None
        {
            cell = HWPersonalCenterTableViewCell(style: UITableViewCellStyle.Default, reuseIdentifier: cellIdentify)
        }
        
        if indexPath.section == 0
        {
            if indexPath.row == 0
            {
                cell?.headImageV.image = UIImage(named: "personal_center_01")
                cell?.nameLabel.text = "业绩"
                var scoreStr = self.dataDic?.stringObjectForKey("result") as String
                if scoreStr == ""
                {
                    cell?.numberLable.text = "￥0.00"
                }
                else
                {
//                    cell?.numberLable.text = "￥\(scoreStr)"
                    cell?.numberLable.text = Utility.setYuanAttibuteString(scoreStr, font: TF_15)
                }
                
            }
            if indexPath.row == 1
            {
                cell?.headImageV.image = UIImage(named: "personal_center_02")
                cell?.nameLabel.text = "积分"
                var integrationStr = self.dataDic?.stringObjectForKey("integrate") as String
                if integrationStr == ""
                {
                    cell?.numberLable.text = "0"
                }
                else
                {
                    cell?.numberLable.text = "\(integrationStr)"
                }
                
            }
            if indexPath.row == 2
            {
                cell?.headImageV.image = UIImage(named: "personal_center_03")
                cell?.nameLabel.text = "钱包"
                var moneyStr = self.dataDic?.stringObjectForKey("brokerAccount") as String
                if moneyStr == ""
                {
                    cell?.numberLable.text = "￥0.00"
                }
                else
                {
//                    cell?.numberLable.text = "￥\(moneyStr)"
                    cell?.numberLable.text = Utility.setYuanAttibuteString(moneyStr, font: TF_15)
                }
                
            }
            
        }
        if indexPath.section == 1
        {
            //优惠券不做、客户经纪人是直客专员
            if currentVersionDiscountCoupon == false && customerType == "C"
            {
                if indexPath.row == 0
                {
                    cell?.headImageV.image = UIImage(named: "personal_center_05")
                    cell?.nameLabel.text = "我的下线"
                    var offLineStr = self.dataDic?.stringObjectForKey("mySubNum") as String
                    cell?.numberLable.text = "\(offLineStr)"
                }
                if indexPath.row == 1
                {
                    cell?.headImageV.image = UIImage(named: "personal_center_06")
                    cell?.nameLabel.text = "排行榜"
                    cell?.numberLable.text = ""
                }
            }
            else if currentVersionDiscountCoupon == false && customerType != "C"
            {
                cell?.headImageV.image = UIImage(named: "personal_center_06")
                cell?.nameLabel.text = "排行榜"
                cell?.numberLable.text = ""
            }
            else if currentVersionDiscountCoupon == true && customerType == "C"
            {
                if indexPath.row == 0
                {
                    var couponNum = self.dataDic?.stringObjectForKey("couponNum") as String
                    cell?.headImageV.image = UIImage(named: "personal_center_04")
                    cell?.nameLabel.text = "我的优惠券"
                    cell?.numberLable.text = "\(couponNum)"
                }
                if indexPath.row == 1
                {
                    cell?.headImageV.image = UIImage(named: "personal_center_05")
                    cell?.nameLabel.text = "我的下线"
                    var offLineStr = self.dataDic?.stringObjectForKey("mySubNum") as String
                    cell?.numberLable.text = "\(offLineStr)"
                }
                if indexPath.row == 2
                {
                    cell?.headImageV.image = UIImage(named: "personal_center_06")
                    cell?.nameLabel.text = "排行榜"
                    cell?.numberLable.text = ""
                }

            }
            else if currentVersionDiscountCoupon == true && customerType != "C"
            {
                if indexPath.row == 0
                {
                    var couponNum = self.dataDic?.stringObjectForKey("couponNum") as String
                    cell?.headImageV.image = UIImage(named: "personal_center_04")
                    cell?.nameLabel.text = "我的优惠券"
                    cell?.numberLable.text = "\(couponNum)"
                }
                if indexPath.row == 1
                {
                    cell?.headImageV.image = UIImage(named: "personal_center_06")
                    cell?.nameLabel.text = "排行榜"
                    cell?.numberLable.text = ""
                }
            }
        }
        if indexPath.section == 2
        {
            if indexPath.row == 0
            {
                 cell?.headImageV.image = UIImage(named: "personal_center_11")
                 cell?.nameLabel.text = "客服热线"
                 cell?.numberLable.text = "400-096-2882" 
                 cell?.numberLable.textColor = CD_MainColor
            }
        }
          cell?.setFrame()
//        cell?.accessoryView = UIImageView(image: UIImage(named: "arrow_next"))
//        cell?.selectionStyle = UITableViewCellSelectionStyle.None
          cell?.contentView.drawBottomLine()
        
        return cell!
    }
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath)
    {
        self.baseTable.deselectRowAtIndexPath(indexPath, animated: true)
        self.delegate?.cellDidSelected(indexPath, customerType: self.customerType, DiscountCoupon: currentVersionDiscountCoupon)
    }
    
    required init(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func uploadHeadImage()
    {
        weak var weakImgV: UIImageView? = headImgV
        
        let url = NSURL(string:Utility.imageDownloadWithMongoDbKey(HWUserLogin.currentUserLogin().brokerPicKey))
        headImgV.setImageWithURL(url, placeholderImage: Utility.getPlaceHolderImage(headImgV.frame.size, imageName: "personal_2")) { (image, error, imageCacheType) -> Void in
            if (error != nil)
            {
                let size: CGSize! = self.headImgV.frame.size
                weakImgV?.image = Utility.getPlaceHolderImage(size, imageName: "personal_2")
            }
            else
            {
                weakImgV?.image = image
            }
        }
    }
    func changeName()
    {
        brokerNameLab.text = HWUserLogin.currentUserLogin().brokerName
    
    }
    
    func changeIntegral()
    {
        self.queryListData()
    }
    

    //MYP add v3.2.2
    func changeHeadImage()
    {
        let headImgViewSize = headImgV.systemLayoutSizeFittingSize(UILayoutFittingCompressedSize)
        weak var weakImgV: UIImageView? = headImgV
        //MYP add v3.2.2修改图片加载方式
        let url = NSURL(string:HWUserLogin.currentUserLogin().brokerPicKey)
        headImgV.setImageWithURL(url, placeholderImage: Utility.getPlaceHolderImage(headImgViewSize, imageName: "personal_2")) { (image, error, imageCacheType) -> Void in
            if (error != nil)
            {
                //let size: CGSize! = self.headImgV.frame.size
                weakImgV?.image = Utility.getPlaceHolderImage(headImgViewSize, imageName: "personal_2")
            }
            else
            {
                weakImgV?.image = image
            }
        }

    }
   }
