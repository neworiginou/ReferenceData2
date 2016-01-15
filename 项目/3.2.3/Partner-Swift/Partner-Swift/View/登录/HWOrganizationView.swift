//
//  HWOrganizationView.swift
//  Partner-Swift
//
//  Created by hw500028 on 15/2/28.
//  Copyright (c) 2015年 caijingpeng.haowu. All rights reserved.
//

import UIKit
protocol HWOrganizationViewDelegate:NSObjectProtocol
{
    func addshopBtnClick() -> Void
    func addBrokerClik(model:HWShopAdminHeaderModel) ->Void
}
enum IsAudited
{
    case audite       //已审核
    case notAudite    //为审核
    case notAgree     //审核未通过
    case auditing     //审核中
}

typealias cellSeleced = (HWBrokerModel) -> Void

class HWOrganizationView: HWBaseRefreshView,HWShopAdminHeaderViewDelegate {
    var iconImageView:UIImageView?          //头像
    var nameLabel:UILabel?                  //名字
    var organizationLabel:UILabel?          //公司
    var isAuditedLabel:UILabel?            //审核状态
    var shopNumLabel:UILabel?             //门店个数
    var performanceLabel:UILabel?         //业绩
    var delegate:HWOrganizationViewDelegate?
    var dataArr:NSMutableArray!
    var brokerDataArr:[HWBrokerModel] = []
    let colors = [CD_GreenColor,CD_OrangeColor,CD_RedDeepColor,CD_BlueColor,CD_GreenLigthColor]        //报备前面的颜色
    var labels:[UILabel] = []      //报备等label
    var isAudited:IsAudited?       //是否审核
    var myfunc = cellSeleced?()
    var currentSelectHeader = 0    //当前选中表头
    var lastPage = false           //经纪人列表是否是最后一页
    var brokerCurrentPage = 1      //经纪人当前页
    var isLoadMore = false         //是否加载更多按钮
    var checkoutLabel:UILabel?
    var details:NSArray?           //业绩详情
    var adminInfoModel:HWAdminInfoModel?{
        didSet
        {
            /*
            "filingClientNum": 0,   -报备客户数
            "visitClientNum": 0,    -到访客户数
            "groupBuyClientNum": 0, -下定客户数
            "dealClientNum": 0,     -成交客户数
            */
            /*
            "adminId": 15,          -管理员id
            "adminName": "",        -管理员姓名
            "orgName": "",          -中介名称
            "orgAuditStatus": 1,    -中介审核状态(0未审核，1审核通过，2审核不通过)
            */
            if adminInfoModel?.orgAuditStatus == "1"
            {
                isAudited = IsAudited.audite
            }
            else if adminInfoModel?.orgAuditStatus == "0"
            {
                isAudited = IsAudited.notAudite
            }
            else if adminInfoModel?.orgAuditStatus == "2"
            {
                isAudited = IsAudited.notAgree
            }
            else
            {
                isAudited = IsAudited.auditing
            }
            self.baseTable.tableHeaderView = headerViewFunc()
            nameLabel?.text = adminInfoModel?.adminName
            organizationLabel?.text = adminInfoModel?.orgName
            performanceLabel?.attributedText = attributeStr(adminInfoModel!.groupBuyMoney)
            shopNumLabel?.text = "门店管理(\(dataArr.count)个门店)"
            checkoutLabel!.attributedText = checkoutAttributeStr(adminInfoModel!.brokerageNum)
        }
        
    }   //管理员信息

    override init(frame: CGRect) {
        super.init(frame: frame)
        self.queryListData()
        self.dataArr = NSMutableArray()
        isAudited = IsAudited.audite
        self.baseTable.tableHeaderView = headerViewFunc()
        self.setIsNeedHeadRefresh(true)
        self.baseTable.rowHeight = 44
        self.baseTable.registerClass(HWBrokerCell.self, forCellReuseIdentifier: "identify")
        NSNotificationCenter.defaultCenter().addObserver(self, selector: "refreshTable", name: "addBrokerSuccess", object: nil)
        NSNotificationCenter.defaultCenter().addObserver(self, selector: "queryListData", name: "addShopSuccess", object: nil)
        
        
    }
    
