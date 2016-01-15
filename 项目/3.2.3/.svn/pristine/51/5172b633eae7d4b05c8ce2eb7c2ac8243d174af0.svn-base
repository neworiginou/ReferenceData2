//
//  HWNewCell.swift
//  MySwift
//
//  Created by zhangxun on 15/2/6.
//  Copyright (c) 2015年 zhangxun. All rights reserved.
//

/**
activityId = 1159315579;
brokerNum = 13;
clientNum = 67;
commission = "\U6700\U9ad824000\U5143/\U5957";
houseAddress = "[\U6d66\U4e1c]";
houseAvgPrice = 10000;
houseName = "\U5389\U5929\U9f99\U6d4b\U8bd5\U697c\U76d8";
housePic = "http://172.16.10.13";
houseType = "<null>";
money = 100;
preferential = "<null>";
projectId = 12832;
rewardType = 1;
shareUrl = "http://172.16.10.105/hhr_system/pageView/appointmentHouse?projectId=12832&brokerId=1132005376";

*/

import UIKit

class HWNewHouseListModel : NSObject{
    var activityId:String?
    var houseId : String?
    var houseName : String?
    var houseAddress : String?
    //合作经济人数
    var brokerNum : String = "0"
    //意向客户数
    var clientNum : String = "0"
    //均价
    var houseAvgPrice : String = "0"
    //佣金
    var commission : String = "0"
    
    var shareUrl : String?
    
    var housePic : String?
    var typeWalt :  String?
    var moneyWalt: String!
    var waitTime =  NSString()
    var copunLableText = NSString()
    //MYP add v3.2.1是否已收藏
    var isCollection:String = ""
    
    override init()
    {
        super.init()
    }
    
    func fill(dict : NSDictionary)
    {
        self.activityId = dict.stringObjectForKey("activityId");
        self.houseId = dict.stringObjectForKey("projectId")
        self.houseName = dict.stringObjectForKey("houseName")
        self.houseAddress = dict.stringObjectForKey("houseAddress")
        self.brokerNum = dict.stringObjectForKey("brokerNum")
        self.clientNum = dict.stringObjectForKey("clientNum")
        self.houseAvgPrice = dict.stringObjectForKey("houseAvgPrice")
        self.commission = dict.stringObjectForKey("commission")
        self.shareUrl = dict.stringObjectForKey("shareUrl")
        self.housePic = dict.stringObjectForKey("housePic").stringByReplacingOccurrencesOfString(" ", withString: "")
        self.typeWalt = dict.stringObjectForKey("rewardType")
        self.moneyWalt = dict.stringObjectForKey("money")
        self.waitTime = dict .stringObjectForKey("waitTime")
        self.copunLableText = dict.stringObjectForKey("isCoupon")
        //MYP add v3.2.1
        self.isCollection = dict.stringObjectForKey("isCollection")
    }
}

protocol HWNewCellDelegate : NSObjectProtocol{
    func leftTap(index : NSIndexPath)
    func rightTap(index : NSIndexPath)
}

class HWNewCell: UITableViewCell {
    var delegate : HWNewCellDelegate?
    
    var currentIndex : NSIndexPath!
//    图片
    var headImageV : UIImageView = UIImageView()
//    倒计时
    var imageTime:UIImageView = UIImageView()
//   时间
    var timeLable:UILabel?
//    均价
    var averagelabel : UILabel?
    var titleLabel : UILabel!
//    合作+意向
    var cooperationLabel : UILabel?
//    佣金
    var commissionLabel : UILabel?
//    优惠券
    var commissionTittleLabel : UILabel!
    var sepLine : UIView!
    
    
    var leftBtn : UIButton?
    var rightBtn : UIButton?
    var maxTime:Int?//最大时间
    var timer:NSTimer!
    var activityNum = 0//倒计时加
    var freezeTime = 0
    var collectionLab:UILabel!
    //MYP add v3.2.1
    var collectionImgView:UIImageView?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(selected: Bool, animated: Bool)
    {
        super.setSelected(selected, animated: animated)
        // Configure the view for the selected state
    }
    
    override init(style: UITableViewCellStyle, reuseIdentifier: String?)
    {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        self.loadUI1()
    }

    //MYP add v3.2.1
    init(style: UITableViewCellStyle, reuseIdentifier: String?,cellType:String)
    {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        if cellType == "1"
        {
            self.loadUI2()
        }
        else
        {
            self.loadUI1()
        }
    }
    
