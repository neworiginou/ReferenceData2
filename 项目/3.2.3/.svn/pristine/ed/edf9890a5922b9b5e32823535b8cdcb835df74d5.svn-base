//
//  HWMessageListCell.swift
//  Partner-Swift
//
//  Created by caijingpeng.haowu on 15/3/4.
//  Copyright (c) 2015年 caijingpeng.haowu. All rights reserved.
//

import UIKit

class HWMessageListCell: HWBaseTableViewCell {

    let marginLeft: CGFloat = 22.0
    
    var redPointImgV: UIImageView!
    var headImgV: UIImageView!
    var titleLabel: UILabel!
    var contentLabel: UILabel!
    var dateLabel: UILabel!
    var tagButton: UIButton!
    
    override init(style: UITableViewCellStyle, reuseIdentifier: String?)
    {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        redPointImgV = UIImageView(frame: CGRectMake(0, 0, 6, 6))
        redPointImgV.image = Utility.imageWithColor(CD_RedLightColor, _size: redPointImgV.frame.size)
        redPointImgV.layer.cornerRadius = 3
        redPointImgV.layer.masksToBounds = true
        redPointImgV.center = CGPointMake(marginLeft / 2.0, HWMessageListCell.getCellHeight() / 2.0)
        self.contentView.addSubview(redPointImgV)
        
        headImgV = UIImageView(frame: CGRectMake(marginLeft, 15, 55, 55))
        headImgV.image = UIImage(named: "")
        headImgV.layer.cornerRadius = 55 / 2.0
        headImgV.layer.masksToBounds = true
        self.contentView.addSubview(headImgV)
        headImgV.backgroundColor = UIColor.redColor()
        
        titleLabel = UILabel(frame: CGRectMake(CGRectGetMaxX(headImgV.frame) + 11, 0, 170, 40))
        titleLabel.backgroundColor = UIColor.clearColor()
        titleLabel.font = Define.font(TF_Text_15)
        titleLabel.textColor = CD_Txt_Color_00
        self.contentView.addSubview(titleLabel)
        
        tagButton = UIButton.buttonWithType(UIButtonType.Custom) as UIButton
        tagButton.frame = CGRectMake(0, 0, 33, 16)
        tagButton.setBackgroundImage(Utility.imageWithColor(CD_MainColor, _size: CGSizeMake(33, 16)), forState: UIControlState.Normal)
        tagButton.setTitle("附近", forState: UIControlState.Normal)
        tagButton.setTitleColor(UIColor.whiteColor(), forState: UIControlState.Normal)
        tagButton.layer.cornerRadius = 8
        tagButton.layer.masksToBounds = true
        tagButton.titleLabel?.font = Define.font(TF_11)
        self.contentView.addSubview(tagButton)
        
        contentLabel = UILabel(frame: CGRectMake(CGRectGetMaxX(headImgV.frame) + 11, 27, kScreenWidth - (CGRectGetMaxX(headImgV.frame) + 11) - 15, 50))
        contentLabel.backgroundColor = UIColor.clearColor()
        contentLabel.font = Define.font(TF_Text_15)
        contentLabel.textColor = CD_Txt_Color_66
        contentLabel.numberOfLines = 0
        self.contentView.addSubview(contentLabel)
        
        dateLabel = UILabel(frame: CGRectMake(kScreenWidth - 15 - 75, 0, 75, 40))
        dateLabel.backgroundColor = UIColor.clearColor()
        dateLabel.font = Define.font(TF_13)
        dateLabel.textColor = CD_Txt_Color_99
        dateLabel.textAlignment = NSTextAlignment.Right
        self.contentView.addSubview(dateLabel)
    }

    required init(coder aDecoder: NSCoder)
    {
        fatalError("init(coder:) has not been implemented")
    }
    
    class func getIdentify() -> String
    {
        return "HWMessageListCell"
    }
    
    class func getCellHeight() -> CGFloat
    {
        return 85
    }
    
