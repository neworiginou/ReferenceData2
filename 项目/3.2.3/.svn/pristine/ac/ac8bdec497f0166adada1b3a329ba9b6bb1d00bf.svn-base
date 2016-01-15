//
//  ClientSearchCell.swift
//  Partner-Swift
//
//  Created by zhangxun on 15/3/10.
//  Copyright (c) 2015年 caijingpeng.haowu. All rights reserved.
//

import UIKit

protocol ClientSearchCellDelegate
{
    func isSelected(select : Bool, index indexPath : NSIndexPath)
}

class ClientSearchCell: UITableViewCell {
    var nameLabel : UILabel!
    var styleLabel : UILabel!
    var houseLabel : UILabel!
    var timeLabel : UILabel!
    var statusLabel : UILabel!
    var deletate : ClientSearchCellDelegate?
    var theIndex : NSIndexPath!
    var hasSelected : Bool!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        nameLabel = UILabel(frame: CGRectMake(15, 10, 100, 15))
        nameLabel.font = Define.font(13)
        self.contentView.addSubview(nameLabel)
        
        styleLabel = UILabel (frame: CGRectMake(0, 0, 40, 15))
        styleLabel.textColor =  UIColor.whiteColor()
        styleLabel.font = Define.font(11)
        styleLabel.backgroundColor = "c7c7c7".UIColor
        styleLabel.layer.cornerRadius = 3.0
        styleLabel.layer.masksToBounds = true
        styleLabel.textAlignment = NSTextAlignment.Center
        self.contentView.addSubview(styleLabel)
        
        houseLabel = UILabel(frame: CGRectMake(15, 30, kScreenWidth - 30, 15))
        houseLabel.textColor = CD_Txt_Color_66
        houseLabel.font = Define.font(12)
        self.contentView.addSubview(houseLabel)
        
        timeLabel = UILabel(frame: CGRectMake(15, 50, kScreenWidth - 30, 15))
        timeLabel.textColor = CD_Txt_Color_66
        timeLabel.font = Define.font(12)
        self.contentView.addSubview(timeLabel)
        
        statusLabel = UILabel(frame: CGRectMake(kScreenWidth - 100, 0, 100, 75))
        statusLabel.textColor = CD_OrangeColor
        statusLabel.font = Define.font(13)
        self.contentView.addSubview(statusLabel)
    }
    
    required init(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func fill(dict : NSDictionary, index indexPath : NSIndexPath)
    {
        nameLabel.text = "aaa"
        nameLabel.sizeToFit()
        styleLabel.text = "bb"
        styleLabel.frame = CGRectMake(nameLabel.frame.size.width + nameLabel.frame.origin.x, styleLabel.frame.origin.y, styleLabel.frame.size.width, styleLabel.frame.size.height)
        houseLabel.text = "cc"
        statusLabel.text = "dd"
        theIndex = indexPath
    }
    
    func setSelected()
    {
        if !hasSelected
        {
            var imageV = UIImageView(image: UIImage(named: "choose_3_2-"))
            imageV.frame = CGRectMake(0, 0, 20, 20)
            self.accessoryView = imageV
            self.deletate?.isSelected(true, index: theIndex)
        }
        else
        {
            self.accessoryView = nil
            self.deletate?.isSelected(false, index: theIndex)
        }
        hasSelected = !hasSelected
    }
}
