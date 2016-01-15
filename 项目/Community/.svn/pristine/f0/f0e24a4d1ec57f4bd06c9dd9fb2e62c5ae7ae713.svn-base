//
//  HWGameNameTableView.m
//  Community
//
//  Created by WeiYuanlin on 15/1/16.
//  Copyright (c) 2015年 caijingpeng. All rights reserved.
//  功能描述：游戏名称、个人全部游戏推广页tableview
//  修改记录
//      李中强 2015-01-17 添加头注释 相关人员补齐注释
//      魏远林 2015-01-16 创建文件
//      魏远林 2015-01-19 规范代码，接口调试

#import "HWGameNameTableView.h"

#define ShareContent @"这些游戏都很好玩，选一个体验一下吧"

@implementation HWGameNameTableView
{
    HWGameAllNameModel *currentModel;
    UILabel *_footerLabel;
    UIView *_footerView;
}
@synthesize presentController;
@synthesize userImg;
@synthesize shareView;

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self)
    {
        [self setViewAttributeValue];
        self.baseListArr = [NSMutableArray array];
    }
    return self;
}

/**
 *	@brief	给tableview赋值
 *
 *	@return	N/A
 */
- (void)setViewAttributeValue
{
//    self.baseTable.frame = CGRectMake(0, 0, self.frame.size.width - 30.f, self.frame.size.height);
    self.baseTable.backgroundColor = [UIColor clearColor];
    self.baseTable.separatorStyle = UITableViewCellSeparatorStyleNone;
    self.baseTable.delegate = self;
    self.baseTable.dataSource = self;
    self.baseTable.showsVerticalScrollIndicator = NO;
    isLastPage = YES;
    self.isNeedHeadRefresh = NO;
    //table的headerview
    UIView *headerView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, self.frame.size.width, 63.0f)];
    headerView.backgroundColor = THEME_COLOR_TEXTBACKGROUND;
    self.baseTable.tableHeaderView = headerView;
    
    UILabel *headerLabel = [[UILabel alloc]initWithFrame:CGRectMake(15.0f, 16.0f, self.frame.size.width - 90.0f - 30.0f, 47.0f)];
    headerLabel.text = @"个人专属的游戏推广页，下载任意一款游戏均可获得佣金收益";
    headerLabel.numberOfLines = 0;
    headerLabel.lineBreakMode = NSLineBreakByCharWrapping;
    headerLabel.font = [UIFont fontWithName:FONTNAME size:THEME_FONT_SMALL13];
    headerLabel.textColor = THEME_COLOR_GRAY_MIDDLE;
    headerLabel.textAlignment = NSTextAlignmentLeft;
    [headerView addSubview:headerLabel];
    
    UIView *headerLine = [[UIView alloc]initWithFrame:CGRectMake(15.0f, 63.0f - 0.5f, headerView.frame.size.width - 30.0f, 0.5f)];
    headerLine.backgroundColor = THEME_COLOR_LINE;
    [headerView addSubview:headerLine];
    
    UIImageView *headerImageView = [[UIImageView alloc]initWithFrame:CGRectMake(CGRectGetMaxX(headerLabel.frame) + 20.0f, 16.0f, 70.0f, 47.0f)];
    headerImageView.image = [UIImage imageNamed:@"game_kaola2"];
    headerImageView.backgroundColor = [UIColor clearColor];
    [headerView addSubview:headerImageView];
    
    //table的footView
    _footerView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, self.frame.size.width, 28.0f + 430 / 2.0f)];
    _footerView.backgroundColor = THEME_COLOR_TEXTBACKGROUND;
    self.baseTable.tableFooterView = _footerView;
    
    UIView *labelBackView = [[UIView alloc]initWithFrame:CGRectMake(15.0f, 0, self.frame.size.width - 30.0f, 28.0f)];
    labelBackView.backgroundColor = [UIColor whiteColor];
    [_footerView addSubview:labelBackView];
    
    _footerLabel = [[UILabel alloc]init];
    _footerLabel.font = [UIFont fontWithName:FONTNAME size:THEME_FONT_SMALL13];
    _footerLabel.textColor = THEME_COLOR_TEXT;
    _footerLabel.frame = CGRectMake(0, 0, self.frame.size.width - 30.0f, 28.0f);
    _footerLabel.textAlignment = NSTextAlignmentCenter;
    [labelBackView addSubview:_footerLabel];
    
    UIView *leftLine = [[UIView alloc]initWithFrame:CGRectMake(0, 0, 0.5f, 28.0f)];
    leftLine.backgroundColor = THEME_COLOR_LINE;
    [labelBackView addSubview:leftLine];
    
    UIView *rightLine = [[UIView alloc]initWithFrame:CGRectMake(kScreenWidth - 15.0f * 2 - 0.5f, 0, 0.5f, 28.0f)];
    rightLine.backgroundColor = THEME_COLOR_LINE;
    [labelBackView addSubview:rightLine];
    
    UIView *line = [[UIView alloc]initWithFrame:CGRectMake(0, 28.0f - 0.5f, self.frame.size.width - 30.0f, 0.5f)];
    line.backgroundColor = THEME_COLOR_LINE;
    [labelBackView addSubview:line];
    
    [self queryListData];
}

