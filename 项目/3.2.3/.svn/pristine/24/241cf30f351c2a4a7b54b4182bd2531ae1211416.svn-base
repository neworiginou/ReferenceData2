//
//  HWChangePersonView.swift
//  Partner-Swift
//
//  Created by wuxiaohong on 15/2/15.
//  Copyright (c) 2015年 caijingpeng.haowu. All rights reserved.
//

import UIKit
protocol HWChangePersonViewDelegate
{
    func didSelecttedCell(index:NSInteger, aIndex:NSInteger)
}
class HWChangePersonView: HWBaseRefreshView,UIActionSheetDelegate,UIImagePickerControllerDelegate,UINavigationControllerDelegate {
    var presentViewController: UIViewController?
    var didSelectedCellDelegate:HWChangePersonViewDelegate?
    let liseOneArr = ["姓名","手机号","性别"]
    let liseTwoArr = ["业务城市","所属机构","所属门店","岗位"]
    //var listThreeArr = ["张三","13062878770","女"]
    
    var listThreeArr = [String]()
    
    var listFourArr = [String]()
    // let listFourArr = ["上海","好屋中国","你是我的小苹果","员工"]
    
    //MYP add v3.2.2修改
    var picUrl:String = ""
    
    override init(frame: CGRect)
    {
        super.init(frame: frame)
        
        self.setIsNeedHeadRefresh(false)
        
        self.presentViewController = shareAppDelegate.window?.rootViewController
        self.baseTable.frame = CGRectMake(0, 0, kScreenWidth, contentHeight)
        if HWUserLogin.currentUserLogin().brokerGender == "0"
        {
            listThreeArr = [HWUserLogin.currentUserLogin().brokerName,HWUserLogin.currentUserLogin().brokerTel,"女"]
        }
        if HWUserLogin.currentUserLogin().brokerGender == "1"
        {
            listThreeArr = [HWUserLogin.currentUserLogin().brokerName,HWUserLogin.currentUserLogin().brokerTel,"男"]
        }
        self.initListFourArr();
        NSNotificationCenter .defaultCenter() .addObserver(self, selector: "reloadUserInfo", name: kUpdateUserInfo, object: nil)
    }
    
    deinit
    {
        NSNotificationCenter.defaultCenter().removeObserver(self, name: kUpdateUserInfo, object: nil)
    }
    
