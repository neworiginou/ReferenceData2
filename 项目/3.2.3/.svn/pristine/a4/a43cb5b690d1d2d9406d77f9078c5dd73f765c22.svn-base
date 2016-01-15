//
//  HWGradeOfSingleTableViewCell.swift
//  HaoWuPartner
//
//  Created by WeiYuanlin on 15/2/12.
//  Copyright (c) 2015年 WeiYuanlin. All rights reserved.
//

import UIKit

class HWGradeOfSingleTableViewCell: UITableViewCell
{
    let CellHeight:CGFloat = 80.0
    var rankNumberLab:UILabel?
    var customerImgV:UIImageView?
    var customerNameLab:UILabel?
    var moneyLab:UILabel?
    
    override init(style: UITableViewCellStyle, reuseIdentifier: String?)
    {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        self.selectionStyle = UITableViewCellSelectionStyle.None
        rankNumberLab = UILabel(frame: CGRectMake(14, (CellHeight - 20) / 2, 20, 20))
        rankNumberLab?.textColor = CD_Txt_Color_00
        rankNumberLab?.textAlignment = NSTextAlignment.Center
        rankNumberLab?.font = Define.font(10)
        rankNumberLab?.backgroundColor = CD_MainColor
        rankNumberLab?.layer.cornerRadius = 10
        rankNumberLab?.clipsToBounds = true
        self.addSubview(rankNumberLab!)
        
        customerImgV = UIImageView(frame: CGRectMake(CGRectGetMaxX(rankNumberLab!.frame) + 5, (CellHeight - 60) / 2, 60, 60))
        customerImgV?.backgroundColor = UIColor.redColor()
        customerImgV?.layer.cornerRadius = 30
        customerImgV?.clipsToBounds = true
        self.addSubview(customerImgV!)
        
        customerNameLab = UILabel(frame: CGRectMake(CGRectGetMaxX(customerImgV!.frame) + 15, 30, 100, 20))
        customerNameLab?.textColor = UIColor.blackColor()
        customerNameLab?.textAlignment = NSTextAlignment.Center
        customerNameLab?.font = Define.font(15)
        self.addSubview(customerNameLab!)
        
        moneyLab = UILabel(frame: CGRectMake(kScreenWidth - 100 - 15, 30, 100, 20))
        moneyLab?.backgroundColor = UIColor.clearColor()
        moneyLab?.textAlignment = NSTextAlignment.Center
        moneyLab?.textColor = CD_MainColor
        moneyLab?.font = Define.font(17)
        self.addSubview(moneyLab!)
        
    }
    
/**
 *	@brief	重写视图
 *
 *	@param 	 N/A
 *
 *	@return	N/A
 */
    func setvalueOfContentView(singleModel:HWGradeOfSingleModel)
    {
        var customerNameStr = singleModel.name
        var moneyStr = singleModel.result

        customerNameLab?.text = customerNameStr
        customerNameLab?.sizeToFit()
        customerNameLab?.frame = CGRectMake(CGRectGetMaxX(customerImgV!.frame) + 5, (CellHeight - customerNameLab!.frame.size.height) / 2, customerNameLab!.frame.size.width, customerNameLab!.frame.size.height)
        moneyLab?.text = Utility.convertRMBStr(moneyStr!)
        moneyLab?.sizeToFit()
        moneyLab?.frame = CGRectMake(kScreenWidth - moneyLab!.frame.size.width - 15, (CellHeight - moneyLab!.frame.size.height) / 2, moneyLab!.frame.size.width, moneyLab!.frame.size.height)
        
        
    }
    
    class func setCellHeight()->CGFloat
    {
        return 80.0
    }
    required init(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