    deinit
    {
        NSNotificationCenter.defaultCenter().removeObserver(self, name: "addBrokerSuccess", object: nil)
        NSNotificationCenter.defaultCenter().removeObserver(self, name: "addShopSuccess", object: nil)
    }
    
    //头部视图
    func headerViewFunc() -> UIView
    {
        if adminInfoModel != nil
        {
             details = [
                adminInfoModel!.filingClientNum,
                adminInfoModel!.visitClientNum,
                adminInfoModel!.groupBuyClientNum,
                adminInfoModel!.dealClientNum,
                adminInfoModel!.serviceNum
            ]
        
        }
        else
        {
            details = ["0","0","0","0","0"]
        }
        
        var headerViewRect = CGRect()
        var performanceViewHeight:CGFloat = 0.0
        var infoVieHeight:CGFloat = 0.0
        //判断是否认证
        if isAudited == IsAudited.audite
        {
            headerViewRect = CGRect(x: 0, y: 0, width: kScreenWidth, height: 410 * kScreenRate)
            performanceViewHeight = 240 * kScreenRate
            infoVieHeight = 115 * kScreenRate

        }
        else
        {
            headerViewRect = CGRect(x: 0, y: 0, width: kScreenWidth, height: 215 * kScreenRate)
            performanceViewHeight = 0.0
            infoVieHeight = 150 * kScreenRate

        }
        
        let headerView = UIView(frame: headerViewRect)
        //1个人信息背景图
        let infoBackgroundImgV = UIImageView(frame: CGRect(x: 0, y: 0, width: kScreenWidth, height: infoVieHeight))
        infoBackgroundImgV.backgroundColor = UIColor.clearColor()
        infoBackgroundImgV.image = UIImage(named: "head_bg3")
        headerView.addSubview(infoBackgroundImgV)
        
        //1.1头像
        iconImageView = UIImageView.newAutoLayoutView()
        infoBackgroundImgV.addSubview(iconImageView!)
        iconImageView?.autoPinEdgeToSuperviewEdge(ALEdge.Left, withInset: 15)
        iconImageView?.autoSetDimensionsToSize(CGSize(width: 80, height: 80))
        iconImageView?.autoPinEdgeToSuperviewEdge(ALEdge.Top, withInset: 15)
        iconImageView?.backgroundColor = UIColor.clearColor()
        let maseklayer = CAShapeLayer()
        maseklayer.path = UIBezierPath(ovalInRect: CGRect(x: 0.0, y: 0.0, width: 80.0, height: 80.0)).CGPath
        iconImageView?.layer.mask = maseklayer
        let userDefault = NSUserDefaults.standardUserDefaults()
        var picKey:String? = userDefault.objectForKey(kLastLoginPicKey) as? String
        
        if picKey == nil
        {
            picKey = ""
        }
          let url = NSURL(string:Utility.imageDownloadWithMongoDbKey(picKey!))
        iconImageView!.setImageWithURL(url,placeholderImage: headPlaceHolderImage){ (image, error, imageCacheType) -> Void in
            if (error != nil)
            {
                self.iconImageView!.image = headFailedImage
            }
            else
            {
                self.iconImageView!.image = image
            }
        }
        //1.2名字
        nameLabel = UILabel.newAutoLayoutView()
        infoBackgroundImgV.addSubview(nameLabel!)
        nameLabel?.autoPinEdgeToSuperviewEdge(ALEdge.Top, withInset: 30)
        nameLabel?.autoPinEdge(ALEdge.Left, toEdge: ALEdge.Right, ofView: iconImageView, withOffset: 15)

        //1.3公司
        organizationLabel = UILabel.newAutoLayoutView()
        infoBackgroundImgV.addSubview(organizationLabel!)
        organizationLabel?.autoPinEdge(ALEdge.Top, toEdge: ALEdge.Bottom, ofView: nameLabel, withOffset: 5)
        organizationLabel?.autoPinEdge(ALEdge.Left, toEdge: ALEdge.Left, ofView: nameLabel)
        organizationLabel?.lineBreakMode = NSLineBreakMode.ByTruncatingTail
        
        //1.4是否审核
        isAuditedLabel = UILabel.newAutoLayoutView()
        infoBackgroundImgV.addSubview(isAuditedLabel!)
        isAuditedLabel?.autoAlignAxis(ALAxis.Horizontal, toSameAxisOfView: organizationLabel)
        isAuditedLabel?.autoPinEdge(ALEdge.Left, toEdge: ALEdge.Right, ofView: organizationLabel, withOffset: 5)
        isAuditedLabel?.autoPinEdgeToSuperviewEdge(ALEdge.Right, withInset: 10, relation: NSLayoutRelation.GreaterThanOrEqual)
        isAuditedLabel?.autoSetDimensionsToSize(CGSize(width: 48, height: 22))
        isAuditedLabel?.textAlignment = NSTextAlignment.Center
        if isAudited == IsAudited.audite
        {
            isAuditedLabel?.text = "已审核"
            isAuditedLabel?.backgroundColor = CD_Btn_MainColor

        }
        else
        {
            isAuditedLabel?.backgroundColor = CD_GreenColor
            if(isAudited == IsAudited.notAgree)
            {
                isAuditedLabel?.text = "审核未通过"
            }
            if (isAudited == IsAudited.auditing)
            {
                isAuditedLabel?.text = "审核中"
            }
            if (isAudited == IsAudited.notAudite)
            {
                isAuditedLabel?.text = "未审核"

            }
        }
        isAuditedLabel?.textColor = UIColor.whiteColor()
        isAuditedLabel?.font = Define.font(TF_13)
        isAuditedLabel?.layer.cornerRadius = 3
        isAuditedLabel?.layer.masksToBounds = true
        //审核通过后 文本视图
        if isAudited != IsAudited.audite
        {
            let labelBackGview = UIView.newAutoLayoutView()
            infoBackgroundImgV.addSubview(labelBackGview)
            labelBackGview.autoPinEdgesToSuperviewEdgesWithInsets(UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0), excludingEdge: ALEdge.Top)
            labelBackGview.autoSetDimension(ALDimension.Height, toSize: 35)
            labelBackGview.backgroundColor = UIColor.blackColor()
            labelBackGview.alpha = 0.1
            let hwlabel = UILabel.newAutoLayoutView()
            infoBackgroundImgV.addSubview(hwlabel)
            hwlabel.autoPinEdgesToSuperviewEdgesWithInsets(UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0), excludingEdge: ALEdge.Top)
            hwlabel.autoSetDimension(ALDimension.Height, toSize: 35)
            
