//
//  InterestingStarVC.m
//  PUClient
//
//  Created by RRLhy on 15/7/20.
//  Copyright (c) 2015年 RRLhy. All rights reserved.
//

#import "InterestingStarVC.h"
#import "StarItem.h"
#import "MyPageVC.h"
#import "HotStarApi.h"
@interface InterestingStarVC ()
@property (weak, nonatomic) IBOutlet UIButton *skipBtn;
@property(nonatomic,retain)UIScrollView * mainScrollView;
@end

@implementation InterestingStarVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    UILabel * introlLab = [[UILabel alloc]initWithFrame:CGRectMake(0, 22, App_Frame_Width, 20)];
    introlLab.text = @"关注我喜爱的明星";
    introlLab.textAlignment = NSTextAlignmentCenter;
    introlLab.font = SYSTEMFONT(14);
    introlLab.textColor = GRAYCOLOR;
    [self.mainScrollView addSubview:introlLab];

    HotStarApi * api = [[HotStarApi alloc]initWithUserToken:[UserInfoConfig sharedUserInfoConfig].userInfo.token SeriesIdArr:self.seriersIdString];
    [api startWithCompletionBlockWithSuccess:^(YTKBaseRequest *request) {
        [IanAlert hideLoading];
        NSDictionary * dic = request.responseJSONObject;
        NSLog(@"热门剧集列表%@",dic);
        if (dic) {
            JsonModel * json = [[JsonModel alloc]init];
            [json setValuesForKeysWithDictionary:dic];
            
            if (json.success) {
                [IanAlert hideLoading];
                [self configureStarItem];
                
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

- (IBAction)completeClick:(id)sender {
    
    [self popRootViewController];
    
}

- (void)configureStarItem
{
    float spaceH = 20;
    float spaceV = 10;
    float w = (App_Frame_Width - 4*spaceH)/3;
    float h = w + 17 + 12*2;
   
    for (int i = 0; i < 15; i++) {
        int m = i%3;//行
        int n = i/3;//列
        
        StarItem * itemView = [[StarItem alloc]initWithFrame:CGRectMake((w + spaceH)* m + spaceH, 60 + (h + spaceV) * n , w, h)];
        
        itemView.selectBlok = ^(NSInteger index,BOOL isSelected){
            
            NSLog(@"--明星---%ld  %d",(long)index,isSelected);
            [_skipBtn setTitle:@"完成" forState:UIControlStateNormal];
        };
        [_mainScrollView addSubview:itemView];
    }
    
    _mainScrollView.contentSize = CGSizeMake(App_Frame_Width, 5*(h + spaceV) + 60);
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
