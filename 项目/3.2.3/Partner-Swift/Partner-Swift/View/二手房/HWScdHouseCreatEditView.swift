//
//  HWScdHouseCreatEditView.swift
//  Partner-Swift
//
//  Created by niedi on 15/2/27.
//  Copyright (c) 2015年 caijingpeng.haowu. All rights reserved.
//
//  功能描述：二手房房源发布\编辑 mainView
//
//  修改记录：
//      姓名         日期               修改内容
//      聂迪      2015-02-26           UI、数据请求及功能逻辑实现
//

import UIKit


protocol HWScdHouseCreatEditViewDelegate: NSObjectProtocol
{
    func delegatePushVC(VC: HWBaseViewController)   //房源发布跳转选择小区
    func delegatePopToDetailVC()    //房源编辑跳转详情
}

class HWScdHouseCreatEditView: HWBaseRefreshView, HWScdHouseCEditCellDelegate, UIPickerViewDelegate, UIPickerViewDataSource, HWScdHouVillageChoiceDelegate,UITextViewDelegate
{
    //MARK: 成员变量
    var _isCreat: CreatOrEdit?
    var isMyHouse: Bool = false //是否是我的房店进的发布
    var _model: HWScdHouseDetailModel!
    weak var delegate: HWScdHouseCreatEditViewDelegate!
    var _currentRow: Int!
    let PickViewTag: Int! = 1101
    var lastContentOffest: CGPoint!
    var isPickViewHasHidden: Bool!
    var isDruging: Bool! 
    var detailTextFiled:UITextView!
//    var copyForModelPrice: NSString! = "0"
    
    
    //MARK: init方法
    init(frame: CGRect, isCreat:CreatOrEdit, model: HWScdHouseDetailModel)
    {
        super.init(frame: frame)
        _isCreat = isCreat
        self.creatTableViewfootView()
        self.setIsNeedHeadRefresh(false)
        self.isPickViewHasHidden = true
        self.isDruging = false
        self.lastContentOffest = CGPointMake(0, 0)
        
        _model = model
        if(_isCreat == CreatOrEdit.EditConfig)
        {
            var priceFloat = (_model.price as NSString).doubleValue
            var priceStr: NSString = NSString(format:"%.2f",priceFloat / 10000.0)
            if(priceStr.length >= 4)
            {
                var tmpStr = priceStr.substringWithRange(NSMakeRange(priceStr.length - 3, 3))
                if(tmpStr == ".00")
                {
                    priceStr = priceStr.substringToIndex(priceStr.length - 3)
                }
            }
            _model.price = priceStr
            
        }
        
        _currentRow = -1
    }
    
