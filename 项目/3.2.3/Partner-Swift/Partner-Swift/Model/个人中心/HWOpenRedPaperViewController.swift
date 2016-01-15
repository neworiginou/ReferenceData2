//
//  HWOpenRedPaperViewController.swift
//  Partner-Swift
//
//  Created by gusheng on 15/5/21.
//  Copyright (c) 2015年 caijingpeng.haowu. All rights reserved.
//

import UIKit

class HWOpenRedPaperViewController: HWBaseViewController {

    var redMoney:String!
    var redImgBackV:UIImageView!
    var moneyLab:UILabel!
    var infoLab:UILabel!
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.navigationItem.titleView = Utility.navTitleView("刮红包")
        self.navigationItem.leftBarButtonItem = Utility.navLeftBackBtn(self, _selector: "backMethod")
        self.view.backgroundColor = CD_RedPaperColor;
        
        var backImgV = UIImageView(frame: CGRectMake(0, 0, kScreenWidth, 245 * kScreenRate))
        backImgV.image = UIImage(named: "gua_bg")
        self.view.addSubview(backImgV)
        
        var firbackImgV = UIImageView(frame: CGRectMake((kScreenWidth - 303) / 2, CGRectGetMaxY(backImgV.frame), 303, 185))
        firbackImgV.image = UIImage(named: "gua_bg1")
        firbackImgV.userInteractionEnabled = true
        self.view.addSubview(firbackImgV)
        
        
        redImgBackV = UIImageView(frame: CGRectMake(10, 10, firbackImgV.frame.size.width - 20, firbackImgV.frame.size.height - 20))
        redImgBackV.backgroundColor = CD_YellowLightColor;
        redImgBackV.userInteractionEnabled = true
        redImgBackV.image = UIImage(named:"gua_bg2")
//        redImgBackV.contentMode = UIViewContentMode.ScaleAspectFill
        firbackImgV.addSubview(redImgBackV)
        
        var pan = UIPanGestureRecognizer(target: self, action: "showRedPaper:");
        redImgBackV.addGestureRecognizer(pan)
        
        moneyLab = UILabel(frame: CGRectMake(0, 40, redImgBackV.frame.size.width, 60))
        moneyLab.textAlignment = NSTextAlignment.Center;
        moneyLab.textColor = CD_RedDeepColor
        moneyLab.font = Define.font(60)
        moneyLab.backgroundColor = UIColor.clearColor()
        redImgBackV.addSubview(moneyLab)
        
        infoLab = UILabel(frame: CGRectMake(0, CGRectGetMaxY(moneyLab.frame), redImgBackV.frame.size.width, 40))
        infoLab.textAlignment = NSTextAlignment.Center;
        infoLab.textColor = CD_Txt_Color_00;
        infoLab.font = Define.font(17)
        infoLab.backgroundColor = UIColor.clearColor()
        redImgBackV.addSubview(infoLab)
        
        
    }

    func showRedPaper(pan:UIPanGestureRecognizer)
    {
        if pan.state == UIGestureRecognizerState.Ended
        {
            redImgBackV.image = UIImage(named: "")
            redImgBackV.userInteractionEnabled = false;
            redMoney = "\(5)";
            moneyLab.text = "\(redMoney)元"
            infoLab.text = "任何财富都是由小钱积累的\n\(redMoney)元收罗囊中"
            var lineSpace = NSMutableParagraphStyle()
            lineSpace.lineSpacing = 6;
//            
            var infoAtt = NSMutableAttributedString(string: infoLab.text!, attributes: [NSParagraphStyle():lineSpace])
            infoLab.attributedText = infoAtt;
        }
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
