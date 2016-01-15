//
//  HWScoreCertificateTableViewCell.swift
//  HaoWuPartner
//
//  Created by WeiYuanlin on 15/2/9.
//  Copyright (c) 2015年 WeiYuanlin. All rights reserved.
//  功能描述：我的业绩—权证tableviewcell
//
//  魏远林    2015-02-10    创建
//
//

import UIKit

class HWScoreCertificateTableViewCell: HWBaseTableViewCell
{
    let cellHeight:CGFloat = 60.0
    var houseNameLab:UILabel!
    var customerNamelab:UILabel!
    var moneyLab:UILabel!
    var dateLab:UILabel!
    
    override init(style: UITableViewCellStyle, reuseIdentifier: String?)
    {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        self.selectionStyle = UITableViewCellSelectionStyle.None
        
        houseNameLab = UILabel(frame: CGRectMake(15, 10, 120, 20))
        houseNameLab?.backgroundColor = UIColor.clearColor()
        houseNameLab?.font = Define.font(TF_15)
        houseNameLab?.textColor = CD_Txt_Color_33
        self.contentView.addSubview(houseNameLab!)
        
        moneyLab = UILabel(frame: CGRectMake(kScreenWidth - 100 - 15, 10, 100, 20))
        moneyLab?.backgroundColor = UIColor.clearColor()
        moneyLab?.font = Define.font(TF_14)
        moneyLab?.textAlignment = NSTextAlignment.Center
        moneyLab?.textColor = CD_MainColor
        self.contentView.addSubview(moneyLab!)
        
        customerNamelab = UILabel(frame: CGRectMake(15, 38, 90, 20))
        customerNamelab?.backgroundColor = UIColor.clearColor()
        customerNamelab?.font = Define.font(TF_12)
        customerNamelab?.textColor = CD_Txt_Color_99
        self.contentView.addSubview(customerNamelab!)
        
        dateLab = UILabel(frame: CGRectMake(115, 38, 120, 20))
        dateLab?.backgroundColor = UIColor.clearColor()
        dateLab?.font = Define.font(TF_14)
        dateLab?.textColor = CD_Txt_Color_99
        self.contentView.addSubview(dateLab!)
    }
    
    /**
    *	@brief	重写坐标
    *
    *	@param  model:HWScoreModel
    *
    *	@return	N/A
    */
    func setValueOfContentView(scoreModel:HWScoreCFOModel)
    {
        var houseNameStr = scoreModel.name
        var customerNameStr = scoreModel.clientName
//        var moneyStr = "￥\(scoreModel.payValue!)元"
        var moneyStr = Utility.setYuanAttibuteString(scoreModel.payValue!, font: TF_14)
//        var dateStr = scoreModel.dateTime!
        var dateStr = Utility.getTimeFormattWithTimeStamp(scoreModel.dateTime!)
        
        var moneySize = Utility.calculateStringSize(moneyStr, textFont: moneyLab.font, constrainedSize: CGSizeMake(1000, 20))
        moneyLab?.frame = CGRectMake(kScreenWidth - 20 - moneySize.width, (cellHeight - moneySize.height) / 2, moneySize.width, moneySize.height)
        moneyLab?.text = moneyStr
        
        customerNamelab?.text = customerNameStr
        let customerNameSize = Utility.calculateStringSize(customerNamelab.text!, textFont: customerNamelab.font, constrainedSize: CGSizeMake(kScreenWidth - 20 - moneySize.width, 20))
        
        var houseNameSize = Utility.calculateStringSize(houseNameStr!, textFont: self.houseNameLab.font, constrainedSize: CGSizeMake(kScreenWidth - 30 - 10 - moneySize.width, 20))
        houseNameLab?.frame = CGRectMake(15, 10, houseNameSize.width, houseNameSize.height)
        houseNameLab?.text = houseNameStr
        
        customerNamelab?.frame = CGRectMake(15, 30, customerNameSize.width, 20)
        
        var dateSize = Utility.calculateStringSize(dateStr, textFont: dateLab.font, constrainedSize: CGSizeMake(1000, 20))
        dateLab?.frame = CGRectMake(CGRectGetMaxX(customerNamelab.frame) + 10, CGRectGetMaxY(houseNameLab.frame) + 4, dateSize.width, dateSize.height)
        dateLab?.text = dateStr
    }
    
    
    class func setCellHeight()->CGFloat
    {
        return CGFloat(60.0)
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    required init(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        // Configure the view for the selected state
    }
}
