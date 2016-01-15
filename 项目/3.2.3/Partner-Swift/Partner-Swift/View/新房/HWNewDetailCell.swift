//
//  HWNewDetailCell.swift
//  Partner-Swift
//
//  Created by zhangxun on 15/2/15.
//  Copyright (c) 2015年 caijingpeng.haowu. All rights reserved.
//

import UIKit

class HWNewDetailCell1: UITableViewCell {

    var titleLabel : UILabel!
    var subTitleLabel : UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        titleLabel = UILabel(frame: CGRectMake(15, 0, 100, 45))
        titleLabel.font = Define.font(15)
        titleLabel.textColor = "333333".UIColor
        self.addSubview(titleLabel)
        
        subTitleLabel = UILabel(frame: CGRectMake(115, 0, kScreenWidth - (140 + 30), 45))
        subTitleLabel.font = Define.font(15)
        subTitleLabel.textColor = CD_Txt_Color_99
        self.addSubview(subTitleLabel)
        
        let LineV : UIView = UIView(frame: CGRectMake(0, (45 - 0.5), kScreenWidth, 0.5))
        LineV.backgroundColor = "d6d6d6".UIColor
        self.addSubview(LineV)
    }
    
    required init(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

class HWNewDetailCell2: UITableViewCell {
    var titleButton : UIButton!
    var contentLabel : UILabel!
    var lineV : UIView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        titleButton = UIButton.buttonWithType(UIButtonType.Custom) as UIButton
        titleButton.frame = CGRectMake(15, 15, 45, 15)
        titleButton.layer.cornerRadius = 2.0
        titleButton.clipsToBounds = true
        titleButton.titleLabel?.font = Define.font(12)
        titleButton.titleLabel?.textColor = "333333".UIColor
        titleButton.userInteractionEnabled = false
        self.addSubview(titleButton)
        
        contentLabel = UILabel(frame: CGRectMake(65, 0, kScreenWidth - 65 - 15, 45))
        contentLabel.font = Define.font(14)
        contentLabel.textColor = "333333".UIColor
        contentLabel.numberOfLines = 0
        self.addSubview(contentLabel)
        
        lineV = UIView(frame:CGRectMake(0, 0, kScreenWidth, 0.5))
        lineV.backgroundColor = CD_LineColor
        self.addSubview(lineV)
    }
    
    func set(content : NSArray, index : NSInteger)
    {
        contentLabel.frame = CGRectMake(65, 0, CGFloat(kScreenWidth - 65 - 15), CGFloat(28 + 17 * content.count))
        
        var a : Int = 1
        if content.count > 1
        {
            a = content.count
        }
        
        if index == 0
        {
            lineV.hidden = true
            titleButton .setBackgroundImage(Utility.imageWithColor("37ca6b".UIColor, _size: CGSizeMake(10, 10)), forState: UIControlState.Normal)
            titleButton.setTitle("优惠", forState: UIControlState.Normal)
            var string : NSMutableString = NSMutableString()
            for (var i = 0; i < content.count; i++)
            {
                var str : NSString = content[i] as NSString
                if str != Optional.None
                {
                    string.appendString(content[i] as NSString)
                    string.appendString("\n")
                }
            }
            var finalString : String = ""
            if string.length > 0
            {
                finalString = string.substringWithRange(NSMakeRange(0, string.length - 1))
            }
            contentLabel.text = finalString
        }
        else if index == 1
        {
            lineV.hidden = false
            titleButton.setBackgroundImage(Utility.imageWithColor("ff7302".UIColor, _size: CGSizeMake(10, 10)), forState: UIControlState.Normal)
            titleButton.setTitle("佣金", forState: UIControlState.Normal)
            
            var string : NSMutableString = NSMutableString()
            for (var i = 0; i < content.count; i++)
            {
                var contentDic : NSDictionary = content[i] as NSDictionary
                var str = contentDic.stringObjectForKey("scale")
                var nameStr = contentDic.stringObjectForKey("productName")
                if contentDic.stringObjectForKey("feeType") == "groupbuy"
                {
                    string.appendString("\(nameStr)  团购费\(str)%")
                    string.appendString("\n")
                }
                else if contentDic.stringObjectForKey("feeType") == "houseprice"
                {
                    string.appendString("\(nameStr)  房价\(str)%")
                    string.appendString("\n")
                }
                else
                {
                    var str = contentDic.stringObjectForKey("fixedAmount")
                    string.appendString("\(nameStr)  \(str)元/套")
                    string.appendString("\n")
                }
            }
            var finalString : String = ""
            if string.length > 0
            {
                finalString = string.substringWithRange(NSMakeRange(0, string.length - 1))
            }
            contentLabel.text = finalString
        }
        else
        {
            lineV.hidden = false
            titleButton.setBackgroundImage(Utility.imageWithColor("f16373".UIColor, _size: CGSizeMake(10, 10)), forState: UIControlState.Normal)
            titleButton.setTitle("现金奖", forState: UIControlState.Normal)
            var string : NSMutableString = NSMutableString()
            for (var i = 0; i < content.count; i++)
            {
                var contentDic : NSDictionary = content[i] as NSDictionary
                if contentDic.stringObjectForKey("cashBrokerage").integerValue > 0
                {
                    string.appendString(contentDic.stringObjectForKey("productName"))
                    string.appendString(" ")
                    string.appendString(contentDic.stringObjectForKey("brokerBrokerage"))
                    string.appendString("元")
                    string.appendString("\n")
                }
            }
            var finalString : String = ""
            if string.length > 0
            {
                finalString = string.substringWithRange(NSMakeRange(0, string.length - 1))
            }
            contentLabel.text = finalString
        }
    }
    
    required init(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}

class HWNewDetailCell3: UITableViewCell {
    
    var houseIV:UIImageView!
    var nameLabel:UILabel!
    var houseStyleLabel:UILabel!
    var houseSizeLabel:UILabel!
    
    let kSizeWidth : CGFloat = 70
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        houseIV = UIImageView(frame: CGRectMake(15, 12.5, 80, 80))
        houseIV.backgroundColor = UIColor.orangeColor()
        houseIV.clipsToBounds = true
        houseIV.layer.cornerRadius = 3.0
        houseIV.layer.borderColor = CD_LineColor.CGColor
        self.addSubview(houseIV)
        
        nameLabel = UILabel(frame: CGRectMake((CGRectGetMaxX(houseIV.frame) + 10), (houseIV.frame.origin.y + 10), kScreenWidth - (80 + 30 + kSizeWidth), 22.5))
        nameLabel.font = Define.font(15)
        nameLabel.textColor = "333333".UIColor
        self.addSubview(nameLabel)
        
        houseSizeLabel = UILabel(frame: CGRectMake(kScreenWidth - (kSizeWidth + 15), houseIV.frame.origin.y, kSizeWidth, 22.5))
        houseSizeLabel.backgroundColor = UIColor.clearColor()
        houseSizeLabel.textAlignment = NSTextAlignment.Right
        houseSizeLabel.font = Define.font(15)
        houseSizeLabel.textColor = "333333".UIColor
        self.addSubview(houseSizeLabel)
        
        houseStyleLabel = UILabel(frame: CGRectMake(nameLabel.frame.origin.x, nameLabel.frame.maxY, nameLabel.frame.size.width, 20))
        houseStyleLabel.font = Define.font(15)
        houseStyleLabel.textColor = CD_Txt_Color_66
        self.addSubview(houseStyleLabel)
        
        var lineV : UIView = UIView(frame: CGRectMake(0, 105 - 0.5, kScreenWidth, 0.5))
        lineV.backgroundColor = CD_LineColor
        self.addSubview(lineV)
    }
    
    required init(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}




