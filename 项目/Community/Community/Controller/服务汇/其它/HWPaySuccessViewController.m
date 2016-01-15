//
//  HWPaySuccessViewController.m
//  Community
//
//  Created by caijingpeng.haowu on 14-12-9.
//  Copyright (c) 2014年 caijingpeng. All rights reserved.
//

#import "HWPaySuccessViewController.h"

@interface HWPaySuccessViewController ()

@end

@implementation HWPaySuccessViewController
@synthesize payResult;

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.navigationItem.titleView = [Utility navTitleView:@"支付成功"];
    self.navigationItem.leftBarButtonItem = [Utility navLeftBackBtn:self action:@selector(backMethod)];
    
    UIView *backView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, 165)];
    
    if (payResult.samePriceTimes.intValue > 1)
    {
        backView.backgroundColor = UIColorFromRGB(0xe15c5e);
    }
    else
    {
        backView.backgroundColor = THEME_COLOR_ORANGE;
    }
    
    [self.view addSubview:backView];
    
    UILabel *priceLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 85, 85)];
    priceLabel.center = CGPointMake(kScreenWidth / 2.0f, 13 + 85 / 2.0f);
    priceLabel.backgroundColor = [UIColor whiteColor];
    priceLabel.layer.cornerRadius = 85 / 2.0f;
    priceLabel.layer.masksToBounds = YES;
    priceLabel.textAlignment = NSTextAlignmentCenter;
    priceLabel.text = [NSString stringWithFormat:@"%@元",payResult.cutPrice];
    priceLabel.textColor = THEME_COLOR_SMOKE;
    priceLabel.font = [UIFont boldSystemFontOfSize:THEME_FONT_BIG + 2];
    priceLabel.adjustsFontSizeToFitWidth = YES;
    [self.view addSubview:priceLabel];
    
    UILabel *infoLab = [[UILabel alloc] initWithFrame:CGRectMake(0, CGRectGetMaxY(priceLabel.frame) + 6, kScreenWidth, 20)];
    infoLab.backgroundColor = [UIColor clearColor];
    infoLab.textAlignment = NSTextAlignmentCenter;
    infoLab.font = [UIFont boldSystemFontOfSize:THEME_FONT_BIG];
    infoLab.textColor = [UIColor whiteColor];
    if (payResult.samePriceTimes.intValue > 1)
    {
        infoLab.text = @"这个价格太热了";
    }
    else
    {
        infoLab.text = @"暂时是唯一的";
    }
    
    [self.view addSubview:infoLab];
    
    UILabel *infoLab2 = [[UILabel alloc] initWithFrame:CGRectMake(0, CGRectGetMaxY(infoLab.frame), kScreenWidth, 20)];
    infoLab2.backgroundColor = [UIColor clearColor];
    infoLab2.textAlignment = NSTextAlignmentCenter;
    infoLab2.font = [UIFont boldSystemFontOfSize:THEME_FONT_BIG];
    infoLab2.textColor = [UIColor whiteColor];
    
