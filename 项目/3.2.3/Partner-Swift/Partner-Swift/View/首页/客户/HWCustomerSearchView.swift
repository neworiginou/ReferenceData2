//
//  HWCustomerSearchView.swift
//  Partner-Swift
//
//  Created by gusheng on 15/2/19.
//  Copyright (c) 2015年 caijingpeng.haowu. All rights reserved.
//

import UIKit
protocol HWCustomerSearchDelegate: NSObjectProtocol
{
    func didSearchTitle(title:NSString)->Void;
    func didSelectMenuByIndex(index: NSInteger)
    func didSelectMenufirstIdAndSecondId(first:NSString,second:NSString)->Void
    func didMenuEnd()->Void;
    func didMenuStart()->Void;
}
enum HWCustomerSearchModel
{
    case FilterModel;
    case SearchModel;
    case NoneModel;
}
class HWCustomerSearchView: HWPerformSelectorView,UITextFieldDelegate,UITableViewDataSource,UITableViewDelegate,CustomerSearchViewDelegate
{
    var totalSearchBg:UIImageView = UIImageView();
    var searchBar:UITextField = UITextField();
    var dataTable:UITableView = UITableView();
    var filterView:HWCustomerView = HWCustomerView();
    var tableView:UITableView = UITableView();

    var cancelBtn:UIButton = UIButton();
    var titleStr:NSString = NSString();
    var delegate:HWCustomerSearchDelegate?;
    var isShowMenuFlag:Bool = true;
    var searchModelType: NSInteger? = 2;//普通模式
     var filterConditionArry = NSMutableArray()
    
    var searchDataArry = NSMutableArray();
    
    var tapControl: UIControl!;
    
    var barHeight: CGFloat! = 0
    var containerHeight: CGFloat! = 0
    var type:String!
    
