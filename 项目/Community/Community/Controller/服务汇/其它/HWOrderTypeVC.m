//
//  HWOrderTypeVC.m
//  Community
//
//  Created by lizhongqiang on 14-9-3.
//  Copyright (c) 2014年 caijingpeng. All rights reserved.
//  预约物业维修问题类型

#import "HWOrderTypeVC.h"

@interface HWOrderTypeVC ()
{
    NSMutableArray *arrayBase;
    NSMutableArray *arrNormal;
    NSMutableArray *arrSelect;
}
@end

@implementation HWOrderTypeVC
@synthesize delegate;
- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)back:(id)sender
{
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)btnSure
{
    [MobClick event:@"click_submit_button"];
    HWOrderData *order = [HWOrderData getOrderData];
    if (isCustom == YES)
    {
        if ([customText.text isEqualToString:@"简单描述下需要上门的问题吧"] || customText.text.length == 0)
        {
            //提示还未输入
            [Utility showAlertWithMessage:@"请输入您需要上门的问题"];
            return;
        }
        else
        {
            order.serviceType = customText.text;
            [delegate getOrderType];
            [self.navigationController popViewControllerAnimated:YES];
        }
    }
    else    //直接取得选择的问题
    {
        order.serviceType = strQuestion;
        [delegate getOrderType];
        [self.navigationController popViewControllerAnimated:YES];
    }
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    
    self.navigationItem.titleView = [Utility navTitleView:@"物业上门"];
    self.navigationItem.leftBarButtonItem = [Utility navLeftBackBtn:self action:@selector(back:)];
    
    [self.view setBackgroundColor:THEME_COLOR_TEXTBACKGROUND];
    isCustom = NO;
    
    UILabel *labTitle = [[UILabel alloc] initWithFrame:CGRectMake(15, 10, kScreenWidth - 30, 28)];
    [labTitle setBackgroundColor:[UIColor clearColor]];
    [labTitle setText:@"请选择问题类型"];
    [labTitle setTextColor:THEME_COLOR_TEXT];
    [labTitle setFont:[UIFont fontWithName:FONTNAME size:THEME_FONT_SMALL]];
    [self.view addSubview:labTitle];
    
    arrayBase = [[NSMutableArray alloc] init];
    
    [self getServiceTypeData];
    
}

- (void)getServiceTypeData
{
    NSMutableDictionary *dict = [[NSMutableDictionary alloc] init];
    [dict setPObject:[HWUserLogin currentUserLogin].key forKey:@"key"];
    [dict setPObject:@"400" forKey:@"parentDictId"];
    HWHTTPRequestOperationManager *manage = [HWHTTPRequestOperationManager manager];
    [manage POST:kServiceBaseData parameters:dict queue:nil success:^(id responseObject) {
        NSLog(@"%@",responseObject);
        NSDictionary *data = [responseObject dictionaryObjectForKey:@"data"];
        NSArray *array = [data arrayObjectForKey:@"content"];
        if (array.count <= 3)
        {
            [arrayBase addObject:array];
        }
        else
        {
            NSInteger row;
            NSInteger num = array.count % 3;
            if (num > 0)
            {
                row = array.count / 3 + 1;
            }
            else
            {
                row = array.count / 3;
            }
            
            for (int i = 0; i < row; i ++)
            {
                NSMutableArray *arrList = [[NSMutableArray alloc] init];
                NSInteger count = 0;
                NSInteger num = array.count - 3 * i;
                if (num > 3)
                {
                    count = 3;
                }
                else
                {
                    count = num;
                }
                for (int k = 0; k < count; k ++)
                {
                    HWServiceBaseDataClass *base = [[HWServiceBaseDataClass alloc] initWithDictionary:[array objectAtIndex:3 * i + k]];
                    [arrList addObject:base];
                    
                }
                [arrayBase addObject:arrList];
        
            }
        }
        
        [self createCollectionView];
        
    } failure:^(NSString *code, NSString *error) {
        NSLog(@"%@",error);
    }];
}

