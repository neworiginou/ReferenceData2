//
//  FangResultViewController.m
//  FangDaiDemo
//
//  Created by baiteng-5 on 14-1-17.
//  Copyright (c) 2014年 org.baiteng. All rights reserved.
//

#import "HWFangResultViewController.h"
#import "HWMonthRepaymentViewController.h"
#import "Partner_Swift-Swift.h"
#import "Define-OC.h"


@interface HWFangResultViewController ()

@property (nonatomic, retain) UIScrollView * coverScrollview;//背景滚动视图
@property (nonatomic, retain) UIView * btnView;//按钮容器
@property (nonatomic, retain) HWExpendTableView * expendView;//可展开列表
@property (nonatomic, retain) UIButton * expendBtn;
@end
@implementation HWFangResultViewController
@synthesize xianType;
@synthesize coverScrollview;
@synthesize oneTableView;
@synthesize btnView;
@synthesize expendView;
@synthesize expendBtn;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}
/**
 *	@brief	返回上一级
 *
 *	@param 	sender
 *
 *	@return	 无
 */
-(void)backBtn:(id)sender
{
    [self.navigationController popViewControllerAnimated:YES];
}
- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.
    self.view.backgroundColor = [UIColor whiteColor];
//    if ([Utility isIOS7]) {
//        self.navigationController.edgesForExtendedLayout = UIRectEdgeNone;
//    }
    self.navigationItem.titleView = [Utility navTitleView:@"房贷计算器"];
    self.navigationItem.leftBarButtonItem = [Utility navLeftBackBtn:self _selector:@selector(backBtn:)];
    
    //添加背景滚动视图
    coverScrollview = [[UIScrollView alloc]initWithFrame:CGRectMake(0, 0, kScreenWidth, self.view.frame.size.height)];
    coverScrollview.backgroundColor = [UIColor clearColor];
    coverScrollview.contentSize = CGSizeMake(kScreenWidth, self.view.frame.size.height);
    [self.view addSubview:coverScrollview];
    
    //判断加载类型
    if ([xianType isEqualToString:@"1"]) {
        [self addViewOne];
    }
    if ([xianType isEqualToString:@"2"]) {
        [self addViewTwo];
    }
}

/**
 *	@brief	增加视图一（等额本息模式）
 *
 *	@return	 无
 */
-(void)addViewOne
{
    //添加列表
    oneTableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 10, kScreenWidth - 10, self.nameArray_1.count*55) style:UITableViewStylePlain];
    oneTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
//    if (![Utility isIOS7]) {
//        oneTableView.frame = CGRectMake(0, 0, 320, self.nameArray_1.count*55);
//        if(self.nameArray_1.count*55+100>=self.view.frame.size.height)
//        {
//            coverScrollview.contentSize = CGSizeMake(320, self.nameArray_1.count+100+10+10);
//        }
//        
//    }
//    else
//    {
        oneTableView.frame = CGRectMake(0, 0, kScreenWidth - 10, self.nameArray_1.count*55);
        if(self.nameArray_1.count*55+100>=self.view.frame.size.height)
        {
            coverScrollview.contentSize = CGSizeMake(kScreenWidth - 10, self.nameArray_1.count*55+100+10);
        }

//    }
    oneTableView.backgroundView.alpha = 0;
    oneTableView.dataSource = self;
    oneTableView.delegate = self;
    oneTableView.scrollEnabled = NO;
    oneTableView.backgroundColor = [UIColor clearColor];
    [coverScrollview addSubview:oneTableView];
    
    UIView *line = [[UIView alloc] initWithFrame:CGRectMake(0,self.nameArray_1.count*55, kScreenWidth, 0.5)];
    [line setBackgroundColor:[UIColor lightGrayColor]];
    [coverScrollview addSubview:line];
    
    //添加按钮视图
    btnView = [[UIView alloc]initWithFrame:CGRectMake(0, oneTableView.frame.origin.y+oneTableView.frame.size.height, kScreenWidth, 100)];
    btnView.backgroundColor = [UIColor clearColor];
    //标题1
    UILabel * label_1 = [[UILabel alloc]initWithFrame:CGRectMake(20, 0, kScreenWidth - 20, 20)];
    label_1.backgroundColor = [UIColor clearColor];
    label_1.font = [UIFont fontWithName:FONTNAME size:12];
    label_1.textColor = [UIColor grayColor];
    label_1.text = @"*以上结果仅供参考。";
    [btnView addSubview:label_1];
    //标题2
    UILabel * label_2 = [[UILabel alloc]initWithFrame:CGRectMake(20, 20, kScreenWidth - 20, 20)];
    label_2.backgroundColor = [UIColor clearColor];
    label_2.font = [UIFont fontWithName:FONTNAME size:12];
    label_2.textColor = [UIColor grayColor];
    label_2.text = @"*房产计算结果最终以实际交易金额为准。";
    [btnView addSubview:label_2];
    [coverScrollview addSubview:btnView];
}
#pragma mark -------Tab Dele-------
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
     if ([xianType isEqualToString:@"1"])
     {
         return [self.nameArray_1 count];
     }
    return self.nameArray_1.count+1;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 55;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString * CellWithIdentifier = @"Cell";
    UITableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:CellWithIdentifier];
    if (cell == nil) {
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellWithIdentifier];
        
    }
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    NSUInteger row = [indexPath row];
    //名称栏
    UILabel * name = [[UILabel alloc]initWithFrame:CGRectMake(15, 17, 100, 21)];
    name.backgroundColor = [UIColor clearColor];
    
    UIView *line = [[UIView alloc] initWithFrame:CGRectMake(15,54.5, kScreenWidth - 30, 0.5)];
    [line setBackgroundColor:[UIColor lightGrayColor]];
