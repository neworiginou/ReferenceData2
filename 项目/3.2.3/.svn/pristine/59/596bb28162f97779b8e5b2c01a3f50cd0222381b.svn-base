//
//  HWLoginViewController.swift
//  Partner-Swift
//
//  Created by hw500028 on 15/2/25.
//  Copyright (c) 2015年 caijingpeng.haowu. All rights reserved.
//

import UIKit

enum IsAutoLogin
{
    case isAuto
    case notAuto
}

class HWLoginViewController: HWBaseViewController,UIScrollViewDelegate,UITextFieldDelegate,HWEyeOpenViewDelegate,HWCustomActionSheetDelegate,UIAlertViewDelegate,UITableViewDelegate,UITableViewDataSource {
    let headerViewheight = ((500/1334) * (contentHeight + 64))
    let footerViewHeight = UIScreen.mainScreen().bounds.size.height - 44 - ((500/1334) * UIScreen.mainScreen().bounds.size.height)
    var headerView:UIView?
    var footerView:UIView?
    var loginView:HWBaseRefreshView!
    var telTF:UITextField?                     //姓名输入
    var passWordTF:UITextField?                 //密码输入
    var autoLogin:IsAutoLogin = IsAutoLogin.notAuto
//    var organizationCtrl = HWOrganizationViewController()
    override func viewWillDisappear(animated: Bool) {
        super.viewWillDisappear(animated)
        self.navigationController?.navigationBarHidden = false

    }
    override func viewWillAppear(animated: Bool) {
        if autoLogin == IsAutoLogin.isAuto
        {
            let organizationCtrl = HWOrganizationViewController()
            self.navigationController?.pushViewController(organizationCtrl, animated: false)
            self.autoLogin = IsAutoLogin.notAuto
        }

        self.navigationController?.navigationBarHidden = true
        let userDefault = NSUserDefaults.standardUserDefaults()
        if userDefault.objectForKey(kLastLoginTel) != nil
        {
            telTF?.text = userDefault.objectForKey(kLastLoginTel) as String

        }
        passWordTF?.text = ""

    }
    override func viewDidLoad() {
        super.viewDidLoad()
        loginView = HWBaseRefreshView(frame: CGRect(x: 0, y: 0, width: kScreenWidth, height: contentHeight + 64))
        self.view.addSubview(loginView)
        loginView.baseTable.dataSource = self
        loginView.baseTable.delegate = self
        let image = UIImage(named: "login_bg")
        let backGImgV = UIImageView(frame: UIScreen.mainScreen().bounds)
        backGImgV.image = image
        self.view.addSubview(backGImgV)
        self.view.sendSubviewToBack(backGImgV)
        loginView.baseTable.tableHeaderView = headerViewFunc()
        loginView.baseTable.tableFooterView = footerViewFunc()
        loginView.setIsNeedHeadRefresh(false)
        loginView.backgroundColor = UIColor.clearColor()
        loginView.baseTable.rowHeight = 88
        let userDefault = NSUserDefaults.standardUserDefaults()
        if userDefault.objectForKey("firstLogin") == nil
            
        {
        
            let guide = HWGuideView(frame:CGRect(x: 0, y: 0, width:kScreenWidth, height: contentHeight + 64))
            view.addSubview(guide)
            guide.scrollend = {
                UIView.transitionFromView(guide, toView: self.loginView, duration: 0.5, options: UIViewAnimationOptions.TransitionFlipFromLeft, completion: nil)
                userDefault.setValue("1", forKey: "firstLogin")
                userDefault.synchronize()
            }
        }


    }

    func headerViewFunc()->UIView
    {
        if headerView == Optional.None
        {
            headerView = UIView(frame: CGRect(x: 0, y: 0, width: kScreenWidth, height: headerViewheight))
            let iconImageView = UIImageView.newAutoLayoutView()
            headerView?.addSubview(iconImageView)
            let gesture = UITapGestureRecognizer(target: self, action: "hideKeyboard")
            headerView?.addGestureRecognizer(gesture)
            iconImageView.autoCenterInSuperview()
            iconImageView.autoSetDimensionsToSize(CGSize(width: 100, height: 100))
            iconImageView.layer.cornerRadius = 50
            iconImageView.clipsToBounds = true
            iconImageView.backgroundColor = UIColor.clearColor()
            
            let userDefault = NSUserDefaults.standardUserDefaults()
            var picKey:String? = userDefault.objectForKey(kLastLoginPicKey) as? String
            
            if picKey == nil
            {
                picKey = ""
                
            }
             let url = NSURL(string:Utility.imageDownloadWithMongoDbKey(picKey!))
            iconImageView.setImageWithURL(url, placeholderImage: headPlaceHolderImage){ (image, error, imageCacheType) -> Void in
                if (error != nil)
                {
                    iconImageView.image = headFailedImage
                }
                else
                {
                    iconImageView.image = image
                }
            }
            
        }
        return headerView!
    }
    
