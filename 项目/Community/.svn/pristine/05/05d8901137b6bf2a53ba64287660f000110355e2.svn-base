//
//  HWAuthenticateConfirmViewController.m
//  Community
//
//  Created by hw500027 on 15/6/15.
//  Copyright (c) 2015年 caijingpeng. All rights reserved.
//
//  功能描述：个人资料 认证门牌界面(收到信件 确认认证)
//
//  修改记录：
//      姓名         日期               修改内容
//     陆晓波     2015-06-15           创建文件
//

#import "HWAuthenticateConfirmViewController.h"
#import "HWInputBackView.h"
#import "AppDelegate.h"

@interface HWAuthenticateConfirmViewController ()
{
    UITextField *_textField;
}
@end

@implementation HWAuthenticateConfirmViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.navigationItem.titleView = [Utility navTitleView:@"认证门牌"];
    [self configUI];
}

- (void)toConfirm
{
    [self.view endEditing:YES];
    //点击申请认证
    [Utility hideMBProgress:self.view];
    [Utility showMBProgress:self.view message:@"请求数据"];
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    NSMutableDictionary *parame = [[NSMutableDictionary alloc] init];
    [parame setPObject:[HWUserLogin currentUserLogin].key forKey:@"key"];
    [parame setPObject:[defaults objectForKey:kAuthApplyId] forKey:@"applyId"];
    [parame setPObject:_textField.text forKey:@"password"];
    
    HWHTTPRequestOperationManager *manager = [HWHTTPRequestOperationManager manager];
    [manager POST:kConfirmForAuthentication parameters:parame queue:nil success:^(id responese)
     {
         [Utility hideMBProgress:self.view];
         if ([[responese stringObjectForKey:@"status"] isEqual:@"1"])
         {
             AppDelegate *del = (AppDelegate *)SHARED_APP_DELEGATE;
             [Utility showToastWithMessage:@"认证成功" inView:del.window];
             
             [HWUserLogin currentUserLogin].isAuth = @"0";
             [self.navigationController popViewControllerAnimated:YES];
         }
     } failure:^(NSString *code, NSString *error)
     {
         [Utility hideMBProgress:self.view];
         [Utility showToastWithMessage:error inView:self.view];
     }];
}

- (CGFloat)addConfigBtn:(CGFloat)originY
{
    CGFloat padding_height = 20;
    CGSize btnSize = CGSizeMake(kScreenWidth - 30, 45);
    
    UIButton *confirmBtn = [UIButton newAutoLayoutView];
    
    [self.view addSubview:confirmBtn];
    confirmBtn.layer.cornerRadius = 3;
    confirmBtn.layer.masksToBounds = YES;
    
    [confirmBtn setTitle:@"认证" forState:UIControlStateNormal];
    
    [confirmBtn autoPinEdge:ALEdgeTop toEdge:ALEdgeTop ofView:self.view  withOffset:originY + padding_height];
    [confirmBtn autoPinEdge:ALEdgeLeft toEdge:ALEdgeLeft ofView:self.view  withOffset:15];
    [confirmBtn autoSetDimensionsToSize:btnSize];
    
    [confirmBtn setBackgroundImage:[Utility imageWithColor:THEBUTTON_GREEN_NORMAL andSize:btnSize] forState:UIControlStateNormal];
    [confirmBtn setBackgroundImage:[Utility imageWithColor:THEBUTTON_GREEN_HIGHLIGHT andSize:btnSize] forState:UIControlStateHighlighted];
    
    [confirmBtn addTarget:self action:@selector(toConfirm) forControlEvents:UIControlEventTouchUpInside];
    
    return originY + [confirmBtn systemLayoutSizeFittingSize:UILayoutFittingCompressedSize].height + padding_height;
}

- (CGFloat)addTextField:(CGFloat)originY
{
    HWInputBackView *view = [[HWInputBackView alloc] initWithFrame:CGRectMake(0, originY, kScreenWidth, 45) withLineCount:1];
    [self.view addSubview:view];
    
    _textField = [UITextField newAutoLayoutView];
    [view addSubview:_textField];
    [self configTextField:_textField toView:view];
    
    return CGRectGetMaxY(view.frame);
}

-(void)configTextField:(UITextField *)textField toView:(UIView *)toView
{
    textField.layer.masksToBounds = YES;
    textField.placeholder = @"输入验证码";
    textField.backgroundColor = [UIColor whiteColor];
    textField.font = [UIFont fontWithName:FONTNAME size:15];
    textField.textColor = [UIColor blackColor];
    textField.clearButtonMode = UITextFieldViewModeWhileEditing;
    //布局
    [textField autoSetDimension:ALDimensionHeight toSize:15];
    [textField autoSetDimension:ALDimensionWidth toSize:kScreenWidth - 15 * 2];
    [textField autoAlignAxis:ALAxisHorizontal toSameAxisOfView:toView];
    [textField autoPinEdge:ALEdgeLeft toEdge:ALEdgeLeft ofView:toView withOffset:15];
}

- (CGFloat)addLabel
{
    UILabel *label = [UILabel newAutoLayoutView];
    [self.view addSubview:label];
    label.text = @"您的明信片已寄出，请耐心等待3-5个工作日";
    label.font = FONT(14);
    label.textColor = THEME_COLOR_TEXT;
    
    [label autoPinEdge:ALEdgeLeft toEdge:ALEdgeLeft ofView:self.view withOffset:15];
    [label autoPinEdge:ALEdgeTop toEdge:ALEdgeTop ofView:self.view withOffset:12];
    
    return 12 * 2 + [label systemLayoutSizeFittingSize:UILayoutFittingCompressedSize].height;
}

//联系客服按钮
- (void)communiteWithCustomerServiceBtn:(CGFloat)originY
{
    NSMutableAttributedString *string = [[NSMutableAttributedString alloc]initWithString:@"遇到问题，联系客服"];
    [string addAttribute:NSForegroundColorAttributeName value:(id)THEME_COLOR_TEXT range:NSMakeRange(0, [string length])];
    [string addAttribute:NSUnderlineStyleAttributeName value:(id)[NSNumber numberWithInt:NSUnderlineStyleSingle] range:NSMakeRange(0, [string length])];
    [string addAttribute:NSFontAttributeName value:(id)FONT(14) range:NSMakeRange(0, [string length])];
    
    UILabel *label = [UILabel newAutoLayoutView];
    [self.view addSubview:label];
    label.backgroundColor = [UIColor clearColor];
    label.attributedText = string;
    label.userInteractionEnabled = YES;
    
    [label autoPinEdge:ALEdgeRight toEdge:ALEdgeRight ofView:self.view withOffset:-15];
    [label autoPinEdge:ALEdgeTop toEdge:ALEdgeTop ofView:self.view withOffset:originY + 15];
    
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(callService)];
    [label addGestureRecognizer:tap];
}

- (void)callService
{
    [self.view endEditing:YES];
    
    NSLog(@"拨打客服电话");
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"提示" message:@"拨打客服电话" delegate:nil cancelButtonTitle:@"取消" otherButtonTitles:@"确定", nil];
    [alert show];
}

- (void)configUI
{
    CGFloat height1 = [self addLabel];
    CGFloat height2 = [self addTextField:height1];
    CGFloat height3 = [self addConfigBtn:height2];
    [self communiteWithCustomerServiceBtn:height3];
    
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(toTap)];
    [self.view addGestureRecognizer:tap];
}

- (void)toTap
{
    [self.view endEditing:YES];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
