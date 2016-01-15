//
//  InterestingSeriesVC.m
//  PUClient
//
//  Created by RRLhy on 15/7/20.
//  Copyright (c) 2015年 RRLhy. All rights reserved.
//

#import "InterestingSeriesVC.h"
#import "InterestingStarVC.h"
#import "SeriesItem.h"
#import "HoteSeriesApi.h"

@interface InterestingSeriesVC ()
@property (weak, nonatomic) IBOutlet UIButton *skipBtn;
@property (nonatomic,retain)UIScrollView * mainScrollView;
@property (nonatomic,retain)NSMutableArray * sourceArray;
@property (nonatomic,retain)NSArray * seriesArray;
@end

@implementation InterestingSeriesVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    UILabel * introlLab = [[UILabel alloc]initWithFrame:CGRectMake(0, 22, App_Frame_Width, 20)];
    introlLab.text = @"先挑选几个感兴趣的美剧吧";
    introlLab.textAlignment = NSTextAlignmentCenter;
    introlLab.font = SYSTEMFONT(14);
    introlLab.textColor = GRAYCOLOR;
    [self.mainScrollView addSubview:introlLab];
   
    HoteSeriesApi * api = [[HoteSeriesApi alloc]initWithUserToken:[UserInfoConfig sharedUserInfoConfig].userInfo.token];
    [IanAlert showloading];
    [api startWithCompletionBlockWithSuccess:^(YTKBaseRequest *request) {
        [IanAlert hideLoading];
        NSDictionary * dic = request.responseJSONObject;
        NSLog(@"热门剧集列表%@",dic);
        if (dic) {
            JsonModel * json = [[JsonModel alloc]init];
            [json setValuesForKeysWithDictionary:dic];
            
            if (json.success) {
                [IanAlert hideLoading];
                [self createItem];
                
            }else{
                
                [IanAlert alertError:json.errorCode length:1];
            }
        }else{
            [IanAlert alertError:ERRORMSG1 length:1];
        }
        
    } failure:^(YTKBaseRequest *request) {
        
        [IanAlert alertError:ERRORMSG2 length:1];
        
    }];
}

- (UIScrollView*)mainScrollView
{
    if (!_mainScrollView) {
        _mainScrollView = [[UIScrollView alloc]initWithFrame:CGRectMake(0, 0, App_Frame_Width, App_Frame_Height - kTopBarHeight)];
        [self.view addSubview:_mainScrollView];
    }
    return _mainScrollView;
}

- (void)createItem
{
    float imageW= 65;
    float imageH= 70;
    float space = (Main_Screen_Width - 65 * 4)/5;
    float H = imageH + 10 + 14;
    float W = imageW;

    for (int i = 0; i < 20; i++) {
        
        int m = i%4;//行
        int n = i/4;//列
    
        SeriesItem * itemView = [[SeriesItem alloc]initWithFrame:CGRectMake((space + W)* m + space, 60 +(30 + H) * n , W,H)];
        
        itemView.selectBlock = ^(NSInteger index, BOOL isSelected){
            
            NSLog(@"--剧集---%ld %d",(long)index,isSelected);
            
            [_skipBtn setTitle:@"下一步" forState:UIControlStateNormal];
        };
        
        [_mainScrollView addSubview:itemView];
    }
    
    _mainScrollView.contentSize = CGSizeMake(App_Frame_Width, 5*(30 + H) + 60);

}
- (IBAction)nextClick:(id)sender {
    
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)updateViewConstraints
{
    [super updateViewConstraints];
//    self.seriesContain.constant = 1000;
}

#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
    
    if ([segue.identifier isEqualToString:@"hotStar"]) {
        InterestingStarVC * theSegue = segue.destinationViewController;
        theSegue.seriersIdString = @"abc";
    }
}


@end
