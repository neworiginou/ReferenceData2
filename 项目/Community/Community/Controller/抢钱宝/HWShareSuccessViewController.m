//
//  HWShareSuccessViewController.m
//  Community
//
//  Created by caijingpeng.haowu on 14-9-15.
//  Copyright (c) 2014年 caijingpeng. All rights reserved.
//

#import "HWShareSuccessViewController.h"

@interface HWShareSuccessViewController ()
{
    UIScrollView *_downView;
    UIView *_upView;
}
@end

@implementation HWShareSuccessViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.navigationItem.rightBarButtonItem = [Utility navButton:self title:@"完成" action:@selector(backMethod)];
    self.navigationItem.titleView = [Utility navTitleView:@"红包"];
    
    [self initialUpView];
    [self initialDownView];
    
    
}

- (void)viewWillAppear:(BOOL)animated
{
    MLNavigationController *mlNav = (MLNavigationController *)self.navigationController;
    mlNav.canDragBack = NO;
}

- (void)viewWillDisappear:(BOOL)animated
{
    MLNavigationController *mlNav = (MLNavigationController *)self.navigationController;
    mlNav.canDragBack = YES;
}

- (void)backMethod
{
    [[NSNotificationCenter defaultCenter] postNotificationName:@"DragRefresh" object:nil];
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)initialUpView
{
    _upView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, CONTENT_HEIGHT)];
    _upView.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:_upView];
    
    UISwipeGestureRecognizer *swipe = [[UISwipeGestureRecognizer alloc] initWithTarget:self action:@selector(showDownView)];
    swipe.direction = UISwipeGestureRecognizerDirectionUp;
    [_upView addGestureRecognizer:swipe];
    
    UILabel *titleLab = [[UILabel alloc] initWithFrame:CGRectMake(0, 25, kScreenWidth, 40)];
    titleLab.backgroundColor = [UIColor clearColor];
    titleLab.font = [UIFont boldSystemFontOfSize:20.0f];
    titleLab.text = @"分享成功，红包到手！";
    titleLab.textColor = THEME_COLOR_ORANGE;
    titleLab.textAlignment = NSTextAlignmentCenter;
    [_upView addSubview:titleLab];
    
    NSString *money = [self.shareInfo stringObjectForKey:@"money"];
    if (![money isEqualToString:@"0"] && ![money isEqualToString:@""])
    {
        UILabel *subTitle = [[UILabel alloc] initWithFrame:CGRectMake(20, CGRectGetMaxY(titleLab.frame), kScreenWidth - 40, 40)];
        subTitle.backgroundColor = [UIColor clearColor];
        subTitle.font = [UIFont boldSystemFontOfSize:14.0f];
        subTitle.text = [NSString stringWithFormat:@"恭喜你，扣除20%%平台服务费之后获得奖励金额￥%@", money];
        subTitle.numberOfLines = 0;
        subTitle.lineBreakMode = NSLineBreakByWordWrapping;
        subTitle.textColor = THEME_COLOR_TEXT;
        subTitle.textAlignment = NSTextAlignmentCenter;
        [_upView addSubview:subTitle];
    }
    
    
    
    UIImageView *mainImgV = [[UIImageView alloc] initWithFrame:CGRectMake(0, (CONTENT_HEIGHT - 205.0f) / 2.0f, 245, 205)];
    mainImgV.image = [UIImage imageNamed:@"shareSuccess"];
    [_upView addSubview:mainImgV];
    
    
    
    NSMutableAttributedString *string = [[NSMutableAttributedString alloc]initWithString:[NSString stringWithFormat:@"%@元",money]];
    [string addAttribute:NSForegroundColorAttributeName value:(id)[UIColor whiteColor] range:NSMakeRange(money.length, 1)];
    [string addAttribute:NSFontAttributeName value:(id)[UIFont boldSystemFontOfSize:60.0f] range:NSMakeRange(0, money.length)];
    [string addAttribute:NSFontAttributeName value:(id)[UIFont boldSystemFontOfSize:40.0f] range:NSMakeRange(money.length, 1)];
    
    UILabel *priceLab = [[UILabel alloc] initWithFrame:CGRectMake(115.0f, 95.0f, 85, 50)];
    priceLab.backgroundColor = [UIColor clearColor];
    priceLab.font = [UIFont boldSystemFontOfSize:20.0f];
    priceLab.textColor = [UIColor whiteColor];
    priceLab.textAlignment = NSTextAlignmentCenter;
    priceLab.adjustsFontSizeToFitWidth = YES;
    priceLab.attributedText = string;
    [mainImgV addSubview:priceLab];
    priceLab.transform = CGAffineTransformMakeRotation( - 10 / 180.0f * M_PI);
    
    UILabel *textLab = [[UILabel alloc] initWithFrame:CGRectMake(kScreenWidth - 180.0f - 10, CONTENT_HEIGHT - 100.0f, 180.0f, 25.0f)];
    textLab.backgroundColor = [UIColor clearColor];
    textLab.textColor = THEME_COLOR_TEXT;
    textLab.font = [UIFont fontWithName:FONTNAME size:12.0f];
    textLab.text = @"*可在“个人中心-我的钱包”里查看";
    [_upView addSubview:textLab];
    
    UIImageView *bottom = [[UIImageView alloc] initWithFrame:CGRectMake((kScreenWidth - 110) / 2.0f, CONTENT_HEIGHT - 50.0f, 110, 50)];
    bottom.image = [UIImage imageNamed:@"bottomImage"];
    [_upView addSubview:bottom];
    
    UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(0, 10.0f, 110.0f, 20)];
    label.font = [UIFont fontWithName:FONTNAME size:13.0f];
    label.textColor = [UIColor whiteColor];
    label.textAlignment = NSTextAlignmentCenter;
    label.text = @"红包小秘密";
    [bottom addSubview:label];
    
}