    //MARK: 保存修改 上传
    override func queryListData()
    {
        /*URL:myStore/editHouses.do
        入参：
        key:*** --用户key
        id:***, -二手房id
        housesOwnerName:***, -业主名字
        housesOwnerPhone:***, -业主电话
        sex:***, --业主性别
        buildingNo:***, --楼号
        houseNo:***, --门牌
        propertyRights:***, --产权
        years:***, --年代
        toward:***, --朝向
        type:***, --类型
        decorate:***, --装修
        sign:***, --标签
        title:***, --标题
        price:***, --价格
        proportion:***, --面积
        roomCount:***, --几室
        hallCount:***, --几厅
        roomType:***, --户型
        toiletCount:***, --卫生间
        floor:***, --楼层
        floorSum:***, --共几层
        出参：
        {"detail":"请求数据成功!","status":"1","data":"房源编辑成功"} */
        Utility.hideMBProgress(self)
        Utility.showMBProgress(self, _message: "上传中")
        
        let manager = HWHttpRequestOperationManager.baseManager()
        var param = NSMutableDictionary()
        
        param.setPObject(HWUserLogin.currentUserLogin().key, forKey: "key")
        param.setPObject(_model.scdHandHousesId, forKey: "id")
        if(_model.title == "")
        {
            param.setPObject(_model.villageName, forKey: "title")
        }
        else
        {
            param.setPObject(_model.title, forKey: "title")
        }
        param.setPObject(_model.buildingNo, forKey: "buildingNo")
        param.setPObject(_model.houseNo, forKey: "houseNo")
        var priceFloat = (_model.price as NSString).doubleValue
        param.setPObject(NSString(format:"%.2f",priceFloat * 10000.0), forKey: "price")
        param.setPObject(_model.area, forKey: "proportion")
        param.setPObject(_model.propertyRights, forKey: "propertyRights")
        param.setPObject(_model.years, forKey: "years")
        param.setPObject(_model.type, forKey: "type")
        param.setPObject(_model.roomCount, forKey: "roomCount")
        param.setPObject(_model.hallCount, forKey: "hallCount")
        param.setPObject(_model.toiletCount, forKey: "toiletCount")
        param.setPObject(_model.floor, forKey: "floor")
        param.setPObject(_model.floorSum, forKey: "floorSum")
        param.setPObject(_model.toward, forKey: "toward")
        param.setPObject(_model.decorate, forKey: "decorate")
        param.setPObject(_model.name, forKey: "housesOwnerName")
        param.setPObject(_model.phone, forKey: "housesOwnerPhone")
        param.setPObject(_model.sex, forKey: "sex")
        
        var tmpStr = ""
        for var i = 0; i < _model.sign.count; i++
        {
            tmpStr = "\(tmpStr)\(_model.sign[i]),"
        }
        if(countElements(tmpStr) > 0)
        {
            
            tmpStr = tmpStr.substringToIndex(advance(tmpStr.endIndex, -1))
        }
        param.setPObject(tmpStr, forKey: "sign")
        
        manager.postHttpRequest(KScdHouEdit, parameters: param, queue: nil, success: { (responseObject) -> Void in
            
            Utility.hideMBProgress(self)
            Utility.showToastWithMessage("编辑成功", _view: self)
            self.delegate.delegatePopToDetailVC()
            
            
            }) { (code, error) -> Void in
                
                Utility.hideMBProgress(self)
                
                Utility.showToastWithMessage(error, _view: self)
        }
    }
    
    
    //MARK: 创建 下一步 或 保存修改按钮
    private func creatTableViewfootView()
    {
        var footView: UIView = UIView(frame: CGRectMake(0, 0, kScreenWidth, 85))
        footView.backgroundColor = UIColor.clearColor()
        
        var nxtBtn: UIButton = UIButton.buttonWithType(UIButtonType.Custom) as UIButton
        nxtBtn.frame = CGRectMake(15, 20, kScreenWidth - 15 * 2, 45)
        nxtBtn.layer.cornerRadius = 3
        nxtBtn.clipsToBounds = true
        nxtBtn.titleLabel?.font = Define.font(TF_Btn_Title_19)
        nxtBtn.setBackgroundImage(Utility.imageWithColor(CD_Btn_MainColor, _size: nxtBtn.frame.size), forState: UIControlState.Normal)
        nxtBtn.addTarget(self, action: "saveOrNextStepBtnClick", forControlEvents: UIControlEvents.TouchUpInside)
        footView.addSubview(nxtBtn)
        
        if(_isCreat == CreatOrEdit.Creat)
        {
            nxtBtn.setTitle("下一步", forState: UIControlState.Normal)
        }
        else
        {
            nxtBtn.setTitle("下一步", forState: UIControlState.Normal)
        }
        
        baseTable.tableFooterView = footView
    }
    
