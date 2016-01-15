//
//  HWOrderPropertyVC.m
//  Community
//
//  Created by lizhongqiang on 14-9-2.
//  Copyright (c) 2014年 caijingpeng. All rights reserved.
//  预约物业上门

#import "HWOrderPropertyVC.h"

@interface HWOrderPropertyVC ()<UIAlertViewDelegate>

@end

@implementation HWOrderPropertyVC
@synthesize orderTable;
@synthesize tenementId;
@synthesize phoneHistoryId;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)back
{
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    
    self.navigationItem.titleView = [Utility navTitleView:@"预约上门"];
    self.navigationItem.leftBarButtonItem = [Utility navLeftBackBtn:self action:@selector(back)];
    [self.view setBackgroundColor:THEME_COLOR_TEXTBACKGROUND];
    
    UIView *headView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, 21)];
    [headView setBackgroundColor:THEME_COLOR_TEXTBACKGROUND];
    
    UILabel *labTip = [[UILabel alloc] initWithFrame:CGRectMake(15, 10, kScreenWidth - 15 * 2, 21)];
    [labTip setBackgroundColor:[UIColor clearColor]];
    [labTip setFont:[UIFont fontWithName:FONTNAME size:14.0f]];
    [labTip setText:@"欢迎使用预约上门服务 , 在此填写房屋信息 , 提交后物业会上门为您服务"];
    [labTip setTextColor:THEME_COLOR_TEXT];
    labTip.numberOfLines = 0;
    [labTip sizeToFit];
    [headView addSubview:labTip];
    float tipHeight = labTip.frame.size.height;
//    CGSize size = [labTip.text sizeWithFont:[UIFont fontWithName:FONTNAME size:14.0f] constrainedToSize:CGSizeMake(kScreenWidth - 30, CGFLOAT_MAX)];
    [headView setFrame:CGRectMake(0, 0, kScreenWidth, tipHeight + 23)];
    
    
    arrHead = [[NSArray alloc] initWithObjects:@"你申请的服务为：",@"你希望物业于：",@"地址为：", nil];
    arrTable = [[NSMutableArray alloc] initWithObjects:@"点击选择上门类型",@"点击选择上门时间",@"点击填写地址", nil];
    
    self.orderTable = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height) style:UITableViewStyleGrouped];
    self.orderTable.delegate = self;
    self.orderTable.dataSource = self;
    self.orderTable.backgroundColor = THEME_COLOR_TEXTBACKGROUND;
    [self.view addSubview:self.orderTable];
    self.orderTable.tableHeaderView = headView;
    UIView *footView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, 65)];
    [footView setBackgroundColor:[UIColor clearColor]];
    self.orderTable.tableFooterView = footView;
    
    UIButton *btnCommit = [UIButton buttonWithType:UIButtonTypeCustom];
    [btnCommit setTitle:@"提交" forState:UIControlStateNormal];
    [btnCommit.titleLabel setFont:[UIFont fontWithName:FONTNAME size:19.0f]];
    [btnCommit setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [btnCommit setBackgroundImage:[UIImage imageNamed:@"button"] forState:UIControlStateNormal];
    [btnCommit setFrame:CGRectMake(15, 20, kScreenWidth - 15 * 2, 45)];
    [btnCommit addTarget:self action:@selector(btnCommitClick:) forControlEvents:UIControlEventTouchUpInside];
    [footView addSubview:btnCommit];
}

- (void)viewWillAppear:(BOOL)animated
{
    self.orderTable.delegate = self;
    self.orderTable.dataSource = self;
}

- (void)viewWillDisappear:(BOOL)animated
{
    self.orderTable.delegate = nil;
    self.orderTable.dataSource = nil;
}

#pragma mark -
#pragma mark tableview delegate 
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 3;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 1;
}
//调整section之间的高度

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 5.0f;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    return 5.0f;
}

-(UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section
{
    return [[UIView alloc] initWithFrame:CGRectZero];
}

-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    return [[UIView alloc] initWithFrame:CGRectZero];
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSString *strLeft = [arrHead objectAtIndex:indexPath.section];
    NSString *strRight = [arrTable objectAtIndex:indexPath.section];
    NSDictionary *dic = [[NSDictionary alloc] initWithObjectsAndKeys:strLeft,@"left",strRight,@"right", nil];
    return [HWOrderCell getOrderCellHeight:dic];
}


