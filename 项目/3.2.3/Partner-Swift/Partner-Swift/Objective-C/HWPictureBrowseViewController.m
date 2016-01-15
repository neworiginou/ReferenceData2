//
//  HWPictureBrowseViewController.m
//  MoreHouse
//
//  Created by caijingpeng on 14/11/24.
//  Copyright (c) 2014年 lizhongqiang. All rights reserved.
//

#import "HWPictureBrowseViewController.h"
#import "ETZoomScrollView.h"
#import "MBProgressHUD.h"
#import "Partner_Swift-Swift.h"

#define TOP_BUTTON_TAG      1001
#define SCROLLVIEW_TAG      2001
#define IMAGEVIEW_TAG       3001

@interface HWPictureBrowseViewController ()<UIScrollViewDelegate>
{
    NSMutableArray *targetArray;
    NSMutableArray *indexArray;
    UIImageView *downArrowImgV;
    UIScrollView *picSV;
    UILabel *countLab;
    NSString *kImageBaseUrl;
}
@end

@implementation HWPictureBrowseViewController
@synthesize selectType,sourceArray;
@synthesize picType;

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    if (picType == picTypeNewHouse) {
        kImageBaseUrl = @"";
    }
    else{
        kImageBaseUrl = [Utility imageDownloadWithMongoDbKey:@""];
    }
    
    self.navigationItem.titleView = [Utility_OC navTitleView:@"图片浏览"];
    self.navigationItem.leftBarButtonItem = [Utility_OC navLeftBackBtn:self action:@selector(backMethod)];
    
    if (self.showEditBtn) {
        self.navigationItem.rightBarButtonItem = [Utility_OC navButton:self title:@"编辑" action:@selector(showEdit)];
    }
    
    UIView *topTabBarView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, 40)];
    topTabBarView.backgroundColor = UIColorFromRGB(0x2c2c2c);
    [self.view addSubview:topTabBarView];
    
    float width = [UIScreen mainScreen].bounds.size.width / (float)self.sourceArray.count;
    
    [self operateData];
    
    for (int i = 0; i < self.sourceArray.count; i++)
    {
        NSDictionary *dic = (NSDictionary *)[sourceArray objectAtIndex:i];
        
        UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
        [btn setFrame:CGRectMake(i * width, 0, width, topTabBarView.frame.size.height)];
        btn.tag = TOP_BUTTON_TAG + i;
        [btn setTitleColor:TITLE_COLOR_99 forState:UIControlStateNormal];
        [btn setTitle:[dic objectForKey:@"title"] forState:UIControlStateNormal];
        btn.titleLabel.font = [UIFont fontWithName:FONTNAME size:TITLE_ZHENGWEN_SIZE];
        [btn addTarget:self action:@selector(doChangeType:) forControlEvents:UIControlEventTouchUpInside];
        [self.view addSubview:btn];
        if (i == selectType)
        {
            [btn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
            btn.backgroundColor = UIColorFromRGB(0x535353);
        }
        else
        {
            [btn setTitleColor:TITLE_COLOR_99 forState:UIControlStateNormal];
            btn.backgroundColor = [UIColor clearColor];
        }
        
    }
    
    picSV = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 40, kScreenWidth, [UIScreen mainScreen].bounds.size.height - 64 - 40)];
    picSV.contentSize = CGSizeMake(kScreenWidth * targetArray.count, picSV.frame.size.height);
    picSV.backgroundColor = [UIColor blackColor];
    picSV.delegate = self;
    picSV.pagingEnabled = YES;
    
    [self.view addSubview:picSV];
    
    NSNumber *indexNum;
    if (selectType > 0)
    {
        indexNum = [indexArray objectAtIndex:selectType - 1];
    }
    else
    {
        indexNum = [NSNumber numberWithInt:0];
    }
    
    
    for (int i = 0; i < targetArray.count; i++)
    {
        ETZoomScrollView *imgV = [[ETZoomScrollView alloc] initWithFrame:CGRectMake(i * picSV.frame.size.width, 0, picSV.frame.size.width, picSV.frame.size.height)];
        imgV.tag = IMAGEVIEW_TAG + i;
        imgV.contentMode = UIViewContentModeScaleAspectFit;
        
        
        if (i == indexNum.intValue)
        {
            MBProgressHUD *hud = [[MBProgressHUD alloc] initWithView:imgV];
            hud.mode = MBProgressHUDModeAnnularDeterminate;
            [imgV addSubview:hud];
            
            [hud show:YES];
            
            __weak ETZoomScrollView *weakImgV = imgV;
            __weak MBProgressHUD *weakHUD = hud;
            
            //MYP add v3.2.2修改
            //NSURL *url = [NSURL URLWithString:[NSString stringWithFormat:@"%@%@",kImageBaseUrl,[[targetArray objectAtIndex:i] objectForKey:@"picKey"]]];
            NSURL *url = [NSURL URLWithString:[[targetArray objectAtIndex:i] objectForKey:@"picKey"]];
            NSLog(@"url ======== %@",[targetArray objectAtIndex:i]);
//            NSString * url = s[[targetArray objectAtIndex:i] objectForKey:@"picKey"];
            [imgV.imageView setImageWithURL:url placeholderImage:[Utility getPlaceHolderImage:CGSizeMake(picSV.frame.size.width, picSV.frame.size.height) imageName:@"pic_wait_big" backColor:[UIColor blackColor]] options:0 progress:^(NSUInteger receivedSize, long long expectedSize) {
                
                if (expectedSize != 0)
                {
                    float progress = receivedSize / (float)expectedSize;
                    weakHUD.progress = progress;
                }
                
            } completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType) {
                
                weakImgV.imageView.image = image;
                if (error != nil)
                {
                    weakImgV.imageView.image = [Utility getPlaceHolderImage:CGSizeMake(picSV.frame.size.width, picSV.frame.size.height) imageName:@"pic_wait_big_no" backColor:[UIColor blackColor]];
                }
                [weakHUD removeFromSuperview];
            }];
            
        }
        [picSV addSubview:imgV];
        
    }
    
    
    downArrowImgV = [[UIImageView alloc] initWithFrame:CGRectMake(selectType * width + width / 2.0f - 7.5f, CGRectGetMaxY(topTabBarView.frame), 15, 7.5f)];
    downArrowImgV.image = [UIImage imageNamed:@"down_arrow"];
    [self.view addSubview:downArrowImgV];
    
    
    countLab = [[UILabel alloc] initWithFrame:CGRectMake(0, CGRectGetMinY(picSV.frame) + CGRectGetHeight(picSV.frame) * 0.75, 105, 20)];
    countLab.backgroundColor = [UIColor colorWithWhite:0 alpha:0.3];
    countLab.font = [UIFont fontWithName:FONTNAME size:TITLE_FUBIAOTI_SIZE];
    countLab.textColor = [UIColor whiteColor];
    countLab.textAlignment = NSTextAlignmentCenter;
    [self.view addSubview:countLab];
    
    NSDictionary *dic = (NSDictionary *)[sourceArray objectAtIndex:selectType];
    NSArray *urlArr = [dic objectForKey:@"sourceArr"];
    
   
    
    int result = 0;
    for (int i = (int)self.sourceArray.count - 1; i >= 0; i -- ) {
        if ([[[sourceArray objectAtIndex:i] objectForKey:@"sourceArr"] count] > 0) {
            result = i;
        }
    }
    UIButton *selButton = (UIButton *)[self.view viewWithTag:TOP_BUTTON_TAG + result];
    
    NSString *countStr = [NSString stringWithFormat:@"%@ 1/%d", [dic objectForKey:@"title"], (int)urlArr.count];
    if (urlArr.count == 0) {
        countStr = [NSString stringWithFormat:@"%@ 0/%d", [dic objectForKey:@"title"], (int)urlArr.count];
    }
    countLab.text = countStr;
    
    
    [self doChangeType:selButton];
    
    
}

