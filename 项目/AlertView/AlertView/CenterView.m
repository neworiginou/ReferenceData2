//
//  CenterView.m
//  AlertView
//
//  Created by lizhongqiang on 15/7/7.
//  Copyright (c) 2015年 lqq. All rights reserved.
//

#import "CenterView.h"
#import "HeadView.h"
#import "FootView.h"
#import "CustomTableViewCell.h"
#import "CellHeadView.h"
#import "NumberTableViewCell.h"

#define kSpaceX (27/2.f)

#define kFootHeight (191/2.f)

#define kHeadHeight (101/2.f)

@interface CenterView ()<UITableViewDelegate,UITableViewDataSource>

@property (nonatomic, strong)HeadView *headView;

@property (nonatomic, strong)CellHeadView *cellHeadView;

@property (nonatomic, strong)FootView *footView;

@property (nonatomic, strong)UITableView *tableView;

@property (nonatomic, strong)NSArray *dataArray;

@property (nonatomic, strong)NSArray *loadDataArray;

@property (nonatomic, strong)NSDictionary *infoDic;


@end

@implementation CenterView

- (instancetype)initWithFrame:(CGRect)frame
{
    if(self = [super initWithFrame:frame])
    {
        
        self.headView = [[HeadView alloc]initWithFrame:CGRectMake(0, 0, frame.size.width, kHeadHeight)];
        
        self.headView.backgroundColor = [UIColor clearColor];
        
        self.headView.spaceX = kSpaceX;
        
        __unsafe_unretained CenterView *weak = self;
        
        self.headView.cancelAction =^(void)
        {
            if(weak.cancelAction)
            {
                weak.cancelAction();
            }
        };
        
        [self addSubview:self.headView];
        
//-----------------
        
        self.footView = [[FootView alloc]initWithFrame:CGRectMake(0, frame.size.height - kFootHeight, frame.size.width, kFootHeight)];
        
        self.footView.backgroundColor = [UIColor clearColor];
        
        self.footView.timeLabel.text = @"";
        
        self.footView.spaceX = kSpaceX;
        
        [self.footView setNeedsDisplay];
        
        [self addSubview:self.footView];
//-------------------
        [self initTableView];
        
        [self initDataArray];
    }
    return self;
}
- (void)setGetTime:(NSString *)getTime
{
    _getTime = getTime;
    
    self.footView.timeLabel.text = getTime;
}
- (void)initTableView
{
    _tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, kHeadHeight, self.frame.size.width, self.frame.size.height - kHeadHeight - kFootHeight) style:UITableViewStylePlain];
    
    _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    
    _tableView.backgroundColor = [UIColor clearColor];
    
    _tableView.delegate = self;
    
    
    _tableView.dataSource = self;
    
    [self addSubview:_tableView];
}
- (void)initDataArray
{
    _dataArray = @[@"收 据 编 号：",@"项 目 名 称：",@"收 款 姓 名：",@"收 款 内 容：",@"金 额 合 计："];
    
#if 0
    _loadDataArray = @[@{@"number":@"2013083828",@"money":@"200000.1",@"time":@"2014/13/12  12:46"},@{@"number":@"2013083828",@"money":@"8.91",@"time":@"2014/13/12  12:46"}];
    
    _infoDic = @{@"number":@"201412120012",@"name":@"中海珊瑚壹号",@"getName":@"张三",@"telephone":@"13811112356",@"content":@"服务费",@"money":@"23000000.1"};

#endif
}
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 2;
    
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if(section == 0)
    {
        return _dataArray.count;
    }
    if(section == 1)
    {
        return _numberArr.count;
    }
    return 0;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if(indexPath.section == 0)
    {
        static NSString *cellId = @"cellId";
        
        CustomTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellId];
        
        if(cell == nil)
        {
            cell = [[CustomTableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellId];
        }
        
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        
        cell.titleLabel.text = _dataArray[indexPath.row];

        switch (indexPath.row) {
            case 0:
                cell.descLabel.text = _tipNumber;
                
                cell.descLabel.textColor = [UIColor blackColor];
                
                break;
            case 1:
                cell.descLabel.text = _projectName;
                
                cell.descLabel.textColor = [UIColor blackColor];
                
                break;
            case 2:
                
            {
                cell.descLabel.text = [self returnFromString1:_perpoleName telephone:_telephone];
                
                cell.descLabel.textColor = [UIColor blackColor];
            }
               
                
                break;
            case 3:
                cell.descLabel.text = _context;
                
                cell.descLabel.textColor = [UIColor blackColor];
                
                break;
            case 4:
            {
                NSString *string = _money;
                
                NSNumberFormatter *formatter = [[NSNumberFormatter alloc]init];
                
                formatter.numberStyle = kCFNumberFormatterRoundFloor;
                
                string = [formatter stringFromNumber:[NSNumber numberWithDouble:string.doubleValue]];
                
                cell.descLabel.textColor = [UIColor redColor];
                
                NSString *sub = [NSString stringWithFormat:@"￥%@",string];
                
                cell.descLabel.text = sub;
            }
                break;
    
            default:
                break;
        }
        cell.spaceX = kSpaceX;
        
        return cell;
    }
    else
    {
        static NSString *numberCellId = @"numberCellId";
        
        NumberTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:numberCellId];
        
        if(cell == nil)
        {
            cell = [[NumberTableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:numberCellId];
        }
        
        NSDictionary *dic = _numberArr[indexPath.row];
        
        cell.numberLabel.text = dic[@"number"];
        {
            NSString *string = dic[@"money"];
            
            NSNumberFormatter *formatter = [[NSNumberFormatter alloc]init];
            
//            [formatter setGroupingSeparator:@","];
//            [formatter setGroupingSize:3];
//            [formatter setUsesGroupingSeparator:YES];
            
            formatter.numberStyle = kCFNumberFormatterRoundFloor;
            
            string = [formatter stringFromNumber:[NSNumber numberWithDouble:string.doubleValue]];
            
            
            
            
            
            
            cell.moneyLabel.text = string;
        }
        
        
        cell.timeLabel.text = dic[@"time"];
        
        cell.spaceX = kSpaceX;
        
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        
        return cell;
    }
    
}
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    if(section == 0)
    {
        return 0;
    }
    return 13.9*2+57/2.f;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if(indexPath.section == 0)
    {
        return 30;
    }
    else
    {
        return 21;
    }
}
- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    if(section == 1)
    {
        CellHeadView *view = [[CellHeadView alloc]init];
        
        view.backgroundColor = [UIColor clearColor];
        
        view.centerView = self;
        
        view.spaceX = kSpaceX;
        
        return view;
    }
    
    return nil;
}
- (NSString *)returnFromString1:(NSString*)str1 telephone:(NSString *)str2
{
    NSString *str = [str2 stringByReplacingCharactersInRange:NSMakeRange(3, 4) withString:@"****"];
    
    if(str1 == NULL)
    {
        return @"";
    }
    
    return [NSString stringWithFormat:@"%@   %@",str1,str];
}
@end
