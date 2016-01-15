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
//      聂迪          2015-1-15                 接口数据连接
//      魏远林        2015-01-20                修改表头图片手势事件

#import "HWGameSpreadTableView.h"

@implementation HWGameSpreadTableView

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self)
    {
        self.baseTable.showsVerticalScrollIndicator = NO;
        
        [self queryListDataForBackstage];
        
        
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
    UIView *tableViewHeaderView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, kScreenWidth, 165 * kScreenRate)];
    tableViewHeaderView.backgroundColor = [UIColor clearColor];
    self.baseTable.tableHeaderView = tableViewHeaderView;
    
    UIScrollView *scroll = [[UIScrollView alloc] initWithFrame:tableViewHeaderView.bounds];
    [scroll setContentSize:CGSizeMake(CGRectGetWidth(scroll.frame) * self.picModelListArr.count, 0)];
    [tableViewHeaderView addSubview:scroll];
    
    for (int i = 0; i < self.picModelListArr.count; i ++)
    {
        HWGameSpreadPicModel *currentModel = (HWGameSpreadPicModel *)[self.picModelListArr pObjectAtIndex:i];
        WXImageView *headImg = [[WXImageView alloc]initWithFrame:CGRectMake(i * kScreenWidth, 0, 320.0f * kScreenRate, 165.0f * kScreenRate)];
        headImg.backgroundColor = IMAGE_DEFAULT_COLOR;
        
        headImg.touchBlock = ^{
            NSLog(@"点击图片");
            [MobClick event:@"click_gamebanner"];   //maidian_1.2.1
            if (self.delegate && [self.delegate respondsToSelector:@selector(tableHeaderImageClickDelegate:)])
            {
                [self.delegate tableHeaderImageClickDelegate:currentModel];
//                [self bannerClickStatistical:currentModel];
            }
            
        };
        __weak UIImageView *imageView = headImg;
        [headImg setImageWithURL:[NSURL URLWithString:[Utility imageDownloadWithMongoDbKey:currentModel.bannerMongodbKey]] placeholderImage:[UIImage imageNamed:IMAGE_PLACE] completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType) {
            if (error == nil)
            {
                imageView.image = image;
            }
            else
            {
                imageView.image = [UIImage imageNamed:IMAGE_BREAK_CUBE];
            }
        }];
        
        UIView *onLine = [[UIView alloc]initWithFrame:CGRectMake(0, 0, kScreenWidth, 0.5f)];
        onLine.backgroundColor = THEME_COLOR_LINE;
        [imageView addSubview:onLine];
        
        UIView *downLine = [[UIView alloc]initWithFrame:CGRectMake(0, 165.0f * kScreenRate - 0.5f, kScreenWidth, 0.5f)];
        downLine.backgroundColor = THEME_COLOR_LINE;
        [imageView addSubview:downLine];
        
        [scroll addSubview:headImg];
    }
    
    UIView * line =[[UIView alloc]initWithFrame:CGRectMake(0, CGRectGetHeight(tableViewHeaderView.frame) - 0.5f, kScreenWidth, 0.5f)];
    line.backgroundColor = THEME_COLOR_LINE;
    [tableViewHeaderView addSubview:line];
}

//banner点击统计 不确定此处是否统计 故已注释调用
- (void)bannerClickStatistical:(HWGameSpreadPicModel *)model
{
    NSMutableDictionary *param = [[NSMutableDictionary alloc]init];
    [param setPObject:[HWUserLogin currentUserLogin].key forKey:@"key"];
    [param setPObject:[HWUserLogin currentUserLogin].userId forKey:@"userId"];
    [param setPObject:model.gameId forKey:@"activityId"];
    
    HWHTTPRequestOperationManager *manager = [HWHTTPRequestOperationManager manager];
    [manager POST:KBannerClickStatistical parameters:param queue:nil success:^(id responese)
     {
         NSLog(@"banner统计 responese ========================= %@",responese);
         
     } failure:^(NSString *code, NSString *error) {
         NSLog(@"banner统计错误 %@", error);
     }];
}

