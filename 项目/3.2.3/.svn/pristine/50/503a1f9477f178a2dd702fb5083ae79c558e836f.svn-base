//
//  HWRelativeSecondHouseViewController.swift
//  Partner-Swift
//
//  Created by gusheng on 15/3/4.
//  Copyright (c) 2015年 caijingpeng.haowu. All rights reserved.
//

import UIKit

class HWRelativeSecondHouseViewController: HWBaseViewController,CustomSegmentControlDelegate,CustomSearchViewDelegate,relativeSecondHouseDelegate,relativeCollectHouseDelegate
{
    var _segementControl:CustomSegmentControl!
    var customerLabel:UILabel!;
    var relativeHouseView:HWRelativeSecondHouseView!;
    var collectionView:HWRelativeCollectHouseView!;
    var choiceSectionView: CustomSearchView!;
    var selectedSecondHouseArry:NSMutableArray!;
    var clientInfoId:NSString = NSString()
    var selectCustomerV:UIImageView!;
    var arrys = NSArray()
    typealias selectCustomerBlock = () ->Void
    var myFunc = selectCustomerBlock?()

    override func viewWillAppear(animated: Bool)
    {
        super.viewWillAppear(animated)
        self.navigationController?.navigationBarHidden = false
        self.navigationItem.titleView = _segementControl
        
    }
    override func viewWillDisappear(animated: Bool)
    {
        
    }
    override func viewDidLoad()
    {
        super.viewDidLoad()
        _segementControl = CustomSegmentControl(titles: ["收藏","二手房"])
        _segementControl.delegate = self;
        _segementControl.selectedIndex = 1;
        selectedSecondHouseArry = NSMutableArray();
        relativeHouseView = HWRelativeSecondHouseView(frame: CGRectMake(0, 35, kScreenWidth, contentHeight-44-35));
        relativeHouseView.delegate = self;
        relativeHouseView.clientInfoId = clientInfoId
        self.view.addSubview(relativeHouseView);
        relativeHouseView.queryListData();
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
        
        var arrys:NSArray = ["1","2","3"];
        choiceSectionView = CustomSearchView(items: [cityClass.areas!, ["不限","100万以下", "100-150万", "150-200万", "200-300万", "300-500万", "500-1000万", "1000万以上"], ["不限","一居","二居","三居","四居","五居","五居以上"], ["默认排序","楼盘均价正序","楼盘均价倒序","开盘时间正序","开盘时间倒序","报备数正序","佣金正序"]], andDefaultTitles: ["区域","价格","户型","排序"], hasSubTitles: true);
        
        //主视图
        choiceSectionView.delegate = self
        self.view.addSubview(choiceSectionView)
        
        
        //创建选择视图
        var selectCustomerVFrame = CGRectMake(0, contentHeight-44, kScreenWidth, 44);
        selectCustomerV = createCustomerImageView(selectCustomerVFrame, "");
        selectCustomerV.backgroundColor = CD_Btn_GrayColor;
        selectCustomerV.userInteractionEnabled = true
        self.view.addSubview(selectCustomerV);
        
        //
        var customerNumLabelFrame:CGRect = CGRectMake(15,(44-16)/2-5,200, 16);
        customerLabel = createCustomeLabel(customerNumLabelFrame, CD_Txt_Color_ff, "已选择匹配二手房0个", TF_14);
        selectCustomerV.addSubview(customerLabel);
        
        var selectCustomerBtnFrame = CGRectMake(kScreenWidth-15-112, 5, 112, 35);
        var selectCustomerBtn:UIButton = createCustomeBtn(self, "selectCustomer", selectCustomerBtnFrame, nil, "", "");
        selectCustomerBtn.layer.cornerRadius = 3.0;
        selectCustomerBtn.layer.masksToBounds = true;
        selectCustomerBtn.backgroundColor = CD_MainColor;
        selectCustomerBtn.setTitle("确定", forState: UIControlState.Normal);
        selectCustomerBtn .setTitleColor(UIColor.whiteColor(), forState: UIControlState.Normal);
        selectCustomerV.addSubview(selectCustomerBtn);
    }
    //MARK: 筛选框代理事件
    func customerSearchView(customerSearchView: CustomSearchView!, passValue value: String!, withIndex index: String!)
    {
        relativeHouseView .customerSearchView(customerSearchView, passValue: value, withIndex: index)
    }
    
