//
//  HWRedDetailViewController.m
//  HaoWu_4.0
//
//  Created by zhangxun on 14-8-1.
//  Copyright (c) 2014年 caijingpeng. All rights reserved.
//

#import "HWRedDetailViewController.h"
#import "Utility.h"
#import "RedPacketView.h"

@interface HWRedDetailViewController ()

@property (nonatomic,strong)NSArray *tipArray;

@end

@implementation HWRedDetailViewController
@synthesize tipArray;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (id)initWithRedObj:(HWRedPacketObject *)redObject waitTime:(NSInteger)time{
    self = [super init];
    if (self) {
        _theRedObject = redObject;
        _theWaitTime = time;
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    self.navigationItem.titleView = [Utility navTitleView:@"刮红包"];
    self.navigationItem.leftBarButtonItem = [Utility navLeftBackBtn:self action:@selector(backMethod)];
    
    
    
    tipArray = @[@"小手一抖，5元到手！",@"任何大财富都是由小钱积累的，5元收罗囊中！",@"机会总是留给努力的人，这5元就是证明！",@"姿势很重要，姿势对了，钱就有了，5元到手！",@"刮红包，讲究的就是人品，人品值5元。"];
    
    UIImageView *backIV = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, kScreenWidth, [UIScreen mainScreen].bounds.size.height - 20)];
    if (IPHONE5)
    {
        backIV.image = [UIImage imageNamed:@"redbg_ip5"];
    }
    else
    {
        backIV.image = [UIImage imageNamed:@"redbg_ip4"];
    }
    
    backIV.backgroundColor = [UIColor orangeColor];
    backIV.userInteractionEnabled = YES;
    [self.view addSubview:backIV];
    
    UILabel *guaLabel = [[UILabel alloc]initWithFrame:CGRectMake(0, IPHONE5 ? 65 : 40, kScreenWidth, 80)];
    guaLabel.textAlignment = NSTextAlignmentCenter;
    guaLabel.textColor = [UIColor whiteColor];
    guaLabel.backgroundColor = [UIColor clearColor];
    guaLabel.font = [UIFont boldSystemFontOfSize:30];
    guaLabel.numberOfLines = 2;
    [backIV addSubview:guaLabel];
    
    UIView *redPacketBg = [[UIView alloc]initWithFrame:CGRectMake(29, 202, 262, 145)];
    
    
    if (!IPHONE5)
    {
        redPacketBg.frame = CGRectMake(39, 158, 244, 137);
    }
    if (IPHONE6) {
        redPacketBg.frame = CGRectMake(29 + 16.5, 202 + 20, 262 + 24, 145 + 47);
    }
    if (IPHONE6PLUS) {
        redPacketBg.frame = CGRectMake(50, 246, 316, 212);
    }
    
    
    [backIV addSubview:redPacketBg];
    
    
    
    if ([_theRedObject.status isEqualToString:@"0"] || [_theRedObject.status isEqualToString:@"-1"])
    {
        redPacketBg.backgroundColor = [UIColor colorWithRed:208.0/255.0 green:208.0/255.0 blue:208.0/255.0 alpha:1];
        guaLabel.text = @"朋友买房预约成功\n即可解锁!";
        if (_theWaitTime <= 0)
        {
            guaLabel.text = @"该红包已过期";
            UILabel *tipLabel = [[UILabel alloc]initWithFrame:CGRectMake(0, 40, redPacketBg.frame.size.width, 20)];
            tipLabel.backgroundColor = [UIColor clearColor];
            tipLabel.textColor = [UIColor grayColor];
            tipLabel.textAlignment = NSTextAlignmentCenter;
            tipLabel.font = [UIFont fontWithName:FONTNAME size:14];
            tipLabel.backgroundColor = [UIColor clearColor];
            tipLabel.text = @"至有效期";
            [redPacketBg addSubview:tipLabel];
            
            _countDownLabel = [[UILabel alloc]initWithFrame:CGRectMake(0, 70, redPacketBg.frame.size.width, 40)];
            _countDownLabel.textColor = [UIColor orangeColor];
            _countDownLabel.backgroundColor = [UIColor clearColor];
            _countDownLabel.textAlignment = NSTextAlignmentCenter;
            _countDownLabel.text = @"已过期";
            [redPacketBg addSubview:_countDownLabel];
        }
        else
        {
            UILabel *tipLabel = [[UILabel alloc]initWithFrame:CGRectMake(0, 40, redPacketBg.frame.size.width, 20)];
            tipLabel.textColor = [UIColor grayColor];
            tipLabel.textAlignment = NSTextAlignmentCenter;
            tipLabel.font = [UIFont fontWithName:FONTNAME size:14];
            tipLabel.backgroundColor = [UIColor clearColor];
            tipLabel.text = @"至有效期";
            [redPacketBg addSubview:tipLabel];
            
            _countDownLabel = [[UILabel alloc]initWithFrame:CGRectMake(0, 70, redPacketBg.frame.size.width, 40)];
            _countDownLabel.textColor = [UIColor orangeColor];
            _countDownLabel.backgroundColor = [UIColor clearColor];
            _countDownLabel.textAlignment = NSTextAlignmentCenter;
            [redPacketBg addSubview:_countDownLabel];
            
            [_theTimer invalidate];
            [self doCount];
            _theTimer = [NSTimer scheduledTimerWithTimeInterval:1 target:self selector:@selector(doCount) userInfo:nil repeats:YES];
        }
    }
    else if ([_theRedObject.status isEqualToString:@"1"])
    {
        redPacketBg.backgroundColor = [UIColor colorWithRed:208.0/255.0 green:208.0/255.0 blue:208.0/255.0 alpha:1];
        
        UILabel *moneyLabel = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, redPacketBg.frame.size.width + 10, redPacketBg.frame.size.height / 2.0)];
        moneyLabel.textAlignment = NSTextAlignmentCenter;
        moneyLabel.font = [UIFont fontWithName:FONTNAME size:30];
        moneyLabel.text = [NSString stringWithFormat:@"%@元",_theRedObject.rewardMoney];
        moneyLabel.backgroundColor = [UIColor clearColor];
        moneyLabel.textColor = UIColorFromRGB(0x8ACF1C);
        [redPacketBg addSubview:moneyLabel];
        
        UILabel *subLabel = [[UILabel alloc]initWithFrame:CGRectMake(20, redPacketBg.frame.size.height / 2.0f - 10, redPacketBg.frame.size.width - 40, redPacketBg.frame.size.height / 2.0f)];
        subLabel.textColor = UIColorFromRGB(0x8ACF1C);
        subLabel.font = [UIFont fontWithName:FONTNAME size:16.0f];
        subLabel.numberOfLines = 0;
        subLabel.textAlignment = NSTextAlignmentCenter;
        [redPacketBg addSubview:subLabel];
        
        int a = arc4random() % 5;
        NSString *tip = [tipArray objectAtIndex:a];
        subLabel.text =  [tip stringByReplacingOccurrencesOfString:@"5" withString:_theRedObject.rewardMoney];
        [redPacketBg addSubview:subLabel];
        
        guaLabel.text = @"刮一发~\n惊喜就在下一刻!";
        redPacketBg.backgroundColor = [UIColor colorWithRed:240.0/255.0 green:208.0/255.0 blue:137.0/255.0 alpha:1];
        
        STScratchView *stView = [[STScratchView alloc]initWithFrame:redPacketBg.frame];
        stView.delegate = self;
        
        UIImageView *img = [[UIImageView alloc] initWithFrame:stView.frame];
        [img setImage:[UIImage imageNamed:@"guagua"]];
        [stView setHideView:img];
        [backIV addSubview:stView];
        
    }else{
        UILabel *moneyLabel = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, redPacketBg.frame.size.width, redPacketBg.frame.size.height/2.0)];
        moneyLabel.textAlignment = NSTextAlignmentCenter;
        moneyLabel.font = [UIFont fontWithName:FONTNAME size:30];
        moneyLabel.backgroundColor = [UIColor clearColor];
        moneyLabel.text = [NSString stringWithFormat:@"%@元",_theRedObject.rewardMoney];
        moneyLabel.textColor = UIColorFromRGB(0x8ACF1C);
        [redPacketBg addSubview:moneyLabel];
        
        UILabel *subLabel = [[UILabel alloc]initWithFrame:CGRectMake(20, redPacketBg.frame.size.height / 2.0f - 10, redPacketBg.frame.size.width - 40, redPacketBg.frame.size.height / 2.0f)];
        subLabel.textColor = UIColorFromRGB(0x8ACF1C);
        subLabel.backgroundColor = [UIColor clearColor];
        subLabel.font = [UIFont fontWithName:FONTNAME size:16];
        subLabel.numberOfLines = 0;
        subLabel.textAlignment = NSTextAlignmentCenter;
        [redPacketBg addSubview:subLabel];
        
        int a = arc4random() % 5;
        NSString *tip = [tipArray objectAtIndex:a];
        subLabel.text =  [tip stringByReplacingOccurrencesOfString:@"5" withString:_theRedObject.rewardMoney];
        [redPacketBg addSubview:subLabel];
        
        guaLabel.text = @"刮一发~\n惊喜就在下一刻!";
        redPacketBg.backgroundColor = [UIColor colorWithRed:240.0/255.0 green:208.0/255.0 blue:137.0/255.0 alpha:1];
        
        STScratchView *stView = [[STScratchView alloc]initWithFrame:redPacketBg.frame];
        stView.delegate = self;
        
        UIImageView *img = [[UIImageView alloc] initWithFrame:stView.frame];
        [img setImage:[UIImage imageNamed:@"guagua"]];
        [stView setHideView:img];
        [backIV addSubview:stView];
        
    }
}

