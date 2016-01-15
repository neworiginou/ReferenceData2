//
//  HWKaoLaCoinViewController.m
//  TestOne
//
//  Created by gusheng on 14-12-9.
//  Copyright (c) 2014年 gusheng. All rights reserved.
//

#import "HWRechargeViewController.h"
#import "HWCollectionLayout.h"
#import "HWKaolaCoinCollectionViewCell.h"
#import "SQSupplementaryView.h"
#import "HWGeneralControl.h"
#import "HWOrderCoinView.h"
#import "SurePayController.h"

#define kfooterIdentifier @"kfooterIdentifier"
#define kheaderIdentifier @"kheaderIdentifier"

@interface HWRechargeViewController ()<HWOrderCoinViewDelegate>

@end

@implementation HWRechargeViewController
@synthesize dataSource;

- (void)backMethod
{
    [super backMethod];
    if (self.isCutPricePushed)
    {
        [self.navigationController setNavigationBarHidden:NO animated:YES];
    }
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.navigationItem.titleView = [Utility navTitleView:@"考拉币充值"];
    
    self.navigationItem.leftBarButtonItem = [Utility navLeftBackBtn:self action:@selector(backMethod)];
    
    self.view.backgroundColor = BACKGROUND_COLOR;
    HWCollectionLayout *collectLayout = [[HWCollectionLayout alloc]init];
    kaoLaCoinCollectV = [[UICollectionView alloc]initWithFrame:CGRectMake(0, 0, kScreenWidth, CONTENT_HEIGHT) collectionViewLayout:collectLayout];
    kaoLaCoinCollectV.backgroundColor = [UIColor whiteColor];
    kaoLaCoinCollectV.delegate = self;
    kaoLaCoinCollectV.dataSource = self;
    [self.view addSubview:kaoLaCoinCollectV];
    
    [kaoLaCoinCollectV registerClass:[HWKaolaCoinCollectionViewCell class] forCellWithReuseIdentifier:@"KaolaCoinIdentify"];
    
    
    self.dataSource = [NSMutableArray arrayWithCapacity:30];
    NSDictionary *dic;
    for (int i = 0; i < 9; i++)
    {
        switch (i) {
            case 0:
            {
                dic = @{@"imageName":@"KLB_copper80",@"titleName":@"0.8"};
                break;
            }
            case 1:
            {
                dic = @{@"imageName":@"KLB_copper200",@"titleName":@"2.0"};
                break;
            }
            case 2:
            {
                dic = @{@"imageName":@"KLB_copper500",@"titleName":@"5.0"};
                break;
            }
            case 3:
            {
                dic = @{@"imageName":@"KLB_sliver1000",@"titleName":@"10.0"};
                break;
            }
            case 4:
            {
                dic = @{@"imageName":@"KLB_sliver2000",@"titleName":@"20.0"};
                break;
            }
            case 5:
            {
                dic = @{@"imageName":@"KLB_sliver5000",@"titleName":@"50.0"};
                break;
            }
            case 6:
            {
                dic = @{@"imageName":@"KLB_gold10000",@"titleName":@"100.0"};
                break;
            }
            case 7:
            {
                dic = @{@"imageName":@"KLB_gold20000",@"titleName":@"200"};
                break;
            }
            case 8:
            {
                dic = @{@"imageName":@"KLB_gold50000",@"titleName":@"500.0"};
                break;
            }
            default:
                break;
        }
        
        [self.dataSource addObject:dic];
    }
    
    //注册headerView Nib的view需要继承UICollectionReusableView
    [kaoLaCoinCollectV registerClass:[SQSupplementaryView class] forSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:kheaderIdentifier];
    //注册footerView Nib的view需要继承UICollectionReusableView
    [kaoLaCoinCollectV registerClass:[SQSupplementaryView class] forSupplementaryViewOfKind:UICollectionElementKindSectionFooter withReuseIdentifier:kfooterIdentifier];
    //
    kaoLaCoinCollectV.allowsMultipleSelection = YES;//默认为NO,是否可以多选
}
#pragma - mark collectionViewDelegate
// The view that is returned must be retrieved from a call to -dequeueReusableSupplementaryViewOfKind:withReuseIdentifier:forIndexPath:
- (UICollectionReusableView *)collectionView:(UICollectionView *)collectionView viewForSupplementaryElementOfKind:(NSString *)kind atIndexPath:(NSIndexPath *)indexPath{
    
    NSInteger section = indexPath.section;
    NSString *reuseIdentifier;
    if ([kind isEqualToString: UICollectionElementKindSectionFooter ]){
        reuseIdentifier = kfooterIdentifier;
    }else{
        reuseIdentifier = kheaderIdentifier;
    }
    
    UICollectionReusableView *view =  [collectionView dequeueReusableSupplementaryViewOfKind :kind   withReuseIdentifier:reuseIdentifier   forIndexPath:indexPath];
    UILabel *label = (UILabel *)[view viewWithTag:1];
    if ([kind isEqualToString:UICollectionElementKindSectionHeader]){
        if (section == 0) {
            label.text = @"今日行情:1元≈100考拉币";
            label.textColor = THEME_COLOR_GRAY_MIDDLE;
            label.font = [UIFont systemFontOfSize:13.0f];
        }
        else if(section == 1)
        {
            label.text = @"可使用钱包余额充值";
            label.textColor = THEME_COLOR_SMOKE;
            label.font = [UIFont systemFontOfSize:15.0f];
            view.backgroundColor = [UIColor whiteColor];
        }
        else
        {
            label.text = @"可使用钱包余额或者快捷支付充值";
            label.textColor = THEME_COLOR_SMOKE;
            label.font = [UIFont systemFontOfSize:15.0f];
            view.backgroundColor = [UIColor whiteColor];
        }
        
    }
    else if ([kind isEqualToString:UICollectionElementKindSectionFooter])
    {
        view.backgroundColor = BACKGROUND_COLOR;
        if (section == 2)
        {
            NSString *contentStr = @"*考拉币是考拉社区懒人专用货币，不设找赎，可以购买兑换部分小额商品服务";
            label.text = contentStr;
            label.frame = CGRectMake(label.frame.origin.x, label.frame.origin.y+5, label.frame.size.width, 60);
            CGRect factualRect = [HWGeneralControl returnLabelFactualHeightSize:label font:13.0];
            [label setFrame:factualRect];
        }
        
    }
    return view;
   
}
-(NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView
{
    return 3;
}

-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    if (section == 0) {
        return 0;
    }
    else if(section == 1)
    {
        return 3;
    }
    else
    {
        return 6;
    }
}

