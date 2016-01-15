//
//  SilverVC.m
//  PUClient
//
//  Created by RRLhy on 15/8/3.
//  Copyright (c) 2015年 RRLhy. All rights reserved.
//

#import "SilverVC.h"
#import "SilverCell.h"
#import "SilverHeader.h"
#import "MySilverApi.h"
#import "Silver.h"
#import "SilverList.h"
#define ROWS @"10"
@interface SilverVC ()
{
    NSInteger page;
    SilverHeader * headerView;
    UIColor * navColor;
}
@property (nonatomic,retain)NSMutableArray * listArray;
@end

@implementation SilverVC

- (void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    [MobClick endLogPageView:self.title];
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [MobClick beginLogPageView:self.title];
    navColor = self.navImage.backgroundColor;
    self.navImage.backgroundColor = [navColor colorWithAlphaComponent:0];

}
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.titleLabel.text = @"我的银币";

    page = 1;
    _listArray = [[NSMutableArray alloc]init];
    
    headerView = [[SilverHeader alloc]initWithFrame:CGRectMake(0, 0, Main_Screen_Width, 170)];
    self.tableView.tableHeaderView = headerView;
    
    [self loadUserSilver];
}

#pragma mark 请求数据
- (void)loadUserSilver
{
    if (self.listArray.count==0) {
            [IanAlert showloading];
    }
    __weak SilverVC * weakself = self;
    NSString * userId = [UserInfoConfig sharedUserInfoConfig].userInfo.Id;
    MySilverApi * silver = [[MySilverApi alloc]initWithUserId:userId Page:[NSString stringWithFormat:@"%ld",(long)page] Rows:ROWS];
    [silver startWithCompletionBlockWithSuccess:^(YTKBaseRequest *request) {
        NSDictionary * dic = request.responseJSONObject;
        if (dic) {
            NSLog(@"%@",dic);
            JsonModel * json = [JsonModel objectWithKeyValues:dic];
            if (json.code == SUCCESSCODE) {
                SilverList * list = [SilverList objectWithKeyValues:json.data];
                [weakself.listArray addObjectsFromArray:list.recordList];
                
                if (list.currentPage == 1) {
                    [headerView upDateSilverCount:list.silverCount];
                }
                
                [weakself.tableView reloadData];
                page = list.currentPage + 1;
                [IanAlert hideLoading];
                
            }else{
                
                [IanAlert alertError:json.msg length:1];
            }
            
        }else{
            
            [IanAlert alertError:ERRORMSG1 length:1];
        }
    } failure:^(YTKBaseRequest *request) {
        
        [IanAlert alertError:ERRORMSG2 length:1];
        
    }];

}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 2;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (section==0) {
        return 1;
    }else{
        return self.listArray.count + 1;
    }
}

- (UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    // 自已的cell类
    SilverCell * silverCell = [tableView dequeueReusableCellWithIdentifier:[SilverCell cellID]];
    if (silverCell == nil) {
        // 如果池中没取到,则重新生成一个girlCell,xib文件中指定了重用cellID
        if (indexPath.section == 0) {
            silverCell = [SilverCell silverCellAtIndex:1];
        }else{
            if (indexPath.row == 0) {
                 silverCell = [SilverCell silverCellAtIndex:2];
            }else{
                 silverCell = [SilverCell silverCellAtIndex:0];
            }
        }
    }
    
    if (indexPath.section == 1) {
        if (indexPath.row != 0) {
            Silver * silver = self.listArray[indexPath.row - 1];
            silverCell = [silverCell cellWithSilver:silver];
        }
    }
    return silverCell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section ==0) {
        return 107;
    }else{
        if (indexPath.row == 0) {
            return 58;
        }else{
            return 50;
        }
    }
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 0.1;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    return 0.1;
}

- (UIView*)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section
{
    return nil;
}

- (UIView*)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    return nil;
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
     self.navImage.frame = CGRectMake(self.navImage.frame.origin.x, 0 + self.tableView.contentOffset.y , self.navImage.frame.size.width,self.navImage.frame.size.height);
    CGPoint offset = scrollView.contentOffset;
    float alp = offset.y/100;
    if (alp>=1) {
        return;
    }
    self.navImage.backgroundColor = [navColor colorWithAlphaComponent:alp];
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
