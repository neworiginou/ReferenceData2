//
//  HWMessageDialogRightCell.swift
//  Partner-Swift
//
//  Created by caijingpeng.haowu on 15/3/4.
//  Copyright (c) 2015年 caijingpeng.haowu. All rights reserved.
//

import UIKit

class HWMessageDialogRightCell: HWBaseTableViewCell {
   
    let marginRight: CGFloat = 15.0
    let marginTop: CGFloat = 11.0
    let marginBottom: CGFloat = 3.0
    
    var headImgV: UIImageView!
//    var nameLabel: UILabel!
    var dateLabel: UILabel!
    var backImgV: UIImageView!
    var contentLabel: UILabel!
    
    override init(style: UITableViewCellStyle, reuseIdentifier: String?)
    {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        headImgV = UIImageView(frame: CGRectMake(kScreenWidth - marginRight - 55, marginTop, 55, 55))
        headImgV.image = UIImage(named: "")
        headImgV.layer.cornerRadius = 55 / 2.0
        headImgV.layer.masksToBounds = true
        self.contentView.addSubview(headImgV)
        
//        nameLabel = UILabel(frame: CGRectMake(CGRectGetMaxX(headImgV.frame) + 11, 0, 0, 40))
//        nameLabel.backgroundColor = UIColor.clearColor()
//        nameLabel.font = Define.font(TF_Text_15)
//        nameLabel.textColor = CD_Txt_Color_00
//        self.contentView.addSubview(nameLabel)
        
        dateLabel = UILabel(frame: CGRectMake(CGRectGetMinX(headImgV.frame) - 75 - 11, 0, 75, 40))
        dateLabel.backgroundColor = UIColor.clearColor()
        dateLabel.font = Define.font(TF_13)
        dateLabel.textColor = CD_Txt_Color_66
        dateLabel.textAlignment = NSTextAlignment.Right
        self.contentView.addSubview(dateLabel)
        
        backImgV = UIImageView(frame: CGRectMake(kScreenWidth - 123 - 222, CGRectGetMaxY(dateLabel.frame), 222, 0))
        backImgV.image = UIImage(named: "sall_green")?.resizableImageWithCapInsets(UIEdgeInsetsMake(35, 10, 10, 15))
        self.contentView.addSubview(backImgV)
        
        contentLabel = UILabel(frame: CGRectMake(10, 10, 0, 0))
        contentLabel.backgroundColor = UIColor.clearColor()
        contentLabel.font = Define.font(TF_Text_15)
        contentLabel.textColor = UIColor.whiteColor()
        self.backImgV.addSubview(contentLabel)
        
        self.selected = false
        self.selectionStyle = UITableViewCellSelectionStyle.None
    }
    
    required init(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    class func getIdentify() -> String
    {
        return "HWMessageDialogRightCell"
    }
    
    class func getCellHeight(message: HWMessageDialogModel?) -> CGFloat
    {
        let ctntSize: CGSize = Utility.calculateStringSize(message?.content as String, textFont: Define.font(TF_Text_15), constrainedSize: CGSizeMake(190, CGFloat.max))
        
        let height = ctntSize.height + 10 * 2 + 40 + 3 + 10
        let minHeight = CGFloat(11 * 2 + 55 + 10)
        
        return max(minHeight, height)
    }
    
    func setMessageDialogRight(message: HWMessageDialogModel?) -> Void
    {
        weak var weakImgV: UIImageView? = headImgV
        headImgV.setImageWithURL(NSURL(string: Utility.imageDownloadWithMongoDbKey((message?.picKey as String))), placeholderImage: UIImage(named: "news_people")) { (image, error, imageCacheType) -> Void in
            if (error != nil)
            {
                weakImgV?.image = UIImage(named: "news_people")
            }
            else
            {
                weakImgV?.image = image
            }
        }
        
//        dateLabel.text = message?.publishTime
        dateLabel.text = Utility.getTimeFormattWithTimeStamp(message!.publishTime)
        
        let ctntSize = Utility.calculateStringSize((message?.content as String), textFont: contentLabel.font, constrainedSize: CGSizeMake(190, CGFloat.max))
        backImgV.frame = CGRectMake(kScreenWidth - min(ctntSize.width + 10 + 20, 222) - 73, backImgV.frame.origin.y, min(ctntSize.width + 10 + 20, 222), 10 * 2 + ctntSize.height)
        contentLabel.frame = CGRectMake(contentLabel.frame.origin.x, contentLabel.frame.origin.y, ctntSize.width, ctntSize.height)
        contentLabel.numberOfLines = 0
        contentLabel.text = message?.content
    }
    
}