-(UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    HWKaolaCoinCollectionViewCell *collectionCell = [collectionView dequeueReusableCellWithReuseIdentifier:@"KaolaCoinIdentify" forIndexPath:indexPath];
    if (!collectionCell)
    {
        return nil;
    }
    collectionCell.backgroundColor = [UIColor clearColor];
    if (indexPath.section !=0)
    {
        if (indexPath.section == 1) {
            NSString *titleName = [[self.dataSource objectAtIndex:((indexPath.section-1)*2+indexPath.row)] objectForKey:@"titleName"];
            NSString *imageName = [[self.dataSource objectAtIndex:((indexPath.section-1)*2+indexPath.row)] objectForKey:@"imageName"];
            collectionCell.collectImageView.image = [UIImage imageNamed:imageName];
            collectionCell.collectContent.text = [NSString stringWithFormat:@"￥%@",titleName];
        }
        else
        {
            NSString *titleName = [[self.dataSource objectAtIndex:((indexPath.section-1)*2+indexPath.row+1)] objectForKey:@"titleName"];
            NSString *imageName = [[self.dataSource objectAtIndex:((indexPath.section-1)*2+indexPath.row+1)] objectForKey:@"imageName"];
            collectionCell.collectImageView.image = [UIImage imageNamed:imageName];
            collectionCell.collectContent.text = [NSString stringWithFormat:@"￥%@",titleName];
        }
        
    }
    return collectionCell;
}
//
-(BOOL)collectionView:(UICollectionView *)collectionView shouldSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    return YES;
}
//点击Item方法
-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    [MobClick event:@"click_exchange kaola"];
    
    if (indexPath.section == 1)
    {
        
        NSString *titleName = [[self.dataSource objectAtIndex:((indexPath.section-1)*2+indexPath.row)] objectForKey:@"titleName"];
        //判断余额是不是充足支付小金额的考拉币
        NSString *totalMoney = [HWUserLogin currentUserLogin].totalMoney;
        float totalMoneyFloat = [totalMoney floatValue];
        if (totalMoneyFloat >=[titleName floatValue])
        {
            //
            NSString *coinUrlStr = [[self.dataSource objectAtIndex:((indexPath.section-1)*2+indexPath.row)] objectForKey:@"imageName"];
            HWOrderCoinView *orderView = [[HWOrderCoinView alloc]initWithFrame:CGRectMake(0, 0, kScreenWidth,self.view.bounds.size.height) coinType:titleName coinImageV:coinUrlStr];
            orderView.delegate = self;
            [self.view addSubview:orderView];
        }
        else
        {
            [Utility showAlertWithMessage:@"账户余额不足,请选择快捷支付购买考拉币"];
        }
    }
    else
    {
        NSString *titleName = [[self.dataSource objectAtIndex:((indexPath.section-1)*2+indexPath.row+1)] objectForKey:@"titleName"];
        NSString *coinUrlStr = [[self.dataSource objectAtIndex:((indexPath.section-1)*2+indexPath.row)+1] objectForKey:@"imageName"];
        HWOrderCoinView *orderView = [[HWOrderCoinView alloc]initWithFrame:CGRectMake(0, 0, kScreenWidth,self.view.bounds.size.height) coinType:titleName coinImageV:coinUrlStr];
        orderView.delegate = self;
        [self.view addSubview:orderView];
    }
}
-(void)collectionView:(UICollectionView *)collectionView didDeselectItemAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section == 1) {
        NSString *titleName = [[self.dataSource objectAtIndex:((indexPath.section-1)*2+indexPath.row)] objectForKey:@"titleName"];
        //判断余额是不是充足支付小金额的考拉币
        NSString *totalMoney = [HWUserLogin currentUserLogin].totalMoney;
        float totalMoneyFloat = [totalMoney floatValue];
        if (totalMoneyFloat >=[titleName floatValue])
        {
            //
            NSString *coinUrlStr = [[self.dataSource objectAtIndex:((indexPath.section-1)*2+indexPath.row)] objectForKey:@"imageName"];
            HWOrderCoinView *orderView = [[HWOrderCoinView alloc]initWithFrame:CGRectMake(0, 0, kScreenWidth,self.view.bounds.size.height) coinType:titleName coinImageV:coinUrlStr];
            orderView.delegate = self;
            [self.view addSubview:orderView];
        }
        else
        {
            [Utility showAlertWithMessage:@"账户余额不足,请选择快捷支付购买考拉币"];
        }
        
        //友盟埋点
        switch (indexPath.row) {
            case 0:
                [MobClick event:@"click_0.8yuan"];
                break;
            case 1:
                [MobClick event:@"click_2.0yuan"];
                break;
            case 2:
                [MobClick event:@"click_5.0yuan"];
                break;
                
            default:
                break;
        }
        //
    }
    else
    {
        NSString *titleName = [[self.dataSource objectAtIndex:((indexPath.section-1)*2+indexPath.row+1)] objectForKey:@"titleName"];
        NSString *coinUrlStr = [[self.dataSource objectAtIndex:((indexPath.section-1)*2+indexPath.row)+1] objectForKey:@"imageName"];
        HWOrderCoinView *orderView = [[HWOrderCoinView alloc]initWithFrame:CGRectMake(0, 0, kScreenWidth,self.view.bounds.size.height) coinType:titleName coinImageV:coinUrlStr];
        orderView.delegate = self;
        [self.view addSubview:orderView];
        
        //友盟埋点
        switch (indexPath.row) {
            case 0:
                [MobClick event:@"click_10.0yuan"];
                break;
            case 1:
                [MobClick event:@"click_20.0yuan"];
                break;
            case 2:
                [MobClick event:@"click_50.0yuan"];
                break;
            case 3:
                [MobClick event:@"click_100.0yuan"];
                break;
            case 4:
                [MobClick event:@"click_200.0yuan"];
                break;
            case 5:
                [MobClick event:@"click_500.0yuan"];
                break;
                
                
            default:
                break;
        }
    }
    
}
//定义每个UICollectionViewCell 的大小
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section == 0)
    {
       return  CGSizeMake(0, 0);
    }
    else
    {
        return CGSizeMake((kScreenWidth-4*30)/3,100*kScreenRate);
    }
}
//返回头headerView的大小
-(CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout referenceSizeForHeaderInSection:(NSInteger)section
{
    CGSize size={kScreenWidth,30};
    return size;
}
//返回头footerView的大小
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout referenceSizeForFooterInSection:(NSInteger)section
{
   
   
    if (section == 0) {
        CGSize size = {0,0};
        return size;
    }
    else if(section == 1)
    {
        CGSize size = {kScreenWidth,10};
        return size;
    }
    else
    {
         CGSize size={kScreenWidth,60};
        return size;
    }
    
}
//定义每个Section 的 margin
-(UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout insetForSectionAtIndex:(NSInteger)section
{
    if (section == 0) {
         return UIEdgeInsetsMake(0, 0, 0, 0);//分别为上、左、下、右
    }
    else
    {
        return  UIEdgeInsetsMake(5, 15, 20, 15);
    }
   
}

#pragma mark -
#pragma HWOrderCoinViewDelegate

- (void)confirmPayMoney:(NSString *)payMoney coinCount:(int)count
{
    if (count > 0)
    {
        SurePayController *surePayVC = [[SurePayController alloc] init];
        if([payMoney floatValue] < 6)
        {
            surePayVC.methodType = remainMoneyMothod;
        }
        else
        {
            [MobClick event:@"click_quedingdaezhifu"];
            surePayVC.methodType = ePayMethod;
        }
        if([[HWUserLogin currentUserLogin].totalMoney floatValue] > [payMoney floatValue])
        {
            surePayVC.isSelectedWalletFlag = @"0";//0代表余额支付
        }
        else
        {
            surePayVC.isSelectedWalletFlag = @"1";//1代表支付宝支付
        }
        surePayVC.payMoney = payMoney;
        surePayVC.objectStr = [NSString stringWithFormat:@"%d个考拉币",count];
        surePayVC.subObjectStr = @"考拉币支付";
        surePayVC.orderTypeStr = @"2";//2代表考拉币支付
        surePayVC.buyCoinCount = [NSString stringWithFormat:@"%d", count];
        [self.navigationController pushViewController:surePayVC animated:YES];
    }
    else
    {
        [Utility showToastWithMessage:@"货币数量不能为零" inView:self.view];
    }
   
}


- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    
}
#pragma - mark tableViewDelegate
//tableview代理方法


/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
