//
//  HWScdHouseDetailCell.swift
//  Partner-Swift
//
//  Created by niedi on 15/3/7.
//  Copyright (c) 2015年 caijingpeng.haowu. All rights reserved.
//
//  功能描述：二手房房源详情 Cell
//
//  修改记录：
//      姓名         日期               修改内容
//      聂迪      2015-02-26           UI及数据实现
//

import UIKit

class HWScdHouseDetailCell: HWBaseTableViewCell
{
    var leftTxtLab: UILabel! //左标签
    var appointNumLab: UILabel! //预约人数lab
    var jmpImg: UIImageView! //右跳转尖角
    
    var _model: HWScdHouseDetailModel!
    
    //MARK: init Method
    override init(style: UITableViewCellStyle, reuseIdentifier: String?)
    {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        leftTxtLab = UILabel(frame: CGRectMake(15, 0, 80, 45))
        leftTxtLab.font = Define.font(TF_15)
        leftTxtLab.textColor = CD_Txt_Color_00
        self.contentView.addSubview(leftTxtLab)
        
        appointNumLab = UILabel(frame: CGRectMake(15, 0, kScreenWidth - 2 * 15 - 13, 45))
        appointNumLab.textColor = CD_Txt_Color_00
        appointNumLab.font = Define.font(TF_15)
        appointNumLab.textAlignment = NSTextAlignment.Right
        self.contentView.addSubview(appointNumLab)
        
        jmpImg = UIImageView(frame: CGRectMake(kScreenWidth - 15 - 8, (45 - 13) / 2, 8, 13))
        jmpImg.image = UIImage(named: "arrow_next")
        self.contentView.addSubview(jmpImg)
        
        self.drawBottomLine()
        self.drawTopLine()
    }
    
    func setContent(model: HWScdHouseDetailModel)
    {
        _model = model
        if(_model.whichOne == "Mine")
        {
            leftTxtLab.text = "预约人数"
            appointNumLab.text = _model.scdHouseCount == "" ? "0" : _model.scdHouseCount
        }
        else if(_model.myAppoint == "yes")
        {
            leftTxtLab.text = "房源投诉"
            
            if(_model.complaint == "0")
            {
                appointNumLab.text = ""
            }
            else
            {
                appointNumLab.text = "已投诉"
            }
        }
    }

    required init(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
}
