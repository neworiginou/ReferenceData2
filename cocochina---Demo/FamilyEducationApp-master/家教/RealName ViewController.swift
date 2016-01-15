//
//  FreeTimeTableViewController.swift
//  家教
//
//  Created by goofygao on 15/10/21.
//  Copyright © 2015年 goofyy. All rights reserved.
//

import UIKit

class RealNameViewController: UIViewController,UIImagePickerControllerDelegate,UINavigationControllerDelegate,UITextFieldDelegate  {

   
    @IBOutlet weak var personalIDcard: UITextField!
    
    @IBOutlet weak var getIDcardBackPicture: UIButton!
    @IBOutlet weak var getIDcardfrontPicture: UIButton!
    
    @IBOutlet weak var uploadButton: UIButton!
    
    var alertView = CustomAlertView()
    
    var buttonIdentify = 0
    
    var IDcardFontImage:UIImage?
    var IDcardBackImage:UIImage?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "实名认证"
        let navBar = self.navigationController?.navigationBar
        navBar?.barTintColor = UIColor(red: 65.0 / 255.0, green: 62.0 / 255.0, blue: 79.0 / 255.0, alpha: 1)
        navBar?.titleTextAttributes = [NSForegroundColorAttributeName: UIColor.whiteColor()]
        getIDcardBackPicture.layer.cornerRadius = 5
        getIDcardBackPicture.layer.masksToBounds = true
        
        getIDcardfrontPicture.layer.cornerRadius = 5
        getIDcardfrontPicture.layer.masksToBounds = true
        personalIDcard.delegate = self
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that  can be recreated.
    }
    
    @IBAction func getIDcardPictureAction(sender: UIButton) {
        buttonIdentify = sender.tag
        if UIImagePickerController.isSourceTypeAvailable(.PhotoLibrary){
            //初始化图片控制器
            let picker = UIImagePickerController()
            //设置代理
            picker.delegate = self
            
            //指定图片控制器类型
            picker.sourceType = UIImagePickerControllerSourceType.PhotoLibrary
            //弹出控制器，显示界面
            self.presentViewController(picker, animated: true, completion: {
                () -> Void in
            })
        }else{
            print("读取相册错误")
        }

    
    }
    
  
    @IBAction func uploadAction(sender: UIButton) {
        
        if IDcardFontImage == nil || IDcardBackImage == nil {
            let alertViewEWarning = UIAlertView(title: "提示", message: "上传前请把图片填充完整", delegate: nil, cancelButtonTitle: "返回")
            alertViewEWarning.show()
        }
        
    }
    
    //选择图片成功后代理
    func imagePickerController(picker: UIImagePickerController,didFinishPickingMediaWithInfo info: [String : AnyObject]) {
        print(buttonIdentify)
            //查看info对象
            print(info["UIImagePickerControllerReferenceURL"])
        print(info)
            //获取选择的原图
            let image = info[UIImagePickerControllerOriginalImage] as! UIImage
        if buttonIdentify == 50 {
            IDcardFontImage = image
            getIDcardfrontPicture.setImage(image, forState: UIControlState.Normal)
        } else {
            IDcardBackImage = image
            getIDcardBackPicture.setImage(image, forState: UIControlState.Normal)
        }
        
            //图片控制器退出
            picker.dismissViewControllerAnimated(true, completion: {
                () -> Void in
            })
    }
    
    override func touchesBegan(touches: Set<UITouch>, withEvent event: UIEvent?) {
        self.personalIDcard.resignFirstResponder()
    }
    
    func textFieldShouldReturn(textField: UITextField) -> Bool {
        self.personalIDcard.resignFirstResponder()
        return true
    }
}
