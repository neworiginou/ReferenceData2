//
//  HWChangeNameViewController.swift
//  HWUser
//
//  Created by wuxiaohong on 15/2/6.
//  Copyright (c) 2015年 hw. All rights reserved.
//

import UIKit

class HWChangeNameViewController: HWBaseViewController,UITableViewDelegate,UITableViewDataSource {
    var nickNameTF = UITextField()
     override func viewWillAppear(animated: Bool)
     {
        self.navigationController?.navigationBarHidden = false
     }
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        self.navigationItem.titleView = Utility .navTitleView("修改姓名")
        self.view.backgroundColor = CD_BackGroundColor
        var tableView = UITableView(frame: CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height * kRate))
        tableView.delegate = self
        tableView.dataSource = self
        tableView.backgroundColor = CD_BackGroundColor
        tableView.separatorStyle = UITableViewCellSeparatorStyle(rawValue:0)!
        self.view .addSubview(tableView)
        //创建表头
        let view = UIView(frame: CGRectMake(0, 0, self.view.frame.size.width, 10 * kRate))
        view.backgroundColor = CD_BackGroundColor
        tableView.tableHeaderView = view
        tableView.tableHeaderView?.drawBottomLine()
        let line = UIView(frame: CGRectMake(0, 10, self.view.frame.size.width, lineHeight))
        line.backgroundColor = CD_LineColor
       // view.addSubview(line)
        //创建表尾
        let footView = UIView(frame: CGRectMake(0, 0, self.view.frame.size.width, 80 * kRate))
        tableView.tableFooterView = footView
        //创建退出按钮
        let logoutBtn = UIButton(frame: CGRectMake(15, 20, self.view.frame.size.width-30 , 45 * kRate))
        logoutBtn .setTitle("修改", forState: UIControlState.Normal)
        logoutBtn.backgroundColor  = CD_MainColor
        logoutBtn.layer.cornerRadius = 3
        logoutBtn .addTarget(self, action: "doConfirm", forControlEvents:UIControlEvents.TouchUpInside)
        footView .addSubview(logoutBtn)

        let tap = UITapGestureRecognizer (target: self, action: "doTap")
        tableView .addGestureRecognizer(tap)
        
        
    }
    //MARK:修改姓名的请求
    func doConfirm()
    {
        if nickNameTF.text == ""
        {
            Utility .showToastWithMessage("请输入姓名", _view: self.view)
            return
        }
        if nickNameTF.text == HWUserLogin.currentUserLogin().brokerName
        {
            Utility .showToastWithMessage("与当前姓名一致", _view: self.view)
            return

        }
        
        Utility .showMBProgress(self.view, _message: "发送数据")
        let manager = HWHttpRequestOperationManager.baseManager()
        var param: NSMutableDictionary! = NSMutableDictionary()
        param .setObject(HWUserLogin.currentUserLogin().key, forKey: "key")
        param .setObject(nickNameTF.text, forKey: "brokerName")
        manager .postHttpRequest(kPersonalChange, parameters: param, queue: nil, success: { (responseObject) -> Void in
        Utility .hideMBProgress(self.view)
        Utility .showToastWithMessage("修改成功", _view: self.view)
       
        HWUserLogin.currentUserLogin().brokerName = self.nickNameTF.text
        HWCoreDataManager .saveUserInfo()
        NSNotificationCenter .defaultCenter() .postNotificationName(kUpdateUserInfo, object: nil)
        var timer =  NSTimer .scheduledTimerWithTimeInterval(1, target: self, selector: "hidePop", userInfo: nil, repeats: true)
        }) { (code, error) -> Void in
            Utility .hideMBProgress(self.view)
            Utility .showToastWithMessage(error, _view: self.view)
        }

        
    }
    func hidePop()
    {
        self.navigationController?.popViewControllerAnimated(true)
    }
     //MARK:添加手势
    func doTap()
    {
        self.view .endEditing(true)
        
    }
    //MARK:表的代理
    func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat
    {
        return 45 * kRate
    }
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int
    {
        return 1
    }
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell
    {
        let cell: UITableViewCell = UITableViewCell(style: UITableViewCellStyle.Default, reuseIdentifier: "cell")
        nickNameTF.frame = CGRectMake(15, 0, self.view.frame.size.width-30, 45 * kRate)
        //nickNameTF.placeholder = "姓名"
        nickNameTF.text = HWUserLogin.currentUserLogin().brokerName
        nickNameTF.textColor = CD_Txt_Color_99
        nickNameTF.font = Define.font(15)
        nickNameTF.contentVerticalAlignment = UIControlContentVerticalAlignment(rawValue:0)!
        cell.contentView .addSubview(nickNameTF)
        let line  = UIView (frame: CGRectMake(0, 45-0.5, self.view.frame.size.width, lineHeight))
        line.backgroundColor = CD_LineColor;
       // cell.contentView .addSubview(line)
        cell .drawBottomLine()
         return cell
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
