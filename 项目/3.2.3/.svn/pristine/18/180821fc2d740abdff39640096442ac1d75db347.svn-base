//
//  HWLoggingCustomerVC.swift
//  Partner-Swift
//
//  Created by wuxiaohong on 15/2/25.
//  Copyright (c) 2015年 caijingpeng.haowu. All rights reserved.
//

import UIKit
//import AddressBook
import AddressBookUI

class HWLoggingCustomerVC: HWBaseViewController,UITableViewDelegate,UITableViewDataSource,UITextFieldDelegate, ABPeoplePickerNavigationControllerDelegate ,HWFloggingCustomerTableViewCellDelegate,UIAlertViewDelegate,HWServiceCustomPickViewDelegate{
    //请求之后回到客户列表
    typealias selectCustomerBlock = () ->Void
    var myFunc = selectCustomerBlock?()
    let backGroundView:UIView = UIView()
    let personInfoView:UIView = UIView()
    var agentClientModel = HWAgentCustomerDetailModel()
    var titileType:NSString?//标题类型
    var arry = NSArray()
    var priceLowerLabel = UILabel()
    var remarkStr = String();
    var whichStr = String();
    var priceUpperLabel = UILabel()
    var houseLowerLabel = UILabel()
    var houseupperLabel = UILabel()
    var selectedHouseLabel = UILabel()
    var houseLabelsStr = String()
    var remarkView = UITextView();
    var str : NSString?
    var diclLogginDate:NSDictionary = NSDictionary()
    var picker: ABPeoplePickerNavigationController!
    var clientSourceWay:String!
    var pickBackview:UIView!
    var tableView:UITableView!
    
    var intentionPurposeStr = NSMutableString()
    override func viewWillAppear(animated: Bool)
    {
        self.navigationController?.navigationBarHidden = false
        //self .dismissViewControllerAnimated(true , completion: ni)
    }

    override func viewDidLoad()
    {
        super.viewDidLoad()
        if titileType == "0"
        {
        self.navigationItem.titleView = Utility.navTitleView("录入客户")
        }
        else
        {
           self.navigationItem.titleView = Utility.navTitleView("编辑客户")
        }
        
        tableView = UITableView(frame: CGRectMake(0, 0, kScreenWidth, self.view.frame.size.height * kRate))
        tableView.delegate = self
        tableView.dataSource = self
        tableView.backgroundColor = CD_BackGroundColor
        tableView.separatorStyle = UITableViewCellSeparatorStyle(rawValue:0)!
        self.view .addSubview(tableView)
        tableView.tableHeaderView = self .createHeaderView()
        let tap = UITapGestureRecognizer(target: self, action: "doTap")
        tableView .addGestureRecognizer(tap)
        var sexBtn = personInfoView .viewWithTag(501) as UIButton
        sexBtn.layer.borderColor = CD_WhiteColor.CGColor;
        
        sexBtn .setImage(UIImage(named: "choose_2_2"), forState: .Normal)

        if agentClientModel.clientInfoId != nil
        {
            self .initCustomerData()
        }
    }
    func initCustomerData()
    {
        var nameTextFiled = personInfoView .viewWithTag(100) as UITextField
        nameTextFiled.text = agentClientModel.clientName
        
        var phoneTextF = personInfoView .viewWithTag(101) as UITextField
        phoneTextF.text = agentClientModel.clientPhone
        
        let btn = personInfoView .viewWithTag(600) as UIButton
        btn.setTitle(agentClientModel.clientSources, forState: .Normal)
        
        let btn1 = personInfoView .viewWithTag(700) as UIButton
        btn1.setTitle(agentClientModel.clientRange, forState: .Normal)//改成数据模型里面客户等级
       
        if agentClientModel.guestSourceWay == "conduit" || agentClientModel.guestSourceWay == "childClient" || agentClientModel.guestSourceWay == "aloneBroker"
        {
           
        }
        else
        {
            personInfoView.frame = CGRectMake(0, 0, kScreenWidth, (206 - 44) * kRate)
            tableView.tableHeaderView = personInfoView
            tableView.reloadData()

            
        }
        if agentClientModel.clientSex == "1"
        {
            var sexBtn = personInfoView .viewWithTag(500) as UIButton
            sexBtn.layer.borderColor = CD_WhiteColor.CGColor;

            sexBtn .setImage(UIImage(named: "choose_2_2"), forState: .Normal)
            var sexBtn1 = personInfoView .viewWithTag(501) as UIButton
            sexBtn1 .setImage(UIImage(named: "choose_2_1"), forState: .Normal)
        }
        else
        {
            var sexBtn = personInfoView .viewWithTag(501) as UIButton
            sexBtn.layer.borderColor = CD_WhiteColor.CGColor;

            sexBtn .setImage(UIImage(named: "choose_2_2"), forState: .Normal)
            var sexBtn1 = personInfoView .viewWithTag(500) as UIButton
            sexBtn1 .setImage(UIImage(named: "choose_2_1"), forState: .Normal)

            
        }
        
    }
    override func backMethod()
    {
        
        self .dismissViewControllerAnimated(true, completion: nil)
        self.navigationController?.popViewControllerAnimated(true);
        
    }
    func doTap()
    {
       self.view .endEditing(true)
    }
    
