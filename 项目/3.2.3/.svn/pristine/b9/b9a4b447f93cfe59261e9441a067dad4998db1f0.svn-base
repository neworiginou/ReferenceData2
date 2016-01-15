//
//  HWSelectCitysViewController.swift
//  Partner-Swift
//
//  Created by wuxiaohong on 15/5/19.
//  Copyright (c) 2015年 caijingpeng.haowu. All rights reserved.
//

import UIKit

class HWSelectCitysViewController: HWBaseViewController,UITableViewDelegate,UITableViewDataSource,HWSearchViewModelDelegate,UIAlertViewDelegate {
    var cityArry = NSMutableArray()
    var tabView = UITableView()
    var keys = NSMutableArray()
    var list = NSMutableDictionary()
    var listArry = NSMutableArray()
    var searchArry  = NSMutableArray()
    var _searchbar = UISearchBar()
    var _searchBar:HWSearchViewModel!
    var strCity:NSString!
    var searchTitle:String!
    var selectCity:String!
    var backView:UIView!
    var dianJi:Bool!
    var currentIndex:Int!
    var cityId:String!
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationItem.titleView = Utility .navTitleView("选择城市");
        //keys = NSMutableArray()
      
        searchTitle = ""
        self .sortByPinyIn(HWUserLogin.currentUserLogin().cities)
        HWLocationManager.shareManager().startLoacting();
        HWLocationManager.shareManager().locationSuccess = { loc,cityName in
             Utility.showToastWithMessage("定位成功", _view: self.view)
             self.strCity = cityName;
             //self.strCity = "江苏省";
             self.view.addSubview(self.tabView);
        }
        HWLocationManager.shareManager().locationFailure = {
            
            Utility.showToastWithMessage("定位失败", _view: self.view)
            self.strCity = "无法定位"
            self.view.addSubview(self.tabView);
        }

        tabView.frame = CGRectMake(0, 0, self.view.frame.size.width,contentHeight);
        tabView.backgroundColor = CD_BackGroundColor;
        tabView.delegate = self;
        tabView.dataSource  = self;
        tabView.rowHeight = 43;
       // self.view.addSubview(self.tabView);
        
        let headView = UIView(frame: CGRectMake(0,0,kScreenWidth ,70))
        headView.backgroundColor = CD_BackGroundColor;
        tabView.tableHeaderView = headView
        
        _searchBar = HWSearchViewModel(delegate: self,type:"1")
        _searchBar.frame = CGRectMake(_searchBar.frame.origin.x, 30, _searchBar.frame.size.width, _searchBar.frame.size.height)
        _searchBar.hidden = false
        headView.addSubview(_searchBar)
        
        var lab = UILabel(frame: CGRectMake(15,5, 200, 30))
        lab.text = "每天最多可切换三个城市"
        lab.font = Define.font(14)
        lab.textColor = CD_MainColor
        headView .addSubview(lab)
        
        let footView = UIView(frame: CGRectMake(0, 0, self.view.frame.size.width, 80 * kRate))
        tabView.tableFooterView = footView
        let logoutBtn = UIButton(frame: CGRectMake(15, 20, self.view.frame.size.width-30 , 45 * kRate))
        logoutBtn .setTitle("更改城市", forState: UIControlState.Normal)
        logoutBtn.backgroundColor = CD_MainColor
        logoutBtn.layer.cornerRadius = 3
        logoutBtn .addTarget(self, action: "doConfirm", forControlEvents:UIControlEvents.TouchUpInside)
      //  footView .addSubview(logoutBtn)
        
//        let tap = UITapGestureRecognizer (target: self, action: "doTap")
//        tabView .addGestureRecognizer(tap)
//        tabView.canCancelContentTouches = false
//        tabView.delaysContentTouches = false
    }
