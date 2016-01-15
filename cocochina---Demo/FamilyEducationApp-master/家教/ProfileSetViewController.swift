//
//  ProfileSetViewController.swift
//  家教
//
//  Created by goofygao on 15/11/30.
//  Copyright © 2015年 goofyy. All rights reserved.
//

import UIKit

class ProfileSetViewController: UIViewController {

    @IBOutlet weak var proFileGBView2: UIView!
    @IBOutlet weak var avaterImageView: UIImageView!
    @IBOutlet weak var profileBGView: UIView!
    
    /// 昵称
    @IBOutlet weak var nickName: UILabel!
    /// 年龄
    @IBOutlet weak var profileAge: UILabel!
    /// 签名
    @IBOutlet weak var signatureLabel: UILabel!
    /// 身份定位
    @IBOutlet weak var bodyLocationLabel: UILabel!
    
    /// 电话号码
    @IBOutlet weak var bodyPhoneNumber: UILabel!
    /// 地址
    @IBOutlet weak var profileAddress: UILabel!
    /// 邮箱
    @IBOutlet weak var profileEmail: UILabel!
    override func viewDidLoad() {
        super.viewDidLoad()
        
        avaterImageView.layer.cornerRadius = avaterImageView.frame.width/2
        avaterImageView.layer.masksToBounds = true
        avaterImageView.layer.borderWidth = 5
        avaterImageView.layer.borderColor = UIColor(white: 0.6, alpha: 0.7).CGColor
        profileBGView.layer.cornerRadius = 20
        profileBGView.layer.masksToBounds = true
        proFileGBView2.layer.cornerRadius = 20
        proFileGBView2.layer.masksToBounds = true
        let navBar = self.navigationController?.navigationBar
        navBar?.barTintColor = UIColor(red: 65.0 / 255.0, green: 62.0 / 255.0, blue: 79.0 / 255.0, alpha: 1)
        navBar?.titleTextAttributes = [NSForegroundColorAttributeName: UIColor.whiteColor()]
        navBar?.tintColor = UIColor.whiteColor()
        self.title = "资料设置"
        
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    

}