    //MYP add v3.2.3 消息分类首页Cell加载数据
    func setMessageWithModel(model:HWMainMsgListModel)
    {
        /*
        "content": "分类消息内容",
        "source": "in",  消息来源
        "read": 1, 0未读  1已读
        "type": "system","admin","hi","rental",优惠券
        */
        
        //红点
        if (model.read == "0")
        {
            redPointImgV.hidden = false
        }
        else
        {
                redPointImgV.hidden = true
        }
        
        dateLabel.text = Utility.getIssueTimeStr(model.publishTime)
        
        //消息内容
        //contentLabel.frame = CGRectMake(CGRectGetMaxX(headImgV.frame) + 11, 27, kScreenWidth - (CGRectGetMaxX(headImgV.frame) + 11) - 15, 35)
        contentLabel.text = model.content

        //消息分类
        if (model.type == "hi")
        {
            titleLabel.text = "Hi"
            headImgV.image = UIImage(named: "message-center5")
            contentLabel.text = model.content
            tagButton.hidden = false
            titleLabel.frame = CGRectMake(CGRectGetMaxX(headImgV.frame) + 14, 0, 170, 40)
    
            let size = Utility.calculateStringSize(titleLabel.text!, textFont: titleLabel.font, constrainedSize: CGSizeMake(1000, 20))
            tagButton.frame = CGRectMake(CGRectGetMinX(titleLabel.frame) + size.width + 10, titleLabel.center.y - 8, tagButton.frame.size.width, tagButton.frame.size.height)
        }
        else if (model.type == "admin")
        {
            titleLabel.frame = CGRectMake(CGRectGetMaxX(headImgV.frame) + 11, 0, 170, 40)
            titleLabel.text = "管理员"
            tagButton.hidden = true
            headImgV.image = UIImage(named: "message-center1")
        }
        else if (model.type == "system")
        {
            titleLabel.frame = CGRectMake(CGRectGetMaxX(headImgV.frame) + 11, 0, 170, 40)
            titleLabel.text = "系统消息"
            headImgV.image = UIImage(named: "message-center2")
            tagButton.hidden = true
        }
        else if (model.type == "rental")
        {
            titleLabel.frame = CGRectMake(CGRectGetMaxX(headImgV.frame) + 11, 0, 170, 40)
            titleLabel.text = "会话"
            headImgV.image = UIImage(named: "message-center4")
            tagButton.hidden = true
        }
        else
        {
            titleLabel.frame = CGRectMake(CGRectGetMaxX(headImgV.frame) + 11, 0, 170, 40)
            titleLabel.text = "优惠券"
            tagButton.hidden = true
            headImgV.image = UIImage(named: "message-center3")
        }

    }
    
