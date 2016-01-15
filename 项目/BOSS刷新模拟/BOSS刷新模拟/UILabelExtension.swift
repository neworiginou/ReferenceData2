//
//  UIViewExtension.swift
//  BOSS刷新模拟
//
//  Created by lizhongqiang on 16/1/12.
//  Copyright © 2016年 lizhongqiang. All rights reserved.
//

import UIKit
private var tag:UInt = 0
private var tag1:UInt = 1
private var textTag:UInt = 2
extension UILabel {
    var myText:String{
        get {
            return objc_getAssociatedObject(self, &textTag) as! String
        }
        set(newValue){
            objc_setAssociatedObject(self, &textTag, newValue, .OBJC_ASSOCIATION_RETAIN_NONATOMIC)
        }
    }
    var attributes:NSDictionary{
        get {
            return objc_getAssociatedObject(self, &tag1) as! NSDictionary
        }
        set(newValue){
            objc_setAssociatedObject(self, &tag1, newValue, .OBJC_ASSOCIATION_RETAIN_NONATOMIC)
        }
    }
    var shapeLayer:CAShapeLayer{
        get {
            return objc_getAssociatedObject(self, &tag) as! CAShapeLayer
        }
        set(newValue){
            let path = UIBezierPath(text: self.myText, attributes:self.attributes as Dictionary)
            newValue.path = path.CGPath
            newValue.frame = CGPathGetBoundingBox(path.CGPath);
            newValue.geometryFlipped = true;//几何反转--geometryFlipped属性,该属性可以改变默认图层y坐标的方向
//            newValue.strokeColor = self.textColor.CGColor
            newValue.fillColor = UIColor.clearColor().CGColor
            var frame = newValue.frame
            frame.origin.x = (self.frame.size.width - newValue.frame.size.width)/2
            newValue.frame = frame
            self.layer.addSublayer(newValue)
            UIBezierPath.layers().enumerateObjectsUsingBlock { (object, index, bool) -> Void in
                let layer = object as! CAShapeLayer
                layer.time = 0.5
             
                layer.delay = Double(index)*0.125
                layer.startAnimation()
                
                layer.strokeColor = self.textColor.CGColor
                layer.fillColor = UIColor.clearColor().CGColor
                newValue.addSublayer(layer)
            }
            objc_setAssociatedObject(self, &tag, newValue, .OBJC_ASSOCIATION_RETAIN_NONATOMIC)
        }
    }
}

private var timeTag:UInt = 100
private var delayTag:UInt = 200
extension CAShapeLayer{
    var time:Double{
        get{
            return (objc_getAssociatedObject(self, &timeTag).doubleValue)
        }
        set(value){
            objc_setAssociatedObject(self, &timeTag, (value), .OBJC_ASSOCIATION_RETAIN)
        }
    }
    var delay:Double{
        get{
            return (objc_getAssociatedObject(self, &delayTag).doubleValue)
        }
        set(value){
            objc_setAssociatedObject(self, &delayTag, (value), .OBJC_ASSOCIATION_RETAIN)
        }
    }
    func startAnimation(){
//        sleep(UInt32(self.delay))
        let animation = CAKeyframeAnimation(keyPath: "position.y")//transform.m42
        animation.values = [(3),(-3)];
        animation.autoreverses = true
        animation.beginTime = Double(self.delay)
        animation.repeatCount = MAXFLOAT
        animation.timingFunctions = [CAMediaTimingFunction(name: kCAMediaTimingFunctionEaseInEaseOut)]
        animation.duration =   Double(self.time)
        self.addAnimation(animation, forKey: "animation")
    }
    func endAnimation(){
    }
    
}