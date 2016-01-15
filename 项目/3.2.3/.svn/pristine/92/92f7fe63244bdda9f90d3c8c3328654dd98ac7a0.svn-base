//
//  HWScoreHouseTableViewCell.swift
//  HaoWuPartner
//
//  Created by WeiYuanlin on 15/2/9.
//  Copyright (c) 2015年 WeiYuanlin. All rights reserved.
//  功能描述：我的业绩—房产tableviewcell
//
//  魏远林    2015-02-09    创建
//
//

import UIKit

class HWScoreHouseTableViewCell: HWBaseTableViewCell
{
    let cellHeight:CGFloat = 60.0
    var houseNameLab:UILabel!
    var houseTypeLab:UILabel!
    var customerNamelab:UILabel!
    var moneyLab:UILabel!
    var dateLab:UILabel!
    var statusLab:UILabel!
    
    override init(style: UITableViewCellStyle, reuseIdentifier: String?)
    {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        self.selectionStyle = UITableViewCellSelectionStyle.None
        
        houseNameLab = UILabel(frame: CGRectMake(15, 10, 120, 20))
        houseNameLab.backgroundColor = UIColor.clearColor()
        houseNameLab.font = Define.font(TF_15)
        houseNameLab.textColor = CD_Txt_Color_33
        self.contentView.addSubview(houseNameLab!)
        
        houseTypeLab = UILabel(frame: CGRectZero)
        houseTypeLab.textColor = UIColor.whiteColor()
        houseTypeLab.layer.cornerRadius = 3.0
        houseTypeLab.layer.masksToBounds = true
        houseTypeLab.font = UIFont.boldSystemFontOfSize(15)
        houseTypeLab.textAlignment = NSTextAlignment.Center
        self.contentView.addSubview(houseTypeLab!)
        
        customerNamelab = UILabel(frame: CGRectMake(15, 41, 90, 20))
        customerNamelab.backgroundColor = UIColor.clearColor()
        customerNamelab.font = Define.font(TF_12)
        customerNamelab.textColor = CD_Txt_Color_99
        self.contentView.addSubview(customerNamelab!)
        
        moneyLab = UILabel(frame: CGRectMake(kScreenWidth - 100 - 15, 10, 100, 20))
        moneyLab.backgroundColor = UIColor.clearColor()
        moneyLab.font = Define.font(TF_14)
        moneyLab.textAlignment = NSTextAlignment.Center
        moneyLab.textColor = CD_MainColor
        self.contentView.addSubview(moneyLab!)
        
        dateLab = UILabel(frame: CGRectMake(45, 41, 120, 20))
        dateLab.backgroundColor = UIColor.clearColor()
        dateLab.font = Define.font(TF_12)
        dateLab.textColor = CD_Txt_Color_99
        self.contentView.addSubview(dateLab!)
        
        statusLab = UILabel(frame: CGRectMake(kScreenWidth - 60, CGRectGetMaxY(moneyLab!.frame), 55, 20))
        statusLab.backgroundColor = UIColor.clearColor()
        statusLab.textAlignment = NSTextAlignment(rawValue: 2)!
        statusLab.font = Define.font(TF_12)
        statusLab.textColor = CD_Txt_Color_99
        self.contentView.addSubview(statusLab!)
        
    }
    
/**
 *	@brief	重写坐标
 *
 *	@param  model:HWScoreModel
 *
 *	@return	N/A
 */
    func setValueOfContentView(scoreModel:HWScoreHouseModel)
    {
        var houseNameStr = scoreModel.name                      //第一行 左
        var houseTypeStr = scoreModel.houseType                 //第一行 中
        var customerNameStr = scoreModel.clientName             //第二行 左
//        var moneyStr = "￥\(scoreModel.payValue!)元"              //第一行 右
        var moneyStr = Utility.setYuanAttibuteString(scoreModel.payValue!, font: TF_14)
//        var dateStr = scoreModel.dateTime!                      //第二行 中
        var dateStr = Utility.getTimeFormattWithTimeStamp(scoreModel.dateTime!)
        var statusStr = scoreModel.status                       //第二行 右
        
        
        moneyLab.text = moneyStr
        let moneySize = Utility.calculateStringSize(moneyLab.text!, textFont: moneyLab.font, constrainedSize: CGSizeMake(CGFloat.max, 20))
        moneyLab.frame = CGRectMake(kScreenWidth - 15 - moneySize.width, 12, moneySize.width, 20)
        
        if houseTypeStr == "新"
        {
            houseTypeLab.backgroundColor = CD_GreenColor
        }
        else if houseTypeStr == "二手" || houseTypeStr == ""
        {
            houseTypeLab.backgroundColor = CD_OrangeColor
        }
        houseTypeLab.text = houseTypeStr
        let houseTypeSize = Utility.calculateStringSize(houseTypeLab.text!, textFont: houseTypeLab.font, constrainedSize: CGSizeMake(CGFloat.max, 20))
        
        houseNameLab.text = houseNameStr
        let houseNameSize = Utility.calculateStringSize(houseNameLab.text!, textFont: houseNameLab.font, constrainedSize: CGSizeMake(kScreenWidth - 15 - moneySize.width - 10 - houseTypeSize.width - 15, 20))
        houseNameLab.frame = CGRectMake(15, 12, houseNameSize.width, 20)
        
        houseTypeLab.frame = CGRectMake(20 + houseNameSize.width, 12, houseTypeSize.width, 20)
        
        
        
//        if statusStr == "已结佣"
//        {
//            statusLab.text = "已结佣"
//        }
//        else if statusStr == "未结佣"
//        {
//            statusLab.text = "未结佣"
//        }
        var statusSize: CGSize = CGSizeMake(0, 0)
         statusLab.text = statusStr
        if statusLab.text != nil
        {
            statusSize = Utility.calculateStringSize(statusLab.text!, textFont: statusLab.font, constrainedSize: CGSizeMake(CGFloat.max, 20))
           
        }
        
        statusLab.frame = CGRectMake(kScreenWidth - 15 - 100, 33, 100, 20)
       
        dateLab.text = dateStr
        let dateSize = Utility.calculateStringSize(dateLab.text!, textFont: dateLab.font, constrainedSize: CGSizeMake(CGFloat.max, 20))
        
        customerNamelab.text = customerNameStr
        let customerNameSize = Utility.calculateStringSize(customerNamelab.text!, textFont: customerNamelab.font, constrainedSize: CGSizeMake(kScreenWidth - 30 - 10 - dateSize.width - statusSize.width, 20))
        customerNamelab.frame = CGRectMake(15, 33, customerNameSize.width, 20)
        dateLab.frame = CGRectMake(20 + customerNameSize.width, 33, dateSize.width, 20)
        
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
