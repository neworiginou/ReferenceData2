//
//  HWTreasureRuleViewController.m
//  Community
//
//  Created by caijingpeng.haowu on 14-12-9.
//  Copyright (c) 2014年 caijingpeng. All rights reserved.
//

#import "HWTreasureRuleViewController.h"
#import "HWGoodsListViewController.h"
#import "HWGoodsDetailViewController.h"

@interface HWTreasureRuleViewController ()
{
    NSString *ruleStr;
    NSString *priceStr;
    NSString *failedStr;
    NSString *levelStr;
    NSString *getStr;
}
@end

@implementation HWTreasureRuleViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.navigationItem.titleView = [Utility navTitleView:@"无底线用户协议"];
    self.navigationItem.leftBarButtonItem = [Utility navLeftBackBtn:self action:@selector(backMethod)];
    
    if (self.isAgree)
    {
        self.baseTableView.frame = CGRectMake(0, 0, kScreenWidth, CONTENT_HEIGHT - 50);
        
        UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
        button.frame = CGRectMake(0, CONTENT_HEIGHT - 50, kScreenWidth, 50);
        [button setBackgroundImage:[Utility imageWithColor:THEME_COLOR_ORANGE andSize:CGSizeMake(kScreenWidth, 50)] forState:UIControlStateNormal];
        [button setTitle:@"同意《无底线用户协议》" forState:UIControlStateNormal];
        [button setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        button.titleLabel.font = [UIFont fontWithName:FONTNAME size:19.0f];
        [button addTarget:self action:@selector(toAgreeProtocal:) forControlEvents:UIControlEventTouchUpInside];
        [self.view addSubview:button];
    }
    else
    {
        self.baseTableView.frame = CGRectMake(0, 0, kScreenWidth, CONTENT_HEIGHT);
    }
    
    
    
    ruleStr = @"无底线 ( 最低唯一价，以下称呼 ) 即唯一且最低的价格.首先必须是最低,然后是唯一,也就是所有唯一价格中最低的价格.或者可以说成没有重复的最低价格。\n例如 : 某商品出价结果为 : 0.1 (22人)、1.4(1人)、5.9(2人)、13.2(4人) , 则取出价1.4的人为中奖者。";
    priceStr = @"每次用户出价都需要消耗考拉币作为参与手续费 , 一种为固定考拉币消耗 , 每次参与无论出价多少消耗的考拉币固定 ; 一种为非固定消耗 , 按出价多少转化为消耗考拉币多少。";
    failedStr = @"方案流标 一直活动结束时间,所有参与夺宝的出价没有出现唯一价 , 该方案即流标 , 将返还所有参与该方案用户的夺宝消费。";
    levelStr = @"每次用户出价成功后，系统会有当前出价排名提醒，即你在所有唯一价当中的排名，会描述前12的具体排名，唯一价超出12名的显示为有“12个以上更低唯一价”；排名规则如图：";
    getStr = @"用户中奖后领取商品需要支付2部分金额：\n1. 用户中奖出价金额，即用户参与无底线最低唯一价的金额。\n2. 奖品税费，根据国家税务方面的法律法规，用户拍得的商品需要支付商品市场价格的0-20%作为个人所得税，我们将在用户支付的时候实行代扣代缴。\n3.苹果公司（Apple.Inc）并非活动赞助商，活动产生的任何影响和苹果公司（Apple.Inc）无关。无底线活动最终解释权属于考拉社区。";
}

-(void)viewWillAppear:(BOOL)animated
{
    [self.navigationController setNavigationBarHidden:NO animated:NO];
}

