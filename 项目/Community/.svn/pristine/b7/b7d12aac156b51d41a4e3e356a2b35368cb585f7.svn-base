//
//  HWHouseSaleRentsVC.m
//  Community
//
//  Created by lizhongqiang on 14-9-9.
//  Copyright (c) 2014年 caijingpeng. All rights reserved.
//

#import "HWHouseSaleRentsVC.h"

@interface HWHouseSaleRentsVC ()<HWRentsIntentionVCDelegate,HWRentsPeopleInfoVCDelegate,HWRentsAddressVCDelegate,HWRentsAreaVCDelegate,HWRentsHuXingVCDelegate,UIAlertViewDelegate>
{
    UITableView *tableSale;                     //
    NSMutableArray *arrayLeft;                  //左数据
    NSMutableArray *arrayRight;                 //右数据
}
@end

@implementation HWHouseSaleRentsVC
@synthesize phoneHistoryId;
- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)backMethod
{
    [self.navigationController popToViewController:self.rootVC animated:YES];
//    [self.navigationController popViewControllerAnimated:YES];
}

- (void)rightItem
{
    HWRentsAdvantageVC *advantage = [[HWRentsAdvantageVC alloc] init];
    [self.navigationController pushViewController:advantage animated:YES];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.navigationItem.titleView = [Utility navTitleView:@"租售托管"];
    self.navigationItem.leftBarButtonItem = [Utility navLeftBackBtn:self action:@selector(backMethod)];
    
    
    UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
    btn.frame = CGRectMake(270, 0, 21, 21);
    [btn setBackgroundImage:[UIImage imageNamed:@"detail"] forState:UIControlStateNormal];
    btn.titleEdgeInsets = UIEdgeInsetsMake(0, 0, 0, -15);
    [btn addTarget:self action:@selector(rightItem) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem *item = [[UIBarButtonItem alloc]initWithCustomView:btn];
    self.navigationItem.rightBarButtonItem = item;
    
    
    //第一次才会有弹窗
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    NSString *strValue = [defaults objectForKey:kFirstRent];
    if ([strValue isEqualToString:@"1"])
    {
        [defaults setObject:@"2" forKey:kFirstRent];
        [defaults synchronize];
        HWCustomBigAlert *bigAlert = [[HWCustomBigAlert alloc] init];
        [bigAlert show];
    }
    
    
    
    arrayLeft = [[NSMutableArray alloc] initWithObjects:@"租售意向",@"房东信息",@"住宅地址",@"使用面积",@"户型", nil];
    HWRentsData *rents = [HWRentsData getRentsData];
    NSString *strInfo = [NSString stringWithFormat:@"%@    %@",rents.strName,rents.strPhone];
    arrayRight = [[NSMutableArray alloc] initWithObjects:rents.strIntention,strInfo,rents.strAddress,rents.strArea,rents.strHuXing, nil];
    
    tableSale = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, self.view.frame.size.height) style:UITableViewStyleGrouped];
    tableSale.delegate = self;
    tableSale.dataSource = self;
    [self.view addSubview:tableSale];
    
    UIView *headView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, 60)];
    [headView setBackgroundColor:[UIColor clearColor]];
    
    UILabel *labelTip = [[UILabel alloc] initWithFrame:CGRectMake(15, 15, kScreenWidth - 15 * 2, 21)];
    [labelTip setBackgroundColor:[UIColor clearColor]];
    [labelTip setText:@"欢迎使用租售托管服务，填写房屋信息申请，我们将为你保密所有信息"];
    [labelTip setFont:[UIFont fontWithName:FONTNAME size:13.0f]];
    [labelTip setTextColor:THEME_COLOR_TEXT];
    [labelTip setNumberOfLines:0];
    [labelTip sizeToFit];
    [headView addSubview:labelTip];
    
    tableSale.tableHeaderView = headView;
    
    UIView *footView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, 160)];
    [footView setBackgroundColor:[UIColor clearColor]];
    tableSale.tableFooterView = footView;
    
    UIButton *btnSubmit = [UIButton buttonWithType:UIButtonTypeCustom];
    [btnSubmit setBackgroundImage:[UIImage imageNamed:@"button"] forState:UIControlStateNormal];
    [btnSubmit setTitle:@"提交" forState:UIControlStateNormal];
    [btnSubmit setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [btnSubmit addTarget:self action:@selector(btnSubmitClick:) forControlEvents:UIControlEventTouchUpInside];
    [btnSubmit setFrame:CGRectMake(15, 10, kScreenWidth - 15 * 2, 40)];
    [footView addSubview:btnSubmit];
    
}

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return arrayLeft.count;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSString *strLeft = [arrayLeft objectAtIndex:indexPath.section];
    NSString *strRight = [arrayRight objectAtIndex:indexPath.section];
    NSDictionary *dic = [[NSDictionary alloc] initWithObjectsAndKeys:strLeft,@"left",strRight,@"right", nil];
    return [HWOrderCell getOrderCellHeight:dic];
}

