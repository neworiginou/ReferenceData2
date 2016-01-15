//
//  ViewController.swift
//  家教
//
//  Created by goofygao on 15/10/19.
//  Copyright © 2015年 goofyy. All rights reserved.
//

import UIKit
//import Alamofire


class ViewController: UIViewController,HttpProtocol,UIGestureRecognizerDelegate{
    
    @IBOutlet weak var searchStudent: UIButton!
    @IBOutlet weak var searchTeacher: UIButton!
    @IBOutlet weak var addButton: UIButton!
    var studentStatus:NSMutableArray?
    let requestHttp = HttpRequest()
    @IBOutlet weak var searchAWorkButton: UIButton!
    
    let reuseIdentifier = "ContentCell"
    //cell行高缓存
    var cellHeightCache = NSCache()
    var dataCount = 5
    var transformValuesDictionary:NSMutableDictionary = NSMutableDictionary()
    //展示家教信息的TableView
    @IBOutlet weak var tableViewFraulein: UITableView!
    @IBOutlet var barButton: UIButton!
    let defaultValue = NSUserDefaults.standardUserDefaults()
    let maskView = UIView()
    var singleTap = UITapGestureRecognizer()
    override func viewDidLoad() {
        super.viewDidLoad()
        
        UIApplication.sharedApplication().statusBarStyle = UIStatusBarStyle.LightContent
       self.initView()
        requestHttp.delegate = self
        requestHttp.loadNewData(0)
        requestHttp.loadNewData(1)
        requestHttp.loadNewData(2)
        requestHttp.loadNewData(3)
        self.tableViewFraulein.reloadData()
        
}

    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Your Menu View Controller vew must know the following data for the proper animatio
        let destinationVC = segue.destinationViewController as? GuillotineMenuViewController
        destinationVC?.hostNavigationBarHeight = self.navigationController!.navigationBar.frame.size.height
        destinationVC?.hostTitleText = self.navigationItem.title
        destinationVC?.view.backgroundColor = self.navigationController!.navigationBar.barTintColor
        destinationVC?.setMenuButtonWithImage(barButton.imageView!.image!)
        
    }
    
    
    //MARK: - 初始化视图控制器
    
    func initView() {
        //navigation设置
        let navBar = self.navigationController?.navigationBar
        navBar?.barTintColor = UIColor(red: 65.0 / 255.0, green: 62.0 / 255.0, blue: 79.0 / 255.0, alpha: 1)
        navBar?.titleTextAttributes = [NSForegroundColorAttributeName: UIColor.whiteColor()]
        //tableview 注册添加代理
        tableViewFraulein.delegate = self
        tableViewFraulein.dataSource = self
        let nib = UINib(nibName: "CustomFrauleinViewCell", bundle: nil)
        self.tableViewFraulein.registerNib(nib, forCellReuseIdentifier: reuseIdentifier)
        //  self.tableViewFraulein.sp=
        self.tableViewFraulein.backgroundColor = UIColor(red: 65.0 / 255.0, green: 62.0 / 255.0, blue: 79.0 / 255.0, alpha: 1)
        //tableView设置刷新
        //进入之后自动刷新
      // MJRefreshHeader
        let header = MJRefreshGifHeader(refreshingTarget: self, refreshingAction: "headerRefreshGetNewInfo")
        var refreshImage = [UIImage]()
        for var i = 1; i <= 60; i++ {
            let string = NSString(format: "dropdown_anim__000%zd.png", i) as String
           
            refreshImage.append(UIImage(named: string)!)
        }
        header.setImages(refreshImage, forState: MJRefreshStateIdle)
        header.setImages(refreshImage, forState: MJRefreshStatePulling)
        header.setTitle("松开刷新", forState: MJRefreshStatePulling)
        header.setTitle("正在努力加载...", forState: MJRefreshStateRefreshing)
        header.stateLabel?.textColor = UIColor(white: 1, alpha: 0.9)
        header.lastUpdatedTimeLabel?.textColor = UIColor(white: 1, alpha: 0.9)
        
        self.tableViewFraulein.header = header
         self.tableViewFraulein.header.beginRefreshing()
        self.initTabBar()
    }
    
    //初始化底部tabBar
    func initTabBar() {
        let tabBarView = UIView(frame: CGRectMake(0, DeviceData.height - 49, DeviceData.width, 49))
        tabBarView.backgroundColor = UIColor.redColor()
        self.view.addSubview(tabBarView)
        
        searchTeacher.setImage(UIImage(named: "16.png"), forState: UIControlState.Normal)
        searchTeacher.titleLabel?.textAlignment = NSTextAlignment.Center
        searchTeacher.setTitle("找老师", forState: UIControlState.Normal)
        searchTeacher.imageEdgeInsets = UIEdgeInsetsMake(10,40, 20,40)
        searchTeacher.titleLabel?.font = UIFont.systemFontOfSize(10)
        
        
        searchTeacher.titleLabel?.tintColor = UIColor.cyanColor()
        searchTeacher.titleEdgeInsets = UIEdgeInsetsMake(30, -50, 0, 10)
        searchTeacher.addTarget(self, action: "searchTeachAction", forControlEvents: UIControlEvents.TouchDown)
        
        searchStudent.setImage(UIImage(named: "18.png"), forState: UIControlState.Normal)
        searchStudent.titleLabel?.textAlignment = NSTextAlignment.Center
        searchStudent.setTitle("找学生", forState: UIControlState.Normal)
        searchStudent.imageEdgeInsets = UIEdgeInsetsMake(10,45, 20,45)
        searchStudent.titleLabel?.font = UIFont.systemFontOfSize(10)
        
        
        searchStudent.titleLabel?.tintColor = UIColor.cyanColor()
        searchStudent.titleEdgeInsets = UIEdgeInsetsMake(30, -20, 0, 10)
        searchStudent.addTarget(self, action: "searchStudentAction", forControlEvents: UIControlEvents.TouchDown)

    }
   
    

    func headerRefreshGetNewInfo() {
//        self.tableViewFraulein.header.endRefreshing()
        requestHttp.loadNewData(2)
//        self.tableViewFraulein.reloadData()
    }
    //MARK: - 用来加载找教师数据 - tabbar
    func searchTeachAction() {
        
        self.tableViewFraulein.header.beginRefreshing()
    }
    //MARK: - 用来加载找学生数据 - tabbar
    func searchStudentAction() {

        self.dataCount += 5
        self.tableViewFraulein.header.beginRefreshing()
        self.tableViewFraulein.reloadData()
    }

}
//MARK: - tableview添加代理方法