            hwlabel.text = "  审核通过后,机构的经纪人就可以推荐客户"
            hwlabel.font = Define.font(TF_13)
            hwlabel.backgroundColor = UIColor.clearColor()

        }
        //2.业绩背景
        let performanceBackgroundView = UIView(frame: CGRect(x: 0, y: CGRectGetMaxY(infoBackgroundImgV.frame), width: kScreenWidth, height: performanceViewHeight))
        performanceBackgroundView.backgroundColor = UIColor.whiteColor()
        headerView.addSubview(performanceBackgroundView)
       //审核通过后才加载业绩视图
        if isAudited == IsAudited.audite
        {
            performanceViewFunc(performanceBackgroundView)

        }

        //3 门店管理
                //3.1背景
        let shopManagerBackgroundView = UIView.newAutoLayoutView()
        headerView.addSubview(shopManagerBackgroundView)
        shopManagerBackgroundView.autoPinEdgesToSuperviewEdgesWithInsets(UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0), excludingEdge: ALEdge.Top)
        shopManagerBackgroundView.autoPinEdge(ALEdge.Top, toEdge: ALEdge.Bottom, ofView: performanceBackgroundView)
        shopManagerBackgroundView.backgroundColor = UIColor.clearColor()
        shopManagerBackgroundView.drawTopLine()
        shopManagerBackgroundView.drawBottomLine()
                //3.2添加门店按钮
        let addShopBtn = UIButton.newAutoLayoutView()
        shopManagerBackgroundView.addSubview(addShopBtn)
        addShopBtn.autoSetDimensionsToSize(CGSize(width: 75, height: 30))
        addShopBtn.autoAlignAxisToSuperviewAxis(ALAxis.Horizontal)
        addShopBtn.autoPinEdgeToSuperviewEdge(ALEdge.Right, withInset: 14)
        addShopBtn.titleLabel?.font = Define.font(TF_13)
        addShopBtn.setTitle("添加门店", forState: UIControlState.Normal)
        addShopBtn.setTitleColor(UIColor.whiteColor(), forState:UIControlState.Normal)
        addShopBtn.setBackgroundImage(Utility.imageWithColor(CD_Btn_MainColor, _size: CGSize(width: 75, height: 30)), forState: UIControlState.Normal)
        addShopBtn.addTarget(self, action: "addShopClick", forControlEvents: UIControlEvents.TouchUpInside)
        addShopBtn.layer.cornerRadius = 3
        addShopBtn.layer.masksToBounds = true
                //3.3门店数量
        shopNumLabel = UILabel.newAutoLayoutView()
        shopManagerBackgroundView.addSubview(shopNumLabel!)
        shopNumLabel?.autoPinEdgeToSuperviewEdge(ALEdge.Left, withInset: 15)
        shopNumLabel?.autoAlignAxisToSuperviewAxis(ALAxis.Horizontal)
        shopNumLabel?.autoPinEdge(ALEdge.Right, toEdge: ALEdge.Left, ofView: addShopBtn)
        shopNumLabel?.text = "门店管理(0)个门店)"

        UIView.autoSetPriority(100, forConstraints: { () -> Void in
            self.shopNumLabel?.autoSetContentCompressionResistancePriorityForAxis(ALAxis.Horizontal)
            return
        })
        shopNumLabel?.font = Define.font(TF_15)
        return headerView
    }
    
    //业绩详情图Func
    func performanceViewFunc(backgroundView:UIView) ->Void
    {
        let hwlabel = UILabel.newAutoLayoutView()
        backgroundView.addSubview(hwlabel)
        hwlabel.autoPinEdgeToSuperviewEdge(ALEdge.Left, withInset: 15)
        hwlabel.autoPinEdgeToSuperviewEdge(ALEdge.Top, withInset: 10)
        hwlabel.text = "本月业绩"
        hwlabel.font = Define.font(TF_15)
        
        //1 结佣背景
        let checkoutImgv = UIImageView.newAutoLayoutView()
        backgroundView.addSubview(checkoutImgv)
        checkoutImgv.autoPinEdge(ALEdge.Top, toEdge: ALEdge.Bottom, ofView: hwlabel, withOffset: 10)
        checkoutImgv.autoPinEdgeToSuperviewEdge(ALEdge.Left, withInset: 15)
        checkoutImgv.autoSetDimensionsToSize(CGSize(width: 130, height: 130))
        checkoutImgv.backgroundColor = UIColor.clearColor()
        checkoutImgv.layer.cornerRadius = 65
        checkoutImgv.layer.masksToBounds = true
        checkoutImgv.image = UIImage(named: "statistics_bg")
            //1.1
        checkoutLabel = UILabel.newAutoLayoutView()
        checkoutImgv.addSubview(checkoutLabel!)
        checkoutLabel!.autoPinEdgeToSuperviewEdge(ALEdge.Top, withInset: 30)
        checkoutLabel!.autoAlignAxisToSuperviewAxis(ALAxis.Vertical)
        checkoutLabel!.font = Define.font(TF_13)
        checkoutLabel!.textColor = UIColor.whiteColor()
        checkoutLabel!.attributedText = checkoutAttributeStr("0")
        let checkoutLabel2 = UILabel.newAutoLayoutView()
        checkoutImgv.addSubview(checkoutLabel2)
        checkoutLabel2.autoPinEdge(ALEdge.Top, toEdge: ALEdge.Bottom, ofView: checkoutLabel)
        checkoutLabel2.autoPinEdge(ALEdge.Left, toEdge: ALEdge.Left, ofView: checkoutLabel)
        checkoutLabel2.text = "已结佣"
        checkoutLabel2.font = Define.font(TF_13)
        checkoutLabel2.textColor = UIColor.whiteColor()
        
        //2 业绩
        performanceLabel = UILabel.newAutoLayoutView()
        backgroundView.addSubview(performanceLabel!)
        performanceLabel?.autoPinEdge(ALEdge.Top, toEdge: ALEdge.Bottom, ofView: checkoutImgv, withOffset: 10)
        performanceLabel?.autoPinEdgeToSuperviewEdge(ALEdge.Left, withInset: 15)
        performanceLabel?.font = Define.font(TF_15)
        performanceLabel?.attributedText = attributeStr("0")

        //3 报备等详情
        for i in 0...4
        {
            
            let numView = UIView(frame: CGRect(x: 200, y: 50 + 33 * CGFloat(i), width: 145, height:20 ))
            numView.backgroundColor = UIColor.clearColor()
            backgroundView.addSubview(numView)
//            numLabel(numView, color: colors[i],index:i)
            numLabel(numView, color: colors[i], index: i)
            
        }
    }
    
    //报备等详情视图
    func numLabel(superView:UIView, color:UIColor,index:Int) ->Void
    {
        let hwView = UIView.newAutoLayoutView()
        superView.addSubview(hwView)
        hwView.layer.cornerRadius = 3
        hwView.layer.masksToBounds = true
        hwView.backgroundColor = color
        hwView.autoPinEdgesToSuperviewEdgesWithInsets(UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0), excludingEdge: ALEdge.Right)
        hwView.autoSetDimension(ALDimension.Width, toSize: 20)
        
        //
        var hwlabel = UILabel.newAutoLayoutView()
        superView.addSubview(hwlabel)
        hwlabel.autoPinEdgesToSuperviewEdgesWithInsets(UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0), excludingEdge: ALEdge.Left)
        hwlabel.autoPinEdge(ALEdge.Left, toEdge: ALEdge.Right, ofView: hwView, withOffset: 5)
        hwlabel.textColor = CD_Txt_Color_99
        hwlabel.font = Define.font(TF_15)
        hwlabel.backgroundColor = UIColor.clearColor()