    func createHeaderView() ->UIView
    {
        personInfoView.frame = CGRectMake(0, 0, kScreenWidth, 250 * kRate)
        personInfoView.backgroundColor = UIColor .whiteColor()
        backGroundView.frame = CGRectMake(0, 0, kScreenWidth, 30 * kRate)
        backGroundView.backgroundColor = CD_BackGroundColor
        personInfoView .addSubview(backGroundView)
        
        let relativeHouseLabel = UILabel(frame: CGRectMake(15, 5, kScreenWidth, 20 * kRate))
        relativeHouseLabel.font  = Define.font(13)
        relativeHouseLabel.textColor = CD_Txt_Color_99
        relativeHouseLabel.backgroundColor = CD_BackGroundColor
        relativeHouseLabel.text = "我们会对您录入的客户信息进行保密,仅自己可见"
        personInfoView .addSubview(relativeHouseLabel)
        self .drawLine(CGRectMake(0, 29.5, kScreenWidth, 0.5), sectionOneViewTemp: personInfoView)
        self .createGeneralTwoStyleView("姓名", titleContentStr: "", view: personInfoView, originY: CGRectGetMaxY(backGroundView.frame), tag: 100)
        let nameTextField = personInfoView .viewWithTag(100) as UITextField
        nameTextField.contentVerticalAlignment = UIControlContentVerticalAlignment (rawValue: 0)!
        nameTextField .resignFirstResponder()
        
        self .drawLine(CGRectMake(0, 44+CGRectGetMaxY(backGroundView.frame), kScreenWidth, 0.5 * kRate), sectionOneViewTemp: personInfoView)
        self .createGeneralOneStyleView("手机", titleContentStr: "", view: personInfoView, originY: 44 + CGRectGetMaxY(backGroundView.frame), tag: 101)
        
        let phoneTextF = personInfoView .viewWithTag(101) as UITextField
        phoneTextF.contentVerticalAlignment = UIControlContentVerticalAlignment (rawValue: 0)!
        phoneTextF.keyboardType = UIKeyboardType (rawValue: 4)!
        self .drawLine(CGRectMake(0, 44*2 + CGRectGetMaxY(backGroundView.frame), kScreenWidth, 0.5), sectionOneViewTemp: personInfoView)
        self .createGeneralThreeStyleView("性别", titleContentStr: "", view: personInfoView, originY: 2*44+CGRectGetMaxY(backGroundView.frame), tag: 500)
         self .drawLine(CGRectMake(0, 44*3+CGRectGetMaxY(backGroundView.frame), kScreenWidth, 0.5), sectionOneViewTemp: personInfoView)
        self .createGeneralFourStyleView("客户来源", titleContentStr: "网络端口", view: personInfoView, originY: 3*44+CGRectGetMaxY(backGroundView.frame), tag: 600)
         self .drawLine(CGRectMake(0, 44*4+CGRectGetMaxY(backGroundView.frame), kScreenWidth, 0.5), sectionOneViewTemp: personInfoView)
        self.createGeneralFiveStyleView("客户等级", titleContentStr: "C", view: personInfoView, originY: 4*44+CGRectGetMaxY(backGroundView.frame), tag: 700)
     return personInfoView
        
    }
    //MARK:划线
    func drawLine(lineRect:CGRect,sectionOneViewTemp:UIView)
    {
        let imageView = UIImageView(frame: lineRect)
        imageView.backgroundColor = CD_LineColor
        sectionOneViewTemp .addSubview(imageView)
    }
    //Mark:创建通用的行试图1
    func createGeneralOneStyleView(titleStr:NSString,titleContentStr:NSString,view:UIView,originY:CGFloat,tag:NSInteger)
    {
        let purposeLabel = UILabel(frame: CGRectMake(15, originY, 100, 44))
        purposeLabel.font = Define.font(15)
        purposeLabel.textColor = CD_Txt_Color_33
        purposeLabel.text = titleStr
        view .addSubview(purposeLabel)
        
        let generalTextField = UITextField(frame: CGRectMake(15+50, originY, kScreenWidth-2*15-50, 44))
        generalTextField.tag = tag
        generalTextField.delegate = self
        generalTextField.textAlignment = NSTextAlignment (rawValue: 2)!
        generalTextField.font = Define.font(16)
        generalTextField.textColor = CD_Txt_Color_99
        generalTextField.text = titleContentStr
        view .addSubview(generalTextField)


    }
    //Mark:创建通用的行试图2
func createGeneralTwoStyleView(titleStr:NSString,titleContentStr:NSString,view:UIView,originY:CGFloat,tag:NSInteger)
    {
        let purposeLabel = UILabel(frame: CGRectMake(15, originY, 100, 44))
        purposeLabel.font = Define.font(15)
        purposeLabel.textColor = CD_Txt_Color_33
        purposeLabel.text = titleStr
        view .addSubview(purposeLabel)
        
        let generalTextField = UITextField(frame: CGRectMake(15+50, originY+2, kScreenWidth-2*15-50-55, 44))
        generalTextField.tag = tag
        generalTextField.font = Define.font(16)
        generalTextField.delegate = self
        generalTextField.textColor = CD_Txt_Color_99
        generalTextField.text = titleContentStr
        view .addSubview(generalTextField)
        let contactBtn = UIButton(frame: CGRectMake(kScreenWidth-15-45, originY+7, 55, 30))
        contactBtn.titleLabel?.font = Define.font(14)
        contactBtn.setImage(UIImage(named: "add_icon2"),forState: .Normal)
        contactBtn .addTarget(self, action: "addCustomer", forControlEvents:UIControlEvents.TouchUpInside)
        view .addSubview(contactBtn)
        
        
    }
func createGeneralFourStyleView(titleStr:NSString,titleContentStr:NSString,view:UIView,originY:CGFloat,tag:NSInteger)
    {
        let purposeLabel = UILabel(frame: CGRectMake(15, originY, 100, 44))
        purposeLabel.font = Define.font(15)
        purposeLabel.textColor = CD_Txt_Color_33
        purposeLabel.text = titleStr
        view .addSubview(purposeLabel)
        let contactBtn = UIButton(frame: CGRectMake(kScreenWidth-15-200, originY+7, 200, 30))
        //contactBtn.backgroundColor = UIColor.redColor()
        contactBtn.titleLabel?.font = Define.font(14)
        contactBtn.tag = tag
        contactBtn.setImage(UIImage(named: "arrow_next"),forState: .Normal)
        contactBtn.setTitle(titleContentStr, forState: .Normal)
        contactBtn.setTitleColor(CD_Txt_Color_99, forState: .Normal)
        contactBtn.imageEdgeInsets = UIEdgeInsets(top: 0, left: 185, bottom: 0, right: 0);
        contactBtn.titleEdgeInsets = UIEdgeInsets(top: 0, left: 105, bottom: 0, right: 15);
        contactBtn.addTarget(self, action: "selectClientSource", forControlEvents:UIControlEvents.TouchUpInside)
        view.addSubview(contactBtn)

    
    }
    func createGeneralFiveStyleView(titleStr:NSString,titleContentStr:NSString,view:UIView,originY:CGFloat,tag:NSInteger)
    {
        let purposeLabel = UILabel(frame: CGRectMake(15, originY, 100, 44))
        purposeLabel.font = Define.font(15)
        purposeLabel.textColor = CD_Txt_Color_33
        purposeLabel.text = titleStr
        view .addSubview(purposeLabel)
        let contactBtn = UIButton(frame: CGRectMake(kScreenWidth-15-200, originY+7, 200, 30))
        //contactBtn.backgroundColor = UIColor.redColor()
        contactBtn.titleLabel?.font = Define.font(14)
        contactBtn.tag = tag
        contactBtn.setImage(UIImage(named: "arrow_next"),forState: .Normal)
        contactBtn.setTitle(titleContentStr, forState: .Normal)
        contactBtn.setTitleColor(CD_Txt_Color_99, forState: .Normal)
        contactBtn.imageEdgeInsets = UIEdgeInsets(top: 0, left: 185, bottom: 0, right: 0);
        contactBtn.titleEdgeInsets = UIEdgeInsets(top: 0, left: 105, bottom: 0, right: 15);
        contactBtn.addTarget(self, action: "selectCustomerRank", forControlEvents:UIControlEvents.TouchUpInside)
        view.addSubview(contactBtn)
        
        
    }
    //客户等级
    func selectCustomerRank()->Void
    {
        whichStr = "range";
        let nameTextField = personInfoView .viewWithTag(100) as UITextField
        nameTextField .resignFirstResponder()
        
        let phoneTextF = personInfoView .viewWithTag(101) as UITextField
        phoneTextF.resignFirstResponder();
        
        var pickArry = ["A","B","C","D"]
        var pickView = HWServiceCustomPickerView(dataArray: pickArry, str: "1")
        pickView.customPickerViewDelegate = self
        self.view.addSubview(pickView)
    }
    //MARK:选择客户来源
    func selectClientSource()
    {
        let nameTextField = personInfoView .viewWithTag(100) as UITextField
        nameTextField .resignFirstResponder()
        
        let phoneTextF = personInfoView .viewWithTag(101) as UITextField
        phoneTextF.resignFirstResponder();
        whichStr = "source"
        var pickArry = ["网络端口","CALL客","巡展","派单","上门客户","房展会","推荐","其他"]
        var pickView = HWServiceCustomPickerView(dataArray: pickArry, str: "1")
        pickView.customPickerViewDelegate = self
        self.view.addSubview(pickView)
    }
    //MARK:HWServiceCustomPickerView代理
    func passSelectedItems(str:NSString)
    {
        if(whichStr == "source")
        {
            let btn = personInfoView .viewWithTag(600) as UIButton
            btn.setTitle(str, forState: .Normal)
            tableView.reloadData()
        }
        else
        {
            
            let btn1 = personInfoView .viewWithTag(700) as UIButton
            btn1.setTitle(str, forState: .Normal)
            tableView.reloadData()
        }
      
        
    }
    //MARK:选择客户
    func addCustomer()
    {
        picker = ABPeoplePickerNavigationController()
        picker.peoplePickerDelegate = self
        self .presentViewController(picker, animated: true, completion: nil)
    }
    //MARK:选择性别
    func clickMale(sender:UIButton!)
    {
        var btn = sender as UIButton
        if (btn.imageView?.image != nil)
        {
           btn .setImage(UIImage(named: "choose_2_2"), forState: .Normal)
           // btn.layer.borderColor = CD_Btn_WhiteColor.CGColor
            var femaleBtn = personInfoView .viewWithTag(501) as UIButton
            if (femaleBtn.imageView?.image != nil)
            {
                femaleBtn .setImage(UIImage(named: "choose_2_1"), forState: .Normal)
//                femaleBtn.imageView?.image = nil
//                femaleBtn.layer.borderColor = CD_LineColor.CGColor
            }
            
        }
        else
        {
            btn .setImage(UIImage(named: "choose_2_1"), forState: .Normal)
//            btn.imageView?.image = nil
//            btn.layer.borderColor = CD_LineColor.CGColor
        }
        
    }
    func clickFemale(sender:UIButton!)
    {
        var btn = sender as UIButton
        if (btn.imageView?.image != nil)
        {
            btn .setImage(UIImage(named: "choose_2_2"), forState: .Normal)
            //btn.layer.borderColor = CD_Btn_WhiteColor.CGColor
            var maleBtn = personInfoView .viewWithTag(500) as UIButton
            if (maleBtn.imageView?.image != nil)
            {
                maleBtn .setImage(UIImage(named: "choose_2_1"), forState: .Normal)
//                maleBtn.imageView?.image = nil
//                maleBtn.layer.borderColor = CD_LineColor.CGColor
            }
            
        }
        else
        {
            btn .setImage(UIImage(named: "choose_2_1"), forState: .Normal)
//            btn.imageView?.image = nil
//            btn.layer.borderColor = CD_LineColor.CGColor
        }
        
    }


