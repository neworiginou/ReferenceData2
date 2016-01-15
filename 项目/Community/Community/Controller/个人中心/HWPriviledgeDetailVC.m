//
//  HWPriviledgeDetailVC.m
//  TestOne
//
//  Created by gusheng on 14-12-8.
//  Copyright (c) 2014年 gusheng. All rights reserved.
//  功能描述：优惠券详情页
//
//  修改记录：
//      李中强 2015-01-30 添加注释
//

#import "HWPriviledgeDetailVC.h"
#import "HWGeneralControl.h"
#import "HWMyPriviledgeVC.h"
#import "MTCustomActionSheet.h"
#import "AppDelegate.h"
#import "HWMoneyViewController.h"
#import "WXApi.h"

@interface HWPriviledgeDetailVC ()
@property (nonatomic, strong) UILabel *timeTipLabel;
@property (nonatomic, strong) UILabel *hourMaoHaoLabel;
@property (nonatomic, strong) UILabel *minitueMaoHaoLabel;

@end

@implementation HWPriviledgeDetailVC
@synthesize activityTimeIV;
@synthesize hourLabel;
@synthesize minitueLabel;
@synthesize secondLabel;
@synthesize priviledgeTicketNumLabel;
@synthesize noActivityTimeTV;
@synthesize noPriviledgeTicketNumLabel;
@synthesize priviledgeLabel;
@synthesize brandLabel;
@synthesize startDateLabel;
@synthesize endDateLabel;
@synthesize shareBtn;
@synthesize priviledgeId;
@synthesize priviledgeIV;

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.view.backgroundColor = BACKGROUND_COLOR;
    self.navigationItem.titleView = [Utility navTitleView:@"优惠券详情"];
    self.navigationItem.leftBarButtonItem = [Utility navLeftBackBtn:self action:@selector(backMethod)];
    if ([Utility isNullQQAndWX])
    {
        self.navigationItem.rightBarButtonItem = nil;
        
    }
    else
    {
        self.navigationItem.rightBarButtonItem = [Utility navShareButton:self action:@selector(navSharePriviledge:)];
    }
    
    
    priviledgeDetailTableV = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, kScreenWidth, CONTENT_HEIGHT) style:UITableViewStylePlain];
    priviledgeDetailTableV.delegate = self;
    priviledgeDetailTableV.dataSource = self;
    priviledgeDetailTableV.separatorStyle = UITableViewCellSeparatorStyleNone;
    priviledgeDetailTableV.backgroundColor = BACKGROUND_COLOR;
    [self.view addSubview:priviledgeDetailTableV];
    
    [self createHeaderView];
    [self createFooterView];
    [self queryListData:priviledgeId];
    
}

- (void)backMethod
{
    //    if (_refershPriviledgeData) {
    //        _refershPriviledgeData(self.priviledgeId);
    //    }
    [self.navigationController popViewControllerAnimated:YES];
    
}
//创建FooterView
-(void)createFooterView
{
    UIView *footView =[HWGeneralControl createView:CGRectMake(0, 0, kScreenWidth, 87)];
    footView.backgroundColor = BACKGROUND_COLOR;
    priviledgeDetailTableV.tableFooterView = footView;
    
    shareBtn = [HWGeneralControl createButton:CGRectMake(12, 20, kScreenWidth-2*12, 46) font:19.0f buttonTitleColor:[UIColor whiteColor] imageStr:@"" backImage:@"" title:@"分享领券"];
    //    if ([priviledgeModel.priviledgeType isEqualToString:@"3"] || priviledgeModel.remainPriviledge.intValue == 0)
    //    {
    //        [shareBtn setTitle:@"分享" forState:UIControlStateNormal];
    //    }
    shareBtn.layer.cornerRadius = 5.0f;
    shareBtn.layer.masksToBounds = YES;
    if ([priviledgeModel.priviledgeType isEqualToString:@"1"])
    {
        shareBtn.backgroundColor = THEME_COLOR_GRAY;
    }
    else
    {
        shareBtn.backgroundColor = THEME_COLOR_ORANGE;
    }
    [shareBtn addTarget:self action:@selector(sharePriviledge:) forControlEvents:UIControlEventTouchUpInside];
    [footView addSubview:shareBtn];
    
    if ([Utility isNullQQAndWX])
    {
        shareBtn.hidden = YES;
    }
    else
    {
        shareBtn.hidden = NO;
    }
}
//
- (void)sharePriviledge:(id)sender
{
    [MobClick event:@"click_fenxiangdequan"];
    if ([HWUserLogin verifyBindMobileWithPopVC:self showAlert:YES])
    {
        if ([HWUserLogin verifyIsLoginWithPresentVC:self toViewController:nil])
        {
            if ([priviledgeModel.priviledgeType isEqualToString:@"1"] && [priviledgeModel.remainMS integerValue] > 0)
            {
                return;
            }
            else if ([priviledgeModel.priviledgeType isEqualToString:@"3"])
            {
                [self navSharePriviledge:nil];
                return;
            }
            shareType = YES;
            [self shareView];
        }
    }
}

- (void)navSharePriviledge:(id)sender
{
    [MobClick event:@"click_youshangjiaofenxiang"];
    shareType = NO;
    [self shareView];
}

