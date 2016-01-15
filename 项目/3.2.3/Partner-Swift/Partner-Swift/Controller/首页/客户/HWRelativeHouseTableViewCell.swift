//
//  HWRelativeHouseTableViewCell.swift
//  Partner-Swift
//
//  Created by gusheng on 15/3/4.
//  Copyright (c) 2015年 caijingpeng.haowu. All rights reserved.
//

import UIKit

class HWRelativeHouseTableViewCell: HWScdHouseCell
{
     var selectImageV:UIButton!;
    //回调函数
    typealias selectSecondHouseBlock = (selectFlag:Bool) ->Void
    var selectSecondHouseFunc = selectSecondHouseBlock?()
    override func awakeFromNib()
    {
        super.awakeFromNib()
    }
    override init(style: UITableViewCellStyle, reuseIdentifier: String?)
    {
        super.init(style: style, reuseIdentifier: reuseIdentifier);
        appointNumLab.hidden = true;
        appointImg.hidden = true;
        statusImg.hidden = true;
        
        //选择Image
        var selectImageFrame:CGRect = CGRectMake(kScreenWidth-15-20, (60-20)/2+15, 20, 20);
        selectImageV = UIButton(frame: selectImageFrame);
        selectImageV.setBackgroundImage(UIImage(named: "choose_3_1"), forState:UIControlState.Normal);
        self.addSubview(selectImageV);
        
        //选择按钮
        var selectBtnFrame:CGRect = CGRectMake(0, 0, kScreenWidth, 60);
        var selectBtn:UIButton = createCustomeBtn(self, "selectBtnClick:", selectBtnFrame, nil, "", "");
        selectBtn.backgroundColor = UIColor.clearColor();
        self.addSubview(selectBtn);
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
        if (selectSecondHouseFunc != nil)
        {
            selectSecondHouseFunc!(selectFlag: flag)
        }
    }
    required init(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    func setSecondHouseInfo(model: HWScdHouseModel,selectedArry:NSMutableArray)
    {
        statusImg.hidden = true;
       // headImg.backgroundColor = CD_Txt_Color_99
        weak var weakImgV: UIImageView! = headImg
          let url = NSURL(string:Utility.imageDownloadWithMongoDbKey(model.picKey))
         headImg.setImageWithURL(url, placeholderImage:Utility.getPlaceHolderImage(weakImgV.frame.size, imageName: "pic_wait_small")) { (image, error, imageCacheType) -> Void in
            if (error != nil)
            {
                let size: CGSize! = weakImgV.frame.size
                weakImgV?.image = Utility.getPlaceHolderImage(size, imageName: " pic_wait_big_no")
            }
            else
            {
                weakImgV?.image = image
            }
        }

        titleLab.text = model.title
        addressLab.text = model.villageName! + "[" + model.areaName! + " " + model.plateName! + "]"
        if addressLab.text == ""
        {
            addressLab.hidden = true
        }
        let priceStr = Utility .stringFrom(model.price)
        detailLab.text = "\(model.roomCount!)室\(model.hallCount!)厅\(model.toiletCount!)卫      \(model.proportion!)㎡    \(priceStr)"
        for(var i:Int = 0; i < selectedArry.count ;i++)
        {
            var tempValue:HWScdHouseModel = selectedArry.objectAtIndex(i) as HWScdHouseModel
            if(model.houseId  == tempValue.houseId)
            {
                model.selectedFlag = true;
           
                self.selectImageV.setImage(UIImage(named: "choose_3_2-"), forState:UIControlState.Normal);
                break;
            }
            else
            {
                  selectImageV.setImage(nil, forState:UIControlState.Normal);
            }
        }
    }
    func setCollectionHouseInfo(model: HWScdHouseModel,selectedArry:NSMutableArray)
    {
       // headImg.backgroundColor = CD_Txt_Color_99
        weak var weakImgV: UIImageView! = headImg
        let url = NSURL(string:Utility.imageDownloadWithMongoDbKey(model.picKey))
        headImg.setImageWithURL(url, placeholderImage: Utility.getPlaceHolderImage(weakImgV.frame.size, imageName: "pic_wait_small")) { (image, error, imageCacheType) -> Void in
            if (error != nil)
            {
                let size: CGSize! = weakImgV.frame.size
                weakImgV?.image = Utility.getPlaceHolderImage(size, imageName: " pic_wait_big_no")
            }
            else
            {
                weakImgV?.image = image
            }
        }

        titleLab.text = model.title
         let priceStr = Utility .stringFrom(model.price)
        addressLab.text = model.villageName! + "[" + model.areaName! + " " + model.plateName! + "]"
        detailLab.text = "\(model.roomCount!)室\(model.hallCount!)厅\(model.toiletCount!)卫     \(model.proportion!)㎡    \(priceStr)"
        
        for(var i:Int = 0; i < selectedArry.count ;i++)
        {
            var tempValue:HWScdHouseModel = selectedArry.objectAtIndex(i) as HWScdHouseModel
            if(model.houseId == tempValue.houseId)
            {
                model.selectedFlag = true;
                self.selectImageV.setImage(UIImage(named: "choose_3_2-"), forState:UIControlState.Normal);
                break;
            }
            else
            {
                 selectImageV.setImage(nil, forState:UIControlState.Normal);
            }
        }

    }
    override func setSelected(selected: Bool, animated: Bool)
    {
        super.setSelected(selected, animated: animated)

    }

}
