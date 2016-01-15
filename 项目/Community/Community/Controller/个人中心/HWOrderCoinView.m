//
//  HWOrderCoinView.m
//  TestOne
//
//  Created by gusheng on 14-12-9.
//  Copyright (c) 2014年 gusheng. All rights reserved.
//

#import "HWOrderCoinView.h"
#import "HWGeneralControl.h"
#define kScreenWidth                    [UIScreen mainScreen].bounds.size.width
@implementation HWOrderCoinView
@synthesize delegate;
-(instancetype)initWithFrame:(CGRect)generalRect coinType:(NSString *)coinTypeStr coinImageV:(NSString *)coinImageVUrl
{
    if (self = [super initWithFrame:generalRect]) {
        _backGroundView = [[UIView alloc]initWithFrame:generalRect];
        _backGroundView.backgroundColor = [UIColor colorWithWhite:0.0f alpha:0.0f];
        [self addSubview:_backGroundView];
        
        UITapGestureRecognizer *ctrl = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(hideSelectKaolaCoin:)];
        [self addGestureRecognizer:ctrl];
        
        _kaolaCoinNum = 1;
        _view =[[UIView alloc]initWithFrame:CGRectMake(0, generalRect.size.height, kScreenWidth, 256)];
        UITapGestureRecognizer *ctrlTemp = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(resignTextfiled:)];
        [_view addGestureRecognizer:ctrlTemp];
        _view.backgroundColor =[UIColor whiteColor];
       
        [self addSubview:_view];
        [self createKaoLaCoinView:coinTypeStr coinImageV:coinImageVUrl];
        [self showSelectKaolaCoin];
        valueTextFileld.text = [NSString stringWithFormat:@"%d",1];
        NSDecimalNumber *danjia= [NSDecimalNumber decimalNumberWithString:_coinTypeStr];
        NSDecimalNumber *coinNum = [NSDecimalNumber decimalNumberWithString:[NSString stringWithFormat:@"%d",_kaolaCoinNum]];
        NSDecimalNumber *zongjia = [danjia decimalNumberByMultiplyingBy:coinNum];
        _totalPayMoneyStr = [zongjia stringValue];
        _needPayMoneyLabel.text = [NSString stringWithFormat:@"￥%@",_totalPayMoneyStr];
        //监听键盘
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardWillShow:) name:UIKeyboardWillShowNotification object:nil];
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardWillHide:) name:UIKeyboardWillHideNotification object:nil];
        
        // 键盘高度变化通知，ios5.0新增的
#ifdef __IPHONE_5_0
        float version = [[[UIDevice currentDevice] systemVersion] floatValue];
        if (version >= 5.0) {
            [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardWillShow:) name:UIKeyboardWillChangeFrameNotification object:nil];
        }
#endif

    }
    return self;
}
#pragma - mark 监听键盘的通知
#pragma mark -
#pragma mark Responding to keyboard events
- (void)keyboardWillShow:(NSNotification *)notification {
    
    /*
     Reduce the size of the text view so that it's not obscured by the keyboard.
     Animate the resize so that it's in sync with the appearance of the keyboard.
     */
    
    NSDictionary *userInfo = [notification userInfo];
    
    // Get the origin of the keyboard when it's displayed.
    NSValue* aValue = [userInfo objectForKey:UIKeyboardFrameEndUserInfoKey];
    
    // Get the top of the keyboard as the y coordinate of its origin in self's view's coordinate system. The bottom of the text view's frame should align with the top of the keyboard's final position.
    CGRect keyboardRect = [aValue CGRectValue];
    
    // Get the duration of the animation.
    NSValue *animationDurationValue = [userInfo objectForKey:UIKeyboardAnimationDurationUserInfoKey];
    NSTimeInterval animationDuration;
    [animationDurationValue getValue:&animationDuration];
    
    // Animate the resize of the text view's frame in sync with the keyboard's appearance.
    [self moveInputBarWithKeyboardHeight:keyboardRect.size.height withDuration:animationDuration];
}