    func setMessageModel(message: HWMessageListModel) -> Void
    {
        /*
        "messageId":"" --消息ID
        "readed":""      --是否已读【0未读，1已读】
        "picKey":""      --头像key
        "publisher":""   --发布人
        "publishTime":"" --发布时间
        "title":""       --标题
        "msgType":""     --消息类型[hi,admin,system]
        */
        
        if (message.readed.isEqualToString("0") == true)
        {
            redPointImgV.hidden = false
        }
        else
        {
            redPointImgV.hidden = true
        }
        
        
        contentLabel.frame = CGRectMake(CGRectGetMaxX(headImgV.frame) + 11, 27, kScreenWidth - (CGRectGetMaxX(headImgV.frame) + 11) - 15, 35)
        contentLabel.text = message.content
//        contentLabel.setLineSpacing(4)
//        dateLabel.text = message.publishTime
        
        //MYP add v3.2.3 修改时间显示格式
        //dateLabel.text = Utility.getTimeFormattWithTimeStamp(message.publishTime)
        dateLabel.text = Utility.getIssueTimeStr(message.publishTime)
        
        if (message.msgType.isEqualToString("hi") == true)
        {
            titleLabel.text = message.publisher
            contentLabel.text = "HI了您一下"
            tagButton.hidden = false
            titleLabel.frame = CGRectMake(CGRectGetMaxX(headImgV.frame) + 14, 0, 170, 40)
            
            let size = Utility.calculateStringSize(titleLabel.text!, textFont: titleLabel.font, constrainedSize: CGSizeMake(1000, 20))
            tagButton.frame = CGRectMake(CGRectGetMinX(titleLabel.frame) + size.width + 10, titleLabel.center.y - 8, tagButton.frame.size.width, tagButton.frame.size.height)
            
            weak var weakImgV: UIImageView? = headImgV
            
            headImgV.setImageWithURL(NSURL(string: Utility.imageDownloadWithMongoDbKey(message.picKey)), placeholderImage: UIImage(named: "message-center5")) { (image, error, imageCacheType) -> Void in
                if (error != nil)
                {
                    weakImgV?.image = UIImage(named: "message-center5")
                }
                else
                {
                    weakImgV?.image = image
                }
            }
        }
        else if (message.msgType.isEqualToString("admin") == true)
        {
            titleLabel.frame = CGRectMake(CGRectGetMaxX(headImgV.frame) + 11, 0, 170, 40)
            titleLabel.text = "管理员"
            tagButton.hidden = true
            headImgV.image = UIImage(named: "message-center1")
        }
        else if (message.msgType.isEqualToString("system") == true)
        {
            if message.msgType.isEqualToString("coupon")
            {
                titleLabel.frame = CGRectMake(CGRectGetMaxX(headImgV.frame) + 11, 0, 170, 40)
                titleLabel.text = ""
                headImgV.image = UIImage(named: "message-center3")
                //MYP add v3.2.3 优惠券消息需设置title
                tagButton.hidden = true
            }
            else
            {
                titleLabel.frame = CGRectMake(CGRectGetMaxX(headImgV.frame) + 11, 0, 170, 40)
                titleLabel.text = "系统消息"
                headImgV.image = UIImage(named: "message-center2")
                tagButton.hidden = true
                //MYP add v3.2.3 进入系统消息列表时不显示红点
                redPointImgV.hidden = true
            }
        }
        else if (message.msgType.isEqualToString("rental") == true)
        {
            titleLabel.frame = CGRectMake(CGRectGetMaxX(headImgV.frame) + 11, 0, 170, 40)
            titleLabel.text = message.publisher
            headImgV.image = UIImage(named: "message-center4")
            tagButton.hidden = true
        }
        else if (message.msgType.isEqualToString("coupon") == true)
        {
            titleLabel.frame = CGRectMake(CGRectGetMaxX(headImgV.frame) + 11, 0, 170, 40)
            titleLabel.text = ""
            headImgV.image = UIImage(named: "message-center3")
            //MYP add v3.2.3 优惠券消息需设置title
            tagButton.hidden = true
        }
        
        titleLabel.sizeToFit()
        contentLabel.sizeToFit()
        
        let originY = (HWMessageListCell.getCellHeight() - (titleLabel.frame.size.height + min(contentLabel.frame.size.height, 35) + 10)) / 2.0;
        
        titleLabel.frame = CGRectMake(CGRectGetMaxX(headImgV.frame) + 11, originY, titleLabel.frame.size.width, titleLabel.frame.size.height)
        contentLabel.frame = CGRectMake(CGRectGetMaxX(headImgV.frame) + 11, CGRectGetMaxY(titleLabel.frame) + 10, contentLabel.frame.size.width, min(contentLabel.frame.size.height, 35))
        
        if (message.msgType.isEqualToString("hi") == true)
        {
            let size = Utility.calculateStringSize(titleLabel.text!, textFont: titleLabel.font, constrainedSize: CGSizeMake(1000, 20))
            tagButton.frame = CGRectMake(CGRectGetMinX(titleLabel.frame) + size.width + 10, titleLabel.center.y - 8, tagButton.frame.size.width, tagButton.frame.size.height)
        }
        
    }

}
