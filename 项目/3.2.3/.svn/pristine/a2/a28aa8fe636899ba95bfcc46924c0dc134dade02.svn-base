//
//  HWAboutViewController.swift
//  HWUser
//
//  Created by wuxiaohong on 15/2/9.
//  Copyright (c) 2015年 hw. All rights reserved.
//

import UIKit

class HWAboutViewController: HWBaseViewController {
   let lab = UILabel()
    var str:NSString?
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = CD_BackGroundColor
        self.navigationItem.titleView = Utility .navTitleView("关于我们")
        let scroll = UIScrollView(frame: CGRectMake(0, 0, kScreenWidth, self.view.frame.size.height))
       
        
        self.view .addSubview(scroll)
        //lab.backgroundColor = UIColor .blackColor()
        
       
       // lab.text = "hehe"
        lab.text = "\t好屋中国是国内首创的O2O房产全民营销创业平台，在全国40多个城市已经发展了300万名以上专业、社会经纪人，并以每月10万以上的的增长速度发展，最优秀的经纪人已经发展自己的团队成员1000多人，2015年经纪人日平均推荐客户超5000组，月推荐成交300组以上，月成交金额已超过150亿元。好屋中国已与全国近百家品牌开发商达成战略合作，助推更多人完成自己的置业梦想。\n\t自2012年5月好屋中国营销平台应运二期，颠覆了久房产高层本、低效率的模式，凭借博客多信息技术有限公司强大的资源整合能力，将欧美国家房产成熟的独立经纪人模式引进国内，结合国内行业的发展趋势以及互联趋势，秉承“居者有其屋，居者乐其屋”的理念，好屋中国在房产全民营销平台创造了一个有一个的辉煌业绩。"
        lab.frame =  CGRectMake(10, 10, self.view.frame.size.width-20, lab.frame.size.height)
        lab.numberOfLines = 0
        lab.lineBreakMode = NSLineBreakMode (rawValue: 1)!
       
        lab.font = UIFont .systemFontOfSize(13)

      // var strSize = Utility .calculateStringSize(str!, textFont: Define.font(13), constrainedSize: CGSizeMake(1000, 300))
       lab.sizeToFit()
      
       
        
        
        print(lab.frame)
         scroll.contentSize = CGSizeMake(0, self.view.frame.size.height+50)
       scroll .addSubview(lab)
        
    }
         override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
