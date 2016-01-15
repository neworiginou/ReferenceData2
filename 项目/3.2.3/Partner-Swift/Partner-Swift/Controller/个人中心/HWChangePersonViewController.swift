//
//  HWChangePersonViewController.swift
//  Partner-Swift
//
//  Created by wuxiaohong on 15/2/15.
//  Copyright (c) 2015年 caijingpeng.haowu. All rights reserved.
//

import UIKit

class HWChangePersonViewController: HWBaseViewController,HWChangePersonViewDelegate ,UIActionSheetDelegate,UINavigationControllerDelegate,UIImagePickerControllerDelegate{
     var chanagePersonalView : HWChangePersonView!
     var changeVC:UIViewController = UIViewController()
    override func viewWillAppear(animated: Bool)
    {
        self.navigationController?.setNavigationBarHidden(false, animated: true);
        chanagePersonalView.initListFourArr();
        chanagePersonalView.baseTable.reloadData();
    }
    override func viewDidLoad()
    {
        super.viewDidLoad()
        chanagePersonalView = HWChangePersonView(frame: CGRectMake(0, 0, kScreenWidth, self.view.frame.size.height * kRate))
        chanagePersonalView.didSelectedCellDelegate = self
        self.view.addSubview(chanagePersonalView)
        self.navigationItem.titleView = Utility .navTitleView("修改个人信息")
          
        
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    //Mark :实现代理方法
   func didSelecttedCell(index:NSInteger, aIndex:NSInteger)

    {
            if index == 0 && aIndex == 0
            {
                
            }
            
            
            if index == 1 && aIndex == 0
            {
                let vc  = HWChangeNameViewController()
                self.navigationController?.pushViewController(vc, animated: true)
            }
            if index == 1 && aIndex == 1
            {
                if HWUserLogin.currentUserLogin().identitys == "1"
                    {
                    let vc  = HWChangePhoneViewController()
                    vc.changePhone = changeVC
                    self.navigationController?.pushViewController(vc, animated: true)
                    }
                    
                else
                {
                    return
                }
                
            }
            if index == 1 && aIndex == 2
            {
                let vc  = HWChangeSexViewController()
                self.navigationController?.pushViewController(vc, animated: true)
            }
    
            if index == 3 && aIndex == 0
            {
                let vc  = HWChangePasswordViewController()
                
                self.navigationController?.pushViewController(vc, animated: true)
                
            }
           if index == 2 && aIndex == 0
           {
               let vc = HWSelectCitysViewController()
               self.navigationController?.pushViewController(vc, animated: true);
       
          }

   }
    
        //MARK: UIActionSheet 的代理
        func actionSheet(actionSheet: UIActionSheet, clickedButtonAtIndex buttonIndex: Int)
        {
    
            if buttonIndex == 1
            {
                let imagePicker = UIImagePickerController()
                imagePicker.sourceType =  UIImagePickerControllerSourceType(rawValue:1)!
                imagePicker.delegate = self
                self .presentViewController(imagePicker, animated: true, completion: nil)
            }
            else if buttonIndex == 2
            {
                let imagePicker = UIImagePickerController()
                imagePicker.sourceType =  UIImagePickerControllerSourceType(rawValue:0)!
                imagePicker.delegate = self
                self .presentViewController(imagePicker, animated: true, completion: nil)
            }
        }
        // MARK: - 图片的代理
        func imagePickerController(picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [NSObject : AnyObject])
        {
    
           
              var image: UIImage? = (info as NSDictionary).objectForKey(UIImagePickerControllerOriginalImage) as? UIImage;
           // self .requestChangePhoto(HWUserLogin.currentUserLogin().headPicKey)
            self .uploadImage(image!)
            self .dismissViewControllerAnimated(true, completion: nil)
    
        }
        func uploadImage(image:UIImage)
        {
            // ---------*******------- 上传图片的请求
            
            Utility .showMBProgress(self.view, _message: "上传中")
            let manager = HWHttpRequestOperationManager.baseManager()
            var param: NSMutableDictionary! = NSMutableDictionary()
            param .setObject(UIImageJPEGRepresentation(image, 1), forKey: "file")
            manager .postHttpRequest(kUploadImageUrl, parameters: param, queue: nil, success: { (responseObject) -> Void in
                Utility .hideMBProgress(self.view)
//                println(responseObject)
                let responseDic: NSDictionary? = responseObject as NSDictionary
                let picKey: NSString? = responseDic?.stringObjectForKey("data")
                self .requestChangePhoto(picKey!)
                
            }) { (code, error) -> Void in
                Utility .hideMBProgress(self.view)
                Utility .showToastWithMessage(error, _view: self.view)
 
            }
        }
    
    func requestChangePhoto(mongoKey:NSString)
    {
        Utility .showMBProgress(self.view, _message: "上传中")
        let manager = HWHttpRequestOperationManager.baseManager()
        var param: NSMutableDictionary! = NSMutableDictionary()
        param .setObject(HWUserLogin.currentUserLogin().key, forKey: "key")
        param .setObject(mongoKey, forKey: "mongKey")
        manager .postHttpRequest(kPersonalChange, parameters: param, queue: nil, success: { (responseObject) -> Void in
            Utility .hideMBProgress(self.view)
            Utility .showToastWithMessage("上传成功", _view: self.view)
            
        }) { (code, error) -> Void in
            Utility .hideMBProgress(self.view)
            Utility .showToastWithMessage(error, _view: self.view)

        }
        
    }
    
}
