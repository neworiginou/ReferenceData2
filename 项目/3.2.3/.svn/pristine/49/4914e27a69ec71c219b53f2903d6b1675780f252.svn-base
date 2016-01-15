//
//  HWPersonalCenterTableViewCell.swift
//  HaoWuPartner
//
//  Created by WeiYuanlin on 15/2/15.
//  Copyright (c) 2015年 WeiYuanlin. All rights reserved.
//

import UIKit

class HWPersonalCenterTableViewCell: HWBaseTableViewCell
{
    let cellHeight:CGFloat = 45.0
    
    var headImageV:UIImageView!
    var nameLabel:UILabel!
    var numberLable:UILabel!
    
    override init(style: UITableViewCellStyle, reuseIdentifier: String?)
    {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        headImageV = UIImageView(frame: CGRectMake(15 , 10, 25, 25))
        headImageV.contentMode = UIViewContentMode.ScaleAspectFit
        headImageV?.backgroundColor = UIColor.clearColor()
        self.contentView.addSubview(headImageV)
        
        nameLabel = UILabel()
        nameLabel?.font = Define.font(TF_15)
        nameLabel?.backgroundColor = UIColor.clearColor()
        nameLabel?.textColor = CD_Txt_Color_00
        self.contentView.addSubview(nameLabel)
        
        numberLable = UILabel()
        numberLable.font = Define.font(TF_15)
        numberLable.backgroundColor = UIColor.clearColor()
        numberLable.textColor = CD_Txt_Color_99
        self.contentView.addSubview(numberLable)
        
        var arrowImg = UIImageView(frame: CGRectMake(kScreenWidth - 15 - 8, (45 - 13) / 2, 8, 13))
        arrowImg.image = UIImage(named: "arrow_next")
        self.contentView.addSubview(arrowImg)

    }
    
    func setFrame()
    {
        nameLabel.sizeToFit()
        nameLabel.frame = CGRectMake(CGRectGetMaxX(headImageV.frame) + 10, (cellHeight - nameLabel.frame.size.height) / 2, nameLabel.frame.size.width, nameLabel.frame.size.height)
        
        numberLable.sizeToFit()
        numberLable.frame = CGRectMake(kScreenWidth - 36   - numberLable.frame.size.width, (cellHeight - numberLable.frame.size.height) / 2, numberLable.frame.size.width, numberLable.frame.size.height)
    }

    class func getCellHeight()->CGFloat
    {
        return 45.0
    }
    required init(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

    }

}
