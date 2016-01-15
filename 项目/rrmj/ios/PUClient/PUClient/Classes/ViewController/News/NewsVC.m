//
//  NewsVC.m
//  PUClient
//
//  Created by RRLhy on 15/7/22.
//  Copyright (c) 2015年 RRLhy. All rights reserved.
//

#import "NewsVC.h"
#import "TopSegMentrol.h"
#import "InformationVC.h"
#import "RatingVC.h"
#import "ReviewVC.h"
#import "DateVC.h"
@interface NewsVC ()<UIPageViewControllerDataSource,UIPageViewControllerDelegate>
{
    TopSegMentrol *  _segMtrol;
}
@property (nonatomic, strong)UIPageViewController *pageViewController;
//UIPageViewController中有两个常用的属性：双面显示（doubleSided)和书脊位置（spineLocation）。
@property (nonatomic, strong)NSMutableArray *dataArray;
@property (nonatomic,assign)NSInteger currentIndex;
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

    self.leftBtn.hidden = YES;
    UIImage * image = IMAGENAME(@"nav_logo");
    self.titleImage.bounds = CGRectMake(0, 0, image.size.width, image.size.height);
    self.titleImage.image = image;

    [self createContentPages];
    [self ShowTopSegMentrol];
    
//    NSDictionary *options = @{UIPageViewControllerOptionInterPageSpacingKey:@(30),UIPageViewControllerOptionSpineLocationKey:@(UIPageViewControllerSpineLocationMin)};
    NSDictionary * options = [NSDictionary dictionaryWithObject:[NSNumber numberWithInteger:UIPageViewControllerSpineLocationMin] forKey: UIPageViewControllerOptionSpineLocationKey];
    /*
     UIpageViewControllerSpineLocationMin 的书脊在左边。
     UIpageViewControllerSpineLocationMid 书脊被放置在两个视图控制器的中间,要求一页要有两个视图控制器。
     UIpageViewControllerSpineLocationMax 书脊在屏幕右端
     只有是这种模式UIPageViewControllerTransitionStylePageCurl时，UIPageViewControllerOptionSpineLocationKey设置才有效
     只有是这种模式UIPageViewControllerTransitionStyleScroll时，UIPageViewControllerOptionInterPageSpacingKey设置才有效,对应的值是两页之间的空隙，可以根据自己意愿设置
     */
    _pageViewController = [[UIPageViewController alloc]initWithTransitionStyle:UIPageViewControllerTransitionStyleScroll navigationOrientation:UIPageViewControllerNavigationOrientationHorizontal options:options];
    _pageViewController.dataSource = self;
    _pageViewController.delegate = self;
    _pageViewController.view.backgroundColor = [UIColor whiteColor];
    
    InformationVC * information = (InformationVC*)[self viewControllerAtIndex:0];
    NSArray *viewControllers = [NSArray arrayWithObject:information];
    
    [_pageViewController setViewControllers:viewControllers direction:UIPageViewControllerNavigationDirectionForward animated:YES completion:^(BOOL finished) {
        /*
         navigationOrientation设定了翻页方向，UIPageViewControllerNavigationDirection枚举类型定义了以下两种翻页方式。
         
         UIPageViewControllerNavigationDirectionForward：从左往右（或从下往上）；
         
         UIPageViewControllerNavigationDirectionReverse：从右向左（或从上往下）
         */
    }];

    self.pageViewController.view.frame = CGRectMake(0, MaxY(_segMtrol), Main_Screen_Width, Main_Screen_Height - MaxY(_segMtrol) - 49);
    [self addChildViewController:_pageViewController];
    [self.view addSubview:_pageViewController.view];
    
//    [_pageViewController.view.subviews enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop) {
//        if([obj isKindOfClass:[UIPageControl class]])
//        {
//            UIPageControl *pageCtrl = (UIPageControl *)obj;
//            pageCtrl.pageIndicatorTintColor = [UIColor redColor];
//            pageCtrl.currentPageIndicatorTintColor = [UIColor blueColor];
//            pageCtrl.hidden = YES;
//        }
//    }];

}
#pragma mark 顶部选项卡
- (void)ShowTopSegMentrol
{
    NSArray * array = @[@"资讯",@"剧评",@"收视",@"排期"];
    __weak NewsVC * weakself = self;
    _segMtrol = [[TopSegMentrol alloc]initWithFrame:CGRectMake(0, 64, Main_Screen_Width, 30) itemsTitleArray:array];
    _segMtrol.itemBlock = ^(NSInteger index){
        NSLog(@"%ld",(long)index);
        NSInteger selectIndex = index - 10;
        if (weakself.currentIndex == selectIndex) {
            return ;
        }
        [weakself setPage:selectIndex];
        
    };
    [self.view addSubview:_segMtrol];
}

