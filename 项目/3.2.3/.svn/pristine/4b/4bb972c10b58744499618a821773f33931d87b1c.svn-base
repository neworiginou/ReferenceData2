//
//  HWHiDialogViewController.swift
//  Partner-Swift
//
//  Created by caijingpeng.haowu on 15/3/4.
//  Copyright (c) 2015年 caijingpeng.haowu. All rights reserved.
//

import UIKit

class HWHiDialogViewController: HWBaseViewController {

    var dialogView: HWMessageDialogView!
    var msgListModel: HWMessageListModel?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.navigationItem.titleView = Utility.navTitleView("消息")
        
        dialogView = HWMessageDialogView(frame: CGRectMake(0, 0, kScreenWidth, contentHeight - 50))
        dialogView.type = DialogType.Hi
        dialogView.msgListModel = self.msgListModel
        self.view.addSubview(dialogView)
        dialogView.drawBottomLine()
        
        let hiButton = UIButton.buttonWithType(UIButtonType.Custom) as UIButton
        hiButton.frame = CGRectMake(15, contentHeight - 45, kScreenWidth - 30, 40)
        hiButton.setBackgroundImage(Utility.imageWithColor(CD_MainColor, _size: CGSizeMake(kScreenWidth - 30, 40)), forState: UIControlState.Normal)
        hiButton.layer.cornerRadius = 20
        hiButton.layer.masksToBounds = true
        hiButton.titleLabel?.font = Define.font(TF_Btn_Title_19)
        hiButton.setTitle("HI一下", forState: UIControlState.Normal)
        hiButton.setTitleColor(UIColor.whiteColor(), forState: UIControlState.Normal)
        hiButton.addTarget(self, action: "toHiAction:", forControlEvents: UIControlEvents.TouchUpInside)
        self.view.addSubview(hiButton)
        
        HWLocationManager.shareManager().startLoacting()
    }
    
    func toHiAction(sender: UIButton) -> Void 
    {
        MobClick.event("Hifeedback_click")
        dialogView.sendHi()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
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