    func footerViewFunc()->UIView
    {
        if footerView == nil
        {
            footerView = UIView(frame: CGRect(x: 0, y: 0, width: kScreenWidth, height: footerViewHeight))
            footerView?.backgroundColor = UIColor.clearColor()
            
            //登录按钮
            let loginBtn = UIButton.newAutoLayoutView()
            footerView!.addSubview(loginBtn)
            loginBtn.autoPinEdgesToSuperviewEdgesWithInsets(UIEdgeInsets(top: 42, left: 15, bottom: 0, right: 15), excludingEdge: ALEdge.Bottom)
            Utility.buttonStyle(loginBtn, color: CD_Btn_MainColor, title: "登录")
            loginBtn.addTarget(self, action: "login", forControlEvents: UIControlEvents.TouchUpInside)
            
            //忘记密码
            
            let forgetPassWord = UIButton.newAutoLayoutView()
            footerView?.addSubview(forgetPassWord)
            forgetPassWord.setTitle("忘记密码?", forState: UIControlState.Normal)
            forgetPassWord.autoPinEdge(ALEdge.Top, toEdge: ALEdge.Bottom, ofView: loginBtn, withOffset: 15)
            forgetPassWord.autoAlignAxis(ALAxis.Vertical, toSameAxisOfView: loginBtn)
            forgetPassWord.titleLabel?.font = UIFont.systemFontOfSize(TF_13)
            forgetPassWord.addTarget(self, action: "forgetPassWordFunc", forControlEvents: UIControlEvents.TouchUpInside)
            //            forgetPassWord.titleLabel?.textColor = UIColor.blackColor()
            forgetPassWord.setTitleColor(UIColor.blackColor(), forState: UIControlState.Normal)
            //申请
            let applyAccountBtn = UIButton.newAutoLayoutView()
            footerView?.addSubview(applyAccountBtn)
            applyAccountBtn.setTitle("没有帐号?申请加入好屋合伙人", forState: UIControlState.Normal)
            applyAccountBtn.autoAlignAxisToSuperviewAxis(ALAxis.Vertical)
            applyAccountBtn.autoPinEdgeToSuperviewEdge(ALEdge.Bottom, withInset: 80)
            applyAccountBtn.titleLabel?.font = UIFont.systemFontOfSize(TF_13)
            applyAccountBtn.setTitleColor(UIColor.blackColor(), forState: UIControlState.Normal)
            applyAccountBtn.addTarget(self, action: "register", forControlEvents: UIControlEvents.TouchUpInside)
            
            //线条
            let line = UIView.newAutoLayoutView()
            footerView?.addSubview(line)
            line.autoPinEdgeToSuperviewEdge(ALEdge.Left, withInset: 60)
            line.autoPinEdgeToSuperviewEdge(ALEdge.Right, withInset: 60)
            line.autoPinEdge(ALEdge.Bottom, toEdge: ALEdge.Top, ofView: applyAccountBtn)
            line.autoSetDimension(ALDimension.Height, toSize: 0.5)
            line.backgroundColor = CD_LoginLineColor
        }
        return footerView!
    }

    
    //MARK:----tableViewDelegate
      func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
     func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let identify = "loginCell"
        var cell:UITableViewCell? = tableView.dequeueReusableCellWithIdentifier(identify) as? UITableViewCell
        if cell == nil
        {
            cell = UITableViewCell(style: UITableViewCellStyle.Default, reuseIdentifier: identify)

                let backView = UIView.newAutoLayoutView()
                cell?.contentView.addSubview(backView)
                backView.autoPinEdgesToSuperviewEdgesWithInsets(UIEdgeInsets(top: 0, left: 15, bottom: 0, right: 15))
                backView.layer.cornerRadius = 3.0
                backView.layer.masksToBounds = true
                backView.backgroundColor = UIColor.whiteColor()
            
                //电话输入框
                telTF = UITextField.newAutoLayoutView()
                backView.addSubview(telTF!)
                telTF?.autoPinEdgesToSuperviewEdgesWithInsets(UIEdgeInsets(top: 0, left: 15, bottom: 0, right: 0), excludingEdge: ALEdge.Bottom)
                telTF?.autoSetDimension(ALDimension.Height, toSize: 44)
                telTF!.placeholder = "请输入电话号码"
                telTF!.font = Define.font(TF_15)
                telTF?.delegate = self
                telTF!.keyboardType = UIKeyboardType.NumberPad
            
                let userDefault = NSUserDefaults.standardUserDefaults()
                if userDefault.objectForKey(kLastLoginTel) != nil
                {
                    let tel:String =  userDefault.objectForKey(kLastLoginTel) as String
                    telTF?.text = tel
                }
                telTF?.backgroundColor = UIColor.clearColor()
                //密码框
                passWordTF = UITextField.newAutoLayoutView()
                backView.addSubview(passWordTF!)
                passWordTF?.autoPinEdgesToSuperviewEdgesWithInsets(UIEdgeInsets(top: 44, left: 15, bottom: 0, right: 0), excludingEdge: ALEdge.Top)
                passWordTF?.autoSetDimension(ALDimension.Height, toSize: 44)
                passWordTF?.placeholder = "请输入密码"
                passWordTF?.font = Define.font(TF_15)
                passWordTF?.delegate = self
                passWordTF?.secureTextEntry = true
                passWordTF?.backgroundColor = UIColor.clearColor()
                //密码可见按钮
                var passWordVisibleBtn = HWEyeOpenView(frame: CGRect(x: kScreenWidth - 47 - 15, y: 44, width: 47, height: 44))
                cell?.contentView.addSubview(passWordVisibleBtn)
                passWordVisibleBtn.delegate  = self
                passWordTF!.drawTopLine()
        }
    