-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    HWOrderCell *cell = (HWOrderCell *)[tableView dequeueReusableCellWithIdentifier:@"cell"];
    if (!cell)
    {
        cell = [[HWOrderCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"cell"];
    }
    cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    
    NSString *strLeft = [arrHead objectAtIndex:indexPath.section];
    NSString *strRight = [arrTable objectAtIndex:indexPath.section];
    NSDictionary *dic = [[NSDictionary alloc] initWithObjectsAndKeys:strLeft,@"left",strRight,@"right", nil];
    cell.orderCellDic = dic;
    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    int selectRow = (int)indexPath.section;
    switch (selectRow)
    {
        case 0:
        {
            HWOrderTypeVC *typeVC = [[HWOrderTypeVC alloc] init];
            typeVC.delegate = self;
            [self.navigationController pushViewController:typeVC animated:YES];
        }
            break;
            case 1:
        {
            HWOrderTimeVC *timeVC = [[HWOrderTimeVC alloc] init];
            timeVC.delegate = self;
            [self.navigationController pushViewController:timeVC animated:YES];
        }
            break;
            case 2:
        {
            HWOrderAddressVC *addVC = [[HWOrderAddressVC alloc] init];
            addVC.delegate = self;
            [self.navigationController pushViewController:addVC animated:YES];
        }
            break;
            
        default:
            break;
    }
}
#pragma mark -
#pragma mark server delegate
-(void)getOrderTime
{
    HWOrderData *order = [HWOrderData getOrderData];
    [arrTable replaceObjectAtIndex:1 withObject:order.time];
    [self.orderTable reloadData];
}

- (void)getOrderType
{
    HWOrderData *order = [HWOrderData getOrderData];
    [arrTable replaceObjectAtIndex:0 withObject:order.serviceType];
    [self.orderTable reloadData];
}

-(void)getOrderAddress
{
    HWOrderData *order = [HWOrderData getOrderData];
    NSString *strAddress = [NSString stringWithFormat:@"%@",order.address];
    [arrTable replaceObjectAtIndex:2 withObject:strAddress];
    [self.orderTable reloadData];
}

#pragma mark -

- (void)btnCommitClick:(id)sender
{
    HWOrderData *order = [HWOrderData getOrderData];
    NSString *strServiceType = order.serviceType;
    NSString *strTime = order.time;
    
    NSString *strAddress = [NSString stringWithFormat:@"%@",order.address];
    
    if (strServiceType == nil || [strServiceType isEqualToString:@""])
    {
        [Utility showAlertWithMessage:@"请选择您需要的上门服务"];
        return;
    }
    else if (strTime == nil || [strTime isEqualToString:@""])
    {
        [Utility showAlertWithMessage:@"请选择为您服务的上门时间"];
        return;
    }
    else if (strAddress == nil || [strAddress isEqualToString:@""])
    {
        [Utility showAlertWithMessage:@"请填写为您上门服务的地址"];
        return;
    }
    
    //入参："key":用户token，"requestService（必填）": "申请的服务","serviceTime（必填）":"服务时间"，"tenementId”（必填）“":"物业Id"，“residentId：（必填）”“住户id”“buildingNo：（必填）”“楼号”"roomNumber（必填）:""房号"“appUrlVersion”:"请求的接口版本号"
    
    HWUserLogin *user = [HWUserLogin currentUserLogin];
    NSMutableDictionary *dict = [[NSMutableDictionary alloc] init];
    [dict setPObject:user.key forKey:@"key"];
//    [dict setPObject:@"1" forKey:@"tenementId"];                             //物业ID
//    [dict setPObject:user.tenementId forKey:@"tenementId"];
    [dict setPObject:tenementId forKey:@"tenementId"];
    [dict setPObject:user.residendId forKey:@"residentId"];                             //住户ID
    [dict setPObject:strServiceType forKey:@"requestService"];
    [dict setPObject:strTime forKey:@"serviceTime"];
    [dict setPObject:strAddress forKey:@"address"];
    [dict setPObject:phoneHistoryId forKey:@"phoneHistoryId"];
//    [dict setPObject:@"1" forKey:@"appUrlVersion"];
    
    HWHTTPRequestOperationManager *manage = [HWHTTPRequestOperationManager manager];
    [manage POST:kPropertyVisit parameters:dict queue:nil success:^(id responseObject) {
//        NSLog(@"responseObject = %@",responseObject);
        NSDictionary *dict = (NSDictionary *)responseObject;
        NSString *strStatus = [dict stringObjectForKey:@"status"];
        if ([strStatus isEqualToString:@"1"])
        {
//            [Utility showToastWithMessage:@"你的预约上门申请已经提交" inView:self.view];
            UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"提示" message:@"你的预约上门申请已经提交" delegate:self cancelButtonTitle:nil otherButtonTitles:@"确定", nil];
            alert.tag = 987;
            [alert show];
//            [self performSelector:@selector(hidePop) withObject:nil afterDelay:2.0f];
        }
        else
        {
            [Utility showToastWithMessage:[dict stringObjectForKey:@"detail"] inView:self.view];
        }
    } failure:^(NSString *code, NSString *error) {
//        NSLog(@"error = %@",error);
        [Utility showToastWithMessage:error inView:self.view];
    }];
    
    
}

-(void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    if (alertView.tag == 987)
    {
//        if (buttonIndex == 1)
//        {
//            [self hidePop];
//        }
        
        if (buttonIndex == 0)
        {
//            NSLog(@"太无语了！");
            [self hidePop];
        }
    }
}

- (void)hidePop
{
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



@end
