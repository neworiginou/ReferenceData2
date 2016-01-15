//
//  HWHomeViewController.swift
//  Partner-Swift
//
//  Created by caijingpeng.haowu on 15/2/11.
//  Copyright (c) 2015年 caijingpeng.haowu. All rights reserved.
//

import Foundation

var robVC:HWRobViewController!
var centerVC:HWPersonalCenterViewController!

class HWHomeViewController: HWBaseViewController,SGFocusImageFrameDelegate,UIScrollViewDelegate
{
    var totalBackgroundScrollV:UIScrollView = UIScrollView();
    var headerBackGImageV:UIImageView = UIImageView();
    var hiImageV:UIImageView!;
    var itemImageV:UIImageView!;
    var messageContentLabel:UILabel!;
    var scrollPictureV:SGFocusImageFrame!;
    var nameLabel:UILabel!;
    var companyLabel:UILabel!;
    var bellImageV:UIImageView!;
    var adArry:NSArray!;
    var avatarImageV:UIImageView! = UIImageView()
    var headImageV:UIImageView!;
    var currentHomeInfoModel:HWHomeModel?;
    
    
    override func viewDidLoad()
    {
        super.viewDidLoad()
        adArry = NSArray();
        totalBackgroundScrollV = createBackScrollView();
        self.view.addSubview(totalBackgroundScrollV);
        self.createItemView();
        self.createHeaderV();
        self.createScrollV(NSArray());
        self.getNewsList();
        self.requestHomeInfo();
        //添加监听
        NSNotificationCenter.defaultCenter().addObserver(self, selector: "uploadHeadImage", name: kGetUserInfo, object: nil)
        NSNotificationCenter.defaultCenter().addObserver(self, selector: "changeName", name: kUpdateUserInfo, object: nil)
        NSNotificationCenter.defaultCenter().addObserver(self, selector: "comminCustomerList" , name: kRobCustomerNotification, object: nil);
        NSNotificationCenter.defaultCenter().addObserver(self, selector: "refershHomePage" , name: kRefershHomePageNotification, object: nil);
    }
    func refershHomePage()->Void
    {
        self.getNewsList();
        self.requestHomeInfo();
    }
    deinit
    {
        NSNotificationCenter.defaultCenter().removeObserver(self)
    }
    