- (void)setPage:(NSUInteger)pageIndex
{
    
    UIPageViewControllerNavigationDirection direction = pageIndex > _currentIndex ? UIPageViewControllerNavigationDirectionForward : UIPageViewControllerNavigationDirectionReverse;

    UIViewController * vc = (UIViewController*)[self viewControllerAtIndex:pageIndex];
 
    NSArray *viewControllers = [NSArray arrayWithObject:vc];
    
    [_pageViewController setViewControllers:viewControllers direction:direction animated:YES completion:^(BOOL finished) {
        /*
         navigationOrientation设定了翻页方向，UIPageViewControllerNavigationDirection枚举类型定义了以下两种翻页方式。
         
         UIPageViewControllerNavigationDirectionForward：从左往右（或从下往上）；
         
         UIPageViewControllerNavigationDirectionReverse：从右向左（或从上往下）
         */
        
        _currentIndex = pageIndex;
    }];
    
    
    
}
- (void)createContentPages
{
    _dataArray = [NSMutableArray array];
    //消息
    InformationVC * information = [[InformationVC alloc] init];
    information.view.backgroundColor = [UIColor whiteColor];
    information.fatherController = self;
    //剧评
    ReviewVC * review = [[ReviewVC alloc] init];
    review.view.backgroundColor = [UIColor blueColor];
    review.fatherController = self;
    //收视率
    RatingVC * rating = [[RatingVC alloc] init];
    rating.view.backgroundColor = [UIColor redColor];
    rating.view.frame = CGRectMake(0, 64, Main_Screen_Width, Main_Screen_Height);
    rating.fatherController = self;
    //排期表
    DateVC * date = [[DateVC alloc] init];
    date.view.backgroundColor = [UIColor yellowColor];
    date.fatherController = self;
    [_dataArray addObject:information];
    [_dataArray addObject:review];
    [_dataArray addObject:rating];
    [_dataArray addObject:date];
    
}
// 得到相应的VC对象
//- (MoreViewController *)viewControllerAtIndex:(NSUInteger)index {
- (UIViewController *)viewControllerAtIndex:(NSUInteger)index {
    if (([self.dataArray count] == 0) || (index >= [self.dataArray count])) {
        return nil;
    }
    // 创建一个新的控制器类，并且分配给相应的数据
    //    MoreViewController *dataViewController =[[MoreViewController alloc] init];
    //    dataViewController.view.backgroundColor = [UIColor whiteColor];
    //    dataViewController.dataObject = [self.dataArray objectAtIndex:index];
    //    return dataViewController;
    return _dataArray[index];
}

// 根据数组元素值，得到下标值
- (NSUInteger)indexOfViewController:(UIViewController *)viewController {
    
    return [self.dataArray indexOfObject:viewController];
}
// 返回上一个ViewController对象
- (UIViewController *)pageViewController:(UIPageViewController *)pageViewController viewControllerBeforeViewController:(UIViewController *)viewController{
    
    //    NSUInteger index = [self indexOfViewController:(MoreViewController *)viewController];
    NSUInteger index = [self indexOfViewController:viewController];
    if ((index == 0) || (index == NSNotFound)) {
        return nil;
    }
    index--;
    // 返回的ViewController，将被添加到相应的UIPageViewController对象上。
    // UIPageViewController对象会根据UIPageViewControllerDataSource协议方法，自动来维护次序。
    // 不用我们去操心每个ViewController的顺序问题。
    return [self viewControllerAtIndex:index];
}

// 返回下一个ViewController对象
- (UIViewController *)pageViewController:(UIPageViewController *)pageViewController viewControllerAfterViewController:(UIViewController *)viewController{
    
    //    NSUInteger index = [self indexOfViewController:(MoreViewController *)viewController];
    NSUInteger index = [self indexOfViewController:viewController];
    if (index == NSNotFound) {
        return nil;
    }
    index++;
    if (index == [self.dataArray count]) {
        return nil;
    }
    return [self viewControllerAtIndex:index];
    
    
}
//UIPageViewControllerTransitionStyleScroll模式下，才会调用下面两个dataSource方法 要显示底部的pagecontrol的时候 用着两个方法
//- (NSInteger)presentationCountForPageViewController:(UIPageViewController *)pageViewController
//{
//    return _dataArray.count;
//}
//
////- (NSInteger)presentationIndexForPageViewController:(UIPageViewController *)pageViewController
////{
////    return 0;
////}

- (void)pageViewController:(UIPageViewController *)pageViewController willTransitionToViewControllers:(NSArray *)pendingViewControllers
{
    
}

- (void)pageViewController:(UIPageViewController *)pageViewController didFinishAnimating:(BOOL)finished previousViewControllers:(NSArray *)previousViewControllers transitionCompleted:(BOOL)completed
{
    NSUInteger index = [self indexOfViewController:pageViewController.viewControllers[0]];
    NSLog(@"%ld",index);
    _segMtrol.currentIndex = index;
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
