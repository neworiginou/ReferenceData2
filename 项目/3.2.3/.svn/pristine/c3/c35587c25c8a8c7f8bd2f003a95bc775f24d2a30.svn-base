
//
//  HWFloggingCustomerTableViewCell.swift
//  Partner-Swift
//
//  Created by wuxiaohong on 15/2/26.
//  Copyright (c) 2015年 caijingpeng.haowu. All rights reserved.
//

import UIKit
protocol HWFloggingCustomerTableViewCellDelegate
{
    func didSelecttedBtn(index:String)
}
class HWFloggingCustomerTableViewCell: UITableViewCell,UITextViewDelegate {
    var didSelectedBtnDelegate:HWFloggingCustomerTableViewCellDelegate?
    let kAgentLeft:CGFloat = 15
    let backGroundView  = UIView()
    var buyHouseView = UIView()
    var arrowImageV = UIImageView();
    var typeView = UIView()
    var scopeView = UIView()
    var houseTypeView = UIView()
    var PriceAndAreaView = UIView()
    var houseTagView = UIView()
    var remarkView = UIView();
    var remarkTextV = UITextView();
    var flag:Bool! = false;
    var currentSize:CGRect! = CGRectZero;
    var areaMoreSelectedArry = NSMutableArray()
    var houseLabelArry = NSMutableArray()
    var houseLabelSStr = String()
    var remarkContentStr = String()
    var houseInfoArry = NSMutableArray()
    var typeDataArry = NSMutableArray()
    var areaDataArry = NSMutableArray()
    var agentClientModel:HWAgentCustomerDetailModel = HWAgentCustomerDetailModel()
    var houseTagLabel = UILabel()
    var houseLowerLabel = UILabel()
    var houseupperLabel = UILabel()
    var priceLowerLabel = UILabel()
    var priceUpperLabel = UILabel()
    var submitBtn = UIButton()
    var mySlider = HWTotalPriceRangeSlider()
    var mySliderArea = HWNMRangeSlider()
    var line = UIImageView()
     var line1 = UIImageView()
    var houseTagsArry = NSMutableArray()
    override func awakeFromNib()
    {
        super.awakeFromNib()
        
    }
    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        
    }
    init(style: UITableViewCellStyle, reuseIdentifier: String?,agentModel:HWAgentCustomerDetailModel)
    {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        backGroundView.frame = CGRectMake(0, 0, kScreenWidth, 770 * kRate)
        backGroundView.backgroundColor = CD_BackGroundColor
        self.addSubview(backGroundView)
        
        
        var tapgesture:UITapGestureRecognizer  = UITapGestureRecognizer(target: self, action: "tapBack");
        backGroundView.addGestureRecognizer(tapgesture);
        
        
        houseInfoArry = ["住宅","不限","不限","0-不限","0-不限"]
        typeDataArry = ["不限","一室","二室","三室","四室","五室以上"]
        agentClientModel = agentModel;
        if agentClientModel.clientInfoId == nil
        {
         // agentClientModel.buyHousepurpose?.houseTypeArry = ["商住","不限","三室","100-200","0-无限"]
         }
       else
        {
            if agentClientModel.buyHousepurpose.houseTypeArry.count == 0
            {
                agentClientModel.buyHousepurpose.houseTypeArry = ["住宅","不限","不限","0-不限","0-不限"]
                 houseInfoArry = NSMutableArray (array: agentClientModel.buyHousepurpose.houseTypeArry)
                
                
            }
            
            else
            {
                houseInfoArry = NSMutableArray (array: agentClientModel.buyHousepurpose.houseTypeArry)
            }
        }
        self.contentView.backgroundColor = CD_BackGroundColor
        self.backgroundColor = CD_BackGroundColor
        self .createBuyHouseView(backGroundView)
        self .createTypeView(backGroundView)
        self .createHouseType(backGroundView)
        self .createTotalPriceAndAreaView(backGroundView)
        self .createScopeView(backGroundView)
        self .createHouseTag(backGroundView)
        //add by gusheng
        self.createRemarkView(backGroundView)
        //end
        self .createSubmitBtn(backGroundView)
        self.hidePopView();
    }
    func tapBack()->Void
    {
        remarkTextV.resignFirstResponder();
    }
    //MARK:创建提交按钮
    func createSubmitBtn(backGroundViewTemp:UIView)
    {
        submitBtn.frame = CGRectMake(kAgentLeft, CGRectGetMaxY(remarkView.frame), kScreenWidth-2*kAgentLeft, 45)
        submitBtn.titleLabel?.font = Define.font(19)
        submitBtn.tintColor = UIColor .whiteColor()
        submitBtn .setTitle("提交", forState: .Normal)
        submitBtn.layer.cornerRadius = 5
        submitBtn.layer.masksToBounds = true
        submitBtn .addTarget(self, action: "submitBtn", forControlEvents: .TouchUpInside)
        submitBtn .setBackgroundImage(Utility .imageWithColor(CD_MainColor, _size: CGSizeMake(kScreenWidth-2 * kAgentLeft, 45)), forState: .Normal)
        backGroundViewTemp .addSubview(submitBtn)
        backGroundView.frame = CGRectMake(0,0, kScreenWidth, CGRectGetMaxY(submitBtn.frame)+20);
    }
    //MARK:隐藏显示意向视图
    func hidePopView()->Void
    {
        if(!flag)
        {
            typeView.hidden = true;
            scopeView.hidden = true;
            houseTypeView.hidden = true;
            PriceAndAreaView.hidden = true;
            houseTagView.hidden = true;
           
            arrowImageV.image = UIImage(named: "arrow_up");
            submitBtn.frame = CGRectMake(kAgentLeft, CGRectGetMaxY(buyHouseView.frame)+20, kScreenWidth-2*kAgentLeft, 45)
        }
        else
        {
            MobClick .event("Clientrequirements_click")
            typeView.hidden = false;
            scopeView.hidden = false;
            houseTypeView.hidden = false;
            PriceAndAreaView.hidden = false;
            houseTagView.hidden = false;
            
            arrowImageV.image = UIImage(named: "arrow_down");
            submitBtn.frame = CGRectMake(kAgentLeft, CGRectGetMaxY(remarkView.frame)+20, kScreenWidth-2*kAgentLeft, 45)
        }
        flag = !flag;
    }
    //MARK:构建购房意向视图
    func createBuyHouseView(headTempView:UIView)
    {
        buyHouseView = UIView(frame:CGRectMake(0, 0, kScreenWidth, 45));
        line.backgroundColor = CD_LineColor
        buyHouseView .addSubview(line);
        line.frame = CGRectMake(0,CGRectGetMaxY(buyHouseView.frame)-0.5, kScreenWidth, 0.5)
        
        line1.backgroundColor = CD_LineColor
       
        var gesTapGesure:UITapGestureRecognizer  = UITapGestureRecognizer(target: self, action: "hidePopView");
        buyHouseView.addGestureRecognizer(gesTapGesure);
        buyHouseView.backgroundColor = UIColor.whiteColor()
        var lastLable:UILabel! = nil
        var fengLineFlag = "0"
        var jixunFlag = "0"//有两行的标识
        var houseTagLabel:UILabel! = UILabel();
        for var i  = 0 ;i<houseInfoArry.count;i++
        {
            houseTagLabel.textAlignment = NSTextAlignment.Left;
            if (lastLable != nil)
            {
                var houseTagFrame = CGRectMake(CGRectGetMaxX(lastLable.frame)+10, 15 , 100, 15);
                houseTagLabel = createCustomeLabel(houseTagFrame, CD_Txt_Color_33, houseInfoArry.objectAtIndex(Int(i))as NSString, TF_13);
                houseTagLabel.font = Define.font(13)
                houseTagLabel.textAlignment = NSTextAlignment.Left;
                houseTagLabel.textColor = CD_Txt_Color_33
                houseTagLabel.text = (houseInfoArry .objectAtIndex(i) as String)
                var factualHouseTagSize = returnLabelFactualSize(houseTagLabel, TF_13);
                houseTagLabel.frame = factualHouseTagSize;
                print(houseTagLabel.text)
                if jixunFlag == "0"
                {
                    buyHouseView.frame = CGRectMake(buyHouseView.frame.origin.x, 0, buyHouseView.frame.size.width, 45)
                    
                }
                lastLable = houseTagLabel
                if CGRectGetMaxX(houseTagLabel.frame) > kScreenWidth-30 && fengLineFlag == "0" || jixunFlag == "1"
                {
                    fengLineFlag = "1"
                    if jixunFlag == "1"
                    {
                        houseTagLabel.frame = CGRectMake(lastLable.frame.size.width+10, 30, houseTagLabel.frame.size.width, houseTagLabel.frame.size.height)
                        line1.hidden = true
                        line.hidden = false
                      
                        
                    }
                    else
                    {
                        houseTagLabel.frame = CGRectMake(15, 30, houseTagLabel.frame.size.width, houseTagLabel.frame.size.height)
                        buyHouseView.frame = CGRectMake(buyHouseView.frame.origin.x, buyHouseView.frame.origin.y, buyHouseView.frame.size.width, buyHouseView.frame.size.height+15)
                        line.hidden = true
                         line1.hidden = false
                          line1.frame = CGRectMake(0,CGRectGetMaxY(buyHouseView.frame)-0.5, kScreenWidth, 0.5)
                         buyHouseView .addSubview(line1);
                        
                        
                    }
                    lastLable = houseTagLabel
                    jixunFlag = "1"
                }
                
                
            }
                
            else
            {
                if fengLineFlag == "0"
                {
                    houseTagLabel.frame = CGRectMake(15, 15, 100, 15)
                    houseTagLabel.font = Define.font(13)
                    houseTagLabel.textColor = CD_Txt_Color_33
                    houseTagLabel.text = (houseInfoArry .objectAtIndex(i) as String)
                    
                }
                    
                else
                {
                    houseTagLabel.frame = CGRectMake(15, 30, 100, 15)
                    houseTagLabel.font = Define.font(13)
                    houseTagLabel.textColor = CD_Txt_Color_33
                    houseTagLabel.text = (houseInfoArry .objectAtIndex(i) as String)
                }
                var houseTagFactualSize:CGRect = returnLabelFactualSize(houseTagLabel, TF_13);
                houseTagLabel.frame = houseTagFactualSize;
                lastLable = houseTagLabel
            }
            
            if i < houseInfoArry.count - 1
            {
                let line = UIView(frame: CGRectMake(CGRectGetMaxX(houseTagLabel.frame)+5, houseTagLabel.frame.origin.y, 0.5, houseTagLabel.frame.size.height))
                line.backgroundColor = CD_BackGroundColor
                buyHouseView .addSubview(line)
            }
            buyHouseView .addSubview(houseTagLabel)
        }
        
        headTempView.addSubview(buyHouseView)
        
        //增加箭头图片
        arrowImageV = UIImageView(frame: CGRectMake(kScreenWidth-15-15, 0, 15, 8));
        arrowImageV.image = UIImage(named: "arrow_down");
        buyHouseView.addSubview(arrowImageV);
        
       
        arrowImageV.center = CGPointMake(arrowImageV.center.x, buyHouseView.center.y);
        
    }
    
    //MARK:创建类型
    func createTypeView(backGroudView:UIView)
    {
        typeView.frame = CGRectMake(0, CGRectGetMaxY(buyHouseView.frame), kScreenWidth, 97 * kRate)
        typeView.backgroundColor = CD_BackGroundColor
        backGroudView .addSubview(typeView)
        
        let line = UIView(frame: CGRectMake(0, 0, kScreenWidth, 0.5 * kRate))
        line.backgroundColor = CD_LineColor
       // typeView .addSubview(line)
        
        var relativeHouseLabel = UILabel(frame: CGRectMake(15, 15, kScreenWidth, 20))
        relativeHouseLabel.font = Define.font(15)
        relativeHouseLabel.text = "类型"
        relativeHouseLabel.textColor = CD_Txt_Color_99
        relativeHouseLabel.backgroundColor = CD_BackGroundColor
        typeView .addSubview(relativeHouseLabel)
        var typeDataArryTemp = ["住宅","别墅","商住"]
        self.dynamicCreatButton(typeView, dataArry: typeDataArryTemp, jianJu: 10, relativeHouseLabel: relativeHouseLabel, baseTag: 200, flag: 0)
        
        if agentClientModel != Optional.None
        {
            self .initHouseType()
        }
    }
    //MARK:初始化类型
    func initHouseType()
    {
        if agentClientModel.buyHousepurpose?.houseTypeArry?.count <= 0
        {
            return
            
        }
        
        var houseTypeStr:String = String()
        houseTypeStr = agentClientModel.buyHousepurpose?.houseTypeArry?.pObjectAtIndex(0) as String
        if houseTypeStr == "别墅/豪宅"
        {
             houseTypeStr = "别墅"
        }
        for var i = 0; i < 3; i++
        {
            var houseTypeBtn = typeView .viewWithTag(200+i) as UIButton
            if houseTypeBtn.titleLabel?.text == houseTypeStr
            {
                
                houseTypeBtn.backgroundColor = CD_OrangeColor
                houseTypeBtn.selected = true
                houseTypeBtn .setTitleColor(UIColor .whiteColor(), forState: .Normal)
            }
                
            else
            {
                
                houseTypeBtn.backgroundColor = UIColor .whiteColor()
                houseTypeBtn.selected = false
                houseTypeBtn .setTitleColor(CD_Txt_Color_33, forState: .Normal)
            }
            
        }
        
    }
    //MARK:动态创建按钮
    func dynamicCreatButton(backGround:UIView,dataArry:NSArray,jianJu:NSInteger,relativeHouseLabel:UILabel,baseTag:NSInteger,flag:NSInteger)
    {
        var j = 0
        var typeBtn:UIButton!;
        for var i = 0;i < dataArry.count;i++
        {
            if i%4 == 0 && i != 0
            {
                j++
                
            }
            typeBtn = UIButton();
            typeBtn.frame = CGRectMake(kAgentLeft+(CGFloat(jianJu)+(kScreenWidth-2*kAgentLeft-3 * CGFloat(jianJu))/4)*(CGFloat(i)-CGFloat(j)*4) , CGRectGetMaxY(relativeHouseLabel.frame)+10+(10+36)*CGFloat(j), (kScreenWidth-2*kAgentLeft-3*CGFloat(jianJu))/4, 36)
            print(typeBtn.frame)
            typeBtn.layer.cornerRadius = 3
            typeBtn.layer.masksToBounds = true
            typeBtn.backgroundColor = UIColor .whiteColor()
            typeBtn .setTitleColor(CD_Txt_Color_33, forState: .Normal)
            typeBtn.layer.borderWidth = 0.5
            typeBtn.layer.borderColor = CD_BackGroundColor.CGColor
            typeBtn .setTitle( dataArry .objectAtIndex(i) as? String, forState:.Normal)
            typeBtn.tag  = baseTag + i
            typeBtn.titleLabel?.font = Define.font(TF_13);
            backGround.addSubview(typeBtn)
            if i == 0
            {
                typeBtn.backgroundColor = CD_OrangeColor
                typeBtn.selected = true
//                println(typeBtn.frame)
                typeBtn .setTitleColor(UIColor .whiteColor(), forState: .Normal)
                
            }
            
            if dataArry.objectAtIndex(i) as String  == "五室以上"
            {
                typeBtn.frame = CGRectMake(typeBtn.frame.origin.x, typeBtn.frame.origin.y, 100, 36 * kRate)
                
            }
            if flag == 0
            {
                typeBtn .addTarget(self, action: "selectType:",forControlEvents:.TouchUpInside)
                
            }
            else if flag == 1
            {
                typeBtn .addTarget(self, action: "selectHouseType:",forControlEvents:.TouchUpInside)
            }
            else
            {
                typeBtn .addTarget(self, action: "selectArea:",forControlEvents:.TouchUpInside)
                typeBtn.tag = 300 + i
            }
        }
        backGroundView.frame = CGRectMake(0, 0, kScreenWidth, 660 + CGFloat(j) * 40)
        backGroundView.userInteractionEnabled = true;
        backGroundView.backgroundColor = CD_BackGroundColor
        scopeView.frame = CGRectMake(scopeView.frame.origin.x, scopeView.frame.origin.y, scopeView.frame.size.width, CGRectGetMaxY(typeBtn.frame)+10);
        scopeView.backgroundColor = CD_BackGroundColor;
        
    }
    //MARK:创建户型
    func createHouseType(backGroundViewTemp:UIView)
    {
        houseTypeView.frame = CGRectMake(0,CGRectGetMaxY(typeView.frame), kScreenWidth, 110 * kRate)
        houseTypeView.backgroundColor = CD_BackGroundColor
        backGroundView .addSubview(houseTypeView)
        
        var relativeHouseLabel = UILabel(frame: CGRectMake(15, 0, kScreenWidth, 20))
        relativeHouseLabel.font = Define.font(15)
        relativeHouseLabel.text = "户型"
        relativeHouseLabel.textColor = CD_Txt_Color_99
        relativeHouseLabel.backgroundColor = CD_BackGroundColor
        houseTypeView .addSubview(relativeHouseLabel)
        self .dynamicCreatButton(houseTypeView, dataArry: typeDataArry, jianJu: 10, relativeHouseLabel: relativeHouseLabel, baseTag: 100, flag: 1)
        
       if agentClientModel != Optional.None
       {
            self .initHouseTypeData()
        
        }
        
    }
    //MARK:初始化户型
    func initHouseTypeData()
    {
        if agentClientModel.buyHousepurpose?.houseTypeArry?.count <= 2
        {
            return
            
        }
        var roomNumStr:NSString = NSString()
         roomNumStr =  agentClientModel.buyHousepurpose?.houseTypeArry?.objectAtIndex(2) as String
        for var i = 0; i < typeDataArry.count; i++
        {
            var typeStr:NSString = typeDataArry .objectAtIndex(i) as String
            
            if typeStr == roomNumStr
            {
                var typeBtn = houseTypeView .viewWithTag(100+i) as UIButton
                typeBtn.backgroundColor = CD_OrangeColor
                typeBtn .setTitleColor(UIColor .whiteColor(), forState: .Normal)
                
                
            }
                
            else
            {
                let typeBtn = houseTypeView .viewWithTag(100+i) as UIButton
                typeBtn.backgroundColor = UIColor .whiteColor()
                typeBtn .setTitleColor(CD_Txt_Color_33, forState: .Normal)
            }
            
        }
    }
    //MARK:创建总价和面积视图
    func createTotalPriceAndAreaView(backGroudView:UIView)
    {
        PriceAndAreaView.frame = CGRectMake(0, CGRectGetMaxY(houseTypeView.frame)+5, kScreenWidth, 170 * kRate)
        PriceAndAreaView.backgroundColor = CD_BackGroundColor
        backGroundView .addSubview(PriceAndAreaView)
        PriceAndAreaView.userInteractionEnabled = true
        let relativeHouseLabel = UILabel(frame: CGRectMake(kAgentLeft, 15, kScreenWidth, 20 * kRate))
        relativeHouseLabel.font = Define.font(14)
        relativeHouseLabel.textColor = CD_Txt_Color_99
        relativeHouseLabel.text = "总价（万）"
        relativeHouseLabel.backgroundColor = CD_BackGroundColor
        PriceAndAreaView .addSubview(relativeHouseLabel)
        
        mySlider.frame = CGRectMake(kAgentLeft, CGRectGetMaxY(relativeHouseLabel.frame)+25, kScreenWidth-2 * kAgentLeft - 8, 30)
        mySlider.sliderType = "0"
        mySlider.userInteractionEnabled = true;
        mySlider.upperValue = 310
        mySlider.lowerValue = 0
        mySlider .addTarget(self, action: "labelSliderPriceChanged:", forControlEvents: .ValueChanged)
        PriceAndAreaView .addSubview(mySlider)
        priceLowerLabel.frame = CGRectMake(kAgentLeft, CGRectGetMaxY(relativeHouseLabel.frame)+5, 50, 20 * kRate)
        priceLowerLabel.font = Define.font(13)
        priceLowerLabel.textColor = CD_Txt_Color_33
        priceLowerLabel.text = "0"
        PriceAndAreaView .addSubview(priceLowerLabel)
        
        priceUpperLabel.frame = CGRectMake(kScreenWidth-kAgentLeft-42, CGRectGetMaxY(relativeHouseLabel.frame)+5, 55, 20 * kRate)
        priceUpperLabel.font = Define.font(13)
        priceUpperLabel.textColor = CD_Txt_Color_33
        priceUpperLabel.text = "不限"
        PriceAndAreaView .addSubview(priceUpperLabel)
        
        var areaLabel = UILabel(frame: CGRectMake(kAgentLeft, CGRectGetMaxY(mySlider.frame), kScreenWidth, 20 * kRate))
        areaLabel.text = "面积（平方米）"
        areaLabel.font = Define.font(14)
        areaLabel.textColor = CD_Txt_Color_99
        areaLabel.backgroundColor = CD_BackGroundColor
        PriceAndAreaView .addSubview(areaLabel)
        
        mySliderArea.frame = CGRectMake(kAgentLeft, CGRectGetMaxY(areaLabel.frame)+25, kScreenWidth-2 * kAgentLeft - 8, 30 * kRate)
        mySliderArea.sliderType = "1"
        mySliderArea.userInteractionEnabled = true;
        mySliderArea.addTarget(self, action: "labelSliderChanged:", forControlEvents: .ValueChanged)
        PriceAndAreaView .addSubview(mySliderArea)
        houseLowerLabel.frame = CGRectMake(kAgentLeft, CGRectGetMaxY(areaLabel.frame)+5, 50, 20 * kRate)
        houseLowerLabel.font = Define.font(13)
        houseLowerLabel.textColor = CD_Txt_Color_33
        houseLowerLabel.text = "0"
        PriceAndAreaView .addSubview(houseLowerLabel)
        
        houseupperLabel.frame = CGRectMake(kScreenWidth-kAgentLeft-42, CGRectGetMaxY(areaLabel.frame)+5, 50, 20 * kRate)
        houseupperLabel.font = Define.font(13)
        houseupperLabel.textColor = CD_Txt_Color_33
        houseupperLabel.text = "不限"
        PriceAndAreaView .addSubview(houseupperLabel)
        
        self .configureLabelSlider()
        self.configureLabelSliderOne()
    }
    //MARK:面积配置
    func configureLabelSlider()
    {
        mySliderArea.minimumValue = 0
        mySliderArea.maximumValue = 310
        mySliderArea.lowerValue = 0
        mySliderArea.upperValue = 310
        mySliderArea.minimumRange = 0
        mySliderArea.lowLastValueStr = "0"
        mySliderArea.uperLastValueStr = "不限"
        if agentClientModel != Optional.None
        {
            if agentClientModel.buyHousepurpose?.houseTypeArry?.count <= 4
            {
                return
            }
            let str = agentClientModel.buyHousepurpose?.houseTypeArry?.objectAtIndex(4) as String
            
            var areaMaxStr:NSString = str .stringByReplacingOccurrencesOfString("㎡", withString: "", options: nil, range: nil)
            var areaArry:NSArray = areaMaxStr.componentsSeparatedByString("-")
            
            var housePriceMaxStr:NSString = areaArry.pObjectAtIndex(1) as String
            var housePriceMinStr:NSString = areaArry.pObjectAtIndex(0) as String
            mySliderArea .setLowerValue(housePriceMinStr.floatValue, animated: true)
            houseLowerLabel.text = housePriceMinStr
            if housePriceMaxStr == "不限"
            {
                mySliderArea .setUpperValue(310, animated: true)
                houseupperLabel.text = "不限"
            }
                
            else
            {
                mySliderArea .setUpperValue(housePriceMaxStr.floatValue, animated: true)
                houseupperLabel.text = "\(housePriceMaxStr)㎡"
            }
              houseLowerLabel.text = "\(housePriceMinStr)㎡"
        }
    }
    
    //MARK:总价配置
    func configureLabelSliderOne()
    {
        mySlider.minimumValue = 0
        mySlider.maximumValue = 1010
        mySlider.lowerValue = 0
        mySlider.upperValue = 1010
        mySlider.minimumRange = 0
        mySlider.lowLastValueStr = "0"
        mySlider.uperLastValueStr = "不限"
        if agentClientModel != Optional.None
        {
            if agentClientModel.buyHousepurpose?.houseTypeArry?.count <= 3
            {
                return
            }
            let str = agentClientModel.buyHousepurpose?.houseTypeArry?.objectAtIndex(3) as String
            
            var totalPriceMaxStr:NSString = str .stringByReplacingOccurrencesOfString("万", withString: "", options: nil, range: nil)
            var priceArry:NSArray = totalPriceMaxStr .componentsSeparatedByString("-")
            var housePriceMaxStr:NSString = priceArry .objectAtIndex(1) as String
            var housePriceMinStr:NSString = priceArry .objectAtIndex(0) as String
            
            
            if housePriceMaxStr != "不限"
            {
                mySlider .setUpperValue(housePriceMaxStr.floatValue, animated: true)
                
            }
                
            else
            {
                mySlider .setUpperValue(1010, animated: true)
                
            }
            mySlider .setLowerValue(housePriceMinStr.floatValue, animated: true)
            if housePriceMaxStr == "不限"
            {
                priceUpperLabel.text = "不限"
            }
                
            else
            {
                
                priceUpperLabel.text = "\(housePriceMaxStr)万"
            }
            priceLowerLabel.text = "\(housePriceMinStr)万"
            
        }
    }
    //MARK:创建区域
    func createScopeView(backGroundViewTemp:UIView)
    {
        scopeView.frame = CGRectMake(0, CGRectGetMaxY(PriceAndAreaView.frame), kScreenWidth, 280 * kRate)
        scopeView.backgroundColor = CD_BackGroundColor
        backGroundViewTemp .addSubview(scopeView)
        let relativeHouseLabel = UILabel(frame: CGRectMake(kAgentLeft, 0, kScreenWidth, 20 * kRate))
        relativeHouseLabel.font = Define.font(14)
        relativeHouseLabel.textColor = CD_Txt_Color_99
        relativeHouseLabel.text = "区域"
        relativeHouseLabel.backgroundColor = CD_BackGroundColor
        scopeView .addSubview(relativeHouseLabel)
        areaDataArry  = ["不限"]
        var citys:NSMutableArray = HWUserLogin.currentUserLogin().cities
        for var i = 0;i < citys.count; i++
        {
            let cityClass:HWCityClass = citys.objectAtIndex(i) as HWCityClass
            
            if cityClass.cityId! == HWUserLogin.currentUserLogin().cityId
            {
                for var j = 0 ;j < cityClass.areas?.count;j++
                {
                    let areaModel:HWSearchAreaModel = cityClass.areas?.objectAtIndex(j) as HWSearchAreaModel
                    areaDataArry .addObject(areaModel.area_name!)
                }
            }
        }
        self.dynamicCreatButton(scopeView, dataArry: areaDataArry, jianJu: 10, relativeHouseLabel: relativeHouseLabel, baseTag: 300, flag: 2)
        if agentClientModel != Optional.None
        {
            self .initAreaData(areaDataArry)
        }
    }
    //MARK:初始化区域按钮
    func initAreaData(allAreaDataArry:NSArray)
    {
        if agentClientModel.buyHousepurpose?.houseTypeArry?.count <= 1
        {
            return
        }
        var str:NSString = agentClientModel.buyHousepurpose?.houseTypeArry?.objectAtIndex(1) as NSString
        let areaData:NSArray = str .componentsSeparatedByString(",")
        
        
        var areaStr:NSString?
        for var i = 0; i < areaData.count;i++
        {
            areaStr = areaData .objectAtIndex(i) as String
            for var j = 0; j < allAreaDataArry.count;j++
            {
                var areaBtn = scopeView .viewWithTag(300+j) as UIButton
                if areaBtn.titleLabel?.text == areaStr
                {
                    areaBtn.selected = true
                    areaBtn.backgroundColor = CD_OrangeColor
                    areaBtn .setTitleColor(UIColor .whiteColor(), forState: .Normal)
                    self .selectFilter(areaBtn)
                    
                }
            }
        }
    }
    
    func selectFilter(selectedBtn:UIButton)
    {
        if selectedBtn.titleLabel?.text == "不限"
        {
            for var i = 0; i < areaDataArry.count;i++
            {
                var typeBtn = scopeView .viewWithTag(300+i) as UIButton
                if typeBtn.titleLabel?.text != "不限"
                {
                    if typeBtn.selected == true
                    {
                        typeBtn.selected = false
                        typeBtn.backgroundColor = UIColor .whiteColor()
                        typeBtn .setTitleColor(CD_Txt_Color_33, forState: .Normal)
                    }
                }
            }
        }
        else
        {
            var typeBtn = scopeView .viewWithTag(300) as UIButton
            typeBtn.selected = false
            typeBtn.backgroundColor = UIColor .whiteColor()
            typeBtn .setTitleColor(CD_Txt_Color_33, forState: .Normal)
            
        }
    }
    //MARK:创建标签
    func createHouseTag(backGroundViewTemp:UIView)
    {
        houseTagView.frame = CGRectMake(0, CGRectGetMaxY(scopeView.frame), kScreenWidth, 45+46)
        houseTagView.backgroundColor = CD_BackGroundColor
        backGroundView .addSubview(houseTagView)
        let relativeHouseLabel = UILabel(frame: CGRectMake(kAgentLeft, 0, kScreenWidth, 20))
        relativeHouseLabel.backgroundColor = CD_BackGroundColor
        relativeHouseLabel.font = Define.font(14)
        relativeHouseLabel.textColor = CD_Txt_Color_99
        relativeHouseLabel.text = "标签"
        houseTagView .addSubview(relativeHouseLabel)
        
      
//        for var i = 0; i < houseTagsArry.count; i++
//        {
//            let signModel:HWHouseInfoModel = houseTagArry .objectAtIndex(i) as HWHouseInfoModel
//            houseTagsArry .addObject(signModel.dicItemValue!)
//        }
        houseTagsArry = ["满五年","唯一住房","学区房"]
        var j = 0
        var typeBtn:UIButton!;
        var baseTag = 800
        var jianJu:CGFloat = 10
        for var i = 0;i < houseTagsArry.count;i++
        {
            typeBtn = UIButton()
            if i % 4 == 0 && i != 0
            {
                j++
            }
            typeBtn.frame = CGRectMake(kAgentLeft+(jianJu+(kScreenWidth-2 * kAgentLeft-3 * jianJu)/4)*(CGFloat(i)-CGFloat(j)*4), CGRectGetMaxY(relativeHouseLabel.frame)+10+(10+36) * CGFloat(j), (kScreenWidth-2*kAgentLeft-3*jianJu)/4, 36)
            typeBtn.titleLabel?.font = Define.font(14)
            typeBtn.setTitleColor(CD_Txt_Color_33, forState: .Normal)
            typeBtn.layer.cornerRadius = 3
            typeBtn.layer.masksToBounds = true
            typeBtn.backgroundColor = UIColor .whiteColor()
            typeBtn.layer.borderWidth = 0.5
            typeBtn.layer.borderColor = CD_BackGroundColor.CGColor
            typeBtn .setTitle(houseTagsArry .objectAtIndex(i) as? String, forState: .Normal)
            typeBtn.titleLabel?.font = Define.font(TF_13);
            typeBtn.tag = baseTag+i
            houseTagView .addSubview(typeBtn)
            typeBtn .addTarget(self, action: "selctHouseTag:", forControlEvents: .TouchUpInside)
        }
        if j>1
        {
            backGroundView.frame = CGRectMake(0, 0, kScreenWidth, backGroundView.frame.size.height)
            
        }
        
        if agentClientModel != Optional.None
        {
            self .initSelectedLabel()
        }
        currentSize = backGroundView.frame;
        
    }
    func createRemarkView(backGroundViewTemp:UIView)->Void
    {
        remarkView.frame = CGRectMake(0, CGRectGetMaxY(houseTagView.frame), kScreenWidth, 110 * kRate)
        remarkView.backgroundColor = CD_BackGroundColor
        backGroundViewTemp .addSubview(remarkView)
        
        let relativeHouseLabel = UILabel(frame: CGRectMake(kAgentLeft, 0, kScreenWidth, 20 * kRate))
        relativeHouseLabel.font = Define.font(14)
        relativeHouseLabel.textColor = CD_Txt_Color_99
        relativeHouseLabel.text = "备注"
        relativeHouseLabel.backgroundColor = CD_BackGroundColor
        remarkView .addSubview(relativeHouseLabel)
        
        remarkTextV.delegate = self;
        remarkTextV.frame = CGRectMake(15, 20 * kRate, kScreenWidth-30, 90 * kRate)
        remarkTextV.layer.cornerRadius = 2.0;
        remarkTextV.layer.backgroundColor = UIColor.whiteColor().CGColor;
        remarkTextV.layer.borderColor = CD_BackGroundColor.CGColor;
        remarkTextV.layer.borderWidth = 0.5;
        remarkTextV.font = Define.font(14);
        remarkTextV.text = self.agentClientModel.remarkStr;
        remarkView.addSubview(remarkTextV);
        
    }
    func textViewDidChange(textView: UITextView)
    {
            remarkContentStr = textView.text;
      
    }
    func textView(textView: UITextView, shouldChangeTextInRange range: NSRange, replacementText text: String) -> Bool
    {
        if range.location >= 100 && range.length == 0
        {
            return false
        }
        return true;

    }
   func textViewShouldBeginEditing(textView: UITextView)
    {
        
        UIView.animateKeyframesWithDuration(2, delay: 1, options: UIViewKeyframeAnimationOptions.CalculationModeLinear, animations: { () -> Void in
            
        }) { (Bool finished) -> Void in
            self.backGroundView.frame = CGRectMake(self.backGroundView.frame.origin.x, self.backGroundView.frame.origin.y - 280, self.backGroundView.frame.size.width, self.backGroundView.frame.size.height);
        }
    }
    func textViewDidEndEditing(textView: UITextView) {
        UIView.animateKeyframesWithDuration(1, delay: 2, options: UIViewKeyframeAnimationOptions.CalculationModeLinear, animations: { () -> Void in
           
            }) { (Bool finished) -> Void in
               self.backGroundView.frame = CGRectMake(self.backGroundView.frame.origin.x, self.backGroundView.frame.origin.y + 280, self.backGroundView.frame.size.width, self.backGroundView.frame.size.height);
        }
    }
    func initSelectedLabel()
    {
        let labelArry = agentClientModel.buyHousepurpose?.housepurseArry
         var tagStr:NSString = NSString()
            for var j = 0 ; j < agentClientModel.buyHousepurpose?.housepurseArry.count;j++
            {
                
                 tagStr = agentClientModel.buyHousepurpose?.housepurseArry.objectAtIndex(j) as String
                for var i = 0; i < houseTagsArry.count;i++
                {
                        var houseTageBtn:UIButton = houseTagView .viewWithTag(800+i) as UIButton
                        var houseTagStr:NSString = houseTageBtn.titleLabel!.text as String!;
               
                        if houseTagStr == tagStr
                        {
                            houseTageBtn.selected = true
                            houseTageBtn.backgroundColor =  CD_OrangeColor
                            houseTageBtn .setTitleColor(UIColor .whiteColor(), forState: .Normal)
                            self .pinjieHouseLabel()
                    
                        }
                }
            }
    }
    //MARK:选择封装标签
    func pinjieHouseLabel()
    {
        houseLabelArry .removeAllObjects()
        if countElements(houseLabelSStr) == 0
        {
            houseLabelSStr = ""
        }
        var arr = ["满五年","唯一住房","学区房"]
        for var i = 0;i<arr.count;i++ //i < HWUserLogin.currentUserLogin().signHouseInfoArr.count;i++
        {
            let btn:UIButton = houseTagView .viewWithTag(800+i) as UIButton
            if btn.selected == true
            {
                var str: NSString?
                if btn.titleLabel?.text == "满五年"
                {
                    str = "8,"
                }
                if btn.titleLabel?.text == "唯一住房"
                {
                    str = "7,"
                }

                if btn.titleLabel?.text == "学区房"
                {
                    str = "2,"
                }

                houseLabelArry.addObject(str!)
             
                
            }
//            println(houseLabelArry.count)
        }
         var StrV:String! = ""
        for var j:Int = 0;j < houseLabelArry.count;j++
        {
            
            StrV = (StrV as String) + (houseLabelArry.pObjectAtIndex(j) as String)
//          houStr.appendString(houseLabelArry.objectAtIndex(j) as NSString)
//          houseLabelSStr .substringToIndex(countElements(houseLabelSStr))
           // var indexEnd = advance(houseLabelSStr.end, <#n: T.Distance#>)
        }
        if  houseLabelArry.count > 0
        {
            let index2 = advance(StrV.endIndex, -1)
            houseLabelSStr = StrV.substringToIndex(index2)
        }
      
        
//        println(houseLabelSStr)
    }
    //MARK:按钮点击事件
    //房源类型
    func selectType(sender:UIButton!)
    {
        var selectedTypeBtn = sender as UIButton
        for var i = 0;i < 3; i++
        {
            var typeBtn = typeView .viewWithTag(200+i) as UIButton
            
            if typeBtn.tag == selectedTypeBtn.tag
            {
                typeBtn.selected = true
                typeBtn.backgroundColor = CD_OrangeColor
                var str = typeBtn.titleLabel?.text
                houseInfoArry .replaceObjectAtIndex(0, withObject: str!)
                self .createBuyHouseView(backGroundView)
                typeBtn .setTitleColor(UIColor .whiteColor(), forState: .Normal)
            }
            else
            {
                typeBtn.selected = false
                typeBtn.backgroundColor = UIColor .whiteColor()
                typeBtn .setTitleColor(CD_Txt_Color_33, forState: .Normal)
                
            }
            
        }
        
    }
    //选择户型
    func selectHouseType(sender:UIButton!)
    {
        var selectedTypeBtn = sender as UIButton
        
        for var i = 0;i<6; i++
        {
            var typeBtn = houseTypeView.viewWithTag(100+i) as UIButton
            if typeBtn.tag == selectedTypeBtn.tag
            {
                typeBtn.selected = true
                typeBtn.backgroundColor = CD_OrangeColor
                var str = typeBtn.titleLabel?.text
                houseInfoArry .replaceObjectAtIndex(2, withObject: str!)
                self .createBuyHouseView(backGroundView)
                typeBtn .setTitleColor(UIColor .whiteColor(), forState: .Normal)
            }
            else
            {
                typeBtn.selected = false
                typeBtn.backgroundColor = UIColor .whiteColor()
                typeBtn .setTitleColor(CD_Txt_Color_33, forState: .Normal)
                
            }
            
        }
        
    }
    //选择区域
    func selectArea(sender:UIButton!)
    {
        var selectedTypeBtn = sender as UIButton
        var typeBtn = scopeView .viewWithTag(selectedTypeBtn.tag) as UIButton
        if typeBtn.selected == false
        {
            if agentClientModel.buyHousepurpose?.houseTypeArry?.count>1
            {
                
                var str: NSString = agentClientModel.buyHousepurpose?.houseTypeArry?.objectAtIndex(1) as NSString
                var areaData:NSArray = str .componentsSeparatedByString(",")
                
                if areaData.count >= 3 && typeBtn.titleLabel?.text != "不限"
                {
                    Utility .showToastWithMessage("最多选择3个区域", _view:self.superview!.superview!)
                    return
                }
                if typeBtn.titleLabel?.text == "不限"
                {
                    agentClientModel.buyHousepurpose?.houseTypeArry?.replaceObjectAtIndex(1, withObject: self .selectedAreaS())
                }
                
            }
            if areaMoreSelectedArry.count >= 3 && typeBtn.titleLabel?.text != "不限"
            {
                Utility .showToastWithMessage("最多选择3个区域", _view:self.superview!.superview!)
                return
                
            }
            
            typeBtn.selected  = true
            typeBtn.backgroundColor = CD_OrangeColor
            typeBtn .setTitleColor(UIColor .whiteColor(), forState: .Normal)
            self .selectFilter(typeBtn)
            houseInfoArry .replaceObjectAtIndex(1, withObject: self .selectedAreaS())
            agentClientModel.buyHousepurpose?.houseTypeArry?.replaceObjectAtIndex(1, withObject: self .selectedAreaS())
            self .createBuyHouseView(backGroundView)
        }
        else
        {
            typeBtn.selected  = false
            typeBtn.backgroundColor = UIColor .whiteColor()
            typeBtn .setTitleColor(CD_Txt_Color_33, forState: .Normal)
            self .selectFilter(typeBtn)
            houseInfoArry .replaceObjectAtIndex(1, withObject: self .selectedAreaS())
            agentClientModel.buyHousepurpose?.houseTypeArry?.replaceObjectAtIndex(1, withObject: self .selectedAreaS())
            self.createBuyHouseView(backGroundView)
            
            
        }
    }
    func selectedAreaS() ->NSString
    {
        areaMoreSelectedArry .removeAllObjects()
        var areaStr  = NSMutableString()
        for var i = 0; i < areaDataArry.count; i++
        {
            var typeBtn = scopeView.viewWithTag(300+i) as UIButton
            if typeBtn.selected == true
            {
                areaMoreSelectedArry .addObject(areaDataArry.objectAtIndex(i))
                
            }
        }
        for var j = 0; j < areaMoreSelectedArry.count; j++
        {
            if j == 0
            {
                areaStr.appendFormat(areaMoreSelectedArry .objectAtIndex(0) as NSString)
            }
            else
            {
                areaStr.appendString(",");
                areaStr.appendFormat(areaMoreSelectedArry.objectAtIndex(j) as NSString)
                
            }
        }
        
        return areaStr
    }
    
    func labelSliderChanged(sender:HWTotalPriceRangeSlider)
    {
        self .updateSliderLabels(sender)
    }
    
    func updateSliderLabels(sender:HWTotalPriceRangeSlider)
    {
        if mySliderArea.upperValue == mySliderArea.lowerValue
        {
            if mySliderArea.upperValue == 50
            {
                mySliderArea .setUpperValue(70, animated: true)
                
            }
            else if mySliderArea.upperValue == 70
            {
                mySliderArea .setUpperValue(90, animated: true)
                
            }
            else if mySliderArea.upperValue == 70
            {
                mySliderArea .setUpperValue(90, animated: true)
                
            }
                
            else if mySliderArea.upperValue == 90
            {
                mySliderArea .setUpperValue(110, animated: true)
                
            }
                
            else if mySliderArea.upperValue == 110
            {
                mySliderArea .setUpperValue(130, animated: true)
                
            }
                
            else if mySliderArea.upperValue == 130
            {
                mySliderArea .setUpperValue(150, animated: true)
                
            }
            else if mySliderArea.upperValue == 150
            {
                mySliderArea .setUpperValue(200, animated: true)
                
            }
                
            else if mySliderArea.upperValue == 200
            {
                mySliderArea .setUpperValue(300, animated: true)
                
            }
                
            else
            {
                mySliderArea .setUpperValue(310, animated: true)
                
            }
            return
        }
        if mySliderArea.lowerValue > 300
        {
            houseLowerLabel.text = "不限"
        }
        else
        {
            houseLowerLabel.text = "\(Int(mySliderArea.lowerValue))㎡"
            
        }
        if mySliderArea.upperValue > 300
        {
            houseupperLabel.text = "不限"
        }
        else
        {
            houseupperLabel.text = "\(Int(mySliderArea.upperValue))㎡"
            
        }
        
        var houseAreaStr:NSString = houseLowerLabel.text!+"-"+houseupperLabel.text!
        houseInfoArry .replaceObjectAtIndex(4, withObject:houseAreaStr)
        self .createBuyHouseView(backGroundView)
        
    }
    //mianji
    
    func labelSliderPriceChanged(sender:HWTotalPriceRangeSlider)
    {
        self .updateSliderPriceLabels(sender)
        
    }
    
    
    func updateSliderPriceLabels(sender:HWTotalPriceRangeSlider)
    {
        if mySlider.upperValue == mySlider.lowerValue
        {
            if mySlider.upperValue == 100
            {
                mySlider .setUpperValue(150, animated: true)
                
            }
                
            else if mySlider.upperValue == 150
            {
                mySlider .setUpperValue(200, animated: true)
                
            }
            else if mySlider.upperValue == 200
            {
                mySlider .setUpperValue(300, animated: true)
                
            }
                
            else if mySlider.upperValue == 300
            {
                mySlider .setUpperValue(500, animated: true)
                
            }
                
            else if mySlider.upperValue == 500
            {
                mySlider .setUpperValue(1000, animated: true)
                
            }
                
                
            else
            {
                mySliderArea .setUpperValue(1010, animated: true)
                
            }
            return
        }
        if mySlider.lowerValue > 1000
        {
            priceLowerLabel.text = "不限"
        }
        else
        {
            //int str = Int(mySlider.lowerValue)
            priceLowerLabel.text = "\(Int(mySlider.lowerValue))万"
            
        }
        if mySlider.upperValue > 1000
        {
            priceUpperLabel.text = "不限"
        }
        else
        {
            priceUpperLabel.text = "\(Int(mySlider.upperValue))万"
            
        }
        
        var housePriceStr:NSString = priceLowerLabel.text!+"-"+priceUpperLabel.text!
        houseInfoArry.replaceObjectAtIndex(3, withObject: housePriceStr)
        self.createBuyHouseView(backGroundView)
        
    }
    func selctHouseTag(sender:UIButton!)
    {
        var selectedTypeBtn = sender as UIButton
        var typeBtn = houseTagView .viewWithTag(selectedTypeBtn.tag) as UIButton
        if typeBtn.selected == false
        {
            typeBtn.selected = true
            typeBtn.backgroundColor = CD_OrangeColor
            typeBtn .setTitleColor(UIColor .whiteColor(), forState: .Normal)
            
        }
        else
        {
            typeBtn.selected = false
            typeBtn.backgroundColor = UIColor .whiteColor()
            typeBtn .setTitleColor(CD_Txt_Color_33, forState: .Normal)
            
            
        }
        self .pinjieHouseLabel()
        
        didSelectedBtnDelegate?.didSelecttedBtn(houseLabelSStr)

    }
    required init(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    
}