//    func doTap()
//    {
//        self.view .endEditing(true)
//        
//    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int
    {
        if searchTitle == ""
        {
        if section == 0
        {
            return 1
        }
        else
        {
        // return HWUserLogin.currentUserLogin().cities.count
            return listArry.count
           
        }
        }
        
        else
        {
            
                return searchArry.count
                
            
        }
    }
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell
    {
        let cell: UITableViewCell = UITableViewCell(style: UITableViewCellStyle.Default, reuseIdentifier: "cell")
      // cell.accessoryType = UITableViewCellAccessoryType(rawValue: 3)!
            if searchTitle == ""
    {
        if indexPath.section == 0
        {
            var backImageView = UIImageView(frame: CGRectMake(25, (43-15)/2, 15, 18))
            backImageView.image = UIImage(named: "add2")
            cell.contentView .addSubview(backImageView);
            var lab = UILabel(frame: CGRectMake(CGRectGetMaxX(backImageView.frame)+5, 0, 150, 43))
            lab.text = self.strCity;
            lab.font = Define.font(15)
            cell.contentView .addSubview(lab);
            
            
        }
        else
        {
           let cityClass = HWUserLogin.currentUserLogin().cities[indexPath.row] as HWCityClass
          //  cell.textLabel?.text = cityClass.cityName
            cell.textLabel?.text = listArry[indexPath.row] as? String
            
        }
    }
        else
    {
        if indexPath.section == 0
        {
            cell.textLabel?.text = searchArry[indexPath.row] as? String

        }
        else
        {
            cell.textLabel?.text = searchArry[indexPath.row] as? String

        }
        
    }
        cell.drawBottomLine()
        cell.textLabel?.font = Define.font(15)
        
        return cell
    }
    func numberOfSectionsInTableView(tableView: UITableView) -> Int
    {
        if searchTitle == ""
        {
           return 2;
        }
        
        else
        {
            return 1
        }
    }
    func tableView(tableView: UITableView, viewForHeaderInSection section: Int) -> UIView?
    {
        var view = UIView(frame: CGRectMake(0, 0, kScreenWidth, 40))
        var lab = UILabel(frame: CGRectMake(15, 0, kScreenWidth, 40))
        view.backgroundColor = CD_BackGroundColor

        if searchTitle == ""
    {
        if section == 0
        {
            lab.text = "定位城市";

        }
        else
        {
        lab.text = "城市列表";
        }
    }
        
        else
        {
             lab.text = "";
        }
        lab.font = Define.font(14)
        lab.textColor = CD_Txt_Color_66
        view.drawBottomLine()
        view .addSubview(lab)
        return view;
    }
    func tableView(tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat
     {
        
        if searchTitle == ""
        {
         return 40
        }
        
        else
        {
            return 0
        }
     }
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath)
    {
        tabView .deselectRowAtIndexPath(indexPath, animated: false)
        
        if searchTitle == ""
        {
            
            if indexPath.section == 0
            {
                
                if self.strCity == "无法定位" || self.strCity == ""
                {
                    return
                }
                
                else
                {
                    for var i = 0;i < HWUserLogin.currentUserLogin().cities.count;i++
                    {
                        let cityClass = HWUserLogin.currentUserLogin().cities .pObjectAtIndex(i) as HWCityClass
                        if self.strCity  == cityClass.cityName
                        {
                            cityId = cityClass.cityId
                            HWUserLogin.currentUserLogin().cityId = cityClass.cityId!
                            selectCity = self.strCity
                        }
                      else
                        {
                            selectCity = self.strCity
                        }
                        if self.strCity == HWUserLogin.currentUserLogin().cityName
                        {
                            return
                        }
                    
                    
                    }
                    
                }
                
               
            }
            else
            {
                
//            let cityClass = HWUserLogin.currentUserLogin().cities[indexPath.row] as HWCityClass
//                 selectCity = cityClass.cityName
                selectCity = listArry[indexPath.row] as String;
                for var i = 0;i < HWUserLogin.currentUserLogin().cities.count;i++
                {
                    let cityClass = HWUserLogin.currentUserLogin().cities .pObjectAtIndex(i) as HWCityClass
                    if selectCity == cityClass.cityName
                    {
                        cityId = cityClass.cityId
                        HWUserLogin.currentUserLogin().cityId = cityClass.cityId!
                    }
                
                    if selectCity == HWUserLogin.currentUserLogin().cityName
                    {
                        return
                    }

                    
                }
                
            }
            
        }
        else
        {
            selectCity = searchArry[indexPath.row] as String
            for var i = 0;i < HWUserLogin.currentUserLogin().cities.count;i++
            {
                let cityClass = HWUserLogin.currentUserLogin().cities[i] as HWCityClass
                if selectCity == cityClass.cityName
                {
                    cityId = cityClass.cityId
                     HWUserLogin.currentUserLogin().cityId = cityClass.cityId!
                }
                
                if selectCity == HWUserLogin.currentUserLogin().cityName
                {
                    return
                }
                
                
            }

            
        }
        
        
        var alert  = UIAlertView(title: "您的业务城市将从\(HWUserLogin.currentUserLogin().cityName)切换到\(selectCity)，是否确认?", message: "", delegate: self, cancelButtonTitle: "取消", otherButtonTitles: "确定")
        alert.show()
        
    }
    func alertView(alertView: UIAlertView, clickedButtonAtIndex buttonIndex: Int)
    {
        if buttonIndex == 0
        {
            
        }
       if buttonIndex == 1
        
        {
            //接口操作
            self.changeCitys()
            
            

        }
    }
    func changeCitys()
    {
        Utility .showMBProgress(self.view, _message: "修改中")
        let manager = HWHttpRequestOperationManager.baseManager()
        var param: NSMutableDictionary! = NSMutableDictionary()
        param.setPObject(HWUserLogin.currentUserLogin().key, forKey: "key")
        param.setPObject(cityId, forKey: "cityId")
        manager .postHttpRequest(kPersonalChangeCity, parameters: param, queue: nil, success: { (responseObject) -> Void in
            Utility.hideMBProgress(self.view)
            Utility.showToastWithMessage("修改成功", _view: self.view)
            if countElements(self.selectCity) <= 0
            {
                
            }
            else
            {
                HWUserLogin.currentUserLogin().cityName = self.selectCity
                HWUserLogin.currentUserLogin().cityId = self.cityId

            }
            HWCoreDataManager.saveUserInfo()
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
    func sortByPinyIn(targetArray:NSMutableArray)
    {
        for (var i = 0;i < targetArray.count;i++)
        {
            let cityClass = HWUserLogin.currentUserLogin().cities[i] as HWCityClass
            var pingYin = cityClass.cityPinyin
            var hanZi = cityClass.cityName
            var firstKey = pingYin?.substringToIndex(1);
            if keys.count == 0
            {
                keys.addObject(firstKey!)
                if list.objectForKey(firstKey!) == nil
                {
                    var keyArry = NSMutableArray()
                    list.setPObject(keyArry, forKey: firstKey!)
                }
                
                var arry = list .arrayObjectForKey(firstKey!) as NSMutableArray
                arry.addObject(cityClass.cityName!)
                list.setPObject(arry, forKey: firstKey!)
                
               
            }
            else
            {
                for (var i = 0;i < keys.count; i++)
                {
                    var key  = keys .pObjectAtIndex(i) as NSString;
                    if key == firstKey
                    {
                         var arry = list .arrayObjectForKey(firstKey!) as NSMutableArray
                         arry.addObject(cityClass.cityName!)
                         list.setPObject(arry, forKey: firstKey!)
                         break
                    }
                    if i == keys.count - 1
                    {
                        keys.addObject(firstKey!)
                        if list.objectForKey(firstKey!) == nil
                        {
                            var keyArry = NSMutableArray()
                            list.setPObject(keyArry, forKey: firstKey!)
                          
                        }
                        var arry = list .objectForKey(firstKey!) as NSMutableArray
                        arry .addObject(cityClass.cityName!)
                        list .setPObject(arry, forKey: firstKey!)
                        break;

                    }
                }
            }
        }
//        var key:NSArray = self.list.keysSortedByValueUsingSelector("stringCompare:") as NSArray!;
        
        var keyq: NSArray = self.list.allKeys
        var kk:NSArray = keyq.sortedArrayUsingSelector("compare:") as NSArray
        self.keys  = NSMutableArray(array: kk)
        println(self.keys);
        for var i = 0;i < self.keys.count;i++
        {
            var key = self.keys.pObjectAtIndex(i) as NSString
            var arr = list .arrayObjectForKey(key) as NSMutableArray
            
            for var i = 0;i<arr.count; i++
            {
                var str = arr.pObjectAtIndex(i) as NSString
                listArry .addObject(str);
            }

        }
//        var arr = list .arrayObjectForKey("a") as NSMutableArray
//        for var i = 0;i<arr.count; i++
//        {
//            var str = arr.pObjectAtIndex(i) as NSString
//            listArry .addObject(str);
//        }
//        var arr1 = list .arrayObjectForKey("b") as NSMutableArray
//        for var i = 0;i<arr1.count; i++
//        {
//            var str = arr1.pObjectAtIndex(i) as NSString
//            listArry .addObject(str);
//        }
//        var arr2 = list .arrayObjectForKey("c") as NSMutableArray
//        for var i = 0;i<arr2.count; i++
//        {
//            var str = arr2.pObjectAtIndex(i) as NSString
//            listArry .addObject(str);
//        }
//        var arr3 = list .arrayObjectForKey("d") as NSMutableArray
//        for var i = 0;i<arr3.count; i++
//        {
//            var str = arr3.pObjectAtIndex(i) as NSString
//            listArry .addObject(str);
//        }
////        var arr4 = list .arrayObjectForKey("e") as NSMutableArray
////        for var i = 0;i<arr4.count; i++
////        {
////            var str = arr4.pObjectAtIndex(i) as NSString
////            listArry .addObject(str);
////        }
//        var arr5 = list .arrayObjectForKey("f") as NSMutableArray
//        for var i = 0;i<arr5.count; i++
//        {
//            var str = arr5.pObjectAtIndex(i) as NSString
//            listArry .addObject(str);
//        }
//        var arr6 = list .arrayObjectForKey("g") as NSMutableArray
//        for var i = 0;i<arr6.count; i++
//        {
//            var str = arr6.pObjectAtIndex(i)as NSString
//            listArry .addObject(str);
//        }
//        var arr7 = list .arrayObjectForKey("h") as NSMutableArray
//        for var i = 0;i<arr7.count; i++
//        {
//            var str = arr7 .pObjectAtIndex(i) as NSString
//            listArry .addObject(str);
//        }
////        var arr8 = list .arrayObjectForKey("i") as NSMutableArray
////        for var i = 0;i<arr8.count; i++
////        {
////            var str = arr8 .pObjectAtIndex(i) as NSString
////            listArry .addObject(str);
////        }
//        var arr88 = list .arrayObjectForKey("j") as NSMutableArray
//        for var i = 0;i<arr88.count; i++
//        {
//            var str = arr88 .pObjectAtIndex(i) as NSString
//            listArry .addObject(str);
//        }
//        var arr9 = list .arrayObjectForKey("k") as NSMutableArray
//        for var i = 0;i<arr9.count; i++
//        {
//            var str = arr9.pObjectAtIndex(i) as NSString
//            listArry .addObject(str);
//        }
//        var arr10 = list .arrayObjectForKey("l") as NSMutableArray
//        for var i = 0;i<arr10.count; i++
//        {
//            var str = arr10 .pObjectAtIndex(i) as NSString
//            listArry .addObject(str);
//        }
////        var arr11 = list .arrayObjectForKey("m") as NSMutableArray
////        for var i = 0;i<arr11.count; i++
////        {
////            var str = arr11 .pObjectAtIndex(i) as NSString
////            listArry .addObject(str);
////        }
//        var arr12 = list .arrayObjectForKey("n") as NSMutableArray
//        for var i = 0;i<arr12.count; i++
//        {
//            var str = arr12.pObjectAtIndex(i) as NSString
//            listArry .addObject(str);
//        }
////        var arr13 = list .arrayObjectForKey("o") as NSMutableArray
////        for var i = 0;i<arr13.count; i++
////        {
////            var str = arr13 .pObjectAtIndex(i) as NSString
////            listArry .addObject(str);
////        }
//        var arr14 = list .arrayObjectForKey("p") as NSMutableArray
//        for var i = 0;i<arr14.count; i++
//        {
//            var str = arr14 .pObjectAtIndex(i) as NSString
//            listArry .addObject(str);
//        }
//        var arr15 = list .arrayObjectForKey("q") as NSMutableArray
//        for var i = 0;i<arr15.count; i++
//        {
//            var str = arr15 .pObjectAtIndex(i) as NSString
//            listArry .addObject(str);
//        }
//        var arr16 = list .arrayObjectForKey("r") as NSMutableArray
//        for var i = 0;i<arr16.count; i++
//        {
//            var str = arr16 .pObjectAtIndex(i) as NSString
//            listArry .addObject(str);
//        }
//        var arr17 = list .arrayObjectForKey("s") as NSMutableArray
//        for var i = 0;i<arr17.count; i++
//        {
//            var str = arr17 .pObjectAtIndex(i) as NSString
//            listArry .addObject(str);
//        }
////        var arr18 = list .arrayObjectForKey("t") as NSMutableArray
////        for var i = 0;i<arr18.count; i++
////        {
////            var str = arr18 .pObjectAtIndex(i) as NSString
////            listArry .addObject(str);
////        }
////        var arr19 = list.arrayObjectForKey("u") as NSMutableArray
////        for var i = 0;i<arr19.count; i++
////        {
////            var str = arr19.pObjectAtIndex(i) as NSString
////            listArry .addObject(str);
////        }
////        var arr20 = list .arrayObjectForKey("v") as NSMutableArray
////        for var i = 0;i<arr20.count; i++
////        {
////            var str = arr20.pObjectAtIndex(i) as NSString
////            listArry .addObject(str);
////        }
//        var arr21 = list .arrayObjectForKey("w") as NSMutableArray
//        for var i = 0;i<arr21.count; i++
//        {
//            var str = arr21 .pObjectAtIndex(i) as NSString
//            listArry .addObject(str);
//        }
//        var arr22 = list.arrayObjectForKey("x") as NSMutableArray
//        for var i = 0;i<arr22.count; i++
//        {
//            var str = arr22.pObjectAtIndex(i) as NSString
//            listArry .addObject(str);
//        }
//        var arr23 = list .arrayObjectForKey("y") as NSMutableArray
//        for var i = 0;i<arr23.count; i++
//        {
//            var str = arr23.pObjectAtIndex(i) as NSString
//            listArry .addObject(str);
//        }
//        var arr24 = list.arrayObjectForKey("z") as NSMutableArray
//        for var i = 0;i<arr24.count; i++
//        {
//            var str = arr24.pObjectAtIndex(i) as NSString
//            listArry .addObject(str);
//        }
       
        

    }
    func didSelectedSearchTitle(title: String!)
    {
        if backView != nil
        {
            weak var weakSelf:HWSelectCitysViewController? = self
            UIView .animateWithDuration(0.3, animations: { () -> Void in
                var originY: CGFloat? = weakSelf?.backView.frame.origin.y
                weakSelf?.backView.frame = CGRectMake(0, originY!, kScreenWidth, 0)
                self.backView.removeFromSuperview()
                }, completion: { (finished) -> Void in
                    self.backView.removeFromSuperview()
                    self.backView = nil
            })
        }
        searchTitle = title
        searchArry .removeAllObjects()
        for (var i = 0;i < HWUserLogin.currentUserLogin().cities.count;i++)
        {
            let cityClass = HWUserLogin.currentUserLogin().cities[i] as HWCityClass
            var pingYin = cityClass.cityPinyin
            var shouPingYin = pingYin?.substringToIndex(1)
            var hanZi = cityClass.cityName
           if shouPingYin == title || hanZi?.rangeOfString(title).location != NSNotFound
           {
            searchArry.addObject(hanZi!)
           }
        }
     tabView.reloadData()
    }
    func didBeginEditing()
    {
        if backView == nil
        {
            backView = UIView(frame: CGRectMake(0, CGRectGetMaxY(_searchBar.frame), kScreenWidth, 0))
            backView.backgroundColor = UIColor(white: 0, alpha: 0.6)
            backView.layer.masksToBounds = true
            self.view .addSubview(backView)
            self.view .bringSubviewToFront(backView)
            weak var weakSelf:HWSelectCitysViewController? = self
            UIView  .animateWithDuration(0.3, animations: { () -> Void in
                var originY: CGFloat? = weakSelf?.backView.frame.origin.y
                weakSelf?.backView.frame = CGRectMake(0, originY!, kScreenWidth, contentHeight)
            })

        }
    }
    //结束编辑状态，移除蒙版
    
    func didEndEditing()
    {
        if backView != nil
        {
            weak var weakSelf:HWSelectCitysViewController? = self
           UIView .animateWithDuration(0.3, animations: { () -> Void in
            var originY: CGFloat? = weakSelf?.backView.frame.origin.y
            weakSelf?.backView.frame = CGRectMake(0, originY!, kScreenWidth, 0)
            self.backView.removeFromSuperview()
           }, completion: { (finished) -> Void in
            self.backView.removeFromSuperview()
            self.backView = nil
           })
        }
        
        
       

       

    }
    func didSelectedSearchBtn()
    {
        if backView != nil
        {
            weak var weakSelf:HWSelectCitysViewController? = self
            UIView .animateWithDuration(0.3, animations: { () -> Void in
                var originY: CGFloat? = weakSelf?.backView.frame.origin.y
                weakSelf?.backView.frame = CGRectMake(0, originY!, kScreenWidth, 0)
                self.backView.removeFromSuperview()
                }, completion: { (finished) -> Void in
                    self.backView.removeFromSuperview()
                    self.backView = nil
            })
        }

    }
    
    func scrollViewWillBeginDragging(scrollView: UIScrollView) {
        view.endEditing(true);
    }
    
    override func didReceiveMemoryWarning()
    {
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