    func loadUI1()
    {
        
        activityNum = 0;
        self.backgroundView?.backgroundColor = CD_BackGroundColor
        self.backgroundColor = CD_BackGroundColor
        
        var backView = UIView(frame: CGRectMake(0, 0, kScreenWidth, (10 + 75 + 10 + 40) * kRate))
        backView.backgroundColor = UIColor.whiteColor()
        self.contentView.addSubview(backView)
        
        headImageV.frame = CGRect(x: 15 * kRate, y: 10 * kRate, width: 95 * kRate, height: 80 * kRate)
        headImageV.layer.cornerRadius = 4 * kRate
        headImageV.backgroundColor = UIColor.clearColor()
        headImageV.layer.cornerRadius = 3
        headImageV.clipsToBounds = true
        self.contentView.addSubview(headImageV)
        
        //MYP add v3.2.1
        collectionImgView = UIImageView.newAutoLayoutView()
        collectionImgView?.backgroundColor = UIColor.clearColor()
        collectionImgView?.image = UIImage(named: "collect222")
        headImageV.addSubview(collectionImgView!)
        collectionImgView?.autoSetDimension(ALDimension.Height, toSize: 26)
        collectionImgView?.autoSetDimension(ALDimension.Width, toSize: 26)
        collectionImgView?.autoPinEdge(ALEdge.Top, toEdge: ALEdge.Top, ofView: headImageV)
        collectionImgView?.autoPinEdge(ALEdge.Left, toEdge: ALEdge.Left, ofView: headImageV)
        collectionImgView?.hidden = true

        
//        collectionLab = UILabel(frame: CGRectMake(0, 0, 45, 20))
//        collectionLab.backgroundColor = CD_MainColor
//        collectionLab.text = "已收藏"
//        collectionLab.font = Define.font(15)
//        collectionLab.textColor = UIColor.blackColor()
//        headImageV .addSubview(collectionLab)
//        collectionLab.hidden = true
        
        imageTime.frame = CGRectMake(15, 80-22+10, 95, 22);
        imageTime.image = UIImage(named: "mask_")
        imageTime.layer.cornerRadius = 3
        imageTime.clipsToBounds = true
        self.contentView .addSubview(imageTime);
        
        timeLable = UILabel(frame: CGRectMake(10, 0, 95, 22))
        timeLable?.font = Define.font(12)
        //  timeLable?.text = "有奖分享"
        timeLable?.textColor = UIColor.whiteColor()
        imageTime.addSubview(timeLable!)
        
        sepLine = UIView(frame: CGRectMake(0 * kRate, 0, kScreenWidth, 0.5))
        sepLine.backgroundColor = CD_LineColor
        self.contentView.addSubview(sepLine)
        
        leftBtn = UIButton.buttonWithType(UIButtonType.Custom) as? UIButton
        leftBtn?.frame = CGRectMake(0, headImageV.frame.size.height + headImageV.frame.origin.y + 10 * kRate, kScreenWidth / 2.0, 40 * kRate)
        leftBtn?.setBackgroundImage(Utility.imageWithColor(CD_BackGroundColor, _size: CGSizeMake(1, 1)), forState: UIControlState.Normal)
        leftBtn?.setImage(UIImage(named: "newhomes_1"), forState: UIControlState.Normal)
        leftBtn?.setTitle("客户", forState: UIControlState.Normal)
        leftBtn?.titleLabel?.font = Define.font(14)
        leftBtn?.setTitleColor(CD_Txt_Color_99, forState: UIControlState.Normal)
        leftBtn?.addTarget(self, action: "leftPress", forControlEvents: UIControlEvents.TouchUpInside)
        leftBtn?.imageEdgeInsets = UIEdgeInsets(top: 0, left: -5 * kRate, bottom: 0, right: 0)
        leftBtn?.titleEdgeInsets = UIEdgeInsets(top: 0, left: 5 * kRate, bottom: 0, right: 0)
        self.contentView.addSubview(leftBtn!)
        
        rightBtn = UIButton.buttonWithType(UIButtonType.Custom) as? UIButton
        rightBtn?.frame = CGRectMake(kScreenWidth / 2.0, headImageV.frame.size.height + headImageV.frame.origin.y + 10 * kRate, kScreenWidth / 2.0, 40 * kRate)
        rightBtn?.setBackgroundImage(Utility.imageWithColor(CD_BackGroundColor, _size: CGSizeMake(1, 1)), forState: UIControlState.Normal)
        //  rightBtn?.setImage(UIImage(named: "newhomes_2"), forState: UIControlState.Normal)
        
        rightBtn?.titleLabel?.font = Define.font(14)
        rightBtn?.setTitleColor(CD_Txt_Color_99, forState: UIControlState.Normal)
        rightBtn?.addTarget(self, action: "rightPress", forControlEvents: UIControlEvents.TouchUpInside)
        
        self.contentView.addSubview(rightBtn!)
        
        var sepLineV = UIView(frame: CGRectMake(0, 0, 0.5, rightBtn!.frame.size.height))
        sepLineV.backgroundColor = CD_LineColor
        rightBtn?.addSubview(sepLineV)
        
        
        
        titleLabel = UILabel(frame: CGRectMake(headImageV.frame.size.width + headImageV.frame.origin.x + 6 * kRate, 11 * kRate,200 * kRate,15))
        //titleLabel = UILabel(frame: CGRectMake(commissionTittleLabel.frame.origin.x + commissionTittleLabel.frame.size.width + 10 * kRate, 11 * kRate, 200 * kRate, 15))
        titleLabel?.font = Define.font(15)
        self.contentView.addSubview(titleLabel!)
        
        commissionTittleLabel = UILabel(frame: CGRectMake(CGRectGetMaxX(titleLabel!.frame), 11 * kRate, 16, 16))
        commissionTittleLabel?.font = Define.font(12)
        commissionTittleLabel?.textColor = UIColor.whiteColor()
        commissionTittleLabel?.backgroundColor = CD_RedDeepColor
        commissionTittleLabel?.layer.cornerRadius = 2
        commissionTittleLabel?.textAlignment = NSTextAlignment.Center
        commissionTittleLabel?.clipsToBounds = true
        self.contentView.addSubview(commissionTittleLabel!)
        
        var commissionTitleLabel = UILabel(frame: CGRectMake(headImageV.frame.size.width + headImageV.frame.origin.x + 6 * kRate, 35 * kRate, 35 * kRate, 16 * kRate))
        commissionTitleLabel.font = Define.font(12)
        commissionTitleLabel.textColor = UIColor.whiteColor()
        commissionTitleLabel.backgroundColor = CD_MainColor
        commissionTitleLabel.layer.cornerRadius = 3.0
        commissionTitleLabel.text = "佣金"
        commissionTitleLabel.textAlignment = NSTextAlignment.Center
        commissionTitleLabel.clipsToBounds = true
        self.contentView.addSubview(commissionTitleLabel)
        
        commissionLabel = UILabel(frame: CGRectMake(commissionTitleLabel.frame.origin.x + commissionTitleLabel.frame.size.width + 10 * kRate, 35 * kRate, kScreenWidth - commissionTitleLabel.frame.origin.x - commissionTitleLabel.frame.size.width - 10 * kRate, 15 * kRate))
        commissionLabel?.textColor = CD_MainColor
        commissionLabel?.font = Define.font(15)
        //        commissionLabel?.text = "最高4000元/套"
        self.contentView.addSubview(commissionLabel!)
        
        averagelabel = UILabel(frame: CGRectMake(headImageV.frame.size.width + headImageV.frame.origin.x + 6 * kRate, 55 * kRate, 200 * kRate, 15))
        averagelabel?.font = Define.font(12)
        averagelabel?.textColor = CD_Txt_Color_99
        //        averagelabel?.text = "均价: 27000元/㎡"
        self.contentView.addSubview(averagelabel!)
        
        //        var width : CGFloat = (kScreenWidth - 15 * kRate - headImageV.frame.size.width - 15 * kRate - 15 * kRate) / 2.0
        
        cooperationLabel = UILabel(frame: CGRectMake(headImageV.frame.size.width + headImageV.frame.origin.x + 6 * kRate, 74 * kRate, kScreenWidth - 45 * kRate - headImageV.frame.size.width, 15))
        cooperationLabel?.textColor = CD_Txt_Color_99
        //        cooperationLabel?.text = "合作经济人：200  意向客户：999"
        cooperationLabel?.font = Define.font(11)
        self.contentView.addSubview(cooperationLabel!)
        
        var topLineV = UIView(frame: CGRectMake(0, leftBtn!.frame.origin.y, kScreenWidth, 0.5))
        topLineV.backgroundColor = CD_LineColor
        self.contentView.addSubview(topLineV)
        
        var bottomLineV = UIView(frame: CGRectMake(0, leftBtn!.frame.origin.y + leftBtn!.frame.size.height, kScreenWidth, 0.5))
        bottomLineV.backgroundColor = CD_LineColor
        self.contentView.addSubview(bottomLineV)
        
        //        var bottomBottomLineV = UIView(frame: CGRectMake(0, 0.5, kScreenWidth, 1.0))
        //        bottomBottomLineV.backgroundColor = CD_GrayColor
        //        bottomLineV.addSubview(bottomBottomLineV)
        //        currentIndex = NSIndexPath(forRow: 1, inSection: 1)
        

    }
    
