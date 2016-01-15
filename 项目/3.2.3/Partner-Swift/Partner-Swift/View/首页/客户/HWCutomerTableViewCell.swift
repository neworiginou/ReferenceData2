//
//  HWCutomerTableViewCell.swift
//  Partner-Swift
//
//  Created by gusheng on 15/2/20.
//  Copyright (c) 2015年 caijingpeng.haowu. All rights reserved.
//

import UIKit

protocol HWCustomerInfoDelegate
{
    func phoneClick(phoneNum:NSString)->Void;
}

class HWCutomerTableViewCell: SWTableViewCell
{
    let rightButtons = NSMutableArray()
    let leftButtons = NSMutableArray()

    var nameLabel:UILabel!;
    var clientTypeLabel:UILabel!;
    var addressLabel:UILabel!;
    var houseResourceLabel:UILabel!;
    var dateLabel:UILabel!;
    var chosenImg: UIImageView!
    var customerDelegate:HWCustomerInfoDelegate?;

    override init(style: UITableViewCellStyle, reuseIdentifier: String?)
    {
        super.init(style: style, reuseIdentifier: reuseIdentifier);
        self.userInteractionEnabled = true;
        
        var nameFrame = CGRectMake(15, 17, 60, 15);
        nameLabel = createCustomeLabel(nameFrame, CD_Txt_Color_00, "谷胜", TF_Text_15);
        nameLabel.backgroundColor = UIColor.clearColor()
        self.contentView.addSubview(nameLabel);
        
        var clientTypeFrame = CGRectMake(CGRectGetMaxX(nameLabel.frame) + 7, 5, 35, 15);
        clientTypeLabel = createCustomeLabel(clientTypeFrame, CD_Txt_Color_66, "自有", TF_Small_12);
        clientTypeLabel.backgroundColor = "#c7c7c7".UIColor;
        clientTypeLabel.textAlignment = NSTextAlignment.Center;
        clientTypeLabel.layer.cornerRadius = 2.0;
        clientTypeLabel.layer.masksToBounds = true;
        clientTypeLabel.textColor = UIColor.whiteColor();
        self.contentView.addSubview(clientTypeLabel);
        
        var houseResourceFrame = CGRectMake(15, CGRectGetMaxY(clientTypeLabel.frame)+10, kScreenWidth - 15 - 60, 25);
        houseResourceLabel = createCustomeLabel(houseResourceFrame, CD_Txt_Color_99, "中海一号", TF_13);
        self.contentView.addSubview(houseResourceLabel);
        
        var dateFrame = CGRectMake(15, CGRectGetMaxY(clientTypeLabel.frame)+10, kScreenWidth - 15 - 60, 25);
        dateLabel = createCustomeLabel(dateFrame, CD_Txt_Color_99, "今天", TF_13);
        self.contentView.addSubview(dateLabel);
        
        chosenImg = UIImageView(frame: CGRectMake(kScreenWidth - 15 - 20, houseResourceLabel.frame.minY-5, 20, 20))
        var point = chosenImg.center
        point.y = 30
        chosenImg.center = point
        chosenImg.image = UIImage(named: "choose_3_1")
        self.contentView.addSubview(chosenImg)
    }

