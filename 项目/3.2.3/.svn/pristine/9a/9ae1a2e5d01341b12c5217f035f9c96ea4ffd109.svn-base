//
//  HWInviteViewController.swift
//  Partner-Swift
//
//  Created by hw500029 on 15/2/27.
//  Copyright (c) 2015年 caijingpeng.haowu. All rights reserved.
//

import UIKit

class HWInviteViewController: HWBaseViewController,MTCustomActionSheetDelegate,UIAlertViewDelegate {

    var QRCodeImgView:UIImageView?
    var invitationCodeLabel:UILabel?
    var shareBtn:UIButton?
    var introduceLabel:UILabel?
    
    var invitationCode:NSString?
    var QRCodePicKey:NSString?
    var shareTitle:NSString?
    var shareContent:NSString?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.navigationItem.titleView = Utility.navTitleView("邀请好友")
        
        let topView = UIView.newAutoLayoutView()
        topView.backgroundColor = UIColor.whiteColor()
        self.view.addSubview(topView)
        topView.autoPinEdgesToSuperviewEdgesWithInsets(UIEdgeInsetsMake(0, 0, 0, 0), excludingEdge: ALEdge.Bottom)
        topView.autoSetDimension(ALDimension.Height, toSize: 280 * kScreenRate)
        
        let topTitleLaebel = UILabel.newAutoLayoutView()
        topTitleLaebel.backgroundColor = UIColor.clearColor()
        topTitleLaebel.textColor = CD_Txt_Color_66
        topTitleLaebel.font = Define.font(TF_13)
        topTitleLaebel.textAlignment = NSTextAlignment.Center
        topView.addSubview(topTitleLaebel)
        topTitleLaebel.autoPinEdgesToSuperviewEdgesWithInsets(UIEdgeInsetsMake(0, 0, 0, 0), excludingEdge: ALEdge.Bottom)
        topTitleLaebel.autoSetDimension(ALDimension.Height, toSize: 45 * kScreenRate)
        topTitleLaebel.text = "扫一扫"
        
        QRCodeImgView = UIImageView.newAutoLayoutView()
        QRCodeImgView?.backgroundColor = UIColor.clearColor()
        topView.addSubview(QRCodeImgView!)
        QRCodeImgView?.autoAlignAxisToSuperviewAxis(ALAxis.Vertical)
        QRCodeImgView?.autoPinEdge(ALEdge.Top, toEdge: ALEdge.Bottom, ofView: topTitleLaebel)
        QRCodeImgView?.autoSetDimension(ALDimension.Height, toSize: 160 * kScreenRate)
        QRCodeImgView?.autoSetDimension(ALDimension.Width, toSize: 160 * kScreenRate)
        
        introduceLabel = UILabel.newAutoLayoutView()
        introduceLabel?.backgroundColor = UIColor.clearColor()
        introduceLabel?.textColor = CD_Txt_Color_66
        introduceLabel?.font = Define.font(TF_13)
        introduceLabel?.textAlignment = NSTextAlignment.Center
        introduceLabel?.numberOfLines = 0
        topView.addSubview(introduceLabel!)
        introduceLabel?.autoSetDimension(ALDimension.Width, toSize: 230 * kScreenRate)
        introduceLabel?.autoPinEdge(ALEdge.Top, toEdge: ALEdge.Bottom, ofView: QRCodeImgView)
        introduceLabel?.autoPinEdge(ALEdge.Bottom, toEdge: ALEdge.Bottom, ofView: topView)
        introduceLabel?.autoAlignAxisToSuperviewAxis(ALAxis.Vertical)
        //introduceLabel?.text = "邀请好友通过我分享的邀请码注册成功，推荐客户买房可获得高额佣金。"
        introduceLabel?.text = "扫描二维码,快速注册为我的下线"
        
        invitationCodeLabel = UILabel.newAutoLayoutView()
        invitationCodeLabel?.font = Define.font(TF_14)
        invitationCodeLabel?.textColor = CD_Txt_Color_66
        invitationCodeLabel?.textAlignment = NSTextAlignment.Center
        self.view.addSubview(invitationCodeLabel!)
        invitationCodeLabel?.autoPinEdge(ALEdge.Top, toEdge: ALEdge.Bottom, ofView: topView)
        invitationCodeLabel?.autoPinEdge(ALEdge.Left, toEdge: ALEdge.Left, ofView: self.view)
        invitationCodeLabel?.autoPinEdge(ALEdge.Right, toEdge: ALEdge.Right, ofView: self.view)
        invitationCodeLabel?.autoSetDimension(ALDimension.Height, toSize: 45 * kScreenRate)
        invitationCodeLabel?.attributedText = self.setCode("")
        
