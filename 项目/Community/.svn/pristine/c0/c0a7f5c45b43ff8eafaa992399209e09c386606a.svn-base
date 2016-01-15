//
//  HWClickZanRefreshView.m
//  Community
//
//  Created by hw500029 on 15/1/20.
//  Copyright (c) 2015年 caijingpeng. All rights reserved.
//  功能描述:点赞的人列表
//      姓名         日期               修改内容
//     马一平     2015-01-20           创建文件
//      李中强     2015-01-20          修改cellForRow里数组用错
//      李中强     2015-01-21          修改btn的image加载方式
//     马一平     2015-01-22           修改tableView数据源的存取方法
//     马一平     2015－01-23          self.basetable添加headview

#import "HWClickZanRefreshView.h"
#import "HWClickZanConsumerModel.h"

#define PageSize 6

@implementation HWClickZanRefreshView

- (id)initWithFrame:(CGRect)frame andTopicId:(NSString *)topicId
{
    self = [super initWithFrame:frame];
    if (self) {
        
        [self.baseListArr removeAllObjects];
        _topicId = topicId;
        _isLast = YES;//是否是最后一页数据
        _isFirstRequest = YES;
        [self.baseTable.endFooterView removeFromSuperview];
        [self initialView];
    }
    return self;
}

- (void)initialView
{
    self.baseTable.frame = CGRectMake(0, 0,kScreenWidth, self.bounds.size.height);
    self.baseTable.separatorStyle = UITableViewCellSeparatorStyleNone;
    
    UIView *tbHead = [[UIView alloc]initWithFrame:CGRectMake(0, 0, kScreenWidth, 20 * kScreenRate)];
    tbHead.backgroundColor = BACKGROUND_COLOR;
    self.baseTable.tableHeaderView = tbHead;
    
    [self queryListData];
}

- (void)queryListData
{
    isLastPage = YES;//屏蔽baserefreshView下拉刷新
    
    //如参：topicId，key，page，size
    [Utility showMBProgress:self message:LOADING_TEXT];
    HWHTTPRequestOperationManager *manager = [HWHTTPRequestOperationManager manager];
    
    NSMutableDictionary *param = [NSMutableDictionary dictionary];
    [param setObject:_topicId forKey:@"topicId"];
    [param setObject:[HWUserLogin currentUserLogin].key forKey:@"key"];
    [param setPObject:[NSString stringWithFormat:@"%d",self.currentPage] forKey:@"page"];
    [param setPObject:[NSString stringWithFormat:@"%d",PageSize] forKey:@"size"];
    
    [manager POST:kClickZanPerson parameters:param queue:nil success:^(id responese) {
        [Utility hideMBProgress:self];
        NSLog(@"respones ----------------------- %@",responese);
        
//        NSString *zanCount = [[responese dictionaryObjectForKey:@"data"] stringObjectForKey:@"totalElements"];
//        NSString *navTitle = [NSString stringWithFormat:@"赞过的人(%@)",zanCount];
//        if (zanCount.length == 0 ||[zanCount isEqualToString:@"0"])
//        {
//            navTitle = @"赞过的人";
//        }
//        _changeNavTitleView(navTitle);
        
        NSArray *resposeArr = [[responese dictionaryObjectForKey:@"data"] arrayObjectForKey:@"content"];
        
        NSMutableArray *tempArr = [NSMutableArray array];
        
        for (int i = 0; i < resposeArr.count; i++)
        {
            [tempArr addObject:[[HWClickZanConsumerModel alloc] initWithDic:[resposeArr pObjectAtIndex:i]]];
        }
        
        if (self.currentPage == 0)
        {
            [self.baseListArr removeAllObjects];
            _isFirstRequest = YES;
        }
        else
        {
            _isFirstRequest = NO;
        }
        
        if ([[[responese dictionaryObjectForKey:@"data"] stringObjectForKey:@"lastPage"]isEqualToString:@"1"])
        {
            _isLast = YES;
        }
        else
        {
            _isLast = NO;
        }
        
        self.currentPage ++;
        
        [self.baseListArr addObject:tempArr];
        [self.baseTable reloadData];
        
        if (_isLast)
        {
            [self.baseTable scrollToRowAtIndexPath:[NSIndexPath indexPathForRow:(self.baseListArr.count - 1) inSection:0] atScrollPosition:0 animated:YES];
        }
        else
        {
            [self.baseTable scrollToRowAtIndexPath:[NSIndexPath indexPathForRow:(self.baseListArr.count) inSection:0] atScrollPosition:0 animated:YES];
        }
        
        [self doneLoadingTableViewData];
        
        if (_isFirstRequest)
        {
            [self queryListData];
        }
        
    } failure:^(NSString *code, NSString *error) {
        [Utility hideMBProgress:self];
        [Utility showToastWithMessage:error inView:self];
        [self doneLoadingTableViewData];
        
    }];
}