    func setClientModel(client: HWClientModel?, sourceType type: ClientSource) -> Void
    {
     
        if (client?.clientSourceWay.length == 0)
        {
            clientTypeLabel.hidden = true
        }
        else
        {
            clientTypeLabel.hidden = false
        }
        
        nameLabel.text = client?.clientName
        clientTypeLabel.text = client?.clientSourceWay
        
        /*
        客户最新更新状态/跟进信息
        
        - 客户录入：仅进行了客户录入，显示“客户录入”
        
        - 楼盘报备：对客户进行楼盘报备，新房显示“#楼盘名称#  已报备”；二手房显示“【#小区名称#】 已匹配
        
        - 楼盘到访/下定/成交/报备失败：由系统反馈的状态，仅针对新房，显示“#楼盘名称#  #状态#”；
        
        - 楼盘保护期剩7天提醒：由系统反馈的状态，仅针对新房，显示“#楼盘名称#  到访保护期剩7天”；
        */
        
        if (client?.cStatus.length == 0)
        {
            if client?.houseState == "到访"
            {
                if client?.visitedProtectDaysRemind == "-1"
                {
                    houseResourceLabel.text = client?.houseState as? String
                }
                if client?.visitedProtectDaysRemind == "0"
                {
                    houseResourceLabel.text = client?.houseState as? String
                }
                
                if client?.visitedProtectDaysRemind.integerValue  > 0
                {
                    houseResourceLabel.text = (client?.houseState as String) + " 到访保护期剩余"+"\(client?.visitedProtectDaysRemind as String)天"
                }
            }
            else
            {
                // 仅录入客户 无房源信息 遗留问题 最好用房源id判断 客户列表中，由系统反馈的状态，用户未进入详情查看之前，状态文字字体一直为红，查看后回复正常颜色
                houseResourceLabel.text = "\(client?.houseName as String) \(client?.houseState as String)"
            }

            
        }
        else
        {
            houseResourceLabel.text = client?.cStatus;
        }

        dateLabel.text = client?.lastChangeTime
        let dateSize = Utility.calculateStringSize(dateLabel.text!, textFont: nameLabel.font, constrainedSize: CGSizeMake(1000, 25))
        dateLabel.frame = CGRectMake(15, dateLabel.frame.origin.y, dateSize.width, 25)
        
        houseResourceLabel.frame = CGRectMake(CGRectGetMaxX(dateLabel.frame), houseResourceLabel.frame.origin.y, houseResourceLabel.frame.size.width, houseResourceLabel.frame.size.height);
        houseResourceLabel.frame = CGRectMake(kScreenWidth-15-houseResourceLabel.frame.size.width, houseResourceLabel.frame.origin.y, houseResourceLabel.frame.size.width, houseResourceLabel.frame.size.height);
        houseResourceLabel.textAlignment = NSTextAlignment.Right;
        
        let nameSize = Utility.calculateStringSize(nameLabel.text!, textFont: nameLabel.font, constrainedSize: CGSizeMake(1000, 20))
        nameLabel.frame = CGRectMake(15, 8, nameSize.width, 21)
        
        let typeSize = Utility.calculateStringSize(clientTypeLabel.text!, textFont: clientTypeLabel.font, constrainedSize: CGSizeMake(1000, 20))
        clientTypeLabel.frame = CGRectMake(CGRectGetMaxX(nameLabel.frame) + 5, 10, typeSize.width + 10, 15);
        
        if (type == ClientSource.Normal)
        {
            rightButtons.removeAllObjects()
            leftButtons.removeAllObjects()
            
            rightButtons.sw_addUtilityButtonWithColor(CD_MainColor, title: "日程")
            
            if (client?.isUp.isEqualToString("1") == true)
            {
                self.contentView.backgroundColor = CD_BackGroundColor
                
                rightButtons.sw_addUtilityButtonWithColor(CD_Btn_GrayColor, title: "取消置顶")
            }
            else
            {
                self.contentView.backgroundColor = UIColor .whiteColor()
                rightButtons.sw_addUtilityButtonWithColor(CD_Btn_GrayColor, title: "置顶")
            }
            self.setRightUtilityButtons(rightButtons, withButtonWidth: 90.0)
        }
    }

    class func getIdentify() -> String
    {
        return "HWScheduleDetailCell"
    }
    
    class func getCellHeight() -> CGFloat
    {
        return 60
    }
    
    override func layoutSubviews()
    {
        super.layoutSubviews();
    }
    
    required init(coder aDecoder: NSCoder)
    {
        fatalError("init(coder:) has not been implemented")
    }

}
