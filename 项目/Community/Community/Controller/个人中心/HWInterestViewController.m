//
//  HWInterestViewController.m
//  Community
//
//  Created by gusheng on 14-9-7.
//  Copyright (c) 2014年 caijingpeng. All rights reserved.
//

#import "HWInterestViewController.h"
#import "HWInputBackView.h"
#import "HWRequestConfig.h"
#import "HWHTTPRequestOperationManager.h"
#import "HWCoreDataManager.h"
#import "HWInterestCollCell.h"

@interface HWInterestViewController ()<UICollectionViewDataSource,UICollectionViewDelegate>
{
    NSArray *dataListArr;               //默认数据
    NSMutableArray *selectArr;          //选择
    UICollectionView *collect;
}
@end

@implementation HWInterestViewController
@synthesize interestText;

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
    
    self.navigationItem.titleView = [Utility navTitleView:@"选择爱好"];
    self.navigationItem.leftBarButtonItem = [Utility navLeftBackBtn:self action:@selector(backMethod)];
    self.navigationItem.rightBarButtonItem = [Utility navButton:self title:@"提交" action:@selector(submitInterest:)];
    selectArr = [[NSMutableArray alloc] init];
    dataListArr = @[@[@"爱睡觉",@"爱看书",@"爱运动"],@[@"爱美食",@"爱旅游",@"爱喝酒"],@[@"爱音乐",@"爱电影",@"爱星座"],@[@"爱桌游",@"爱美容",@"爱科技"],@[@"爱育儿",@"爱养生",@"爱八卦"]];
    UICollectionViewFlowLayout *collectLayout = [[UICollectionViewFlowLayout alloc] init];
    collectLayout.itemSize = CGSizeMake(87, 35);//每格子大小
//    CGFloat paddingY = 0;
//    CGFloat paddingX = 0;
    
    collectLayout.sectionInset = UIEdgeInsetsMake(10, 15, 10, 15);//内边距   top, left, bottom, right
    
    CGFloat colWidth = (kScreenWidth - 87 * 3 - 15 - 15) / 2;
    collectLayout.minimumInteritemSpacing = colWidth;
    
    collect = [[UICollectionView alloc] initWithFrame:CGRectMake(0, 10, kScreenWidth, dataListArr.count * 80 + 30) collectionViewLayout:collectLayout];
    [collect registerClass:[HWInterestCollCell class] forCellWithReuseIdentifier:@"cell"];
    collect.delegate = self;
    collect.dataSource = self;
    collect.scrollEnabled = YES;
    collect.backgroundColor = [UIColor clearColor];
    [self.view addSubview:collect];
    
    self.interestText = [HWUserLogin currentUserLogin].favorite;
}
#pragma mark -

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView
{
    return dataListArr.count;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return 3;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    HWInterestCollCell *cell = (HWInterestCollCell *)[collectionView dequeueReusableCellWithReuseIdentifier:@"cell" forIndexPath:indexPath];
    if (!cell) {
        cell = [[HWInterestCollCell alloc] init];
    }
    
    NSString *strNew = dataListArr[indexPath.section][indexPath.row];
//    NSLog(@"新的 = %@",strNew);
    NSInteger length = interestText.length;
    NSInteger max = (length / 4 > 3) ? 3 : length / 4;
    
    cell.btnName.selected = NO;
    cell.btnName.layer.borderColor = THEME_COLOR_TEXT.CGColor;
    [cell.btnName setTitleColor:THEME_COLOR_TEXT forState:UIControlStateNormal];
    
    for (int i = 0; i < max; i ++)
    {
        
        NSString *strOld = [[interestText substringFromIndex:0 + 4 * i] substringToIndex:3];
//        NSLog(@"老的 = %@",strOld);
        if ([strNew isEqualToString:strOld])
        {
            [selectArr addObject:strOld];
            cell.btnName.selected = YES;
            [cell.btnName setBackgroundColor:[UIColor whiteColor]];
            cell.btnName.layer.borderColor = THEME_COLOR_ORANGE.CGColor;
            [cell.btnName setTitleColor:THEME_COLOR_ORANGE forState:UIControlStateNormal];
        }
        
    }
    [cell.btnName setTitle:strNew forState:UIControlStateNormal];
    [cell.btnName addTarget:self action:@selector(btnNameClick:) forControlEvents:UIControlEventTouchUpInside];
    return cell;
    
}

- (void)btnNameClick:(id)sender
{
    UIButton *btn = (UIButton *)sender;
//    NSLog(@"文字 = %@",btn.titleLabel.text);

    if (btn.selected)
    {
        [selectArr removeObject:btn.titleLabel.text];
        btn.selected = NO;
        btn.layer.borderColor = THEME_COLOR_TEXT.CGColor;
        [btn setBackgroundColor:BACKGROUND_COLOR];
        [btn setTitleColor:THEME_COLOR_TEXT forState:UIControlStateNormal];
    }
    else
    {
        if (selectArr.count >= 3)
        {
            [Utility showToastWithMessage:@"最多只能选择三个哦~" inView:self.view];
            return;
        }
        [selectArr addObject:btn.titleLabel.text];
        btn.selected = YES;
        [btn setBackgroundColor:[UIColor whiteColor]];
        btn.layer.borderColor = THEME_COLOR_ORANGE.CGColor;
        [btn setTitleColor:THEME_COLOR_ORANGE forState:UIControlStateNormal];
    }
    
}


//提交爱好请求
-(void)submitInterest:(id)sender
{
    NSString *strInterest = @"";
    for (int i = 0; i < selectArr.count; i ++)
    {
        NSString *str = [NSString stringWithFormat:@"%@,",selectArr[i]];
        strInterest = [strInterest stringByAppendingString:str];
    }
    if (selectArr.count > 0)
    {
        strInterest = [[strInterest substringFromIndex:0] substringToIndex:strInterest.length - 1];
        strInterest = [NSString stringWithFormat:@"%@的考拉",strInterest];
    }
    
    
    HWHTTPRequestOperationManager *manager = [HWHTTPRequestOperationManager manager];
    NSMutableDictionary *dict = [NSMutableDictionary dictionary];
    [dict setPObject:[HWUserLogin currentUserLogin].key forKey:@"key"];
    [dict setPObject:strInterest forKey:@"hobby"];
    [manager POST:kSubmitInterest parameters:dict queue:nil success:^(id responseObject) {
        NSString *strStatus = [responseObject stringObjectForKey:@"status"];
        
        if ([strStatus isEqualToString:@"1"])
        {
            NSString *strResult = strInterest;
            if (selectArr.count == 0)
            {
                strResult = @"";
            }
            
            [HWUserLogin currentUserLogin].favorite = strResult;
            [HWCoreDataManager saveUserInfo];
            [self.navigationController popViewControllerAnimated:YES];
        }
        else
        {
            [Utility showToastWithMessage:strStatus inView:self.view];
        }
        
    } failure:^(NSString *code, NSString *error) {
        NSLog(@"error");
        [Utility showToastWithMessage:error inView:self.view];
    }];
    
}

//返回上一级页面
- (void)backMethod
{
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
