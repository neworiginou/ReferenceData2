//
//  HWScdHouseCreatEditCell.swift
//  Partner-Swift
//
//  Created by niedi on 15/2/27.
//  Copyright (c) 2015年 caijingpeng.haowu. All rights reserved.
//
//  功能描述：二手房房源发布\编辑 Cell
//
//  修改记录：
//      姓名         日期               修改内容
//      聂迪      2015-02-26           UI及简单功能实现
//

import UIKit

enum scdHouseCellType
{
    case OnlyFidld //仅输入框
    case Normal   //输入框 右文字
    case HasJmpImg //输入 右文字 箭头
    case LockCase  //输入 右文字 锁
    case SingleChoice //单选 性别
    case MultipleChoice //多选 标签
}

protocol HWScdHouseCEditCellDelegate: NSObjectProtocol
{
    func cellTextEdit(index: Int, txt: String)
    func cellClickForChoice(index: Int, type: Int)
    func cellClickForDeChoice(index: Int, type: Int)
    func cellKeyBoardReturnClick(index: Int)
    func cellTextFieldBecomeFirstResponse(index: Int)
}

class HWScdHouseCreatEditCell: HWBaseTableViewCell, UITextFieldDelegate, HWSelectionViewDelegate
{
    //MARK: 成员变量
    var leftTxtLab: UILabel! //左标签
    var rightTxtLab: UILabel! //右文字标签
    var jmpImg: UIImageView! //右跳转尖角
    var lockImg: UIImageView! //右锁
    var textField: UITextField! //输入框
    
    var titleArr: [String] = ["","小区","标题","楼号","门牌","价格","面积","产权","建成年代","","业主姓名","联系电话","性别","", "类型","户型","楼层","朝向","装修","标签"]
    var _index: Int!
    var _type: scdHouseCellType!
    var _model: HWScdHouseDetailModel!
    weak var delegate: HWScdHouseCEditCellDelegate!
    
    //MARK: init Method
    override init(style: UITableViewCellStyle, reuseIdentifier: String?)
    {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        self.selectionStyle = UITableViewCellSelectionStyle.None
        
        leftTxtLab = UILabel(frame: CGRectMake(15, 0, 80, 45))
        leftTxtLab.font = Define.font(TF_15)
        leftTxtLab.textColor = CD_Txt_Color_00
        self.contentView.addSubview(leftTxtLab)
        
        rightTxtLab = UILabel(frame: CGRectMake(80, 0, kScreenWidth - 80 - 15 - 5, 45))
        rightTxtLab.font = Define.font(TF_15)
        rightTxtLab.textColor = CD_Txt_Color_99
        rightTxtLab.textAlignment = NSTextAlignment.Right
        self.contentView.addSubview(rightTxtLab)
        
        jmpImg = UIImageView(frame: CGRectMake(kScreenWidth - 15 - 8, (45 - 13) / 2, 8, 13))
        jmpImg.image = UIImage(named: "arrow_next")
        self.contentView.addSubview(jmpImg)
        
        lockImg = UIImageView(frame: CGRectMake(kScreenWidth - 15 - 11, (45 - 12) / 2, 10, 12))
        lockImg.image = UIImage(named: "lock2")
        self.contentView.addSubview(lockImg)
        
        textField = UITextField(frame: CGRectMake(80, 0, kScreenWidth - 80 - 60, 45))
        textField.font = Define.font(TF_15)
        textField.textAlignment = NSTextAlignment.Right
        textField.textColor = CD_Txt_Color_99
        textField.delegate = self
//        textField.backgroundColor = UIColor(white: 0.9, alpha: 0.5)
        self.contentView.addSubview(textField)
    }
    