    override func viewWillAppear(animated: Bool)
    {
       
        self.getNewsList();
        self.requestHomeInfo();
        self.navigationController?.navigationBarHidden = true;
    }
        func comminCustomerList()->Void
    {
            var customerList:HWInputClientViewController = HWInputClientViewController();
            self.navigationController?.pushViewController(customerList, animated: true);
//        })

    }
    func uploadHeadImage()
    {
        weak var weakImgV: UIImageView? = avatarImageV
        //MYP add v3.2.2修改头像加载方式
        //let url = NSURL(string:Utility.imageDownloadWithMongoDbKey(HWUserLogin.currentUserLogin().brokerPicKey))
        let url = NSURL(string:HWUserLogin.currentUserLogin().brokerPicKey)
         avatarImageV.setImageWithURL(url, placeholderImage: Utility.getPlaceHolderImage(avatarImageV.frame.size, imageName: "personal_2")) { (image, error, imageCacheType) -> Void in
            if (error != nil)
            {
                let size: CGSize! = self.avatarImageV.frame.size
                weakImgV?.image = Utility.getPlaceHolderImage(size, imageName: "personal_2")
            }
            else
            {
                weakImgV?.image = image
            }
        }
    }
    func changeName()
    {
        nameLabel.text = HWUserLogin.currentUserLogin().brokerName
        
    }
    //MARK:-获取经纪人首页信息
    func requestHomeInfo()->Void
    {
        Utility.hideMBProgress(self.view);
//        Utility.showMBProgress(self.view, _message: "加载中");
        var param:NSMutableDictionary = NSMutableDictionary();
        param.setPObject(HWUserLogin.currentUserLogin().key, forKey: "key");
        let manager = HWHttpRequestOperationManager.baseManager()
        manager.postHttpRequest(kHomeAgentInfo, parameters: param, queue: nil, success: { (responseObject) -> Void in
//            Utility.hideMBProgress(self.view);
            var dic =  responseObject.objectForKey("data") as NSDictionary
            
//             println(dic)
            self.currentHomeInfoModel = self .createTestData(dic) as HWHomeModel;
            self.refershUI(self .createTestData(dic) as HWHomeModel);
    
        }) { (code, error) -> Void in
//            Utility.hideMBProgress(self.view)
        }
    }
    //MARK:-获取咨询列表
    func getNewsList()->Void
    {
        
        var param:NSMutableDictionary = NSMutableDictionary();
        param.setPObject(HWUserLogin.currentUserLogin().key, forKey: "key");
        let manager = HWHttpRequestOperationManager.baseManager()
        manager.postHttpRequest(kNewsList, parameters: param, queue: nil, success: { (responseObject) -> Void in
            Utility.hideMBProgress(self.view);
            var dicArry =  responseObject.arrayObjectForKey("data") as NSArray
            self.adArry = dicArry;
            self.createScrollV(dicArry);
            if(self.currentHomeInfoModel != nil)
            {
                self.refershUI((self.currentHomeInfoModel as HWHomeModel!));
            }
            }) { (code, error) -> Void in
                Utility.hideMBProgress(self.view)
        }

    }
    //刷新数据
    func refershUI(homeInfo:HWHomeModel)->Void
    {
        if(homeInfo.hasHiMsg == "0")
        {
            hiImageV.hidden = true;
        }
        else
        {
            hiImageV.hidden = false;
        }
        var customerBtn:UIButton! = itemImageV.viewWithTag(200) as UIButton;
        var scheduleBtn:UIButton! = itemImageV.viewWithTag(201) as UIButton;
        var houseBtn:UIButton! = itemImageV.viewWithTag(202) as UIButton;
        
        var customerTipLabel:UILabel! = customerBtn.viewWithTag(100)as UILabel;
        var scheduleTipLabel:UILabel! = scheduleBtn.viewWithTag(101)as UILabel;
        var houseTipLabel:UILabel! = houseBtn.viewWithTag(102)as UILabel;
        if homeInfo.remindClientNum.integerValue > 0
        {
            scheduleTipLabel.hidden = false
            customerTipLabel.text = homeInfo.remindClientNum
            
        }
        else
        {
             scheduleTipLabel.hidden = true
        }
        if(homeInfo.remindScheduleNum.integerValue > 0)
        {
            scheduleTipLabel.hidden = false;
            scheduleTipLabel.text = homeInfo.remindScheduleNum;
        }
        else
        {
            scheduleTipLabel.hidden = true;
        }
        if(homeInfo.remindHouseStoreNum.integerValue > 0)
        {
             houseTipLabel.hidden = false;
            houseTipLabel.text = homeInfo.remindHouseStoreNum;
        }
        else
        {
            houseTipLabel.hidden = true;
        }
        if(hiImageV.hidden == true)
        {
            messageContentLabel.frame = CGRectMake(CGRectGetMaxX(bellImageV.frame) + 5, messageContentLabel.frame.origin.y, messageContentLabel.frame.size.width, messageContentLabel.frame.size.height);
        }
        else
        {
            messageContentLabel.frame = CGRectMake(CGRectGetMaxX(hiImageV.frame) + 5, messageContentLabel.frame.origin.y, messageContentLabel.frame.size.width, messageContentLabel.frame.size.height);
        }
        messageContentLabel.attributedText = self.attributeStr(homeInfo.adMsgInfo, rol: homeInfo.role)
        
        if homeInfo.newClientNum == ""
        {
            var str = "客户 "+"0";
            var attributeStr = NSMutableAttributedString(string: str);
            var rang = NSMakeRange(countElements("客户 "), 1);
            if iPhone5
            {
            
                attributeStr.addAttribute(NSFontAttributeName,value:UIFont(name: FONTNAME, size: 22)!,range:rang);
            }
            else
            {
                attributeStr.addAttribute(NSFontAttributeName,value:UIFont(name: FONTNAME, size: 27)!,range:rang);
            }
           
            
            attributeStr.addAttribute(NSForegroundColorAttributeName, value: CD_MainColor, range: rang)
            // scrollPictureV.customerNumLabel.textAlignment = NSTextAlignment(rawValue: 0)!;

             scrollPictureV.customerNumLabel.attributedText = attributeStr;
            
            
        }
        else
        {
            var str = "客户 "+homeInfo.newClientNum;
            var attributeStr = NSMutableAttributedString(string: str);
            var rang = NSMakeRange(3, homeInfo.newClientNum.length);
            if iPhone5
            {
                
                attributeStr.addAttribute(NSFontAttributeName,value:UIFont(name: FONTNAME, size: 22)!,range:rang);
            }
            else
            {
                attributeStr.addAttribute(NSFontAttributeName,value:UIFont(name: FONTNAME, size: 27)!,range:rang);
            }

           // attributeStr.addAttribute(NSFontAttributeName,value:UIFont(name: FONTNAME, size: 27)!,range:rang);
            attributeStr.addAttribute(NSForegroundColorAttributeName, value: CD_MainColor, range: rang)
            //scrollPictureV.customerNumLabel.textAlignment = NSTextAlignment(rawValue: 0)!;
            
            scrollPictureV.customerNumLabel.attributedText = attributeStr;
        }
        
        if homeInfo.scdHousesNum == ""
        {
            
            var str = "房源 "+"0";
            var attributeStr = NSMutableAttributedString(string: str);
            var rang = NSMakeRange(countElements("房源 "), 1);
            if iPhone5
            {
                
                attributeStr.addAttribute(NSFontAttributeName,value:UIFont(name: FONTNAME, size: 22)!,range:rang);
            }
            else
            {
                attributeStr.addAttribute(NSFontAttributeName,value:UIFont(name: FONTNAME, size: 27)!,range:rang);
            }

            //attributeStr.addAttribute(NSFontAttributeName,value:UIFont(name: FONTNAME, size: 27)!,range:rang);
            attributeStr.addAttribute(NSForegroundColorAttributeName, value: CD_MainColor, range: rang)
           // scrollPictureV.customerNumLabel.textAlignment = NSTextAlignment(rawValue: 0)!;
            
            scrollPictureV.houseLabel.attributedText = attributeStr;
            
            
        }
        else
        {
            var str = "房源 "+homeInfo.scdHousesNum;
            var attributeStr = NSMutableAttributedString(string: str);
            var rang = NSMakeRange(countElements("房源 "),homeInfo.scdHousesNum.length);
            if iPhone5
            {
                
                attributeStr.addAttribute(NSFontAttributeName,value:UIFont(name: FONTNAME, size: 22)!,range:rang);
            }
            else
            {
                attributeStr.addAttribute(NSFontAttributeName,value:UIFont(name: FONTNAME, size: 27)!,range:rang);
            }

           // attributeStr.addAttribute(NSFontAttributeName,value:UIFont(name: FONTNAME, size: 27)!,range:rang);
            attributeStr.addAttribute(NSForegroundColorAttributeName, value: CD_MainColor, range: rang)
            //scrollPictureV.customerNumLabel.textAlignment = NSTextAlignment(rawValue: 0)!;
            
           scrollPictureV.houseLabel.attributedText = attributeStr;
        }

//        scrollPictureV.customerNumLabel.text = homeInfo.newClientNum;
//        scrollPictureV.houseLabel.text = homeInfo.scdHousesNum;
        
    }
    func attributeStr(str:String,rol:String) -> NSMutableAttributedString
    {
        var  string = rol + str;
        var attributeStr = NSMutableAttributedString(string: string);
        let range = NSMakeRange(0, countElements(rol));
        attributeStr.addAttribute(NSForegroundColorAttributeName, value: UIColor.orangeColor(), range: range)
        return attributeStr
    }
    //创建测试数据
    func createTestData(dic:NSDictionary)->HWHomeModel
    {
        var testModel:HWHomeModel = HWHomeModel(dic: dic);
        /*
        {
        "detail": "请求数据成功!",
        "status":"" ,
        "data":{
        hasHiMsg:"" --是否有HI消息（0无，1有，默认0）
        adMsgInfo:"" --广告消息（文本）
        newClientNum:"", --释放新客户数（默认0）
        remindClientNum:"", --提醒客户数（默认0）
        remindScheduleNum:"", --日程数（默认0）
        remindHouseStoreNum:"", --我的房店数（默认0）
        :"",  --是否有新房提醒(0无，1有，默认0)
        hasSecondHouse:"", --是否有二手房提醒(0无，1有，默认0)
        }
        }
        */

//      testModel.hasHiMsg = "0";
//      testModel.adMsgInfo = "中海大赛特麦纪要开始来得快的劳动力六点多的劳动力";
//      testModel.newClientNum = "200";
//      testModel.remindClientNum = "2";
//      testModel.remindScheduleNum = "3";
//      testModel.remindHouseStoreNum = "4";
//      testModel.hasSecondHouse = "1";
        return testModel;
        
    }
    //设置状态栏背景颜色
    func setStatusView()->Void
    {
        var statusBarView:UIView = createView(CGRectMake(0, 0, kScreenWidth, 20));
        statusBarView.backgroundColor = "#0C1325".UIColor ;
        UIApplication.sharedApplication().statusBarStyle = UIStatusBarStyle.LightContent;
        if(iOS7)
        {
              self.view.addSubview(statusBarView);
        }
      
    }
    func createBackScrollView()->UIScrollView
    {
        var backgroundScrollV:UIScrollView = UIScrollView(frame:CGRectMake(0,0, kScreenWidth, self.view.frame.size.height));
   
        backgroundScrollV.delegate = self;
        backgroundScrollV.showsHorizontalScrollIndicator = false;
        backgroundScrollV.showsVerticalScrollIndicator = true;
        backgroundScrollV.contentSize = CGSizeMake(0,540);
        return backgroundScrollV;
    }
    func createHeaderV()->Void
    {
        //创建背景
        var headerBackGImageVFrame:CGRect = CGRectMake(0, 0,kScreenWidth, 120);
        if(iPhone6plus)
        {
            headerBackGImageVFrame = CGRectMake(0, 0, kScreenWidth, 120*kScreen6PRate-20);
        }
        else if(iPhone6plusFangDa)
        {
            headerBackGImageVFrame = CGRectMake(0, 0, kScreenWidth, 120*kScreen6PRate-50);
        }
        else if(iPhone6)
        {
             headerBackGImageVFrame = CGRectMake(0, 0, kScreenWidth, 120*kScreen6Rate);
        }
        headerBackGImageV = createCustomerImageView(headerBackGImageVFrame,"");
        headerBackGImageV.userInteractionEnabled = true;
        headerBackGImageV.backgroundColor = UIColor.clearColor();
        totalBackgroundScrollV.addSubview(headerBackGImageV);

        //
        var bgImgeVFrame:CGRect = CGRectMake(0, -200, kScreenWidth, 200+120);
        if(iPhone6plus)
        {
            bgImgeVFrame = CGRectMake(0, -200, kScreenWidth, 200+120*kScreen6PRate-20);
        }
        else if(iPhone6)
        {
            bgImgeVFrame = CGRectMake(0, -200, kScreenWidth, 200+120*kScreen6Rate);
        }
        else if(iPhone6plusFangDa)
        {
            bgImgeVFrame = CGRectMake(0, -200, kScreenWidth, 200+120*kScreen6PRate-50);
        }
        var bgImageView:UIView = UIView(frame: bgImgeVFrame);
        bgImageView.backgroundColor = UIColor.clearColor();
        bgImageView.layer.masksToBounds = true;
        
        // 
        
        headImageV = UIImageView(frame: CGRectMake(0, 120, kScreenWidth, 120+80));
        if(iPhone6plus)
        {
            headImageV.frame = CGRectMake(0, 120, kScreenWidth, 120*kScreen6PRate+80-20);
        }
        else if(iPhone6)
        {
             headImageV.frame = CGRectMake(0, 120, kScreenWidth, 120*kScreen6Rate+80);
        }
        else if(iPhone6plusFangDa)
        {
            headImageV.frame = CGRectMake(0, 120, kScreenWidth, 120*kScreen6PRate+80-20);
        }
        headImageV.image = UIImage(named: "head_bg");
        bgImageView.addSubview(headImageV);
        headImageV.backgroundColor = UIColor.clearColor();
        headerBackGImageV.addSubview(bgImageView);
        
        
        //创建头像
        var avatarImageVFrame:CGRect = CGRectMake(15, 10, 60, 60);
        if(iPhone6plus)
        {
            avatarImageVFrame = CGRectMake(15, 27, 80, 80);
        }
        else if(iPhone6plusFangDa)
        {
            avatarImageVFrame = CGRectMake(15, 27, 80, 80);
        }
        else if(iPhone6)
        {
            avatarImageVFrame = CGRectMake(15, 20, 60, 60);
        }
        self.avatarImageV = createCustomerImageView(avatarImageVFrame,"success");
        
        avatarImageV.layer.borderColor = UIColor.whiteColor().CGColor;
        avatarImageV.alpha = 0.5;
        avatarImageV.layer.borderWidth = 2.0;
        if(iPhone6plus)
        {
            avatarImageV.layer.cornerRadius = 40.0;
        }
        else if(iPhone6plusFangDa)
        {
             avatarImageV.layer.cornerRadius = 40.0;
        }
        else if(iPhone6)
        {
            avatarImageV.layer.cornerRadius = 30.0;
        }
        else
        {
            avatarImageV.layer.cornerRadius = 30.0;
        }
        weak var weakImgV: UIImageView? = avatarImageV
        //MYP add v3.2.2修改头像加载方式
        //let url = NSURL(string:Utility.imageDownloadWithMongoDbKey(HWUserLogin.currentUserLogin().brokerPicKey))
        let url = NSURL(string:HWUserLogin.currentUserLogin().brokerPicKey)
        avatarImageV.setImageWithURL(url, placeholderImage: Utility.getPlaceHolderImage(avatarImageV.frame.size, imageName: "personal_2")) { (image, error, imageCacheType) -> Void in
            if (error != nil)
            {
                let size: CGSize! = self.avatarImageV.frame.size
                weakImgV?.image = Utility.getPlaceHolderImage(size, imageName: "personal_2")
            }
            else
            {
                weakImgV?.image = image
            }
        }
        avatarImageV.layer.masksToBounds = true;
        headerBackGImageV.addSubview(avatarImageV);
        
        //姓名
        var nameLabelFrame:CGRect = CGRectMake(CGRectGetMaxX(avatarImageVFrame)+10,avatarImageVFrame.origin.y+8,150,20);
        var nameLabelColor = UIColor.whiteColor();
        nameLabel = createCustomeLabel(nameLabelFrame, nameLabelColor,HWUserLogin.currentUserLogin().brokerName,TF_18);
        nameLabel.textAlignment = NSTextAlignment.Left;
        if(HWUserLogin.currentUserLogin().orgName == "")
        {
            nameLabel.center = CGPointMake(nameLabel.center.x, avatarImageV.center.y);
        }
        headerBackGImageV.addSubview(nameLabel);
        
        //公司
        var companyLabelFrame:CGRect = CGRectMake(CGRectGetMaxX(avatarImageVFrame)+10,CGRectGetMaxY(nameLabel.frame)+10,250,20);
        var companyLabelColor = UIColor.whiteColor();
        companyLabel = createCustomeLabel(companyLabelFrame, companyLabelColor,HWUserLogin.currentUserLogin().orgName,TF_15);
        companyLabel.textAlignment = NSTextAlignment.Left;
        headerBackGImageV.addSubview(companyLabel);
        //创建箭头
        var arrowImageVFrame:CGRect = CGRectMake(kScreenWidth-15, 20, 8, 14);
        var arrowImageV:UIImageView = createCustomerImageView(arrowImageVFrame,"arrow_next");
        arrowImageV.center = CGPointMake(kScreenWidth-15-4, avatarImageV.center.y);
        headerBackGImageV.addSubview(arrowImageV);
        
        
        //创建进入个人信息手势
        var personInfoGesture:UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: "commeInPerson:");
        headerBackGImageV.addGestureRecognizer(personInfoGesture);
        //创建消息视图
        var messageImageVFrame:CGRect = CGRectMake(0, headerBackGImageV.frame.size.height-35, kScreenWidth, 35);
        if(iPhone6plus)
        {
            messageImageVFrame = CGRectMake(0, headerBackGImageV.frame.size.height-40, kScreenWidth, 40);
        }
        else if(iPhone6)
        {
            messageImageVFrame = CGRectMake(0, headerBackGImageV.frame.size.height-40, kScreenWidth, 40);
        }
        else if(iPhone6plusFangDa)
        {
            messageImageVFrame = CGRectMake(0, headerBackGImageV.frame.size.height-40, kScreenWidth, 40);
        }
        var messageImageV:UIImageView = createCustomerImageView(messageImageVFrame,"");
        messageImageV.backgroundColor = UIColor.lightGrayColor();
        messageImageV.alpha = 0.1;
        messageImageV.userInteractionEnabled = true;
        headerBackGImageV.addSubview(messageImageV);