- (void)toAgreeProtocal:(id)sender
{
    [MobClick event:@"click_agree_bargain User agreement"];
    NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
    NSString *agreeFlag = [userDefaults objectForKey:kAgreeProtocol];
    if (agreeFlag == nil || [agreeFlag isEqualToString:@"0"])
    {
        // 发送请求
        [Utility showMBProgress:self.view message:@"加载中..."];
        HWHTTPRequestOperationManager *manager = [HWHTTPRequestOperationManager cutManager];
        NSMutableDictionary *param = [NSMutableDictionary dictionary];
        [param setPObject:[HWUserLogin currentUserLogin].userId forKey:@"userId"];
        [param setPObject:@"1" forKey:@"source"];
        [param setPObject:[HWUserLogin currentUserLogin].telephoneNum forKey:@"mobileNumber"];
        [param setPObject:[HWUserLogin currentUserLogin].key forKey:@"key"];
        
        [manager POST:kAgreeCutProtocol parameters:param queue:nil success:^(id responseObject) {
            
            [Utility hideMBProgress:self.view];
            
            NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
            [userDefaults setObject:@"1" forKey:kAgreeProtocol];
            
            //如果是引导至该界面 跳转砍价第一个商品详情
            if (_isGuide == YES)
            {
                [self pushFirstGoodDetail];
            }
            else
            {
                HWGoodsListViewController *goods = [[HWGoodsListViewController alloc] init];
                [self.navigationController pushViewController:goods animated:YES];
            }
        } failure:^(NSString *code, NSString *error) {
            [Utility hideMBProgress:self.view];
            [Utility showToastWithMessage:error inView:self.view];
        }];
        
    }
    else
    {
        [self.navigationController popViewControllerAnimated:YES];
    }
}

