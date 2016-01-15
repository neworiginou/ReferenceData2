//
//  RatingVC.m
//  PUClient
//
//  Created by RRLhy on 15/8/11.
//  Copyright (c) 2015年 RRLhy. All rights reserved.
//

#import "RatingVC.h"
#import "SDCycleScrollView.h"
#import "InformationCell.h"
#import "ReviewApi.h"
#import "ReviewListModel.h"
#import "NewTextDetailVC.h"
#import "DateNextVC.h"

@interface RatingVC ()<UITableViewDelegate,UITableViewDataSource>
{
    NSInteger currentPage;
    BOOL isRefreshing;
    UIImageView * topImage;
}
@property (nonatomic,strong)UITableView * ratingTableView;

@property (nonatomic,strong)NSMutableArray * sourceArray;

@end

@implementation RatingVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.navImage.hidden = YES;
    
    [self showTopImage];
    
    [self requestData];
    
    __weak RatingVC * weakself = self;
    
    self.ratingTableView.header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
        isRefreshing = YES;
        [weakself requestData];
    }];
    
    self.ratingTableView.footer = [MJRefreshBackStateFooter footerWithRefreshingBlock:^{
        isRefreshing = NO;
        [weakself requestData];
    }];

}

- (void)showTopImage
{
    UITapGestureRecognizer * gestrure = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(topAction)];
    topImage = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, Main_Screen_Width, 160)];
    [topImage sd_setImageWithURL:URL(@"http://img.tvmao.com/stills/drama/48/367/b/600x343_1.jpg") placeholderImage:nil];
    [topImage addGestureRecognizer:gestrure];
    topImage.userInteractionEnabled = YES;
    self.ratingTableView.tableHeaderView = topImage;
}

- (NSMutableArray*)sourceArray
{
    if (!_sourceArray) {
        _sourceArray = [[NSMutableArray alloc]init];
    }
    return _sourceArray;
}

- (void)requestData
{
    __weak RatingVC * weakself = self;
    NSString * page = [NSString stringWithFormat:@"%ld",(long)currentPage];
    ReviewApi * api = [[ReviewApi alloc]initWithType:@"rating" page:page];
    [api startWithCompletionBlockWithSuccess:^(YTKBaseRequest *request) {
        
        NSLog(@"收视率 模块 列表%@",request.responseJSONObject);
        [_ratingTableView.header endRefreshing];
        [_ratingTableView.footer endRefreshing];
        NSDictionary * dic = request.responseJSONObject;
        if (dic) {
            JsonModel * json = [JsonModel objectWithKeyValues:dic];
            if (json.code == SUCCESSCODE) {
                
                if (isRefreshing) {
                    [weakself.sourceArray removeAllObjects];
                    isRefreshing = NO;
                }
                
                ReviewListModel * list = [ReviewListModel objectWithKeyValues:json.data];
                [weakself.sourceArray addObjectsFromArray:list.results];
                [weakself.ratingTableView reloadData];
                
            }else {
                
            }
        }
    } failure:^(YTKBaseRequest *request) {
        [_ratingTableView.header endRefreshing];
        [_ratingTableView.footer endRefreshing];
    }];
}


- (UITableView *)ratingTableView
{
    if (!_ratingTableView) {
        _ratingTableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, Main_Screen_Width, Main_Screen_Height - 64 - 30 - 49) style:UITableViewStylePlain];
        _ratingTableView.delegate = self;
        _ratingTableView.dataSource = self;
        _ratingTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        [self.view addSubview:_ratingTableView];
    }
    return _ratingTableView;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.sourceArray.count;
}

#pragma mark 每一行怎样显示cell
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    InformationCell * cell = [tableView dequeueReusableCellWithIdentifier:[InformationCell cellID]];
    if (cell == nil) {
        // 如果池中没取到,则重新生成一个girlCell,xib文件中指定了重用cellID
        cell = [InformationCell informationCellAtIndex:0];
    }
 
    cell = [cell cellWithRating:self.sourceArray[indexPath.row]];
    
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 100;
    
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    ReviewModel * model = self.sourceArray[indexPath.row];
    UIStoryboard * storyboard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
    NewTextDetailVC * detail = [storyboard instantiateViewControllerWithIdentifier:@"newDetailVC"];
    detail.reviewModel = model;
    detail.type = InfoTypeRating;
    [self.navigationController pushViewController:detail animated:YES];
}

- (void)topAction
{
    UIStoryboard * storyboard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
    DateNextVC * dateNext = [storyboard instantiateViewControllerWithIdentifier:@"dateNextVC"];
    [self.navigationController pushViewController:dateNext animated:YES];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