    func loadUI2()
    {
        activityNum = 0;
        self.backgroundView?.backgroundColor = CD_BackGroundColor
        self.backgroundColor = CD_BackGroundColor
        
        var backView = UIView(frame: CGRectMake(0, 0, kScreenWidth, (10 + 75 + 10) * kRate))
        backView.backgroundColor = UIColor.whiteColor()
        self.contentView.addSubview(backView)
        
        headImageV.frame = CGRect(x: 15 * kRate, y: 10 * kRate, width: 95 * kRate, height: 75 * kRate)
        headImageV.layer.cornerRadius = 4 * kRate
        headImageV.backgroundColor = UIColor.clearColor()
        headImageV.layer.cornerRadius = 3
        headImageV.clipsToBounds = true
        self.contentView.addSubview(headImageV)
        
        //        collectionLab = UILabel(frame: CGRectMake(0, 0, 45, 20))
        //        collectionLab.backgroundColor = CD_MainColor
        //        collectionLab.text = "已收藏"
        //        collectionLab.font = Define.font(15)
        //        collectionLab.textColor = UIColor.blackColor()
        //        headImageV .addSubview(collectionLab)
        
//        imageTime.frame = CGRectMake(15, 80-22+10, 95, 22);
//        imageTime.image = UIImage(named: "mask_")
//        imageTime.layer.cornerRadius = 3
//        imageTime.clipsToBounds = true
//        self.contentView .addSubview(imageTime);
        
//        timeLable = UILabel(frame: CGRectMake(10, 0, 95, 22))
//        timeLable?.font = Define.font(12)
//        //  timeLable?.text = "有奖分享"
//        timeLable?.textColor = UIColor.whiteColor()
//        imageTime.addSubview(timeLable!)
//        
//        sepLine = UIView(frame: CGRectMake(0 * kRate, 0, kScreenWidth, 0.5))
//        sepLine.backgroundColor = CD_LineColor
//        self.contentView.addSubview(sepLine)
        

        titleLabel = UILabel(frame: CGRectMake(headImageV.frame.size.width + headImageV.frame.origin.x + 6 * kRate, 10 * kRate,200 ,15))
        //titleLabel = UILabel(frame: CGRectMake(commissionTittleLabel.frame.origin.x + commissionTittleLabel.frame.size.width + 10 * kRate, 11 * kRate, 200 * kRate, 15))
        titleLabel?.font = Define.font(15)
        self.contentView.addSubview(titleLabel!)
        
//        commissionTittleLabel = UILabel(frame: CGRectMake(CGRectGetMaxX(titleLabel!.frame), 11 * kRate, 16, 16))
//        commissionTittleLabel?.font = Define.font(12)
//        commissionTittleLabel?.textColor = UIColor.whiteColor()
//        commissionTittleLabel?.backgroundColor = CD_RedDeepColor
//        commissionTittleLabel?.layer.cornerRadius = 2
//        commissionTittleLabel?.textAlignment = NSTextAlignment.Center
//        commissionTittleLabel?.clipsToBounds = true
//        self.contentView.addSubview(commissionTittleLabel!)
        
        var commissionTitleLabel = UILabel(frame: CGRectMake(headImageV.frame.size.width + headImageV.frame.origin.x + 6 * kRate, 35 * kRate, 35 * kRate, 16 * kRate))
        commissionTitleLabel.font = Define.font(12)
        commissionTitleLabel.textColor = UIColor.whiteColor()
        commissionTitleLabel.backgroundColor = CD_MainColor
        commissionTitleLabel.layer.cornerRadius = 3.0
        commissionTitleLabel.text = "佣金"
        commissionTitleLabel.textAlignment = NSTextAlignment.Center
        commissionTitleLabel.clipsToBounds = true
        self.contentView.addSubview(commissionTitleLabel)
        
        commissionLabel = UILabel(frame: CGRectMake(commissionTitleLabel.frame.origin.x + commissionTitleLabel.frame.size.width + 10 * kRate, 35 * kRate, kScreenWidth - commissionTitleLabel.frame.origin.x - commissionTitleLabel.frame.size.width - 10 * kRate, 15 * kRate))
        commissionLabel?.textColor = CD_MainColor
        commissionLabel?.font = Define.font(15)
        //        commissionLabel?.text = "最高4000元/套"
        self.contentView.addSubview(commissionLabel!)
        
        averagelabel = UILabel(frame: CGRectMake(headImageV.frame.size.width + headImageV.frame.origin.x + 6 * kRate, 55 * kRate, 200 * kRate, 15))
        averagelabel?.font = Define.font(12)
        averagelabel?.textColor = CD_Txt_Color_99
        //        averagelabel?.text = "均价: 27000元/㎡"
        self.contentView.addSubview(averagelabel!)
        
        //        var width : CGFloat = (kScreenWidth - 15 * kRate - headImageV.frame.size.width - 15 * kRate - 15 * kRate) / 2.0
        
        cooperationLabel = UILabel(frame: CGRectMake(headImageV.frame.size.width + headImageV.frame.origin.x + 6 * kRate, 74 * kRate, kScreenWidth - 45 * kRate - headImageV.frame.size.width, 15))
        cooperationLabel?.textColor = CD_Txt_Color_99
        //        cooperationLabel?.text = "合作经济人：200  意向客户：999"
        cooperationLabel?.font = Define.font(11)
        self.contentView.addSubview(cooperationLabel!)
        
//        var topLineV = UIView(frame: CGRectMake(0, leftBtn!.frame.origin.y, kScreenWidth, 0.5))
//        topLineV.backgroundColor = CD_LineColor
//        self.contentView.addSubview(topLineV)
//        
//        var bottomLineV = UIView(frame: CGRectMake(0, leftBtn!.frame.origin.y + leftBtn!.frame.size.height, kScreenWidth, 0.5))
//        bottomLineV.backgroundColor = CD_LineColor
//        self.contentView.addSubview(bottomLineV)
        
        //        var bottomBottomLineV = UIView(frame: CGRectMake(0, 0.5, kScreenWidth, 1.0))
        //        bottomBottomLineV.backgroundColor = CD_GrayColor
        //        bottomLineV.addSubview(bottomBottomLineV)
        //        currentIndex = NSIndexPath(forRow: 1, inSection: 1)
    }
    