- (void)keyboardWillHide:(NSNotification *)notification {
    
    NSDictionary* userInfo = [notification userInfo];
    
    /*
     Restore the size of the text view (fill self's view).
     Animate the resize so that it's in sync with the disappearance of the keyboard.
     */
    NSValue *animationDurationValue = [userInfo objectForKey:UIKeyboardAnimationDurationUserInfoKey];
    NSTimeInterval animationDuration;
    [animationDurationValue getValue:&animationDuration];
    
    [self moveInputBarWithKeyboardHeight:0.0 withDuration:animationDuration];
}
-(void)moveInputBarWithKeyboardHeight:(float)_CGRectHeight withDuration:(NSTimeInterval)_NSTimeInterval{
    
    CGRect rect = self.frame;
    
    [UIView beginAnimations:nil context:NULL];
    
    [UIView setAnimationDuration:_NSTimeInterval];
    
    rect.origin.y = -_CGRectHeight;//view往上移动
    
    self.frame = rect;
    
    [UIView commitAnimations];
    
}
-(void)dealloc
{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}
//
//创建视图
-(void)createKaoLaCoinView:(NSString*)coinTypeStr coinImageV:(NSString *)coinImageVUrl
{
    _coinTypeStr = coinTypeStr;
    UIImageView *coinTypeImageV = [HWGeneralControl createImageView:CGRectMake(kScreenWidth/2-64/2, 20, 64, 64) image:coinImageVUrl];
    coinTypeImageV.layer.cornerRadius = 32.0f;
    coinTypeImageV.backgroundColor = [UIColor clearColor];
    coinTypeImageV.layer.masksToBounds = YES;
    [_view addSubview:coinTypeImageV];
    
    valueTextFileld = [HWGeneralControl createTextFiledView:CGRectMake(kScreenWidth/2-91/2, CGRectGetMaxY(coinTypeImageV.frame)+16,91 ,36) delegate:self textAligment:NSTextAlignmentCenter font:18.0f textColor:THEME_COLOR_SMOKE tag:100];
    valueTextFileld.clearsOnBeginEditing = YES;
    valueTextFileld.layer.cornerRadius = 20.0f;
    valueTextFileld.layer.masksToBounds = YES;
    valueTextFileld.layer.borderColor = [UIColor lightGrayColor].CGColor;
    valueTextFileld.layer.borderWidth = 0.5;
    valueTextFileld.text = @"1";
    [_view addSubview:valueTextFileld];
    
    
    
    UIButton *minusBtn = [HWGeneralControl createButton:CGRectMake(valueTextFileld.frame.origin.x-8-36, CGRectGetMaxY(coinTypeImageV.frame)+16,36,36) font:25 buttonTitleColor:UIColorFromRGB(0x8a8a8a) imageStr:@"" backImage:@"" title:@"-"];
    [minusBtn addTarget:self action:@selector(minusCoinNum:) forControlEvents:UIControlEventTouchUpInside];
    minusBtn.layer.cornerRadius = 18.0f;
    minusBtn.layer.masksToBounds = YES;
    minusBtn.backgroundColor = UIColorFromRGB(0xe1e1e1);
    minusBtn.titleEdgeInsets = UIEdgeInsetsMake(-2, 0, 0, 0);
    [_view addSubview:minusBtn];
    
    
    UIButton *addBtn = [HWGeneralControl createButton:CGRectMake(CGRectGetMaxX(valueTextFileld.frame)+8, CGRectGetMaxY(coinTypeImageV.frame)+16,36,36) font:25 buttonTitleColor:nil imageStr:@"" backImage:@"" title:@"+"];
    [addBtn addTarget:self action:@selector(addCoinNum:) forControlEvents:UIControlEventTouchUpInside];
    [addBtn setButtonOrangeStyle];
    addBtn.layer.cornerRadius = 18.0f;
    addBtn.titleEdgeInsets = UIEdgeInsetsMake(-2, 0, 0, 0);
    [_view addSubview:addBtn];
    
    
    UILabel *needPayTitleLabel = [HWGeneralControl createLabel:CGRectMake(kScreenWidth/2-100, CGRectGetMaxY(valueTextFileld.frame)+30,100,16) font:15.0f textAligment:NSTextAlignmentRight labelColor:[UIColor blackColor]];
    needPayTitleLabel.text = @"您需支付:";
    [_view addSubview:needPayTitleLabel];
    
    _needPayMoneyLabel = [HWGeneralControl createLabel:CGRectMake(CGRectGetMaxX(needPayTitleLabel.frame), CGRectGetMaxY(valueTextFileld.frame)+30,kScreenWidth-CGRectGetMaxX(needPayTitleLabel.frame),16) font:18.0f textAligment:NSTextAlignmentLeft labelColor:[UIColor blackColor]];
    _needPayMoneyLabel.textColor = THEME_COLOR_MONEY;
    _needPayMoneyLabel.text = @"￥0";
    [_view addSubview:_needPayMoneyLabel];
    
    UIImageView *lineImageV = [HWGeneralControl createImageView:CGRectMake(0,  CGRectGetMaxY(_needPayMoneyLabel.frame)+14.5, kScreenWidth, 0.5) image:@""];
    lineImageV.backgroundColor = [UIColor lightGrayColor];
    [_view addSubview:lineImageV];
    
    UIView *confirmView = [HWGeneralControl createView:CGRectMake(0, CGRectGetMaxY(_needPayMoneyLabel.frame)+15, kScreenWidth, 256-(CGRectGetMaxY(_needPayMoneyLabel.frame)+15))];
    confirmView.backgroundColor = BACKGROUND_COLOR;
    [_view addSubview:confirmView];
    
    UIButton *createBtn = [HWGeneralControl createButton:CGRectMake(kScreenWidth/2-120/2,10,120,40) font:18 buttonTitleColor:nil imageStr:@"" backImage:@"" title:@"确认"];
    createBtn.backgroundColor = THEME_COLOR_ORANGE;
    createBtn.layer.cornerRadius = 5.0;
    createBtn.layer.masksToBounds = YES;
    [createBtn addTarget:self action:@selector(confirmPayMoney:) forControlEvents:UIControlEventTouchUpInside];
    [confirmView addSubview:createBtn];
    
}
//确认金额
-(void)confirmPayMoney:(id)sender
{
    [MobClick event:@"click_quedingqianbaozhifu"];
    [self hideSelectKaolaCoin:nil];
    if (delegate && [delegate respondsToSelector:@selector(confirmPayMoney:coinCount:)])
    {
        [delegate confirmPayMoney:_totalPayMoneyStr coinCount:_kaolaCoinNum];
    }
}
//加
-(void)addCoinNum:(id)sender
{
    [MobClick event:@"click_shuliangzengjia"];
    _kaolaCoinNum++;
    valueTextFileld.text = [NSString stringWithFormat:@"%d",_kaolaCoinNum];
    NSDecimalNumber *danjia= [NSDecimalNumber decimalNumberWithString:_coinTypeStr];
    NSDecimalNumber *coinNum = [NSDecimalNumber decimalNumberWithString:[NSString stringWithFormat:@"%d",_kaolaCoinNum]];
    NSDecimalNumber *zongjia = [danjia decimalNumberByMultiplyingBy:coinNum];
    _totalPayMoneyStr = [zongjia stringValue];
    _needPayMoneyLabel.text = [NSString stringWithFormat:@"￥%@",_totalPayMoneyStr];
}
//减
-(void)minusCoinNum:(id)sender
{
    [MobClick event:@"click_shuliangjianshao"];
    if (_kaolaCoinNum >0 ) {
        _kaolaCoinNum--;
        valueTextFileld.text = [NSString stringWithFormat:@"%d",_kaolaCoinNum];
        NSDecimalNumber *danjia= [NSDecimalNumber decimalNumberWithString:_coinTypeStr];
        NSDecimalNumber *coinNum = [NSDecimalNumber decimalNumberWithString:[NSString stringWithFormat:@"%d",_kaolaCoinNum]];
        NSDecimalNumber *zongjia = [danjia decimalNumberByMultiplyingBy:coinNum];
        _totalPayMoneyStr = [zongjia stringValue];
        _needPayMoneyLabel.text = [NSString stringWithFormat:@"￥%@",_totalPayMoneyStr];
    }
}
- (void)showSelectKaolaCoin
{
    [UIView animateWithDuration:0.3 animations:^{
        
        [_view setFrame:CGRectMake(0, self.frame.size.height-256, kScreenWidth, 256)];
        _backGroundView.backgroundColor =[UIColor colorWithWhite:0.0f alpha:0.4f];
        
    } completion:^(BOOL finished) {
        
    }];
}
-(void)resignTextfiled:(id)sender
{
    [valueTextFileld resignFirstResponder];
}
- (void)hideSelectKaolaCoin:(id)sender
{
    [UIView animateWithDuration:0.3 animations:^{
        
        _view.frame = CGRectMake(0, self.bounds.size.height, kScreenWidth, 256);
        _backGroundView.backgroundColor = [UIColor colorWithWhite:0.0f alpha:0.0f];
        
    } completion:^(BOOL finished)
     {
         
         [self removeFromSuperview];
         [valueTextFileld resignFirstResponder];
     }];
}
#pragma - mark UITextfiledDelegate
-(BOOL)textFieldShouldBeginEditing:(UITextField *)textField
{
        _kaolaCoinNum  = 0;
        NSDecimalNumber *danjia= [NSDecimalNumber decimalNumberWithString:_coinTypeStr];
        NSDecimalNumber *coinNum = [NSDecimalNumber decimalNumberWithString:[NSString stringWithFormat:@"%d",_kaolaCoinNum]];
        NSDecimalNumber *zongjia = [danjia decimalNumberByMultiplyingBy:coinNum];
        _totalPayMoneyStr = [zongjia stringValue];
        _needPayMoneyLabel.text = [NSString stringWithFormat:@"￥%@",_totalPayMoneyStr];
    return YES;
}
-(BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string
{
        if([string length]==0)
    {
        _kaolaCoinNum = [[textField.text stringByReplacingCharactersInRange:range withString:string]intValue];
    }
    else
    {
        _kaolaCoinNum = [[NSString stringWithFormat:@"%@%@",valueTextFileld.text,string]intValue];
    }
    
    NSDecimalNumber *danjia= [NSDecimalNumber decimalNumberWithString:_coinTypeStr];
    NSDecimalNumber *coinNum = [NSDecimalNumber decimalNumberWithString:[NSString stringWithFormat:@"%d",_kaolaCoinNum]];
    NSDecimalNumber *zongjia = [danjia decimalNumberByMultiplyingBy:coinNum];
    _totalPayMoneyStr = [zongjia stringValue];
    _needPayMoneyLabel.text = [NSString stringWithFormat:@"￥%@",_totalPayMoneyStr];
    return YES;

}

@end