    required init(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func reloadUserInfo()
    {
        self.baseTable .reloadData()
    }
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int
    {
        if section == 0
        {
            return 1
        }
        if section == 1
        {
            return 3
        }
        
        if section == 2
        {
            return 4
        }
        
        if section == 3
        {
            return 1
        }
        return 0
    }
    override func numberOfSectionsInTableView(tableView: UITableView) -> Int
    {
        return 4
    }
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell
    {
        let cell: HWBaseTableViewCell = HWBaseTableViewCell(style: UITableViewCellStyle.Value1, reuseIdentifier: "cell")
        cell.contentView.drawBottomLine()
        
        if indexPath.section == 0 && indexPath.row == 0
        {
            //            line.frame = CGRectMake(0, 80 - 0.5, self.frame.size.width, 0.5);
            let headerImage = UIImageView(frame: CGRectMake(15, 15, 50, 50))
            headerImage.layer.cornerRadius = 25
            headerImage.layer.borderWidth = 2
            headerImage.layer.borderColor = CD_BackGroundColor.CGColor
            headerImage.layer.masksToBounds = true
            //   headerImage.backgroundColor = UIColor .whiteColor()
            weak var weakImgV: UIImageView? = headerImage
            
            //MYP add v3.2.2修改加载头像直接加载url
            //let url = NSURL(string:Utility.imageDownloadWithMongoDbKey(HWUserLogin.currentUserLogin().brokerPicKey))
            let url = NSURL(string:HWUserLogin.currentUserLogin().brokerPicKey)
            headerImage.setImageWithURL(url, placeholderImage:Utility.getPlaceHolderImage(headerImage.frame.size, imageName: "personal_2")) { (image, error, imageCacheType) -> Void in
                if (error != nil)
                {
                    let size: CGSize! = headerImage.frame.size
                    weakImgV?.image = Utility.getPlaceHolderImage(size, imageName: " personal_2")
                }
                else
                {
                    weakImgV?.image = image
                    let userDefault = NSUserDefaults.standardUserDefaults()
                    userDefault.setValue(HWUserLogin.currentUserLogin().brokerPicKey, forKey: kLastLoginPicKey)
                    userDefault.synchronize()
                }
            }
            cell.contentView .addSubview(headerImage)
            
            let lable = UILabel(frame: CGRectMake(CGRectGetMaxX(headerImage.frame)+20, CGRectGetMinY(headerImage.frame), 100, CGRectGetHeight(headerImage.frame)))
            lable.text = "头像"
            lable.font = Define.font(15)
            cell.contentView .addSubview(lable)
            
        }
        else
        {
            //            line.frame = CGRectMake(0, 45 - 0.5, self.frame.size.width, lineHeight);
            
        }
        if indexPath.section == 1
        {
            cell.textLabel?.text = liseOneArr[indexPath.row]
            cell.textLabel?.font = Define.font(15)
            
           if indexPath.row == 0
           {
            var lab = UILabel(frame: CGRectMake(50, (45 - 13) / 2-8-5, kScreenWidth-50-15-8-5, 40))
            lab.text = HWUserLogin.currentUserLogin().brokerName
            lab.textAlignment = NSTextAlignment(rawValue: 2)!
            lab.textColor = CD_BackGroundColor
            lab.textColor = CD_Txt_Color_99
            cell.contentView .addSubview(lab)
            
           }
            if indexPath.row == 1
            {
                var lab = UILabel(frame: CGRectMake(50, (45 - 13) / 2-8-5, kScreenWidth-50-15-8-5, 40))
                lab.text = HWUserLogin.currentUserLogin().brokerTel
                lab.textColor = CD_Txt_Color_99
                lab.textAlignment = NSTextAlignment(rawValue: 2)!
                cell.contentView .addSubview(lab)
               // cell.detailTextLabel?.text = HWUserLogin.currentUserLogin().brokerTel
            }
            if indexPath.row == 2
            {
                var lab = UILabel(frame: CGRectMake(50, (45 - 13) / 2-8-5,kScreenWidth-50-15-8-5, 40))
                lab.text = Utility .parseGenderValue(HWUserLogin.currentUserLogin().brokerGender)
                lab.textColor = CD_Txt_Color_99
                lab.textAlignment = NSTextAlignment(rawValue: 2)!
                cell.contentView .addSubview(lab)
                
                //cell.detailTextLabel?.text = Utility .parseGenderValue(HWUserLogin.currentUserLogin().brokerGender)
            }
            cell.detailTextLabel?.font = Define.font(15)
        }
        
        if indexPath.section == 1
        {
            //cell.accessoryType = UITableViewCellAccessoryType(rawValue: 1)!
            var jmpImg = UIImageView(frame: CGRectMake(kScreenWidth - 15 - 8, (45 - 13) / 2, 8, 13))
            jmpImg.image = UIImage(named: "arrow_next")
            cell.contentView.addSubview(jmpImg)
            
        }
        if indexPath.section == 0
        {
            //cell.accessoryType = UITableViewCellAccessoryType(rawValue: 1)!
            var jmpImg = UIImageView(frame: CGRectMake(kScreenWidth - 15 - 8, (80 - 13) / 2, 8, 13))
            jmpImg.image = UIImage(named: "arrow_next")
            cell.contentView.addSubview(jmpImg)
            
        }
        
        if indexPath.section == 2
        {
            let lable = UILabel(frame: CGRectMake(15+60, 0, self.frame.size.width-15-60-15, 43))
            lable.textAlignment = NSTextAlignment (rawValue: 2)!
            //lable.backgroundColor = UIColor .redColor()
            lable.text = listFourArr[indexPath.row]
            lable.textColor = CD_Txt_Color_99
            lable.font = Define.font(15)
            cell.contentView .addSubview(lable)
            // cell.accessoryView = lable
            cell.textLabel?.text = liseTwoArr[indexPath.row]
            cell.textLabel?.font = Define.font(15)
            if indexPath.row == 0
            {
                var jmpImg = UIImageView(frame: CGRectMake(kScreenWidth - 15 - 8, (45 - 13) / 2, 8, 13))
                jmpImg.image = UIImage(named: "arrow_next")
                cell.contentView.addSubview(jmpImg)
                lable.frame = CGRectMake(15+60, 0, kScreenWidth-15-60-15-11, 43);
            }

        }
        if indexPath.section == 3
        {
            cell.textLabel?.text = "修改密码"
            cell.textLabel?.font = Define.font(15)
            //cell.accessoryType = UITableViewCellAccessoryType(rawValue: 1)!
            var jmpImg = UIImageView(frame: CGRectMake(kScreenWidth - 15 - 8, (45 - 13) / 2, 8, 13))
            jmpImg.image = UIImage(named: "arrow_next")
            cell.contentView.addSubview(jmpImg)
            
        }
        
        
        return cell
    }
    func tableView(tableView: UITableView, viewForHeaderInSection section: Int) -> UIView?
    {
        let view = UIView(frame: CGRectMake(0, 0, self.frame.size.width, 30))
        view.backgroundColor = CD_BackGroundColor
        let line  = UILabel(frame: CGRectMake(0, 10-0.5, self.frame.size.width,0.5))
        line.backgroundColor = CD_LineColor
        view .addSubview(line)
        return view
    }
    func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat
    {
        if indexPath.section == 0 && indexPath.row == 0
        {
            return  80
        }
        
        return 45
    }
    func tableView(tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat
    {
        return 10
    }
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath)
    {
        tableView .deselectRowAtIndexPath(indexPath, animated: true)
        
        if indexPath.section == 0 && indexPath.row == 0
        {
            let actionSheet = UIActionSheet (title: nil, delegate:self, cancelButtonTitle: "取消", destructiveButtonTitle: nil, otherButtonTitles: "拍照", "从相册选择")
            actionSheet .showInView(self)
            
            
            
            
            
        }
            
        else
        {
            didSelectedCellDelegate?.didSelecttedCell(indexPath.section, aIndex: indexPath.row)
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
            presentViewController?.presentViewController(imagePicker, animated: true, completion: nil)
        }
        else if buttonIndex == 2
        {
            let imagePicker = UIImagePickerController()
            imagePicker.sourceType =  UIImagePickerControllerSourceType(rawValue:0)!
            imagePicker.delegate = self
            presentViewController?.presentViewController(imagePicker, animated: true, completion: nil)
        }
    }
    // MARK: - 图片的代理
    func imagePickerController(picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [NSObject : AnyObject])
    {
        
        
        var image: UIImage? = (info as NSDictionary).objectForKey(UIImagePickerControllerOriginalImage) as? UIImage;
        // self .requestChangePhoto(HWUserLogin.currentUserLogin().headPicKey)
        self .uploadImage(image!)
        presentViewController?.dismissViewControllerAnimated(true, completion: nil)
        
    }
    func uploadImage(image:UIImage)
    {
        // ---------*******------- 上传图片的请求
        
        Utility .showMBProgress(self, _message: "上传中")
        let manager = HWHttpRequestOperationManager.baseManager()
        var param: NSMutableDictionary! = NSMutableDictionary()
        param.setObject(UIImageJPEGRepresentation(image, 1), forKey: "file")
        manager.postImageHttpRequest(kUploadImageUrl, parameters: param, queue: nil, success: { (responseObject) -> Void in
            println(responseObject)
            Utility.hideMBProgress(self)
            let responseDic: NSDictionary? = responseObject as? NSDictionary
//            let picKey: NSDictionary = responseDic?.objectForKey("data") as NSDictionary
//            self.requestChangePhoto(picKey.objectForKey("fileKey") as String)
            
            //MYP add v3.2.2修改
            let dataDic = responseDic?.objectForKey("data") as NSDictionary
            self.picUrl = dataDic.stringObjectForKey("picUrl")
            self.requestChangePhoto(dataDic.stringObjectForKey("fileKey") as String)
            
            }) { (code, error) -> Void in
                Utility .hideMBProgress(self)
                Utility .showToastWithMessage(error, _view: self)
                
        }
    }
    
    func requestChangePhoto(mongoKey:NSString)
    {
        Utility .showMBProgress(self, _message: "上传中")
        let manager = HWHttpRequestOperationManager.baseManager()
        var param: NSMutableDictionary! = NSMutableDictionary()
        param.setObject(HWUserLogin.currentUserLogin().key, forKey: "key")
        param.setObject(mongoKey, forKey: "mongKey")
        manager .postHttpRequest(kPersonalChange, parameters: param, queue: nil, success: { (responseObject) -> Void in
            Utility .hideMBProgress(self)
            Utility .showToastWithMessage("上传成功", _view: self)
            
            //MYP add v3.2.2修改
            //HWUserLogin.currentUserLogin().brokerPicKey = mongoKey
            HWUserLogin.currentUserLogin().brokerPicKey = self.picUrl
            HWCoreDataManager .saveUserInfo()
            let userDefault = NSUserDefaults.standardUserDefaults()
            userDefault.setObject(mongoKey, forKey: kLastLoginPicKey)
            self.baseTable.reloadData()
            NSNotificationCenter .defaultCenter() .postNotificationName(kGetUserInfo, object: nil)
            NSNotificationCenter.defaultCenter().postNotificationName("reloadPersonalCenterData", object: nil)
            }) { (code, error) -> Void in
                Utility .hideMBProgress(self)
                Utility .showToastWithMessage(error, _view: self)
                
        }
        
    }
    
    
   func initListFourArr()
    {
        
        if HWUserLogin.currentUserLogin().brokerType == "A"
        {
            listFourArr =  [HWUserLogin.currentUserLogin().cityName,HWUserLogin.currentUserLogin().orgName,HWUserLogin.currentUserLogin().brokerStoreName,"中介"]
        }
        if HWUserLogin.currentUserLogin().brokerType == "B"
        {
            listFourArr =  [HWUserLogin.currentUserLogin().cityName,HWUserLogin.currentUserLogin().orgName,HWUserLogin.currentUserLogin().brokerStoreName,"直客下线"]
        }
        if HWUserLogin.currentUserLogin().brokerType == "C"
        {
            listFourArr =  [HWUserLogin.currentUserLogin().cityName,HWUserLogin.currentUserLogin().orgName,HWUserLogin.currentUserLogin().brokerStoreName,"直客"]
        }

        
    }
    
    
}
