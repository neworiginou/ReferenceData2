//
//  HWChangeSexViewController.swift
//  HWUser
//
//  Created by wuxiaohong on 15/2/6.
//  Copyright (c) 2015年 hw. All rights reserved.
//

import UIKit

class HWChangeSexViewController: HWBaseViewController,UITableViewDelegate,UITableViewDataSource {
     var sex  = NSString()
     var tableViews = UITableView()
    override func viewWillAppear(animated: Bool)
    {
        self.navigationController?.navigationBarHidden = false
    }

    override func viewDidLoad() {
        super.viewDidLoad()
       
        // Do any additional setup after loading the view.
        self.navigationItem.titleView = Utility .navTitleView("修改性别")
        sex = HWUserLogin.currentUserLogin().brokerGender
        self.view.backgroundColor = UIColor .clearColor()
        tableViews.frame=CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height * kRate)
        tableViews.delegate = self
        tableViews.dataSource = self
        tableViews.backgroundColor = CD_BackGroundColor
        tableViews.separatorStyle = UITableViewCellSeparatorStyle(rawValue:0)!
        self.view .addSubview(tableViews)
        //创建表头
        let view = UIView(frame: CGRectMake(0, 0, self.view.frame.size.width, 10))
        view.backgroundColor = CD_BackGroundColor
        tableViews.tableHeaderView = view
        tableViews.tableHeaderView?.drawBottomLine()
        let line = UIView(frame: CGRectMake(0, 10-0.5, self.view.frame.size.width, lineHeight))
        line.backgroundColor = CD_LineColor
      //  view.addSubview(line)
        
        //创建表尾
        let footView = UIView(frame: CGRectMake(0, 0, self.view.frame.size.width, 80 * kRate))
        tableViews.tableFooterView = footView
        //创建退出按钮
        let logoutBtn = UIButton(frame: CGRectMake(15, 20, self.view.frame.size.width-30 , 45 * kRate))
        logoutBtn.setTitle("修改", forState: UIControlState.Normal)
        logoutBtn.backgroundColor  = CD_MainColor
        logoutBtn.layer.cornerRadius = 3
        logoutBtn.addTarget(self, action: "doConfirm", forControlEvents:UIControlEvents.TouchUpInside)
        footView .addSubview(logoutBtn)
        
        let tap = UITapGestureRecognizer (target: self, action: "doTap")
       // tableViews .addGestureRecognizer(tap)
       
        
        
    }
    //MARK:修改性别的请求
    func doConfirm()
    {
        
        Utility .showMBProgress(self.view, _message: "修改中")
        let manager = HWHttpRequestOperationManager.baseManager()
        var param: NSMutableDictionary! = NSMutableDictionary()
        param .setObject(HWUserLogin.currentUserLogin().key, forKey: "key")
       
        param .setObject(sex, forKey: "gender")
      
        manager .postHttpRequest(kPersonalChange, parameters: param, queue: nil, success: { (responseObject) -> Void in
            Utility .hideMBProgress(self.view)
            Utility .showToastWithMessage("修改成功", _view: self.view)
           
            let responseDic: NSDictionary? = responseObject as NSDictionary
            HWUserLogin.currentUserLogin().brokerGender = self.sex
            
            HWCoreDataManager .saveUserInfo()
            NSNotificationCenter .defaultCenter() .postNotificationName(kUpdateUserInfo, object: nil)
             var timer =  NSTimer .scheduledTimerWithTimeInterval(2, target: self, selector: "hidePop", userInfo: nil, repeats: true)
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
        return 2
    }
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell
    {
        let cell: UITableViewCell = UITableViewCell(style: UITableViewCellStyle.Default, reuseIdentifier: "cell")
        let line  = UIView (frame: CGRectMake(0, 45-0.5, self.view.frame.size.width, lineHeight))
        line.backgroundColor = CD_LineColor
        //cell.contentView .addSubview(line)
        cell .drawBottomLine()
        if indexPath.row == 0
        {
            cell.textLabel?.text = "先生"
        }
        if indexPath.row == 1
        {
            cell.textLabel?.text = "女士"

        }
        let btn = UIButton()
        btn.frame = CGRectMake(0, 0, 19, 19 * kRate)
        btn.tag = indexPath.row+100
        btn .addTarget(self, action: "doSelect:", forControlEvents: UIControlEvents.TouchUpInside)
        if indexPath.row == 0
        {
            if sex .isEqualToString("1")
            {
                btn .setImage(UIImage(named: "choose_2_2.png"), forState: UIControlState.Normal)
            }
            
            else
            {
                 btn .setImage(UIImage(named: "choose_2_1.png"), forState: UIControlState.Normal)
            }
            
        }
        
        else
        {
            if sex .isEqualToString("0")
            {
                btn .setImage(UIImage(named: "choose_2_2.png"), forState: UIControlState.Normal)
            }
                
            else
            {
                btn .setImage(UIImage(named: "choose_2_1.png"), forState: UIControlState.Normal)
            }

        }
        cell.accessoryView = btn
        return cell
    
    }
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath)
    {
      //  tableView .deselectRowAtIndexPath(indexPath, animated: true)
        if indexPath.row == 0
        {
            sex = "1"
        }
        else
        {
            sex = "0"
        }
        tableViews .reloadData()
    }
    //MARK:btn点击事件
    func doSelect(sender:UIButton!)
    {
        if sender.tag % 100 == 0
        {
             sex = "1"
        }
        
        else
        {
            sex = "0"
        }
        
        tableViews .reloadData()
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
