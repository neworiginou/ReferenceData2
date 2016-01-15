//
//  HWScheduleDetailView.swift
//  Partner-Swift
//
//  Created by caijingpeng.haowu on 15/2/23.
//  Copyright (c) 2015年 caijingpeng.haowu. All rights reserved.
//

import UIKit

protocol HWScheduleDetailViewDelegate: NSObjectProtocol
{
    func didSelectContinueFollow()
    func didSelectClientInfo(schedule: HWScheduleModel?)
}

class HWScheduleDetailView: HWBaseRefreshView, HWScheduleDetailCellDelegate, UIScrollViewDelegate {
    
    var headerView: UIView!
    var imgScrollView: UIScrollView!
    var messageView: UIControl!
    var pageCtrl: UIPageControl!
    
    var scheduleModel: HWScheduleModel?
    var delegate: HWScheduleDetailViewDelegate?

    override init(frame: CGRect)
    {
        super.init(frame: frame)
        
        self.baseTable.registerClass(HWDefaultCell.self, forCellReuseIdentifier: HWDefaultCell.getIdentify())
        self.baseTable.registerClass(HWScheduleDetailCell.self, forCellReuseIdentifier: HWScheduleDetailCell.getIdentify())
        self.baseTable.hidden = true
        self.setIsNeedHeadRefresh(false)
//        self.initialHeaderView()
//        self.initialFooterView()
    }
    
    override func queryListData()
    {
        Utility.showMBProgress(self, _message: "加载中")
        
        let manager = HWHttpRequestOperationManager.baseManager()
        var param: NSMutableDictionary! = NSMutableDictionary()
        param.setPObject(HWUserLogin.currentUserLogin().key, forKey: "key")
        param.setPObject(scheduleModel?.partnerScheduleId, forKey: "partnerScheduleId")
        
        manager.postHttpRequest(kScheduleDetail, parameters: param, queue: nil, success: { (responseObject) -> Void in
            
            Utility.hideMBProgress(self)
            self.scheduleModel = HWScheduleModel(scheduleInfo: (responseObject.dictionaryObjectForKey("data") as NSDictionary))
        
            self.initialHeaderView()
            self.initialFooterView()
            
            self.baseTable.hidden = false
            self.baseTable.reloadData()
            
            
        }) { (code, error) -> Void in
            
            Utility.hideMBProgress(self)
            Utility.showToastWithMessage(error, _view: self)
            
        }
        
    }
    