    //MARK: 添加选择器方法
    private func setSelectViewWithArr(titleS: NSArray)
    {
        var distance: CGFloat = 0
        var view: UIView!
        var selViewArr: NSMutableArray! = NSMutableArray()
        
        for view in self.contentView.subviews
        {
            if(view.isKindOfClass(HWSelectionView))
            {
                view.removeFromSuperview()
            }
        }
        
        for(var i = 0; i < titleS.count; i++)
        {
            var selView: HWSelectionView = HWSelectionView(title: titleS[i] as NSString)
            if(_type == scdHouseCellType.SingleChoice)
            {
                selView.allowMore = false
            }
            else
            {
                selView.allowMore = true
            }
            selViewArr.addObject(selView)
        }
        var j:CGFloat = 0;
        for(var i = 0; i < selViewArr.count; i++)
        {
            var tmpView: HWSelectionView = selViewArr[selViewArr.count - 1 - i] as HWSelectionView
            tmpView.frame = CGRectMake(kScreenWidth - distance - tmpView.frame.size.width - 7, 25, tmpView.frame.size.width, tmpView.frame.size.height)
            distance += tmpView.frame.width
            distance += 5
            tmpView.delegate = self
            tmpView.tag = i
            self.contentView.addSubview(tmpView)
        }
    }
    //MARK:创建标签
    func createLabelSelectViewWithArr(titleS: NSArray)
    {
        var distance: CGFloat = 5
        var view: UIView!
        var selViewArr: NSMutableArray! = NSMutableArray()
        
        for view in self.contentView.subviews
        {
            if(view.isKindOfClass(HWSelectionView))
            {
                view.removeFromSuperview()
            }
        }
        
        for(var i = 0; i < titleS.count; i++)
        {
            var selView: HWSelectionView = HWSelectionView(title: titleS[i] as NSString)
            if(_type == scdHouseCellType.SingleChoice)
            {
                selView.allowMore = false
            }
            else
            {
                selView.allowMore = true
            }
            selViewArr.addObject(selView)
        }
        var j:CGFloat = 0;
        var distanceTemp:CGFloat = 0;
        for(var i = 0; i < selViewArr.count; i++)
        {
            var tmpView: HWSelectionView = selViewArr[selViewArr.count - 1 - i] as HWSelectionView
            tmpView.backgroundColor = UIColor.clearColor();
            distanceTemp = distance +  tmpView.frame.width;
            if(distanceTemp > kScreenWidth - 45)
            {
                j++;
                distance = 5
                tmpView.frame = CGRectMake(distance+45, 25 + j*25.0, tmpView.frame.size.width, tmpView.frame.size.height)
            }
            else
            {
                tmpView.frame = CGRectMake(distance+45, 25 + j*25.0, tmpView.frame.size.width, tmpView.frame.size.height)
            }
            distance += tmpView.frame.width + 5
            tmpView.delegate = self
            tmpView.tag = i
            self.contentView.addSubview(tmpView)
        }

    }
    //MARK:设置按钮不能点击
    func setViewUnable()->Void
    {
        self.userInteractionEnabled = false;
    }
    //MARK: 移除选择器方法
    private func clearSelView()
    {
        var view: UIView!
        
        for view in self.contentView.subviews
        {
            if(view.isKindOfClass(HWSelectionView))
            {
                view.removeFromSuperview()
            }
        }
    }
    
    //MARK: 数据实现
    func setContent(model: HWScdHouseDetailModel, index: Int)
    {
        _index = index
        _model = model
        
        if(_model.status == "putup" && _model.sourceWay != "")
        {
            if(index == 2 || index == 5)
            {
                textField.userInteractionEnabled = true;
            }
            else
            {
                textField.userInteractionEnabled = false;
            }
            
        }
        //end
        leftTxtLab.text = titleArr[index]
        
        if(index == 1 || index == 14 || index == 15 || index == 16 || index == 17 || index == 18)
        {
            _type = scdHouseCellType.HasJmpImg
        }
        else if(index == 2 || index == 8)
        {
            _type = scdHouseCellType.OnlyFidld
        }
        else if(index == 3 || index == 4 || index == 10 || index == 11)
        {
            _type = scdHouseCellType.LockCase
        }
        else if(index == 5 || index == 6 || index == 7 )
        {
            _type = scdHouseCellType.Normal
        }
        else if(index == 12)
        {
            _type = scdHouseCellType.SingleChoice
        }
        else if(index == 19)
        {
            _type = scdHouseCellType.MultipleChoice
        }
        self.setCellWithType()
        
        self.setCellForModel()
    }
    