    required init(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
   
    func fillData(model : HWNewHouseListModel, index : NSIndexPath ,timer:Int)
    {
        currentIndex = index
         titleLabel?.text = model.houseName! + model.houseAddress!
        if model.copunLableText == "1"
        {
             commissionTittleLabel.hidden = false
             commissionTittleLabel.text = "券"
            var dateSize = Utility.calculateStringSize(titleLabel.text!, textFont: titleLabel.font, constrainedSize:CGSizeMake(1000, 25))
            commissionTittleLabel.frame = CGRectMake(titleLabel.frame.origin.x + dateSize.width + 5, commissionTittleLabel.frame.origin.y, 16, 16 * kRate)
            var width = kScreenWidth - CGRectGetMaxX(headImageV.frame) - CGFloat(16)
            
            if  width <= dateSize.width
            {
                titleLabel!.frame = CGRectMake(titleLabel!.frame.origin.x, 11 * kRate,kScreenWidth-16-CGRectGetMaxX(headImageV.frame)-6 - 5, 16 * kRate)
                commissionTittleLabel.frame = CGRectMake(kScreenWidth-15-16,11, 16, 16 * kRate)
            }

        }
        else
        {
            commissionTittleLabel.hidden = true
        }
        headImageV.setImageWithURL(NSURL(string:  model.housePic!), placeholderImage: Utility.getPlaceHolderImage(CGSizeMake(95, 80), imageName: placeHolderSmallImage))
       
        commissionLabel?.text = "\(model.commission)"
        averagelabel?.text = "均价: \(model.houseAvgPrice)元/㎡"
        cooperationLabel?.text = "合作经纪人: \(model.brokerNum)    意向客户: \(model.clientNum)"
        if model.typeWalt == "0" || model.typeWalt == ""
        {
        
            imageTime.hidden = true
            timeLable?.hidden = true
            rightBtn?.setImage(UIImage(named: "newhomes_2"), forState: UIControlState.Normal)
            rightBtn?.setTitle("分享", forState: UIControlState.Normal)
            rightBtn?.imageEdgeInsets = UIEdgeInsets(top: 0, left: -5 * kRate, bottom: 0, right: 0)
            rightBtn?.titleEdgeInsets = UIEdgeInsets(top: 0, left: 5 * kRate, bottom: 0, right: 0)
            var attributeStr = NSMutableAttributedString(string:"");
            rightBtn?.setAttributedTitle(attributeStr, forState:  UIControlState.Normal)
        }
        
        else if model.typeWalt == "1"
        {
            if(model.waitTime.intValue == 0)
            {
                imageTime.hidden = true
                timeLable?.hidden = true
                rightBtn?.setImage(UIImage(named: ""), forState: UIControlState.Normal)
                rightBtn?.setTitle("", forState: UIControlState.Normal)
                
                // rightBtn?.setTitle("￥\(model.moneyWalt) 分享", forState: UIControlState.Normal)
                var attributeStr = NSMutableAttributedString(string:"￥\(model.moneyWalt) 分享");
                //  var rang = NSMakeRange(0,countElements(model.moneyWalt));
                var rang = NSMakeRange(0, countElements(model.moneyWalt)+1)
                var rang1 = NSMakeRange(countElements("￥\(model.moneyWalt) "), 2)
                attributeStr.addAttribute(NSForegroundColorAttributeName, value: CD_RedDeepColor, range: rang)
                attributeStr.addAttribute(NSForegroundColorAttributeName, value: CD_Txt_Color_99, range: rang1)
                rightBtn?.setAttributedTitle(attributeStr, forState:  UIControlState.Normal)
            }
            else
            {
                var freezeTime:Int = model.waitTime.integerValue / 1000
                var remaindTime = freezeTime - timer;
                if(remaindTime > 0)
                {
                    imageTime.hidden = false
                    timeLable?.hidden = false
                    rightBtn?.setImage(UIImage(named: "newhomes_2"), forState: UIControlState.Normal)
                    rightBtn?.setTitle("分享", forState: UIControlState.Normal)
                    rightBtn?.imageEdgeInsets = UIEdgeInsets(top: 0, left: -5 * kRate, bottom: 0, right: 0)
                    rightBtn?.titleEdgeInsets = UIEdgeInsets(top: 0, left: 5 * kRate, bottom: 0, right: 0)
                    var attributeStr = NSMutableAttributedString(string:"");
                    rightBtn?.setAttributedTitle(attributeStr, forState:  UIControlState.Normal)
                }
                else if(remaindTime <= 0)
                {
                    imageTime.hidden = true
                    timeLable?.hidden = true
                    rightBtn?.setImage(UIImage(named: ""), forState: UIControlState.Normal)
                    rightBtn?.setTitle("", forState: UIControlState.Normal)
                    
                    //rightBtn?.setTitle("￥\(model.moneyWalt) 分享", forState: UIControlState.Normal)
                    var attributeStr = NSMutableAttributedString(string:"￥\(model.moneyWalt) 分享");
                    //var rang = NSMakeRange(0,countElements(model.moneyWalt));
                    var rang = NSMakeRange(0, countElements(model.moneyWalt)+1)
                    var rang1 = NSMakeRange(countElements("￥\(model.moneyWalt) "), 2)
                    attributeStr.addAttribute(NSForegroundColorAttributeName, value: CD_RedDeepColor, range: rang)
                    attributeStr.addAttribute(NSForegroundColorAttributeName, value: CD_Txt_Color_99, range: rang1)
                    rightBtn?.setAttributedTitle(attributeStr, forState:  UIControlState.Normal)
                }
                
            }
            
        }
        else  if model.typeWalt == "2"

        {
            if(model.waitTime.intValue == 0)
            {
                imageTime.hidden = true
                timeLable?.hidden = true
                rightBtn?.setImage(UIImage(named: "wallet_icon1"), forState: UIControlState.Normal)
                rightBtn?.setTitle("分享", forState: UIControlState.Normal)
                rightBtn?.imageEdgeInsets = UIEdgeInsets(top: 0, left: -5 * kRate, bottom: 0, right: 0)
                rightBtn?.titleEdgeInsets = UIEdgeInsets(top: 0, left: 5 * kRate, bottom: 0, right: 0)
                var attributeStr = NSMutableAttributedString(string:"");
                rightBtn?.setAttributedTitle(attributeStr, forState:  UIControlState.Normal)
            }
            else
            {
                var freezeTime:Int = model.waitTime.integerValue / 1000
                var remaindTime = freezeTime - timer;
                if(remaindTime > 0)
                {
                    imageTime.hidden = false
                    timeLable?.hidden = false
                    rightBtn?.setImage(UIImage(named: "newhomes_2"), forState: UIControlState.Normal)
                    rightBtn?.setTitle("分享", forState: UIControlState.Normal)
                    rightBtn?.imageEdgeInsets = UIEdgeInsets(top: 0, left: -5 * kRate, bottom: 0, right: 0)
                    rightBtn?.titleEdgeInsets = UIEdgeInsets(top: 0, left: 5 * kRate, bottom: 0, right: 0)
                    var attributeStr = NSMutableAttributedString(string:"");
                    rightBtn?.setAttributedTitle(attributeStr, forState:  UIControlState.Normal)
                }
                else if(remaindTime <= 0)
                {
                    imageTime.hidden = true
                    timeLable?.hidden = true
                    rightBtn?.setImage(UIImage(named: ""), forState: UIControlState.Normal)
                    rightBtn?.setTitle("", forState: UIControlState.Normal)
                    
                    // rightBtn?.setTitle("￥\(model.moneyWalt) 分享", forState: UIControlState.Normal)
                    var attributeStr = NSMutableAttributedString(string:"￥\(model.moneyWalt) 分享");
                    //  var rang = NSMakeRange(0,countElements(model.moneyWalt));
                    var rang = NSMakeRange(0, countElements(model.moneyWalt)+1)
                    var rang1 = NSMakeRange(countElements("￥\(model.moneyWalt) "), 2)
                    attributeStr.addAttribute(NSForegroundColorAttributeName, value: CD_RedDeepColor, range: rang)
                    attributeStr.addAttribute(NSForegroundColorAttributeName, value: CD_Txt_Color_99, range: rang1)
                    rightBtn?.setAttributedTitle(attributeStr, forState:  UIControlState.Normal)
                }
            }
        }
        if model.isCollection == "1"
        {
            collectionImgView?.hidden = false
        }
        else
        {
            collectionImgView?.hidden = true
        }
}
func timer(time:Int,model:HWNewHouseListModel)
    {
        freezeTime = model.waitTime.integerValue / 1000
        var remaindTime = freezeTime - time;
        
//        if remaindTime < 0
//        {
//            return;
//        }
//        else
        if remaindTime <= 0
        {
            if model.typeWalt == "0" || model.typeWalt == ""
            {
                
                imageTime.hidden = true
                timeLable?.hidden = true
                rightBtn?.setImage(UIImage(named: "newhomes_2"), forState: UIControlState.Normal)
                rightBtn?.setTitle("分享", forState: UIControlState.Normal)
                rightBtn?.imageEdgeInsets = UIEdgeInsets(top: 0, left: -5 * kRate, bottom: 0, right: 0)
                rightBtn?.titleEdgeInsets = UIEdgeInsets(top: 0, left: 5 * kRate, bottom: 0, right: 0)
                var attributeStr = NSMutableAttributedString(string:"");
                rightBtn?.setAttributedTitle(attributeStr, forState:  UIControlState.Normal)
            }
                
            else if model.typeWalt == "1"
            {
                    imageTime.hidden = true
                    timeLable?.hidden = true
                    rightBtn?.setImage(UIImage(named: ""), forState: UIControlState.Normal)
                    rightBtn?.setTitle("", forState: UIControlState.Normal)
                    
                    // rightBtn?.setTitle("￥\(model.moneyWalt) 分享", forState: UIControlState.Normal)
                    var attributeStr = NSMutableAttributedString(string:"￥\(model.moneyWalt) 分享");
                    //  var rang = NSMakeRange(0,countElements(model.moneyWalt));
                    var rang = NSMakeRange(0, countElements(model.moneyWalt)+1)
                    var rang1 = NSMakeRange(countElements("￥\(model.moneyWalt) "), 2)
                    attributeStr.addAttribute(NSForegroundColorAttributeName, value: CD_RedDeepColor, range: rang)
                    attributeStr.addAttribute(NSForegroundColorAttributeName, value: CD_Txt_Color_99, range: rang1)
                    rightBtn?.setAttributedTitle(attributeStr, forState:  UIControlState.Normal)
             }
            
            else
            {
                
                    imageTime.hidden = true
                    timeLable?.hidden = true
                    rightBtn?.setImage(UIImage(named: "wallet_icon1"), forState: UIControlState.Normal)
                    rightBtn?.setTitle("分享", forState: UIControlState.Normal)
                    rightBtn?.imageEdgeInsets = UIEdgeInsets(top: 0, left: -5 * kRate, bottom: 0, right: 0)
                    rightBtn?.titleEdgeInsets = UIEdgeInsets(top: 0, left: 5 * kRate, bottom: 0, right: 0)
                    var attributeStr = NSMutableAttributedString(string:"");
                    rightBtn?.setAttributedTitle(attributeStr, forState:  UIControlState.Normal)
                
            }
        }
        else if remaindTime > 0
        {
            var second = remaindTime % 60
            var minute = (remaindTime / 60) % 60
            var hour = remaindTime / 3600


            var str = NSString()
            var minuteStr = NSString()
            var minuteStrs = NSString()
            var seconds = NSString()
            var hours = NSString()
            if hour > 0
            {
                if hour >= 100
                {
                     self.timeLable?.hidden = true
                     imageTime.hidden = true
                }
                
                else
                {
                    if hour < 10
                    {
                        
                        hours = "0\(hour):"
                        
                    }
                    
                    else
                    {
                        hours = "\(hour):"
                    }
                    if (minute) < 10
                    {
                        
                        minuteStr = "0\(minute)"
                        
                    }
                        
                    else
                    {
                        minuteStr = "\(minute)"

                    }
                    str  = "有奖分享 \(hours + minuteStr)"
                    var attributeStr = NSMutableAttributedString(string:"有奖分享\(str)");
                    var rang = NSMakeRange(0, countElements("有奖分享"))
                    var rang1 = NSMakeRange(countElements("有奖分享"),str.length)
                    attributeStr.addAttribute(NSForegroundColorAttributeName, value: CD_WhiteColor, range: rang)
                    attributeStr.addAttribute(NSForegroundColorAttributeName, value: CD_MainColor, range: rang1)
                    timeLable?.text = str

                }
            
            }
            
            else
            {
                if minute < 10
                {
                    minuteStrs = "0\(minute):"
                }
                
                else
                {
                    minuteStrs = "\(minute):"
                    
                }
                if second < 10
                {
                    seconds = "0\(second)"
                }
                else
                {
                     seconds = "\(second)"
                }
                str = "有奖分享\(minuteStrs+seconds)"
                
                var attributeStr = NSMutableAttributedString(string:"有奖分享\(str)");
                var rang = NSMakeRange(0, countElements("有奖分享"))
                var rang1 = NSMakeRange(countElements("有奖分享"),str.length)
                attributeStr.addAttribute(NSForegroundColorAttributeName, value: CD_WhiteColor, range: rang)
                attributeStr.addAttribute(NSForegroundColorAttributeName, value: CD_MainColor, range: rang1)
                timeLable?.text = str
            }
            
        }
    }
    
   
    func leftPress()
    {
        self.delegate?.leftTap(currentIndex!)
    }
    
    func rightPress()
    {
        self.delegate?.rightTap(currentIndex!)
        
    }
    
    //MYP add v3.2.1
    func setMyCollectionInfo(model:HWMyCollectionModel)
    {
        //小区名和区域
        titleLabel?.text = model.houseName + model.houseAddress
        //图片
        headImageV.setImageWithURL(NSURL(string:  model.housePic), placeholderImage: Utility.getPlaceHolderImage(CGSizeMake(95, 75), imageName: placeHolderSmallImage))
        //佣金
        commissionLabel?.text = "\(model.commission)"
        //均价
        averagelabel?.text = "均价: \(model.houseAvgPrice)元/㎡"
        cooperationLabel?.text = "合作经纪人: \(model.brokerNum)    意向客户: \(model.clientNum)"
    }
}