//    NSString *countStr = @"4";
    
    
    
    
    if (self.payResult.samePriceTimes.intValue > 1)
    {
//        if (self.payResult.samePriceTimes.intValue <= 1)
//        {
//            NSMutableAttributedString *string = [[NSMutableAttributedString alloc]initWithString:[NSString stringWithFormat:@"已经有%@个更低唯一价", payResult.uniqueLowerTimes]];
//            [string addAttribute:NSForegroundColorAttributeName value:(id)[UIColor orangeColor] range:NSMakeRange(3, payResult.uniqueLowerTimes.length)];
//            infoLab2.attributedText = string;
//        }
//        else
//        {
            NSMutableAttributedString *string = [[NSMutableAttributedString alloc]initWithString:[NSString stringWithFormat:@"已经有%@个家伙出这个价", payResult.samePriceTimes]];
            [string addAttribute:NSForegroundColorAttributeName value:(id)[UIColor orangeColor] range:NSMakeRange(3, payResult.samePriceTimes.length)];
            infoLab2.attributedText = string;
//        }
//        infoLab2.text = @"已经有4个家伙出这个价";
    }
    else
    {
        if (self.payResult.uniqueLowerTimes.intValue > 0)
        {
            // 不是最低
            NSMutableAttributedString *string = [[NSMutableAttributedString alloc]initWithString:[NSString stringWithFormat:@"有%@个更低唯一价", payResult.uniqueLowerTimes]];
            [string addAttribute:NSForegroundColorAttributeName value:(id)THEME_COLOR_MONEY range:NSMakeRange(1, payResult.uniqueLowerTimes.length)];
            infoLab2.attributedText = string;
        }
        else
        {
            // 唯一最低
            infoLab2.text = @"";
        }
//        infoLab2.text = @"有5个更低唯一价";
    }
    
    
    [self.view addSubview:infoLab2];
    
    UIImageView *championImgV = [[UIImageView alloc] initWithFrame:CGRectMake(15, CGRectGetMaxY(backView.frame) + 30, 60, 60)];
    championImgV.image = [UIImage imageNamed:@"king"];
    [self.view addSubview:championImgV];
    
    UILabel *championTitLab = [[UILabel alloc] initWithFrame:CGRectMake(15, CGRectGetMaxY(championImgV.frame) + 5, 60, 20)];
    championTitLab.backgroundColor = [UIColor clearColor];
    championTitLab.textAlignment = NSTextAlignmentCenter;
    championTitLab.font = [UIFont fontWithName:FONTNAME size:THEME_FONT_SMALL];
    championTitLab.textColor = THEME_COLOR_GRAY_MIDDLE;
    championTitLab.text = @"砍价王";
    [self.view addSubview:championTitLab];
    
    
    
    UIImageView *puppleImgV = [[UIImageView alloc] initWithFrame:CGRectMake(CGRectGetMaxX(championImgV.frame) + 10, CGRectGetMinY(championImgV.frame), kScreenWidth - (CGRectGetMaxX(championImgV.frame) + 10) - 15.0f, 70)];
    puppleImgV.image = [[UIImage imageNamed:@"paySuccessPupple"] resizableImageWithCapInsets:UIEdgeInsetsMake(40, 20, 10, 10)];
    [self.view addSubview:puppleImgV];
    
    NSString *string;
    
    if (payResult.isLowest.intValue == 0)
    {
        string = @"对于土豪来说，用次数打败对手是最直接、有效的方式";
    }
    else
    {
        string = @"对于集人品、技术、长相与一身的人，挑战更低价才是最终目的";
    }
    
    UIFont *font = [UIFont fontWithName:FONTNAME size:THEME_FONT_SMALL];
    CGSize strSize = [Utility calculateStringHeight:string font:font constrainedSize:CGSizeMake(CGRectGetWidth(puppleImgV.frame) - 10 - 17, 1000)];
    
    CGRect frame = puppleImgV.frame;
    frame.size.height = strSize.height + 30;
    puppleImgV.frame = frame;
    
    UILabel *puppleLab = [[UILabel alloc] initWithFrame:CGRectMake(17, 10, CGRectGetWidth(puppleImgV.frame) - 10 - 17, strSize.height)];
    puppleLab.numberOfLines = 0;
    puppleLab.lineBreakMode = NSLineBreakByWordWrapping;
    puppleLab.backgroundColor = [UIColor clearColor];
    puppleLab.textColor = THEME_COLOR_SMOKE;
    puppleLab.font = font;
    puppleLab.text = string;
    [puppleImgV addSubview:puppleLab];
    
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    button.frame = CGRectMake(15, CGRectGetMaxY(backView.frame) + 135.0f, kScreenWidth - 30, 45.0f);
    [button setTitle:@"再来一次" forState:UIControlStateNormal];
    [button setButtonOrangeStyle];
    [button addTarget:self action:@selector(toCutAgain:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:button];
}

- (void)toCutAgain:(id)sender
{
    [self.navigationController popViewControllerAnimated:YES];
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