- (void)shareView
{
    NSMutableArray *arrImage = [[NSMutableArray alloc] init];
    NSMutableArray *arrName = [[NSMutableArray alloc] init];
    if ([Utility isInstalledWX])
    {
        [arrImage addObject:@"share_weixin161"];
        [arrName addObject:@"朋友圈"];
    }
    if ([Utility isInstalledQQ])
    {
        [arrImage addObject:@"share_qzone161"];
        [arrName addObject:@"QQ空间"];
    }
    MTCustomActionSheet *actionSheet = [[MTCustomActionSheet alloc] initWithFrame:CGRectZero andImageArr:arrImage nameArray:arrName orientation:0];
    actionSheet.delegate = self;
    AppDelegate *appDel = (AppDelegate *)[UIApplication sharedApplication].delegate;
    [actionSheet showInView:appDel.window];
}
#pragma mark -
#pragma mark MTCustomActionSheet Delegate

- (void)actionSheet:(MTCustomActionSheet *)actionSheet didClickButtonByIndex:(int)index
{
    UIImage *shareImage = self.priviledgeIV.image;
    if ([shareImage isEqual:[UIImage imageNamed:IMAGE_PLACE]] || [shareImage isEqual:[UIImage imageNamed:IMAGE_BREAK_CUBE]])
    {
        shareImage = [UIImage imageNamed:@"Icon"];
    }
    
    NSString *url = [NSString stringWithFormat:@"%@?mKey=%@&shopName=%@&name=%@",
                     _priviledgeModel.shareUrl,
                     [NSString encodeToPercentEscapeString:_priviledgeModel.priviledgeImageUrl],
                     [NSString encodeToPercentEscapeString:_priviledgeModel.brandStr],
                     [NSString encodeToPercentEscapeString:_priviledgeModel.priviledgeContent]];
    if ([Utility isInstalledQQAndInstalledWX])
    {
        if (index == 0) // 分享微信朋友圈
        {
            if (![WXApi isWXAppInstalled]) {
                return;
            }
            [MobClick event:@"click_youhuiquanfenxiangpengyouquan"];
            
            NSString *shareText = [NSString stringWithFormat:@"%@在考拉社区发优惠券咯，优惠多多、福利多多！",[_priviledgeModel.brandStr length]>0?_priviledgeModel.brandStr:@""];
            NSString *titleStr = [NSString stringWithFormat:@"%@",[_priviledgeModel.priviledgeContent length] > 0 ? _priviledgeModel.priviledgeContent : DEFAULTSHARECONTENT];
            
            [UMSocialData defaultData].extConfig.wxMessageType = UMSocialWXMessageTypeApp;
            [UMSocialData defaultData].urlResource.url = url;
            [UMSocialData defaultData].extConfig.wechatTimelineData.url = url;
            [UMSocialData defaultData].extConfig.wechatSessionData.url = url;
            [UMSocialData defaultData].extConfig.title = titleStr;
            
            NSLog(@"%@",[UMSocialSnsPlatformManager sharedInstance].allSnsValuesArray);
            
            
            [[UMSocialDataService defaultDataService]  postSNSWithTypes:@[UMShareToWechatTimeline] content:shareText image:shareImage location:nil urlResource:nil presentedController:self completion:^(UMSocialResponseEntity *response)
             {
                 if (response.responseCode == UMSResponseCodeSuccess)
                 {
                     if (shareType == YES)
                     {
                         [self getPrivledgeSuccess];
                     }
                     else
                     {
                         [Utility showToastWithMessage:@"分享成功" inView:self.view];
                     }
                     
                 }
                 else
                 {
                     [Utility showToastWithMessage:@"分享失败" inView:self.view];
                 }
             }];
        }
        else if (index == 1) // 分享QQZone
        {
            //直接到QQ
            
            //分享数据的采集
            [MobClick event:@"click_youhuiquanfenxiangqqkongjian"];
            //        NSString *url = [NSString stringWithFormat:@"%@&way=5",_priviledgeModel.priviledgeUrl];
            NSString *shareText = [NSString stringWithFormat:@"%@在考拉社区发优惠券咯，优惠多多、福利多多！",[_priviledgeModel.brandStr length] > 0 ? _priviledgeModel.brandStr : DEFAULTSHARECONTENT];
            NSString *titleStr = [NSString stringWithFormat:@"%@",[_priviledgeModel.priviledgeContent length] > 0 ? _priviledgeModel.priviledgeContent : DEFAULTSHARECONTENT];
            
            //分享内容设置
            
            [UMSocialData defaultData].extConfig.qzoneData.url = url;
            [UMSocialData defaultData].extConfig.qzoneData.title = titleStr;
            [UMSocialData defaultData].extConfig.qzoneData.shareText = shareText;
            //        [UMSocialData defaultData].extConfig.qzoneData.shareImage = [UIImage imageNamed:@"icon.png"];
            [UMSocialData defaultData].extConfig.qzoneData.shareImage = UIImageJPEGRepresentation(shareImage,0.1f);
            //分享数据，平台设置   UMSocialQzoneData
            [[UMSocialDataService defaultDataService] postSNSWithTypes:@[UMShareToQzone] content:shareText image:nil location:nil urlResource:nil presentedController:self completion:^(UMSocialResponseEntity *response)
             {
                 if (response.responseCode == UMSResponseCodeSuccess)
                 {
                     if (shareType == YES)
                     {
                         [self getPrivledgeSuccess];
                     }
                     else
                     {
                         [Utility showToastWithMessage:@"分享成功" inView:self.view];
                     }
                 }
                 else
                 {
                     [Utility showToastWithMessage:@"分享失败" inView:self.view];
                 }
             }];
        }
        else
        {
            [MobClick event:@"click_youhuiquanquxiao"];
        }
    }
    else
    {
        if ([Utility isInstalledWX])
        {
            if (![WXApi isWXAppInstalled]) {
                return;
            }
            [MobClick event:@"click_youhuiquanfenxiangpengyouquan"];
            
            NSString *shareText = [NSString stringWithFormat:@"%@在考拉社区发优惠券咯，优惠多多、福利多多！",[_priviledgeModel.brandStr length]>0?_priviledgeModel.brandStr:@""];
            NSString *titleStr = [NSString stringWithFormat:@"%@",[_priviledgeModel.priviledgeContent length] > 0 ? _priviledgeModel.priviledgeContent : DEFAULTSHARECONTENT];
            
            [UMSocialData defaultData].extConfig.wxMessageType = UMSocialWXMessageTypeApp;
            [UMSocialData defaultData].urlResource.url = url;
            [UMSocialData defaultData].extConfig.wechatTimelineData.url = url;
            [UMSocialData defaultData].extConfig.wechatSessionData.url = url;
            [UMSocialData defaultData].extConfig.title = titleStr;
            
            NSLog(@"%@",[UMSocialSnsPlatformManager sharedInstance].allSnsValuesArray);
            
            
            [[UMSocialDataService defaultDataService]  postSNSWithTypes:@[UMShareToWechatTimeline] content:shareText image:shareImage location:nil urlResource:nil presentedController:self completion:^(UMSocialResponseEntity *response)
             {
                 if (response.responseCode == UMSResponseCodeSuccess)
                 {
                     if (shareType == YES)
                     {
                         [self getPrivledgeSuccess];
                     }
                     else
                     {
                         [Utility showToastWithMessage:@"分享成功" inView:self.view];
                     }
                     
                 }
                 else
                 {
                     [Utility showToastWithMessage:@"分享失败" inView:self.view];
                 }
             }];
        }
        else if ([Utility isInstalledQQ])
        {
            //直接到QQ
            
            //分享数据的采集
            [MobClick event:@"click_youhuiquanfenxiangqqkongjian"];
            //        NSString *url = [NSString stringWithFormat:@"%@&way=5",_priviledgeModel.priviledgeUrl];
            NSString *shareText = [NSString stringWithFormat:@"%@在考拉社区发优惠券咯，优惠多多、福利多多！",[_priviledgeModel.brandStr length] > 0 ? _priviledgeModel.brandStr : DEFAULTSHARECONTENT];
            NSString *titleStr = [NSString stringWithFormat:@"%@",[_priviledgeModel.priviledgeContent length] > 0 ? _priviledgeModel.priviledgeContent : DEFAULTSHARECONTENT];
            
            //分享内容设置
            
            [UMSocialData defaultData].extConfig.qzoneData.url = url;
            [UMSocialData defaultData].extConfig.qzoneData.title = titleStr;
            [UMSocialData defaultData].extConfig.qzoneData.shareText = shareText;
            //        [UMSocialData defaultData].extConfig.qzoneData.shareImage = [UIImage imageNamed:@"icon.png"];
            [UMSocialData defaultData].extConfig.qzoneData.shareImage = UIImageJPEGRepresentation(shareImage,0.1f);
            //分享数据，平台设置   UMSocialQzoneData
            [[UMSocialDataService defaultDataService] postSNSWithTypes:@[UMShareToQzone] content:shareText image:nil location:nil urlResource:nil presentedController:self completion:^(UMSocialResponseEntity *response)
             {
                 if (response.responseCode == UMSResponseCodeSuccess)
                 {
                     if (shareType == YES)
                     {
                         [self getPrivledgeSuccess];
                     }
                     else
                     {
                         [Utility showToastWithMessage:@"分享成功" inView:self.view];
                     }
                 }
                 else
                 {
                     [Utility showToastWithMessage:@"分享失败" inView:self.view];
                 }
             }];
        }
        else
        {
            [MobClick event:@"click_youhuiquanquxiao"];
        }
        
    }
    
}
//领取优惠券成功
- (void)getPrivledgeSuccess
{
    HWUserLogin *user = [HWUserLogin currentUserLogin];
    HWHTTPRequestOperationManager *manage = [HWHTTPRequestOperationManager manager];
    NSMutableDictionary *dict = [[NSMutableDictionary alloc] init];
    [dict setPObject:user.key forKey:@"key"];
    [dict setPObject:user.userId forKey:@"userId"];
    [dict setPObject:priviledgeId forKey:@"couponId"];
    
    [manage POST:kGetPriviledge parameters:dict queue:nil success:^(id responseObject) {
        
        UIAlertView *tipAlertView = [[UIAlertView alloc]initWithTitle:@"分享成功！" message:@"优惠券可在我的钱包里查看" delegate:self cancelButtonTitle:@"取消" otherButtonTitles:@"前往查看", nil];
        [tipAlertView show];
        
    } failure:^(NSString *code, NSString *error) {
        [MobClick event:@"click_fenxiangbudequan"];
        [Utility showToastWithMessage:error inView:self.view];
        NSLog(@"error %@",error);
    }];
}
#pragma - mark UIAlerViewDelegat Method
- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    if (buttonIndex == 0) {
        
    }
    else
    {
        AppDelegate *delegate = (AppDelegate *)[UIApplication sharedApplication].delegate;
        delegate.tabBarVC.selectedIndex = 3;
        HWPersonInfoViewController *personVC = [[delegate.tabBarVC viewControllers]objectAtIndex:3];
        HWMoneyViewController *moneyVC = [[HWMoneyViewController alloc] init];
        [personVC.navigationController pushViewController:moneyVC animated:YES];
        
    }
}
//创建HeaderView
- (void)createHeaderView
{
    if (headerView)
    {
        [priviledgeLabel removeFromSuperview];
        if ([priviledgeModel.priviledgeType isEqualToString:@"1"]) {
            [self createActivityTime:priviledgeIV headerView:headerView];
            priviledgeLabel  = [HWGeneralControl createLabel:CGRectMake(12, CGRectGetMaxY(activityTimeIV.frame)+15, kScreenWidth-2*12, 15) font:15.0f textAligment:NSTextAlignmentLeft labelColor:THEME_COLOR_SMOKE];
            noActivityTimeTV.hidden = YES;
        }
        else
        {
            [self createNoActivity:priviledgeIV headerView:headerView];
            priviledgeLabel  = [HWGeneralControl createLabel:CGRectMake(12, CGRectGetMaxY(noActivityTimeTV.frame)+15, kScreenWidth-2*12, 15) font:15.0f textAligment:NSTextAlignmentLeft labelColor:THEME_COLOR_SMOKE];
            noActivityTimeTV.hidden = NO;
        }
        [headerView addSubview:priviledgeLabel];
        priviledgeLabel.text = priviledgeModel.priviledgeContent;
        startDateLabel.text = priviledgeModel.starTime;
        CGRect factualRect =  [HWGeneralControl returnLabelFactualSize:startDateLabel font:13];
        [startDateLabel setFrame:CGRectMake(72, CGRectGetMaxY(priviledgeLabel.frame)+5, factualRect.size.width,13)];
        toLabel.text = @"至";
        [endDateLabel removeFromSuperview];
        endDateLabel = [HWGeneralControl createLabel:CGRectMake(CGRectGetMaxX(toLabel.frame)+2, CGRectGetMaxY(priviledgeLabel.frame)+5, 200, 13) font:13.0f textAligment:NSTextAlignmentLeft labelColor:THEME_COLOR_TEXT];
        endDateLabel.text = [Utility getTimeWithTimestamp:priviledgeModel.endTime];
        [headerView addSubview:endDateLabel];
        //        [endDateLabel setFrame:CGRectMake(CGRectGetMaxX(toLabel.frame), CGRectGetMaxY(priviledgeLabel.frame)+5, 200, 13)];
        brandLabel.text = priviledgeModel.brandStr;
    }
    else
    {
        
        headerView = [HWGeneralControl createView:CGRectMake(0, 0, kScreenWidth, kPriviledgeHeaderHeight)];
        headerView.backgroundColor = BACKGROUND_COLOR;
        priviledgeDetailTableV.tableHeaderView = headerView;
        
        UIImageView *priviledgeView = [HWGeneralControl createImageView:CGRectMake(0, 0, kScreenWidth, kPriviledgeBackgroundHeight) image:@""];
        priviledgeView.backgroundColor = [UIColor clearColor];
        UIImage *image = [UIImage imageNamed:@"sawtooth"];
        priviledgeView.image = [image resizableImageWithCapInsets:UIEdgeInsetsMake(0, 0, 30, 30)];
        [headerView addSubview:priviledgeView];
        
        
        priviledgeIV = [HWGeneralControl createImageView:CGRectMake(kPriviledgeDetailLeft, kPriviledgeDetailTop, kScreenWidth - 2 * kPriviledgeDetailLeft, kPriviledgeDetailImageV) image:@""];
        [priviledgeView addSubview:priviledgeIV];
        priviledgeIV.backgroundColor = [UIColor clearColor];
        priviledgeIV.layer.borderColor = THEME_COLOR_LINE.CGColor;
        priviledgeIV.layer.borderWidth = 0.5;
        if ([priviledgeModel.priviledgeType isEqualToString:@"1"]) {
            [self createActivityTime:priviledgeIV headerView:headerView];
            priviledgeLabel  = [HWGeneralControl createLabel:CGRectMake(12, CGRectGetMaxY(activityTimeIV.frame)+15, kScreenWidth-2*12, 15) font:15.0f textAligment:NSTextAlignmentLeft labelColor:THEME_COLOR_SMOKE];
            noActivityTimeTV.hidden = YES;
        }
        else
        {
            [self createNoActivity:priviledgeIV headerView:headerView];
            priviledgeLabel  = [HWGeneralControl createLabel:CGRectMake(12, CGRectGetMaxY(noActivityTimeTV.frame)+15, kScreenWidth-2*12, 15) font:15.0f textAligment:NSTextAlignmentLeft labelColor:THEME_COLOR_SMOKE];
            noActivityTimeTV.hidden = NO;
        }
        
        
        priviledgeLabel.text = priviledgeModel.priviledgeContent;
        [headerView addSubview:priviledgeLabel];
        //有效期
        UILabel *validDateLabel = [HWGeneralControl createLabel:CGRectMake(12, CGRectGetMaxY(priviledgeLabel.frame)+5, 60, 13) font:13.0 textAligment:NSTextAlignmentLeft labelColor:THEME_COLOR_TEXT];
        validDateLabel.text = @"有效期限:";
        [headerView addSubview:validDateLabel];
        startDateLabel =[HWGeneralControl createLabel:CGRectMake(72, CGRectGetMaxY(priviledgeLabel.frame)+5, 100, 13) font:13.0f textAligment:NSTextAlignmentLeft labelColor:THEME_COLOR_TEXT];
        startDateLabel.text = priviledgeModel.starTime;
        if([priviledgeModel.starTime length]==0)
        {
            startDateLabel.text = @"";
        }
        else
        {
            startDateLabel.text = [Utility getTimeWithTimestamp:priviledgeModel.starTime];
            
        }
        CGRect factualRect =  [HWGeneralControl returnLabelFactualSize:startDateLabel font:13];
        [startDateLabel setFrame:CGRectMake(72, CGRectGetMaxY(priviledgeLabel.frame)+5, factualRect.size.width,13)];
        
        toLabel = [HWGeneralControl createLabel:CGRectMake(CGRectGetMaxX(startDateLabel.frame)+2, CGRectGetMaxY(priviledgeLabel.frame)+5, 12, 13) font:13.0f textAligment:NSTextAlignmentLeft labelColor:THEME_COLOR_TEXT];
        toLabel.text = @"至";
        endDateLabel = [HWGeneralControl createLabel:CGRectMake(CGRectGetMaxX(toLabel.frame) + 3, CGRectGetMaxY(priviledgeLabel.frame)+5, 200, 13) font:13.0f textAligment:NSTextAlignmentLeft labelColor:THEME_COLOR_TEXT];
        
        //        endDateLabel.text = [Utility getTimeWithTimestamp:priviledgeModel.endTime];
        
        [endDateLabel setFrame:CGRectMake(CGRectGetMaxX(toLabel.frame), CGRectGetMaxY(priviledgeLabel.frame)+5, 200, 13)];
        
        
        //商家
        //
        shopLabel = [HWGeneralControl createLabel:CGRectMake(12, CGRectGetMaxY(startDateLabel.frame)+5,60, 13) font:13.0 textAligment:NSTextAlignmentLeft labelColor:THEME_COLOR_TEXT];
        shopLabel.text = @"发券商家:";
        [headerView addSubview:shopLabel];
        
        brandLabel = [HWGeneralControl createLabel:CGRectMake(CGRectGetMaxX(shopLabel.frame), CGRectGetMaxY(startDateLabel.frame)+5, (kScreenWidth-2*12)/2, 13) font:13.0f textAligment:NSTextAlignmentLeft labelColor:THEME_COLOR_ORANGE];
        brandLabel.backgroundColor = [UIColor clearColor];
        brandLabel.text = priviledgeModel.brandStr;
        [headerView addSubview:brandLabel];
        
        brandBtn = [HWGeneralControl createButton:CGRectMake(CGRectGetMaxX(shopLabel.frame), CGRectGetMaxY(startDateLabel.frame)+5, kScreenWidth-2*12, 13) font:13.0f buttonTitleColor:THEME_COLOR_ORANGE imageStr:@"" backImage:@"" title:@""];
        brandBtn.backgroundColor = [UIColor clearColor];
        [brandBtn addTarget:self action:@selector(businessUrl:) forControlEvents:UIControlEventTouchUpInside];
        [headerView addSubview:brandBtn];
        
        [headerView addSubview:startDateLabel];
        [headerView addSubview:toLabel];
        [headerView addSubview:endDateLabel];
        
        
        UILabel *ruleLabel =[HWGeneralControl createLabel:CGRectMake(12, CGRectGetMaxY(priviledgeView.frame)+20, 100, 13) font:14.0f textAligment:NSTextAlignmentLeft labelColor:THEME_COLOR_TEXT];
        ruleLabel.text = @"使用规则";
        [headerView addSubview:ruleLabel];
        
        UILabel * lab = [[UILabel alloc]initWithFrame:CGRectMake(0, headerView.frame.size.height - 0.5, kScreenWidth, 0.5)];
        lab.backgroundColor = THEME_COLOR_LINE;
        lab.shadowColor = THEME_COLOR_SMOKE;
        lab.shadowOffset = CGSizeMake(0, 2);
        [headerView addSubview:lab];
    }
    
}
//跳转商家链接
- (void)businessUrl:(id)sender
{
    [MobClick event:@"click_shangjiamingcheng"];
    [MobClick event:@"click_qianwangchakan"];
    if([_priviledgeModel.priviledgeUrl length]>0)
    {
        NSURL *url;
        if (!([_priviledgeModel.priviledgeUrl rangeOfString:@"http://"].location == NSNotFound)) {
            url = [NSURL URLWithString:[NSString stringWithFormat:@"%@",_priviledgeModel.priviledgeUrl]];
        }
        else
        {
            url = [NSURL URLWithString:[NSString stringWithFormat:@"http://%@",_priviledgeModel.priviledgeUrl]];
        }
        [[UIApplication sharedApplication] openURL:url];
    }
    
}
//创建没有活动倒计时的View
- (void)createNoActivity:(UIImageView *)noActivityTime headerView:(UIView *)headerViewTemp
{
    noActivityTimeTV = [HWGeneralControl createView:CGRectMake(0, CGRectGetMaxY(noActivityTime.frame), kScreenWidth, 40)];
    noActivityTimeTV.backgroundColor = [UIColor clearColor];
    [headerViewTemp addSubview:noActivityTimeTV];
    
    noPriviledgeTicketNumLabel = [HWGeneralControl createLabel:CGRectMake(12, kPriviledgeDetailTop, 300, 16) font:11.0 textAligment:NSTextAlignmentLeft labelColor:THEME_COLOR_TEXT];
    [noActivityTimeTV addSubview:noPriviledgeTicketNumLabel];
    [self drawDottedLine];
    
    
}
//画虚线
- (void)drawDottedLine
{
    UIImageView *lineImageV = [HWGeneralControl createImageView:CGRectMake(12,noActivityTimeTV.frame.size.height-0.5, kScreenWidth-2*12, 1) image:@""];
    lineImageV.backgroundColor = [UIColor whiteColor];
    [noActivityTimeTV addSubview:lineImageV];
    
    UIGraphicsBeginImageContext(lineImageV.frame.size);   //开始画线
    [lineImageV.image drawInRect:CGRectMake(0, 0, lineImageV.frame.size.width, lineImageV.frame.size.height)];
    CGContextRef context =UIGraphicsGetCurrentContext();
    CGContextBeginPath(context);
    CGContextSetLineWidth(context, 0.5);
    CGContextSetLineCap(UIGraphicsGetCurrentContext(), kCGLineCapRound);  //设置线条终点形状
    CGFloat lengths[] = {2,1};
    CGContextSetStrokeColorWithColor(context, [UIColor grayColor].CGColor);
    
    CGContextSetLineDash(context, 0, lengths, 2);  //画虚线
    CGContextMoveToPoint(context, 0.0, 0.0);    //开始画线
    CGContextAddLineToPoint(context, kScreenWidth-10, 0.0);
    CGContextStrokePath(context);
    lineImageV.image = UIGraphicsGetImageFromCurrentImageContext();
    CGContextClosePath(context);
}