- (void)viewWillAppear:(BOOL)animated
{
    MLNavigationController *navigation = (MLNavigationController *)self.navigationController;
    navigation.canDragBack = NO;
}

- (void)viewWillDisappear:(BOOL)animated
{
    MLNavigationController *navigation = (MLNavigationController *)self.navigationController;
    navigation.canDragBack = YES;
}


- (void)doCount
{
    _theWaitTime --;
    if (_theWaitTime <= 0)
    {
        _countDownLabel.text = @"已过期";
        [_theTimer invalidate];
        return;
    }
    _countDownLabel.text = [NSString stringWithFormat:@"%d天%d时%d分%d秒", _theWaitTime / (3600 * 24), (_theWaitTime % (3600* 24))/3600,(_theWaitTime % 3600) / 60, _theWaitTime % 60];
    
}

- (void)passResult:(BOOL)result
{
    
    HWHTTPRequestOperationManager *manager = [HWHTTPRequestOperationManager societyManager];
    NSMutableDictionary *param = [NSMutableDictionary dictionary];
    [param setPObject:[HWUserLogin currentUserLogin].key forKey:@"key"];
    [param setPObject:_theRedObject.redId forKey:@"redId"];
    [param setPObject:@"1" forKey:@"channel"];
    [manager redPacketPost:kOpenRedPackage parameters:param queue:nil success:^(id responseObject) {
        NSDictionary *dic = [[NSDictionary dictionaryWithDictionary:responseObject]dictionaryObjectForKey:@"data"];
        NSString *str = [NSString stringWithFormat:@"恭喜你，扣除20%%平台服务费之后获得奖励金额￥%@",[dic stringObjectForKey:@"money"]];
        UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@"提示" message:str delegate:self cancelButtonTitle:nil otherButtonTitles:@"确定", nil];
        [alert performSelectorOnMainThread:@selector(show) withObject:nil waitUntilDone:YES];

    } failure:^(NSString *code, NSString *error) {
        
    }];
}

- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    if (buttonIndex == 0)
    {
        [self.navigationController popViewControllerAnimated:YES];
    }
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
