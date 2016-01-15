//
//  HWCreateOrganizationViewController.swift
//  Partner-Swift
//
//  Created by hw500028 on 15/2/26.
//  Copyright (c) 2015年 caijingpeng.haowu. All rights reserved.
//

import UIKit

class HWCreateOrganizationViewController: HWBaseViewController,UITableViewDataSource,UITableViewDelegate {
    
    var cityLabel:UILabel?
    var organizationNameTF:UITextField?
    var agreeBtn:UIButton?
    var nextStepBtn:UIButton?
    var cityID = ""
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationItem.titleView = Utility.navTitleView("创建机构")
        var createOrganizationView = HWBaseRefreshView(frame: CGRect(x: 0, y: 0, width: kScreenWidth, height:  contentHeight-50))
        self.view.addSubview(createOrganizationView)
        createOrganizationView.baseTable.tableFooterView = footerViewFunc()
        createOrganizationView.baseTable.dataSource = self
        createOrganizationView.baseTable.delegate = self
        self.customerPhoneView();
        
    }
    func customerPhoneView()->Void
    {
        let footerViewPhone = UIView(frame: CGRect(x: 0, y: contentHeight-50, width: kScreenWidth, height: 50))
        footerViewPhone.backgroundColor = UIColor.whiteColor();
        self.view.addSubview(footerViewPhone);
        
        var tapGesture:UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: "chickPhone");
        footerViewPhone.addGestureRecognizer(tapGesture);
        
        let width = kScreenWidth/3.0;
        var customerTipLabel:UILabel = UILabel(frame: CGRectMake(0, 15, width, 20));
        customerTipLabel.text = "客服热线:";
        customerTipLabel.textColor = CD_Txt_Color_33;
        customerTipLabel.font = Define.font(15.0);
        customerTipLabel.textAlignment = NSTextAlignment.Right;
        footerViewPhone.addSubview(customerTipLabel);
        
        
        var phoneLabel:UILabel = UILabel(frame: CGRectMake(width, 15, width, 20));
        phoneLabel.text = "400-096-2882";
        phoneLabel.textColor = CD_OrangeColor;
        phoneLabel.font = Define.font(15.0);
        phoneLabel.textAlignment = NSTextAlignment.Center;

        footerViewPhone.addSubview(phoneLabel);
        
        
        
        var phoneIconImageV:UIImageView = UIImageView(frame: CGRectMake(2 * width, 9, 32, 32));
        phoneIconImageV.image = UIImage(named: "phone2");
        footerViewPhone.addSubview(phoneIconImageV);
    }
    func chickPhone()->Void
    {
        var callWebView = UIWebView()
        var telUrl = NSURL(string: "tel://"+"4000962882")
        callWebView .loadRequest(NSURLRequest(URL:telUrl!))

    }
    func footerViewFunc()->UIView
    {
        let footerView = UIView(frame: CGRect(x: 0, y: 0, width: kScreenWidth, height: 200))
        agreeBtn = UIButton.newAutoLayoutView()
        footerView.addSubview(agreeBtn!)
        agreeBtn?.autoPinEdgeToSuperviewEdge(ALEdge.Left, withInset: 15)
        agreeBtn?.autoPinEdgeToSuperviewEdge(ALEdge.Top, withInset: 15)
        agreeBtn?.autoSetDimensionsToSize(CGSize(width: 15, height: 15))
        agreeBtn?.setBackgroundImage(Utility.imageWithColor(CD_Txt_Color_99, _size: CGSize(width: 15, height: 15)), forState: UIControlState.Normal)
        agreeBtn?.selected = false
        agreeBtn?.addTarget(self, action: "agreeBtnClick:", forControlEvents: UIControlEvents.TouchUpInside)
        //
        let hwbutton = UIButton.newAutoLayoutView()
        footerView.addSubview(hwbutton)
        hwbutton.autoPinEdge(ALEdge.Left, toEdge: ALEdge.Right, ofView: agreeBtn, withOffset: 5)
        var attributeStr = NSMutableAttributedString(string: "已阅读并同意 <<好屋机构加入协议>>")
        attributeStr.addAttribute(NSForegroundColorAttributeName, value: UIColor.orangeColor(), range: NSMakeRange(7, 12))
        hwbutton.setAttributedTitle(attributeStr, forState: UIControlState.Normal)
        hwbutton.autoAlignAxis(ALAxis.Horizontal, toSameAxisOfView: agreeBtn)
        hwbutton.titleLabel?.font = Define.font(TF_14)
        hwbutton.addTarget(self, action: "agreementBtnAction", forControlEvents: UIControlEvents.TouchUpInside)
        //
        nextStepBtn = UIButton.newAutoLayoutView()
        footerView.addSubview(nextStepBtn!)
        nextStepBtn!.autoPinEdge(ALEdge.Top, toEdge: ALEdge.Bottom, ofView:agreeBtn, withOffset: 30)
        nextStepBtn!.autoPinEdgeToSuperviewEdge(ALEdge.Left, withInset: 15)
        nextStepBtn!.autoPinEdgeToSuperviewEdge(ALEdge.Right, withInset: 15)
        nextStepBtn!.autoSetDimension(ALDimension.Height, toSize: 45)
        Utility.buttonStyle(nextStepBtn!, color: CD_Txt_Color_99, title: "下一步")
        nextStepBtn?.userInteractionEnabled = false
        nextStepBtn!.addTarget(self, action: "nextStepAction:", forControlEvents: UIControlEvents.TouchUpInside)
          
        return footerView
    }
    
    //MARK:tableViewDelegate
    
    func tableView(tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 30
    }
    func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        return 44
    }
    
     func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 2
    }
    func tableView(tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let hwView = UIView(frame: CGRect(x: 0, y: 0, width: kScreenWidth, height: 30 * kScreenRate))
        hwView.backgroundColor = UIColor.clearColor()
        
        let hwLabel = UILabel.newAutoLayoutView()
        hwView.addSubview(hwLabel)
        hwLabel.autoPinEdgesToSuperviewEdgesWithInsets(UIEdgeInsets(top: 0, left: 15, bottom: 0, right: 0))
        hwLabel.text = "机构信息"
        hwLabel.font = Define.font(TF_13)
        hwLabel.textColor = CD_Txt_Color_99
        hwView.drawBottomLine()
        return hwView
    }
    
     func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let identify = "cell\(indexPath.row)"
        var cell:HWDefaultCell? = tableView.dequeueReusableCellWithIdentifier(identify) as? HWDefaultCell
        if cell == nil
        {
            cell = HWDefaultCell(style: UITableViewCellStyle.Default, reuseIdentifier: identify)
            if indexPath.row == 0
            {
                let hwlabel = UILabel.newAutoLayoutView()
                cell?.contentView.addSubview(hwlabel)
                hwlabel.autoPinEdgesToSuperviewEdgesWithInsets(UIEdgeInsets(top: 0, left: 15, bottom: 0, right: 0), excludingEdge: ALEdge.Right)
                hwlabel.textColor = CD_Txt_Color_99
                hwlabel.font = Define.font(TF_15)
                hwlabel.text = "业务城市"
                //
                cityLabel = UILabel.newAutoLayoutView()
                cell?.contentView.addSubview(cityLabel!)
                cityLabel?.autoPinEdge(ALEdge.Right, toEdge: ALEdge.Left, ofView: cell!.accessoryImgV, withOffset: -5)
                cityLabel?.autoAlignAxisToSuperviewAxis(ALAxis.Horizontal)
                cityLabel?.text = "上海"
                cityLabel?.font = Define.font(TF_15)
            }
            if indexPath.row == 1
            {
                organizationNameTF = UITextField.newAutoLayoutView()
                cell?.contentView.addSubview(organizationNameTF!)
                organizationNameTF?.autoPinEdgesToSuperviewEdgesWithInsets(UIEdgeInsets(top: 0, left: 15, bottom: 0, right: 0))
                organizationNameTF?.font = Define.font(TF_15)
                organizationNameTF?.textColor = CD_Txt_Color_99
                organizationNameTF?.placeholder = "机构名称"
                cell!.accessoryImgV.removeFromSuperview()
            }
            
            cell?.contentView.drawBottomLine()
        }
        
        return cell!
    }
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        
        tableView.deselectRowAtIndexPath(indexPath, animated: true)

        if indexPath.row == 0
        {
            
            let cityListCtrl = HWTeamworkCityListController()
            self.navigationController?.pushViewController(cityListCtrl, animated: true)
            cityListCtrl.selectCityCell = { cityName in
            self.cityLabel!.text = cityName
                
            }
        }
    }
    
    //MARK:---Actions
    //同意协议
    func agreementBtnAction()->Void
    {
        let agreementCtrl = HWAgreementController()
        agreementCtrl.agreement = {
            self.agreeBtn?.selected = false
            self.agreeBtnClick(self.agreeBtn!)
        }
        navigationController?.pushViewController(agreementCtrl, animated: true)
    }
    
    
    func agreeBtnClick(btn:UIButton)->Void
    {
        btn.selected = !btn.selected
        if btn.selected == true
        {
            agreeBtn?.setBackgroundImage(UIImage(named: "choose_1_2"), forState: UIControlState.Selected)
            nextStepBtn?.setBackgroundImage(Utility.imageWithColor(CD_Btn_MainColor, _size: CGSize(width: kScreenWidth - 30, height: 45)), forState: UIControlState.Normal)
            nextStepBtn?.userInteractionEnabled = true
            
        }
        if btn.selected == false
        {
            agreeBtn?.setBackgroundImage(Utility.imageWithColor(CD_Txt_Color_99, _size: CGSize(width: 15, height: 15)), forState: UIControlState.Normal)
            nextStepBtn?.setBackgroundImage(Utility.imageWithColor(CD_Txt_Color_99, _size: CGSize(width: kScreenWidth - 30, height: 45)), forState: UIControlState.Normal)
            nextStepBtn?.userInteractionEnabled = false
        }
    }
    
    //下一步
    func nextStepAction(btn:UIButton)->Void
    {
        if organizationNameTF!.text!.isEmpty
        {
            Utility.showToastWithMessage("机构名称不能为空", _view: self.view)
            return
        }
        
        if cityLabel?.text == "上海"
        {
            HWUserLogin.currentUserLogin().cityId = "52"
            HWCoreDataManager.saveUserInfo()
        }
        
        let createOrganizationViewNextStepCtrl = HWCreateOrganizationNextStepViewController()
        self.navigationController?.pushViewController(createOrganizationViewNextStepCtrl, animated: true)
        createOrganizationViewNextStepCtrl.cityId = cityLabel!.text!
        createOrganizationViewNextStepCtrl.orgName = organizationNameTF!.text
    }

    func scrollViewDidScroll(scrollView: UIScrollView) {
        view.endEditing(true)
    }
    
}
