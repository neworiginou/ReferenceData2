//
//  HWGameSpreadTableView.m
//  KaoLa
//
//  Created by WeiYuanlin on 15/1/13.
//  Copyright (c) 2015年 WeiYuanlin. All rights reserved.
//
// 
//  功能描述：福利社首页 View
//
//  修改记录：
//      姓名          日期                      修改内容
//      吴晓红        2015-1-13                 创建文件
//      魏远林        2015-01-20                修改表头图片手势事件

#import "HWGameSpreadTableView.h"

@implementation HWGameSpreadTableView

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self)
    {
        [self queryListDataForBackstage];
        
        [self queryListDataForBannerPic];
        
        [self queryListData];
        
    }
    return self;
}

/**
 *	@brief	加载图片墙
 *
 *	@return	N/A
 */
- (void)initTableViewHeaderView
{
    UIView *tableViewHeaderView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, kScreenWidth, 177.5f * kScreenRate)];
    tableViewHeaderView.backgroundColor = [UIColor clearColor];
    self.baseTable.tableHeaderView = tableViewHeaderView;
    
    UIScrollView *scroll = [[UIScrollView alloc] initWithFrame:tableViewHeaderView.bounds];
    [scroll setContentSize:CGSizeMake(CGRectGetWidth(scroll.frame) * self.baseListArr.count, 0)];
    [tableViewHeaderView addSubview:scroll];
    
    for (int i = 0; i < self.baseListArr.count; i ++)
    {
        HWGameSpreadPicModel *currentModel = (HWGameSpreadPicModel *)[self.baseListArr pObjectAtIndex:i];
        WXImageView *headImg = [[WXImageView alloc]initWithFrame:CGRectMake(i * kScreenWidth, 0, kScreenWidth, self.baseTable.tableHeaderView.frame.size.height * kScreenRate)];
        headImg.backgroundColor = [UIColor clearColor];
        
        headImg.touchBlock = ^{
            NSLog(@"点击图片");
            if (self.delegate && [self.delegate respondsToSelector:@selector(tableHeaderImageClickDelegate:)])
            {
                [self.delegate tableHeaderImageClickDelegate:currentModel];
            }
            
        };
        __weak UIImageView *imageView = headImg;
        [imageView setImageWithURL:[NSURL URLWithString:[Utility imageDownloadWithMongoDbKey:currentModel.bannerMongodbKey]] placeholderImage:[UIImage imageNamed:IMAGE_PLACE] completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType) {
            if (error == nil)
            {
                headImg.image = image;
            }
            else
            {
                headImg.image = [UIImage imageNamed:IMAGE_BREAK_CUBE];
            }
        }];
        
        UIView *onLine = [[UIView alloc]initWithFrame:CGRectMake(0, 0, kScreenWidth, 0.5f)];
        onLine.backgroundColor = THEME_COLOR_LINE;
        [imageView addSubview:onLine];
        
        UIView *downLine = [[UIView alloc]initWithFrame:CGRectMake(0, 177.5f * kScreenRate - 0.5f, kScreenWidth, 0.5f)];
        downLine.backgroundColor = THEME_COLOR_LINE;
        [imageView addSubview:downLine];
        
        [scroll addSubview:headImg];
    }
    
    UIView * line =[[UIView alloc]initWithFrame:CGRectMake(0, CGRectGetHeight(tableViewHeaderView.frame) - 0.5, kScreenWidth, 0.5)];
    line.backgroundColor = THEME_COLOR_LINE;
    [tableViewHeaderView addSubview:line];
}

//列表数据请求
- (void)queryListData
{
    [Utility showMBProgress:self message:@"加载中..."];
    
    HWUserLogin *user = [HWUserLogin currentUserLogin];
    
    NSMutableDictionary *param = [[NSMutableDictionary alloc]init];
    [param setPObject:user.userId forKey:@"userId"];
    [param setPObject:@(kPageCount) forKey:@"size"];
    [param setPObject:@(self.currentPage) forKey:@"page"];
    HWHTTPRequestOperationManager *manage = [HWHTTPRequestOperationManager cutManager];
    
    [manage POST:KGameSpreadVCList parameters:param queue:nil success:^(id responseObject)
     {
         [Utility hideMBProgress:self];
         
         NSLog(@"%@", responseObject);
         
         NSDictionary *dataDic = [responseObject dictionaryObjectForKey:@"data"];
         NSDictionary *pageDic = [dataDic dictionaryObjectForKey:@"homePage"];
         NSArray *contents = [pageDic arrayObjectForKey:@"content"];
         NSMutableArray *tmpArr = [NSMutableArray array];
         
         for (NSDictionary *dict in contents) {
             
             HWGameSpreadModel *model = [[HWGameSpreadModel alloc] initWithDictionary:dict];
             [tmpArr addObject:model];
         }
         
         if(tmpArr.count < kPageCount)
         {
             isLastPage = YES;
         }
         else
         {
             isLastPage = NO;
         }
         
         if (self.currentPage == 0)
         {
             self.baseListArr = [NSMutableArray arrayWithArray:tmpArr];
         }
         else
         {
             [self.baseListArr addObjectsFromArray:tmpArr];
         }
         
         [self.baseTable reloadData];
         [self doneLoadingTableViewData];
         
         if (self.baseListArr.count == 0)
         {
             [self showEmpty:@"暂无推广内容" withOffset:180];
         }
         else
         {
             [self hideEmptyView];
         }
         
     }failure:^(NSString *code, NSString *error) {
         
         [Utility hideMBProgress:self];
         [Utility showToastWithMessage:error inView:self];
         [self doneLoadingTableViewData];
     }];
}

