//
//  guideView.swift
//  customGuideView
//
//  Created by hw500028 on 15/3/6.
//  Copyright (c) 2015年 YL. All rights reserved.
//

import UIKit
class HWGuideView: UIView ,UIScrollViewDelegate{
    let width = kScreenWidth + 200
    var backGroundScrollView:UIScrollView?                        //滚动scrollview
    var guideImgVText:UIImageView?                                    //渐变的guideView
    var guideTmgVIcon:UIImageView?                                //渐变的guideView的Icon

    var hwTimer:NSTimer?
    var guideScrollView:UIScrollView?                             //滑动scrollview
    let guideTxts:[String] = ["guide1_text1","guide2_text1","guide3_text1","guide4_text1"]//滑动图片的文字
    let guideIcons:[String] = ["guide1_text2","guide2_text2","guide3_text2","guide4_text2"]//滑动图片的Icon
    let backgroundImgs:[String] = ["guide1_bg","guide2_bg","guide3_bg","guide4_bg"]        //滚动图片
    let backgroundImgs_iPhone4 = ["guide1_bg_iPhone4","guide2_bg_iPhone4","guide3_bg_iPhone4","guide4_bg_iPhone4"]
    var scrollend:(() -> ())?
    var pageCtrl:UIView?            //淡出的pagectrl
    var pageIndicators:[UIView] = []
    var currentPageIndicator:UIView?
    var skipBtn:UIButton?
    var originalCenterY:CGFloat?
    let rate:CGFloat = 850/1135
    var skipConstraint:NSLayoutConstraint?
    override init(frame: CGRect)
   {
        super.init(frame: frame)
        self.backgroundColor = UIColor.clearColor()
        backGroundScrollView = UIScrollView(frame: CGRect(x: 0, y: 0, width: kScreenWidth, height: contentHeight + 64))
        self.addSubview(backGroundScrollView!)
        self.backGroundScrollView?.backgroundColor = UIColor.clearColor()
    //动态图
    if iPhone4
    {
        let imgV = UIImageView(frame: CGRect(x:0, y: 0, width:370, height: contentHeight + 64))
        imgV.image = UIImage(named: "guide1_bg_iPhone4")
        backGroundScrollView?.addSubview(imgV)
        backGroundScrollView?.pagingEnabled = true
        imgV.tag = 200
        
        backGroundScrollView?.contentSize = CGSize(width: 370 , height: contentHeight + 64)

    }
    else
    {
        let width = (contentHeight + 64) * 800 / 1136
        let imgV = UIImageView(frame: CGRect(x:0, y: 0, width:width, height: contentHeight + 64))
        imgV.image = UIImage(named: "guide1_bg")
        backGroundScrollView?.addSubview(imgV)
        backGroundScrollView?.pagingEnabled = true
        imgV.tag = 200
        
        backGroundScrollView?.contentSize = CGSize(width: kScreenWidth + 50 , height: contentHeight + 64)

    }
   //下面的图
    
    let hwbackgroundView1 = UIView(frame: CGRect(x: 0, y: 0, width: kScreenWidth, height: (contentHeight + 64) * rate))
    hwbackgroundView1.backgroundColor = UIColor.clearColor()
    self.addSubview(hwbackgroundView1)
    guideImgVText = UIImageView.newAutoLayoutView()
    hwbackgroundView1.addSubview(guideImgVText!)
    guideImgVText?.autoPinEdgeToSuperviewEdge(ALEdge.Bottom, withInset: 10)
    guideImgVText?.autoAlignAxisToSuperviewAxis(ALAxis.Vertical)
    let img = UIImage(named: guideTxts[0])
    guideImgVText?.backgroundColor = UIColor.clearColor()
    guideImgVText?.image = img!
    guideTmgVIcon = UIImageView.newAutoLayoutView()
    hwbackgroundView1.addSubview(guideTmgVIcon!)
    guideTmgVIcon?.autoPinEdgeToSuperviewEdge(ALEdge.Top, withInset: 40, relation: NSLayoutRelation.GreaterThanOrEqual)
    UIView.autoSetPriority(501, forConstraints: { () -> Void in
       let containt = self.guideTmgVIcon!.autoPinEdge(ALEdge.Bottom, toEdge: ALEdge.Top, ofView: self.guideImgVText!, withOffset: -200)
    })
    guideTmgVIcon?.autoAlignAxisToSuperviewAxis(ALAxis.Vertical)
    guideTmgVIcon?.image = UIImage(named: guideIcons[0])
    
    
    
    
        //滚动的图
        guideScrollView = UIScrollView(frame: CGRect(x: 0, y: 0, width: kScreenWidth, height: contentHeight + 64))
        self.addSubview(guideScrollView!)
        guideScrollView?.backgroundColor = UIColor.clearColor()
        guideScrollView?.contentSize = CGSize(width: kScreenWidth * 4, height: contentHeight + 64)
        guideScrollView?.pagingEnabled = true
        guideScrollView?.delegate = self

        for i in 1...3
        {
            let hwBackgroundView2 = UIView(frame: CGRect(x: kScreenWidth * CGFloat(i), y: 0, width: kScreenWidth, height: (contentHeight + 64) * rate))
            guideScrollView?.addSubview(hwBackgroundView2)
            let hwimgV = UIImageView.newAutoLayoutView()
            hwBackgroundView2.addSubview(hwimgV)
            hwimgV.autoPinEdgeToSuperviewEdge(ALEdge.Bottom, withInset: 10)
            hwimgV.autoAlignAxisToSuperviewAxis(ALAxis.Vertical)
            hwimgV.image = UIImage(named: guideTxts[i])
            hwimgV.backgroundColor = UIColor.clearColor()
            
            let hwimgIcon = UIImageView.newAutoLayoutView()
            hwBackgroundView2.addSubview(hwimgIcon)
            hwimgIcon?.autoPinEdgeToSuperviewEdge(ALEdge.Top, withInset: 40, relation: NSLayoutRelation.GreaterThanOrEqual)
            UIView.autoSetPriority(501, forConstraints: { () -> Void in
                let containt = hwimgIcon!.autoPinEdge(ALEdge.Bottom, toEdge: ALEdge.Top, ofView:hwimgV, withOffset: -200)
            })
            hwimgIcon.autoAlignAxisToSuperviewAxis(ALAxis.Vertical)
            hwimgIcon.image = UIImage(named: guideIcons[i])

            
            hwBackgroundView2.tag = 100 + i
            
        }
    guideScrollView?.showsHorizontalScrollIndicator = false
    //pageCtrl的背景
    pageCtrl = UIView.newAutoLayoutView()
    self.addSubview(pageCtrl!)
    pageCtrl?.autoPinEdge(ALEdge.Top, toEdge: ALEdge.Bottom, ofView: hwbackgroundView1)
    pageCtrl?.autoAlignAxisToSuperviewAxis(ALAxis.Vertical)
    pageCtrl?.autoSetDimensionsToSize(CGSize(width: 50, height: 20))
    pageCtrl?.backgroundColor = UIColor.clearColor()
    for i in 0...3
    {
        let pageIndicator = UIView(frame: CGRect(x:14 * CGFloat(i), y: 10, width: 8, height: 8))
        pageIndicator.backgroundColor = UIColor.clearColor()
        pageIndicator.layer.borderColor = UIColor.whiteColor().CGColor
        pageIndicator.layer.borderWidth = 1
        pageIndicator.layer.cornerRadius = 8/2
        pageIndicator.layer.masksToBounds = true
        pageCtrl?.addSubview(pageIndicator)
        if i == 0
        {
            pageIndicator.backgroundColor = UIColor.whiteColor()
            currentPageIndicator = pageIndicator
        }
        pageIndicators.append(pageIndicator)
        
    }

    skipBtn = UIButton.newAutoLayoutView()
    self.addSubview(skipBtn!)
    UIView.autoSetPriority(500, forConstraints: { () -> Void in
       self.skipConstraint = self.skipBtn!.autoPinEdge(ALEdge.Top, toEdge: ALEdge.Bottom, ofView: self.pageCtrl!, withOffset: 400)
        
    })
    skipBtn?.autoAlignAxisToSuperviewAxis(ALAxis.Vertical)
    skipBtn?.setBackgroundImage(UIImage(named: "butten"), forState: UIControlState.Normal)
    skipBtn?.setBackgroundImage(UIImage(named: "butten-hl"), forState: UIControlState.Highlighted)
    skipBtn?.setTitle("马上体验", forState: UIControlState.Normal)
    skipBtn?.addTarget(self, action: "skipGuide", forControlEvents: UIControlEvents.TouchUpInside)
    
    setAnimate()
    
    }
    
    
    func setAnimate()
    {
        var imgOffset:CGFloat = 50.0
        UIView.animateWithDuration(5, delay: 0, options: UIViewAnimationOptions.Repeat | UIViewAnimationOptions.Autoreverse | UIViewAnimationOptions.CurveEaseInOut, animations: { () -> Void in
            self.backGroundScrollView!.contentOffset.x += imgOffset

            
        }, completion: nil)
    }
    
