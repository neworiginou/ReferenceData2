//
//  HWBrandViewController.m
//  Community
//
//  Created by caijingpeng.haowu on 14-12-9.
//  Copyright (c) 2014年 caijingpeng. All rights reserved.
//

#import "HWBrandViewController.h"
#import "HWApplicationModel.h"
#import "HWApplicationDetailViewController.h"

@interface HWBrandViewController ()
{
    UIScrollView *mainSV;
}
@property (nonatomic, strong) NSArray *appList;

@end

@implementation HWBrandViewController

@synthesize appList;

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.navigationItem.leftBarButtonItem = [Utility navLeftBackBtn:self action:@selector(backMethod)];
    
    mainSV = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, CONTENT_HEIGHT)];
    mainSV.backgroundColor = [UIColor whiteColor];
    mainSV.contentSize = CGSizeMake(kScreenWidth, mainSV.frame.size.height + 1);
    [self.view addSubview:mainSV];
    
    
    
    [self queryListData];
}

- (void)initialAppView
{
    float marginLeft = 30;
    float btnWidth = 60;
    float btnHeight = 90;
    float verticalGap = 15.0f;
    float gap = (kScreenWidth - btnWidth * 3 - marginLeft * 2) / 2.0f;
    
    for (int i = 0; i < self.appList.count; i++)
    {
        UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
        button.backgroundColor = [UIColor clearColor];
        button.frame = CGRectMake(i % 3 * (btnWidth + gap) + marginLeft, verticalGap + i / 3 * (btnHeight + verticalGap), btnWidth, btnHeight);
//        [button setImage:[Utility imageWithColor:[UIColor clearColor] andSize:CGSizeMake(50, 50)] forState:UIControlStateNormal];
        button.titleLabel.font = [UIFont fontWithName:FONTNAME size:13.0f];
        button.titleLabel.backgroundColor = [UIColor clearColor];
        [button setTitleColor:THEME_COLOR_SMOKE forState:UIControlStateNormal];
        [button setImageEdgeInsets:UIEdgeInsetsMake(0, 0, 30, 0)];
//        [button setTitleEdgeInsets:UIEdgeInsetsMake(60, - btnWidth, 0, 0)];
        //        [button addTarget:self action:@selector(toAppIcon:) forControlEvents:UIControlEventTouchUpInside];
        //        button.tag = kAPPICON_TAG + i;
//        [button setImage:[Utility imageWithColor:[UIColor redColor] andSize:CGSizeMake(btnWidth, btnWidth)] forState:UIControlStateNormal];
        
        
        
//        [button setTitle:@"水果店" forState:UIControlStateNormal];
        
        HWApplicationModel *appModel = [self.appList objectAtIndex:i];
        NSString *iconUrlStr = [Utility imageDownloadWithMongoDbKey:appModel.iconMongodbKey];
        
        __weak UIButton *weakButton = button;
        [button.imageView setImageWithURL:[NSURL URLWithString:iconUrlStr] placeholderImage:[UIImage imageNamed:IMAGE_PLACE] completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType) {
            
            if (error != nil)
            {
                [weakButton setImage:[UIImage imageNamed:IMAGE_BREAK_CUBE] forState:UIControlStateNormal];
            }
            else
            {
                [weakButton setImage:image forState:UIControlStateNormal];
            }
            
        }];
        button.tag = 999 + i;
        [button addTarget:self action:@selector(toAppDetail:) forControlEvents:UIControlEventTouchUpInside];
        
        UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(0, 90 - 30, btnWidth, 30)];
        label.backgroundColor = [UIColor clearColor];
        label.font = [UIFont fontWithName:FONTNAME size:13.0f];
        label.textColor = THEME_COLOR_SMOKE;
        label.text = appModel.name;
        label.textAlignment = NSTextAlignmentCenter;
        [button addSubview:label];
        
        [mainSV addSubview:button];
    }
    
    float height = verticalGap + (self.appList.count + 2) / 3 * (btnHeight + verticalGap);
    
    mainSV.contentSize = CGSizeMake(kScreenWidth, MAX(height, mainSV.frame.size.height + 1));
}

- (void)queryListData
{
    HWUserLogin *user = [HWUserLogin currentUserLogin];
    HWHTTPRequestOperationManager *manage = [HWHTTPRequestOperationManager manager];
    NSMutableDictionary *dict = [[NSMutableDictionary alloc] init];
    [dict setPObject:[HWUserLogin currentUserLogin].key forKey:@"key"];
    [dict setPObject:[HWUserLogin currentUserLogin].villageId forKey:@"villageId"];
    [dict setPObject:self.folderId forKey:@"folderId"];

    [manage POST:kApplicationFolder parameters:dict queue:nil success:^(id responseObject) {
        
        NSArray *respList = [[responseObject dictionaryObjectForKey:@"data"] arrayObjectForKey:@"content"];
        
        NSMutableArray *resultList = [NSMutableArray array];
        for (int i = 0; i < respList.count; i++)
        {
            NSDictionary *info = [respList objectAtIndex:i];
            [resultList addObject:[[HWApplicationModel alloc] initWithApplicationInfo:info]];
        }
        self.appList = resultList;
        
        [self initialAppView];
        
    } failure:^(NSString *code, NSString *error) {
        NSLog(@"error %@",error);
    }];
}

- (void)toAppDetail:(UIButton *)sender
{
    HWApplicationModel *appModel = [self.appList objectAtIndex:(sender.tag - 999)];
    
    HWApplicationDetailViewController *appDetailVC = [[HWApplicationDetailViewController alloc] init];
    appDetailVC.navigationItem.titleView = [Utility navTitleView:appModel.name];
    appDetailVC.appUrl = appModel.iconUrl;
    [self.navigationController pushViewController:appDetailVC animated:YES];
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
