//
//  HWRedPaperTableViewCell.swift
//  Partner-Swift
//
//  Created by gusheng on 15/5/21.
//  Copyright (c) 2015年 caijingpeng.haowu. All rights reserved.
//

import UIKit

class HWRedPaperTableViewCell: HWBaseTableViewCell {

    let cellHeight:CGFloat = 80.0
    
    var headImageV:UIImageView!
    var titleLab:UILabel!
    var timeLab:UILabel!
    var moneyLab:UILabel!
    
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        headImageV = UIImageView(frame: CGRectMake(15 , 20, 35, 40))
        headImageV.contentMode = UIViewContentMode.ScaleAspectFit
        headImageV?.backgroundColor = UIColor.clearColor()
        self.contentView.addSubview(headImageV)
        
        titleLab = UILabel(frame: CGRectMake(CGRectGetMaxX(headImageV.frame) + 15, 20, kScreenWidth - 120, 15))
        titleLab?.font = Define.font(TF_15)
        titleLab?.backgroundColor = UIColor.clearColor()
        titleLab?.textColor = CD_Txt_Color_00
        titleLab.textAlignment = NSTextAlignment.Left;
        self.contentView.addSubview(titleLab)
        
        timeLab = UILabel(frame: CGRectMake(CGRectGetMaxX(headImageV.frame) + 15, CGRectGetMaxY(titleLab.frame) + 11, kScreenWidth - 120, 14))
        timeLab.font = Define.font(TF_14)
        timeLab.backgroundColor = UIColor.clearColor()
        timeLab.textColor = CD_Txt_Color_99
        titleLab.textAlignment = NSTextAlignment.Left;
        self.contentView.addSubview(timeLab)
        
        moneyLab = UILabel(frame: CGRectMake(kScreenWidth - 60, (cellHeight - 15) / 2.0, 40, 15))
        moneyLab.font = Define.font(TF_15)
        moneyLab.backgroundColor = UIColor.clearColor()
        moneyLab.textColor = CD_MainColor;
        moneyLab.textAlignment = NSTextAlignment.Right;
        self.contentView.addSubview(moneyLab)
    }

    func setValueForContentView(model:HWRedPaperModel)
    {
        /*
        type = dic.stringObjectForKey("status")
        money = dic.stringObjectForKey("rewardMoney")
        time = dic.stringObjectForKey("rewardTime")
        title = dic.stringObjectForKey("activityName")
        */
        titleLab.text = model.title
        moneyLab.text = "￥\(model.money)"
//        if model.type == "0"
//        {
            //未过期
            headImageV.image = UIImage(named: "wallet_icon2");
            moneyLab.hidden = true;
//        }
//        else
//        {
//            //过期
//            headImageV.image = UIImage(named: "wallet_icon3");
//            moneyLab.hidden = true;
//        }
        timeLab.text = model.time;
    }
    required init(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

}
