//
//  HWFlightHouseViewController.swift
//  Partner-Swift
//
//  Created by gusheng on 15/3/4.
//  Copyright (c) 2015年 caijingpeng.haowu. All rights reserved.
//

import UIKit

class HWFlightHouseViewController: HWBaseViewController,CustomSearchViewDelegate,selectFlightHouseDelegat,UIAlertViewDelegate
{
    var regionIdStr:String!;
  
    var clientInfoid :NSString = NSString()
    var modelArry = NSArray()
     var collectionView:HWFlightHouseView!
    typealias selectCustomerBlock = () ->Void
    var myFunc = selectCustomerBlock?()
    override func viewWillAppear(animated: Bool)
    {
        super.viewWillAppear(animated)
        self.navigationController?.navigationBarHidden = false
        
    }
    var customerLabel:UILabel!;
    override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: NSBundle?) {
        super.init(nibName:nibNameOrNil, bundle:nibBundleOrNil)
    }
    init(clientInfoId:NSString)
    {
        super.init()
        clientInfoid = clientInfoId
    }
    override func viewDidLoad()
    {
        super.viewDidLoad()
        self.navigationItem.titleView = Utility.navTitleView("报备新房")
        regionIdStr = "";
        var documentsDirectory = NSSearchPathForDirectoriesInDomains(NSSearchPathDirectory.DocumentDirectory, NSSearchPathDomainMask.UserDomainMask, true)[0] as NSString
      /*
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
*/
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

//        var choiceSectionView: CustomSearchView = CustomSearchView(items:NSArray(array: cityClass.areas!), andDefaultTitles: ["区域"], hasSubTitles: true);
        var arr : NSMutableArray = NSMutableArray()
        arr.addObject(cityClass.areas!)
        var choiceSectionView : CustomSearchView = CustomSearchView(items: arr, andDefaultTitles: ["区域"], hasSubTitles: true)
        //主视图
        choiceSectionView.delegate = self;
        self.view.addSubview(choiceSectionView)
        
         collectionView = HWFlightHouseView(frame:CGRectMake(0, 35, kScreenWidth, contentHeight-44-35-10),clientInfoId: clientInfoid)
            collectionView.delegate = self;
        self.view.addSubview(collectionView);
        
         
        //创建选择视图
        var selectCustomerVFrame = CGRectMake(0, contentHeight-44, kScreenWidth, 44);
        var selectCustomerV:UIImageView = createCustomerImageView(selectCustomerVFrame, "");
        selectCustomerV.backgroundColor = CD_Btn_GrayColor;
        selectCustomerV.userInteractionEnabled = true;
        self.view.addSubview(selectCustomerV);
        
        //
        var customerNumLabelFrame:CGRect = CGRectMake(15,(44-16)/2-5,200, 16);
        customerLabel = createCustomeLabel(customerNumLabelFrame, CD_Txt_Color_ff, "已选择报备楼盘0个", TF_14);
        selectCustomerV.addSubview(customerLabel);
        
        var selectCustomerBtnFrame = CGRectMake(kScreenWidth-15-112, 5, 112, 35);
        var selectCustomerBtn:UIButton = createCustomeBtn(self, "selectCustomer", selectCustomerBtnFrame, nil, "", "");
        selectCustomerBtn.layer.cornerRadius = 3.0;
        selectCustomerBtn.layer.masksToBounds = true;
        selectCustomerBtn.backgroundColor = CD_MainColor;
        selectCustomerBtn.setTitle("确定", forState: UIControlState.Normal);
        selectCustomerBtn.userInteractionEnabled = true
        selectCustomerBtn .setTitleColor(UIColor.whiteColor(), forState: UIControlState.Normal);
        selectCustomerV.addSubview(selectCustomerBtn);

    }
    override func didReceiveMemoryWarning()
    {
        super.didReceiveMemoryWarning()
       
    }
    //MARK:-选择报备楼盘
    func selectedFlightHouseS(arry:NSMutableArray)->Void
    {
         var rows:Int = arry.count;
         modelArry = arry
         customerLabel.text = "已选择报备楼盘"+"\(rows)"+"个";
    }
    func selectCustomer()->Void
    {
       
        
             Utility.showMBProgress(self.view, _message: "加载中");
        let manager = HWHttpRequestOperationManager.baseManager()
        var param:NSMutableDictionary = NSMutableDictionary();
        param.setPObject(HWUserLogin.currentUserLogin().key, forKey: "key");
        param.setPObject(clientInfoid, forKey: "clientInfoId")
        for var i = 0; i < modelArry.count;i++
        {
            var houseModel = modelArry .objectAtIndex(i) as HWFlightHouseMoel
            param.setPObject(houseModel.houseId, forKey: "houseList[\(i)].houseId")
            param.setPObject(houseModel.houseName, forKey: "houseList[\(i)].houseName")
        }
        manager.postHttpRequest(kFlightHouse, parameters: param, queue: nil, success: { (responseObject) -> Void in
            
            Utility.hideMBProgress(self.view);
            var dic:NSDictionary = responseObject as NSDictionary
            Utility.showToastWithMessage(dic .stringObjectForKey("detail"), _view:shareAppDelegate.window!);
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
    
    //MARK: 筛选框代理事件
    func customerSearchView(customerSearchView: CustomSearchView!, passValue value: String!, withIndex index: String!)
    {
        
    }
    
    func customerSearchView(customerSearchView: CustomSearchView!, passZone zoneId: String!, plateId: String!)
    {
        collectionView .customerSearchView(customerSearchView, passZone: zoneId, plateId: plateId)
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