//        labels.append(hwlabel)
        hwlabel.attributedText = self.checkoutDetailAttributeStr(details![index] as String, index: index)
    }
    
   //业绩文本中数字 变色
    func attributeStr(str:String) -> NSMutableAttributedString
    {
        var  string = "业绩:  " + str + "元"
        var attributeStr = NSMutableAttributedString(string: string)
        let range = NSMakeRange(4,countElements(string) - 5)
        attributeStr.addAttribute(NSForegroundColorAttributeName, value: UIColor.orangeColor(), range: range)
        return attributeStr
    }
    
    //业绩文本中的数字 变大
    func    checkoutAttributeStr(str:String) ->NSMutableAttributedString
    {
        var string = str + "组"
        var attributeStr = NSMutableAttributedString(string: string)
        let range = NSMakeRange(0, countElements(string) - 1)
        attributeStr.addAttribute(NSFontAttributeName, value: Define.font(TF_30), range: range)
        return attributeStr
    }
    
    func checkoutDetailAttributeStr(str:String,index:Int) -> NSMutableAttributedString
    {
        var string = ""
        switch index
        {
        case 0:
          string = "报备" + str + "组"
        case 1:
            string = "到访" + str + "组"
        case 2:
            string = "下定" + str + "组"
        case 3:
            string = "成交" + str + "组"
        case 4:
            string = "报备服务" + str + "组"
        default: string = ""
        }
        var range = NSMakeRange(0, 0)
        if index == 4
        {
            range = NSMakeRange(4, countElements(string) - 5)

        }
        else
        {
            range = NSMakeRange(2, countElements(string) - 3)

        }
        var attributeStr = NSMutableAttributedString(string: string)
        attributeStr.addAttribute(NSForegroundColorAttributeName, value: UIColor.blackColor(), range: range)
        return attributeStr
        
    }
    
    //MARK:---tablviewDelegate
     func tableView(tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        var shopHeaderView = HWShopAdminHeaderView.headerViewWithTableView(tableView, hwSection: section)
        shopHeaderView.delegate = self
        shopHeaderView.shopAdminModel = dataArr[section] as? HWShopAdminHeaderModel
        return shopHeaderView
    }
    
    func tableView(tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 88
    }
    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return dataArr.count
    }
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        let model = dataArr[section] as HWShopAdminHeaderModel
        if model.groupIsOpen == true
        {

            return brokerDataArr.count + 1
        }
        else
        {
            return 0
        }
    }
    
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {

        let loadMore = "loadMore"
         if indexPath.row == brokerDataArr.count
         {
            var loadMoreCell:UITableViewCell? = tableView.dequeueReusableCellWithIdentifier(loadMore) as? UITableViewCell
            if loadMoreCell == nil
            {
                loadMoreCell = UITableViewCell(style: UITableViewCellStyle.Default, reuseIdentifier: loadMore)
                let btn = UIButton.newAutoLayoutView()
                loadMoreCell!.contentView.addSubview(btn)
                btn.autoAlignAxisToSuperviewAxis(ALAxis.Vertical)
                btn.autoAlignAxisToSuperviewAxis(ALAxis.Horizontal)
                btn.autoSetDimension(ALDimension.Height, toSize: 44)
                btn.setTitle("加载更多", forState: UIControlState.Normal)
                btn.setTitleColor(UIColor.blackColor(), forState: UIControlState.Normal)
                btn.addTarget(self, action: "loadMoreBtnClick", forControlEvents: UIControlEvents.TouchUpInside)
                btn.titleLabel?.font = Define.font(TF_13)
                loadMoreCell?.backgroundColor = UIColor.clearColor()
                loadMoreCell?.contentView.backgroundColor = UIColor.clearColor()
            }
            return loadMoreCell!


        }
        else
         {
        
            var cell = tableView.dequeueReusableCellWithIdentifier("identify", forIndexPath: indexPath) as HWBrokerCell
            if brokerDataArr.count > 0
            {
                let model = brokerDataArr[indexPath.row]
                cell.nameLabel!.text = model.brokerName
                cell.telLabel?.text = model.phone
            }
            cell.contentView.drawBottomLine()
            cell.backgroundColor = UIColor.clearColor()
            cell.contentView.backgroundColor = UIColor.clearColor()
            return cell

        }
        
        
    }
    
     func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        tableView.deselectRowAtIndexPath(indexPath, animated: true)
        if indexPath.row != brokerDataArr.count
        {
            if myfunc != nil
            {
                let model = brokerDataArr[indexPath.row]
                myfunc!(model)
            }
        }
        
    }