        shareBtn = UIButton.newAutoLayoutView()
        shareBtn?.backgroundColor = CD_MainColor
        shareBtn?.layer.cornerRadius = 3
        shareBtn?.layer.masksToBounds = true
        shareBtn?.titleLabel?.font = Define.font(TF_18)
        shareBtn?.setTitleColor(UIColor.whiteColor(), forState: UIControlState.Normal)
        shareBtn?.addTarget(self, action: "shareAction", forControlEvents: UIControlEvents.TouchUpInside)
        shareBtn?.setTitle("分享给朋友", forState: UIControlState.Normal)
        self.view.addSubview(shareBtn!)
        shareBtn?.autoPinEdge(ALEdge.Top, toEdge: ALEdge.Bottom, ofView: invitationCodeLabel)
        shareBtn?.autoPinEdge(ALEdge.Left, toEdge: ALEdge.Left, ofView: self.view, withOffset:15)
        shareBtn?.autoPinEdge(ALEdge.Right, toEdge: ALEdge.Right, ofView: self.view, withOffset:-15)
        shareBtn?.autoSetDimension(ALDimension.Height, toSize: 45 * kScreenRate)
        
        self.loadData()
    }

    func loadData()
    {
        var parma = NSMutableDictionary()
        parma.setPObject(HWUserLogin.currentUserLogin().key, forKey: "key")
//        var manager = HWHttpRequestOperationManager.baseManager()
//        manager.postHttpRequest(kInViteBroker, parameters: parma, queue: nil, success:
//            { (responseObject) -> Void in
//                
//                var responseDic = responseObject as NSDictionary
//                var dataDic = responseDic.dictionaryObjectForKey("data") as NSDictionary
//                self.invitationCode = dataDic.stringObjectForKey("code")
//                self.QRCodePicKey = dataDic.stringObjectForKey("url")
//                self.shareTitle = dataDic.stringObjectForKey("title")
//                self.shareContent = dataDic.stringObjectForKey("content")
//                
//                self.QRCodeImgView?.image = QRCodeGenerator.qrImageForString(self.QRCodePicKey, imageSize: 180)
//                self.invitationCodeLabel?.attributedText = self.setCode(self.invitationCode!)
//                self.introduceLabel?.text = self.shareTitle
//                
//            }) { (failure, error) -> Void in
//                println("请求失败") 
//        }
        
        var manager = HWHttpRequestOperationManager.baseManager()
        manager.postHttpRequest(kInviteOthers, parameters: parma, queue: nil, success:
            { (responseObject) -> Void in
                
                var responseDic = responseObject as NSDictionary
                var dataDic = responseDic.dictionaryObjectForKey("data") as NSDictionary
                self.invitationCode = dataDic.stringObjectForKey("inviteCode")
                self.QRCodePicKey = dataDic.stringObjectForKey("url")
                
                self.QRCodeImgView?.image = QRCodeGenerator.qrImageForString(self.QRCodePicKey, imageSize: 180)
                self.invitationCodeLabel?.attributedText = self.setCode(self.invitationCode!)
                
            }) { (failure, error) -> Void in
                println("请求失败")
        }

    }
    
    func shareAction()
    {
        println("分享")
        
//        let shareView = HWShareViewModel(shareContent: self.shareContent, image: nil, shareUrl: self.QRCodePicKey)
//        shareView.showInView(self.view, presentController: self)
        
//        var imgView = UIImageView()
//        imgView.setImageWithURL(NSURL(string:model.picKey), placeholderImage: UIImage(named: "shareIcon")!)
        //shareModel = HWShareViewModel(shareContent: model.content, image: UIImage(named: "shareIcon")!, shareUrl: model.couponShareUrl)
        
        let shareView:HWMsgShareViewModel = HWMsgShareViewModel(shareContent: "注册为好屋合伙人，推荐客户买房、成交便可得佣金", image: UIImage(named: "shareIcon"), shareUrl: QRCodePicKey)
        shareView.shareSuccess = {type in
            self.shareSuccessRequest(type)
        }
        
        shareView.showInView(shareAppDelegate.window, presentController: self)
        
    }
    
//    func actionSheet(actionSheet: MTCustomActionSheet!, didClickButtonByIndex index: Int32) {
//        if index == 0
//        {
//            println("qq分享")
//        }
//        else
//        {
//            println("微信分享")
//        }
//    }

    func shareSuccessRequest(shareType:String)
    {
//        var parma = NSMutableDictionary()
//        parma.setPObject(HWUserLogin.currentUserLogin().key, forKey: "key")
//        var type:String = ""
//        if shareType == "1"
//        {
//            type = "WeChat"
//        }
//        else if shareType == "6"
//        {
//            type = "CircleOfFriends"
//        }
//        else if shareType == "7"
//        {
//            type = "note"
//        }
//        parma.setPObject(type, forKey: "shareChannel")
//        parma.setPObject(shareCouponNum, forKey: "couponNum")
//        var manager = HWHttpRequestOperationManager.baseManager()
//        manager.postHttpRequest(kCouponShareSuccess, parameters: parma, queue: nil, success: { (responsObject) -> Void in
//            println("responsObject ================= \(responsObject)")
//            }) { (error, code) -> Void in
//                println("error ================= \(error)")
//                
//        }
    }

    func setCode(str:NSString) -> NSMutableAttributedString
    {
        var attri = NSMutableAttributedString(string: "我的邀请码 \(str)")
        attri.addAttribute(NSForegroundColorAttributeName, value: CD_MainColor, range: NSMakeRange(6, str.length))
        return attri
    }

}