//画虚线
- (void)drawDottedActiveLine
{
    UIImageView *lineImageV = [HWGeneralControl createImageView:CGRectMake(12,activityTimeIV.frame.size.height-0.5, kScreenWidth-2*12, 1) image:@""];
    lineImageV.backgroundColor = [UIColor whiteColor];
    [activityTimeIV addSubview:lineImageV];
    
    UIGraphicsBeginImageContext(lineImageV.frame.size);   //开始画线
    [lineImageV.image drawInRect:CGRectMake(0, 0, lineImageV.frame.size.width, lineImageV.frame.size.height)];
    CGContextRef context =UIGraphicsGetCurrentContext();
    CGContextBeginPath(context);
    CGContextSetLineWidth(context, 0.5);
    CGContextSetLineCap(UIGraphicsGetCurrentContext(), kCGLineCapRound);  //设置线条终点形状
    CGFloat lengths[] = {2,1};
    CGContextSetStrokeColorWithColor(context, [UIColor grayColor].CGColor);
    
    CGContextSetLineDash(context, 0, lengths, 2);  //画虚线
    CGContextMoveToPoint(context, 0.0, 0.0);    //开始画线
    CGContextAddLineToPoint(context, kScreenWidth-10, 0.0);
    CGContextStrokePath(context);
    lineImageV.image = UIGraphicsGetImageFromCurrentImageContext();
    CGContextClosePath(context);
}
//创建活动倒计时的view
- (void)createActivityTime:(UIImageView *)priviledgeIVTemp headerView:(UIView *)headerViewTemp
{
    activityTimeIV = [HWGeneralControl createView:CGRectMake(0, CGRectGetMaxY(priviledgeIVTemp.frame), kScreenWidth, 40)];
    activityTimeIV.backgroundColor = [UIColor clearColor];
    [headerViewTemp addSubview:activityTimeIV];
    
    
    _timeTipLabel = [HWGeneralControl createLabel:CGRectMake(kScreenWidth - 175,kPriviledgeDetailTop, 83, 16) font:13.0f textAligment:NSTextAlignmentLeft labelColor:THEME_COLOR_SMOKE];
    _timeTipLabel.text = @"距离开始还有";
    [activityTimeIV addSubview:_timeTipLabel];
    
    
    hourLabel = [HWGeneralControl createLabel:CGRectMake(CGRectGetMaxX(_timeTipLabel.frame)+3,kPriviledgeDetailTop, 24, 16) font:13 textAligment:NSTextAlignmentCenter labelColor:[UIColor whiteColor]];
    //    hourLabel.backgroundColor = UIColorFromRGB(0xc01a24);
    hourLabel.textColor = THEME_COLOR_RED;
    hourLabel.backgroundColor = [UIColor clearColor];
    [activityTimeIV addSubview:hourLabel];
    
    _hourMaoHaoLabel = [HWGeneralControl createLabel:CGRectMake(CGRectGetMaxX(hourLabel.frame),kPriviledgeDetailTop, 15, 15) font:13.0f textAligment:NSTextAlignmentCenter labelColor:[UIColor blackColor]];
    _hourMaoHaoLabel.text = @":";
    [activityTimeIV addSubview:_hourMaoHaoLabel];
    
    minitueLabel = [HWGeneralControl createLabel:CGRectMake(CGRectGetMaxX(_hourMaoHaoLabel.frame),kPriviledgeDetailTop, 16, 16) font:13 textAligment:NSTextAlignmentCenter labelColor:[UIColor whiteColor]];
    minitueLabel.textColor = THEME_COLOR_RED;
    //    minitueLabel.backgroundColor = UIColorFromRGB(0xc01a24);
    minitueLabel.backgroundColor = [UIColor clearColor];
    [activityTimeIV addSubview:minitueLabel];
    
    _minitueMaoHaoLabel = [HWGeneralControl createLabel:CGRectMake(CGRectGetMaxX(minitueLabel.frame),kPriviledgeDetailTop, 15, 15) font:13 textAligment:NSTextAlignmentCenter labelColor:[UIColor blackColor]];
    _minitueMaoHaoLabel.text = @":";
    [activityTimeIV addSubview:_minitueMaoHaoLabel];
    
    secondLabel = [HWGeneralControl createLabel:CGRectMake(CGRectGetMaxX(_minitueMaoHaoLabel.frame),kPriviledgeDetailTop, 16, 16) font:13 textAligment:NSTextAlignmentCenter labelColor:[UIColor whiteColor]];
    //    secondLabel.backgroundColor = UIColorFromRGB(0xc01a24);
    secondLabel.textColor = THEME_COLOR_RED;
    secondLabel.backgroundColor = [UIColor clearColor];
    [activityTimeIV addSubview:secondLabel];
    
    priviledgeTicketNumLabel = [HWGeneralControl createLabel:CGRectMake(12, kPriviledgeDetailTop, 150, 16) font:11.0 textAligment:NSTextAlignmentLeft labelColor:THEME_COLOR_TEXT];
    [activityTimeIV addSubview:priviledgeTicketNumLabel];
    priviledgeTicketNumLabel.backgroundColor = [UIColor clearColor];
    [self setCoolTime:activityNum];
    [self drawDottedActiveLine];
    
    
}
//倒计时