extension ViewController: UITableViewDelegate,UITableViewDataSource {
    
     func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }
    
      func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        if self.studentStatus?.count == nil {
            return 1
        }
        return (self.studentStatus?.count)!
    }
    
      func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCellWithIdentifier(reuseIdentifier, forIndexPath: indexPath) as! CustomFrauleinViewCell
        cell.selectionStyle = UITableViewCellSelectionStyle.None
        cell.contentView.layer.cornerRadius = 10
        cell.contentView.layer.masksToBounds = true
        
        if let studentData = studentStatus?[indexPath.row] {
            cell.collectButton.setTitle("\(studentData.stu_collect!)", forState: UIControlState.Normal)
            cell.StudentFrauleinTittle.text = studentData.stu_name!
            cell.FrauleinPlace.text = studentData.stu_addr
            cell.FrauleinWantMoney.text = "\(studentData.stu_bcost)" + " ~ \(studentData.stu_lcost)元"
            cell.FrauleinPlace.text = "\(studentData.stu_addr)"
            cell.recentFrauleinTime.text = "最近家教" + "\(studentData.volTime)次"
            //把行高放进缓存
            cellHeightCache.setObject(cell.heightForCell("\(studentData.stu_intro)") + 2, forKey: indexPath.row)
            cell.FrauleinLevel.getLevelStar(Int(studentData.stu_star))
            if studentData.stu_sex == "男" {
                cell.FrauleinStudentSex.image = UIImage(named: "boy.png")
            } else {
                cell.FrauleinStudentSex.image = UIImage(named: "girl.png")
            }
            
        }
        return cell
            
        
    }
    
    
    
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        
       
        let storyBoadrd = UIStoryboard(name: "Main", bundle: NSBundle.mainBundle())
        let familyStoryBoard:FamilyInfoViewController = storyBoadrd.instantiateViewControllerWithIdentifier("familyInfo") as! FamilyInfoViewController
        self.navigationController?.pushViewController(familyStoryBoard, animated: true)
