//
//  HWSubmitOrderView.m
//  Community
//
//  Created by ryder on 7/29/15.
//  Copyright (c) 2015 caijingpeng. All rights reserved.
//
//  功能描述：
//      天天团提交订单页面
//  修改记录：
//      姓名         日期              修改内容
//     程耀均     2015-07-29           创建文件

#import "HWSubmitOrderView.h"
#import "HWSubmitOrderModel.h"
#import "HWTianTianTuanDetailVC.h"
#import "HWCommonditySellUpViewController.h"
#import "AppDelegate.h"

typedef NS_ENUM(NSInteger, StepperViewTag)
{
    StepperViewTagSub = 200,
    StepperViewTagField = 201,
    StepperViewTagAdd = 202
};

@interface HWSubmitOrderView ()
{
    BOOL _isEditing; // 判断是否为数量 输入状态
    BOOL _isFirstCheckLeft; //是否是第一次检查库存
}

@property (nonatomic, strong) UITableView *mainViewTableView;
@property (nonatomic, strong) UILabel *postageLabel;
@property (nonatomic, strong) NSString *total;
@property (nonatomic, strong) UILabel *totaMoneyLab;
@property (nonatomic, assign) CGFloat totalPrice;
@property (nonatomic, assign) NSInteger orderCount;    //选购数量
@property (nonatomic, strong) UILabel *purchaseLimitsCountLabel;
@property (nonatomic, assign) NSInteger commondityStock; // 商品库存
@property (nonatomic, strong) UITextField *orderNumTF;
@end

@implementation HWSubmitOrderView

- (instancetype)initWithModel:(HWCommondityDetailModel *)model
{
    if (self = [super initWithFrame:CGRectMake(0, 0, kScreenWidth, kScreecHeight)])
    {
        _isEditing = NO;
        _isFirstCheckLeft = YES;
        
        [self setBackgroundColor:[[UIColor blackColor] colorWithAlphaComponent:0.5]];
        _mainViewTableView.transform = CGAffineTransformMakeTranslation(0, kScreecHeight);
        
        [UIView animateWithDuration:0.5 animations:^ {
            _mainViewTableView.transform = CGAffineTransformIdentity;
        }];
        
        self.model = model;
        [self checkCommondityStocks];
        [self initContentView];
        
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self
                                                                              action:@selector(handleTapRecognizer:)];
        [self addGestureRecognizer:tap];
    }
    return self;
}

- (void)initContentView
{
    CGRect frame = CGRectMake(CGPointZero.x,  CONTENT_HEIGHT/2, kScreenWidth, CONTENT_HEIGHT/2);
    _mainViewTableView = [[UITableView alloc] initWithFrame:frame];
    [_mainViewTableView setBackgroundColor:[UIColor whiteColor]];
    _mainViewTableView.delegate = self;
    _mainViewTableView.dataSource = self;
    _mainViewTableView.scrollEnabled = NO;
    _mainViewTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    [self addSubview:_mainViewTableView];
    [self submitOrderButton];
}

- (void)submitOrderButton
{
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    button.frame = CGRectMake(15, CONTENT_HEIGHT - 45 - 20, kScreenWidth - 30, 45);
    [button setTitle:@"提交订单" forState:UIControlStateNormal];
    [button addTarget:self action:@selector(submitOrder) forControlEvents:UIControlEventTouchUpInside];
    //    [button setBackgroundColor:THEME_COLOR_ORANGE];
    [button setButtonOrangeStyle];
    [self addSubview:button];
}

- (void)setTotal:(NSString *)total
{
    _totaMoneyLab.text = [NSString stringWithFormat:@"%@元",total];
}

