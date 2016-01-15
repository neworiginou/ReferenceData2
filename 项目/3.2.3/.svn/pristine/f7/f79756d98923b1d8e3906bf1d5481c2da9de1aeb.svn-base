//
//  HWHasBaoBeiVC.swift
//  Partner-Swift
//
//  Created by niedi on 15/3/28.
//  Copyright (c) 2015年 caijingpeng.haowu. All rights reserved.
//

import UIKit

class HWHasBaoBeiVC: HWBaseViewController
{
    var houseId : NSString! = ""
    
    override func viewDidLoad()
    {
        super.viewDidLoad()
        
        self.navigationItem.titleView = Utility.navTitleView("已报备客户")
        
        var mainView = HWHasBaoBeiView(frame: CGRectMake(0, 0, kScreenWidth, contentHeight), houseId: houseId)
        self.view.addSubview(mainView)
    }
}




class HasBaoBeiCell: UITableViewCell {
    var nameLabel : UILabel!
    var houseLabel : UILabel!
    var dateLabel : UILabel!
    var statusLabel : UILabel!
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        nameLabel = UILabel(frame: CGRectMake(15, 10, kScreenWidth - 20, 15))
        nameLabel.font = Define.font(15)
        self.addSubview(nameLabel)
        
        houseLabel = UILabel(frame: CGRectMake(15, 35, kScreenWidth - 20, 13))
        houseLabel.font = Define.font(13)
        houseLabel.textColor = "999999".UIColor
        self.addSubview(houseLabel)
        
        dateLabel = UILabel(frame: CGRectMake(15, 55, kScreenWidth - 20, 13))
        dateLabel.font = Define.font(13)
        dateLabel.textColor = "999999".UIColor
        self.addSubview(dateLabel)
        
        statusLabel = UILabel(frame: CGRectMake(kScreenWidth - 15 - 100, 0, 100, 80))
        statusLabel.font = Define.font(15)
        statusLabel.textAlignment = NSTextAlignment.Right
        statusLabel.textColor = UIColor.orangeColor()
        self.addSubview(statusLabel)
    }
    
    func fill(model : HasBaoBeiModel)
    {
        nameLabel.text = model.clientName as? String
        houseLabel.text = model.houseName as? String
        dateLabel.text = Utility.getTimeFormattWithTimeStamp( model.lastChangeTime!) as String
        if model.status == "filing"
        {
            statusLabel.text = "报备"
        }else if model.status == "look"
        {
            statusLabel.text = "带看"
        }else if model.status == "buy"
        {
            statusLabel.text = "下定"
        }else if model.status == "brokerage"
        {
            statusLabel.text = "结佣"
        }else if model.status == "deal"
        {
            statusLabel.text = "成交"
        }else if model.status == "visited"
        {
            statusLabel.text = "到访"
        }else{
            statusLabel.text = " "
        }
        
        
        
    }
    
    required init(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

class HasBaoBeiModel : NSObject
{
    var clientInfoId : NSString?
    var clientName : NSString?
    var houseName : NSString?
    var lastChangeTime : NSString?
    var status : NSString?
    
    init(dict : NSDictionary)
    {
        super.init()
        clientInfoId = dict.stringObjectForKey("clientInfoId")
        clientName = dict.stringObjectForKey("clientName")
        houseName = dict.stringObjectForKey("houseName")
        lastChangeTime = dict.stringObjectForKey("lastChangeTime")
        status = dict.stringObjectForKey("status")
        
    }
}