//        let archivedObject = NSKeyedArchiver.archivedDataWithRootObject([Student]())
//        let defaults = NSUserDefaults.standardUserDefaults()
        
        defaultValue.setObject("\(self.studentStatus![indexPath.row].stu_id)", forKey: "stu_id")
        defaultValue.setObject(self.studentStatus![indexPath.row].username, forKey: "username")
        defaultValue.setObject(self.studentStatus![indexPath.row].stu_name, forKey: "stu_name")
        defaultValue.setObject(self.studentStatus![indexPath.row].stu_sign, forKey: "stu_sign")
        defaultValue.setObject("\(self.studentStatus![indexPath.row].stu_sex)", forKey: "stu_sex")
        defaultValue.setObject("\(self.studentStatus![indexPath.row].stu_age)", forKey: "stu_age")
        defaultValue.setObject(self.studentStatus![indexPath.row].stu_num, forKey: "stu_num")
        defaultValue.setObject(self.studentStatus![indexPath.row].stu_addr, forKey: "stu_addr")
//        defaultValue.setObject(self.studentStatus![indexPath.row].stu_edu, forKey: "stu_edu")
//        defaultValue.setObject(self.studentStatus![indexPath.row].stu_major, forKey: "stu_major")
        defaultValue.setObject(self.studentStatus![indexPath.row].stu_course, forKey: "stu_course")
        defaultValue.setObject(self.studentStatus![indexPath.row].stu_intro, forKey: "stu_intro")
        defaultValue.setObject(self.studentStatus![indexPath.row].stu_pic, forKey: "stu_pic")
        defaultValue.setObject("\(self.studentStatus![indexPath.row].stu_collect)", forKey: "stu_collect")
        defaultValue.setObject("\(self.studentStatus![indexPath.row].stu_bcost)", forKey: "stu_bcost")
        defaultValue.setObject("\(self.studentStatus![indexPath.row].stu_lcost)", forKey: "stu_lcost")
        defaultValue.setObject(self.studentStatus![indexPath.row].volTime, forKey: "volTime")
        defaultValue.setObject(self.studentStatus![indexPath.row].free_time, forKey: "free_time")
////        defaultValue.setObject(self.studentStatus![indexPath.row].lfree_time, forKey: "lfree_time")
        defaultValue.setObject("\(self.studentStatus![indexPath.row].stu_collect)", forKey: "stu_collect")
        defaultValue.setObject("\(self.studentStatus![indexPath.row].stu_star)", forKey: "stu_star")
        defaultValue.setObject("\(self.studentStatus![indexPath.row].real_sign)", forKey: "real_sign")
//        defaultValue.setObject(self.studentStatus![indexPath.row].volTime, forKey: "volTime")
        defaultValue.synchronize()
    }
    
