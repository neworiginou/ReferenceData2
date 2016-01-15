//
//  MyScrollView.swift
//  MyScrollView
//
//  Created by hw500029 on 15/4/14.
//  Copyright (c) 2015年 MYP. All rights reserved.
//

import UIKit

protocol MyScrollViewDelegate
{
    func anotherOne()
}

class MyScrollView: UIScrollView ,UIScrollViewDelegate{

    var imageArray:NSMutableArray!
    var bigView:UIImageView!
    var neighbourView:UIImageView!
    var eachWidth:CGFloat!
    var scrollOffSetX:CGFloat = 0
    
    var currentOffSet:CGFloat = 0//用来判断scrollView滚动方向
    
    var proportion:CGFloat = 1//缩放比例
    var percentage:CGFloat = 0//偏移量百分比
    var pCha:CGFloat = 0
    var pMax:CGFloat = 1
    
    var myDelegate:MyScrollViewDelegate?
    
    var canGetAnother:Bool = true
    
    var bigImgName:NSString = ""
    
    init(frame: CGRect, imgName:NSString) {
        super.init(frame: frame)
        self.pagingEnabled = false
        self.showsHorizontalScrollIndicator = false
        self.showsVerticalScrollIndicator = false
        self.delegate = self
        
        bigImgName = imgName
        
        eachWidth = kScreenWidth / 3
        pCha = eachWidth / 60 - 1
        pMax = eachWidth / 60
        
        //println("eachWidth ============= \(eachWidth)")
        imageArray = NSMutableArray()
    }

    func scrollViewLoadData()
    {
        self.contentSize = CGSizeMake(self.bounds.size.width * 3, self.bounds.size.height)
        self.contentOffset = CGPointMake(self.bounds.size.width, 0)
        for var i = 0; i < 3 * 3; i++
        {
            var eachBackView = UIView(frame: CGRectMake(CGFloat(i) * eachWidth, 0, eachWidth, eachWidth))
            self.addSubview(eachBackView)
            
            var imgView = UIImageView(frame: CGRectMake((eachWidth - 60) / 2, (eachWidth - 60) / 2, 60, 60))
            imgView.backgroundColor = UIColor.clearColor()
            imgView.image = UIImage(named: "more_icon2")
            eachBackView.addSubview(imgView)
            
            imageArray.addObject(imgView)
        }
        bigView = imageArray[4] as UIImageView
        //bigView.frame =  CGRectMake(0, 0, eachWidth, eachWidth)
        bigView.transform = CGAffineTransformMakeScale(pMax, pMax)
        bigView.image = UIImage(named: bigImgName)
    }
    
