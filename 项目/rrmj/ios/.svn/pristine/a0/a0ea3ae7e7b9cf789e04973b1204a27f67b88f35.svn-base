//
//  NewsVC.m
//  PUClient
//
//  Created by RRLhy on 15/7/22.
//  Copyright (c) 2015年 RRLhy. All rights reserved.
//

#import "NewsVC.h"
#import "TopSegMentrol.h"
@interface NewsVC ()

@end

@implementation NewsVC

- (void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    [MobClick endLogPageView:@"Page_资讯"];
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [MobClick beginLogPageView:@"Page_资讯"];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.navigationItem.leftBarButtonItem = nil;
    
    [self ShowTopSegMentrol];

}

- (void)ShowTopSegMentrol
{
    NSArray * array = @[@"资讯",@"剧评",@"收视",@"排期"];
    
    TopSegMentrol *  _segMtrol = [[TopSegMentrol alloc]initWithFrame:CGRectMake(0, 0, Main_Screen_Width, 30) itemsTitleArray:array];
    _segMtrol.itemBlock = ^(NSInteger index){
        NSLog(@"%ld",(long)index);
        
    };
    [self.view addSubview:_segMtrol];
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