- (void)createCollectionView
{
    UICollectionViewFlowLayout *collectLayout = [[UICollectionViewFlowLayout alloc] init];
    collectLayout.itemSize = CGSizeMake(60, 80);//每格子大小
    CGFloat paddingY = 10;
//    CGFloat paddingX = (kScreenWidth - 60 * 3) / 6;
    NSLog(@"%f",kScreenWidth);
    CGFloat paddingX = 30;
    collectLayout.sectionInset = UIEdgeInsetsMake(paddingY, paddingX, paddingY, paddingX);//内边距   top, left, bottom, right
    CGFloat colWidth = (kScreenWidth - 60 * 3 - 30 - 30) / 2;
    collectLayout.minimumInteritemSpacing = colWidth; // 列间距
    
    UICollectionView *collect = [[UICollectionView alloc] initWithFrame:CGRectMake(0, 35, kScreenWidth, arrayBase.count * 80 + 30) collectionViewLayout:collectLayout];
    [collect registerClass:[HWServerTypeCell class] forCellWithReuseIdentifier:@"cell"];
    collect.delegate = self;
    collect.dataSource = self;
    collect.scrollEnabled = NO;
    collect.backgroundColor = [UIColor clearColor];
    //    collect.backgroundColor = THEME_COLOR_ORANGE_HIGHLIGHT;
    [self.view addSubview:collect];
    
    
    int btnY = collect.frame.origin.y + collect.frame.size.height + 25;
    UIButton *btnCustom = [UIButton buttonWithType:UIButtonTypeCustom];
    [btnCustom setFrame:CGRectMake(30, btnY, 50, 50)];
    [btnCustom setBackgroundImage:[UIImage imageNamed:@"custom"] forState:UIControlStateNormal];
    [btnCustom setImage:[UIImage imageNamed:@"custom_sel"] forState:UIControlStateHighlighted];
    [btnCustom addTarget:self action:@selector(btnCustomClick:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:btnCustom];
    
    UILabel *labelCustom = [[UILabel alloc] initWithFrame:CGRectMake(30, btnY + 55, 50, 21)];
    [labelCustom setBackgroundColor:[UIColor clearColor]];
    [labelCustom setText:@"自定义"];
    [labelCustom setTextColor:THEME_COLOR_SMOKE];
    [labelCustom setFont:[UIFont fontWithName:FONTNAME size:THEME_FONT_BIG]];
    [labelCustom setTextAlignment:NSTextAlignmentCenter];
    [self.view addSubview:labelCustom];
}

#pragma mark -
#pragma mark collect

//-(UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout insetForSectionAtIndex:(NSInteger)section
//{
//    UIEdgeInsets *edge = UIEdgeInsetsMake(10.0f, 30.0f, 10.0f, 60.0f);
//    return edge;
////    return nil;
//}

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView
{
    return arrayBase.count;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return [[arrayBase objectAtIndex:section] count];
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    HWServerTypeCell *cell = (HWServerTypeCell *)[collectionView dequeueReusableCellWithReuseIdentifier:@"cell" forIndexPath:indexPath];
    if (!cell)
    {
        cell = [[HWServerTypeCell alloc] initWithFrame:CGRectMake(15, 0, 90, 30)];
    }
    
    HWServiceBaseDataClass *base = arrayBase[indexPath.section][indexPath.row];
//    NSLog(@"%@",base);

    cell.baseService = base;
    cell.section = indexPath.section;
    cell.row = indexPath.row;
    
    return cell;
    
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{

    HWServiceBaseDataClass *base = arrayBase[indexPath.section][indexPath.row];
    NSString *strType = base.dictCodeText;
    NSString *strTypeId = base.dictId;
    
    HWOrderData *order = [HWOrderData getOrderData];
//    if (isCustom == YES)
//    {
//        if ([customText.text isEqualToString:@"简单描述下需要上门的问题吧"] || customText.text.length == 0)
//        {
//            //提示还未输入
//            [Utility showAlertWithMessage:@"请输入您需要上门的问题"];
//            return;
//        }
//        else
//        {
//            order.serviceType = customText.text;
//            [delegate getOrderType];
//            [self.navigationController popViewControllerAnimated:YES];
//        }
//    }
//    else    //直接取得选择的问题
//    {
        if ([strTypeId isEqualToString:@"401"])//维修水管
        {
            [MobClick event:@"click_plumber_problem"];
        }
        else if ([strTypeId isEqualToString:@"402"])//窗户错位
        {
            [MobClick event:@"click_window_problem"];
        }
        else if ([strTypeId isEqualToString:@"403"])//墙面断裂
        {
            [MobClick event:@"click_metope_problem"];
        }
        else if ([strTypeId isEqualToString:@"404"])//维修电路
        {
            [MobClick event:@""];
        }
        else if ([strTypeId isEqualToString:@"405"])//地面
        {
            [MobClick event:@"click_floor_problem"];
        }
        else if ([strTypeId isEqualToString:@"406"])//燃气
        {
//            [MobClick event:@""];
        }
        order.serviceType = strType;
        [delegate getOrderType];
        [self.navigationController popViewControllerAnimated:YES];
//    }
}

#pragma mark -

- (void)btnCustomClick:(id)sender
{
    [MobClick event:@"click_another_problem"];
    self.navigationItem.rightBarButtonItem = [Utility navButton:self title:@"确定" action:@selector(btnSure)];
    
    for (UIView *view in [self.view subviews])
    {
        [view removeFromSuperview];
    }
    
    UIView *bgView = [[UIView alloc] initWithFrame:CGRectMake(0, self.view.frame.size.height, kScreenWidth, 135)];
    [bgView setBackgroundColor:[UIColor whiteColor]];
    [self.view addSubview:bgView];
    
    for (int i = 0; i < 2; i ++)
    {
        UIView *line = [[UIView alloc] initWithFrame:CGRectMake(0, 0 + 134.5 * i, kScreenWidth, 0.5)];
        [line setBackgroundColor:THEME_COLOR_LINE];
        [bgView addSubview:line];
    }
    
    isCustom = YES;
    customText = [[UITextView alloc] initWithFrame:CGRectMake(15, 0.5, kScreenWidth - 10 * 2, 134)];
    customText.text = @"简单描述下需要上门的问题吧";
    customText.textColor = THEME_COLOR_TEXT;
    customText.delegate = self;
    [customText setFont:[UIFont fontWithName:FONTNAME size:15.0f]];
    [bgView addSubview:customText];
    
    
    [UIView animateWithDuration:0.8f animations:^{
        [bgView setFrame:CGRectMake(0, 10, kScreenWidth, 135)];
    } completion:^(BOOL finished) {
        
    }];
}

-(BOOL)textViewShouldBeginEditing:(UITextView *)textView
{
    [MobClick event:@"get_focus_another"];
    if (textView == customText)
    {
        customText.textColor = THEME_COLOR_SMOKE;
        customText.text = @"";
    }
    return YES;
}



- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