//调整section之间的高度
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 5.0f;
}

//- (CGFloat)tableView:(UITableView *)tableView estimatedHeightForHeaderInSection:(NSInteger)section
//{
//    return 5.0f;
//}

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

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 1;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    HWOrderCell *cell = (HWOrderCell *)[tableView dequeueReusableCellWithIdentifier:@"cell"];
    if (!cell)
    {
        cell = [[HWOrderCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"cell"];
    }
    cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    NSString *strLeft = [arrayLeft objectAtIndex:indexPath.section];
    NSString *strRight = [arrayRight objectAtIndex:indexPath.section];
    NSDictionary *dic = [[NSDictionary alloc] initWithObjectsAndKeys:strLeft,@"left",strRight,@"right", nil];
    cell.orderCellDic = dic;
    
    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    switch (indexPath.section)
    {
        case 0:
        {
            HWRentsIntentionVC *intention = [[HWRentsIntentionVC alloc] init];
            intention.delegate = self;
            intention.superVC = self;
            [self.navigationController pushViewController:intention animated:YES];
        }
            break;
            case 1:
        {
            HWRentsPeopleInfoVC *peopleInfo = [[HWRentsPeopleInfoVC alloc] init];
            peopleInfo.delegate = self;
            peopleInfo.superVC = self;
            [self.navigationController pushViewController:peopleInfo animated:YES];
        }
            break;
            case 2:
        {
            HWRentsAddressVC *address = [[HWRentsAddressVC alloc] init];
            address.delegate = self;
            address.superVC = self;
            [self.navigationController pushViewController:address animated:YES];
        }
            break;
            case 3:
        {
            HWRentsAreaVC *area = [[HWRentsAreaVC alloc] init];
            area.delegate = self;
            area.superVC = self;
            [self.navigationController pushViewController:area animated:YES];
        }
            break;
            case 4:
        {
            HWRentsHuXingVC *huxing = [[HWRentsHuXingVC alloc] init];
            huxing.delegate = self;
            huxing.superVC = self;
            [self.navigationController pushViewController:huxing animated:YES];
        }
            break;
        default:
            break;
    }
}

//意向
-(void)getRentsIntention
{
    HWRentsData *rents = [HWRentsData getRentsData];
    [arrayRight replaceObjectAtIndex:0 withObject:rents.strIntention];
    [tableSale reloadData];
}
//房东信息
-(void)getRentsPeopleInfo
{
    HWRentsData *rents = [HWRentsData getRentsData];
    NSString *strPeopleInfo = [NSString stringWithFormat:@"%@    %@",rents.strName,rents.strPhone];
    [arrayRight replaceObjectAtIndex:1 withObject:strPeopleInfo];
    [tableSale reloadData];
}
//地址
-(void)getRentsAddress
{
    HWRentsData *rents = [HWRentsData getRentsData];
    [arrayRight replaceObjectAtIndex:2 withObject:rents.strAddress];
    [tableSale reloadData];
}
//面积
-(void)getRentsArea
{
    HWRentsData *rents = [HWRentsData getRentsData];
    [arrayRight replaceObjectAtIndex:3 withObject:rents.strArea];
    [tableSale reloadData];
}
//户型
-(void)getRentsHuXing
{
    HWRentsData *rents = [HWRentsData getRentsData];
    [arrayRight replaceObjectAtIndex:4 withObject:rents.strHuXing];
    [tableSale reloadData];
}