- (void)backMethod
{
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)operateData
{
    targetArray = [NSMutableArray array];
    indexArray = [NSMutableArray array];
    int count = 0;
    
    for (int i = 0; i < self.sourceArray.count; i++)
    {
        NSDictionary *dic = (NSDictionary *)[sourceArray objectAtIndex:i];
        NSArray *arr = [dic objectForKey:@"sourceArr"];
        [targetArray addObjectsFromArray:arr];
        count += arr.count;
        [indexArray addObject:[NSNumber numberWithInt:count]];
    }
}

- (void)showEdit{
    HWScdHouseCreatStep2VC *step2VC = [[HWScdHouseCreatStep2VC alloc] init];
    step2VC._model.permission = self.permission;
    step2VC.indoorArr = self.innerArr;
    
    step2VC.houseStyleArr = self.houseArr;
    step2VC.houseId = self.houseId;
    
    
    
    
    [self.navigationController pushViewController:step2VC animated:YES];
}

- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView
{
    int page = scrollView.contentOffset.x / scrollView.frame.size.width;
    int i;
    for (i = 0; i < indexArray.count; i++)
    {
        int value = [[indexArray objectAtIndex:i] intValue];
        if (page < value)
        {
            break;
        }
    }
    
    
    if (selectType != i)
    {
        UIButton *button = (UIButton *)[self.view viewWithTag:TOP_BUTTON_TAG + i];
        [button setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        button.backgroundColor = UIColorFromRGB(0x535353);
        
        UIButton *preButton = (UIButton *)[self.view viewWithTag:TOP_BUTTON_TAG + selectType];
        [preButton setTitleColor:TITLE_COLOR_99 forState:UIControlStateNormal];
        preButton.backgroundColor = [UIColor clearColor];
        
        selectType = i;
        
        float width = kScreenWidth / (float)self.sourceArray.count;
        downArrowImgV.frame = CGRectMake(selectType * width + width / 2.0f - 7.5f, 40, 15, 7.5f);
    }
    
    ETZoomScrollView *imgV = (ETZoomScrollView *)[scrollView viewWithTag:(page + IMAGEVIEW_TAG)];
//    NSLog(@"%@",[targetArray objectAtIndex:page]);
    
    if (imgV != nil)
    {
        if (imgV.imageView.image == nil)
        {
            MBProgressHUD *hud = [[MBProgressHUD alloc] initWithView:imgV];
            hud.mode = MBProgressHUDModeAnnularDeterminate;
            [imgV addSubview:hud];
            [hud show:YES];
            __weak ETZoomScrollView *weakImgV = imgV;
            __weak MBProgressHUD *weakHUD = hud;
            
            //MYP add v3.2.2修改图片加载方式
            [imgV.imageView setImageWithURL:[NSURL URLWithString:[[targetArray objectAtIndex:page] stringObjectForKey:@"picKey"]] placeholderImage:[Utility getPlaceHolderImage:CGSizeMake(picSV.frame.size.width, picSV.frame.size.height) imageName:@"pic_wait_big" backColor:[UIColor blackColor]] options:0 progress:^(NSUInteger receivedSize, long long expectedSize) {
                
                if (expectedSize != 0)
                {
                    float progress = receivedSize / (float)expectedSize;
                    weakHUD.progress = progress;
                }
                
            } completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType) {
                
                weakImgV.imageView.image = image;
                [weakHUD removeFromSuperview];
                if (error != nil)
                {
                    weakImgV.imageView.image = [Utility getPlaceHolderImage:weakImgV.frame.size imageName:@"pic_wait_big_no" backColor:[UIColor blackColor]];
                }
                
            }];
        }
    }
    
    
    
    
    
    
    NSNumber *indexNum;
    if (selectType > 0)
    {
        indexNum = [indexArray objectAtIndex:selectType - 1];
    }
    else
    {
        indexNum = [NSNumber numberWithInt:0];
    }
    
    NSDictionary *dic = (NSDictionary *)[sourceArray objectAtIndex:selectType];
    NSArray *urlArr = [dic arrayObjectForKey:@"sourceArr"];
    
    NSString *countStr = [NSString stringWithFormat:@"%@ %d/%d", [dic stringObjectForKey:@"title"], page - indexNum.intValue + 1, (int)urlArr.count];
    countLab.text = countStr;
    
}