- (void)handleTapRecognizer:(UITapGestureRecognizer *)recognizer
{
    if (_isEditing)
    {
        [self endEditing:YES];
    }
    else
    {
        CGPoint point = [recognizer locationInView:_mainViewTableView];
        if (point.y >= 0)
        {
            return;
        }
        self.transform = CGAffineTransformIdentity;
        [UIView animateWithDuration:0.3 animations:^{
            
            _mainViewTableView.transform = CGAffineTransformMakeTranslation(0, kScreecHeight);
            self.alpha = 0.0f;
            
        } completion:^(BOOL finished) {
            
            [self removeFromSuperview];
        }];
    }
}

- (void)checkCommondityStocks
{
    /*url：http://172.16.10.110:8080/hw-sq-app-web/grpBuyGoods/getGrpBuyGoodSurplusStock.do
     输入参数说明：
     key：考拉社区登录成功用户被授权的key(必填)
     goodsId：被查看的商品id(必填)
     输出参数：
     {
     "status":"1",
     "data":49,
     "detail":"请求数据成功!",
     "key":"3e801f50-10d8-44d7-9ce7-83e57fe582f1"
     }
     返回参数说明：
     status：1表示返回成功
     data：49 表示商品库存*/
    
    HWHTTPRequestOperationManager *manager = [HWHTTPRequestOperationManager manager];
    NSMutableDictionary *dictionary = [NSMutableDictionary dictionary];
    [dictionary setPObject:[HWUserLogin currentUserLogin].key forKey:@"key"];
    [dictionary setPObject:self.model.goodsId forKey:@"goodsId"];
    
    [manager POST:kTianTianTuanCommonditySurplusStock parameters:dictionary queue:nil success:^(id responese) {
        
        _commondityStock = [[responese stringObjectForKey:@"data"] integerValue];   //剩余库存
        
        if (_commondityStock)
        {
            if (_orderCount <= _commondityStock)
            {
                if (_orderCount > self.model.limitCount.integerValue) //超过限购数
                {
                    _purchaseLimitsCountLabel.hidden = NO;
                    _purchaseLimitsCountLabel.text = [NSString stringWithFormat:@"限购%zd份", [self.model.limitCount integerValue]];
                    _orderNumTF.text = [NSString stringWithFormat:@"%@", self.model.limitCount];
                    NSString *text = [_orderNumTF text];
                    CGFloat value = text.floatValue * self.model.sellPrice.floatValue;
                    [self setTotal:[NSString stringWithFormat:@"%.2f",value]];
                }
                else
                {
                    if (!_isFirstCheckLeft)
                    {
                        [self commitOrder];
                    }
                }
            }
            else  // 超过库存数
            {
                NSString *alertStirng = [NSString stringWithFormat:@"只有%zd份，是否确认购买？",_commondityStock];
                UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"提示" message:alertStirng delegate:nil cancelButtonTitle:@"取消" otherButtonTitles:@"确定", nil];
                alert.delegate = self;
                [alert show];
                alert.tag = 9999;
            }
        }
        else  // 商品没有库存
        {
            HWCommonditySellUpViewController *sellUpVC = [[HWCommonditySellUpViewController alloc] init];
            [self.superVC.navigationController pushViewController:sellUpVC animated:YES];
        }
        
        _isFirstCheckLeft = NO;//是否是第一次检查库存
        
    } failure:^(NSString *code, NSString *error) {
        
        NSLog(@"查询库存错误：%@",error);
        [Utility hideMBProgress:self];
        [Utility showToastWithMessage:error inView:self];
        
        _commondityStock = 0;
    }];
}

- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex;
{
    if (alertView.tag == 9999)
    {
        if (buttonIndex == 0)
        {
            [_orderNumTF setText:[NSString stringWithFormat:@"%zd", _commondityStock]];
            NSString *text = [_orderNumTF text];
            CGFloat value = text.floatValue * self.model.sellPrice.floatValue;
            [self setTotal:[NSString stringWithFormat:@"%.2f",value]];
            
            _orderCount = _commondityStock;
        }
        else
        {
            [_orderNumTF setText:[NSString stringWithFormat:@"%zd", _commondityStock]];
            NSString *text = [_orderNumTF text];
            CGFloat value = text.floatValue * self.model.sellPrice.floatValue;
            [self setTotal:[NSString stringWithFormat:@"%.2f",value]];
            
            _orderCount = _commondityStock;
            [self commitOrder];
        }
    }
}