    required init(coder aDecoder: NSCoder)
    {
        super.init(coder: aDecoder);
    }
    init(frame: CGRect,type:String)
    {
        super.init(frame: frame);
        self.type = type
        barHeight = frame.size.height
        self.setUpView(frame);
        self.layer.masksToBounds = true
        self.drawBottomLine()
        self.backgroundColor = UIColor.clearColor()
        if HWUserLogin.currentUserLogin().brokerType == "C"
      {
        
           filterConditionArry = ["默认",["已报备","已到访","已下定","已成交"],["下线客户","分享客户","合作客户","抢到客户","租售中心"],"无意向"];
      }
        
        else
        {
            filterConditionArry = ["默认",["已报备","已到访","已下定","已成交"],["分享客户","合作客户","抢到客户","租售中心"],"无意向"];
        }
    }
    func setUpView(frame: CGRect) -> Void
    {
        self.userInteractionEnabled = true;
        var totalSearchBgFrame: CGRect = CGRectMake(0, 0, frame.size.width + 45, frame.size.height);
        totalSearchBg = createCustomerImageView(totalSearchBgFrame, "");
        totalSearchBg.userInteractionEnabled = true;
        totalSearchBg.backgroundColor = CD_BackGroundColor;
//        totalSearchBg.layer.masksToBounds = true
        self.addSubview(totalSearchBg);
        
        let searchBgFrame: CGRect = CGRectMake(0, 0, frame.size.width, frame.size.height);
        var searchBgV:UIImageView = createCustomerImageView(searchBgFrame, "");
        searchBgV.userInteractionEnabled = true;
        searchBgV.backgroundColor = CD_BackGroundColor
        totalSearchBg.addSubview(searchBgV);
        
        var filterFrame: CGRect = CGRectMake(0, 0, 45, frame.size.height);
        var filterBtn: UIButton = createCustomeBtn(self, "doFilter:", filterFrame, nil, "", "schedule1");
        filterBtn.userInteractionEnabled = true;
        filterBtn.backgroundColor = UIColor.clearColor()
        searchBgV.addSubview(filterBtn);
        
        searchBar = UITextField(frame: CGRectMake(58, 10, frame.size.width - 15 - 58, frame.size.height - 2 * 10));
        searchBar.backgroundColor = UIColor.whiteColor();
        searchBar.layer.cornerRadius = 4;
        searchBar.userInteractionEnabled = true;
        searchBar.layer.borderColor = CD_LineColor.CGColor;
        searchBar.layer.borderWidth = 0.5;
        searchBar.leftViewMode = UITextFieldViewMode.Always;
        searchBar.placeholder = "客户姓名,手机号,楼盘精准搜索";
        searchBar.textColor = CD_Txt_Color_33;
        searchBar.returnKeyType = UIReturnKeyType.Search;
        searchBar.contentVerticalAlignment  = UIControlContentVerticalAlignment.Center;
        searchBar.font = UIFont.systemFontOfSize(TF_14);
        searchBar.delegate = self;
       
        var leftV:UIView = UIView(frame: CGRectMake(0, 0, 25, 25));
        var imageVFrame:CGRect = CGRectMake(0, 0, 16, 16);
        var imageV:UIImageView = createCustomerImageView(imageVFrame,"search");
        imageV.center = CGPointMake(leftV.frame.width / 2.0 + 3, leftV.frame.height / 2.0);
        leftV.addSubview(imageV);
        searchBar.leftView = leftV;
        searchBar.clearButtonMode = UITextFieldViewMode.WhileEditing;
        searchBgV.addSubview(searchBar);
        
        var cancelFrame:CGRect = CGRectMake(self.frame.size.width - 60, searchBar.frame.origin.y, 60, searchBar.frame.size.height);
        cancelBtn = createCustomeBtn(self, "doCancel:", cancelFrame, CD_RedDeepColor, "取消", "");
        cancelBtn.setTitle("取消", forState: UIControlState.Normal);
        cancelBtn.backgroundColor = CD_BackGroundColor
        cancelBtn.setTitleColor(CD_MainColor, forState: UIControlState.Normal);
        cancelBtn.titleLabel?.font = UIFont.systemFontOfSize(TF_15);
        cancelBtn.userInteractionEnabled = true
        cancelBtn.alpha = 0
        self.addSubview(cancelBtn);
        
        tapControl = UIControl(frame: CGRectMake(0, CGRectGetMaxY(totalSearchBg.frame), frame.size.width, UIScreen.mainScreen().bounds.size.height))
        tapControl.backgroundColor = UIColor(white: 0, alpha: 0.6)
        tapControl.addTarget(self, action: "doTap:", forControlEvents: UIControlEvents.TouchUpInside)
        self.addSubview(tapControl)
        
        //创建TableView
        dataTable = UITableView(frame: CGRectMake(0, CGRectGetMaxY(totalSearchBg.frame), kScreenWidth, 0));
        dataTable.userInteractionEnabled = true;
        dataTable.delegate = self;
        dataTable.dataSource = self;
        dataTable.backgroundColor = CD_BackGroundColor;
        dataTable.separatorStyle = UITableViewCellSeparatorStyle(rawValue: 0)!;
        self.addSubview(dataTable);
        if type == "1"
        {
            searchBar.frame = CGRectMake(15, 10, kScreenWidth-30, frame.size.height - 2 * 10)
            searchBar.placeholder = "请输入城市或首字母查询"
            filterBtn.hidden = true
        }
        self.getFliterConditionRequest();
        //end
    }
    //MARK:-获取筛选提条件
    func getFliterConditionRequest()->Void
    {
        var manager : HWHttpRequestOperationManager = HWHttpRequestOperationManager.baseManager()
        var dict : NSMutableDictionary = ["key":HWUserLogin.currentUserLogin().key]
        manager.postHttpRequest(kClientCatory, parameters: dict, queue: nil, success: { (responObject) -> Void in
            
            var documentsDirectory = NSSearchPathForDirectoriesInDomains(NSSearchPathDirectory.DocumentDirectory, NSSearchPathDomainMask.UserDomainMask, true)[0] as NSString
            var filePath = documentsDirectory.stringByAppendingPathComponent("city.plist")
            var cities : NSArray = NSArray(contentsOfFile: filePath)!
            var cityClass : HWCityClass = HWCityClass(dic: cities[0] as NSDictionary)
            for var i = 0; i < cities.count; i++
            {
                var cityCl = HWCityClass(dic: cities[i] as NSDictionary)
                if (cityCl.cityId! == HWUserLogin.currentUserLogin().cityId)
                {
                    cityClass = cityCl
                }
            }
            var contentDic : NSDictionary = responObject.dictionaryObjectForKey("data")
            var conentArry:NSMutableArray = NSMutableArray();
            var bigCatorgrayDic:NSDictionary = contentDic.dictionaryObjectForKey("clientBigType");
            var smallCatograyDic:NSDictionary = contentDic.dictionaryObjectForKey("clientType");
            for var i = 0; i < bigCatorgrayDic.allKeys.count; i++
            {
                var keyArry:NSArray = bigCatorgrayDic.allKeys;
                var bigCatoryStr:NSString = keyArry.objectAtIndex(i)as NSString;
                
                var smallArry:NSMutableArray = NSMutableArray();
                var smallDic:NSDictionary =  smallCatograyDic.dictionaryObjectForKey(bigCatoryStr)
                var smallKey:NSArray = smallDic.allKeys;
                if(bigCatoryStr.isEqualToString("need_district"))
                {
                    var areaArry:NSMutableArray = cityClass.areas as NSMutableArray!;
                    for var  j = 0 ; j < areaArry.count ; j++
                    {
                        var smallPlat:HWSearchPlateModel = HWSearchPlateModel(plate: NSDictionary());
                        var smallModel:HWSearchAreaModel = areaArry.objectAtIndex(j) as HWSearchAreaModel;
                        smallPlat.name = smallModel.area_name;
                        smallPlat.plate_id = smallModel.area_id;
                        smallArry.addObject(smallPlat);
                    }

                }
                else
                {
                    for var  j = 0 ; j < smallKey.count ; j++
                    {
                    var smallPlat:HWSearchPlateModel = HWSearchPlateModel(plate: NSDictionary());
                    var smallKeyStr:NSString = smallKey.objectAtIndex(j) as NSString;
                    var smallValueStr:NSString = smallDic.stringObjectForKey(smallKeyStr);
                        smallPlat.plate_id = smallKeyStr;
                    smallPlat.name = smallValueStr;
                    smallArry.addObject(smallPlat);
                    }

                }
                
                
                var catorgroyModel:HWSearchAreaModel = HWSearchAreaModel(area: NSDictionary());
                catorgroyModel.area_name = bigCatorgrayDic.stringObjectForKey(bigCatoryStr);
                catorgroyModel.plates = smallArry;
                catorgroyModel.area_id = bigCatoryStr;
                
                conentArry.addObject(catorgroyModel);
            }
            
            
            //
            //add by gusheng3.2.3
            self.filterView = HWCustomerView(items: conentArry, andCCustomerDefaultTitles: ["1"], hasSubTitles: true, height: CGRectGetMaxY(self.totalSearchBg.frame));
            self.filterView.delegate1 = self;
            self.addSubview(self.filterView);
            
            }) { (failure, error) -> Void in
               
        }

    }
    func customerSearchView(customerSearchView: CustomSearchView!, passZone zoneId: String!, plateId: String!)
    {
        MobClick.event("Newhouse-areafilter_click")
//        if (delegate != nil && delegate?.respondsToSelector("didSelectMenufirstIdAndSecondId:") == true)
//        {
            delegate?.didSelectMenufirstIdAndSecondId(zoneId, second: plateId);
//        }
        
    }
    //MARK:--textFielDelegate 方法
    func textField(textField: UITextField, shouldChangeCharactersInRange range: NSRange, replacementString string: String) -> Bool
    {
        var text:NSMutableString = NSMutableString(string: textField.text).mutableCopy() as NSMutableString;
        text.replaceCharactersInRange(range, withString: string);
        titleStr = text;
        self.execMessage("performTime", withObject: nil, afterDelay: 0.5);
        print(text);
        return true;
    }
    func textFieldShouldReturn(textField: UITextField) -> Bool
    {
        titleStr = textField.text;
        self.delegate?.didSearchTitle(titleStr);
        textField.resignFirstResponder();
        
        // 保存 搜索历史
        let userDefault = NSUserDefaults.standardUserDefaults()
        var tmpArr: NSArray? = userDefault.objectForKey("history") as? NSArray
        var historyArr: NSMutableArray?
        
        if (tmpArr != nil)
        {
            historyArr = NSMutableArray(array: tmpArr!)
            historyArr?.insertObject(titleStr, atIndex: 0)
            if (historyArr?.count > 5)
            {
                historyArr?.removeObjectAtIndex(5)
            }
        }
        else
        {
            historyArr = NSMutableArray(object: titleStr)
        }
        
        userDefault.setObject(historyArr, forKey: "history")
        
        return true;
    }
    func textFieldShouldBeginEditing(textField: UITextField) -> Bool
    {
        if (containerHeight == 0)
        {
            let superview: UIView! = self.superview
            let windowPos: CGPoint = superview.convertPoint(CGPointMake(0, frame.origin.y + frame.size.height), toView: self.window)
//            println("坐标 \(windowPos)")
            containerHeight = UIScreen.mainScreen().bounds.size.height - CGFloat(windowPos.y)
        }
        
        UIView.animateWithDuration(0.3)
        {
            self.frame = CGRectMake(self.frame.origin.x, self.frame.origin.y, self.frame.size.width, contentHeight + self.barHeight);
            self.totalSearchBg.frame = CGRectMake(-45, self.totalSearchBg.frame.origin.y, self.totalSearchBg.frame.size.width, self.totalSearchBg.frame.size.height)
            
        }
        self.cancelBtn.alpha = 1
        searchModelType = 1;//代表开启搜索模式
        delegate?.didMenuStart();
        
        self.searchDataArry = self.loadSearchHistroy()
        dataTable.frame = CGRectMake(0, dataTable.frame.origin.y, kScreenWidth, CGFloat(45 * searchDataArry.count));
        
        self.dataTable.reloadData()
        
        return true;
    }
    func textFieldShouldEndEditing(textField: UITextField) -> Bool
    {
        UIView.animateWithDuration(0.3)
        {
            self.frame = CGRectMake(0, self.frame.origin.y, self.frame.size.width, self.barHeight);
            self.totalSearchBg.frame = CGRectMake(0, self.totalSearchBg.frame.origin.y, self.totalSearchBg.frame.size.width, self.totalSearchBg.frame.size.height)
            
            self.delegate?.didMenuEnd();
        }
        self.cancelBtn.alpha = 0
        return true;
    }
    //MARK:-UITableViewDelegate方法
    func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat
    {
        if(searchModelType == 2)
        {
            return 0.0;
        }
        else
        {
            return 45.0;
        }
    }
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int
    {
        if(searchModelType == 0)
        {
            if section == 0
            {
              return 1;
            }
            if section == 1
            {
                return 4;
            }
            if section == 2
            {
                if HWUserLogin.currentUserLogin().brokerType == "C"
                {
                    return 5;
                }
                else
                {
                    return 4;
                }
            }
            if section == 3
            {
                return 1;
            }
            
            
            
    }
        else if(searchModelType == 1)
        {
            return searchDataArry.count;
        }
        else
        {
            return 0;
        }
        return 0
    }

    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath)
    {
        tableView.deselectRowAtIndexPath(indexPath, animated: true)
        
        if (searchModelType == 0)
        {
            // 筛选
            var detailText: NSString;
            if(indexPath.section == 0)
            {
                detailText = filterConditionArry[0] as NSString;
            }
            else if(indexPath.section == 1)
            {
                let detailArry:NSArray = filterConditionArry[1] as NSArray;
                detailText = detailArry[indexPath.row]as NSString;
            }
            else if(indexPath.section == 2)
            {
                let detailArry:NSArray = filterConditionArry[2] as NSArray;
                detailText = detailArry[indexPath.row]as NSString;
            }
            else
            {
                 //let detailArry:NSArray = filterConditionArry[3] as NSArray;
                detailText = filterConditionArry[3] as NSString;
            }
            
            self.endEditing(true)
            
            UIView.animateWithDuration(0.3)
                {
                    self.frame = CGRectMake(0, self.frame.origin.y, self.frame.size.width, self.barHeight);
                    self.totalSearchBg.frame = CGRectMake(0, self.totalSearchBg.frame.origin.y, self.totalSearchBg.frame.size.width, self.totalSearchBg.frame.size.height)
            }
            self.cancelBtn.alpha = 0
            
            if (delegate != nil && delegate?.respondsToSelector("didSelectMenuByIndex:") == true)
            {
                delegate?.didSelectMenuByIndex(Utility.parseClientCategory(detailText).integerValue)
            }
        } 
        else if (searchModelType == 1)
        {
            // 搜索
            
            var searchKeyStr = searchDataArry.pObjectAtIndex(indexPath.row) as String
            
            if searchKeyStr == "清空历史"
            {
                self.clearSearchHistroy()
                self.searchDataArry = NSMutableArray()
                dataTable.frame = CGRectMake(0, dataTable.frame.origin.y, kScreenWidth, CGFloat(45 * searchDataArry.count));
                self.dataTable.reloadData()
            }
            else
            {
                titleStr = searchKeyStr
                self.delegate?.didSearchTitle(searchKeyStr)
                searchBar.text = titleStr
                self.endEditing(true);
                self.saveSearchHistroy()
            }
            
        }
        
        
    }
    func tableView(tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat
    {
        if(searchModelType == 0)
        {
            if(section == 3)
            {
                return 0.0;
            }
            else
            {
                return 10.0;
            }
        }
        else
        {
            return 0;
        }
    }
    func tableView(tableView: UITableView, viewForFooterInSection section: Int) -> UIView?
    {
        var sectionFootV :UIImageView = createCustomerImageView(CGRectMake(0, 0, kScreenWidth, 10), "");
        sectionFootV.backgroundColor = CD_BackGroundColor;
        var topLineImageV:UIImageView = createCustomerImageView(CGRectMake(0, 0, kScreenWidth, lineHeight), "");
        topLineImageV.backgroundColor = CD_LineColor;
        sectionFootV.addSubview(topLineImageV);
        
        var botomeLineImageV:UIImageView = createCustomerImageView(CGRectMake(0, 10-lineHeight, kScreenWidth, lineHeight), "");
        botomeLineImageV.backgroundColor = CD_LineColor;
        sectionFootV.addSubview(botomeLineImageV);
        
        return sectionFootV;

    }
    func tableView(tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat
    {
        return 0.0;
    }
    func numberOfSectionsInTableView(tableView: UITableView) -> Int
    {
        if(searchModelType == 0)
        {
            return 4;
        }
        else if(searchModelType == 1)
        {
            return 1;
        }
        else
        {
            return 0;
        }
    }
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell
    {
        var cell:UITableViewCell;
        let identifyOne = "identifyOne";
        let identifyTwo = "identifyTwo";
        let identifyThree = "identifyThree";
        let row:Int = indexPath.row;
        if(searchModelType == 0)
        {
            cell = UITableViewCell(style: UITableViewCellStyle.Default, reuseIdentifier:identifyOne);
            if(indexPath.section == 0)
            {
                let detailText:NSString = filterConditionArry[0] as NSString;
                cell.textLabel?.text = detailText
                cell.textLabel?.textColor = CD_MainColor;
                cell.textLabel?.font = Define.font(TF_14);
            }
            else if(indexPath.section == 1)
            {
                let detailArry:NSArray = filterConditionArry[1] as NSArray;
                let detailText:NSString = detailArry[indexPath.row]as NSString;
                cell.textLabel?.text = detailText
                cell.textLabel?.textColor = CD_Txt_Color_00;
                cell.textLabel?.font = Define.font(TF_14);
            }
            else if(indexPath.section == 2)
            {
                let detailArry:NSArray = filterConditionArry[2] as NSArray;
                let detailText:NSString = detailArry[indexPath.row]as NSString;
                cell.textLabel?.text = detailText
                cell.textLabel?.textColor = CD_Txt_Color_00;
                cell.textLabel?.font = Define.font(TF_14);
            }
            else
            {
              // let detailArry:NSArray = filterConditionArry[3] as NSArray;
                let detailText:NSString = filterConditionArry[3]as NSString;
                cell.textLabel?.text = detailText
                cell.textLabel?.textColor = CD_Txt_Color_00;
                cell.textLabel?.font = Define.font(TF_14);
            }
            if(indexPath.section == 1 || indexPath.section == 2)
            {
                if indexPath.section == 2
            {
               if filterConditionArry[2].count == 5
                {
                    if(row != 4)
                    {
                        var lineImageV: UIImageView = createCustomerImageView(CGRectMake(15, 45-lineHeight, kScreenWidth-15, lineHeight), "");
                        lineImageV.backgroundColor = CD_LineColor;
                        cell.addSubview(lineImageV);
                    }
                    

                }
                
//                else
//               {
//                
//                }
//                if filterConditionArry[2].count == 4
//                {
//                    if(row != 3)
//                    {
//                        var lineImageV: UIImageView = createCustomerImageView(CGRectMake(15, 45-lineHeight, kScreenWidth-15, lineHeight), "");
//                        lineImageV.backgroundColor = CD_LineColor;
//                        cell.addSubview(lineImageV);
//                    }
//                    
//                    
//                }

                               
             }
                if(row != 3)
                {
                    var lineImageV: UIImageView = createCustomerImageView(CGRectMake(15, 45-lineHeight, kScreenWidth-15, lineHeight), "");
                    lineImageV.backgroundColor = CD_LineColor;
                    cell.addSubview(lineImageV);
                }
                
            }
            
//            if indexPath.section == 3
//            {
//                if indexPath.row == 0
//                {
//                    var lineImageV: UIImageView = createCustomerImageView(CGRectMake(15, 45-lineHeight, kScreenWidth-15, lineHeight), "");
//                    lineImageV.backgroundColor = CD_LineColor;
//                    cell.addSubview(lineImageV);
//
//                }
//            }
        }
        else if(searchModelType == 1)
        {
            cell = UITableViewCell(style: UITableViewCellStyle.Default, reuseIdentifier:identifyTwo);
            cell.textLabel?.text = searchDataArry[indexPath.row] as? String;
            var lineImageV: UIImageView = createCustomerImageView(CGRectMake(15, 45-lineHeight, kScreenWidth-15, lineHeight), "");
            lineImageV.backgroundColor = CD_LineColor;
            cell.addSubview(lineImageV);
            
        }
        else
        {
           cell = UITableViewCell(style: UITableViewCellStyle.Default, reuseIdentifier: identifyThree);
        }
        return cell;
    }

    func performTime()->Void
    {
        if (titleStr.length <= 0)
        {
            searchDataArry = NSMutableArray()
            dataTable.reloadData()
        }
        else
        {
            let manager = HWHttpRequestOperationManager.baseManager()
            var param: NSMutableDictionary = NSMutableDictionary()
            param.setPObject(titleStr, forKey: "clientName")
            param.setPObject("1", forKey: "pageNumber")
            param.setPObject("10", forKey: "pageSize")
            param.setPObject(HWUserLogin.currentUserLogin().key, forKey: "key")
//            clientName=w&pageSize=1& pageNumber=2
            manager.postHttpRequest(kClientSearch, parameters: param, queue: nil, success: { (responseObject) -> Void in
            
//                println(responseObject)
                var responseDic: NSDictionary = responseObject as NSDictionary
                var resultArray: NSArray = responseDic.arrayObjectForKey("data")
                
                self.searchDataArry = NSMutableArray()
                for (var i = 0; i < resultArray.count; i++)
                {
                    var dic: NSDictionary = resultArray.objectAtIndex(i) as NSDictionary
                    var clientName: NSString = dic.stringObjectForKey("clinetName")
                    self.searchDataArry.addObject("\(clientName)")
                }
                dispatch_async(dispatch_get_main_queue(), { () -> Void in
                    self.dataTable.reloadData()
                    self.dataTable.frame = CGRectMake(0, self.dataTable.frame.origin.y, kScreenWidth, CGFloat(45 * self.searchDataArry.count));
                })
                
                
                }) { (code, error) -> Void in
                    Utility.showToastWithMessage(error, _view: self)
            }
        }
        
        if(self.searchModelType == 1)
        {
            
        }
        else
        {
            dataTable.frame = CGRectMake(0, dataTable.frame.origin.y, kScreenWidth, min(containerHeight, CGFloat(45 * 10 + 3 * 10)));
        }
//        dataTable.reloadData();
    }
    //按类别筛选
    func doFilter(sender:UIButton)->Void
    {
        if (containerHeight == 0)
        {
            let superview: UIView! = self.superview
            let windowPos: CGPoint = superview.convertPoint(CGPointMake(0, frame.origin.y + frame.size.height), toView: self.window)
//            println("坐标 \(windowPos)")
            containerHeight = UIScreen.mainScreen().bounds.size.height - CGFloat(windowPos.y)
        }
//
        searchModelType = 0;
//
//        dataTable.frame = CGRectMake(0, dataTable.frame.origin.y, kScreenWidth, min(containerHeight-44, CGFloat(45 * 10 + 3 * 10)));
//        dataTable.reloadData();
//        
//        UIView.animateWithDuration(0.3, animations: { () -> Void in
//            if(self.isShowMenuFlag)
//            {
//                self.frame = CGRectMake(self.frame.origin.x, self.frame.origin.y, self.frame.size.width, self.barHeight + self.containerHeight)
//            }
//            else
//            {
//                self.frame = CGRectMake(self.frame.origin.x, self.frame.origin.y, self.frame.size.width, self.barHeight)
//            }
//        })
//        
//        isShowMenuFlag = !isShowMenuFlag;
        if(self.isShowMenuFlag)
        {
            filterView.doSelect(nil);
            self.frame = CGRectMake(self.frame.origin.x, self.frame.origin.y, self.frame.size.width, self.barHeight + self.containerHeight)
            filterView.hidden = false;
        }
        else
        {
            filterView.hidden = true;
            self.frame = CGRectMake(self.frame.origin.x, self.frame.origin.y, self.frame.size.width, self.barHeight)
        }
        isShowMenuFlag = !isShowMenuFlag;
        
    }
    //取消搜索
    func doCancel(sender:UIButton)->Void
    {
        titleStr = "";
        self.delegate?.didSearchTitle(titleStr);
        self.endEditing(true);
    }
    
    func doTap(sender: UITapGestureRecognizer) -> Void
    {
        if (searchModelType == 0)
        {
            UIView.animateWithDuration(0.3, animations: { () -> Void in
                self.frame = CGRectMake(self.frame.origin.x, self.frame.origin.y, self.frame.size.width, self.barHeight)
            })
            self.cancelBtn.alpha = 0
        }
        else
        {
            titleStr = "";
            self.delegate?.didSearchTitle(titleStr);
            self.endEditing(true);
        }
        
        
    }
    
    
    func loadSearchHistroy() -> NSMutableArray
    {
        let userDefault = NSUserDefaults.standardUserDefaults()
        var historyArr: NSMutableArray? = userDefault.objectForKey("history") as? NSMutableArray
        
        if (historyArr != nil)
        {
            return historyArr!
        }
        else
        {
            return NSMutableArray()
        }
    }
    
    func saveSearchHistroy()
    {
        let userDefault = NSUserDefaults.standardUserDefaults()
        var tmpArr: NSArray? = userDefault.objectForKey("history") as? NSArray
        var historyArr: NSMutableArray?
        
        if (tmpArr != nil)
        {
            historyArr = NSMutableArray(array: tmpArr!)
            historyArr?.insertObject(titleStr, atIndex: 1)
            if (historyArr?.count > 6)
            {
                historyArr?.removeObjectAtIndex(6)
            }
        }
        else
        {
            historyArr = NSMutableArray(objects: "清空历史", titleStr)
        }
        
        userDefault.setObject(historyArr, forKey: "history")
    }
    
    func clearSearchHistroy()
    {
        let userDefault = NSUserDefaults.standardUserDefaults()
        userDefault.removeObjectForKey("history")
    }

}