    //MARK: 数据填充
    private func setCellForModel()
    {
        //1.小区,2.标题,3.楼号,4.门牌,5.价格,6.面积,7.产权,8.年代,10.业主姓名,11.联系电话,12.性别,14.类型,15.户型,16.楼层,17.朝向,18.装修,19.标签
        if(_index == 1)
        {//小区
            rightTxtLab.text = _model.villageName
        }
        else if(_index == 2)
        {//标题
            textField.text = _model.title
        }
        else if(_index == 3)
        {//楼号
            textField.text = _model.buildingNo
        }
        else if(_index == 4)
        {//门牌
            textField.text = _model.houseNo
        }
        else if(_index == 5)
        {//价格
            textField.text = _model.price
        }
        else if(_index == 6)
        {//面积
            textField.text = _model.area
        }
        else if(_index == 7)
        {//产权
            textField.text = _model.propertyRights
        }
        else if(_index == 8)
        {//年代
            textField.text = _model.years
        }
        else if(_index == 10)
        {//业主姓名
            textField.text = _model.name
        }
        else if(_index == 11)
        {//联系电话
            textField.text = _model.phone
        }
        else if(_index == 12)
        {//性别 0女，1男
            if(_model.sex == "0")
            {
                self.setSexType(0)
            }
            else if(_model.sex == "1")
            {
                self.setSexType(1)
            }
        }
        else if(_index == 14)
        {//类型 residence:住宅 villa:别墅 commercial:商住
            if(_model.type != "")
            {
                for var i = 0; i < HWScdHouConfigCenter.defaultCenter().typeArr_E.count; i++
                {
                    if(_model.type == HWScdHouConfigCenter.defaultCenter().typeArr_E.pObjectAtIndex(i) as NSString)
                    {
                        rightTxtLab.text = HWScdHouConfigCenter.defaultCenter().typeArr_C.pObjectAtIndex(i) as NSString
                    }
                }
            }
            else
            {
                rightTxtLab.text = ""
            }
        }
        else if(_index == 15)
        {//户型
            var tmpStr: String! = ""
            if(_model.roomCount != "")
            {
                tmpStr = "\(_model.roomCount)室\(_model.hallCount)厅\(_model.toiletCount)卫"
            }
            
            rightTxtLab.text = tmpStr
        }
        else if(_index == 16)
        {//楼层
            var tmpStr: String! = ""
            if(_model.floor != "")
            {
                tmpStr = "\(_model.floor)楼 共\(_model.floorSum)层"
            }
            rightTxtLab.text = tmpStr
        }
        else if(_index == 17)
        {//朝向 south:朝南 north:朝北 east:朝东 west:朝西 east_west:东西向 south_north: 南北通透
            if(_model.toward != "")
            {
                for var i = 0; i < HWScdHouConfigCenter.defaultCenter().towardArr_E.count; i++
                {
                    if(_model.toward == HWScdHouConfigCenter.defaultCenter().towardArr_E.pObjectAtIndex(i) as NSString)
                    {
                        rightTxtLab.text = HWScdHouConfigCenter.defaultCenter().towardArr_C.pObjectAtIndex(i) as NSString
                    }
                }
            }
            else
            {
                rightTxtLab.text = ""
            }
        }
        else if(_index == 18)
        {//装修 workblank:毛坯 simple:简装修 refined:精装修 luxury:豪华装修
            if(_model.decorate != "")
            {
                for var i = 0; i < HWScdHouConfigCenter.defaultCenter().decorateArr_E.count; i++
                {
                    if(_model.decorate == HWScdHouConfigCenter.defaultCenter().decorateArr_E.pObjectAtIndex(i) as NSString)
                    {
                        rightTxtLab.text = HWScdHouConfigCenter.defaultCenter().decorateArr_C.pObjectAtIndex(i) as NSString
                    }
                }
            }
            else
            {
                rightTxtLab.text = ""
            }
        }
        else if(_index == 19)
        {//var sign: NSArray = [] //标签
            if(_model.sign.count != 0)
            {
                for var i = 0; i < _model.sign.count; i++
                {
                    var tmpS = _model.sign.pObjectAtIndex(i) as NSString
                    
                    for var j = 0; j < HWScdHouConfigCenter.defaultCenter().sign_E.count; j++
                    {
                        if(tmpS == HWScdHouConfigCenter.defaultCenter().sign_E.pObjectAtIndex(j) as NSString)
                        {
                            self.setSignSelected(HWScdHouConfigCenter.defaultCenter().sign_E.count - j - 1)
                        }
                    }
                }
            }
        }
    }
    
