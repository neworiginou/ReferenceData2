//
//  MineExtendDetailViewController.m
//  TEST
//
//  Created by gusheng on 14-8-29.
//  Copyright (c) 2014年 gusheng. All rights reserved.
//

#import "MineExtendDetailViewController.h"
#import"MineExtendHeaderView.h"
#import "MineExtendRecordTableViewCell.h"
#import "EveryDayRecordTableViewCell.h"
#import "EveryDayRecordView.h"
#import "HWHTTPRequestOperationManager.h"
#import "TuiGuangYuanUI.h"
#import "MineRecordModel.h"
#import "EveryDayRecordModel.h"

@interface MineExtendDetailViewController ()

@end

@implementation MineExtendDetailViewController
@synthesize questType;

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
    isHeadLoading = YES;
    isTailLoading = YES;
    if([UIDevice currentDevice].systemVersion.floatValue >= 7.0)
    {
        self.edgesForExtendedLayout = UIRectEdgeNone;
    }
    self.baseTableView.delegate = self;
    self.navigationItem.titleView = [Utility navTitleView:@"考拉社区"];
    self.navigationItem.leftBarButtonItem = [Utility navLeftBackBtn:self action:@selector(doBack)];
    [self creatHeadView];
    [self getActiveAndScanNum];
    flag  = 0;
    
    
}
//获取扫码数和激活数
-(void)getActiveAndScanNum
{
    [self getActiveAndScanNumRequest];
}
//获取推广记录
-(void)getExtendRecord
{
    questType = MINEEXTENDKEY;
    [self queryListData];
}
//获取每日记录
-(void)getEveryDayRecord
{
    questType = ERVERYDAYRECORD;
    [self queryListData];
}
//返回上一级
-(void)doBack
{
    [self.navigationController popViewControllerAnimated:YES];
}
-(void)creatHeadView
{
    tableHeaderView = [[MineExtendHeaderView alloc]init];
    __weak MineExtendDetailViewController *myself = self;
    [tableHeaderView setClickSegmentBlock:^(int index)
    {
        myself._currentPage = 0;
        myself.questType = index;
        [myself queryListData];
    }];
    self.baseTableView.tableHeaderView = tableHeaderView;
}
#pragma tableViewDelegate
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath\
{
//    每日
    if(questType == ERVERYDAYRECORD)
    {
        MineExtendRecordTableViewCell *cell = (MineExtendRecordTableViewCell *)[tableView dequeueReusableCellWithIdentifier:@"orderCell"];
        if (!cell) {
            cell = [[MineExtendRecordTableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"orderCell"];
        }
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        EveryDayRecordModel *tempRecord = [self.dataList objectAtIndex:[indexPath row]];
        cell.commissionLabel.text = [NSString stringWithFormat:@"￥%@",tempRecord.commissionStr];
        if(tempRecord.commissionStr.length == 0)
        {
            cell.commissionLabel.text = @"￥0.00";
        }
            
        cell.scanLabel.text = tempRecord.scanStr;
        cell.activeLabel.text = tempRecord.activeStr;
        cell.registerLabel.text = tempRecord.registerStr;
        cell.dateLabel.text = tempRecord.yearAndDayStr;
        return cell;
    }
    else
    {
        EveryDayRecordTableViewCell *cell = (EveryDayRecordTableViewCell *)[tableView dequeueReusableCellWithIdentifier:@"orderCell1"];
        if (!cell) {
            cell = [[EveryDayRecordTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"orderCell1"];
        }
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        MineRecordModel *tempRecord = [self.dataList objectAtIndex:[indexPath row]];
        
        
        cell.phoneStyle.text = tempRecord.phoneStr;
        cell.scanMonthAndDay.text = tempRecord.scanStr;
        cell.activeMonthAndDay.text = tempRecord.activeStr;
        cell.registerTime.text = tempRecord.registerStr;

        
        return cell;
    }
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if(questType == MINEEXTENDKEY)
    {
        return [self.dataList count];//
    }
    return [self.dataList count];//
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    if(questType == MINEEXTENDKEY)
    {
        return 50;//推广记录
    }
    return 100;
}
-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    if(questType == MINEEXTENDKEY)
    {
        EveryDayRecordView *everyDayView = [[EveryDayRecordView alloc]init];
        return everyDayView;
    }
    else
    {
        return nil;
    }
}
-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    if (questType == MINEEXTENDKEY) {
        return 35.0f;
    }
    else{
        return 0.0f;
    }
}
#pragma 发送请求u
- (void)queryListData
{
    [Utility showMBProgress:self.view message:@"请求数据"];
    NSMutableDictionary *param = [NSMutableDictionary dictionary];
    [param setObject:@"10010" forKey:@"appKey"];
    [param setObject:[HWUserLogin currentUserLogin].userId forKey:@"userId"];
//    [param setPObject:[HWUserLogin currentUserLogin].key forKey:@"userName"];
    //TuiGuangYuan_APP_KEY
    NSString *path = nil;
    if (questType == MINEEXTENDKEY || questType == ERVERYDAYRECORD) {
        [param setPObject:[NSString stringWithFormat:@"%d",_currentPage] forKey:@"page"];
        [param setPObject:[NSString stringWithFormat:@"%d",kPageCount] forKey:@"size"];
        if (questType == MINEEXTENDKEY)
        {
            path = kSpreadRecord;
        }
        else
        {
            path = kDailySpreadStatistics;
        }
    }
    else
    {
        path = kGetScanAndActiveNum;
    }
    
    HWHTTPRequestOperationManager *manager = [HWHTTPRequestOperationManager gameManager];
    [manager POST:path parameters:param queue:nil success:^(id responseObject){
        
        
        if ([self.view viewWithTag:1111]) {
            [[self.view viewWithTag:1111] removeFromSuperview];
        }
        NSDictionary *dataDic = [responseObject dictionaryObjectForKey:@"data"];
        [Utility hideMBProgress:self.view];
        if(questType == MINEEXTENDKEY)
        {
            NSArray *array = [dataDic arrayObjectForKey:@"content"];
            if(array.count<kPageCount) {
                refreshTailView.hidden = YES;
                isLastPage = YES;
            }
            else {
                refreshTailView.hidden = NO;
                isLastPage = NO;
            }
            
            if (_currentPage == 0) {
                self.dataList = [NSMutableArray array];
                for (NSDictionary *temp in array) {
                    MineRecordModel *newsM = [[MineRecordModel alloc]initWithDic:temp];
                    [self.dataList addObject:newsM];
                } 
                
            }
            else
            {
                for (NSDictionary *temp in array) {
                    MineRecordModel *newsM = [[MineRecordModel alloc]initWithDic:temp];
                    [self.dataList addObject:newsM];
                }
            }
            [baseTableView reloadData];
            if(self.dataList.count==0) {
             
            }
            
            [self doneLoadingTableViewData];
        }
        else if(questType == ERVERYDAYRECORD)
        {
            NSArray *array = [dataDic arrayObjectForKey:@"content"];
            if(array.count<kPageCount) {
                refreshTailView.hidden = YES;
                isLastPage = YES;
            }
            else {
                refreshTailView.hidden = NO;
                isLastPage = NO;
            }
            
            if (_currentPage == 0) {
                self.dataList = [NSMutableArray array];
                for (NSDictionary *temp in array) {
                    EveryDayRecordModel *newsM = [[EveryDayRecordModel alloc]initWithDic:temp];
                    [self.dataList addObject:newsM];
                }
                
            }
            else
            {
                for (NSDictionary *temp in array) {
                    EveryDayRecordModel *newsM = [[EveryDayRecordModel alloc]initWithDic:temp];
                    [self.dataList addObject:newsM];
                }
            }
            [baseTableView reloadData];
            
//            refreshTailView.frame = CGRectMake(0, baseTableView.contentSize.height, refreshTailView.frame.size.width, refreshTailView.frame.size.height);
            
            if(self.dataList.count==0) {
                //[self showEmpty];
            }
            
            [self doneLoadingTableViewData];
        }
        else if(questType == ACTIVEANDSCANNUM)
        {
            tableHeaderView.totalActiveLabel.text = [dataDic objectForKey:@"activateAmount"];
            tableHeaderView.totalScanLabel.text = [dataDic objectForKey:@"clickAmount"];
            refreshTailView.frame = CGRectMake(0, baseTableView.contentSize.height, refreshTailView.frame.size.width, refreshTailView.frame.size.height);
            [self doneLoadingTableViewData];
        }
       
    } failure:^(NSString *code, NSString *error) {
        [Utility hideMBProgress:self.view];
        [self doneLoadingTableViewData];
        if (_currentPage==0&&[error isEqualToString:@"没有符合条件的"]) {
            [self.dataList removeAllObjects];
            [self.baseTableView reloadData];
            //[self showEmpty];
        }
        else if(self.dataList.count==0) {
           // [self showEmpty];
        }
    }];
}
-(void)getActiveAndScanNumRequest
{
    
    [Utility showMBProgress:self.view message:@"获取数据"];
    NSMutableDictionary *param = [NSMutableDictionary dictionary];
    [param setPObject:@"10010" forKey:@"appKey"];
    [param setObject:[HWUserLogin currentUserLogin].userId forKey:@"userId"];
    //TuiGuangYuan_APP_KEY
     HWHTTPRequestOperationManager *manager = [HWHTTPRequestOperationManager gameManager];
    [manager POST:kGetScanAndActiveNum parameters:param queue:nil success:^(id responseObject){
        [Utility hideMBProgress:self.view];
        NSDictionary *dataDic = [responseObject dictionaryObjectForKey:@"data"];
        tableHeaderView.totalActiveLabel.text = [dataDic numberObjectForKey:@"active"];
        tableHeaderView.totalScanLabel.text = [dataDic numberObjectForKey:@"scan"];
        tableHeaderView.totalRegisterLabel.text = [dataDic numberObjectForKey:@"register"];
        
        
//        [attributeString setAttributes:@{NSForegroundColorAttributeName : THEME_COLOR_ORANGE,   NSFontAttributeName : [UIFont fontWithName:FONTNAME size:17.0f] , } range:NSMakeRange(l, r)];
        
        
        NSMutableAttributedString *attString = [[NSMutableAttributedString alloc]initWithString:[NSString stringWithFormat:@"推广总佣金：￥%@",[dataDic stringObjectForKey:@"commission"]] attributes:nil];
        [attString setAttributes:@{NSForegroundColorAttributeName : THEME_COLOR_SMOKE} range:NSMakeRange(0, attString.length)];
        [attString setAttributes:@{NSForegroundColorAttributeName : UIColorFromRGB(0xff6c00)} range:NSMakeRange(6, attString.length - 6)];
        tableHeaderView.DetailLabel.attributedText = attString;
        
        [self getExtendRecord];
    } failure:^(NSString *code, NSString *error)
    {
        [Utility hideMBProgress:self.view];
        [self getExtendRecord];
    }];
}
- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