/**
 *	@brief	数据请求
 *
 *	@return	N/A
 */
- (void)queryListData
{
    /*
     接口名称：推广游戏--个人推广页分享
     接口URL：hw-game-app-web/quickmark/queryAllQuickMarkAndUrl.do
     入参：
     popularizeUserId(必填，推广员ID)
     */
    
    [Utility showMBProgress:self message:@"加载中"];
    NSMutableDictionary *param = [NSMutableDictionary dictionary];
    [param setPObject:[HWUserLogin currentUserLogin].userId forKey:@"popularizeUserId"];
    HWHTTPRequestOperationManager *manager = [HWHTTPRequestOperationManager gameManager];
    [manager POST:kOneClickSpread parameters:param queue:nil success:^(id responese) {
        [Utility hideMBProgress:self];
        NSDictionary *dataDic = [responese dictionaryObjectForKey:@"data"];
        //全部游戏分享的url
        NSString *gameShareUrl = [dataDic stringObjectForKey:@"gameShareUrl"];
        NSDictionary *homePageDic = [dataDic dictionaryObjectForKey:@"homePage"];
        NSArray *dataArr = [homePageDic arrayObjectForKey:@"content"];

        for (int i = 0; i < dataArr.count; i ++)
        {
            NSDictionary *dataDic = [dataArr pObjectAtIndex:i];
            HWGameAllNameModel *model = [[HWGameAllNameModel alloc]initWithDictionary:dataDic];
            [self.baseListArr addObject:model];
        }
        if (dataArr.count == 0)
        {
            [self showEmpty:@"暂无可分享游戏" withOffset:180.f];
             self.baseTable.hidden = YES;
        }
        
        [self loadDataForShareView:gameShareUrl];
        
        [self.baseTable reloadData];
        [self doneLoadingTableViewData];
        
        
    } failure:^(NSString *code, NSString *error) {
        [Utility hideMBProgress:self];
        [Utility showToastWithMessage:error inView:self];
        [self showEmpty:@"暂无可分享游戏" withOffset:90.0f];
        self.baseTable.hidden = YES;
        [self doneLoadingTableViewData];
    }];
    
}

- (void)loadDataForShareView:(NSString *)gameShareUrl
{
    //给tablefootview上面的label赋值
    _footerLabel.text = [NSString stringWithFormat:@"包含所有%lu款游戏",(unsigned long)self.baseListArr.count];
    //分享View
    self.userImg = [[UIImageView alloc]init];
    __weak UIImageView *imageView = userImg;
    [userImg setImageWithURL:[NSURL URLWithString:[Utility imageDownloadUrl:[HWUserLogin currentUserLogin].avatar]] placeholderImage:[UIImage imageNamed:IMAGE_PLACE] completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType){
        if (error != nil)
        {
            imageView.image = [UIImage imageNamed:IMAGE_BREAK_CUBE];
        }
        else
        {
            imageView.image = image;
        }
        
        shareView.shareImage = imageView.image;
    }];
    
    [self initShareView:gameShareUrl andImageView:self.userImg];
}

- (void)initShareView:(NSString *)gameShareUrl andImageView:(UIImageView *)imageView
{
    //拼接分享url
    /*
     http://172.16.10.35/kaola/game?popularizeUserId=77
     */
    NSString *titleStr = [NSString stringWithFormat:@"%@的分享游戏列表",[HWUserLogin currentUserLogin].nickname];
    
    NSString *shareStr = [NSString stringWithFormat:@"%@?popularizeUserId=%@",gameShareUrl,[HWUserLogin currentUserLogin].userId];
    shareView = [[HWShareView alloc]initWithShareTitile:titleStr content:ShareContent image:imageView.image shareUrl:shareStr];
    shareView.shareSource = 0;
    shareView.frame = CGRectMake(0, CGRectGetMaxY(_footerLabel.frame), kScreenWidth, 430 / 2.0f);
    shareView.gameId = @"";
    shareView.superView = self;
    shareView.copiesUrl = shareStr;
    shareView.backgroundColor = [UIColor clearColor];
    [shareView showInView:self presentController:self.presentController];
    [_footerView addSubview:shareView];
}

#pragma mark - UITableView Delegate
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return [HWGameNameTableViewCell setCellHeight];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.baseListArr.count;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *cellIdentify = @"cell";
    HWGameNameTableViewCell *cell = [[HWGameNameTableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdentify];
    if (cell == nil)
    {
        cell = [tableView dequeueReusableCellWithIdentifier:cellIdentify forIndexPath:indexPath];
    }
    if (self.baseListArr.count != 0)
    {
        NSLog(@"%d",indexPath.row);
        currentModel = (HWGameAllNameModel *)self.baseListArr[indexPath.row];
        [cell setCellViewFrame:currentModel];
    }
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    if (self.delegate && [self.delegate respondsToSelector:@selector(didSelectedCell:)])
    {
        
        [self.delegate didSelectedCell:[self.baseListArr pObjectAtIndex:indexPath.row]];
    }
}



@end