    func customerSearchView(customerSearchView: CustomSearchView!, passZone zoneId: String!, plateId: String!)
    {
        relativeHouseView.customerSearchView(customerSearchView, passZone: zoneId, plateId: plateId)
    }
    override func viewDidAppear(animated: Bool)
    {
        
    }
    override func viewDidDisappear(animated: Bool)
    {
        self.tabBarController?.navigationItem.titleView = nil
    }
    override func didReceiveMemoryWarning()
    {
        super.didReceiveMemoryWarning()
    }
    //MARK:--选择关联二手房
    func relativeSecondHouseSelected(arry: NSMutableArray)
    {
       
        var houseArry:NSMutableArray =  NSMutableArray(array: arry);
        selectedSecondHouseArry.removeAllObjects();
        selectedSecondHouseArry.addObjectsFromArray(houseArry);
        var rows:Int = arry.count;
        arrys = arry
        customerLabel.text = "已选择匹配二手房"+"\(rows)"+"个";
    }
    //查看所有二手房
    func lookAllSecondHouse()
    {
        
    }
    func selectCustomer()
    {
      //  var houseModel = arrys[0] as HWSecondHouseModel
        
        Utility.showMBProgress(self.view, _message: "加载中");
        let manager = HWHttpRequestOperationManager.baseManager()
        var param:NSMutableDictionary = NSMutableDictionary();
        param.setPObject(HWUserLogin.currentUserLogin().key, forKey: "key");
        param.setPObject(clientInfoId, forKey: "clientInfoId")
        for var i = 0; i < arrys.count;i++
        {
            var houseModel = arrys .objectAtIndex(i) as HWScdHouseModel
            param.setPObject(houseModel.houseId, forKey: "houseList[\(i)].houseId")
            param.setPObject(houseModel.title, forKey: "houseList[\(i)].houseName")
        }
        manager.postHttpRequest(kmatchSecondHouse, parameters: param, queue: nil, success: { (responseObject) -> Void in
            Utility.hideMBProgress(self.view);
            Utility.showToastWithMessage("关联成功", _view: self.view);
            if (self.myFunc != nil)
            {
                self.myFunc!()
            }
            self.navigationController?.popViewControllerAnimated(true)
            
            }) { (code, error) -> Void in
                Utility.hideMBProgress(self.view)
                Utility .showToastWithMessage(error, _view: self.view)
        }

    }
    func returnSelectedCollectionHouse(arry: NSMutableArray)
    {
        
        var houseArry:NSMutableArray =  NSMutableArray(array: arry);
        selectedSecondHouseArry.removeAllObjects();
        selectedSecondHouseArry.addObjectsFromArray(houseArry);
        var rows:Int = arry.count;
        arrys = arry
        customerLabel.text = "已选择匹配二手房"+"\(rows)"+"个";
    }
    //MARK:--segmentControl代理方法
    func segmentControl(sControl: CustomSegmentControl!, didSelectSegmentIndex index: Int32)
    {
        if(index == 0)
        {
            if(collectionView == nil)
            {
                collectionView = HWRelativeCollectHouseView(frame: CGRectMake(0, 0, kScreenWidth, contentHeight-44));
                collectionView.delegate = self;
                self.view.addSubview(collectionView);
            }
            if(collectionView != nil)
            {
                collectionView.hidden = false;
            }
            collectionView.selectedCustomerArry = selectedSecondHouseArry;
            choiceSectionView.hidden = true;
            relativeHouseView.hidden = true;
            collectionView.queryListData();
        }
        else
        {
            if(relativeHouseView == nil) 
            {
                relativeHouseView = HWRelativeSecondHouseView(frame: CGRectMake(0, 35, kScreenWidth, contentHeight-44))
                relativeHouseView.delegate = self;
                relativeHouseView.clientInfoId = clientInfoId
                self.view.addSubview(relativeHouseView);
            }
            if(relativeHouseView != nil)
            {
                relativeHouseView.hidden = false;
            }
            relativeHouseView.selectedCustomerArry = selectedSecondHouseArry;
            choiceSectionView.hidden = false;
            if(collectionView != nil)
            {
                collectionView.hidden = true;
            }
            
            relativeHouseView.queryListData()
        }
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
