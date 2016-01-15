//
//  HWFlightHouseTableViewCell.swift
//  Partner-Swift
//
//  Created by gusheng on 15/3/6.
//  Copyright (c) 2015年 caijingpeng.haowu. All rights reserved.
//

import UIKit

class HWFlightHouseTableViewCell: HWBaseTableViewCell
{

    var houseNameLabel:UILabel!
    var areaLabel:UILabel!;
    var houseStatusLabel:UILabel!;
    var selectImageV:UIButton!;
    //回调函数
    typealias selectFlightHouseBlock = (selectFlag:Bool) ->Void
    var selectFlightFunc = selectFlightHouseBlock?()
    override func awakeFromNib()
    {
        super.awakeFromNib()
    }
    
    override init(style: UITableViewCellStyle, reuseIdentifier: String?)
    {
        super.init(style: style, reuseIdentifier: reuseIdentifier);
        self.userInteractionEnabled = true;
        
        //选择Image
        var selectImageFrame:CGRect = CGRectMake(kScreenWidth-15-20, (60-20)/2+2, 20, 20);
        selectImageV = UIButton(frame: selectImageFrame);
        selectImageV.setBackgroundImage(UIImage(named: "choose_3_1"), forState:UIControlState.Normal);
        self.addSubview(selectImageV);
        
        //选择按钮
        var selectBtnFrame:CGRect = CGRectMake(0, 0, kScreenWidth, 60);
        var selectBtn:UIButton = createCustomeBtn(self, "selectBtnClick:", selectBtnFrame, nil, "", "");
        selectBtn.backgroundColor = UIColor.clearColor();
        self.addSubview(selectBtn);
        
        var houseNameFrame:CGRect = CGRectMake(15, 12, kScreenWidth-30, 15);
        houseNameLabel = createCustomeLabel(houseNameFrame, CD_Txt_Color_33, "卓越广场", TF_15);
        self.contentView.addSubview(houseNameLabel);
        
        var mapImageVFrame:CGRect = CGRectMake(15, CGRectGetMaxY(houseNameLabel.frame)+5, 16, 16);
        var mapImageV:UIImageView = createCustomerImageView(mapImageVFrame, "positioning");
        self.contentView.addSubview(mapImageV);
        
        var areaLabelFrame:CGRect = CGRectMake(CGRectGetMaxX(mapImageV.frame),CGRectGetMaxY(houseNameLabel.frame)+8, kScreenWidth-CGRectGetMaxX(mapImageV.frame)-15, 15);
        areaLabel = createCustomeLabel(areaLabelFrame, CD_Txt_Color_66, "[宝山-万达]", TF_13);
        self.contentView.addSubview(areaLabel);
        
        
        var houseStatusFrame:CGRect = CGRectMake(kScreenWidth-40-15, areaLabel.frame.origin.y, 40, 15);
        houseStatusLabel = createCustomeLabel(houseStatusFrame, CD_OrangeColor, "", TF_13);
        houseStatusLabel.textAlignment = NSTextAlignment.Right;
        self.contentView.addSubview(houseStatusLabel);
        
    }
    func setFlightHouseInfo(houseInfo:HWFlightHouseMoel)->Void
    {
        houseNameLabel.text = houseInfo.houseName;
        areaLabel.text = houseInfo.houseAddress;
        if(houseInfo.housesStatus == "0")
        {
            houseStatusLabel.text = "";
        }
        else
        {
            houseStatusLabel.text = "已报备";
        }
        if(houseInfo.selectedFlag == true)
        {
             selectImageV.setImage(UIImage(named: "choose_3_2-"), forState:UIControlState.Normal);
        }
        else
        {
             selectImageV.setImage(nil, forState:UIControlState.Normal);
        }
    }
   func selectBtnClick(sender:AnyObject)->Void
    {
        var flag:Bool;
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
        if (selectFlightFunc != nil)
        {
            selectFlightFunc!(selectFlag: flag)
        }
    }
    required init(coder aDecoder: NSCoder)
    {
        fatalError("init(coder:) has not been implemented")
    }

    override func setSelected(selected: Bool, animated: Bool)
    {
        super.setSelected(selected, animated: animated)

    }

}
