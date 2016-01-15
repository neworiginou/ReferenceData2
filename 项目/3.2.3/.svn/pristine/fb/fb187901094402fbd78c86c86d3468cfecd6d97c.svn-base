//
//  HWScdHouVillageChoiceCell.swift
//  Partner-Swift
//
//  Created by niedi on 15/3/4.
//  Copyright (c) 2015年 caijingpeng.haowu. All rights reserved.
//
//  功能描述：二手房房源发布-选择小区 Cell
//
//  修改记录：
//      姓名         日期               修改内容
//      聂迪      2015-02-26           UI及数据实现
//

import UIKit

class HWScdHouVillageChoiceCell: HWBaseTableViewCell
{
    var villageNameLab: UILabel!
    var addressLab: UILabel!
    var distanceLab: UILabel!
    
    override init(style: UITableViewCellStyle, reuseIdentifier: String?)
    {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        villageNameLab = UILabel(frame: CGRectMake(10, 8, kScreenWidth - 2 * 15, 20))
        villageNameLab.font = Define.font(TF_15)
        villageNameLab.textColor = CD_Txt_Color_00
        self.contentView.addSubview(villageNameLab)
        
        addressLab = UILabel(frame: CGRectMake(villageNameLab.frame.origin.x, villageNameLab.frame.maxY + 3, kScreenWidth - 2 * 15, 20))
        addressLab.font = Define.font(TF_14)
        addressLab.textColor = CD_Txt_Color_99
        self.contentView.addSubview(addressLab)
        
        distanceLab = UILabel(frame: CGRectMake(15, 30 - 20 / 2, kScreenWidth - 2 * 15, 20))
        distanceLab.font = Define.font(TF_14)
        distanceLab.textColor = CD_Txt_Color_99
        distanceLab.textAlignment = NSTextAlignment.Right
        self.contentView.addSubview(distanceLab)
    }
    
    func setContentForModel(model: HWScdHouVillageChoiceModel)
    {
        villageNameLab.text = model.villageName
        addressLab.text = model.villageAddress
        if model.distance == "" || model.distance == "0"
        {
            distanceLab.hidden = true;
        }
        else
        {
            distanceLab.text = "\(model.distance!)m"
        }
    }
    
    class func getCellHeight() -> CGFloat
    {
        return 60
    }

    required init(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
