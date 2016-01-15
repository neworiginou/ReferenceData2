//
//  WYYCOrderPayViewController.m
//  无忧云车司机
//
//  Created by luosai19910103@163.com on 15/7/6.
//  Copyright (c) 2015年 wuyouyunche. All rights reserved.
//

typedef enum
{
    payOrder =0,
    commentOrder,
    finishedOrder
}OrderStatus;
#import "WYYCOrderPayViewController.h"
#import "HCSStarRatingView.h"
#import "WYYC.h"
#import "WYYCConst.h"
#import "AppDelegate.h"
@interface WYYCOrderPayViewController ()<UITextViewDelegate>

//客户头像
@property (weak, nonatomic) IBOutlet UIImageView *customerIcon;
//客户名称
@property (weak, nonatomic) IBOutlet UILabel *customerName;

//预约次数
@property (weak, nonatomic) IBOutlet UILabel *preOrderCount;
//评分view
@property (weak, nonatomic) IBOutlet HCSStarRatingView *avgRatingStarView;
//出发地
@property (weak, nonatomic) IBOutlet UILabel *startPlace;
//目的地
@property (weak, nonatomic) IBOutlet UILabel *destination;
// 应付金额
@property (weak, nonatomic) IBOutlet UILabel *cost;

//等待时间
@property (weak, nonatomic) IBOutlet UILabel *waitingTime;
//总价
@property (weak, nonatomic) IBOutlet UILabel *totalPrice;
//行驶里程
@property (weak, nonatomic) IBOutlet UILabel *distance;
//优惠价
@property (weak, nonatomic) IBOutlet UILabel *voucherPrice;
//客服联系电话
@property (weak, nonatomic) IBOutlet UILabel *linkPhone;



//底部按钮
@property (weak,nonatomic) UIButton *buttomBtn;
//成功付款页面
@property (weak, nonatomic) IBOutlet UIView *orderPayView;
//评分view
@property (weak, nonatomic) IBOutlet HCSStarRatingView *commentRatingView;
//评价内容
@property (weak, nonatomic) IBOutlet UITextView *commentContent;

//评价页面
@property (weak, nonatomic) IBOutlet UIView *commentView;
//订单完成页面
@property (weak, nonatomic) IBOutlet UIView *orderFinishedView;
@property (nonatomic,strong) WYYCOrder *order;
@property (nonatomic, strong) AppDelegate *appDelegate;
@end

@implementation WYYCOrderPayViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setup];

    //出发地 目的地
    self.order =self.appDelegate.order ;

    self.startPlace.text = self.order.startPlace ;
    self.destination.text = self.order.destination ;
}

- (AppDelegate *)appDelegate
{
    return (AppDelegate *)[[UIApplication sharedApplication]delegate];
}
- (void)setup
{
    self.cost.textColor =ORANGE_COLOR ;
    self.avgRatingStarView.tintColor = ORANGE_COLOR ;
    self.avgRatingStarView.enabled = NO ;
    self.avgRatingStarView.value = 3;
    self.commentRatingView.value = 2;
    self.commentRatingView.tintColor = ORANGE_COLOR ;
    
    UIButton *buttomBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [buttomBtn setTitle:@"付款成功" forState:UIControlStateNormal];
    [buttomBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [buttomBtn addTarget:self action:@selector(clickButton) forControlEvents:UIControlEventTouchUpInside];
    UIWindow *window =  [[UIApplication sharedApplication] keyWindow] ;
    [window addSubview:buttomBtn];
    buttomBtn.frame = CGRectMake(0,CGRectGetMaxY(window.frame)-49, window.frame.size.width, 49);
    [buttomBtn setBackgroundColor:BLUE_COLOR];
    [window addSubview:buttomBtn];
    buttomBtn.tag = payOrder ;
    self.buttomBtn =  buttomBtn;
    
    

    self.commentView.hidden = YES ;
    self.orderFinishedView.hidden =YES ;
    
    self.edgesForExtendedLayout = UIRectEdgeNone ;
    self.navigationItem.title = @"申代驾";
    self.navigationItem.leftBarButtonItem =[[UIBarButtonItem alloc]initWithImage:[UIImage imageNamed:@"navigation_back"]style:UIBarButtonItemStylePlain target:self action:@selector(popViewController) ];


    
}
#pragma - mark 点击底部按钮
- (void)clickButton{
    
    switch (self.buttomBtn.tag) {
        case payOrder:
            self.buttomBtn.tag = commentOrder ;
            [self.buttomBtn setTitle:@"提交评论" forState:UIControlStateNormal];
            self.commentView.hidden = NO ;
            self.orderPayView.hidden = YES;
            self.appDelegate.order.orderStatusCode = orderFinishedPayStatus;
            //订单完成，该页面消失。
            [WYYCNOTIFICATION postNotificationName:WYYCDidFinishedOrderNotification object:nil];
            
            break;
        case commentOrder:
            self.buttomBtn.tag = finishedOrder ;
            [self.buttomBtn setTitle:@"返回首页" forState:UIControlStateNormal];
            self.commentView.hidden = YES ;
            self.orderFinishedView.hidden = NO;
            self.appDelegate.order.orderStatusCode = orderFinishedCommentStatus ;
            //订单完成，该页面消失。
            [WYYCNOTIFICATION postNotificationName:WYYCDidFinishedOrderNotification object:nil];
            
            break;
        case finishedOrder:
            //订单完成，该页面消失。
            [WYYCNOTIFICATION postNotificationName:WYYCDidFinishedOrderNotification object:nil];
            [self popViewController];
            break;
        default:
            break;
    }
        
    
    
}
- (void)popViewController
{

        [self.navigationController popToRootViewControllerAnimated:YES ];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)callPhone:(id)sender {
    
}
#pragma - mark 回车隐藏键盘
- (BOOL)textView:(UITextView *)textView shouldChangeTextInRange:(NSRange)range replacementText:(NSString *)text
{
    if ([text isEqualToString:@"\n"])
    {  [textView resignFirstResponder];
        return NO;
    }
    return YES;
}
- (void)viewWillAppear:(BOOL)animated
{
    self.commentContent.delegate =self;
    
}
- (void)viewWillDisappear:(BOOL)animated
{
    [self.buttomBtn removeFromSuperview];
    self.commentContent.delegate =nil ;

    if (self.buttomBtn.tag== finishedOrder) {
        self.appDelegate.order = nil;
    }
        self.appDelegate.order = self.order ;
}

@end
