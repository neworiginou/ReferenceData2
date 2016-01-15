//
//  InformationVC.m
//  PUClient
//
//  Created by RRLhy on 15/8/11.
//  Copyright (c) 2015年 RRLhy. All rights reserved.
//

#import "InformationVC.h"
#import "NewTextDetailVC.h"
#import "NewTypeImageVC.h"
#import "SDCycleScrollView.h"
#import "InformationCell.h"
#import "NewsRingApi.h"
#import "NewsMainApi.h"
#import "NewRingListModel.h"
#import "NewRingModel.h"
#import "NewsListModel.h"
#import "NewsIntroModel.h"

@interface InformationVC ()<SDCycleScrollViewDelegate,UITableViewDataSource,UITableViewDelegate>
{
    SDCycleScrollView * cycleScrollView2;
    NSInteger currentPage;
    BOOL isRefreshing;
}

@property (nonatomic,strong)UITableView * newsTableView;

@property (nonatomic,strong)NSMutableArray * sourceArray;

@end

@implementation InformationVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.navImage.hidden = YES;

    self.gifImageView.frame = CGRectMake((Main_Screen_Width - 100)/2, ( Main_Screen_Width, Main_Screen_Height - 64 - 30 - 49 - 100)/2, 100, 100);
    [self.gifImageView startAnimating];
    self.reminderLabel.text = REMINDTEXT1;
    
    currentPage = 1;
    
    [self loadTop];
}

#pragma mark 顶部轮播图
- (void)showTopRingView
{
    if (!cycleScrollView2) {
        // 网络加载 --- 创建带标题的图片轮播器
        CGFloat w = self.view.bounds.size.width;
        cycleScrollView2 = [SDCycleScrollView cycleScrollViewWithFrame:CGRectMake(0, 0, w, 160) imageURLsGroup:nil];
        cycleScrollView2.pageControlAliment = SDCycleScrollViewPageContolAlimentRight;
        cycleScrollView2.delegate = self;
        cycleScrollView2.dotColor = [UIColor yellowColor]; // 自定义分页控件小圆标颜色
        cycleScrollView2.placeholderImage = [UIImage imageNamed:@"placeholder"];
        cycleScrollView2.autoScrollTimeInterval = 10;
        [self.view addSubview:cycleScrollView2];
        self.newsTableView.tableHeaderView = cycleScrollView2;
    }
}

#pragma mark 加载顶部
- (void)loadTop
{
    __weak InformationVC * weakself = self;
    NewsRingApi * api = [[NewsRingApi alloc]initWithPage:@"1" rows:@"5"];
    [api startWithCompletionBlockWithSuccess:^(YTKBaseRequest *request) {
        
        NSLog(@"顶部轮播%@",request.responseJSONObject);
        NSDictionary * dic = request.responseJSONObject;
        if (dic) {
            
            JsonModel * josn = [JsonModel objectWithKeyValues:dic];
            if (josn.code == SUCCESSCODE) {
                
                [weakself.gifImageView removeFromSuperview];
                [weakself showTopRingView];
                
                NewRingListModel * model = [NewRingListModel objectWithKeyValues:josn.data];
                NSMutableArray *imagesURL = [NSMutableArray array];
                NSMutableArray *titles = [NSMutableArray array];
                for (NewRingModel * topObj in model.results) {
                    
                    [imagesURL addObject:topObj.imgUrl];
                    [titles addObject:topObj.title];
                }
                cycleScrollView2.imageURLsGroup = imagesURL;
                cycleScrollView2.titlesGroup = titles;
                
                [weakself requestData];
                
            }else{
                
                [weakself.gifImageView stopAnimating];
                [weakself.reminderLabel setText:REMINDTEXT3];
            }
        }
        
        [weakself.gifImageView stopAnimating];
        [weakself.reminderLabel setText:REMINDTEXT3];
        
    } failure:^(YTKBaseRequest *request) {
      
        [weakself.gifImageView stopAnimating];
        [weakself.reminderLabel setText:REMINDTEXT2];
        
    }];
}

- (void)requestData
{
    __weak InformationVC * weakself = self;
    NSString * page = [NSString stringWithFormat:@"%ld",currentPage];
    NewsMainApi * mainApi = [[NewsMainApi alloc]initWithNewsPage:page newRow:@"20"];
    [mainApi startWithCompletionBlockWithSuccess:^(YTKBaseRequest *request) {
        
        NSLog(@"列表%@",request.responseJSONObject);
        [_newsTableView.header endRefreshing];
        [_newsTableView.footer endRefreshing];
        NSDictionary * dic = request.responseJSONObject;
        if (dic) {
            JsonModel * json = [JsonModel objectWithKeyValues:dic];
            if (json.code == SUCCESSCODE) {
                
                if (isRefreshing) {
                    [weakself.sourceArray removeAllObjects];
                    isRefreshing = NO;
                }
                NewsListModel * list =  [NewsListModel objectWithKeyValues:json.data];
                [weakself.sourceArray addObjectsFromArray:list.results];
                [_newsTableView reloadData];
                currentPage = [list.currentPage integerValue] + 1;
                
            }else{
                
                [IanAlert alertError:json.msg length:TIMELENGTH];
            }
            
        }else{
            
            [IanAlert alertError:ERRORMSG1 length:TIMELENGTH];
        }
        
    } failure:^(YTKBaseRequest *request) {
        
        [_newsTableView.header endRefreshing];
        [_newsTableView.footer endRefreshing];
        
        [IanAlert alertError:ERRORMSG2 length:TIMELENGTH];
    }];

}

- (NSMutableArray*)sourceArray
{
    if (!_sourceArray) {
        _sourceArray = [[NSMutableArray alloc]init];
    }
    return _sourceArray;
}

- (UITableView *)newsTableView
{
    if (!_newsTableView) {
        _newsTableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, Main_Screen_Width, Main_Screen_Height - 64 - 30 - 49) style:UITableViewStylePlain];
        _newsTableView.delegate = self;
        _newsTableView.dataSource = self;
        _newsTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        __weak InformationVC * weakself = self;
        self.newsTableView.header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
            currentPage =1 ;
            isRefreshing = YES;
            [weakself requestData];
        }];
        
        self.newsTableView.footer = [MJRefreshAutoStateFooter footerWithRefreshingBlock:^{
            isRefreshing = NO;
            [weakself requestData];
        }];
        [self.view addSubview:_newsTableView];
    }
    return _newsTableView;
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
        cell = [cell cellWithInformation:self.sourceArray[indexPath.row]];
    
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return [InformationCell heightForRowWithInformation:self.sourceArray[indexPath.row]];
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    NewsIntroModel * model = self.sourceArray[indexPath.row];
    UIStoryboard * storyboard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
    if ([model.showType isEqualToString:@"common"]) {
        
        NewTypeImageVC * imageDetail = [storyboard instantiateViewControllerWithIdentifier:@"imageDetail"];
        imageDetail.infoModel = model;
        [self.navigationController pushViewController:imageDetail animated:YES];
        
    }else if([model.showType isEqualToString:@"common2"]){
        
        NewTextDetailVC * detail = [storyboard instantiateViewControllerWithIdentifier:@"newDetailVC"];
        detail.infoModel = model;
        [self.navigationController pushViewController:detail animated:YES];
    }
}

#pragma mark - SDCycleScrollViewDelegate
- (void)cycleScrollView:(SDCycleScrollView *)cycleScrollView didSelectItemAtIndex:(NSInteger)index
{
    NSLog(@"---点击了第%ld张图片", index);
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


#pragma mark - Navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {

}

@end