//列表数据请求
- (void)queryListData
{
    /*接口名称：游戏推广首页--游戏列表
     接口URL：/hw-game-app-web/game/queryGameGeneralizeHomePage.do
     入参：
     userId 推广员id （必输）
     page 分页，第page页，第一页从0开始
     size 每页数据条数
     出参：
     {"status":"1","data":{"bannerList":null,"homePage":{"content":[
     {"gameId":1,"gameName":"地狱边境","iconMongodbKey":"3423424sdfsfgfdg","typeDescription":"描述1","detailDescription":"详细描述1","commissionList":null,"appNumber":"10010","channelNumber":"KALA","shortUrl":null,"shareCount":3,"commissionCount":29.2125}
     ],"size":10,"number":0,"firstPage":true,"totalPages":1,"lastPage":true,"numberOfElements":4,"totalElements":4,"sort":null}},"detail":"请求数据成功!","key":null}
     */
    
    [Utility showMBProgress:self message:@"加载中..."];
    
    HWUserLogin *user = [HWUserLogin currentUserLogin];
    
    NSMutableDictionary *param = [[NSMutableDictionary alloc]init];
    [param setPObject:user.userId forKey:@"userId"];
    [param setPObject:@(kPageCount) forKey:@"size"];
    [param setPObject:@(self.currentPage) forKey:@"page"];
    [param setPObject:@"0" forKey:@"gameType"];      //gameType参数，0：游戏应用；1：考拉社区应用
    
    HWHTTPRequestOperationManager *manage = [HWHTTPRequestOperationManager gameManager];
    
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
         
         if (self.currentPage == 0 && tmpArr.count > 0)     //加载引导页
         {
             if (self.delegate && [self.delegate respondsToSelector:@selector(showGuideViewWhenHaveList)])
             {
                 [self.delegate showGuideViewWhenHaveList];
             }
         }
         
         [self.baseTable reloadData];
         [self doneLoadingTableViewData];
         
         if (self.baseListArr.count == 0)
         {
             if (self.picModelListArr.count == 0)
             {
                 [self showEmptyView:@"暂无推广内容"];
             }
             else
             {
                 [self showEmpty:@"暂无推广内容" withOffset:180];
             }
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
    /*接口名称：游戏推广首页--游戏banner图
     接口URL：/hw-game-app-web/game/queryGameGeneralizeBanner.do
     入参：
     无
     出参：
     {"status":"1","data":{"bannerList":[
     {"gameId":2,"gameName":"秋之回忆3","bannerMongodbKey":"54bd0915d26cf0abc2d9f677"}
     ],"homePage":null},"detail":"请求数据成功!","key":null}
     */
    
    HWHTTPRequestOperationManager *manage = [HWHTTPRequestOperationManager gameManager];
    NSMutableDictionary *dict = [[NSMutableDictionary alloc] init];
    [dict setObject:@"0" forKey:@"gameType"];        //gameType参数，0：游戏应用；1：考拉社区应用
    
    [manage POST:KGameSpreadVCPic parameters:dict queue:nil success:^(id responseObject)
     {
         NSLog(@"%@", responseObject);
         NSDictionary *dataDic = [responseObject dictionaryObjectForKey:@"data"];
         NSArray *picArr = [dataDic arrayObjectForKey:@"bannerList"];
         NSMutableArray *tmpArr = [NSMutableArray array];
         for (int i = 0; i<picArr.count;i ++)
         {
             NSDictionary *dict = [picArr pObjectAtIndex:i];
             HWGameSpreadPicModel *model = [[HWGameSpreadPicModel alloc]initWithDic:dict];
             [tmpArr addObject:model];
         }
         
         self.picModelListArr = [NSMutableArray arrayWithArray:tmpArr];
         if (tmpArr.count == 0)
         {
             return ;
         }
         else
         {
             [self initTableViewHeaderView];
         }
         
         [Utility hideMBProgress:self];
         
     } failure:^(NSString *code, NSString *error) {
         
         NSLog(@"error %@",error);
         [Utility hideMBProgress:self];
     }];
    
}

/**
 *	@brief	后台添加用户到游戏推广相关的数据库中
 *
 *	@return	后台设定接口
 */
- (void)queryListDataForBackstage {
    
    /*游戏推广首页接口之前：起到后台 添加用户到游戏推广相关的数据库中 的作用
     popularizeUserId=12&popularizeMobile=15112345678&popularizeName=用户昵称&uuid=retret4545334r34
     出参：
     布尔类型：true/false    经验证不是－by niedi
     */
    
    NSMutableDictionary *param = [NSMutableDictionary dictionary];
    
    HWHTTPRequestOperationManager *manager = [HWHTTPRequestOperationManager gameManager];
    [param setPObject:[HWUserLogin currentUserLogin].userId forKey:@"popularizeUserId"];
    [param setPObject:[HWUserLogin currentUserLogin].telephoneNum forKey:@"popularizeMobile"];
    [param setPObject:[HWUserLogin currentUserLogin].nickname forKey:@"popularizeName"];
    [param setPObject:[HWUserLogin currentUserLogin].key forKey:@"uuid"];
    
    [manager POST:KGameSpreadVC parameters:param queue:nil success:^(id responseObject) {
        
        NSLog(@"%@",responseObject);
        
        [self queryListDataForBannerPic];
        
        [self queryListData];
        
    } failure:^(NSString *code, NSString *error) {
        
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
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    [MobClick event:@"click_gamelist"]; //maidian_1.2.1 by niedi
    
    if (self.delegate && [self.delegate respondsToSelector:@selector(cellClickDelegate:)])
    {
        [self.delegate cellClickDelegate:self.baseListArr[indexPath.row]];
    }
}

- (void)spreadBtnIsClicked:(HWGameSpreadModel *)spreadModel
{
    [MobClick event:@"click_listspreadgame"]; //maidian_1.2.1
    
    if ([HWUserLogin verifyBindMobileWithPopVC:(UIViewController *)self.delegate showAlert:YES])
    {
        if (self.delegate && [self.delegate respondsToSelector:@selector(spreadBtnClickDelegate:)])
        {
            [self.delegate spreadBtnClickDelegate:spreadModel];
        }
        
    }
}


@end