- (void)initialDownView
{
    _downView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, CONTENT_HEIGHT, kScreenWidth, CONTENT_HEIGHT)];
    _downView.backgroundColor = UIColorFromRGB(0xffcf3b);
    _downView.delegate = self;
    _downView.contentSize = CGSizeMake(kScreenWidth, 505);
    [self.view addSubview:_downView];
    
    
    UIImageView *bottomBack = [[UIImageView alloc] initWithFrame:CGRectMake((kScreenWidth - 320.0f) / 2.0f, _downView.contentSize.height - 214.0f, 320.0f, 214.0f)];
    bottomBack.image = [UIImage imageNamed:@"sharelight"];
    [_downView addSubview:bottomBack];
    
    UIImageView *bottomImgV = [[UIImageView alloc] initWithFrame:CGRectMake((kScreenWidth - 150.0f) / 2.0f + 10.0f, _downView.contentSize.height - 180.0f, 150.0f, 134.0f)];
    bottomImgV.image = [UIImage imageNamed:@"house2000"];
    [_downView addSubview:bottomImgV];
    
    UIImageView *calculateImgV = [[UIImageView alloc] initWithFrame:CGRectMake((kScreenWidth - 320.0f) / 2.0f, 85.0f, 320.0f, 170.0f)];
    calculateImgV.image = [UIImage imageNamed:@"calculateImage"];
    [_downView addSubview:calculateImgV];
    
    UILabel *titleLab = [[UILabel alloc] initWithFrame:CGRectMake(0, 20, kScreenWidth, 60.0f)];
    titleLab.backgroundColor = [UIColor clearColor];
    titleLab.numberOfLines = 2.0f;
    titleLab.font = [UIFont boldSystemFontOfSize:20.0f];
    titleLab.textAlignment = NSTextAlignmentCenter;
    titleLab.lineBreakMode = NSLineBreakByWordWrapping;
    titleLab.text = @"你分享到朋友圈中活动\n预约越多，红包越多";
    [_downView addSubview:titleLab];
    
    UILabel *subTitleLab = [[UILabel alloc] initWithFrame:CGRectMake(0, CGRectGetMaxY(calculateImgV.frame) + 25.0f, kScreenWidth, 25.0f)];
    subTitleLab.backgroundColor = [UIColor clearColor];
    subTitleLab.textAlignment = NSTextAlignmentCenter;
    subTitleLab.font = [UIFont boldSystemFontOfSize:20.0f];
    subTitleLab.text = @"你的朋友买了你分享的房子";
    [_downView addSubview:subTitleLab];
    
}

- (void)showDownView
{
    [UIView animateWithDuration:0.6f animations:^{
        CGRect frame = _downView.frame;
        frame.origin.y = 0;
        _downView.frame = frame;
        
        CGRect frame1 = _upView.frame;
        frame1.origin.y = -CONTENT_HEIGHT;
        _upView.frame = frame1;
    }];
}

- (void)showUpView
{
    [UIView animateWithDuration:0.6f animations:^{
        CGRect frame = _downView.frame;
        frame.origin.y = CONTENT_HEIGHT;
        _downView.frame = frame;
        
        CGRect frame1 = _upView.frame;
        frame1.origin.y = 0;
        _upView.frame = frame1;
    }];
}

- (void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate
{
    if (scrollView.contentOffset.y < -40)
    {
        [self showUpView];
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
