//
//  CenterLoading.swift
//  BOSS刷新模拟
//
//  Created by lizhongqiang on 16/1/12.
//  Copyright © 2016年 lizhongqiang. All rights reserved.
//

import UIKit
@objc protocol CenterLoadingDelegate{
    optional func loadingBegin()
    optional func loadingEnd()
}
class CenterLoading: UIView {
    var delegate:CenterLoadingDelegate!
    var size:CGSize!
    var _titleLabel:UILabel!
    var titleLabel:UILabel{
        get{
            _titleLabel = UILabel(frame: CGRectMake(0, size.height-20, size.width, size.height))
            _titleLabel.font = UIFont(name: "ArialMT", size: 12)
            _titleLabel.textColor = UIColor(colorLiteralRed: 195/255.0, green: 195/255.0, blue: 195/255.0, alpha: 1.0)
            _titleLabel.textAlignment = .Center
            _titleLabel.text = "正在加载中"
            return _titleLabel
        }
    }
    var animationView:UILabel!
    override init(frame: CGRect) {
        super.init(frame:frame)
    }
    init(size:CGSize){
        let frame = CGRectMake(CGRectGetWidth(UIScreen.mainScreen().bounds)/2-size.width/2, CGRectGetHeight(UIScreen.mainScreen().bounds)/2-size.height/2, size.width, size.height);
        super.init(frame: frame)
        self.size = size
        self.addSubview(self.titleLabel);
        animationView = UILabel(frame:CGRectMake(0, 0, size.width, size.height-20));
        
        animationView.textColor = UIColor(colorLiteralRed: 223/255.0, green: 229/255.0, blue: 229/255.0, alpha: 1.0);
//        animationView.backgroundColor = UIColor.yellowColor()
        animationView.myText = "BOSS"
        animationView.textAlignment = .Center
        animationView.attributes = [NSFontAttributeName:UIFont(name: "CourierNewPS-BoldMT", size: 42)!]
        animationView.shapeLayer = CAShapeLayer()
        self.addSubview(self.animationView)
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