    func scrollViewDidScroll(scrollView: UIScrollView) {
        
        let image: UIImage = UIImage(named:guideTxts[getIndex(scrollView.contentOffset.x)])!
        guideImgVText?.image = image
        guideImgVText?.alpha = getRatio(scrollView.contentOffset.x)
        guideTmgVIcon?.image = UIImage(named: guideIcons[getIndex(scrollView.contentOffset.x)])
        guideTmgVIcon?.alpha = getRatio(scrollView.contentOffset.x)
        HidenImagv(scrollView.contentOffset.x)
        notHidenImagV(scrollView.contentOffset.x)
        
        let offset = scrollView.contentOffset.x
            if offset >= (kScreenWidth * 3 + 20)
            {

                scrollend?()
        }
        
        
    }
    
    func scrollViewDidEndDecelerating(scrollView: UIScrollView) {
        let a:Int = Int(scrollView.contentOffset.x/kScreenWidth)
        var imgV = backGroundScrollView?.viewWithTag(200) as UIImageView
        currentPageIndicator?.backgroundColor = UIColor.clearColor()
        pageIndicators[a].backgroundColor = UIColor.whiteColor()
        currentPageIndicator = pageIndicators[a]
        
        if a == 3
        {
            self.skipConstraint?.constant = 40
            UIView.animateWithDuration(1.0, delay: 0.0, usingSpringWithDamping: 13.0, initialSpringVelocity: 1, options: nil, animations: { () -> Void in

                self.layoutIfNeeded()
                }, completion: nil)

        
        }
        else
        {
            self.skipConstraint?.constant = 400
            UIView.animateWithDuration(1.0, delay: 0.0, usingSpringWithDamping: 13.0, initialSpringVelocity: 1, options: nil, animations: { () -> Void in
                
                self.layoutIfNeeded()
                }, completion: nil)

        }
        

        UIView.transitionWithView(imgV, duration: 0.5, options: UIViewAnimationOptions.TransitionCrossDissolve, animations: { () -> Void in
            if iPhone4
            {
                imgV.image = UIImage(named: self.backgroundImgs_iPhone4[a])
            }
            else
            {
                imgV.image = UIImage(named: self.backgroundImgs[a])

            }
        }, completion: nil)
        
    }
//向右滑动的视图隐藏
    func HidenImagv(contentOffSetX:CGFloat)
    {
        var a = (contentOffSetX/kScreenWidth)
        for i in 0...3
        {
            if (CGFloat(i) < a && a <= CGFloat(i + 1))
            {
                let imgv = guideScrollView?.viewWithTag(100 + i)
                    imgv?.hidden = true
            }
        }
    }
//向左滑动不隐藏
    func notHidenImagV(contentOffSetX:CGFloat)
    {
        var a = (contentOffSetX/kScreenWidth)
        
        for i in 0...3
        {
            if (CGFloat(i) < a && a <= CGFloat(i + 1))
            {
                let imgv = guideScrollView?.viewWithTag(100 + i + 1)
                imgv?.hidden = false
            }
        }

        
    }
//获取alpha的值
    func getRatio(contentOffSetX:CGFloat) -> CGFloat
    {
        var a = (contentOffSetX/kScreenWidth)
            for i in 0...3
            {
        
                if (a >= CGFloat(i) && a < CGFloat(i + 1))
                {
                    a = a - CGFloat(i)
                }
        }
        return 1 - a
    }
    
//   返回需要的数组下标
    func getIndex(contentOffsetX:CGFloat) -> Int
    {
        var a = Int(contentOffsetX/kScreenWidth)
        
        for i in 0...3
        {
            if (a >= i && a < i+1)
            {
                a = i
            }
        }
        return a
    }
    

    required init(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func skipGuide()
    {
    scrollend?()
    }
}