    func scrollViewDidScroll(scrollView: UIScrollView) {
        //println("offSet.x ============ \(scrollView.contentOffset.x)")
        
        var cX = scrollView.contentOffset.x
        
        if cX < currentOffSet
        {
            //println("向右")
            
            //两种情况 1、向右拖动  2、向右回弹
            if cX > 2 * eachWidth && cX < 3 * eachWidth
            {
                //println("index4变小 ---------------- index3变大 ")
                
                neighbourView = imageArray[3] as UIImageView
                percentage = 1 - (cX - 2 * eachWidth) / eachWidth
                proportion = 1 + pCha * percentage
                
                neighbourView.transform = CGAffineTransformMakeScale(proportion, proportion)
                
                bigView.transform = CGAffineTransformMakeScale(pMax - pCha * percentage, pMax - pCha * percentage)
            }
            else if cX < 4 * eachWidth && cX > 3 * eachWidth
            {
                //println("index4变大 ---------------- index5变小")
                
                neighbourView = imageArray[5] as UIImageView
                percentage = (cX - 3 * eachWidth) / eachWidth
                proportion = 1 + pCha * percentage
                
                neighbourView.transform = CGAffineTransformMakeScale(proportion, proportion)
                
                bigView.transform = CGAffineTransformMakeScale(pMax - pCha * percentage, pMax - pCha * percentage)
            }
            
            if scrollView.contentOffset.x <= eachWidth * 2
            {
                scrollView.contentOffset = CGPointMake(eachWidth * 3, 0)
                bigView = imageArray[4] as UIImageView
                //bigView.image = UIImage(named: "big_character")
                //bigView.frame =  CGRectMake(0, 0, eachWidth, eachWidth)
                bigView.transform = CGAffineTransformMakeScale(pMax, pMax)
                self.neighbourView.transform = CGAffineTransformMakeScale(1, 1)
                //切换客户 通知刷新UI
                if canGetAnother == true
                {
                    myDelegate?.anotherOne()
                    canGetAnother = false
                }
            }
            //println("百分比===========\(( 2 * eachWidth) / eachWidth)")
        }
        else if cX > currentOffSet
        {
            //println("向左")
            
            //两种情况 1、向左拖动  2、向左回弹
            if cX < 4 * eachWidth && cX > 3 * eachWidth
            {
                //println("index4变小 ---------------- index5变大 ")
                
                neighbourView = imageArray[5] as UIImageView
                percentage = (cX - 3 * eachWidth) / eachWidth
                proportion = 1 + pCha * percentage
                
                neighbourView.transform = CGAffineTransformMakeScale(proportion, proportion)
                
                bigView.transform = CGAffineTransformMakeScale(pMax - pCha * percentage, pMax - pCha * percentage)
            }
            else if cX > 2 * eachWidth && cX < 3 * eachWidth
            {
                //println("index4变大 ---------------- index3变小")
                neighbourView = imageArray[3] as UIImageView
                percentage = 1 - (cX - 2 * eachWidth) / eachWidth
                proportion = 1 + pCha * percentage
                
                neighbourView.transform = CGAffineTransformMakeScale(proportion, proportion)
                
                bigView.transform = CGAffineTransformMakeScale(pMax - percentage, pMax - percentage)
            }
            
            if scrollView.contentOffset.x >= eachWidth * 4
            {
                scrollView.contentOffset = CGPointMake(eachWidth * 3, 0)
                bigView = imageArray[4] as UIImageView
                //bigView.frame =  CGRectMake(0, 0, eachWidth, eachWidth)
                bigView.transform = CGAffineTransformMakeScale(pMax, pMax)
                self.neighbourView.transform = CGAffineTransformMakeScale(1, 1)
                //切换客户 通知刷新UI
                if canGetAnother == true
                {
                    myDelegate?.anotherOne()
                    canGetAnother == false
                }
            }
            //println("百分比===========\((cX - 3 * eachWidth) / eachWidth)")
        }
        currentOffSet = cX
    }
    
    func scrollViewDidEndDecelerating(scrollView: UIScrollView)
    {
        scrollOffSetX = scrollView.contentOffset.x
        var p:CGPoint = scrollView.contentOffset
        self.reloadScrollView(p)
    }
    
    func scrollViewDidEndDragging(scrollView: UIScrollView, willDecelerate decelerate: Bool) {
        scrollOffSetX = scrollView.contentOffset.x
        if decelerate == false
        {
            var p:CGPoint = scrollView.contentOffset
            self.reloadScrollView(p)
        }
    }
    
    func reloadScrollView(scrollOffset:CGPoint)
    {
        //println("停止滚动")
        
        UIView.animateWithDuration(0.2, animations: { () -> Void in
            self.contentOffset = CGPoint(x: 3 * self.eachWidth,y: 0)
            self.neighbourView.transform = CGAffineTransformMakeScale(1, 1)
            self.bigView.transform = CGAffineTransformMakeScale(self.pMax, self.pMax)
            }, completion: { (Bool) -> Void in
            //添加回调方法 获取抢客/抢房信息
            self.canGetAnother = true
        })
    }
    
    required init(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