        cell!.contentView.backgroundColor = UIColor.clearColor()
        cell!.backgroundColor = UIColor.clearColor()
        cell?.selectionStyle = UITableViewCellSelectionStyle.None
        return cell!
        
    }
    
    func scrollViewDidScroll(scrollView: UIScrollView) {
        self.view.endEditing(true)
    }
    

    //MARK:----Actions
    //忘记密码按钮
    func forgetPassWordFunc()->Void
    {
        MobClick.event("Forgetpassword_click")

        let forgetPasswordCtrl = HWForgetPasswordController()
        self.navigationController?.pushViewController(forgetPasswordCtrl, animated: true)

        
    }
    
    //登录按钮
    func login()->Void
    {


        self.view.endEditing(true)
        if Utility.validateMobile(telTF!.text!) == false
        {
            Utility.showToastWithMessage("请输入正确的电话号码", _view: self.view)
            return
        }
        if passWordTF!.text!.isEmpty
        {
            Utility.showToastWithMessage("密码不能为空", _view: self.view)
            return
        }
        Utility.showMBProgress(view!, _message: "登录中")

        /*
        phone:*** - 手机号
        password:*** - 密码(APP端MD5加密后传入)
        */
        var params = ["phone":telTF!.text!,"password":passWordTF!.text!.md5]
        var manager = HWHttpRequestOperationManager.baseManager()
            manager.postHttpRequest(kLogin, parameters: params, queue: nil, success: { (responseObject) -> Void in
           
                Utility.hideMBProgress(self.view)
                let dataDic:NSDictionary = responseObject.objectForKey("data") as NSDictionary
                HWUserLogin.currentUserLogin().initUserLogin(dataDic)
                HWUserLogin.currentUserLogin().key = responseObject.objectForKey("key") as String
                HWCoreDataManager.saveUserInfo()
                
                APService.setTags(NSSet(object: HWUserLogin.currentUserLogin().cityName), alias: HWUserLogin.currentUserLogin().brokerTel, callbackSelector: nil, object: nil)

                let identitys:NSArray = dataDic.objectForKey("identitys") as  NSArray
                if identitys.count > 1
                {
                    self.loginActionsheet()

                }
                else
                {
         //经纪人登录
                    if (HWUserLogin.currentUserLogin().code == "1001")
                    {
                        let tabbar = HWTabbarViewController()
                        shareAppDelegate.tabbarNav = HWBaseNavigationController(rootViewController: tabbar)
                        Utility.transController(currentNav, newCtrl: shareAppDelegate.tabbarNav!)
                        let userDefault = NSUserDefaults.standardUserDefaults()
                        userDefault.setObject("broker", forKey: kLastLoginRole)
                        userDefault.synchronize()

                    }
                    if (HWUserLogin.currentUserLogin().code == "1002")
                    {
                        let organizationCtrl = HWOrganizationViewController()
                        self.navigationController?.pushViewController(organizationCtrl, animated: true)
                        let userDefault = NSUserDefaults.standardUserDefaults()
                        userDefault.setObject("admin", forKey: kLastLoginRole)
                        userDefault.synchronize()
                    }

                }
                
                let userDefault = NSUserDefaults.standardUserDefaults()
                userDefault.setObject(self.telTF!.text!, forKey: kLastLoginTel)
                userDefault.synchronize()
                
                
            }) { (code, error) -> Void in
                Utility.hideMBProgress(self.view)
                if (error.isEqualToString("该用户不是机构经纪人") || error.isEqualToString("该经纪人不是机构成员") || error.isEqualToString("用户不存在，马上注册?"))
                {
                    let alertView = UIAlertView(title: "提示", message: "用户不存在,马上注册?", delegate: self, cancelButtonTitle: "取消", otherButtonTitles: "确定")
                    alertView.show()
                    
                }
                else
                {
                    Utility.showToastWithMessage(error, _view: self.view)
   
                }
                
        }
        
    }
    //注册
    func register()->Void
    {
            MobClick.event("Institutions-apply_click") //埋点
            registerActionsheet()
    }
    
    //MARK:---alertViewDelegate
    func alertView(alertView: UIAlertView, clickedButtonAtIndex buttonIndex: Int) {
        if buttonIndex == 1
        {
            registerActionsheet()
        }
        
        
    }

    func loginActionsheet()
    {
        let customSheet = HWCustomActionSheet(frame: shareAppDelegate.window!.bounds)
        customSheet.customAction("请选择角色登录", cancelButtonTitle: "取消", otherBUttonTitles: ["经纪人登录","机构管理员登录"])
        customSheet.delegate = self
        customSheet.tag = 100
        customSheet.show(shareAppDelegate.window!)

    }
    
    func registerActionsheet()
    {
        let customSheet = HWCustomActionSheet(frame: shareAppDelegate.window!.bounds)
        customSheet.customAction("", cancelButtonTitle: "取消", otherBUttonTitles: ["个人加入门店","创建机构"])
        //customSheet.customAction("个人加入门店", cancelButtonTitle: "取消", otherBUttonTitles: ["创建机构"])
        customSheet.show(shareAppDelegate.window!)
        customSheet.tag = 101
        customSheet.delegate = self

    }
    
    func hideKeyboard()
    {
        self.view.endEditing(true)
    }
    
    override func touchesBegan(touches: NSSet, withEvent event: UIEvent) {
        self.view.endEditing(true)
    }
    

}
extension HWLoginViewController:UITextFieldDelegate
{
    func textField(textField: UITextField, shouldChangeCharactersInRange range: NSRange, replacementString string: String) -> Bool {
        if (textField == telTF)
        {
            if range.location >= 11 && range.length == 0
            {
                return false
            }
        }
        if (textField == passWordTF)
        {
            if range.location >= 20 && range.length == 0
            {
                return false
            }
        }
        
        return true
    }
}