//    kind
    
        func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        if let rowHeight = cellHeightCache.objectForKey(indexPath.row) as? CGFloat {
            
            return rowHeight
        }
    
        return 100
    }
    
    //MARK: -button action
    
    @IBAction func rightNavigationItemAction(sender: UIButton) {
        self.presentViewController(ChatListViewController(), animated: true, completion: nil)
        
    }
 
    @IBAction func searchAWorkAction(sender: UIButton) {
        
        
    }
    
    func didReceiveResults(result: NSMutableArray) {
        if studentStatus?.count == nil {
            var array = [Student]()
            self.studentStatus = NSMutableArray(array: array)
        }
      
        for i in 0...result.count - 1{
            self.studentStatus?.addObject(result[i])
        }
        let cell = tableViewFraulein.dequeueReusableCellWithIdentifier(reuseIdentifier) as! CustomFrauleinViewCell
        cellHeightCache.setObject(cell.heightForCell("\(self.studentStatus?[((self.studentStatus?.count)! - 1)].stu_intro)"), forKey: (self.studentStatus?.count)! - 1)
        if self.studentStatus?.count > 3 {
            self.tableViewFraulein.header.endRefreshing()
            self.tableViewFraulein.reloadData()
        }
    }
    
    func tableView(tableView: UITableView, willDisplayCell cell: UITableViewCell, forRowAtIndexPath indexPath: NSIndexPath) {
        cell.layer.transform = CATransform3DMakeScale(0.9, 0.9, 1)
        UIView.animateWithDuration(0.7) { () -> Void in
            cell.layer.transform = CATransform3DMakeScale(1, 1, 1)
        }
    }
    
    
    @IBAction func announceFamilyInfo(sender: UIButton) {
        
        
        maskView.frame = CGRectMake(0, 0, DeviceData.width, DeviceData.height)
        maskView.backgroundColor = UIColor.whiteColor()
        
        let searchFamilyButton = UIButton()
        let searchFamilyTitle = UILabel()
        let announceFamilyButton = UIButton()
        let announceFamilyTitle = UILabel()
        let annoceYiJiaoFamilyButton = UIButton()
        let annoceYiJiaoFamilyTitle = UILabel()
        let searchYiJiaoFamilyButton = UIButton()
        let searchYiJiaoFamilyTitle = UILabel()
        
        searchFamilyButton.center = sender.center
        searchFamilyButton.frame.size = CGSizeZero
        searchFamilyButton.setImage(UIImage(named: "add-1.png"), forState: UIControlState.Normal)
        searchFamilyButton.layer.cornerRadius = 10
        searchFamilyButton.layer.masksToBounds = true
        searchFamilyTitle.text = "找家教"
        searchFamilyTitle.font = UIFont.systemFontOfSize(12)
        self.maskView.addSubview(searchFamilyTitle)
//        searchFamilyButton.backgroundColor = UIColor.randColor(1)
        
        announceFamilyButton.center = sender.center
        announceFamilyButton.frame.size = CGSizeZero
        announceFamilyButton.setImage(UIImage(named: "add-2.png"), forState: UIControlState.Normal)
        announceFamilyTitle.text = "招家教"
        announceFamilyButton.layer.cornerRadius = 10
        announceFamilyButton.layer.masksToBounds = true
        announceFamilyTitle.font = UIFont.systemFontOfSize(12)
        self.maskView.addSubview(announceFamilyTitle)
        
//        announceFamilyButton.backgroundColor = UIColor.randColor(1)
        
        annoceYiJiaoFamilyButton.center = sender.center
        annoceYiJiaoFamilyButton.frame.size = CGSizeZero
        annoceYiJiaoFamilyButton.setImage(UIImage(named: "add-3.png"), forState: UIControlState.Normal)
        annoceYiJiaoFamilyButton.layer.cornerRadius = 10
        annoceYiJiaoFamilyButton.layer.masksToBounds = true
        annoceYiJiaoFamilyTitle.text = "招义教"
        annoceYiJiaoFamilyTitle.font = UIFont.systemFontOfSize(12)
        self.maskView.addSubview(annoceYiJiaoFamilyTitle)
//        annoceYiJiaoFamilyButton.backgroundColor = UIColor.randColor(1)
        
        searchYiJiaoFamilyButton.center = sender.center
        searchYiJiaoFamilyButton.frame.size = CGSizeZero
        searchYiJiaoFamilyButton.setImage(UIImage(named: "add-4.png"), forState: UIControlState.Normal)
        annoceYiJiaoFamilyButton.layer.cornerRadius = 10
        searchYiJiaoFamilyButton.layer.masksToBounds = true
        searchYiJiaoFamilyTitle.text = "找义教"
        searchYiJiaoFamilyTitle.font = UIFont.systemFontOfSize(12)
        self.maskView.addSubview(searchYiJiaoFamilyTitle)

//        searchYiJiaoFamilyButton.backgroundColor = UIColor.randColor(1)
        maskView.frame.size = CGSizeZero
        
        maskView.center = CGPointMake(DeviceData.width/2, DeviceData.height)
        searchFamilyButton.tag = 100
        announceFamilyButton.tag = 101
        annoceYiJiaoFamilyButton.tag = 102
        searchYiJiaoFamilyButton.tag = 103
        searchFamilyButton.addTarget(self, action: "addMessageAction:", forControlEvents: UIControlEvents.TouchDown)
        announceFamilyButton.addTarget(self, action: "addMessageAction:", forControlEvents: UIControlEvents.TouchDown)
        annoceYiJiaoFamilyButton.addTarget(self, action: "addMessageAction:", forControlEvents: UIControlEvents.TouchDown)
        searchYiJiaoFamilyButton.addTarget(self, action: "addMessageAction:", forControlEvents: UIControlEvents.TouchDown)
        maskView.addSubview(searchFamilyButton)
        maskView.addSubview(announceFamilyButton)
        maskView.addSubview(annoceYiJiaoFamilyButton)
        maskView.addSubview(searchYiJiaoFamilyButton)
        singleTap.delegate = self
        singleTap.cancelsTouchesInView = false
        singleTap = UITapGestureRecognizer(target: self, action: "singleTapAction")
        singleTap.numberOfTapsRequired = 1
                maskView.addGestureRecognizer(singleTap)
        
        
        UIView.animateWithDuration(0.3, delay: 0, options: UIViewAnimationOptions.CurveEaseInOut, animations: { () -> Void in
                self.maskView.frame = (self.navigationController?.view.frame)!
                self.navigationController?.view.addSubview(self.maskView)
                searchFamilyButton.frame = CGRectMake(DeviceData.width/6, DeviceData.height - 100, 50, 50)
                searchFamilyTitle.frame = CGRectMake(CGRectGetMinX(searchFamilyButton.frame) + 5, CGRectGetMaxY(searchFamilyButton.frame) + 5, 50, 21)
                announceFamilyButton.frame = CGRectMake(DeviceData.width * 2/6, DeviceData.height - 100, 50, 50)
            announceFamilyTitle.frame = CGRectMake(CGRectGetMinX(announceFamilyButton.frame) + 5, CGRectGetMaxY(announceFamilyButton.frame) + 5, 50, 21)
                annoceYiJiaoFamilyButton.frame = CGRectMake(DeviceData.width * 3/6, DeviceData.height - 100, 50, 50)
                annoceYiJiaoFamilyTitle.frame = CGRectMake(CGRectGetMinX(annoceYiJiaoFamilyButton.frame) + 5, CGRectGetMaxY(annoceYiJiaoFamilyButton.frame) + 5, 50, 21)
                searchYiJiaoFamilyButton.frame = CGRectMake(DeviceData.width * 4/6, DeviceData.height - 100, 50, 50)
            searchYiJiaoFamilyTitle.frame = CGRectMake(CGRectGetMinX(searchYiJiaoFamilyButton.frame) + 5, CGRectGetMaxY(annoceYiJiaoFamilyButton.frame) + 5, 50, 21)
            }, completion: nil)
    }
    
    
    func addMessageAction(sender:UIButton) {
        self.maskView.removeFromSuperview()
//        if sender.tag == 100 || sender.tag == 101 {
            self.navigationController?.pushViewController(FindFamilyAndVolunController(), animated: false)
//        }
    }
    
    func singleTapAction() {
        UIView.animateWithDuration(0.7, delay: 0, options: UIViewAnimationOptions.CurveEaseInOut, animations: { () -> Void in
            self.maskView.removeFromSuperview()
            }, completion: nil)
    }
}