        //创建消息手势
        var messageGesture:UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: "commeInMessage:");
        messageImageV.addGestureRecognizer(messageGesture);
        
        //创建小铃铛切图
        var bellImageVFrame:CGRect = CGRectMake(15, 12+messageImageVFrame.origin.y, 14, 18);
        bellImageV = createCustomerImageView(bellImageVFrame,"news2");
        headerBackGImageV.addSubview(bellImageV);
        
        //创建HI视图
        var hiImageVFrame:CGRect = CGRectMake(CGRectGetMaxX(bellImageV.frame),(messageImageVFrame.origin.y)-1, 15, 15);
        hiImageV = createCustomerImageView(hiImageVFrame,"hi_icon");
        hiImageV.alpha = 1.0;
        headerBackGImageV.addSubview(hiImageV);
        
        //创建消息内容Label
        var messageContentLabelFrame:CGRect = CGRectMake(CGRectGetMaxX(hiImageV.frame),CGRectGetMaxY(hiImageVFrame)-3,kScreenWidth-CGRectGetMaxX(hiImageVFrame)-15,15);
        var messageContentLabelColor = UIColor.whiteColor();
        messageContentLabel = createCustomeLabel(messageContentLabelFrame, messageContentLabelColor, "", TF_14);
        messageContentLabel.textAlignment = NSTextAlignment.Left;
        headerBackGImageV.addSubview(messageContentLabel);
  
    }
    func scrollViewDidScroll(scrollView: UIScrollView)
    {
        if(scrollView.contentOffset.y < -80)
        {
//            float scale = ABS(self.homeTable.contentOffset.y) / 80.0f;
//            backgroundImgV.transform = CGAffineTransformMakeScale(scale, scale);
            let scale = abs(scrollView.contentOffset.y);
            let bili = scale / 80;
             headImageV.transform = CGAffineTransformMakeScale(bili, bili);
        }
        else
        {
            headImageV.transform = CGAffineTransformMakeScale(1, 1);
        }
    }
    func createScrollV(imageArry:NSArray)->Void
    {
         var arr = NSMutableArray()
        var imageMutableArry:NSMutableArray = NSMutableArray();
        if(imageArry.count == 0)
        {
            var itemTemp:SGFocusImageItem = SGFocusImageItem.itemWithTitle("title1", image: "banner1", tag: 0 ,type:"",id:"") as SGFocusImageItem ;
            imageMutableArry.addObject(itemTemp);
        }
        else
        {
            for(var i:Int = 0;i < imageArry.count;i++)
            {
                var imageDic:NSDictionary = imageArry.objectAtIndex(i) as NSDictionary;
                var itemTemp:SGFocusImageItem = SGFocusImageItem.itemWithTitle(imageDic.stringObjectForKey("url")as NSString, image: imageDic.stringObjectForKey("pic")as NSString, tag: 0 ,type:imageDic.stringObjectForKey("type")as NSString,id:imageDic.stringObjectForKey("id")as NSString) as SGFocusImageItem ;
                imageMutableArry.addObject(itemTemp);
                arr .addObject(imageDic.stringObjectForKey("title")as NSString)
            }
        }
//        arr  = ["wwwww","wwwwwww","wwwww"]
        scrollPictureV = SGFocusImageFrame(frame: CGRectMake(15, CGRectGetMaxY(headerBackGImageV.frame)+12, self.view.frame.size.width-2*15, 250+20), delegate:self, focusImageItemsArrray:imageMutableArry, detailarr: arr);
        
        if(iPhone6plus)
        {
              scrollPictureV = SGFocusImageFrame(frame: CGRectMake(15, CGRectGetMaxY(headerBackGImageV.frame)+12, self.view.frame.size.width-2*15, 320+30), delegate:self, focusImageItemsArrray:imageMutableArry, detailarr: arr);
            //scrollPictureV.frame = CGRectMake(15, CGRectGetMaxY(headerBackGImageV.frame)+12, self.view.frame.size.width-2*15, 320+20)
            
        }
        else if(iPhone6plusFangDa)
        {
          scrollPictureV = SGFocusImageFrame(frame: CGRectMake(15, CGRectGetMaxY(headerBackGImageV.frame)+12, self.view.frame.size.width-2*15, 320+30), delegate:self, focusImageItemsArrray:imageMutableArry, detailarr: arr);
            
            // scrollPictureV.frame = CGRectMake(15, CGRectGetMaxY(headerBackGImageV.frame)+12, self.view.frame.size.width-2*15, 320+20)
        }
        else if(iPhone6)
        {
             scrollPictureV = SGFocusImageFrame(frame: CGRectMake(15, CGRectGetMaxY(headerBackGImageV.frame)+12, self.view.frame.size.width-2*15, 300+20), delegate:self, focusImageItemsArrray:imageMutableArry, detailarr: arr);
            
            
            // scrollPictureV.frame = CGRectMake(15, CGRectGetMaxY(headerBackGImageV.frame)+12, self.view.frame.size.width-2*15, 300+20)
        }
        scrollPictureV.autoScrolling = true;
        scrollPictureV.detailArr = arr;
        scrollPictureV.backgroundColor = UIColor.clearColor();
        totalBackgroundScrollV.addSubview(scrollPictureV);
    }
    //创建客户，日程，我的房店视图
    func createItemView()->Void
    {
        var itemImageVFrame:CGRect = CGRectMake(0, 312, kScreenWidth, 312);
        if(iPhone6plus)
        {
              itemImageVFrame = CGRectMake(0, 445, kScreenWidth, self.view.frame.size.height-443);
        }
        else if(iPhone6plusFangDa)
        {
            itemImageVFrame = CGRectMake(0, 415, kScreenWidth, self.view.frame.size.height-413);
        }
        else if(iPhone6)
        {
              itemImageVFrame = CGRectMake(0, 372, kScreenWidth, self.view.frame.size.height-355);
        }
        itemImageV = createCustomerImageView(itemImageVFrame,"");
        itemImageV.userInteractionEnabled = true;
        itemImageV.backgroundColor = CD_OrangeColor;
        totalBackgroundScrollV.addSubview(itemImageV);
        
        for(var i:CGFloat = 0;i<3;i++)
        {
            var jianju:CGFloat = (kScreenWidth-30*kScreenReverseRate*2-3*81*kScreenReverseRate)/2;
            jianju = jianju + +81*kScreenReverseRate;
            jianju = jianju*(i as CGFloat);
            var generalBtnFrame:CGRect = CGRectMake(30*kScreenReverseRate+jianju,70+15,81*kScreenReverseRate,81*kScreenReverseRate);
            if(iPhone6plus)
            {
                generalBtnFrame  = CGRectMake(generalBtnFrame.origin.x, generalBtnFrame.origin.y+12, generalBtnFrame.size.width, generalBtnFrame.size.height);
            }
            else if(iPhone6)
            {
                 generalBtnFrame  = CGRectMake(generalBtnFrame.origin.x, generalBtnFrame.origin.y+25, generalBtnFrame.size.width, generalBtnFrame.size.height);
            }
            var generalLabelFrame:CGRect = CGRectMake(0,0,81*kScreenReverseRate,20);
            var tipLabelFrame:CGRect = CGRectMake((81-17)*kScreenReverseRate, 20*kScreenReverseRate-8, 20*kScreenReverseRate, 20*kScreenReverseRate)
            var generalBtn:UIButton!;
            var generalLabel:UILabel!;
            var tipLabel:UILabel = UILabel();
            if(i == 0)
            {
                generalBtn = createCustomeBtn(self, "clickItemAction:", generalBtnFrame,nil, "","home_icon1");
                generalLabel = createCustomeLabel(generalLabelFrame,UIColor.whiteColor() ,"客户",TF_15);
                tipLabel = createCustomeLabel(tipLabelFrame,UIColor.whiteColor() ,"",TF_13);
            }
            else if(i == 1)
            {
                generalBtn = createCustomeBtn(self, "clickItemAction:", generalBtnFrame,nil, "","home_icon2");
                generalLabel = createCustomeLabel(generalLabelFrame,UIColor.whiteColor() ,"日程",TF_15);
                tipLabel = createCustomeLabel(tipLabelFrame,UIColor.whiteColor() ,"",TF_13);
            }
            else if(i == 2)
            {
                generalBtn = createCustomeBtn(self, "clickItemAction:", generalBtnFrame,nil, "","home_icon3");
                generalLabel = createCustomeLabel(generalLabelFrame,UIColor.whiteColor() ,"我的房店",TF_15);
                tipLabel = createCustomeLabel(tipLabelFrame,UIColor.whiteColor() ,"",TF_13);
                
               
            }
            tipLabel.backgroundColor = UIColor.redColor();
            tipLabel.hidden = true;
            tipLabel.textColor = UIColor.whiteColor();
            tipLabel.layer.cornerRadius = 10*kScreenReverseRate;
            tipLabel.layer.masksToBounds = true;
            tipLabel.textAlignment = NSTextAlignment.Center;
            generalLabel.textAlignment = NSTextAlignment.Center;
            generalBtn.tag = Int(200+i);
            tipLabel.tag = Int(100+i);
            generalLabel.center = CGPointMake(generalBtn.center.x, generalBtn.center.y+10+generalBtn.frame.size.width/2);
            
            itemImageV.addSubview(generalBtn);
            itemImageV.addSubview(generalLabel);
            generalBtn.addSubview(tipLabel);
        }
    }
    override func preferredStatusBarStyle() -> UIStatusBarStyle
    {
        return .LightContent
    }
    //MARK:-进入消息
    func commeInMessage(sender:UIGestureRecognizer)->Void
    {
        print("进入消息列表");
        //MYP add v3.2将消息列表vc 设置为全局
        //MYP add v3.2.3修改 主消息列表改为 HWMainMsgViewController所有消息分类
        //shareAppDelegate.messageListVC = HWMessageListViewController()
        shareAppDelegate.messageListVC = HWMainMsgViewController()
        //let messageListVC = HWMessageListViewController()
        //self.navigationController?.pushViewController(messageListVC, animated: true)
        self.navigationController?.pushViewController(shareAppDelegate.messageListVC, animated: true)
    }
    //MARK:-进入个人中心
    func commeInPerson(sender:UIGestureRecognizer)->Void
    {
        var personalVC = HWPersonalCenterViewController()
        self.navigationController?.pushViewController(personalVC, animated: true)
    }
    //MARK:-点击客户，日程，我的房店的按钮
    func clickItemAction(sender:UIButton) -> Void
    {
        var whichItem:NSInteger = sender.tag;
//        println(whichItem) 
        switch whichItem
        {
            case 200:
                MobClick.event("Client_click");
                let customerListV:HWInputClientViewController = HWInputClientViewController();
                customerListV.myFunc = { ()->Void in
                    self.getNewsList();
                    self.requestHomeInfo()
                }

                self.navigationController?.pushViewController(customerListV, animated: true);
                print("进入客户");
                break;
            case 201:
                MobClick.event("Schedule_click");
                print("进入日程");
                let scheduleManagerVC = HWScheduleManagerViewController()
                scheduleManagerVC.myFunc = { ()->Void in
                    self.getNewsList();
                    self.requestHomeInfo()
                }
                self.navigationController?.pushViewController(scheduleManagerVC, animated: true)
                break;
            
            case 202:
                MobClick.event("Mystore_click");
                print("我的房店");
                let myHouseShopVC = HWMyHouseShopViewController()
                myHouseShopVC.myFunc = { ()->Void in
                    self.getNewsList();
                    self.requestHomeInfo()
                }
                self.navigationController?.pushViewController(myHouseShopVC, animated: true)
                break;
            default:
                print("");
                break;
        }
    }
    
    //MARK:-点击滑动图片的代理
    func foucusImageFrame(imageFrame: SGFocusImageFrame!, didSelectItem item: SGFocusImageItem!)
    {
        if(adArry.count > 0)
        {
            MobClick.event("News_click ");
            var adIdStr:NSString! = item.title as NSString
           
            if item.type == "coupon"
            {
                //跳转优惠券详情
                let vc = HWDisCountDetailViewController()
                vc.couponId = item.aId
                vc.webViewUrlStr = adIdStr
                vc.brokerId = HWUserLogin.currentUserLogin().brokerId
                vc.fromVCName = "首页"
                self.navigationController?.pushViewController(vc, animated: true)
            }
            else
            {
            var infomationV:HWinfomationViewController = HWinfomationViewController();
            infomationV.newUrl = adIdStr;
            self.navigationController?.pushViewController(infomationV, animated: true);
            }
        }
        
    }
    //MARK:-抢客
    func commeInRob(robItem: SGRobItem!)
    {
        MobClick.event("Takeclients_click");
//        var robCustomerV:HWRobCustomerViewController = HWRobCustomerViewController();
//        self.navigationController?.pushViewController(robCustomerV, animated: true);
//        //MYP add v3.1 抢客抢房
        robVC = HWRobViewController()
        self.navigationController?.pushViewController(robVC, animated: true)
        
    }
  
    
}
