//
//  HWServiceCatoryViewController.m
//  Community
//
//  Created by gusheng on 14-9-15.
//  Copyright (c) 2014年 caijingpeng. All rights reserved.
//

#import "HWServiceCatoryViewController.h"
#import "HWServiceCatoryTableViewCell.h"
#import "HWCatoryClass.h"
@interface HWServiceCatoryViewController ()

@end

@implementation HWServiceCatoryViewController
@synthesize serviceCatoryTableView,catoryArry;
- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}
//获取服务类别数据
-(void)getCatoryData
{
    [Utility showMBProgress:self.view message:@"获取服务类别"];
    HWHTTPRequestOperationManager *manager = [HWHTTPRequestOperationManager manager];
    NSMutableDictionary *dict = [NSMutableDictionary dictionary];
    [dict setPObject:[HWUserLogin currentUserLogin].key forKey:@"key"];
//    [dict setPObject:@"200" forKey:@"parentDictId"];
    [manager POST:kGetCatoryData parameters:dict queue:nil success:^(id responseObject){
        
        // 保存key [dict objectForKey:@"key"];
        [Utility hideMBProgress:self.view];
        NSDictionary *dataDic = (NSDictionary *)[responseObject objectForKey:@"data"];
        NSArray *catoryArryTemp = [dataDic objectForKey:@"content"];
        [self createDataSource:catoryArryTemp];
        //用户数据保存本地
    }failure:^(NSString *code, NSString *error) {
        [Utility hideMBProgress:self.view];
        [Utility showToastWithMessage:error inView:self.view];
        NSLog(@"error %@",error);
    }];

}
//创建数据源
-(void)createDataSource:(NSArray *)arry
{
    for (int i = 0; i < [arry count]; i++) {
        NSDictionary *dic = [arry objectAtIndex:i];
        HWCatoryClass *catoryData = [[HWCatoryClass alloc]initWithDic:dic];
        [catoryArry addObject:catoryData];
    }
    [serviceCatoryTableView reloadData];
}
//创建主视图
-(void)createMainHeadView
{
    serviceCatoryTableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, kScreenWidth, CONTENT_HEIGHT)];;
    serviceCatoryTableView.dataSource = self;
    serviceCatoryTableView.delegate = self;
    serviceCatoryTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    serviceCatoryTableView.backgroundColor = [UIColor clearColor];
    [self.view addSubview:serviceCatoryTableView];
}
- (void)viewDidLoad
{
    [super viewDidLoad];
    self.navigationItem.titleView = [Utility navTitleView:@"选择服务类别"];
    self.navigationItem.leftBarButtonItem = [Utility navLeftBackBtn:self action:@selector(backMethod)];
    catoryArry = [[NSMutableArray alloc]init];
    [self createMainHeadView];
    [self getCatoryData];
    
    
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSString *identify = @"serviceCatoryTableView";
    HWServiceCatoryTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identify];
    if (!cell) {
        cell = [[HWServiceCatoryTableViewCell alloc]init];
        
    }
    [cell setSelectionStyle:UITableViewCellSelectionStyleNone];
    cell.backgroundColor = [UIColor clearColor];
    cell.contentView.backgroundColor = [UIColor clearColor];
    [cell addLine:49.5 isHide:NO];
    HWCatoryClass *catoryData = [catoryArry objectAtIndex:[indexPath row]];
    
     __weak UIImageView *blockImgV = cell.avatarImageView;
    [cell.avatarImageView setImageWithURL:catoryData.catoryImageUrl placeholderImage:[UIImage imageNamed:@"other"] completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType) {
        if (error)
        {
            NSLog(@"Error : load image fail.");
            blockImgV.image = [UIImage imageNamed:@"other"];
        }
        else
        {
            blockImgV.image = image;
            if (cacheType == 0)
            { // request url
                CATransition *transition = [CATransition animation];
                transition.duration = 1.0f;
                transition.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut];
                transition.type = kCATransitionFade;
                [blockImgV.layer addAnimation:transition forKey:nil];
            }
        }
    }];
    cell.titleLabel.text = catoryData.catoryName;
    
    return cell;
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [catoryArry count];
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 50.0f;
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    HWCatoryClass *serviceCatory = [catoryArry objectAtIndex:[indexPath row]];
    if (_selectCatory) {
        _selectCatory(serviceCatory.catoryName,serviceCatory.catoryId,serviceCatory.catoryImageUrl);
    }
    [self.navigationController popViewControllerAnimated:YES];
}
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}
- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