- (void)btnSubmitClick:(id)sender
{
    
    HWRentsData *rents = [HWRentsData getRentsData];
    
    NSString *strType = rents.strIntention;
    NSString *type;
    if ([strType isEqualToString:@"出租房屋"])
    {
        type = @"1";
    }
    else if ([strType isEqualToString:@"出售房屋"])
    {
        type = @"2";
    }
    else
    {
        //提示
        [Utility showToastWithMessage:@"请选择租售意向" inView:self.view];
        return;
    }
    
    NSString *houseOwnerName = rents.strName;
    if (houseOwnerName.length <= 0)
    {
        //提示
        [Utility showToastWithMessage:@"户主名字未填写" inView:self.view];
        return;
    }
    
    NSString *phoneNumber = rents.strPhone;
    if (phoneNumber.length <= 0)            //有可能为座机否？
    {
        //提示
        [Utility showToastWithMessage:@"手机号码未填写" inView:self.view];
        return;
    }
    
    NSString *address = rents.strAddress;
    if (address.length <= 0)
    {
        //提示
        [Utility showToastWithMessage:@"地址未填写" inView:self.view];
        return;
    }
    
    NSString *mianji = rents.strArea;
    if (mianji.length <= 0)
    {
        //提示
        [Utility showToastWithMessage:@"面积未填写" inView:self.view];
        return;
    }
    
    NSString *strBuildNo = rents.buildNo;
    if (strBuildNo.length <= 0)
    {
        [Utility showToastWithMessage:@"楼号未填写" inView:self.view];
        return;
    }
    
    NSString *strRoomNo = rents.roomNo;
    if (strRoomNo.length <= 0)
    {
        [Utility showToastWithMessage:@"房号未填写" inView:self.view];
        return;
    }
    
    NSString *huxing = rents.strHuXing;
    if (huxing.length <= 0)
    {
        //提示
        [Utility showToastWithMessage:@"户型未选择" inView:self.view];
        return;
    }
    
    HWUserLogin *user = [HWUserLogin currentUserLogin];
    NSMutableDictionary *dict = [[NSMutableDictionary alloc] init];
    [dict setPObject:user.key forKey:@"key"];
    [dict setPObject:type forKey:@"type"];
    [dict setPObject:houseOwnerName forKey:@"houseOwnerName"];
    [dict setPObject:phoneNumber forKey:@"phoneNumber"];
    [dict setPObject:address forKey:@"addr"];
    [dict setPObject:mianji forKey:@"mianji"];
    [dict setPObject:huxing forKey:@"huxing"];
    [dict setPObject:strRoomNo forKey:@"roomNumber"];
    [dict setPObject:strBuildNo forKey:@"buildingNum"];
    [dict setPObject:user.residendId forKey:@"residentId"];
    [dict setPObject:user.tenementId forKey:@"tenementId"];
    [dict setPObject:user.villageId forKey:@"villageId"];
    [dict setPObject:phoneHistoryId forKey:@"phoneHistoryId"];
    [Utility showMBProgress:self.view message:@"请求数据"];
    HWHTTPRequestOperationManager *manage = [HWHTTPRequestOperationManager manager];
    [manage POST:kRentalhosting parameters:dict queue:nil success:^(id responseObject) {
//        NSLog(@"responseObject = %@",responseObject);
        [Utility hideMBProgress:self.view];
        NSDictionary *dic = (NSDictionary *)responseObject;
        NSString *strStatus = [dic stringObjectForKey:@"status"];
        if ([strStatus isEqualToString:@"1"])
        {
            
            UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"提示" message:@"你的租售托管申请已经提交，后续会有相关工作人员和您联系" delegate:self cancelButtonTitle:nil otherButtonTitles:@"确定", nil];
            alert.tag = 789;
            [alert show];
        
//            [Utility showToastWithMessage:@"提交成功" inView:self.view];
//            [self performSelector:@selector(hidePop) withObject:nil afterDelay:2.0f];

        }

    } failure:^(NSString *code, NSString *error) {
//        NSLog(@"error = %@",error);
        [Utility hideMBProgress:self.view];
        [Utility showAlertWithMessage:error];
        return ;
    }];
}

-(void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    if (alertView.tag == 789)
    {
        if (buttonIndex == 0)
        {
            [self hidePop];
        }
    }
}

- (void)hidePop
{
    if (self.phoneHistoryId)
    {
        [self.navigationController popToRootViewControllerAnimated:YES];
    }
    else
    {
        [self.navigationController popToViewController:self.rootVC animated:YES];
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
