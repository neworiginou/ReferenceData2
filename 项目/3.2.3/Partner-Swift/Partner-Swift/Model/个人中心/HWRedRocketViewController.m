//
//  HWRedRocketViewController.m
//  Partner-Swift
//
//  Created by gusheng on 15/5/24.
//  Copyright (c) 2015年 caijingpeng.haowu. All rights reserved.
//

#import "HWRedRocketViewController.h"
#import "Utility-OC.h"
#import "Partner-Bridging-Header.h"
#import "Utility-OC.h"

#import "HWMoneyViewController.h"
#import "PurseTableViewCell.h"
#import "WalletDetailViewController.h"
#import "HWForgotMoneyPasswordController.h"
#import <CoreText/CoreText.h>
#import "HWMyCardViewController.h"
#import "HWMoneyPasswordManagerController.h"
#import "HWAddCardViewController.h"
#import "HWMoneyPasswordController.h"
#import "ExtractViewController.h"
#import "Partner_Swift-Swift.h"
#import "Define-OC.h"
#import "Utility-OC.h"
@interface HWRedRocketViewController ()
{
    NSArray *tipArray;
}
@end

@implementation HWRedRocketViewController
@synthesize sourceStr;
@synthesize redIdStr;
@synthesize moneyStr;
- (void)viewDidLoad
{
    [super viewDidLoad];
    self.view.backgroundColor = UIColorFromRGB(0xea4425);
    self.navigationItem.titleView = [Utility_OC navTitleView:@"刮红包"];
    self.navigationItem.leftBarButtonItem = [Utility_OC navLeftBackBtn:self action:@selector(backMethod)];
    UIScrollView *backScrollView = [[UIScrollView alloc]initWithFrame:self.view.frame];
    backScrollView.contentSize = CGSizeMake(0, 500);
    backScrollView.backgroundColor = [UIColor clearColor];
    backScrollView.showsHorizontalScrollIndicator = NO;
    backScrollView.showsVerticalScrollIndicator = NO;
    [self.view addSubview:backScrollView];
    sourceStr = @"1";
    tipArray = @[@"小手一抖，5元到手！",@"任何大财富都是由小钱积累的，5元收罗囊中！",@"机会总是留给努力的人，这5元就是证明！",@"姿势很重要，姿势对了，钱就有了，5元到手！",@"刮红包，讲究的就是人品，人品值5元。"];
    
    UIImageView *backIV = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, kScreenWidth, 245 * kScreenReverseRate0C)];
    backIV.image = [UIImage imageNamed:@"gua_bg"];
    backIV.backgroundColor = [UIColor clearColor];
    backIV.userInteractionEnabled = YES;
    [backScrollView addSubview:backIV];
    
    UILabel *guaLabel = [[UILabel alloc]initWithFrame:CGRectMake(0, 120, kScreenWidth, 80)];
    if (IPHONE6)
    {
        guaLabel.frame = CGRectMake(0, 140, kScreenWidth, 80);
    }
    else if(IPHONE6PLUS)
    {
        guaLabel.frame = CGRectMake(0, 155, kScreenWidth, 80);
    }
    guaLabel.textAlignment = NSTextAlignmentCenter;
    guaLabel.textColor = [UIColor whiteColor];
    guaLabel.backgroundColor = [UIColor clearColor];
    guaLabel.font = [UIFont fontWithName:FONTNAME size:30];
    guaLabel.numberOfLines = 2;
    [backScrollView addSubview:guaLabel];
    
    UIView *redPacketBg = [[UIImageView alloc]initWithFrame:CGRectMake(kScreenWidth/2-131, CGRectGetMaxY(backIV.frame)+20, 262, 145)];
    redPacketBg.backgroundColor = UIColorFromRGB(0xffd766);
    UIImageView *redPacketImage = [[UIImageView alloc]initWithFrame:CGRectMake(redPacketBg.frame.origin.x-10, redPacketBg.frame.origin.y-10, redPacketBg.frame.size.width+20, redPacketBg.frame.size.height+20)];
    redPacketImage.image = [UIImage imageNamed:@"gua_bg1"];
    redPacketImage.backgroundColor = [UIColor clearColor];
    [backScrollView addSubview:redPacketImage];
    [backScrollView addSubview:redPacketBg];
    
    UILabel *moneyLabel = [[UILabel alloc]initWithFrame:CGRectMake(0, 10, redPacketBg.frame.size.width, redPacketBg.frame.size.height/2.0)];
    moneyLabel.textAlignment = NSTextAlignmentCenter;
    moneyLabel.font = [UIFont fontWithName:FONTNAME size:50];
    moneyLabel.text = [NSString stringWithFormat:@"%@元",moneyStr];
    moneyLabel.backgroundColor = [UIColor clearColor];
    moneyLabel.textColor = UIColorFromRGB(0xec4426);
    [redPacketBg addSubview:moneyLabel];
    
    UILabel *subLabel = [[UILabel alloc]initWithFrame:CGRectMake(20, redPacketBg.frame.size.height/2.0 - 10, redPacketBg.frame.size.width - 40, redPacketBg.frame.size.height/2.0)];
    subLabel.textColor = UIColorFromRGB(0x333333);
    subLabel.font = [UIFont fontWithName:FONTNAME size:14];
    subLabel.numberOfLines = 0;
    subLabel.textAlignment = NSTextAlignmentCenter;
    [redPacketBg addSubview:subLabel];
    
    int a = arc4random() % 5;
    NSString *tip = [tipArray objectAtIndex:a];
    subLabel.text =  [tip stringByReplacingOccurrencesOfString:@"5" withString:moneyStr];
    [redPacketBg addSubview:subLabel];
    
    guaLabel.text = @"恭喜你~\n获得红包一个";
    guaLabel.textColor = UIColorFromRGB(0xffe103);
    
    STScratchView *stView = [[STScratchView alloc]initWithFrame:redPacketBg.frame];
    stView.delegate = self;
    
    UIImageView *img = [[UIImageView alloc] initWithFrame:CGRectMake(29, 165, 262, 133)];
    [img setImage:[UIImage imageNamed:@"gua_bg2"]];
    [stView setHideView:img];
    [backScrollView addSubview:stView];
    
    if ([sourceStr isEqualToString:@"1"])
    {
        UIButton *myRedBtn = [[UIButton alloc]initWithFrame:CGRectMake(0, CONTENT_HEIGHT-45, kScreenWidth/2, 45)];
        [myRedBtn setTitle:@"我的红包" forState:UIControlStateNormal];
        [myRedBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [myRedBtn addTarget:self action:@selector(comeinMyred) forControlEvents:UIControlEventTouchUpInside];
        myRedBtn.backgroundColor = UIColorFromRGB(0x999999);
        myRedBtn.backgroundColor = [UIColor lightGrayColor];
        [self.view addSubview:myRedBtn];
        
        
        
        UIButton *shareBtn = [[UIButton alloc]initWithFrame:CGRectMake(kScreenWidth/2, CONTENT_HEIGHT-45, kScreenWidth/2, 45)];
        [shareBtn setTitle:@"继续分享" forState:UIControlStateNormal];
        [shareBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [shareBtn addTarget:self action:@selector(comeinShare) forControlEvents:UIControlEventTouchUpInside];
        shareBtn.backgroundColor = UIColorFromRGB(0xfe9200);
        [self.view addSubview:shareBtn];
    }
}
//继续分享
-(void)comeinShare
{
     [[NSNotificationCenter defaultCenter] postNotificationName:@"queryListData" object:nil];
    [self.navigationController popViewControllerAnimated:YES];
}
-(void)backMethod
{
    [[NSNotificationCenter defaultCenter] postNotificationName:@"queryListData" object:nil];
    [self.navigationController popViewControllerAnimated:YES];
}
//进入我的红包页面
-(void)comeinMyred
{
    HWRedPaperViewController  *redV = [[HWRedPaperViewController alloc]init];
    [self.navigationController pushViewController:redV animated:YES];
}
-(void)passResult:(BOOL)result
{
    if([redIdStr length]==0)
    {
        return;
    }
    HWHttpRequestOperationManager *manager = [HWHttpRequestOperationManager baseManager];
    NSMutableDictionary *param = [NSMutableDictionary dictionary];
    [param setPObject:[HWUserLogin currentUserLogin].key forKey:@"key"];
    [param setPObject:redIdStr forKey:@"redId"];
    [manager postHttpRequest:OpenRedPocket parameters:param queue:nil success:^(NSDictionary *responseObject) {
    NSDictionary *dic = [[NSDictionary dictionaryWithDictionary:responseObject]dictionaryObjectForKey:@"data"];
    float money = [[dic stringObjectForKey:@"money"]floatValue];
    NSString *moneyTempStr = [NSString stringWithFormat:@"%.2f",money];
    NSString *str = [NSString stringWithFormat:@"本次收取平台服务费￥%@,您实际获取的奖励金额为￥%@",[dic stringObjectForKey:@"serviceMoney"],moneyTempStr];
        
        
    UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@"提示" message:str delegate:nil cancelButtonTitle:nil otherButtonTitles:@"确定", nil];
    [alert performSelectorOnMainThread:@selector(show) withObject:nil waitUntilDone:YES];
        
    } failure:^(NSString *code, NSString *error) {
        
    }];


}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}

@end