//表头图片数据请求
- (void)queryListDataForBannerPic
{
    HWHTTPRequestOperationManager *manage = [HWHTTPRequestOperationManager manager];
    NSMutableDictionary *dict = [[NSMutableDictionary alloc] init];
    [manage POST:KGameSpreadVCPic parameters:dict queue:nil success:^(id responseObject)
     {
         [Utility hideMBProgress:self];
         
         NSLog(@"%@", responseObject);
         NSDictionary *dataDic = [responseObject dictionaryObjectForKey:@"data"];
         NSArray *picArr = [dataDic arrayObjectForKey:@"bannerList"];
         NSMutableArray *tmpArr = [NSMutableArray array];
         for (int i = 0; i < picArr.count; i++)
         {
             NSDictionary *dict = [picArr pObjectAtIndex:i];
             HWGameSpreadPicModel *model = [[HWGameSpreadPicModel alloc]initWithDic:dict];
             [tmpArr addObject:model];
         }
         
         self.baseListArr = [NSMutableArray arrayWithArray:tmpArr];
         if (tmpArr.count == 0)
         {
             return ;
         }
         else
         {
             [self initTableViewHeaderView];
         }
         
     } failure:^(NSString *code, NSString *error) {
         
         [Utility hideMBProgress:self];
         NSLog(@"error %@",error);
     }];
    
}

/**
 *	@brief	后台添加用户到游戏推广相关的数据库中
 *
 *	@return	后台设定接口
 */
- (void)queryListDataForBackstage {
    
    /*游戏推广首页接口之前：起到后台 添加用户到游戏推广相关的数据库中 的作用
     popularizeUserId=12&popularizeMobile=15112345678&popularizeName=用户昵称&uuid=retret4545334r34*/
    
    NSMutableDictionary *param = [NSMutableDictionary dictionary];
    
    HWHTTPRequestOperationManager *manager = [HWHTTPRequestOperationManager manager];
    [param setPObject:[HWUserLogin currentUserLogin].userId forKey:@"popularizeUserId"];
    [param setPObject:[HWUserLogin currentUserLogin].telephoneNum forKey:@"popularizeMobile"];
    [param setPObject:[HWUserLogin currentUserLogin].nickname forKey:@"popularizeName"];
    [param setPObject:[HWUserLogin currentUserLogin].key forKey:@"uuid"];
    
    [manager POST:KGameSpreadVC parameters:param queue:nil success:^(id responseObject) {
        
        [Utility hideMBProgress:self];
        NSLog(@"%@",responseObject);
        
    } failure:^(NSString *code, NSString *error) {
        
        [Utility hideMBProgress:self];
        [Utility showToastWithMessage:error inView:self];
    }];
}

#pragma mark - UITableView Delegate
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.baseListArr.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *cellIdentify = @"cell";
    HWGameSpreadTableViewCell *cell = [[HWGameSpreadTableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdentify];
    if (cell == nil)
    {
        cell = [tableView dequeueReusableCellWithIdentifier:cellIdentify forIndexPath:indexPath];
    }
    [cell setGameSpreadInfo:self.baseListArr[indexPath.row]];
    cell.delegate = self;
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return [HWGameSpreadTableViewCell getCellHeight];
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (self.delegate && [self.delegate respondsToSelector:@selector(cellClickDelegate:)]) {
        
        [self.delegate cellClickDelegate:self.baseListArr[indexPath.row]];
    }
}

- (void)spreadBtnIsClicked:(HWGameSpreadModel *)spreadModel
{
    if (self.delegate && [self.delegate respondsToSelector:@selector(spreadBtnClickDelegate:)]) {
        
        [self.delegate spreadBtnClickDelegate:spreadModel];
    }
}


@end