- (void)commitOrder //提交订单（下单接口）
{
    /*接口名称：
     http://localhost:8080/hw-sq-app-web/grpBuyOrder/submitOrder.do?goodsId=10349274824&goodsCount=2&userId=1011066011065&key=a79dbe5c-bf01-4c47-b4ac-ed9ca9c6b1d0
     
     输入参数：
     userId 用户ID
     goodsId 商品ID
     goodsCount 商品数量
     
     输出参数：
     orderId 订单ID submitResult =1新订单ID； submitResult =0老订单ID
     submitResult 提交结果 1：新订单提交成功 0：新订单未提交，有同一商品的老订单未支付
     submitMsg 提交结果信息
     
     成功：
     {
     status: "1",
     data:
     { orderId: 1042718677, submitResult: 1, submitMsg: "订单提交成功" }
     
     ,
     detail: "请求数据成功!",
     key: "a79dbe5c-bf01-4c47-b4ac-ed9ca9c6b1d0"
     }
     
     {
     status: "1",
     data:
     { orderId: 1042718677, submitResult: 0, submitMsg: "您有该商品的未支付订单，请先处理" }
     
     ,
     detail: "请求数据成功!",
     key: "a79dbe5c-bf01-4c47-b4ac-ed9ca9c6b1d0"
     }
     
     失败：
     { status: "0", data: "", detail: "亲，该商品库存不足，剩余1份", key: "a79dbe5c-bf01-4c47-b4ac-ed9ca9c6b1d0" } { status: "0", data: "", detail: "您的下单数量超过该商品限购数量", key: "a79dbe5c-bf01-4c47-b4ac-ed9ca9c6b1d0" } { status: "0", data: "", detail: "提交订单出错", key: "a79dbe5c-bf01-4c47-b4ac-ed9ca9c6b1d0" } */
    
    HWHTTPRequestOperationManager *manager = [HWHTTPRequestOperationManager manager];
    NSMutableDictionary *dictionary = [NSMutableDictionary dictionary];
    [dictionary setPObject:[HWUserLogin currentUserLogin].key forKey:@"key"];
    [dictionary setPObject:[HWUserLogin currentUserLogin].userId forKey:@"userId"];
    [dictionary setPObject:self.model.goodsId forKey:@"goodsId"];
    [dictionary setPObject:[NSString stringWithFormat:@"%zd",_orderCount] forKey:@"goodsCount"];
    
    [manager POST:kTianTianTuanSubmitOrder parameters:dictionary queue:nil success:^(id responese) {
        
        [Utility hideMBProgress:self];
        
        AppDelegate *del = (AppDelegate *)SHARED_APP_DELEGATE;
        HWSubmitOrderModel *orderModel = [[HWSubmitOrderModel alloc] initWithdictionary:responese];
        
        if ([orderModel.submitResult isEqualToString:@"1"])
        {
            if ([self.delegate respondsToSelector:@selector(didSubmitOrder:price:orderId:)])
            {
                [self.delegate didSubmitOrder:_orderCount price:_totalPrice orderId:orderModel.orderId];
            }
        }
        else
        {
            [Utility showToastWithMessage:orderModel.submitMsg inView:del.window];
            
            [self checkOrderDetails:orderModel.orderId];
        }
        
    } failure:^(NSString *code, NSString *error) {
        
        NSLog(@"下单错误：%@",error);
        [Utility hideMBProgress:self];
        [Utility showToastWithMessage:error inView:self];
    }];
}

- (void)checkOrderDetails:(NSString *)orderId
{
    HWTianTianTuanDetailVC *dVC = [[HWTianTianTuanDetailVC alloc] init];
    dVC.orderId = orderId;
    [self.superVC.navigationController pushViewController:dVC animated:YES];
}