//    if (row < [self.nameArray_1 count]) {
    if ([xianType isEqualToString:@"1"]) {
        name.text = [self.nameArray_1 objectAtIndex:row];
        if (row < [self.nameArray_1 count]-1) {
             [cell.contentView addSubview:line];
        }
    }
    else
    {
        if (row < [self.nameArray_1 count])
        {
           name.text = [self.nameArray_1 objectAtIndex:row];
           [cell.contentView addSubview:line];
        }
        else
        {
           name.text = @"月均还款";
        }
    }

    name.font = [UIFont fontWithName:FONTNAME size:14];
    [cell.contentView addSubview:name];
    //数据栏
    UILabel * data = [[UILabel alloc]initWithFrame:CGRectMake(100, 17, kScreenWidth - 120, 21)];
    data.backgroundColor = [UIColor clearColor];
//    if (row < [self.dataArray_1 count]) {
    if ([xianType isEqualToString:@"1"])
    {
        data.text = [self.dataArray_1 objectAtIndex:row];
        

    }
    else
    {
        if (row < [self.nameArray_1 count]) {
             data.text = [self.dataArray_1 objectAtIndex:row];
        }
        else
        {
            data.text = @"";
            cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
        }
    }
    data.font = [UIFont fontWithName:FONTNAME size:14];
    data.textAlignment = NSTextAlignmentRight;
    data.textColor = [UIColor grayColor];
    [cell.contentView addSubview:data];
    
    return cell;
}

-(float)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    return 0.0f;
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if ([indexPath row]== [self.nameArray_1 count]) {
        HWMonthRepaymentViewController *monthRepaymentView = [[HWMonthRepaymentViewController alloc]init];
        monthRepaymentView.nameArray_2 = self.nameArray_2;
        monthRepaymentView.dataArray_2 = self.dataArray_2;
        [self.navigationController pushViewController:monthRepaymentView animated:YES];
    }
}
/**
 *	@brief	增加视图二（等额本金视图）
 *
 *	@return	  无
 */
-(void)addViewTwo
{
    //添加列表
    oneTableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, kScreenWidth - 10, (self.nameArray_1.count+1)*55) style:UITableViewStylePlain];
    oneTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
//    if (![Utility isIOS7]) {
//        oneTableView.frame = CGRectMake(0, 0, 320, (self.nameArray_1.count+1)*55);
//        if((self.nameArray_1.count+1)*55+100>=self.view.frame.size.height)
//        {
//            coverScrollview.contentSize = CGSizeMake(310, (self.nameArray_1.count+1)*55+100+10);
//        }
//    }
//    else
//    {
        oneTableView.frame = CGRectMake(0, 0, kScreenWidth - 10, (self.nameArray_1.count+1)*55);
        if((self.nameArray_1.count+1)*55+100>=self.view.frame.size.height)
        {
            coverScrollview.contentSize = CGSizeMake(kScreenWidth - 10, (self.nameArray_1.count+1)*55+100+10);
        }
        
//    }

    oneTableView.backgroundView.alpha = 0;
    oneTableView.dataSource = self;
    oneTableView.delegate = self;
    oneTableView.scrollEnabled = NO;
    [coverScrollview addSubview:oneTableView];
    
    UIView *line = [[UIView alloc] initWithFrame:CGRectMake(0, (self.nameArray_1.count+1)*55, kScreenWidth, 0.5)];
    [line setBackgroundColor:[UIColor lightGrayColor]];
    [coverScrollview addSubview:line];
    
    //添加按钮视图
    btnView = [[UIView alloc]initWithFrame:CGRectMake(0, oneTableView.frame.origin.y+oneTableView.frame.size.height+15, 320, 100)];
    btnView.backgroundColor = [UIColor clearColor];
    //标题1
    UILabel * label_1 = [[UILabel alloc]initWithFrame:CGRectMake(20, 3, kScreenWidth - 20, 20)];
    label_1.backgroundColor = [UIColor clearColor];
    label_1.font = [UIFont fontWithName:FONTNAME size:12];
    label_1.textColor = [UIColor grayColor];
    label_1.text = @"*以上结果仅供参考。";
    [btnView addSubview:label_1];
    //标题2
    UILabel * label_2 = [[UILabel alloc]initWithFrame:CGRectMake(20, 25, kScreenWidth - 20, 20)];
    label_2.backgroundColor = [UIColor clearColor];
    label_2.font = [UIFont fontWithName:FONTNAME size:12];
    label_2.textColor = [UIColor grayColor];
    label_2.text = @"*房产计算结果最终以实际交易金额为准。";
    [btnView addSubview:label_2];

    [coverScrollview addSubview:btnView];
    //判断滚动范伟
    coverScrollview.contentSize = CGSizeMake(kScreenWidth - 20, 500);
}
- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
