//
//  DateNextVC.m
//  PUClient
//
//  Created by RRLhy on 15/8/15.
//  Copyright (c) 2015年 RRLhy. All rights reserved.
//

#import "DateNextVC.h"
#import "DateSelectView.h"
#import "DateNextCell.h"

@interface DateNextVC ()<UITableViewDataSource,UITableViewDelegate,UIScrollViewDelegate>
{
    DateSelectView * topView;
    NSInteger currentIndex;
}
@property (weak, nonatomic) IBOutlet UIScrollView *mainScrollView;
@property (weak, nonatomic) IBOutlet UITableView *tableView1;
@property (weak, nonatomic) IBOutlet UITableView *tableView2;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *viewcotainWidth;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *viewCotainHight;
@end

@implementation DateNextVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.navImage.image = [UIImage stretchImageWithName:@"nav_bg_black"];
    topView = [[DateSelectView alloc]initWithFrame:CGRectMake(X(self.titleLabel), 27, WIDTH(self.titleLabel), 30) items:@[@"上周排行",@"上上周排行"] complete:^(NSInteger itemIndex) {
        
        NSLog(@"%ld",(long)itemIndex);
        if (currentIndex == itemIndex) {
            return ;
        }
        
        currentIndex = itemIndex;
        
        [_mainScrollView setContentOffset:CGPointMake(Main_Screen_Width*(currentIndex-1), 0) animated:YES];
    }];

    [self.navImage addSubview:topView];
}


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 10;
}

#pragma mark 每一行怎样显示cell
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    DateNextCell * cell = [tableView dequeueReusableCellWithIdentifier:[DateNextCell cellIndentifier]];
    //3，如果缓存中没有可利用的cell，则创建
    if(cell == nil){
        cell = [DateNextCell CellAtIndex:0];
    }
    
    cell = [cell cellWithSeries:nil];
    
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 70;
}

- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView
{
    
    CGPoint offset = scrollView.contentOffset;
    NSInteger num = offset.x/Main_Screen_Width;
    currentIndex = num + 1;
    topView.currentIndex = num;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)updateViewConstraints
{
    [super updateViewConstraints];
    _viewcotainWidth.constant =  Main_Screen_Width * 2;
    _viewCotainHight.constant = Main_Screen_Height - 64;
}

#pragma mark - Navigation
// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
@end