#pragma mark -
#pragma mark UITableViewDataSource

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 2;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath;
{
    UITableViewCell *cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:nil];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    
    switch (indexPath.row)
    {
        case 0:
        {
            UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(15, 0, 100, 55)];
            label.font = FONT(TF16);
            label.text = @"数量";
            label.textColor = THEME_COLOR_TEXT;
            [cell addSubview:label];
            
            _purchaseLimitsCountLabel = [[UILabel alloc] initWithFrame:CGRectMake(50, 0, kScreenWidth - 50 - 130, 55)];
            _purchaseLimitsCountLabel.textColor = UIColorFromRGB(0xe45b5c);
            _purchaseLimitsCountLabel.text = @"限购x份";
            _purchaseLimitsCountLabel.font = FONT(TF16);
            _purchaseLimitsCountLabel.hidden = YES;
            [cell addSubview:_purchaseLimitsCountLabel];
            
            _orderCount = 1;
            
            UIView *orderNumStepView = [self creatStepView]; //订单数量调整view
            orderNumStepView.frame = CGRectMake(kScreenWidth - 150, 0, 150, 55);
            [cell.contentView addSubview:orderNumStepView];
            
            CALayer *topLine = [DView layerFrameX:15 y:CGRectGetMaxY(orderNumStepView.frame) w:kScreenWidth - 2 * 15 h:0.5f];
            [cell.layer addSublayer:topLine];
        }
            break;
        case 1:
        {
            DLable *postageTitleLab = [DLable LabTxt:@"邮费" txtFont:TF16 txtColor:THEME_COLOR_TEXT frameX:15 y:15 w:100 h:32];
            [cell addSubview:postageTitleLab];
            
            NSString *postageStr = @"";
            if (_model.postage.length == 0 || [_model.postage isEqualToString:@"0"])
            {
                postageStr = @"免邮";
            }
            else
            {
                if ([_model.freePostageType isEqualToString:@"0"])//免邮类型(0金额， 1分数， 2不免邮)
                {
                    postageStr = [NSString stringWithFormat:@"¥%@ (满%@元包邮)", _model.postage, _model.freePostageAmount];
                }
                else if ([_model.freePostageType isEqualToString:@"1"])
                {
                    postageStr = [NSString stringWithFormat:@"¥%@ (满%@份包邮)", _model.postage, _model.freePostageNum];
                }
                else if ([_model.freePostageType isEqualToString:@"2"])
                {
                    postageStr = [NSString stringWithFormat:@"%@", _model.postage];
                }
            }
            
            _postageLabel = [DLable LabTxt:postageStr txtFont:TF16 txtColor:THEME_COLOR_TEXT frameX:15 y:15 w:kScreenWidth - 2 * 15 h:32];
            _postageLabel.textAlignment = NSTextAlignmentRight;
            [cell addSubview:_postageLabel];
            
            DLable *totalMoneyTitleLab = [DLable LabTxt:@"商品总价" txtFont:TF16 txtColor:THEME_COLOR_TEXT frameX:15 y:CGRectGetMaxY(postageTitleLab.frame) w:100 h:32];
            [cell addSubview:totalMoneyTitleLab];
            
            NSString *totalMoneyStr = [NSString stringWithFormat:@"%@元",self.model.sellPrice];
            DLable *totalMoneyLab = [DLable LabTxt:totalMoneyStr txtFont:TF16 txtColor:THEME_COLOR_RED frameX:15 y:CGRectGetMaxY(postageTitleLab.frame) w:kScreenWidth - 2 * 15 h:32];
            totalMoneyLab.textAlignment = NSTextAlignmentRight;
            [cell addSubview:totalMoneyLab];
            _totaMoneyLab = totalMoneyLab;
            
            NSInteger pading = 16;
            UIView *line = [[UIView alloc] initWithFrame:CGRectMake(16, 90 - 1.f, kScreenWidth - pading * 2, 0.5f)];
            line.backgroundColor = THEME_COLOR_LINE;
            [cell addSubview:line];
        }
            break;
        default:
            break;
    }
    return cell;
}

