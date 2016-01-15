

//
//  HWImageEditView.swift
//  Partner-Swift
//
//  Created by caijingpeng.haowu on 15/2/16.
//  Copyright (c) 2015年 caijingpeng.haowu. All rights reserved.
//

import UIKit

protocol HWImageEditViewDelegate : NSObjectProtocol
{
    func didDeleteImageEditView(imgEditView: HWImageEditView)
}

class HWImageEditView: UIView {

    var imageView: UIImageView!
    weak var delegate: HWImageEditViewDelegate?
    
    override init(frame: CGRect)
    {
        super.init(frame: frame)
        
        imageView = UIImageView(frame: self.bounds)
        imageView.backgroundColor = UIColor.cyanColor()
        self.addSubview(imageView)
        
        imageView.layer.cornerRadius = 10.0
        imageView.layer.masksToBounds = true
        imageView.layer.borderColor = CD_LineColor.CGColor
        imageView.layer.borderWidth = 0.5
        
        let deleteBtn: UIButton = UIButton.buttonWithType(UIButtonType.Custom) as UIButton
//        deleteBtn.backgroundColor = UIColor.redColor()
        deleteBtn.frame = CGRectMake(-3, -3, 20, 20)
//        deleteBtn.layer.cornerRadius = 20 / 2.0
//        deleteBtn.layer.masksToBounds = true
        deleteBtn.setImage(UIImage(named: "delete"), forState: UIControlState.Normal)
        deleteBtn.addTarget(self, action: "toDeleteImage", forControlEvents: UIControlEvents.TouchUpInside)
        self.addSubview(deleteBtn)
    }

    required init(coder aDecoder: NSCoder)
    {
        fatalError("init(coder:) has not been implemented")
    }
    
    func toDeleteImage() -> Void
    {
        println("delete")
        if (delegate != nil && delegate?.respondsToSelector("didDeleteImageEditView:") != false)
        {
            delegate?.didDeleteImageEditView(self)
        }
    }
    
    func setImage(picKey: NSString) -> Void
    {
        //let picUrl: NSString? = Utility.imageDownloadWithMongoDbKey(picKey)
        let picUrl: NSString? = picKey
        
        weak var weakImgV: UIImageView? = imageView
        imageView.setImageWithURL(NSURL(string: picUrl!), placeholderImage: Utility.getPlaceHolderImage(imageView.frame.size, imageName: "pic_wait_small")) { (image, error, imageCacheType) -> Void in
            if (error != nil)
            {
                let size: CGSize! = weakImgV?.frame.size
                weakImgV?.image = Utility.getPlaceHolderImage(size, imageName: "pic_wait_small_no-")
            }
            else
            {
                weakImgV?.image = image
            }
        }
    }
    
    
    /*
    // Only override drawRect: if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func drawRect(rect: CGRect) {
        // Drawing code
    }
    */

}