    //MARK: 下一步 或 保存修改按钮 点击事件
    @objc private func saveOrNextStepBtnClick()
    {
        if(_isCreat == CreatOrEdit.Creat)
        {
            MobClick.event("SubmitSCDhouse-next_click")//maidian_3.0_niedi
        }
        
        //小区、价格、面积、类型、户型、楼层、朝向、装修必填
        //提交后，标题不填默认为小区名
        //点击下一步对以上进行验证，若有误进行提示
        self.hidePickAnimation(self.viewWithTag(PickViewTag)?)
        self.endEditing(true)
        
        if(_model.villageName == "")
        {
            Utility.showToastWithMessage("小区必填", _view: self)
            return
        }
        if(countElements(_model.title!) > 30)
        {
            Utility.showToastWithMessage("标题限制30字以下", _view: self)
            return
        }
        
        if(_model.price == "")
        {
            Utility.showToastWithMessage("价格必填", _view: self)
            return
        }
        else
        {
            var priceFloat = (_model.price as NSString).doubleValue
            if(priceFloat <= 0)
            {
                Utility.showToastWithMessage("请输入正确的价格", _view: self)
                return
            }
        }
        if(_model.area == "")
        {
            Utility.showToastWithMessage("面积必填", _view: self)
            return
        }
        if(_model.type == "")
        {
            Utility.showToastWithMessage("类型必填", _view: self)
            return
        }
        if(_model.roomCount == "")
        {
            Utility.showToastWithMessage("户型必填", _view: self)
            return
        }
        else
        {
            if(_model.roomCount == "0" && _model.hallCount == "0" && _model.toiletCount == "0")
            {
                Utility.showToastWithMessage("请输入正确的户型", _view: self)
                return
            }
        }
        if(_model.floor == "")
        {
            Utility.showToastWithMessage("楼层必填", _view: self)
            return
        }
        if(_model.toward == "")
        {
            Utility.showToastWithMessage("朝向必填", _view: self)
            return
        }
        if(_model.decorate == "")
        {
            Utility.showToastWithMessage("装修必填", _view: self)
            return
        }
        if(_model.phone != "")
        {
            if(!Utility.validateMobile(_model.phone))
            {
                Utility.showToastWithMessage("手机号码有误,请修改或删除", _view: self)
                return
            }
        }
        
        if(_isCreat == CreatOrEdit.Creat)
        {
            var step2VC: HWScdHouseCreatStep2VC = HWScdHouseCreatStep2VC()
            step2VC._isCreat = CreatOrEdit.Creat
            step2VC._model = _model
            step2VC.isMyHouse = isMyHouse
            delegate.delegatePushVC(step2VC)
        }
        else
        {
            //保存修改
            //self.queryListData()
            
            var step2VC: HWScdHouseCreatStep2VC = HWScdHouseCreatStep2VC()
            step2VC._isCreat = CreatOrEdit.EditConfig
            step2VC._model = _model
            step2VC.isMyHouse = isMyHouse  
            delegate.delegatePushVC(step2VC)
        }
    }
    
    //MARK: tableView 代理
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int
    {
        return 22
    }
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell
    {
        if(indexPath.row == 0 || indexPath.row == 9 || indexPath.row == 13 || indexPath.row == 20 || indexPath.row == 21)
        {
            let cellId1 = "cellId1"
            var cell: HWBaseTableViewCell? = tableView.dequeueReusableCellWithIdentifier(cellId1) as? HWBaseTableViewCell
            
            if(cell == nil)
            {
                cell = HWBaseTableViewCell(style: UITableViewCellStyle.Default, reuseIdentifier: cellId1)
                cell?.backgroundColor = UIColor.clearColor()
                cell?.contentView.backgroundColor = UIColor.clearColor()
                
                var lab: UILabel! = UILabel(frame: CGRectMake(15, 5, kScreenWidth - 2 * 15, 35))
                lab.textColor = CD_Txt_Color_99
                lab.font = Define.font(TF_13)
                lab.numberOfLines = 0
                lab.tag = 323
                cell?.addSubview(lab)
            }
            
            var lab: UILabel! = cell?.viewWithTag(323) as UILabel
            if(indexPath.row == 13)
            {
                lab.text = "业主姓名、电话，房源楼号、门牌信息仅供房源管理使用，仅自己可见！"
            }
            else if indexPath.row == 20
            {
                lab.frame = CGRectMake(15, 0, kScreenWidth, 35)
                lab.text = "房源描述"
            }
            else if indexPath.row == 21
            {
                detailTextFiled = UITextView(frame: CGRectMake(0, 0, kScreenWidth, 110))
                detailTextFiled.delegate = self
                detailTextFiled.font = Define.font(15)
                detailTextFiled.textColor = CD_Txt_Color_99
                if _isCreat ==  CreatOrEdit.Creat
                {
                  detailTextFiled.text = "  请为你的房源添加相应描述"
                }
                
                else
                {
                    detailTextFiled.text = _model.housesDescription
                }
                cell?.addSubview(detailTextFiled)
                // lab.text = "请为你的房源添加相应描述"
            }
            else
            {
                lab.text = ""
            }
            cell?.contentView.drawBottomLine()
            return cell!
        }
        else
        {
            let cellId2: String = "cellId2"
            var cell: HWScdHouseCreatEditCell? = tableView.dequeueReusableCellWithIdentifier(cellId2) as? HWScdHouseCreatEditCell
            if(cell == nil)
            {
                cell = HWScdHouseCreatEditCell(style: UITableViewCellStyle.Default, reuseIdentifier: cellId2)
            }
            cell?.contentView.drawBottomLine()
            
            cell?.setContent(_model, index: indexPath.row)
            cell?.delegate = self
            
            return cell!
        }
    }
    