//MARK:---aciton
    //增加门店
    func addShopClick() -> Void
    {
        MobClick.event("Addstore_click")//埋点
        if (delegate != nil && delegate?.respondsToSelector("addshopBtnClick") != false)
        {
            delegate?.addshopBtnClick()
        }

    }
    //增加经纪人
    func addBrokerBtnClick(hwSection: Int) {
        
        let model = dataArr[hwSection] as HWShopAdminHeaderModel
        currentSelectHeader = hwSection
        if (delegate != nil && delegate?.respondsToSelector("addBrokerClik:") != false)
        {
            delegate?.addBrokerClik(model )
        }

        
    }
// MARK:---添加经纪人和门店成功成功
    func refreshTable()
    {
        queryListData()
        headerControlClick(currentSelectHeader)
    }
    
    func headerControlClick(hwSection: Int) {
        
        for i in 0 ..< dataArr.count
        {
            var model = dataArr[i] as HWShopAdminHeaderModel
            if i != hwSection
            {
                model.groupIsOpen = false
            }
        }
        //请求数据
        /*
        入参：storeId=1
        pageNumber=1
        pageSize=10
        */
        currentSelectHeader = hwSection
        if isLoadMore == false
        {
            brokerCurrentPage = 1
            self.lastPage = false
        }
        Utility.showMBProgress(self, _message: "加载中")
        let shopModel = dataArr[hwSection] as HWShopAdminHeaderModel
        let param = NSMutableDictionary()
        param.setPObject(shopModel.id, forKey: "storeId")
        param.setPObject("\(self.brokerCurrentPage)", forKey: "pageNumber")
        param.setPObject("10", forKey: "pageSize")
        
        var manager = HWHttpRequestOperationManager.baseManager()
        manager.postHttpRequest(kGetPartnerBrokerList, parameters: param, queue: nil, success: { (responseObject) -> Void in
           Utility.hideMBProgress(self)
            if self.brokerCurrentPage == 1
            {
                self.brokerDataArr.removeAll(keepCapacity: true)
                
            }

            if self.lastPage == false
            {
                self.brokerCurrentPage++
            }
            let tempArr:NSArray = responseObject.objectForKey("data") as NSArray
            if (tempArr.count < kPageCount)
            {
                self.lastPage = true

            }
            for item in tempArr
            {
                let brokerDic = item as NSDictionary
                var brokerModel = HWBrokerModel(dict: brokerDic, hwSection: hwSection)
                brokerModel.hwSection = hwSection
                self.brokerDataArr.append(brokerModel)
            }
            self.baseTable.reloadData()
            }) { (code, error) -> Void in
                Utility.hideMBProgress(self)
                Utility.showToastWithMessage(error, _view:  shareAppDelegate.window!)
            
        }
        
        isLoadMore = false
        self.baseTable.reloadData()

    }
