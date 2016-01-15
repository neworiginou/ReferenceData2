//
//  HWSelectCustomerTableViewCell.swift
//  Partner-Swift
//
//  Created by gusheng on 15/3/2.
//  Copyright (c) 2015年 caijingpeng.haowu. All rights reserved.
//

import UIKit
class HWSelectCustomerTableViewCell: UITableViewCell
{
    var nameLabel:UILabel!;
    var clientTypeLabel:UILabel!;
    var addressLabel:UILabel!;
    var houseResourceLabel:UILabel!;
    var statusLabel:UILabel!;
    var dateLabel:UILabel!;
    var selectImageV:UIButton!;
    //回调函数
    typealias selectCustomerBlock = (selectFlag:Bool) ->Void
    var myFunc = selectCustomerBlock?()
    override func awakeFromNib()
    {
        super.awakeFromNib()
    }

    override func setSelected(selected: Bool, animated: Bool)
    {
        super.setSelected(selected, animated: animated)

    }
    override init(style: UITableViewCellStyle, reuseIdentifier: String?)
    {
        super.init(style: style, reuseIdentifier: reuseIdentifier);
        self.userInteractionEnabled = true;
        //选择Image
        var selectImageFrame:CGRect = CGRectMake(15, (60-20)/2, 20, 20);
        selectImageV = UIButton(frame: selectImageFrame);
        selectImageV.setBackgroundImage(UIImage(named: "choose_3_1"), forState:UIControlState.Normal);
        self.addSubview(selectImageV);
        
        //选择按钮
        var selectBtnFrame:CGRect = CGRectMake(0, 0, kScreenWidth, 75);
        var selectBtn:UIButton = createCustomeBtn(self, "selectBtnClick:", selectBtnFrame, nil, "", "");
        selectBtn.backgroundColor = UIColor.clearColor();
        self.contentView.addSubview(selectBtn);
        
        var nameFrame = CGRectMake(CGRectGetMaxX(selectImageV.frame)+10, 17, 60, 15);
        nameLabel = createCustomeLabel(nameFrame, CD_Txt_Color_00, "谷胜", TF_Text_15);
        nameLabel.backgroundColor = UIColor.clearColor()
        self.contentView.addSubview(nameLabel);
        
        var clientTypeFrame = CGRectMake(CGRectGetMaxX(nameLabel.frame) + 7, 5, 35, 15);
        clientTypeLabel = createCustomeLabel(clientTypeFrame, CD_Txt_Color_66, "自有", TF_Small_12);
        clientTypeLabel.backgroundColor = "#b2b2b2".UIColor;
        clientTypeLabel.textAlignment = NSTextAlignment.Center;
        clientTypeLabel.layer.cornerRadius = 2.0;
        clientTypeLabel.layer.masksToBounds = true;
        clientTypeLabel.textColor = UIColor.whiteColor();
        self.contentView.addSubview(clientTypeLabel);
        
        var houseResourceFrame = CGRectMake(CGRectGetMaxX(selectImageV.frame)+10, CGRectGetMaxY(clientTypeLabel.frame)+10, kScreenWidth - 15 - 60, 25);
        houseResourceLabel = createCustomeLabel(houseResourceFrame, CD_Txt_Color_99, "中海一号", TF_13);
        self.contentView.addSubview(houseResourceLabel);
        
        var dateFrame = CGRectMake(CGRectGetMaxX(selectImageV.frame)+10, CGRectGetMaxY(clientTypeLabel.frame)+10, kScreenWidth - 15 - 60, 25);
        dateLabel = createCustomeLabel(dateFrame, CD_Txt_Color_99, "今天", TF_13);
        self.contentView.addSubview(dateLabel);
        
    }
    func selectBtnClick(sender:AnyObject)->Void
    {
        var flag:Bool;
        flag = false
        if(selectImageV?.imageForState(UIControlState.Normal) == nil)
        {
            selectImageV.setImage(UIImage(named: "choose_3_2-"), forState:UIControlState.Normal);
            flag = true;
        }
        else
        {
            selectImageV.setImage(nil, forState:UIControlState.Normal);
            flag = false;
        }
        if (myFunc != nil)
        {
            myFunc!(selectFlag: flag)
        }
    }
    func didMakeData(model:HWClientModel)
    {
        
        if (model.clientSourceWay.length == 0)
        {
            clientTypeLabel.hidden = true
        }
        else
        {
            clientTypeLabel.hidden = false
        }
        
        nameLabel.text = model.clientName
        clientTypeLabel.text = model.clientSourceWay
        dateLabel.text = model.lastChangeTime
        
        let dateSize = Utility.calculateStringSize(dateLabel.text!, textFont: nameLabel.font, constrainedSize: CGSizeMake(1000, 25))
        dateLabel.frame = CGRectMake(CGRectGetMaxX(selectImageV.frame)+10, houseResourceLabel.frame.origin.y, dateSize.width, 25)
        
        houseResourceLabel.frame = CGRectMake(CGRectGetMaxX(dateLabel.frame), houseResourceLabel.frame.origin.y, houseResourceLabel.frame.size.width, houseResourceLabel.frame.size.height);
        
        /*
        客户最新更新状态/跟进信息
        
        - 客户录入：仅进行了客户录入，显示“客户录入”
        
        - 楼盘报备：对客户进行楼盘报备，新房显示“#楼盘名称#  已报备”；二手房显示“【#小区名称#】 已匹配
        
        - 楼盘到访/下定/成交/报备失败：由系统反馈的状态，仅针对新房，显示“#楼盘名称#  #状态#”；
        
        - 楼盘保护期剩7天提醒：由系统反馈的状态，仅针对新房，显示“#楼盘名称#  到访保护期剩7天”；
        */
        
        if (model.cStatus.length == 0)
        {
            // 仅录入客户 无房源信息 遗留问题 最好用房源id判断 客户列表中，由系统反馈的状态，用户未进入详情查看之前，状态文字字体一直为红，查看后回复正常颜色
            houseResourceLabel.text = "\(model.houseName as String) \(model.houseState as String)"
        }
        else
        {
            houseResourceLabel.text = model.cStatus
        }

        
        let nameSize = Utility.calculateStringSize(nameLabel.text!, textFont: nameLabel.font, constrainedSize: CGSizeMake(1000, 20))
        nameLabel.frame = CGRectMake(CGRectGetMaxX(selectImageV.frame)+10, 5, nameSize.width, 21)
        
        let typeSize = Utility.calculateStringSize(clientTypeLabel.text!, textFont: clientTypeLabel.font, constrainedSize: CGSizeMake(1000, 20))
        clientTypeLabel.frame = CGRectMake(CGRectGetMaxX(nameLabel.frame) + 5,8, typeSize.width + 10, 15)
    }
    required init(coder aDecoder: NSCoder)
    {
        fatalError("init(coder:) has not been implemented")
    }
    
}