    func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat
    {
        if(indexPath.row == 9 || indexPath.row == 0)
        {
            return 10
        }
        else if indexPath.row == 20
        {

            return 35
        }
        else if indexPath.row == 21
        {
            
            return 110
        }
        else if indexPath.row == 19
        {
            var j:Int = 0;
            var distanceTemp:CGFloat = 0;
            var selViewArr: NSMutableArray! = NSMutableArray()
            
            for(var i = 0; i < HWScdHouConfigCenter.defaultCenter().sign_C.count; i++)
            {
                var selView: HWSelectionView = HWSelectionView(title: HWScdHouConfigCenter.defaultCenter().sign_C[i] as NSString)
                selViewArr.addObject(selView)
            }
            var distance: CGFloat = 0
            
           
            for(var i = 0; i < HWScdHouConfigCenter.defaultCenter().sign_C.count; i++)
            {
                
                var tmpView: HWSelectionView = selViewArr[i] as HWSelectionView
                 distanceTemp = distance +  tmpView.frame.width;
                if(distanceTemp > kScreenWidth)
                {
                    j++;
                    distance = 0;
                }
                 distance += tmpView.frame.width
            }
            var m:Int = 80+25*j;
            return CGFloat(m);

        }
        else
        {
            return 45
        }
    }
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath)
    {//1.小区,2.标题,3.楼号,4.门牌,5.价格,6.面积,7.产权,8.年代,10.业主姓名,11.联系电话,12.性别,14.类型,15.户型,16.楼层,17.朝向,18.装修,19.标签
        if(_model.status == "putup" && _model.sourceWay != "")
        {
            return;
        }
        if(indexPath.row == 0 || indexPath.row == 9 || indexPath.row == 13 || indexPath.row == 20)
        {
            //空cell
        }
        else if(indexPath.row == 1)
        {
            if(_currentRow != indexPath.row)
            {
                _currentRow = indexPath.row
                self.endEditing(true)
                self.hidePickAnimation(self.viewWithTag(PickViewTag)?)
            }
            if(_isCreat == CreatOrEdit.EditConfig)
            {
                Utility.showToastWithMessage("小区不可编辑", _view: self)
                return
            }
            var villageCVC: HWScdHouseVillageChoiceVC = HWScdHouseVillageChoiceVC()
            villageCVC.delegate = self
            delegate.delegatePushVC(villageCVC)
        }
        else if(indexPath.row == 14 || indexPath.row == 15 || indexPath.row == 16 || indexPath.row == 17 || indexPath.row == 18 || indexPath.row == 21)
        {
            //_currentRow:1 选择小区、 14 房屋类型、 15 户型、 16 楼层、 17 朝向、 18 装修
            if(_currentRow != indexPath.row)
            {
                _currentRow = indexPath.row
                self.endEditing(true)
                self.showPickView()
            }
        }
        else
        {
            if(_currentRow != indexPath.row)
            {
                _currentRow = indexPath.row
                self.hidePickAnimation(self.viewWithTag(PickViewTag)?)
            }
            
            if(indexPath.row == 12 || indexPath.row == 19)
            {
                self.hidePickAnimation(self.viewWithTag(PickViewTag)?)
                self.endEditing(true)
            }
            else
            {
                var cell: HWScdHouseCreatEditCell! = baseTable.cellForRowAtIndexPath(indexPath) as HWScdHouseCreatEditCell
                cell.textField.becomeFirstResponder()
                baseTable.scrollToRowAtIndexPath(NSIndexPath(forRow: _currentRow, inSection: 0), atScrollPosition: UITableViewScrollPosition.Top, animated: true)
            }
        }
        
    }
    
    //MARK: 显示PickView
    func showPickView()
    {
        var pickBackview: UIView? = self.viewWithTag(PickViewTag)
        if(pickBackview != nil)
        {
            pickBackview?.removeFromSuperview()
        }
        
        pickBackview = UIView(frame: CGRectMake(0, contentHeight, kScreenWidth, 280))
        pickBackview?.backgroundColor = CD_WhiteColor
        pickBackview?.tag = PickViewTag
        self.addSubview(pickBackview!)
        
        var pickView: UIPickerView = UIPickerView()
        pickView.delegate = self
        pickView.dataSource = self
        pickView.showsSelectionIndicator = true
        pickBackview?.addSubview(pickView)
        
        var confirmBtn: UIButton! = UIButton.buttonWithType(UIButtonType.Custom) as UIButton
        confirmBtn.frame = CGRectMake(15, pickView.frame.height + 15, kScreenWidth - 30, 40)
        confirmBtn.layer.cornerRadius = 5
        confirmBtn.setTitle("确认", forState: UIControlState.Normal)
        confirmBtn.setBackgroundImage(Utility.imageWithColor(CD_MainColor, _size: confirmBtn.frame.size), forState: UIControlState.Normal)
        confirmBtn.addTarget(self, action: "confirmBtnClick", forControlEvents: UIControlEvents.TouchUpInside)
        pickBackview?.addSubview(confirmBtn)
        
        self.showPickAnimation(pickBackview!)
        
        if(_currentRow == 14)
        {
            //类型 residence:住宅 villa:别墅 commercial:商住
            
            if(_model.type == "")
            {
                _model.type = HWScdHouConfigCenter.defaultCenter().typeArr_E.pObjectAtIndex(0) as String
            }
            
            for var i = 0; i < HWScdHouConfigCenter.defaultCenter().typeArr_E.count; i++
            {
                if(_model.type == HWScdHouConfigCenter.defaultCenter().typeArr_E.pObjectAtIndex(i) as String)
                {
                    pickView.selectRow(i, inComponent: 0, animated: true)
                }
            }
        }
        else if (_currentRow == 15)
        {//户型
            if(_model.roomCount == "")
            {
                _model.roomCount = "0"
            }
            if(_model.hallCount == "")
            {
                _model.hallCount = "0"
            }
            if(_model.toiletCount == "")
            {
                _model.toiletCount = "0"
            }
            pickView.selectRow(_model.roomCount!.toInt()!, inComponent: 0, animated: true)
            pickView.selectRow(_model.hallCount!.toInt()!, inComponent: 1, animated: true)
            pickView.selectRow(_model.toiletCount!.toInt()!, inComponent: 2, animated: true)
        }
        else if (_currentRow == 16)
        {//楼层
            if(_model.floor == "")
            {
                _model.floor = "1"
            }
            if(_model.floorSum == "")
            {
                _model.floorSum = "1"
            }
            pickView.selectRow(_model.floorSum!.toInt()! - 1, inComponent: 1, animated: true)
            pickView.selectRow(_model.floor!.toInt()! - 1, inComponent: 0, animated: true)
        }
        else if(_currentRow == 17)
        {//朝向 south:朝南 north:朝北 east:朝东 west:朝西 east_west:东西向 south_north: 南北通透
            if(_model.toward == "")
            {
                _model.toward = HWScdHouConfigCenter.defaultCenter().towardArr_E.pObjectAtIndex(0) as String
            }
            for var i = 0; i < HWScdHouConfigCenter.defaultCenter().towardArr_E.count; i++
            {
                if(_model.toward == HWScdHouConfigCenter.defaultCenter().towardArr_E.pObjectAtIndex(i) as String)
                {
                    pickView.selectRow(i, inComponent: 0, animated: true)
                }
            }
        }
        else if(_currentRow == 18)
        {//装修 workblank:毛坯 simple:简装修 refined:精装修 luxury:豪华装修
            if(_model.decorate == "")
            {
                _model.decorate = HWScdHouConfigCenter.defaultCenter().decorateArr_E.pObjectAtIndex(0) as String
            }
            for var i = 0; i < HWScdHouConfigCenter.defaultCenter().decorateArr_E.count; i++
            {
                if(_model.decorate == HWScdHouConfigCenter.defaultCenter().decorateArr_E.pObjectAtIndex(i) as String)
                {
                    pickView.selectRow(i, inComponent: 0, animated: true)
                }
            }
        }
        self.baseTable.reloadData()
    }
    
    //MARK: pickView “确定” 按钮点击事件
     @objc private func confirmBtnClick()
    {
        self.hidePickAnimation(self.viewWithTag(PickViewTag)!)
        _currentRow = -1
    }
    
    //MARK: pickView 动画
    private func showPickAnimation(pickBackView: UIView)
    {
        self.endEditing(true)
        weak var weakSelf: HWScdHouseCreatEditView! = self
        
        UIView.animateWithDuration(0.3, animations: { () -> Void in
            pickBackView.frame = CGRectMake(0, contentHeight - pickBackView.frame.size.height, pickBackView.frame.size.width, pickBackView.frame.size.height)
            weakSelf.baseTable.frame = CGRectMake(0, 0, kScreenWidth, contentHeight - pickBackView.frame.size.height)
            }) { (finished) -> Void in
                weakSelf.baseTable.scrollToRowAtIndexPath(NSIndexPath(forRow: weakSelf._currentRow, inSection: 0), atScrollPosition: UITableViewScrollPosition.Middle, animated: true)
        }
    }
    
    private func hidePickAnimation(pickBackView: UIView?)
    {
        if(pickBackView != nil)
        {
            if( self.isPickViewHasHidden == true)
            {
                self.isPickViewHasHidden = false
                weak var weakSelf: HWScdHouseCreatEditView! = self
                UIView.animateWithDuration(0.3, animations: { () -> Void in
                    pickBackView!.frame = CGRectMake(0, contentHeight, pickBackView!.frame.size.width, pickBackView!.frame.size.height)
                    weakSelf.baseTable.frame = CGRectMake(0, 0, kScreenWidth, contentHeight)
                    }) { (finished) -> Void in
                        pickBackView!.removeFromSuperview()
                        self.isPickViewHasHidden = true
                }
            }
        }
    }
    
    //MARK:  键盘动画
    @objc private func KeyboardShowAnimation()
    {
        baseTable.scrollToRowAtIndexPath(NSIndexPath(forRow: _currentRow, inSection: 0), atScrollPosition: UITableViewScrollPosition.Top, animated: true)
    }
    
    //MARK: scrollView 代理 下拉收键盘
    override func scrollViewDidScroll(scrollView: UIScrollView)
    {
        if(self.isDruging == true)//lastContentOffest.y > scrollView.contentOffset.y &&
        {
            self.endEditing(true)
            self.isDruging = false
            _currentRow = -1
        }
        else
        {
//            lastContentOffest.y = scrollView.contentOffset.y
        }
    }
    
    func scrollViewWillBeginDragging(scrollView: UIScrollView)
    {
        lastContentOffest = scrollView.contentOffset
        if(self.viewWithTag(PickViewTag) != nil)
        {
            self.hidePickAnimation(self.viewWithTag(PickViewTag)!)
        }
        self.isDruging = true
    }
    
    //MARK: pickView 代理
    func numberOfComponentsInPickerView(pickerView: UIPickerView) -> Int
    {
        //_currentRow:1 选择小区、 14 房屋类型、 15 户型、 16 楼层、 17 朝向、 18 装修
        if(_currentRow == 15)
        {
            return 3
        }
        else if(_currentRow == 16)
        {
            return 2
        }
        return 1
    }
    
    func pickerView(pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int
    {
        //_currentRow:1 选择小区、 14 房屋类型、 15 户型、 16 楼层、 17 朝向、 18 装修
        switch _currentRow {
        case 14:
            return HWScdHouConfigCenter.defaultCenter().typeArr_E.count
        case 15:
            return 10
        case 16:
            return 99
        case 17:
            return HWScdHouConfigCenter.defaultCenter().towardArr_E.count
        case 18:
            return HWScdHouConfigCenter.defaultCenter().decorateArr_E.count
        default:
            return 1
        }
    }
    
    func pickerView(pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String!
    {
        //_currentRow:1 选择小区、 14 房屋类型、 15 户型、 16 楼层、 17 朝向、 18 装修
        switch _currentRow {
        case 14:
            return HWScdHouConfigCenter.defaultCenter().typeArr_C.pObjectAtIndex(row) as String
        case 15:
            if (component == 0)
            {
                return "\(row)室"
            }
            else if (component == 1)
            {
                return "\(row)厅"
            }
            else{
                return "\(row)卫"
            }
        case 16:
            if (component == 0)
            {
                return "\(row + 1)楼"
            }
            else
            {
                return "共\(row + 1)层"
            }
        case 17:
            return HWScdHouConfigCenter.defaultCenter().towardArr_C.pObjectAtIndex(row) as String
        case 18:
            return HWScdHouConfigCenter.defaultCenter().decorateArr_C.pObjectAtIndex(row) as String
        default:
            return ""
        }
    }
    
    func pickerView(pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int)
    {
        if(_currentRow == 14)
        {//类型 residence:住宅 villa:别墅 commercial:商住
            
            _model.type = HWScdHouConfigCenter.defaultCenter().typeArr_E.pObjectAtIndex(row) as String
        }
        else if(_currentRow == 15)
        {//户型
            if(component == 0)
            {
                _model.roomCount = "\(row)"
            }
            if(component == 1)
            {
                _model.hallCount = "\(row)"
            }
            if(component == 2)
            {
                _model.toiletCount = "\(row)"
            }
        }
        else if(_currentRow == 16)
        {//楼层
            if(component == 0)
            {
                _model.floor = "\(row + 1)"
                if(_model.floorSum!.toInt()! < _model.floor!.toInt())
                {
                    _model.floorSum = _model.floor
                    pickerView.selectRow(row, inComponent: 1, animated: true)
                }
            }
            else if(component == 1)
            {
                _model.floorSum = "\(row + 1)"
                if(_model.floorSum!.toInt()! < _model.floor!.toInt())
                {
                    _model.floorSum = _model.floor
                    pickerView.selectRow(_model.floor!.toInt()! - 1, inComponent: 1, animated: true)
                }
            }
            
            //            [dependentPicker reloadComponent:1];
            //重新载入第二个选择器
        }
        else if(_currentRow == 17)
        {//朝向 south:朝南 north:朝北 east:朝东 west:朝西 east_west:东西向 south_north: 南北通透
            
            _model.toward = HWScdHouConfigCenter.defaultCenter().towardArr_E.pObjectAtIndex(row) as String
        }
        else if(_currentRow == 18)
        {//装修 workblank:毛坯 simple:简装修 refined:精装修 luxury:豪华装修
            
            _model.decorate = HWScdHouConfigCenter.defaultCenter().decorateArr_E.pObjectAtIndex(row) as String
        }
        self.baseTable.reloadData()
    }
    
    //MARK: HWScdHouseCEditCell 代理 Method
    
    func cellTextEdit(index: Int, txt: String)
    {//1.小区,2.标题,3.楼号,4.门牌,5.价格,6.面积,7.产权,8.年代,10.业主姓名,11.联系电话,12.性别,14.类型,15.户型,16.楼层,17.朝向,18.装修,19.标签
        if(index == 2)
        {
            _model.title = txt
        }
        else if(index == 3)
        {
            _model.buildingNo = txt
        }
        else if(index == 4)
        {
            _model.houseNo = txt
        }
        else if(index == 5)
        {
            _model.price = txt
        }
        else if(index == 6)
        {
            _model.area = txt
        }
        else if(index == 7)
        {
            _model.propertyRights = txt
        }
        else if(index == 8)
        {
            _model.years = txt
        }
        else if(index == 10)
        {
            _model.name = txt
        }
        else if(index == 11)
        {
            _model.phone = txt
        }
    }
    
    func cellClickForChoice(index: Int, type: Int)
    {
        self.hidePickAnimation(self.viewWithTag(PickViewTag)?)
        self.endEditing(true)
        if(index == 12)
        {
            if(type == 0)
            {
                _model.sex = "0"
            }
            else
            {
                _model.sex = "1"
            }
        }
        else if(index == 19)
        {
            var tmpMArr: NSMutableArray = NSMutableArray(array: _model.sign)
            var tmpStr = HWScdHouConfigCenter.defaultCenter().sign_E.pObjectAtIndex(type) as String
            tmpMArr.addObject(tmpStr)
            
            _model.sign = tmpMArr
        }
    }
    
    func cellClickForDeChoice(index: Int, type: Int)
    {
        self.hidePickAnimation(self.viewWithTag(PickViewTag)?)
        self.endEditing(true)
        var tmpMArr: NSMutableArray = NSMutableArray(array: _model.sign)
        var vtype = HWScdHouConfigCenter.defaultCenter().sign_E.count - type - 1
        var tmpStr = HWScdHouConfigCenter.defaultCenter().sign_E.pObjectAtIndex(vtype) as String
        tmpMArr.removeObject(tmpStr)
        _model.sign = tmpMArr
    }
    
    func cellKeyBoardReturnClick(index: Int)
    {//1.小区,2.标题,3.楼号,4.门牌,5.价格,6.面积,7.产权,8.年代,10.业主姓名,11.联系电话,12.性别,14.类型,15.户型,16.楼层,17.朝向,18.装修,19.标签
        var cell: HWScdHouseCreatEditCell!
        if(index == 2 || index == 3 || index == 4 || index == 5 || index == 6 || index == 7 || index == 10)
        {
            cell = baseTable.cellForRowAtIndexPath(NSIndexPath(forRow: index, inSection: 0)) as HWScdHouseCreatEditCell
            cell.textField.resignFirstResponder()
            
            cell = baseTable.cellForRowAtIndexPath(NSIndexPath(forRow: index + 1, inSection: 0)) as HWScdHouseCreatEditCell
            cell.textField.becomeFirstResponder()
            _currentRow = index + 1
        }
        else if(index == 8)
        {
            cell = baseTable.cellForRowAtIndexPath(NSIndexPath(forRow: index, inSection: 0)) as HWScdHouseCreatEditCell
            cell.textField.resignFirstResponder()
            
            cell = baseTable.cellForRowAtIndexPath(NSIndexPath(forRow: index + 2, inSection: 0)) as HWScdHouseCreatEditCell
            cell.textField.becomeFirstResponder()
            _currentRow = index + 2
        }
    }
    
    func cellTextFieldBecomeFirstResponse(index: Int)
    {
        _currentRow = index
        if(self.viewWithTag(PickViewTag) != nil)
        {
            self.hidePickAnimation(self.viewWithTag(PickViewTag)!)
        }
        self.KeyboardShowAnimation()
    }
    
    //MARK: HWScdHouVillageChoiceDelegate 选择小区回调方法
    func clickedModel(model: HWScdHouVillageChoiceModel)
    {
        _model.villageId = model.villageId
        _model.villageName = model.villageName
        baseTable.reloadData()
    }
    // MARK:textViwDelegate
    func textViewDidBeginEditing(textView: UITextView)
    {
        
          textView.text = ""
          textView .becomeFirstResponder()
          _currentRow = 21
        weak var weakSelf: HWScdHouseCreatEditView! = self
        UIView.animateWithDuration(0.3, animations: { () -> Void in
        weakSelf.baseTable.frame = CGRectMake(0, 0, kScreenWidth, contentHeight - 216)
            }) { (finished) -> Void in
                weakSelf.baseTable.scrollToRowAtIndexPath(NSIndexPath(forRow: 21, inSection: 0), atScrollPosition: UITableViewScrollPosition.Top, animated: true)
        }

       
        
        
    }

    func textViewDidEndEditing(textView: UITextView)
    {
        _model.housesDescription = textView.text
        weak var weakSelf: HWScdHouseCreatEditView! = self
        UIView.animateWithDuration(0.3, animations: { () -> Void in
            weakSelf.baseTable.frame = CGRectMake(0, 0, kScreenWidth, contentHeight )
            }) { (finished) -> Void in
                
        }
        

    }
    
    //MARK: 其他
    required init(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
