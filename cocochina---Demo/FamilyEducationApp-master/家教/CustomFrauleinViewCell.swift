//
//  CustomCollectionViewCell.swift
//  家教
//
//  Created by goofygao on 15/10/19.
//  Copyright © 2015年 goofyy. All rights reserved.
//

import UIKit

protocol CustomFrauleinViewCellDelegate {
    func getRowNumber(dict:NSDictionary)
}

class CustomFrauleinViewCell: UITableViewCell {
    
    var delegate:CustomFrauleinViewCellDelegate?
    //头像
    @IBOutlet weak var avaterImage: UIImageView!
    //家教标题
    @IBOutlet weak var StudentFrauleinTittle: UILabel!
    //家教星级
    @IBOutlet weak var FrauleinLevel: UIView!
    //最近家教次数
    @IBOutlet weak var recentFrauleinTime: UILabel!
    //家教地点
    @IBOutlet weak var FrauleinPlace: UILabel!
    //家教详细信息
    @IBOutlet weak var FrauleinDetailContent: UILabel!
    //家教期望资金
    @IBOutlet weak var FrauleinWantMoney: UILabel!
    //家教学生性别
    @IBOutlet weak var FrauleinStudentSex: UIImageView!
    //toolBar父视图
    @IBOutlet weak var barView: UIView!
    //收藏按钮
    @IBOutlet weak var collectButton: UIButton!
    //评论按钮
    @IBOutlet weak var commentButton: UIButton!
    //喜欢按钮
    @IBOutlet weak var likeButton: UIButton!
    
    
    override func layoutSubviews() {
        super.layoutSubviews()
        //设置cell层颜色
        self.backgroundColor = UIColor(white: 1, alpha: 0.9)
        self.layer.cornerRadius = 10
        self.layer.masksToBounds = true
        avaterImage.layer.cornerRadius = avaterImage.bounds.height/2
        avaterImage.layer.masksToBounds = true
        barView.layer.borderWidth = 1
        barView.layer.borderColor = UIColor(white: 0.5, alpha: 0.5).CGColor
        collectButton.layer.borderWidth = 1
        collectButton.layer.borderColor = UIColor(white: 0.5, alpha: 0.1).CGColor
        commentButton.layer.borderWidth = 1
        commentButton.layer.borderColor = UIColor(white: 0.5, alpha: 0.1).CGColor
        likeButton.layer.borderWidth = 1
        likeButton.layer.borderColor = UIColor(white: 0.5, alpha: 0.1).CGColor
        collectButton.addTarget(self, action: "collectionAction:", forControlEvents: UIControlEvents.TouchDown)
    }
    

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
//        self.delegate?.getRowNumber(<#T##dict: NSDictionary##NSDictionary#>)
    }
    //获取高度
    func heightForCell(status:String)-> CGFloat{
        //设置数据
        self.FrauleinDetailContent.text = status
        //刷新布局
        self.layoutIfNeeded()
        //返回最最下方控件的最大Y值，就是高度啦
        return  CGRectGetMaxY(barView.frame)
    }
    
    func collectionAction(sender:UIButton) {
        let timeS:Int = Int((sender.titleLabel?.text)!)! + 1
        sender.setTitle("\(timeS)", forState: UIControlState.Normal)
        let animationImage = UIImageView()
       animationImage.image = UIImage(named: "collect_selecte.png")
        animationImage.center = sender.center
        animationImage.bounds.size = CGSizeMake(20, 20)
        sender.addSubview(animationImage)
        UIView.animateWithDuration(1.5, delay: 0, options: UIViewAnimationOptions.CurveEaseOut, animations: { () -> Void in
            animationImage.center.x = sender.center.x - 15
            animationImage.center.y = sender.center.y - 15
            animationImage.bounds.size = CGSizeMake(40, 40)
            animationImage.alpha = 0
            }, completion: nil)
        sender.enabled = false
    }
    
    @IBAction func shareAction(sender: UIButton) {
        let alertSheet = UIActionSheet(title: "请选择要分享的平台", delegate: nil, cancelButtonTitle: "取消分享", destructiveButtonTitle: nil, otherButtonTitles: "QQ空间", "微信","新浪微博")
        alertSheet.showInView(self.contentView)
        
        
    }
   
}
