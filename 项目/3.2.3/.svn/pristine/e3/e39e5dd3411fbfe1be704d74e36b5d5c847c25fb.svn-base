//
//  HWImagePickerWidget.swift
//  Partner-Swift
//
//  Created by caijingpeng.haowu on 15/2/16.
//  Copyright (c) 2015年 caijingpeng.haowu. All rights reserved.
//
//  功能描述：选择图片插件  当有选择图片功能的时候，使用此类，button事件直接调用chooseImagePicker方法，实现回调来获取已经选择的图片
//
//  exp:
//
//  imgPickerWidget = HWImagePickerWidget()
//  imgPickerWidget?.delegate = self
//  imgPickerWidget?.actionSheetShowInView = self
//
//  addPicBtn.addTarget(imgPickerWidget, action: "chooseImagePicker", forControlEvents: UIControlEvents.TouchUpInside)
//
//  修改记录：
//      姓名         日期               修改内容
//     蔡景鹏     2015-02-17           创建文件
//

import UIKit

@objc protocol HWImagePickerWidgetDelegate : NSObjectProtocol
{
    func imagePickerWidget(widget: HWImagePickerWidget, didFinishSelectImage image: UIImage)
}

class HWImagePickerWidget: NSObject, UIActionSheetDelegate, UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    var presentViewController: UIViewController?
    var actionSheetShowInView: UIView?
    weak var delegate: HWImagePickerWidgetDelegate?
    
    var imgPic: UIImagePickerController!
    
    override init()
    {
        super.init()
        self.presentViewController = shareAppDelegate.window?.rootViewController
    }
    
    func chooseImagePicker() -> Void
    {
        var acitonSheet: UIActionSheet! = UIActionSheet(title: nil, delegate: self, cancelButtonTitle: "取消", destructiveButtonTitle: nil, otherButtonTitles: "拍照", "相册")
        acitonSheet.showInView(self.actionSheetShowInView)
    }
    
    func actionSheet(actionSheet: UIActionSheet, clickedButtonAtIndex buttonIndex: Int)
    {
        if (buttonIndex == 1)
        {
            // 拍照
            if (UIImagePickerController.isSourceTypeAvailable(UIImagePickerControllerSourceType.Camera) == true)
            {
                imgPic = UIImagePickerController()
                imgPic.sourceType = UIImagePickerControllerSourceType.Camera
                imgPic.delegate = self
                presentViewController?.presentViewController(imgPic, animated: true, completion: { () -> Void in
                    
                })
            }
            else
            {
                Utility.showToastWithMessage("拍照功能不可用", _view: self.actionSheetShowInView!)
            }
        }
        else if (buttonIndex == 2)
        {
            // 相册
            imgPic = UIImagePickerController()
            imgPic.sourceType = UIImagePickerControllerSourceType.PhotoLibrary
            imgPic.delegate = self
            presentViewController?.presentViewController(imgPic, animated: true, completion: { () -> Void in
            
            })
        }
    }
    
    func imagePickerController(picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [NSObject : AnyObject]) {
        
        var image: UIImage? = (info as NSDictionary).objectForKey(UIImagePickerControllerOriginalImage) as? UIImage;
        
        if (image != nil)
        {
            if (delegate != nil && delegate?.respondsToSelector("imagePickerWidget:didFinishSelectImage:") != false)
            {
                delegate?.imagePickerWidget(self, didFinishSelectImage: image!)
            }
        }
        
        picker.dismissViewControllerAnimated(true, completion: { () -> Void in
            
        })
    }


   
}