- (UIView *)creatStepView
{
    CGRect frame = CGRectMake(0, 0, 150, 55);
    UIView *control = [[UIView alloc] initWithFrame:frame];
    
    NSInteger btnWidth = 45;
    UIButton *subButton = [[UIButton alloc] initWithFrame:CGRectMake(0, 5, btnWidth, btnWidth)];
    [subButton addTarget:self action:@selector(changeCommodityCount:) forControlEvents:UIControlEventTouchUpInside];
    [subButton setImage:[UIImage imageNamed:@"减"] forState:UIControlStateNormal];
    [subButton setImageEdgeInsets:UIEdgeInsetsMake(5, 15, 5, 5)];
    subButton.tag = StepperViewTagSub;
    [control addSubview:subButton];
    
    _orderNumTF = [[UITextField alloc] initWithFrame:CGRectMake(CGRectGetMaxX(subButton.frame) + 6, 15, 44, 25)];
    _orderNumTF.text = @"1";
    [_orderNumTF setTextColor:THEME_COLOR_TEXT];
    _orderNumTF.layer.cornerRadius = 3.5f;
    _orderNumTF.layer.masksToBounds = YES;
    _orderNumTF.layer.borderColor = THEME_COLOR_TEXT.CGColor;
    _orderNumTF.layer.borderWidth = 1.0f;
    _orderNumTF.font = FONT(TF14);
    _orderNumTF.textAlignment = NSTextAlignmentCenter;
    _orderNumTF.tag = StepperViewTagField;
    _orderNumTF.keyboardType = UIKeyboardTypeNumberPad;
    _orderNumTF.delegate = self;
    [control addSubview:_orderNumTF];
    
    UIButton *addButton = [[UIButton alloc] initWithFrame:CGRectMake(CGRectGetMaxX(_orderNumTF.frame) + 6, 5, btnWidth, btnWidth)];
    [addButton setImageEdgeInsets:UIEdgeInsetsMake(5, 5, 5, 15)];
    [addButton addTarget:self action:@selector(changeCommodityCount:) forControlEvents:UIControlEventTouchUpInside];
    addButton.tag = StepperViewTagAdd;
    [addButton setImage:[UIImage imageNamed:@"加"] forState:UIControlStateNormal];
    [control addSubview:addButton];
    
    return control;
}

- (void)changeCommodityCount:(UIButton *)button
{
    UITextField *field = (UITextField *)[button.superview viewWithTag:StepperViewTagField];
    NSInteger limitCount = [self.model.limitCount integerValue];
    NSInteger count = field.text.integerValue;
    
    BOOL isAddCommondity  = (button.tag == StepperViewTagAdd) ? YES : NO;
    
    if (isAddCommondity)
    {
        [MobClick event:@"click_add_good"];//1.7
        
        if (count >= limitCount)
        {
            _purchaseLimitsCountLabel.hidden = NO;
            _purchaseLimitsCountLabel.text = [NSString stringWithFormat:@"限购%zd份", [self.model.limitCount integerValue]];
            return;
        }
        
        if (count >= _commondityStock)
        {
            NSString *alertStirng = [NSString stringWithFormat:@"只有%zd份，是否确认购买？",_commondityStock];
            UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"提示" message:alertStirng delegate:nil cancelButtonTitle:@"确定" otherButtonTitles:nil];
            alert.delegate = self;
            [alert show];
            alert.tag = 9999;
            return;
        }
        
        count++;
        field.text = [NSString stringWithFormat:@"%zd",count];
        _orderCount = count;
    }
    else
    {
        [MobClick event:@"click_reduce_good"];//1.7
        
        if (count <= 1)
        {
            return;
        }
        
        NSInteger count = field.text.integerValue;
        count--;
        field.text = [NSString stringWithFormat:@"%zd",count];
        _orderCount = count;
        
        if (count < limitCount )
        {
            _purchaseLimitsCountLabel.hidden = YES;
        }
    }
    
    NSString *totalString = [NSString stringWithFormat:@"%.2f", _orderCount * self.model.sellPrice.floatValue];
    _totalPrice = totalString.floatValue;
    [self setTotal:totalString];
}