    required init(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func initialFooterView() -> Void
    {
        let footerView = UIView(frame: CGRectMake(0, 0, kScreenWidth, 40))
        self.baseTable.tableFooterView = footerView
    }
    
    func initialHeaderView() -> Void
    {
        headerView = UIView(frame: CGRectMake(0, 0, kScreenWidth, 0))
        self.initialDateView()
        self.initialImageView()
        self.initialMessageView()
        headerView.frame = CGRectMake(0, 0, kScreenWidth, CGRectGetMaxY(messageView.frame))
        self.baseTable.tableHeaderView = headerView
    }
    
    func initialDateView() -> Void
    {
        var str: String? = self.scheduleModel?.finishTime
        if str == nil
        {
            return
        }
        let scheduleDate: NSDate? = Utility.convertDateFromString(Utility.getTimeWithTimestamp(str!, dateFormatStr: "yyyy-MM-dd HH:mm:ss"), formate: "yyyy-MM-dd HH:mm:ss")
        
        let dateLabel: UILabel = UILabel(frame: CGRectMake(0, 0, kScreenWidth, 60))
        dateLabel.numberOfLines = 2
        dateLabel.font = Define.font(TF_Small_12)
        
        let string: String? = Utility.convertStringFromDate(scheduleDate, formate: "yyyy-MM-dd HH:mm \nEE")
        
        if string != nil
        {
            dateLabel.text = "\(string!) \(Utility.getChineseCalendar(scheduleDate))"
        }
        
        
        dateLabel.setLineSpacing(3)
        dateLabel.textAlignment = NSTextAlignment.Center
        headerView.addSubview(dateLabel)
        
        dateLabel.drawBottomLine()
    }
    
    func initialImageView() -> Void
    {
        imgScrollView = UIScrollView(frame: CGRectMake(0, 60, kScreenWidth, 240 * kScreenRate))
        imgScrollView.backgroundColor = UIColor.whiteColor()
        imgScrollView.layer.masksToBounds = true
        imgScrollView.pagingEnabled = true
        headerView.addSubview(imgScrollView)
        
        let keyStr: NSString? = self.scheduleModel?.picKey
        if (keyStr != nil && keyStr?.length > 0)
        {
            let imgArr: NSArray = NSMutableArray(array: keyStr!.componentsSeparatedByString(","))
            
            for (var i = 0; i < imgArr.count; i++)
            {
                let imageView = UIImageView(frame: CGRectMake(CGFloat(i) * CGRectGetWidth(imgScrollView.frame), 0, CGRectGetWidth(imgScrollView.frame), CGRectGetHeight(imgScrollView.frame)))
                imageView.contentMode = UIViewContentMode.ScaleAspectFit
                imageView.backgroundColor = UIColor.blackColor()
                //MYP add 修改图片加载方式 直接加载url
                //let picUrl: NSString? = Utility.imageDownloadWithMongoDbKey(imgArr.pObjectAtIndex(i) as NSString)
                let picUrl: NSString? = imgArr.pObjectAtIndex(i) as? NSString
                weak var weakImgV: UIImageView? = imageView
                imageView.setImageWithURL(NSURL(string: picUrl!) , placeholderImage: Utility.getPlaceHolderImage(imageView.frame.size, imageName: "pic_wait_big"), completed: { (image, error, cacheType) -> Void in
                    if (error != nil)
                    {
                        let size: CGSize! = weakImgV?.frame.size
                        weakImgV?.image = Utility.getPlaceHolderImage(size, imageName: "pic_wait_big_no")
                    }
                    else
                    {
                        weakImgV?.image = image
                    }
                })
                imgScrollView.addSubview(imageView)
            }
            imgScrollView.delegate = self
            imgScrollView.contentSize = CGSizeMake(kScreenWidth * CGFloat(imgArr.count), imgScrollView.frame.size.height)
            Utility.drawLine(CGPointMake(0, CGRectGetMaxY(imgScrollView.frame)), width: CGRectGetWidth(imgScrollView.frame))
            
            pageCtrl = UIPageControl(frame: CGRectMake(kScreenWidth - 17 * CGFloat(imgArr.count) - 10, CGRectGetMaxY(imgScrollView.frame) - 30, 17 * CGFloat(imgArr.count), 30))
            pageCtrl.backgroundColor = UIColor.clearColor()
            pageCtrl.numberOfPages = imgArr.count
            headerView.addSubview(pageCtrl)
        }
        
        if keyStr?.length > 0
        {
            imgScrollView.frame = CGRectMake(0, 60, kScreenWidth, 240 * kScreenRate)
        }
        else
        {
            imgScrollView.frame = CGRectMake(0, 60, kScreenWidth, 0)
        }
        
    }
    
    func initialMessageView() -> Void
    {
        messageView = UIControl(frame: CGRectMake(0, CGRectGetMaxY(imgScrollView.frame), kScreenWidth, 0))
        messageView.backgroundColor = UIColor.whiteColor()
        headerView.addSubview(messageView)
        messageView.addTarget(self, action: "clientDetail", forControlEvents: UIControlEvents.TouchUpInside)
        
        var clientStr: NSString = ""
        if (self.scheduleModel?.clientName.length > 0)
        {
            clientStr = "[\(self.scheduleModel?.clientName as String) \(self.scheduleModel?.clientPhone as String)]"
        }
        var houseName: NSString = ""
        if (self.scheduleModel?.houseName.length > 0)
        {
            houseName = " [\(self.scheduleModel?.houseName as String)]"
        }
        var content: NSString = ""
        if (self.scheduleModel?.content.length > 0 && (houseName.length > 0 || clientStr.length > 0))
        {
            content = "\n\(self.scheduleModel?.content as String)"
        }
        else
        {
            content = "\(self.scheduleModel?.content as String)"
        }
        
        let messageStr: NSString? = "\(clientStr)\(houseName)\(content)"
        let msgFont: UIFont = Define.font(TF_Text_15)
        
        let size = Utility.calculateStringSize(messageStr!, textFont: msgFont, constrainedSize: CGSizeMake(kScreenWidth - 30, 10000))
        
        let messageLabel: UILabel = UILabel(frame: CGRectMake(15, 10, kScreenWidth - 30, size.height))
        messageLabel.numberOfLines = 0
        messageLabel.textColor = CD_Txt_Color_00
        messageLabel.font = msgFont
        messageLabel.text = messageStr
        messageLabel.backgroundColor = UIColor.clearColor()
        messageView.addSubview(messageLabel)
        
        
        
        if (self.scheduleModel?.address.length > 0)
        {
            messageView.addSubview(Utility.drawLine(CGPointMake(0, CGRectGetMaxY(messageLabel.frame) + 10), width: kScreenWidth))
            
            let addressView: UIView = UIView(frame: CGRectMake(15, CGRectGetMaxY(messageLabel.frame) + 10, kScreenWidth - 2 * 15, 44))
            addressView.backgroundColor = UIColor.clearColor()
            messageView.addSubview(addressView)
            
            let addressImgV: UIImageView = UIImageView(frame: CGRectMake(0, (44 - 15) / 2.0, 10, 15)) as UIImageView
            addressImgV.image = UIImage(named: "map_2")
            addressView.addSubview(addressImgV)
            
            let addressLabel: UILabel = UILabel(frame: CGRectMake(15, 0, CGRectGetWidth(addressView.frame) - 20, CGRectGetHeight(addressView.frame)))
            addressLabel.font = Define.font(TF_Small_12)
            addressLabel.textColor = CD_Txt_Color_66
            addressLabel.backgroundColor = UIColor.clearColor()
            addressLabel.text = self.scheduleModel?.address
            addressView.addSubview(addressLabel)
            messageView.frame = CGRectMake(0, CGRectGetMaxY(imgScrollView.frame), kScreenWidth, CGRectGetMaxY(addressView.frame))
        }
        else
        {
            messageView.frame = CGRectMake(0, CGRectGetMaxY(imgScrollView.frame), kScreenWidth, CGRectGetMaxY(messageLabel.frame) + 10)
        }
        
        messageView.drawBottomLine()
        
    }
    
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        
        if (self.scheduleModel?.sourceType.isEqualToString("appointment_client") == true)
        {
            if (section == 0 && self.scheduleModel?.clientInfoId?.length != 0)
            {
                if (self.scheduleModel?.houseBrokerPhone?.length != 0)
                {
                    return 2
                }
                return 1
            }
            else
            {
                return 1
            }
        }
        else if (self.scheduleModel?.sourceType.isEqualToString("appointment_house") == true)
        {
            return 1
        }
        else if (self.scheduleModel?.sourceType.isEqualToString("new") == true)
        {
            return 1
        }
        return 0
    }
    
