//
//  BaseTableViewController.m
//  PUClient
//
//  Created by RRLhy on 15/7/17.
//  Copyright (c) 2015年 RRLhy. All rights reserved.
//

#import "BaseTableViewController.h"
#import "MyPageVC.h"
#import "AppDelegate.h"
@interface BaseTableViewController ()<UIGestureRecognizerDelegate,UIScrollViewDelegate>
{
    NSArray * colorArray;
}
@end

@implementation BaseTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    colorArray = @[RGBCOLOR(0.020, 0.745, 1.000),
                   RGBCOLOR(0.133, 0.133, 0.133),
                   RGBCOLOR(0.941, 0.188, 0.506),
                   RGBCOLOR(0.624, 0.377, 0.753),
                   RGBCOLOR(0.314, 0.153, 0.643),
                   RGBCOLOR(0.149, 0.416, 0.620),
                   RGBCOLOR(0.373, 0.620, 0.627),
                   RGBCOLOR(0.180, 0.522, 0.373),
                   RGBCOLOR(0.467, 0.584, 0.341),
                   RGBCOLOR(0.576, 0.424, 0.353),
                   RGBCOLOR(0.659, 0.580, 0.427),
                   RGBCOLOR(0.573, 0.565, 0.545)];
    NSInteger index = [[[NSUserDefaults standardUserDefaults] objectForKey:ColorIndex] integerValue];
    
//    self.navigationItem.leftBarButtonItem =  [[UIBarButtonItem alloc]initWithImage:[UIImage imageNamed:@"nav_back_me_n"] style:UIBarButtonItemStylePlain target:self action:@selector(popViewController)];
//    self.navigationController.interactivePopGestureRecognizer.delegate = self;
//    self.navigationController.interactivePopGestureRecognizer.enabled = YES;
    
    self.navImage = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, Main_Screen_Width, kStatusBarHeight + kTopBarHeight)];
//    self.navImage.image = [UIImage stretchImageWithName:@"nav_bg_black"];
    self.navImage.backgroundColor = colorArray[index];
    self.navImage.userInteractionEnabled = YES;
    [self.view insertSubview:self.navImage aboveSubview:self.tableView];
//    [self.view bringSubviewToFront:self.navImage];
    
    self.leftBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [self.leftBtn setFrame:CGRectMake(0, 20, 44, 44)];
    [self.leftBtn setImage:[UIImage imageNamed:@"nav_btn_back_n"] forState:UIControlStateNormal];
    [self.leftBtn setImage:[UIImage imageNamed:@"nav_back_me_h"] forState:UIControlStateHighlighted];
    [self.leftBtn addTarget:self action:@selector(popViewController) forControlEvents:UIControlEventTouchUpInside];
    [self.leftBtn.imageView setContentMode:UIViewContentModeScaleAspectFit];
    [self.leftBtn setTintColor:[UIColor whiteColor]];
    [self.navImage addSubview:self.leftBtn];
    
    self.rightBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [self.rightBtn setFrame:CGRectMake(Main_Screen_Width - 54, 20, 44, 44)];
    [self.rightBtn addTarget:self action:@selector(rightBtnClick) forControlEvents:UIControlEventTouchUpInside];
    [self.rightBtn.imageView setContentMode:UIViewContentModeScaleAspectFit];
    [self.rightBtn setTintColor:[UIColor whiteColor]];
    [self.rightBtn.titleLabel setFont:BOLDSYSTEMFONT(16)];
    [self.rightBtn setHidden:YES];
    [self.navImage addSubview:self.rightBtn];
    
    self.titleLabel = [[UILabel alloc]initWithFrame:CGRectMake(80, 20, (Main_Screen_Width - 160), 44)];
    self.titleLabel.font = BOLDSYSTEMFONT(18);
    self.titleLabel.textAlignment = NSTextAlignmentCenter;
    self.titleLabel.textColor = [UIColor whiteColor];
    [self.navImage addSubview:self.titleLabel];
    
    UIView * view = [[UIView alloc]initWithFrame:CGRectMake(0, 0, Main_Screen_Width, 64)];
    self.tableView.tableHeaderView = view;
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(changeNavImage) name:@"changeColor" object:nil];
}

- (void)changeNavImage
{
    NSInteger index = [[[NSUserDefaults standardUserDefaults] objectForKey:ColorIndex] integerValue];
    self.navImage.backgroundColor = colorArray[index];
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    _navImage.frame = CGRectMake(_navImage.frame.origin.x, 0 + self.tableView.contentOffset.y , _navImage.frame.size.width,_navImage.frame.size.height);
}

#pragma mark 返回上一个视图控制器
- (void)popViewController
{
    [self.navigationController popViewControllerAnimated:YES];
}

#pragma mark 返回到根视图控制器
- (void)popRootTableViewController
{
    NSArray * array = self.navigationController.viewControllers;
    MyPageVC * myPage = (MyPageVC*)array[0];
    [myPage reloadUIData];
    [self.navigationController popToViewController:array[0] animated:YES];
}
#pragma mark 右边按钮
- (void)rightBtnClick
{
    
}

- (UIStatusBarStyle)preferredStatusBarStyle
{
    return UIStatusBarStyleLightContent;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

//- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
//#warning Potentially incomplete method implementation.
//    // Return the number of sections.
//    return 0;
//}

//- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
//#warning Incomplete method implementation.
//    // Return the number of rows in the section.
//    return 0;
//}

/*
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:<#@"reuseIdentifier"#> forIndexPath:indexPath];
    
    // Configure the cell...
    
    return cell;
}
*/

/*
// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the specified item to be editable.
    return YES;
}
*/

/*
// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete the row from the data source
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    } else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
    }   
}
*/

/*
// Override to support rearranging the table view.
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath {
}
*/

/*
// Override to support conditional rearranging of the table view.
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the item to be re-orderable.
    return YES;
}
*/

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