- (void)setCoolTime:(int)time
{
    NSInteger freezeTime = [_priviledgeModel.remainMS integerValue];
    NSInteger  remaindTime = freezeTime - time;
    if (remaindTime > 0)
    {
        secondLabel.hidden = NO;
        hourLabel.hidden = NO;
        minitueLabel.hidden = NO;
        _timeTipLabel.hidden = NO;
        _hourMaoHaoLabel.hidden = NO;
        _minitueMaoHaoLabel.hidden = NO;
        NSInteger hour = remaindTime / 60 / 60;
        NSInteger minute = remaindTime / 60 % 60;
        NSInteger second = (remaindTime) % 60;
        secondLabel.text = [NSString stringWithFormat:@"%02d", second];
        hourLabel.text = [NSString stringWithFormat:@"%02d", hour];
        minitueLabel.text = [NSString stringWithFormat:@"%02d", minute];
    }
    else
    {
        shareBtn.backgroundColor = THEME_COLOR_ORANGE;
        priviledgeModel.priviledgeType = @"2";
        
        secondLabel.hidden = YES;
        hourLabel.hidden = YES;
        minitueLabel.hidden = YES;
        _timeTipLabel.hidden = YES;
        _hourMaoHaoLabel.hidden = YES;
        _minitueMaoHaoLabel.hidden = YES;
        
    }
    
}
//赋值
- (void)followRecordContent:(NSString *)str
{
    NSAttributedString *contentStr = [self setStringdiffrentColor:str color:THEME_COLOR_ORANGE contentStr:@"剩"];
    [priviledgeTicketNumLabel setAttributedText:contentStr];
    [noPriviledgeTicketNumLabel setAttributedText:contentStr];
}
//修改字体颜色
- (NSMutableAttributedString *)setStringdiffrentColor:(NSString *)str color:(UIColor *)color contentStr:(NSString *)contentStr
{
    NSMutableAttributedString *string = [[NSMutableAttributedString alloc]initWithString:str];
    NSRange range=[str rangeOfString:contentStr];
    int length = (int)[str length]-2 - (int)range.location;
    NSRange newRange = NSMakeRange(range.location+1, length);
    
    [string addAttribute:NSForegroundColorAttributeName value:color range:newRange];
    
    return string;
}