#pragma mark -
#pragma mark UITableViewDelegate
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    CGFloat height = 0;
    switch (indexPath.section) {
        case 0:
            height = 55;
            break;
        case 1:
            height = 83;
            break;
            
        default:
            break;
    }
    return height;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    return 0.f;
}

- (void)submitOrder
{
    [MobClick event:@"click_submit_order"];//1.7
    
    _totalPrice += [self.model.postage floatValue]; // 算上邮费
    [self checkCommondityStocks];
}


#pragma mark -
#pragma mark UITextFieldDelegate

- (BOOL)textFieldShouldBeginEditing:(UITextField *)textField
{
    _isEditing = YES;
    
    [UIView animateWithDuration:0.3f animations:^{
        CGRect frame = _mainViewTableView.frame;
        frame.origin.y = CONTENT_HEIGHT / 2 - 60;
        _mainViewTableView.frame = frame;
    }];
    
    return YES;
}

- (BOOL)textFieldShouldEndEditing:(UITextField *)textField
{
    int count = [textField.text intValue];
    NSInteger limitCount = [self.model.limitCount integerValue];
    
    if (count > _commondityStock || count > limitCount)
    {
        if (limitCount > _commondityStock)
        {
            if (count > _commondityStock)
            {
                NSString *alertStirng = [NSString stringWithFormat:@"只有%zd份，是否确认购买？",_commondityStock];
                UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"提示" message:alertStirng delegate:nil cancelButtonTitle:@"确定" otherButtonTitles:nil];
                alert.delegate = self;
                [alert show];
                alert.tag = 9999;
            }
        }
        else
        {
            if (count > limitCount)
            {
                _purchaseLimitsCountLabel.hidden = NO;
                _purchaseLimitsCountLabel.text = [NSString stringWithFormat:@"限购%zd份", [self.model.limitCount integerValue]];
                
                textField.text = [NSString stringWithFormat:@"%ld", (long)limitCount];
                
                
                NSString *totalString = [NSString stringWithFormat:@"%.2f", limitCount * self.model.sellPrice.floatValue];
                _totalPrice = totalString.floatValue;
                [self setTotal:totalString];
                
                _orderCount = limitCount;
            }
        }
    }
    else
    {
        NSString *totalString = [NSString stringWithFormat:@"%.2f", count * self.model.sellPrice.floatValue];
        _totalPrice = totalString.floatValue;
        [self setTotal:totalString];
        
        _orderCount = count;
    }
    
    _isEditing = NO;
    
    [UIView animateWithDuration:0.3f animations:^{
        CGRect frame = _mainViewTableView.frame;
        frame.origin.y = CONTENT_HEIGHT / 2;
        _mainViewTableView.frame = frame;
    }];
    
    
    return YES;
}

- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string
{
    NSCharacterSet *cs = [[NSCharacterSet characterSetWithCharactersInString:@"1234567890"] invertedSet];
    NSString *filtered = [[string componentsSeparatedByCharactersInSet:cs] componentsJoinedByString:@""];
    if ((([string isEqualToString:filtered]))) {
        NSString *text = [textField text];
        text = [text stringByReplacingCharactersInRange:range
                                             withString:string];
        CGFloat value = text.floatValue * self.model.sellPrice.floatValue;
        [self setTotal:[NSString stringWithFormat:@"%.2f",value]];
    }
    return (([string isEqualToString:filtered]));
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
    [textField resignFirstResponder];
    return NO;
}

@end