- (void)doChangeType:(UIButton *)sender
{
    if ([[self.sourceArray objectAtIndex:sender.tag - TOP_BUTTON_TAG]arrayObjectForKey:@"sourceArr"].count == 0) {
        
        [Utility showToastWithMessage:[NSString stringWithFormat:@"无%@",[[self.sourceArray objectAtIndex:sender.tag - TOP_BUTTON_TAG] stringObjectForKey:@"title"]] _view:self.view];
        return;
    }
    UIButton *preButton = (UIButton *)[self.view viewWithTag:TOP_BUTTON_TAG + selectType];
    [preButton setTitleColor:TITLE_COLOR_99 forState:UIControlStateNormal];
    preButton.backgroundColor = [UIColor clearColor];
    
    [sender setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    sender.backgroundColor = UIColorFromRGB(0x535353);
    
    selectType = sender.tag % TOP_BUTTON_TAG;
    
    float width = kScreenWidth / (float)self.sourceArray.count;
    downArrowImgV.frame = CGRectMake(selectType * width + width / 2.0f - 7.5f, 40, 15, 7.5f);
    
    NSNumber *indexNum;
    if (selectType > 0)
    {
        indexNum = [indexArray objectAtIndex:selectType - 1];
    }
    else
    {
        indexNum = [NSNumber numberWithInt:0];
    }
    [picSV setContentOffset:CGPointMake(indexNum.intValue * picSV.frame.size.width, 0)];
    
    NSDictionary *dic = (NSDictionary *)[sourceArray objectAtIndex:selectType];
    NSArray *urlArr = [dic arrayObjectForKey:@"sourceArr"];
    
    NSString *countStr = [NSString stringWithFormat:@"%@ 1/%d", [dic stringObjectForKey:@"title"], (int)urlArr.count];
    if (urlArr.count == 0) {
        countStr = [NSString stringWithFormat:@"%@ 0/%d", [dic stringObjectForKey:@"title"], (int)urlArr.count];
    }
    countLab.text = countStr;
    
    
    ETZoomScrollView *imgV = (ETZoomScrollView *)[picSV viewWithTag:(indexNum.intValue + IMAGEVIEW_TAG)];
//    NSLog(@"%@",[targetArray objectAtIndex:indexNum.intValue]);
    
    if (imgV != nil)
    {
        if (imgV.imageView.image == nil)
        {
            MBProgressHUD *hud = [[MBProgressHUD alloc] initWithView:imgV];
            hud.mode = MBProgressHUDModeAnnularDeterminate;
            [imgV addSubview:hud];
            [hud show:YES];
            __weak ETZoomScrollView *weakImgV = imgV;
            __weak MBProgressHUD *weakHUD = hud;
            
            //MYP add v3.2.2修改图片加载方式
            [imgV.imageView setImageWithURL:[NSURL URLWithString:[[targetArray objectAtIndex:indexNum.intValue] stringObjectForKey:@"picKey"]]placeholderImage:[Utility getPlaceHolderImage:CGSizeMake(picSV.frame.size.width, picSV.frame.size.height) imageName:@"pic_wait_big" backColor:[UIColor blackColor]] options:0 progress:^(NSUInteger receivedSize, long long expectedSize) {
                
                if (expectedSize != 0)
                {
                    float progress = receivedSize / (float)expectedSize;
                    weakHUD.progress = progress;
                }
                
            } completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType) {
                
                weakImgV.imageView.image = image;
                [weakHUD removeFromSuperview];
                if (error != nil)
                {
                    weakImgV.imageView.image = [Utility getPlaceHolderImage:weakImgV.frame.size imageName:@"pic_wait_big_no" backColor:[UIColor blackColor]];
                }
                
            }];
        }
    }
}