- (void)queryListData:(NSString *)priviledgeIdStr
{
    HWUserLogin *user = [HWUserLogin currentUserLogin];
    HWHTTPRequestOperationManager *manage = [HWHTTPRequestOperationManager manager];
    NSMutableDictionary *dict = [[NSMutableDictionary alloc] init];
    [Utility hideMBProgress:self.view];
    [Utility showMBProgress:self.view message:@"请求数据"];
    [dict setPObject:user.key forKey:@"key"];
    [dict setPObject:priviledgeIdStr forKey:@"couponId"];
    
    [manage POST:kPriviledgeDetail parameters:dict queue:nil success:^(id responseObject) {
        [Utility hideMBProgress:self.view];
        NSDictionary *respDic = (NSDictionary *)[responseObject dictionaryObjectForKey:@"data"];
        priviledgeModel = [[HWPriviledgeDetailModel alloc]initWithDic:respDic];
        _priviledgeModel = priviledgeModel;
        
        [self createHeaderView];
        [self createFooterView];
        //初始化定时器
        timer = nil;
        activityNum = 0;
        if (!timer)
        {
            timer = [NSTimer scheduledTimerWithTimeInterval:1.0f target:self selector:@selector(countDown:) userInfo:nil repeats:YES];
            [[NSRunLoop mainRunLoop]addTimer:timer forMode:NSRunLoopCommonModes];
        }
        
        [self refershUI:priviledgeModel];
        
    } failure:^(NSString *code, NSString *error) {
        NSLog(@"error %@",error);
        [Utility hideMBProgress:self.view];
        [Utility showToastWithMessage:error inView:self.view];
        self.priviledgeIV.image = [UIImage imageNamed:IMAGE_BREAK_CUBE];
    }];
}
- (void)refershUI:(HWPriviledgeDetailModel*)priviledgeModelTemp
{
    //start
    //    NSURL *avatarUrl = [NSURL URLWithString:[NSString stringWithFormat:@"%@/hw-sq-app-web/%@&key=%@",kUrlBaseTest,priviledgeModelTemp.priviledgeImageUrl,@"e2a3b251-841b-4e0c-ab9f-e50bbb1e8ea5"]];
    
    
    
    NSURL *avatarUrl = [NSURL URLWithString:[Utility imageDownloadWithMongoDbKey:priviledgeModelTemp.priviledgeImageUrl]];
    
    __weak UIImageView *blockImgV = self.priviledgeIV;
    [self.priviledgeIV setImageWithURL:avatarUrl placeholderImage:[UIImage imageNamed:IMAGE_PLACE] completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType) {
        if (error)
        {
            NSLog(@"Error : load image fail.");
            blockImgV.image = [UIImage imageNamed:IMAGE_BREAK_CUBE];
        }
        else
        {
            blockImgV.image = image;
            if (cacheType == 0)
            { // request url
                CATransition *transition = [CATransition animation];
                transition.duration = 1.0f;
                transition.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut];
                transition.type = kCATransitionFade;
                [blockImgV.layer addAnimation:transition forKey:nil];
            }
        }
    }];
    //end
    
    if (![priviledgeModelTemp.priviledgeType isEqualToString:@"1"])
    {
        activityTimeIV.hidden = YES;
        noActivityTimeTV.hidden = NO;
        if (timer)
        {
            [timer invalidate];
        }
    }
    else
    {
        activityNum = 0;
        activityTimeIV.hidden = NO;
        noActivityTimeTV.hidden = YES;
    }
    if ([priviledgeModel.priviledgeUrl length] != 0)
    {
        [self followRecordContent:[NSString stringWithFormat:@"共%@张,剩%@张",priviledgeModelTemp.totalPriviledge,priviledgeModelTemp.remainPriviledge]];
        brandLabel.textColor = THEME_COLOR_ORANGE;
        
        NSRange contentRange = {0,[_priviledgeModel.brandStr length]};
        NSMutableAttributedString *content = [[NSMutableAttributedString alloc]initWithString:_priviledgeModel.brandStr];
        [content addAttribute:NSUnderlineStyleAttributeName value:[NSNumber numberWithInteger:NSUnderlineStyleSingle] range:contentRange];
        brandLabel.attributedText = content;
    }
    else
    {
        priviledgeTicketNumLabel.text  = [NSString stringWithFormat:@"共%@张,剩%@张",priviledgeModelTemp.totalPriviledge,priviledgeModelTemp.remainPriviledge];
        priviledgeTicketNumLabel.textColor = THEME_COLOR_TEXT;
        noPriviledgeTicketNumLabel.text = [NSString stringWithFormat:@"共%@张,剩%@张",priviledgeModelTemp.totalPriviledge,priviledgeModelTemp.remainPriviledge];
        noPriviledgeTicketNumLabel.textColor = THEME_COLOR_TEXT;
        brandLabel.textColor = THEME_COLOR_TEXT;
        brandLabel.text = _priviledgeModel.brandStr;
    }
    [self followRecordContent:[NSString stringWithFormat:@"共%@张,剩%@张",priviledgeModelTemp.totalPriviledge,priviledgeModelTemp.remainPriviledge]];
    if ([brandLabel.text length]==0)
    {
        shopLabel.hidden = YES;
    }
    
    priviledgeLabel.text = priviledgeModel.priviledgeContent;
    startDateLabel.text = [Utility getTimeWithTimestamp:priviledgeModelTemp.starTime];
    if ([priviledgeModelTemp.endTime length]==0)
    {
        endDateLabel.text = @"";
    }
    else
    {
        endDateLabel.text = [Utility getTimeWithTimestamp:priviledgeModelTemp.endTime];
    }
    
    CGRect factualRect =  [HWGeneralControl returnLabelFactualSize:startDateLabel font:13];
    
    [startDateLabel setFrame:CGRectMake(72, CGRectGetMaxY(priviledgeLabel.frame) + 5, factualRect.size.width, 13)];
    [toLabel setFrame:CGRectMake(CGRectGetMaxX(startDateLabel.frame)+2, CGRectGetMaxY(priviledgeLabel.frame) + 5, 12, 13)];
    [endDateLabel setFrame:CGRectMake(CGRectGetMaxX(toLabel.frame) + 4, CGRectGetMaxY(priviledgeLabel.frame)+5, 200, 13)];
    [priviledgeDetailTableV reloadData];
    
    if ([priviledgeModel.priviledgeType isEqualToString:@"3"] || priviledgeModel.remainPriviledge.intValue == 0)
    {
        [shareBtn setTitle:@"分享" forState:UIControlStateNormal];
    }
    
}
//倒计时
- (void)countDown:(id)sender
{
    activityNum++;
    [self setCoolTime:activityNum];
    
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
//tableview代理方法
#pragma - mark TableViewDelegate
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *cellIdentifier = @"PriviledgeDetailIdentifier";
    HWPriviledgeDetailTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    if (!cell)
    {
        cell = [[HWPriviledgeDetailTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdentifier];
    }
    cell.backgroundColor = [UIColor whiteColor];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    int row = (int)indexPath.row;
    [cell setPriviledgContent:[priviledgeModel.ruleArry objectAtIndex:row]];
    ;
    return cell;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}
- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    UIView *headerViewW = [HWGeneralControl createView:CGRectMake(0, 0, kScreenWidth, 10)];
    headerViewW.backgroundColor = [UIColor whiteColor];
    return  headerViewW;
}
- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section
{
    UIView *footerView = [HWGeneralControl createView:CGRectMake(0, 0, kScreenWidth, 10)];
    footerView.backgroundColor = [UIColor whiteColor];
    return  footerView;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSString *ruleStr = [priviledgeModel.ruleArry objectAtIndex:indexPath.row];
    CGSize labelSize = [ruleStr sizeWithFont:[UIFont systemFontOfSize:13.0]
                           constrainedToSize:CGSizeMake(kScreenWidth-27, MAXFLOAT)
                               lineBreakMode:NSLineBreakByWordWrapping];
    return  labelSize.height;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [priviledgeModel.ruleArry count];
}
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 10.0f;
}
- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    return 10.0f;
}

#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}

@end