extension HWLoginViewController:HWEyeOpenViewDelegate
{
    func hwEyeCloseSate() {
        passWordTF?.secureTextEntry = true
        let str = passWordTF?.text
        passWordTF?.text = nil
        passWordTF?.text = str
    }
    
    func hwEyeOpenSate() {
        passWordTF?.secureTextEntry = false
        let str = passWordTF?.text
        passWordTF?.text = nil
        passWordTF?.text = str
        
    }

}

extension HWLoginViewController:HWCustomActionSheetDelegate
{
    func customActionSheet(actionSheet: HWCustomActionSheet, didSelectButtonIndex index: NSInteger) {
        if actionSheet.tag == 100
        {
            //经纪人登录
            if index == 0
            {
                let tabbar = HWTabbarViewController()
                var tabbarNav = HWBaseNavigationController(rootViewController: tabbar)
                Utility.transController(currentNav, newCtrl: tabbarNav)
                let userDefault = NSUserDefaults.standardUserDefaults()
                userDefault.setObject("broker", forKey: kLastLoginRole)
                userDefault.synchronize()

            }
            if index == 1
            {
                let organizationCtrl = HWOrganizationViewController()
                self.navigationController?.pushViewController(organizationCtrl, animated: true)
                let userDefault = NSUserDefaults.standardUserDefaults()
                userDefault.setObject("admin", forKey: kLastLoginRole)
                userDefault.synchronize()

                
            }
        }
        if actionSheet.tag == 101
        {
            if index == 0
            {
                let personRegisterCtrl = HWPersonRegisterViewController()
                self.navigationController?.pushViewController(personRegisterCtrl, animated: true)
                
                
            }
            if index == 1
            {
                
                let createOrganizationCtrl = HWCreateOrganizationViewController()
                self.navigationController?.pushViewController(createOrganizationCtrl, animated: true)
                
            }
        }
    }
    
}