- (void)doChangeTypeWithIndex:(int)index
{
    UIButton *preButton = (UIButton *)[self.view viewWithTag:(TOP_BUTTON_TAG + 1)];
    [preButton setTitleColor:TITLE_COLOR_99 forState:UIControlStateNormal];
    preButton.backgroundColor = [UIColor clearColor];
    self.selectType = index;
    [preButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    preButton.backgroundColor = UIColorFromRGB(0x535353);
    
    
    UIButton *firstBtn = (UIButton *)[self.view viewWithTag:1001];
    [firstBtn setBackgroundColor:[UIColor clearColor]];
    
    selectType = preButton.tag % TOP_BUTTON_TAG;
    
    float width = kScreenWidth / (float)self.sourceArray.count;
    downArrowImgV.frame = CGRectMake(selectType * width + width / 2.0f - 7.5f, 40, 15, 7.5f);
    
    NSNumber *indexNum;
    if (selectType > 0)
    {
        indexNum = [indexArray objectAtIndex:selectType - 1];
    }
    else
    {
        indexNum = [NSNumber numberWithInt:0];
    }
    [picSV setContentOffset:CGPointMake(indexNum.intValue * picSV.frame.size.width, 0)];
    
    NSDictionary *dic = (NSDictionary *)[sourceArray objectAtIndex:selectType];
    NSArray *urlArr = [dic arrayObjectForKey:@"sourceArr"];
    
    NSString *countStr = [NSString stringWithFormat:@"%@ 1/%d", [dic stringObjectForKey:@"title"], (int)urlArr.count];
    countLab.text = countStr;
    
    
    ETZoomScrollView *imgV = (ETZoomScrollView *)[picSV viewWithTag:(indexNum.intValue + IMAGEVIEW_TAG)];
    //    NSLog(@"%@",[targetArray objectAtIndex:indexNum.intValue]);
    
    if (imgV != nil)
    {
        if (imgV.imageView.image == nil)
        {
            MBProgressHUD *hud = [[MBProgressHUD alloc] initWithView:imgV];
            hud.mode = MBProgressHUDModeAnnularDeterminate;
            [imgV addSubview:hud];
            [hud show:YES];
            __weak ETZoomScrollView *weakImgV = imgV;
            __weak MBProgressHUD *weakHUD = hud;
            
            //MYP add v3.2.2修改图片加载方式
            [imgV.imageView setImageWithURL: [NSURL URLWithString:[[targetArray objectAtIndex:indexNum.intValue] stringObjectForKey:@"picKey"]]  placeholderImage:[Utility getPlaceHolderImage:CGSizeMake(picSV.frame.size.width, picSV.frame.size.height) imageName:@"pic_wait_big" backColor:[UIColor blackColor]] options:0 progress:^(NSUInteger receivedSize, long long expectedSize) {
                
                if (expectedSize != 0)
                {
                    float progress = receivedSize / (float)expectedSize;
                    weakHUD.progress = progress;
                }
                
            } completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType) {
                
                weakImgV.imageView.image = image;
                [weakHUD removeFromSuperview];
                if (error != nil)
                {
                    weakImgV.imageView.image = [Utility getPlaceHolderImage:weakImgV.frame.size imageName:@"pic_wait_big_no" backColor:[UIColor blackColor]];
                }
                
            }];
        }
    }
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