//MARK:---请求数据
    override func queryListData()
    {
//        Utility.showMBProgress(shareAppDelegate.window!, _message: "加载中")
        var manager = HWHttpRequestOperationManager.baseManager()
        var params = NSMutableDictionary()
        params.setPObject(HWUserLogin.currentUserLogin().key, forKey: "key")
//        println("key === \(HWUserLogin.currentUserLogin().key)")
        manager.postHttpRequest(kGetAdminInfo, parameters: params, queue: nil, success: { (responseObject) -> Void in
//            Utility.hideMBProgress( shareAppDelegate.window!)
            let dic = responseObject.objectForKey("data") as? NSDictionary
            self.dataArr.removeAllObjects()
            let tempArray = dic!.objectForKey("partnerStoreList") as NSArray
            for item in tempArray
            {
                let dataDic = item as NSDictionary
                let model = HWShopAdminHeaderModel(dic: dataDic)
                self.dataArr.addObject(model)
            }
            self.adminInfoModel = HWAdminInfoModel(dic: dic!)
            self.baseTable.reloadData()
            self.doneLoadingTableViewData()

        }) { (code, error) -> Void in
//            Utility.hideMBProgress( shareAppDelegate.window!)
            Utility.showToastWithMessage(error, _view: self)
            
        }
    }
    func loadMoreBtnClick()
    {
        isLoadMore = true
        headerControlClick(currentSelectHeader)
        
    }
    
    required init(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
}