    //MARK:根据type适应UI
    private func setCellWithType()
    {
        var frame: CGRect!
        
        if(_type == scdHouseCellType.HasJmpImg)
        {
            frame = self.rightTxtLab.frame
            frame.origin.x = 80 - 10
            rightTxtLab.frame = frame
            
            jmpImg.hidden = false
            textField.hidden = true
            lockImg.hidden = true
            self.clearSelView()
        }
        else if(_type == scdHouseCellType.OnlyFidld)
        {
            frame = textField.frame
            frame.size.width = kScreenWidth - 80 - 15
            textField.frame = frame
            
            textField.keyboardType = UIKeyboardType.Default
            textField.returnKeyType = UIReturnKeyType.Next
            
            rightTxtLab.text = ""
            textField.hidden = false
            lockImg.hidden = true
            jmpImg.hidden = true
            self.clearSelView()
        }
        else if(_type == scdHouseCellType.LockCase)
        {
            frame = rightTxtLab.frame
            frame.origin.x = 80 - 10
            rightTxtLab.frame = frame
            
            frame = textField.frame
            frame.origin.x = 80
            
            if(_index == 3)
            {
                frame.size.width = kScreenWidth - 80 - 50
                rightTxtLab.text = "号"
            }
            else if(_index == 4)
            {
                frame.size.width = kScreenWidth - 80 - 50
                rightTxtLab.text = "室"
            }
            else
            {
                frame.size.width = kScreenWidth - 80 - 30
                rightTxtLab.text = ""
            }
            textField.frame = frame
            if(_index == 11)
            {
                textField.keyboardType = UIKeyboardType.PhonePad
            }
            else
            {
                textField.keyboardType = UIKeyboardType.Default
            }
            textField.returnKeyType = UIReturnKeyType.Next
            
            textField.hidden = false
            lockImg.hidden = false
            jmpImg.hidden = true
            self.clearSelView()
        }
        else if(_type == scdHouseCellType.Normal)
        {
            frame = rightTxtLab.frame
            frame.origin.x = 80 + 5
            rightTxtLab.frame = frame
            
            frame = textField.frame
            frame.origin.x = 80
            
            if(_index == 5)
            {
                frame.size.width = kScreenWidth - 80 - 55
                rightTxtLab.text = "万元"
            }
            else if(_index == 6)
            {
                frame.size.width = kScreenWidth - 80 - 70
                rightTxtLab.text = "平方米"
            }
            else if(_index == 7)
            {
                frame.size.width = kScreenWidth - 80 - 40
                rightTxtLab.text = "年"
            }
            textField.frame = frame
            textField.keyboardType = UIKeyboardType.DecimalPad
            textField.returnKeyType = UIReturnKeyType.Next
            
            textField.hidden = false
            lockImg.hidden = true
            jmpImg.hidden = true
            self.clearSelView()
        }
        else if(_type == scdHouseCellType.SingleChoice)
        {
            self.setSelectViewWithArr(["先生", "女士"])
            if(_model.status == "putup" && _model.sourceWay != "")
            {
                self.setViewUnable();
            }
            rightTxtLab.text = ""
            lockImg.hidden = true
            jmpImg.hidden = true
            textField.hidden = true
        }
        else if(_type == scdHouseCellType.MultipleChoice)
        {
            self.createLabelSelectViewWithArr(HWScdHouConfigCenter.defaultCenter().sign_C)
            
            rightTxtLab.text = ""
            lockImg.hidden = true
            jmpImg.hidden = true
            textField.hidden = true
        }
    }
    
    //MARK: 实现性别单选
    private func setSexType(type: Int)
    {
        var view: HWSelectionView
        for view in self.contentView.subviews
        {
            if(view.isKindOfClass(HWSelectionView))
            {
                if (view.tag == type)
                {
                    view.setSelected()
                }
                else
                {
                    view.setDeselected()
                }
            }
        }
    }
    
    //MARK: 设置标签多选
    private func setSignSelected(type: Int)
    {
        var view: HWSelectionView
        for view in self.contentView.subviews
        {
            if(view.isKindOfClass(HWSelectionView))
            {
                if (view.tag == type)
                {
                    view.setSelected()
                }
            }
        }
    }
    
    //MARK: HWSelectionViewDelegate Method
    //选择
    func selected(selClass: HWSelectionView!)
    {
        
            if(_type == scdHouseCellType.SingleChoice)
            {
                if(selClass.tag == 0)
                {
                    self.setSexType(0)
                }
                else
                {
                    self.setSexType(1)
                }
                delegate.cellClickForChoice(12, type: selClass.tag)
            }
            else
            {
                delegate.cellClickForChoice(19, type: HWScdHouConfigCenter.defaultCenter().sign_E.count - selClass.tag - 1)
            }
    }
    
    //取消 选择
    func deSelected(selClass: HWSelectionView!)
    {
        delegate.cellClickForDeChoice(19, type: selClass.tag)
    }
    
    //MARK: textFieldDelegate
    func textField(textField: UITextField, shouldChangeCharactersInRange range: NSRange, replacementString string: String) -> Bool
    {
        var tmpStr: NSMutableString = NSMutableString(string: textField.text)
        tmpStr.replaceCharactersInRange(range, withString: string)
        if(_index == 11)
        {
            //标题限制最多30字
            if(tmpStr.length > 11)
            {
                return false
            }
        }
        return true
    }
    
    func textFieldShouldBeginEditing(textField: UITextField) -> Bool
    {
        delegate.cellTextFieldBecomeFirstResponse(_index)
        
        return true
    }
    
    func textFieldShouldEndEditing(textField: UITextField) -> Bool
    {
        delegate.cellTextEdit(_index, txt: textField.text)
        return true
    }
    
    func textFieldShouldReturn(textField: UITextField) -> Bool
    {
        //输入键盘右下角为下一步按钮，点击自动切换下一个输入框
        
        delegate.cellKeyBoardReturnClick(_index)
        return true
    }
    
    //MARK: 无用
    required init(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
