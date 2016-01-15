//
//  HWMessageDialogLeftCell.swift
//  Partner-Swift
//
//  Created by caijingpeng.haowu on 15/3/4.
//  Copyright (c) 2015年 caijingpeng.haowu. All rights reserved.
//

import UIKit

class HWMessageDialogLeftCell: HWBaseTableViewCell {

    let marginLeft: CGFloat = 15.0
    let marginTop: CGFloat = 11.0
    let marginBottom: CGFloat = 3.0
    
    var headImgV: UIImageView!
    var nameLabel: UILabel!
    var dateLabel: UILabel!
    var backImgV: UIImageView!
    var contentLabel: UILabel!
    var pictureImgV: UIImageView!
    
    override init(style: UITableViewCellStyle, reuseIdentifier: String?)
    {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        headImgV = UIImageView(frame: CGRectMake(marginLeft, marginTop, 55, 55))
        headImgV.image = UIImage(named: "")
        headImgV.layer.cornerRadius = 55 / 2.0
        headImgV.layer.masksToBounds = true
        self.contentView.addSubview(headImgV)
        
        nameLabel = UILabel(frame: CGRectMake(CGRectGetMaxX(headImgV.frame) + 11, 0, 0, 40))
        nameLabel.backgroundColor = UIColor.clearColor()
        nameLabel.font = Define.font(TF_Text_15)
        nameLabel.textColor = CD_Txt_Color_00
        self.contentView.addSubview(nameLabel)
        
        dateLabel = UILabel(frame: CGRectMake(0, 0, 75, 40))
        dateLabel.backgroundColor = UIColor.clearColor()
        dateLabel.font = Define.font(TF_13)
        dateLabel.textColor = CD_Txt_Color_66
        self.contentView.addSubview(dateLabel)
        
        backImgV = UIImageView(frame: CGRectMake(CGRectGetMaxX(headImgV.frame) + 5, CGRectGetMaxY(nameLabel.frame), 222, 55))
        backImgV.image = UIImage(named: "sall_gray")?.resizableImageWithCapInsets(UIEdgeInsetsMake(35, 15, 10, 10))
        self.contentView.addSubview(backImgV)
        
        contentLabel = UILabel(frame: CGRectMake(20, 10, 0, 0))
        contentLabel.backgroundColor = UIColor.clearColor()
        contentLabel.font = Define.font(TF_Text_15)
        contentLabel.textColor = CD_Txt_Color_00
        self.backImgV.addSubview(contentLabel)
        
        pictureImgV = UIImageView(frame: CGRectZero)
        pictureImgV.contentMode = UIViewContentMode.ScaleAspectFit
        self.backImgV.addSubview(pictureImgV)
        
        self.selected = false
        self.selectionStyle = UITableViewCellSelectionStyle.None
    }

    required init(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    class func getIdentify() -> String
    {
        return "HWMessageDialogLeftCell"
    }
    
    class func getCellHeight(message: HWMessageDialogModel?) -> CGFloat
    {
        let ctntSize: CGSize = Utility.calculateStringSize(message?.content as String, textFont: Define.font(TF_Text_15), constrainedSize: CGSizeMake(190, CGFloat.max))
        
        let height = ctntSize.height + 10 * 2 + 40 + 3 + 10
        let minHeight = CGFloat(11 * 2 + 55 + 10)
        
        return max(minHeight, height)
    }
    
    func setMessageDialogLeft(message: HWMessageDialogModel?) -> Void
    {
        weak var weakImgV: UIImageView? = headImgV
        headImgV.setImageWithURL(NSURL(string: Utility.imageDownloadWithMongoDbKey(message?.picKey as String)), placeholderImage: UIImage(named: "news_people")) { (image, error, imageCacheType) -> Void in
            if (error != nil)
            {
                weakImgV?.image = UIImage(named: "news_people")
            }
            else
            {
                weakImgV?.image = image
            }
        }
        
        if (message?.msgType.isEqualToString("hi") == true)
        {
            nameLabel.text = message?.publisher
        }
        else if (message?.msgType.isEqualToString("admin") == true)
        {
            nameLabel.text = "管理员"
        }
        else if (message?.msgType.isEqualToString("system") == true)
        {
            nameLabel.text = "系统消息"
        }
        else
        {
            nameLabel.text = message?.publisher
        }
        
        
        
        let size = Utility.calculateStringSize(nameLabel.text!, textFont: nameLabel.font, constrainedSize: CGSizeMake(1000, 20))
        nameLabel.frame = CGRectMake(CGRectGetMaxX(headImgV.frame) + 11, 0, size.width, 40)
        dateLabel.frame = CGRectMake(CGRectGetMinX(nameLabel.frame) + size.width + 17, 0, dateLabel.frame.size.width, dateLabel.frame.size.height)
//        dateLabel.text = message?.publishTime
        dateLabel.text = Utility.getTimeFormattWithTimeStamp(message!.publishTime)
        
        let ctntSize = Utility.calculateStringSize(message?.content as String, textFont: contentLabel.font, constrainedSize: CGSizeMake(190, CGFloat.max))
        
        contentLabel.frame = CGRectMake(contentLabel.frame.origin.x, contentLabel.frame.origin.y, ctntSize.width, ctntSize.height)
        contentLabel.numberOfLines = 0
        contentLabel.text = message?.content
        
        if (message?.picKey.length == 0)
        {
            backImgV.frame = CGRectMake(backImgV.frame.origin.x, backImgV.frame.origin.y, min(ctntSize.width + 10 + 20, 222), 10 * 2 + ctntSize.height)
            pictureImgV.hidden = true
        }
        else
        {
            // 问题 图片大小尺寸
            backImgV.frame = CGRectMake(backImgV.frame.origin.x, backImgV.frame.origin.y, min(ctntSize.width + 10 + 20, 222), 10 * 2 + ctntSize.height)
            pictureImgV.hidden = false
        }
        
    }
}