//跳转砍价第一个商品详情
-(void)pushFirstGoodDetail
{
    [Utility showMBProgress:self.view message:@"数据请求中..."];
    //去花考拉币 跳转砍价第一个商品详情
    NSMutableDictionary *param = [[NSMutableDictionary alloc] init];
    [param setPObject:@"0" forKey:@"pageNumber"];
    [param setPObject:[NSString stringWithFormat:@"%d",kPageCount] forKey:@"pageSize"];
    [param setPObject:[HWUserLogin currentUserLogin].key forKey:@"key"];
    [param setPObject:@"1" forKey:@"source"];
    
    HWHTTPRequestOperationManager *manager = [HWHTTPRequestOperationManager cutManager];
    [manager POST:kCutProductList parameters:param queue:nil success:^(id responese)
     {
         if ([[responese stringObjectForKey:@"status"] isEqual:@"1"])
         {
             [Utility hideMBProgress:self.view];
             NSArray *array = [[responese dictionaryObjectForKey:@"data"] arrayObjectForKey:@"list"];
             //跳转商品详情
             HWGoodsDetailViewController *vc = [[HWGoodsDetailViewController alloc]init];
             vc.productId = [array firstObject][@"productId"];
             [self.navigationController pushViewController:vc animated:YES];
         }
     } failure:^(NSString *code, NSString *error)
     {
         [Utility hideMBProgress:self.view];
         [Utility showToastWithMessage:error inView:self.view];
     }];
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 5;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 1;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = (UITableViewCell *)[tableView dequeueReusableCellWithIdentifier:[NSString stringWithFormat:@"cell%d%d",indexPath.section,indexPath.row]];
    if (!cell)
    {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:[NSString stringWithFormat:@"cell%d%d",indexPath.section,indexPath.row]];
        
        UILabel *contentLab = [[UILabel alloc] initWithFrame:CGRectMake(10, 10, kScreenWidth - 20, 0)];
        contentLab.backgroundColor = [UIColor clearColor];
        contentLab.lineBreakMode = NSLineBreakByCharWrapping;
        contentLab.numberOfLines = 0;
        contentLab.font = [UIFont fontWithName:FONTNAME size:THEME_FONT_SMALL];
        contentLab.textColor = THEME_COLOR_GRAY_MIDDLE;
        contentLab.tag = 999;
        [cell.contentView addSubview:contentLab];
        
        UIView *line = [[UIView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, 0.5f)];
        line.backgroundColor = THEME_COLOR_LINE;
        line.tag = 1000;
        [cell.contentView addSubview:line];
        
        UIImageView *imgV = [[UIImageView alloc] initWithFrame:CGRectMake((kScreenWidth - 320) / 2.0f, 0, 320, 555 / 2.0f)];
        imgV.tag = 1001;
        imgV.image = [UIImage imageNamed:@"pic_xieyi"];
        imgV.hidden = YES;
        [cell.contentView addSubview:imgV];
    }
    
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    
    UIImageView *imgV = (UIImageView *)[cell.contentView viewWithTag:1001];
    
    
    NSString *string ;
    if (indexPath.section == 0)
    {
        string = ruleStr;
        imgV.hidden = YES;
    }
    else if (indexPath.section == 1)
    {
        string = priceStr;
        imgV.hidden = YES;
    }
    else if (indexPath.section == 2)
    {
        string = failedStr;
        imgV.hidden = YES;
    }
    else if (indexPath.section == 3)
    {
        string = levelStr;
        imgV.hidden = NO;
    }
    else if (indexPath.section == 4)
    {
        string = getStr;
        imgV.hidden = YES;
    }
    
    UILabel *contentLab = (UILabel *)[cell.contentView viewWithTag:999];
    CGSize size = [Utility calculateStringHeight:string font:contentLab.font constrainedSize:CGSizeMake(contentLab.frame.size.width, 1000)];
    contentLab.text = string;
    
    CGRect frame = contentLab.frame;
    frame.size.height = size.height;
    contentLab.frame = frame;
    
    if (!imgV.hidden)
    {
        CGRect imgVFrame = imgV.frame;
        imgVFrame.origin.y = size.height + 20 - 0.5f;
        imgV.frame = imgVFrame;
        
        UIView *line = [cell.contentView viewWithTag:1000];
        CGRect frame1 = line.frame;
        frame1.origin.y = size.height + 20 - 0.5f + imgV.frame.size.height;
        line.frame = frame1;
    }
    else
    {
        UIView *line = [cell.contentView viewWithTag:1000];
        CGRect frame1 = line.frame;
        frame1.origin.y = size.height + 20 - 0.5f;
        line.frame = frame1;
    }
    
    
    
    
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSString *string ;
    if (indexPath.section == 0)
    {
        string = ruleStr;
    }
    else if (indexPath.section == 1)
    {
        string = priceStr;
    }
    else if (indexPath.section == 2)
    {
        string = failedStr;
    }
    else if (indexPath.section == 3)
    {
        string = levelStr;
    }
    else if (indexPath.section == 4)
    {
        string = getStr;
    }
    
    UIFont *font = [UIFont fontWithName:FONTNAME size:THEME_FONT_SMALL];
    CGSize size = CGSizeMake(kScreenWidth - 20, 1000);
    
    if (indexPath.section == 3)
    {
        return [Utility calculateStringHeight:string font:font constrainedSize:size].height + 20 + 555 / 2.0f;
    }
    else
    {
        return [Utility calculateStringHeight:string font:font constrainedSize:size].height + 20;
    }
    return 0;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 30;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, 30.0f)];
    view.backgroundColor = BACKGROUND_COLOR;
    
    UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(15, 0, kScreenWidth - 30, 30.0f)];
    label.textColor = THEME_COLOR_SMOKE;
    label.font = [UIFont fontWithName:FONTNAME size:THEME_FONT_SMALL];
    label.backgroundColor = [UIColor clearColor];
    [view addSubview:label];
    
    UIView *line = [[UIView alloc] initWithFrame:CGRectMake(0, 30 - 0.5f, kScreenWidth, 0.5f)];
    line.backgroundColor = THEME_COLOR_LINE;
    [view addSubview:line];
    
    if (section == 0)
    {
        label.text = @"中奖规则";
    }
    else if (section == 1)
    {
        label.text = @"出价手续费";
    }
    else if (section == 2)
    {
        label.text = @"方案流标";
    }
    else if (section == 3)
    {
        label.text = @"排名说明";
    }
    else if (section == 4)
    {
        label.text = @"领取商品支付";
    }
    return view;
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
