//
//  WYYCCreatOrderViewController.m
//  无忧云车司机
//
//  Created by luosai19910103@163.com on 15/7/1.
//  Copyright (c) 2015年 wuyouyunche. All rights reserved.
//
#import "WYYC.h"
#import "WYYCCreatOrderViewController.h"
#import "AFNetworking.h"
#import "WYYCOrderWaitingAndProcesingViewController.h"
#import "MJExtension.h"
#import "WYYCConst.h"
#import "AppDelegate.h"
@interface WYYCCreatOrderViewController ()<UITextFieldDelegate,UIAlertViewDelegate>
@property (weak, nonatomic) IBOutlet UITextField *phoneNum;
@property (weak, nonatomic) IBOutlet UITextField *customerName;
@property (weak, nonatomic) IBOutlet UITextField *startPlace;
@property (weak, nonatomic) IBOutlet UITextField *carLisence;
@property (weak, nonatomic) IBOutlet UITextField *carType;
@property (weak, nonatomic) UIButton *creatOrderBtn;
@property (nonatomic,strong)  AFHTTPRequestOperationManager *manager ;
@property (weak, nonatomic) IBOutlet UIView *cartypeView;

// 车辆检查
@property (nonatomic ,assign) BOOL isCarChecked;

@property (nonatomic, strong) WYYCOrder *order;
@property (strong ,nonatomic) AppDelegate *appDelegate;
@end

@implementation WYYCCreatOrderViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setup];
    
    self.order = self.appDelegate.order;

    self.startPlace.text=self.appDelegate.order.startPlace;
    NSLog(@"self.startPlace.text:%@",self.startPlace.text);
     self.manager = [AFHTTPRequestOperationManager manager];

}

- (AppDelegate *)appDelegate
{
    _appDelegate= (AppDelegate *)[[UIApplication sharedApplication]delegate];
    return _appDelegate;
}

- (void)setup
{
    self.navigationItem.title = @"申代驾";
    UIButton *creatOrderBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [creatOrderBtn setTitle:@"创建订单" forState:UIControlStateNormal];
    [creatOrderBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [creatOrderBtn addTarget:self action:@selector(creatOrder) forControlEvents:UIControlEventTouchUpInside];
    UIWindow *window =  [[UIApplication sharedApplication] keyWindow] ;
    [window addSubview:creatOrderBtn];
    creatOrderBtn.frame = CGRectMake(0,CGRectGetMaxY(window.frame)-49, window.frame.size.width, 49);
    [creatOrderBtn setBackgroundColor:BLUE_COLOR];
    self.creatOrderBtn =  creatOrderBtn;


}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



- (void)creatOrder {

    if (self.isCarChecked) {
    
        WYYCOrderWaitingAndProcesingViewController *orderDetailVC = [[WYYCOrderWaitingAndProcesingViewController alloc]init];
        self.appDelegate.order.orderStatusCode = orderDuringDrivingStatus;
        [self.navigationController pushViewController:orderDetailVC animated:YES];

        return;
    }
    

    if (self.phoneNum.text.length >0 && self.startPlace.text.length>0) {
        
       
        self.order.linkPhoneNumber = self.phoneNum.text ;
        NSDate *nowDate = [NSDate date];
        nowDate = [nowDate dateByAddingTimeInterval:600];
        NSDateFormatter *formatter = [[NSDateFormatter alloc]init];
        [formatter setDateFormat:@"YYYY-MM-dd HH:mm:ss"];
        NSString *dateStr = [formatter stringFromDate:nowDate];
        NSLog(@"self.order.linkPhoneNumber:%@%@",self.order.linkPhoneNumber,self.phoneNum.text);
        NSDictionary *param = @{@"submittype":@"司机自助下单",
                                 @"tel":self.order.linkPhoneNumber,
                                 @"username":@"abc",
                                 @"psw":@"123",
                                 @"source":@"无忧APP-IOS",
                                 @"city":self.order.orderCity,
                                 @"s_addr":self.order.startPlace,
                                 @"x":self.order.latitude,
                                 @"y":self.order.longitude,
                                 @"preset_time":dateStr,
                                 @"type":@"及时代驾"
                                 
                                 };
        
        
        NSMutableDictionary * params =[[NSMutableDictionary alloc]init];
        if (self.carLisence.text.length>0) {
            [params setObject:self.carLisence.text forKey:@"carid"];
        }
        [params setDictionary:param];
            
        NSLog(@"para: %@",[self logDic:params]);

        NSString *urlString = [NSString stringWithFormat:@"%@%@",WYYC_PREFIX,ORDER_SUBMIT];
        
        [self.manager POST:urlString parameters:params success:^(AFHTTPRequestOperation *operation, NSDictionary* responseObject) {
            
         NSLog(@"para: %@",[self logDic:responseObject]);
            
            NSData *data = [NSJSONSerialization dataWithJSONObject:responseObject options:NSJSONWritingPrettyPrinted error:nil];
//            
            NSDictionary *dic = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableLeaves error:nil];
            NSNumber *code = [dic objectForKey:@"code"];
            self.order.orderId = [dic objectForKey:@"result"];
            
            if ([code intValue] ==200) {
                //发通知，告知主页有订单
                [WYYCNOTIFICATION postNotificationName:WYYCDidAcceptedOrderNotification object:nil];
                UIAlertView *alert =[[UIAlertView alloc]initWithTitle:@"" message:@"开车前请与客户协商并检查客户车辆" delegate:self cancelButtonTitle:@"稍等" otherButtonTitles:
                                     @"已检查", nil];
                
                [alert show];
         
           }
                     
        } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
            
            NSLog(@"error: %@",error);
        }];
       
    }
}

- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    if (buttonIndex ==1) {
        self.isCarChecked = YES ;
    }
}


- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
    [textField resignFirstResponder];
    if (textField.tag==4) {
        [self creatOrder];
    }
    return YES;
}

- (void)viewWillAppear:(BOOL)animated
{
    self.phoneNum.delegate=self;
    self.startPlace.delegate=self;
    self.carType.delegate = self;
    self.carLisence.delegate = self;
    self.customerName.delegate = self;
    

}
- (void)viewWillDisappear:(BOOL)animated
{
    if (self.creatOrderBtn) {
        [self.creatOrderBtn removeFromSuperview];
    }

}

- (NSString *)logDic:(NSDictionary *)dic {
    if (![dic count]) {
        return nil;
    }
    NSString *tempStr1 =
    [[dic description] stringByReplacingOccurrencesOfString:@"\\u"
                                                 withString:@"\\U"];
    NSString *tempStr2 =
    [tempStr1 stringByReplacingOccurrencesOfString:@"\"" withString:@"\\\""];
    NSString *tempStr3 =
    [[@"\"" stringByAppendingString:tempStr2] stringByAppendingString:@"\""];
    NSData *tempData = [tempStr3 dataUsingEncoding:NSUTF8StringEncoding];
    NSString *str =
    [NSPropertyListSerialization propertyListFromData:tempData
                                     mutabilityOption:NSPropertyListImmutable
                                               format:NULL
                                     errorDescription:NULL];
    return str;
}

@end