#pragma mark -- UITableViewDelegate
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return _isLast ? self.baseListArr.count : (self.baseListArr.count + 1);
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 126 / 3 * kScreenRate;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    float eachWidth = (kScreenWidth - 10) / 6;
    //更多按钮的cell
    if (indexPath.row == self.baseListArr.count)
    {
       static NSString *cellID = @"id";
        UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellID];
        if (!cell) {
            cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellID];
        }
        
        //cell背景视图
        UIView *cellBackView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, kScreenWidth,126 / 3 * kScreenRate)];
        cellBackView.backgroundColor = BACKGROUND_COLOR;
        [cell.contentView addSubview:cellBackView];

        UIView *backView = [[UIView alloc]initWithFrame:CGRectMake(5, 0, eachWidth, 42 * kScreenRate)];
        backView.backgroundColor = [UIColor clearColor];
        UIButton * btn = [UIButton buttonWithType:UIButtonTypeCustom];
        [btn setBackgroundImage:[UIImage imageNamed:@"more_icon2"] forState:UIControlStateNormal];
        btn.backgroundColor = [UIColor clearColor];
        btn.layer.cornerRadius = 32 * kScreenRate / 2;
        btn.layer.masksToBounds = YES;
        btn.tag = 1000;
        [btn addTarget:self action:@selector(queryListData) forControlEvents:UIControlEventTouchUpInside];
        btn.frame = CGRectMake((eachWidth - 32 * kScreenRate)/2, 5 * kScreenRate, 32 * kScreenRate, 32 * kScreenRate);
        [cell.contentView addSubview:backView];
        [backView addSubview:btn];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        return cell;
    }
    
    static NSString * cellid = @"ID";
    UITableViewCell *cell = [tableView dequeueReusableHeaderFooterViewWithIdentifier:cellid];
    if (!cell) {
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellid];
    }
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    
    //cell背景视图
    UIView *cellBackView2 = [[UIView alloc]initWithFrame:CGRectMake(0, 0, kScreenWidth,126 / 3 * kScreenRate)];
    cellBackView2.backgroundColor = BACKGROUND_COLOR;
    [cell.contentView addSubview:cellBackView2];

    NSArray * personArr = [self.baseListArr pObjectAtIndex:indexPath.row];
    
    for (int i = 0; i < personArr.count; i++)
    {
        UIView *backView = [[UIView alloc]initWithFrame:CGRectMake(5 + i%6 * eachWidth, i/6 * 42 * kScreenRate, eachWidth, 42 * kScreenRate)];
        backView.backgroundColor = [UIColor clearColor];
        UIButton * btn = [UIButton buttonWithType:UIButtonTypeCustom];
        
        btn.layer.cornerRadius = 16 * kScreenRate;
        btn.layer.masksToBounds = YES;
        btn.tag = indexPath.row*18 +i+100;
        btn.frame = CGRectMake((eachWidth - 32 * kScreenRate)/2, 5 * kScreenRate, 32 * kScreenRate, 32 * kScreenRate);
        
        HWClickZanConsumerModel *model = [personArr pObjectAtIndex:i];

        __block UIButton *blockButton = btn;
        NSURL *url;
        if (model.headUrl.length > 0)
        {
            url = [NSURL URLWithString:[Utility imageDownloadUrl:model.headUrl]];
        }
        else if (model.mongodbKey.length > 0)
        {
            url = [NSURL URLWithString:[Utility imageDownloadWithMongoDbKey:model.mongodbKey]];
        }
        else
        {
            url = [NSURL URLWithString:@""];
        }
        [btn setImageWithURL:url forState:UIControlStateNormal placeholderImage:[UIImage imageNamed:@"head_placeholder"] completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType) {
            if (!error)
                [blockButton setImage:image forState:UIControlStateNormal];
            else
                [blockButton setImage:[UIImage imageNamed:@"head_placeholder"] forState:UIControlStateNormal];
        }];
        
        [btn addTarget:self action:@selector(btnClick:) forControlEvents:UIControlEventTouchUpInside];
        
        [cell.contentView addSubview:backView];
        [backView addSubview:btn];
    }
    return cell;
}

#pragma mark -- 点赞用户头像点击
-(void)btnClick:(UIButton *)btn
{
    NSLog(@"btn.tag ======================= %ld",(long)btn.tag);
}

@end