    //Mark:创建通用的行试图3
    func createGeneralThreeStyleView(titleStr:NSString,titleContentStr:NSString,view:UIView,originY:CGFloat,tag:NSInteger)
    {
        let purposeLabel = UILabel(frame: CGRectMake(15, originY, 100, 44))
        purposeLabel.font = Define.font(15)
        purposeLabel.textColor = CD_Txt_Color_33
        purposeLabel.text = titleStr
        view .addSubview(purposeLabel)
        
        let maleBtn = UIButton(frame: CGRectMake(kScreenWidth-65-19-32-19,44/2-19/2+originY, 50, 19))
        maleBtn .addTarget(self, action: "clickMale:", forControlEvents:UIControlEvents.TouchUpInside)
        maleBtn .setImage(UIImage(named: "choose_2_1"), forState: .Normal)
        maleBtn.tag = tag
        maleBtn.backgroundColor = UIColor .clearColor()
        maleBtn.imageEdgeInsets = UIEdgeInsetsMake(0, 0, 0, 31)
        view .addSubview(maleBtn)
    
        
        let maleLab = UILabel(frame: CGRectMake(kScreenWidth-19-60-32, originY, 60, 44))
        maleLab.text = "先生"
        maleLab.font = Define.font(16)
        maleLab.textColor = CD_Txt_Color_99
        view .addSubview(maleLab)
        
        let femaleBtn = UIButton(frame: CGRectMake(kScreenWidth-55-19,44/2-19/2+originY, 50, 19))
        femaleBtn .addTarget(self, action: "clickFemale:", forControlEvents:UIControlEvents.TouchUpInside)
        femaleBtn .setImage(UIImage(named: "choose_2_1"), forState: .Normal)
        femaleBtn.imageEdgeInsets = UIEdgeInsetsMake(0, 0, 0, 31)
        femaleBtn.tag = tag + 1
        femaleBtn.layer.borderColor = CD_LineColor.CGColor
        femaleBtn.backgroundColor = UIColor .clearColor()
        view .addSubview(femaleBtn)
        
       
        
        let femaleLabel = UILabel(frame: CGRectMake(kScreenWidth-15-35, originY, 35, 44))
        femaleLabel.text = "女士"
        femaleLabel.font = Define.font(16)
        femaleLabel.textColor = CD_Txt_Color_99
        view .addSubview(femaleLabel)
        
    }
    //MARK:表的代理
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell
    {
//          let cell:HWFloggingCustomerTableViewCell  = tableView.dequeueReusableCellWithIdentifier("cell", forIndexPath: indexPath) as HWFloggingCustomerTableViewCell
        let cell:HWFloggingCustomerTableViewCell = HWFloggingCustomerTableViewCell(style:UITableViewCellStyle.Default, reuseIdentifier:"cell", agentModel: agentClientModel)
        cell.selectionStyle = UITableViewCellSelectionStyle.None; 
//        cell.agentClientModel = agentClientModel
        cell.didSelectedBtnDelegate = self
        arry = cell.houseInfoArry
        priceLowerLabel = cell.priceLowerLabel
        priceUpperLabel = cell.priceUpperLabel
        houseLowerLabel = cell.houseLowerLabel
        houseupperLabel = cell.houseupperLabel
        houseLabelsStr = cell.houseLabelSStr
        remarkView = cell.remarkTextV;
//        println(cell.houseLabelSStr)
        cell.submitBtn .addTarget(self, action: "submitBtn", forControlEvents: .TouchUpInside)
        return cell
    }
    func tableView(tableView: UITableView, viewForHeaderInSection section: Int) -> UIView
    {
        let view = UIView(frame: CGRectMake(0, 0, kScreenWidth, 30 * kRate))
        view.backgroundColor = CD_BackGroundColor
        let lab = UILabel(frame: CGRectMake(15, 5, kScreenWidth, 20))
        lab.font = Define.font(14)
        lab.textColor = CD_Txt_Color_99
        lab.text  = "购房意向"
        view .addSubview(lab)
        let imageViewOne = UIImageView(frame: CGRectMake(0, 0, kScreenWidth, 0.5))
        imageViewOne.backgroundColor  = CD_LineColor
        view .addSubview(imageViewOne)
        
        let imageViewTwo = UIImageView(frame: CGRectMake(0,29.5, kScreenWidth, 0.5))
        imageViewTwo.backgroundColor  = CD_LineColor
        view .addSubview(imageViewTwo)
        return view
    }
    func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat
    {
        var areaDataArry = NSMutableArray(objects: "不限")
        var citys = HWUserLogin.currentUserLogin().cities
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
       var rows = areaDataArry.count / 4
        if areaDataArry.count % 4 != 0
        {
            rows++
        }
        
        
        var houseTagsArry = NSMutableArray(objects: "满五年","唯一住房","学区房")
        var houseRows = houseTagsArry.count / 4
        if houseTagsArry.count % 4 != 0
        {
            houseRows++
        }
        return 700 + CGFloat(rows)*40 + CGFloat(houseRows-1) * 40+110
    }
    func tableView(tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat
    {
        return 30 * kRate
    }

    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int
    {
        return 1
    }
    override func didReceiveMemoryWarning()
    {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
       
    }
    
   //MARK: UITextField的代理
    func textField(textField: UITextField, shouldChangeCharactersInRange range: NSRange, replacementString string: String) -> Bool
    {
        let telTextFiled = personInfoView .viewWithTag(101) as UITextField
        if textField == telTextFiled
        {
            if countElements(textField.text) >= 11 && range.length == 0
            {
                return false
            }
        }
        return true
    }
    //MARK:选择通讯录的代理
    
   func peoplePickerNavigationController(peoplePicker: ABPeoplePickerNavigationController!, didSelectPerson person: ABRecordRef!, property: ABPropertyID, identifier: ABMultiValueIdentifier) -> Void
   {
    
    if property == kABPersonPhoneProperty
    {
        var phoneMulti:ABMutableMultiValueRef =  ABRecordCopyValue(person, property).takeRetainedValue()
        var fullName = NSString()
        var phoneStr = NSString()
        var index: CFIndex = ABMultiValueGetIndexForIdentifier(phoneMulti, identifier)
        var firstValue:Unmanaged? = ABRecordCopyValue(person, kABPersonFirstNameProperty);
        var firstName: String?;
        var lastName: String?;
        
        if(firstValue == nil)
        {
            
        }
        else
        {
            var ab: Unmanaged<AnyObject> = ABRecordCopyValue(person, kABPersonFirstNameProperty)
            firstName = ab.takeRetainedValue().isKindOfClass(NSString) == true ? (ab.takeRetainedValue() as? String) : ""
        }
       
        if (firstName == nil)
        {
            firstName = ""
            firstName = firstName?.stringByAppendingString(" ")
        }
        
        
        var lastValue:Unmanaged? = ABRecordCopyValue(person, kABPersonLastNameProperty);
        if(lastValue == nil)
        {
            
        }
        else
        {
            var ab: Unmanaged<AnyObject> = ABRecordCopyValue(person, kABPersonLastNameProperty)
            lastName = ab.takeRetainedValue().isKindOfClass(NSString) == true ? (ab.takeRetainedValue() as? String) : ""
        }
        
        if (lastName == nil)
        {
            lastName = ""
        }
        if(firstName == "")
        {
            fullName  =  lastName!;
        }
        else
        {
            if(lastName != nil)
            {
                fullName  =  lastName! + firstName!;
            }
            else
            {
                fullName = "";
            }
        }

        let personNameTextFiled = personInfoView.viewWithTag(100) as UITextField
        personNameTextFiled.text = fullName
        if(index >= 0)
        {
            var phoneValue:Unmanaged? = ABMultiValueCopyValueAtIndex(phoneMulti, index);
            if(phoneValue != nil)
            {
                phoneStr = ABMultiValueCopyValueAtIndex(phoneMulti, index).takeRetainedValue() as String
                let phoneTextFiled = personInfoView .viewWithTag(101) as UITextField
                phoneTextFiled.text = phoneStr;
            }
 
        }
        peoplePicker .dismissViewControllerAnimated(true, completion: nil)

    }

    }
    
    
    func peoplePickerNavigationController(peoplePicker: ABPeoplePickerNavigationController!, shouldContinueAfterSelectingPerson person: ABRecordRef!, property: ABPropertyID, identifier: ABMultiValueIdentifier) -> Bool
    {
        if property == kABPersonPhoneProperty
        {
            var phoneMulti:ABMutableMultiValueRef =  ABRecordCopyValue(person, property).takeRetainedValue()
            var fullName: String!
            var phoneStr: String!
            var index: CFIndex = ABMultiValueGetIndexForIdentifier(phoneMulti, identifier)
            var firstValue:Unmanaged? = ABRecordCopyValue(person, kABPersonFirstNameProperty);
            var firstName: String?;
            var lastName: String?;
            if(firstValue == nil)
            {
            }
            else
            {
                firstName = ABRecordCopyValue(person, kABPersonFirstNameProperty)?.takeRetainedValue() as? String
            }
            
            if (firstName == nil)
            {
                firstName = ""
                firstName = firstName?.stringByAppendingString(" ")
            }
            
            
            var lastValue:Unmanaged? = ABRecordCopyValue(person, kABPersonLastNameProperty);
            if(lastValue == nil)
            {
                
            }
            else
            {
                lastName = ABRecordCopyValue(person, kABPersonLastNameProperty)?.takeRetainedValue() as? String
            }
            
            if (lastName == nil)
            {
                lastName = ""
            }
            if(firstName == "")
            {
                fullName  =  lastName;
            }
            else
            {
                if(lastName != nil)
                {
                    fullName  =  lastName! + firstName!;
                }
                else
                {
                    fullName = "";
                }
            }
            
            let personNameTextFiled = personInfoView.viewWithTag(100) as UITextField
            personNameTextFiled.text = fullName
            var phoneValue:Unmanaged? = ABMultiValueCopyValueAtIndex(phoneMulti, index);
            if(phoneValue != nil)
            {
                phoneStr = ABMultiValueCopyValueAtIndex(phoneMulti, index).takeRetainedValue() as String
                let phoneTextFiled = personInfoView.viewWithTag(101) as UITextField
                phoneTextFiled.text = phoneStr;
            }
            
            peoplePicker.dismissViewControllerAnimated(true, completion: nil)
        }
        return false
    }
    
    func peoplePickerNavigationController(peoplePicker: ABPeoplePickerNavigationController!, shouldContinueAfterSelectingPerson person: ABRecordRef!) -> Bool
    {
        return  true
    }
     func personViewController(personViewController: ABPersonViewController!, shouldPerformDefaultActionForPerson person: ABRecordRef!, property: ABPropertyID, identifier: ABMultiValueIdentifier) -> Bool
     {
        return true
    }
    func peoplePickerNavigationControllerDidCancel(peoplePicker: ABPeoplePickerNavigationController!)
    {
        peoplePicker .dismissViewControllerAnimated(true, completion: nil)
    }
    //MARK:提交的请求
    func submitBtn()
    {
            MobClick .event("Addclientsubmit_click")
            
    //        key: ***   --用户key
    //        name: ***  --客户姓名
    //        phone: *** --客户电话
    //        sex: ***   --客户性别(0女，1男)
    //        intentionCategory: *** --意向类别（code值）
    //        intentionHouseType: ***  --意向户型（code值）
    //        intentionPrice: ***  --意向总价（100-150，150-max）
    //        intentionSize:***    --意向面积（0-100,300-max）
    //        intentionRegion: *** --意向区域（code值多个以逗号分隔）
    //        intentionPurpose: *** --意向目的(标签)（code值多个以逗号分隔）
    if titileType == "0"
    {
        var nameTextFiled = personInfoView .viewWithTag(100) as UITextField
        if  nameTextFiled.text == ""
        {
            Utility .showToastWithMessage("姓名不能为空", _view: self.view)
            return
        }
        if countElements(nameTextFiled.text) > 14
        {
            Utility .showToastWithMessage("姓名长度不能超过14字", _view: self.view)
            return
        }
        var phoneTextField = personInfoView .viewWithTag(101) as UITextField
        if countElements (phoneTextField.text) < 11 && countElements(phoneTextField.text)>0
        {
              Utility .showToastWithMessage("手机号不能小于11位", _view: self.view)
              return
        }
        var femaleBtn =  personInfoView .viewWithTag(501) as UIButton
        var maleBtn =  personInfoView .viewWithTag(500) as UIButton
        
        if femaleBtn.imageView?.image == UIImage(named: "choose_2_2")
        {
            str = "0"
        }
        else
        {
            self.str = "1"
        }
        let manager = HWHttpRequestOperationManager.baseManager()
        var param: NSMutableDictionary! = NSMutableDictionary()
        param .setObject(HWUserLogin.currentUserLogin().key, forKey: "key")
        param .setObject(nameTextFiled.text, forKey: "name")
        
        if phoneTextField.text == ""
        {
        
        }
        else
        {
        param .setObject(phoneTextField.text .stringByReplacingOccurrencesOfString("-", withString: "", options: nil, range: nil) .stringByReplacingOccurrencesOfString(" ", withString: "", options: nil, range: nil), forKey: "phone")
        }
        if str == ""
        {
            Utility .showToastWithMessage("性别为空", _view: self.view)
            return
            
        }
        var btn:UIButton? =  personInfoView .viewWithTag(600) as? UIButton
        var sourceStr:NSString?
        if btn?.titleLabel?.text == "网络端口"
        {
            sourceStr = "networkPort"
        }
       else if btn?.titleLabel?.text == "CALL客"
        {
            sourceStr = "callGuest"
        }
       else  if btn?.titleLabel?.text == "巡展"
        {
            sourceStr = "tour"
        }
       else if btn?.titleLabel?.text == "派单"
        {
            sourceStr = "distributeLeaflets"
        }
       else  if btn?.titleLabel?.text == "上门客户"
        {
            sourceStr = "comeToClient"
        }
       else if btn?.titleLabel?.text == "房展会"
        {
            sourceStr = "exhibitions"
        }
      else if btn?.titleLabel?.text == "推荐"
        {
            sourceStr = "recommend"
        }
      else if btn?.titleLabel?.text == "其他"
        {
            sourceStr = "others"
        }
      else
        {
            sourceStr = ""
        }
        //增加等级
        var rangBtn:UIButton? =  personInfoView .viewWithTag(700) as? UIButton
        var rangBtnsourceStr:NSString?
        rangBtnsourceStr = rangBtn?.titleLabel?.text
        param .setObject(rangBtnsourceStr!,forKey: "clientLevel")
        //
        param .setObject(sourceStr!, forKey: "clientSources")
        param .setObject(str!,forKey: "sex")
        if arry[0] .isEqualToString("住宅")
        {
            param .setObject("1", forKey: "intentionCategory")
        }
        if arry[0] .isEqualToString("别墅")
        {
            param .setObject("3", forKey: "intentionCategory")
        }

        if arry[0] .isEqualToString("商住")
        {
            param .setObject("2", forKey: "intentionCategory")
        }
        if arry[2] .isEqualToString("不限")
        {
           param .setObject("0", forKey: "intentionHouseType")
        }
        if arry[2] .isEqualToString("一室")
        {
            param .setObject("1", forKey: "intentionHouseType")
        }
        if arry[2] .isEqualToString("二室")
        {
            param .setObject("2", forKey: "intentionHouseType")
        }
        if arry[2] .isEqualToString("三室")
        {
            param .setObject("3", forKey: "intentionHouseType")
        }
        if arry[2] .isEqualToString("四室")
        {
            param .setObject("4", forKey: "intentionHouseType")
        }
       if arry[2] .isEqualToString("五室以上")
        {
            param .setObject("5", forKey: "intentionHouseType")
        }
        
        var priceLowText = priceLowerLabel.text?.stringByReplacingOccurrencesOfString("万", withString: "", options: nil, range: nil)
        var priceUpText = priceUpperLabel.text?.stringByReplacingOccurrencesOfString("万", withString: "", options: nil, range: nil)
        if  priceUpperLabel.text == "不限"
        {
            param .setObject( priceLowText!+"-"+"2000",forKey: "intentionPrice")
        }
         else
        {
             param .setObject( priceLowText!+"-"+priceUpText!,forKey: "intentionPrice")
            
        }
     
        var areaLowText = houseLowerLabel.text?.stringByReplacingOccurrencesOfString("㎡", withString: "", options: nil, range: nil)
        var areaUpText = houseupperLabel.text?.stringByReplacingOccurrencesOfString("㎡", withString: "", options: nil, range: nil)
        if  houseupperLabel.text == "不限"
        {
            
            param .setObject(areaLowText!+"-"+"600",forKey: "intentionSize")
        }
            else
        {
            param .setObject( areaLowText!+"-"+areaUpText!,forKey: "intentionSize")
            
        }
        
         param .setObject(arry[1], forKey: "intentionRegion")
       if countElements(houseLabelsStr)>0
       {
        param .setObject(houseLabelsStr, forKey: "intentionPurpose")
        }
        param .setObject(remarkView.text, forKey: "remark")
          Utility .showMBProgress(self.view, _message: "发送中")
         manager .postLogginHttpRequest(kClientEntry, parameters: param, queue: nil, success: { (responseObject) -> Void in
            Utility .hideMBProgress(self.view)
           
            MobClick .event("Addclientsuccess")
            if (self.myFunc != nil)
            {
                self.myFunc!()
            }
                      
            self.diclLogginDate = responseObject.dictionaryObjectForKey("data") as NSDictionary
            let code = responseObject.stringObjectForKey("status")
            if code == "2"
            {
                var alert  = UIAlertView(title: "", message: nameTextFiled.text+phoneTextField.text+"已经是我的客户，查看客户详情？", delegate: self, cancelButtonTitle: "取消", otherButtonTitles: "确定")
                
                alert.show()
                return;
            }
            else
            {
                Utility .showToastWithMessage("添加成功", _view: self.view)
                self.dismissViewControllerAnimated(true, completion: nil);
                self.navigationController?.popViewControllerAnimated(true)
            }
            
            


            }) { (code, error) -> Void in
                Utility .hideMBProgress(self.view)
                Utility .showToastWithMessage(error, _view: self.view)
            }
}
            
            else
           {
                self .editCustmomer()
            }
        }
    
    //MARK:UIAlertView代理
    func alertView(alertView: UIAlertView, clickedButtonAtIndex buttonIndex: Int)

    {
        if buttonIndex == 1
        {
            if diclLogginDate .stringObjectForKey("sourceWay") == "broker_to_client"
            {
                let vc = HWAgentCutomerVC ()
                vc.clientInfoId = diclLogginDate .stringObjectForKey("id")
                self.navigationController?.pushViewController(vc, animated: true)
            }
            
            else
            {
            let vc = HWCustomerDetailViewController()
            vc.clientInfoId = diclLogginDate.stringObjectForKey("id")
            self.navigationController?.pushViewController(vc, animated: true)
            }
        }
    }
      func editCustmomer()
        {
            var nameTextFiled = personInfoView .viewWithTag(100) as UITextField
            if  nameTextFiled.text == ""
            {
                Utility .showToastWithMessage("姓名不能为空", _view: self.view)
                return
            }
            if countElements(nameTextFiled.text) > 14
            {
                Utility .showToastWithMessage("姓名长度不能超过14字", _view: self.view)
                return
            }
            var phoneTextField = personInfoView .viewWithTag(101) as UITextField
            
            
            if countElements (phoneTextField.text) < 11 && countElements(phoneTextField.text)>0
           {
               Utility .showToastWithMessage("手机号不能小于11位", _view: self.view)
                   return
            }
            var femaleBtn =  personInfoView .viewWithTag(501) as UIButton
            var maleBtn =  personInfoView .viewWithTag(500) as UIButton
            
            if femaleBtn.imageView?.image == UIImage(named: "choose_2_2")
            {
                str = "0"
            }
            else
            {
                self.str = "1"
            }
            let manager = HWHttpRequestOperationManager.baseManager()
            var param: NSMutableDictionary! = NSMutableDictionary()
            param .setObject(HWUserLogin.currentUserLogin().key, forKey: "key")
            param .setObject(nameTextFiled.text, forKey: "name")
            param .setObject(phoneTextField.text .stringByReplacingOccurrencesOfString("-", withString: "", options: nil, range: nil) .stringByReplacingOccurrencesOfString(" ", withString: "", options: nil, range: nil), forKey: "phone")
            param.setObject(agentClientModel.clientInfoId!, forKey: "clientInfoId");
            if str == ""
            {
                Utility.showToastWithMessage("性别为空", _view: self.view)
                return
            }
             param .setObject(remarkView.text, forKey: "remark")
            param .setObject(str!,forKey: "sex")
            var btn:UIButton? =  personInfoView .viewWithTag(600) as? UIButton
            var sourceStr:NSString?
            if btn?.titleLabel?.text == "网络端口"
            {
                sourceStr = "networkPort"
            }
            else if btn?.titleLabel?.text == "CALL客"
            {
                sourceStr = "callGuest"
            }
            else  if btn?.titleLabel?.text == "巡展"
            {
                sourceStr = "tour"
            }
            else if btn?.titleLabel?.text == "派单"
            {
                sourceStr = "distributeLeaflets"
            }
            else  if btn?.titleLabel?.text == "上门客户"
            {
                sourceStr = "comeToClient"
            }
            else if btn?.titleLabel?.text == "房展会"
            {
                sourceStr = "exhibitions"
            }
            else if btn?.titleLabel?.text == "推荐"
            {
                sourceStr = "recommend"
            }
            else if btn?.titleLabel?.text == "其他"
            {
                sourceStr = "others"
            }
            else
            {
                 sourceStr = ""
            }
            param .setObject(sourceStr!, forKey: "clientSources")
            //增加等级
            var rangBtn:UIButton? =  personInfoView .viewWithTag(700) as? UIButton
            var rangBtnsourceStr:NSString?
            rangBtnsourceStr = rangBtn?.titleLabel?.text
            param .setObject(rangBtnsourceStr!,forKey: "clientLevel")
            //
            if arry[0] .isEqualToString("住宅")
            {
                param .setObject("1", forKey: "intentionCategory")
            }
            if arry[0] .isEqualToString("别墅")
                {
                    param .setObject("3", forKey: "intentionCategory")
            }
            
            if arry[0] .isEqualToString("商住")
            {
                param .setObject("2", forKey: "intentionCategory")
            }
            if arry[2] .isEqualToString("不限")
            {
                    param .setObject("0", forKey: "intentionHouseType")
            }
            if arry[2] .isEqualToString("一室")
            {
                param .setObject("1", forKey: "intentionHouseType")
            }
            if arry[2] .isEqualToString("二室")
            {
                param .setObject("2", forKey: "intentionHouseType")
            }
            if arry[2] .isEqualToString("三室")
            {
                param .setObject("3", forKey: "intentionHouseType")
            }
            if arry[2] .isEqualToString("四室")
            {
                param .setObject("4", forKey: "intentionHouseType")
            }
            if arry[2] .isEqualToString("五室以上")
            {
                param .setObject("5", forKey: "intentionHouseType")
            }
            
            var priceLowText = priceLowerLabel.text?.stringByReplacingOccurrencesOfString("万", withString: "", options: nil, range: nil)
            var priceUpText = priceUpperLabel.text?.stringByReplacingOccurrencesOfString("万", withString: "", options: nil, range: nil)
            if  priceUpperLabel.text == "不限"
                {
                param .setObject( priceLowText!+"-"+"2000",forKey: "intentionPrice")
                }
                    else
                {
                param .setObject( priceLowText!+"-"+priceUpText!,forKey: "intentionPrice")
                
            }
            var areaLowText = houseLowerLabel.text?.stringByReplacingOccurrencesOfString("㎡", withString: "", options: nil, range: nil)
            var areaUpText = houseupperLabel.text?.stringByReplacingOccurrencesOfString("㎡", withString: "", options: nil, range: nil)
            if  houseupperLabel.text == "不限"
                {
                        
                    param .setObject(areaLowText!+"-"+"600",forKey: "intentionSize")
                }
            else
              {
                    param .setObject( areaLowText!+"-"+areaUpText!,forKey: "intentionSize")
                
               }
            
            param .setObject(arry[1], forKey: "intentionRegion")
            if countElements(houseLabelsStr)>0
            {
                param .setObject(houseLabelsStr, forKey: "intentionPurpose")
            }
            Utility .showMBProgress(self.view, _message: "请求中")
            manager .postHttpRequest(kClientEdit, parameters: param, queue: nil, success: { (responseObject) -> Void in
                    Utility .hideMBProgress(self.view)
                    Utility .showToastWithMessage("请求成功", _view: self.view)
                if (self.myFunc != nil)
                {
                    self.myFunc!()
                }
                if(self.navigationController == nil)
                {
                    self.dismissViewControllerAnimated(true, completion: nil);
                }
                else
                {
                    self.navigationController?.popViewControllerAnimated(true)
                }
                
                }) { (code, error) -> Void in
                Utility .hideMBProgress(self.view)
                Utility .showToastWithMessage(error, _view: self.view)
            }
    }
    
    //MARK:点击cell标签从cell传过来的
    func didSelecttedBtn(index:String)
    {
            houseLabelsStr = index
    }
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
