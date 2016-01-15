//
//  HWCreateOrganizationSuccessViewController.swift
//  Partner-Swift
//
//  Created by hw500028 on 15/2/27.
//  Copyright (c) 2015年 caijingpeng.haowu. All rights reserved.
//

import UIKit

class HWCreateOrganizationSuccessViewController: HWBaseViewController {
    var addShopBtn:UIButton?
    var loginAdminBtn:UIButton?
    override func loadView() {
        self.view = UIView(frame: CGRect(x: 0, y: 0, width: kScreenWidth, height: UIScreen.mainScreen().bounds.size.height))
        self.view.backgroundColor = CD_BackGroundColor
        
    }
    override func viewDidLoad() {
        super.viewDidLoad()        
        let hwImageView = UIImageView.newAutoLayoutView()
        self.view.addSubview(hwImageView)
        hwImageView.autoPinEdgeToSuperviewEdge(ALEdge.Top, withInset: 35 * kScreenRate)
        hwImageView.autoSetDimensionsToSize(CGSize(width: 60, height: 60))
        hwImageView.autoAlignAxisToSuperviewAxis(ALAxis.Vertical)
        hwImageView.image = UIImage(named: "success")
        //
        let hwlabel1 = UILabel.newAutoLayoutView()
        self.view.addSubview(hwlabel1)
        hwlabel1.autoPinEdge(ALEdge.Top, toEdge: ALEdge.Bottom, ofView: hwImageView, withOffset: 20)
        hwlabel1.autoAlignAxisToSuperviewAxis(ALAxis.Vertical)
        hwlabel1.text = "恭喜, 创建机构申请提交成功"
        hwlabel1.textColor = UIColor.orangeColor()
        hwlabel1.font = Define.font(TF_15)
        //
        let hwlabel2 = UILabel.newAutoLayoutView()
        self.view.addSubview(hwlabel2)
        hwlabel2.autoPinEdge(ALEdge.Top, toEdge: ALEdge.Bottom, ofView: hwlabel1, withOffset: 15)
        hwlabel2.autoAlignAxisToSuperviewAxis(ALAxis.Vertical)
        hwlabel2.textColor = CD_Txt_Color_99
        hwlabel2.text = "审核通过之后就可以推荐用户"
        hwlabel2.font = Define.font(TF_13)
        
        //
        let hwlabel3 = UILabel.newAutoLayoutView()
        self.view.addSubview(hwlabel3)
        hwlabel3.autoPinEdge(ALEdge.Top, toEdge: ALEdge.Bottom, ofView: hwlabel2, withOffset: 50)
        hwlabel3.autoAlignAxisToSuperviewAxis(ALAxis.Vertical)
        hwlabel3.text = "您可以"
        hwlabel3.font = Define.font(TF_15)
        hwlabel3.textColor = CD_Txt_Color_99
        //添加门店按钮
        addShopBtn = UIButton.newAutoLayoutView()
        self.view.addSubview(addShopBtn!)
        addShopBtn?.autoPinEdge(ALEdge.Top, toEdge: ALEdge.Bottom, ofView: hwlabel3, withOffset: 20)
        addShopBtn?.autoAlignAxisToSuperviewAxis(ALAxis.Vertical)
        addShopBtn?.autoSetDimensionsToSize(CGSize(width: kScreenWidth - 30, height: 45))
        Utility.buttonStyle(addShopBtn!, color: CD_Btn_MainColor, title: "添加门店")
        addShopBtn?.addTarget(self, action: "addShopAction", forControlEvents: UIControlEvents.TouchUpInside)
        
        //进入管理员按钮
        loginAdminBtn = UIButton.newAutoLayoutView()
        self.view.addSubview(loginAdminBtn!)
        loginAdminBtn?.autoPinEdge(ALEdge.Top, toEdge: ALEdge.Bottom, ofView: addShopBtn, withOffset: 25)
        loginAdminBtn?.autoAlignAxisToSuperviewAxis(ALAxis.Vertical)
        loginAdminBtn?.setTitle("直接进入管理员首页", forState: UIControlState.Normal)
        loginAdminBtn?.backgroundColor = UIColor.clearColor()
        loginAdminBtn?.setTitleColor(UIColor.blackColor(), forState: UIControlState.Normal)
        loginAdminBtn?.titleLabel?.font = Define.font(TF_13)
        loginAdminBtn?.addTarget(self, action: "loginAdminBtnAction", forControlEvents: UIControlEvents.TouchUpInside)

        
    }

    //MARK:---Actions
    func addShopAction()->Void
    {
        let organizationCtrl = HWOrganizationViewController()
        organizationCtrl.ctrlType = ControllerType.addShop
        self.navigationController?.pushViewController(organizationCtrl, animated: true)
        
    }
    func loginAdminBtnAction()->Void
    {
        let organizationCtrl = HWOrganizationViewController()
        organizationCtrl.ctrlType = ControllerType.typeNone
        self.navigationController?.pushViewController(organizationCtrl, animated: true)
    
    }
    
}
