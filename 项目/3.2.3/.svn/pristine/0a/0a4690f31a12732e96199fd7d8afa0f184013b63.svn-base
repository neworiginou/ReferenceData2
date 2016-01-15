//
//  HWGradeOfCompanyTableViewCell.swift
//  HaoWuPartner
//
//  Created by WeiYuanlin on 15/2/12.
//  Copyright (c) 2015年 WeiYuanlin. All rights reserved.
//

import UIKit

class HWGradeOfCompanyTableViewCell: HWBaseTableViewCell {
    let CellHeight:CGFloat = 80.0
    var rankNumberLab:UILabel?
    var companyNameLab:UILabel?
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
        
        companyNameLab = UILabel(frame: CGRectMake(CGRectGetMaxX(rankNumberLab!.frame) + 15, 30, 108, 70))
        companyNameLab?.textColor = CD_Txt_Color_00
        companyNameLab?.textAlignment = NSTextAlignment.Center
        companyNameLab?.font = Define.font(15)
        companyNameLab?.numberOfLines = 0
        companyNameLab?.lineBreakMode = NSLineBreakMode.ByCharWrapping
        self.addSubview(companyNameLab!)
        
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
    func setValueOfContentView(companyModel:HWGradeOfCompanyModel)
    {
        var companyNameStr = companyModel.name
        var moneyStr = companyModel.result
        
//        println("companyModel=\(companyModel)")
//        println("name=\(companyModel.name)")
        
        companyNameLab?.text = companyNameStr
        companyNameLab?.sizeToFit()
        companyNameLab?.frame = CGRectMake(CGRectGetMaxX(rankNumberLab!.frame) + 15, (CellHeight - companyNameLab!.frame.size.height) / 2, companyNameLab!.frame.size.width, companyNameLab!.frame.size.height)
        
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