    func tableView(tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 10
    }
    
    func tableView(tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let view: UIView = UIView(frame: CGRectMake(0, 0, kScreenWidth, 10))
        view.backgroundColor = CD_BackGroundColor
        view.drawBottomLine()
        return view
    }

    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        
        if (self.scheduleModel?.clientInfoId?.length == 0)
        {
            return 1
        }
        return 2
    }
    
    func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        return 44
    }
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        if (indexPath.section == 0 && self.scheduleModel?.clientInfoId?.length != 0)
        {
            let cell = tableView.dequeueReusableCellWithIdentifier(HWScheduleDetailCell.getIdentify(), forIndexPath: indexPath) as HWScheduleDetailCell
            
            
            if (self.scheduleModel?.sourceType.isEqualToString("appointment_client") == true)
            {
                if indexPath.row == 0
                {
                    cell.setScheduleClientInfo(self.scheduleModel)
                }
                else
                {
                    cell.setScheduleHouseInfo(self.scheduleModel)
                }
            }
            else if (self.scheduleModel?.sourceType.isEqualToString("appointment_house") == true)
            {
                cell.setScheduleClientInfo(self.scheduleModel)
            }
            else if (self.scheduleModel?.sourceType.isEqualToString("new") == true)
            {
                cell.setScheduleClientInfo(self.scheduleModel)
            }
            
            
            //cell.delegate = self
            cell.contentView.drawBottomLine()
            cell.selectionStyle = UITableViewCellSelectionStyle.None
            return cell
        }
        else
        {
            let cell = tableView.dequeueReusableCellWithIdentifier(HWDefaultCell.getIdentify(), forIndexPath: indexPath) as HWDefaultCell
            cell.myTextLabel.text = "继续跟进"
            cell.contentView.drawBottomLine()
            
            return cell
        }
        
    }
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        
        tableView.deselectRowAtIndexPath(indexPath, animated: true)
        
        if (indexPath.section == 1 || (self.scheduleModel?.clientInfoId?.length == 0 && indexPath.section == 0))
        {
            if (delegate != nil && delegate?.respondsToSelector("didSelectContinueFollow") == true)
            {
                delegate?.didSelectContinueFollow()
            }
        }
        
    }
    
    override func scrollViewDidScroll(scrollView: UIScrollView)
    {
        super.scrollViewDidScroll(scrollView)
        
        if (scrollView == imgScrollView)
        {
            if (pageCtrl != nil)
            {
                pageCtrl.currentPage = Int(scrollView.contentOffset.x / scrollView.frame.size.width)
            }
        }
        
    }
    
    func scheduleDetailCell(cell: HWScheduleDetailCell, didCallToPhone phoneNumber: String)
    {
        // 拨打电话
        Utility.callPhone(phoneNumber)
    }
    
    func clientDetail()
    {
        if (self.scheduleModel?.clientInfoId.length > 0 && self.scheduleModel?.sourceWay.length > 0)
        {
            MobClick.event("Follow-up_click")//埋点
            if (delegate != nil && delegate?.respondsToSelector("didSelectClientInfo:") == true)
            {
                delegate?.didSelectClientInfo(self.scheduleModel)
            }
        }

    }
    
}













