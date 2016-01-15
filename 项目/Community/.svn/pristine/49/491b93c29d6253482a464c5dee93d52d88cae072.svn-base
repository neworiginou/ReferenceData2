//
//  HWLuckDrawResultViewController.m
//  Community
//
//  Created by hw500027 on 15/4/24.
//  Copyright (c) 2015年 caijingpeng. All rights reserved.
//
//  功能描述：抽奖结果界面
//
//  修改记录：
//      姓名          日期                      修改内容
//      陆晓波        2015-04-24                 创建文件
//

#import "HWLuckDrawResultViewController.h"
#import "HWMoneyViewController.h"

#define kTopHeight      45
@interface HWLuckDrawResultViewController ()

@end

@implementation HWLuckDrawResultViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.titleView = [Utility navTitleView:@"抽奖"];
    self.navigationItem.leftBarButtonItem = [Utility navLeftBackBtn:self action:@selector(customBackMethod)];
    
    CGFloat height1 = [self addContentLabel];
    CGFloat height2 = [self addCoinImgView:height1];
    CGFloat height3 = [self moveToWallet:height2];
    CGFloat height4 = [self moveToWudixian:height3];
    [self autoTurnBackLabel:height4];
    // Do any additional setup after loading the view.
}

-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [self.navigationController setNavigationBarHidden:NO];
}

-(void)viewWillDisappear:(BOOL)animated
{
    [NSRunLoop cancelPreviousPerformRequestsWithTarget:self];
}

//显示label
-(CGFloat)addContentLabel
{
    UILabel *contentLabel = [UILabel newAutoLayoutView];
    [self.view addSubview:contentLabel];
    [contentLabel autoPinEdge:ALEdgeTop toEdge:ALEdgeTop ofView:self.view withOffset:kTopHeight];
    [contentLabel autoAlignAxis:ALAxisVertical toSameAxisOfView:self.view];
    
    NSString *text = [NSString stringWithFormat:@"恭喜，获得考拉币%d个",_coinCount];
    NSMutableAttributedString *str = [Utility setFullStr:text fullStrWithFont:[UIFont fontWithName:FONTNAME size:15] fullStrWithColor:[UIColor blackColor] needChangeStrArray:@[@"0",@"1",@"2",@"3",@"4",@"5",@"6",@"7",@"8",@"9"] changeStrWithFont:[UIFont fontWithName:FONTNAME size:20] changeStrColor:THEBUTTON_GREEN_NORMAL];
    contentLabel.attributedText = str;
    return [contentLabel systemLayoutSizeFittingSize:UILayoutFittingCompressedSize].height + kTopHeight;
}

//显示图片
-(CGFloat)addCoinImgView:(CGFloat)edgeTopHeight
{
    CGFloat height = 35;
    UIImageView *coinImgV = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"login_klb"]];
    [self.view addSubview:coinImgV];
    coinImgV.translatesAutoresizingMaskIntoConstraints = NO;
    [coinImgV autoAlignAxis:ALAxisVertical toSameAxisOfView:self.view];
    [coinImgV autoPinEdge:ALEdgeTop toEdge:ALEdgeTop ofView:self.view withOffset:edgeTopHeight + height];
    return [coinImgV systemLayoutSizeFittingSize:UILayoutFittingCompressedSize].height + height + edgeTopHeight;
}

//去钱包查看button
-(CGFloat)moveToWallet:(CGFloat)edgeTopHeight
{
    CGFloat height = 60;
    UIButton *moveToWalletButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [self.view addSubview:moveToWalletButton];
    moveToWalletButton.translatesAutoresizingMaskIntoConstraints = NO;
    [moveToWalletButton autoPinEdge:ALEdgeTop toEdge:ALEdgeTop ofView:self.view withOffset:edgeTopHeight + height];
    [moveToWalletButton autoAlignAxis:ALAxisVertical toSameAxisOfView:self.view];
    [moveToWalletButton autoSetDimensionsToSize:CGSizeMake(580 / 2, 90 / 2)];
    [moveToWalletButton setTitle:@"去钱包查看" forState:UIControlStateNormal];
    [moveToWalletButton setButtonCustomStyleWithButtonSize:[moveToWalletButton systemLayoutSizeFittingSize:UILayoutFittingCompressedSize] buttonNormalColor:THEBUTTON_GREEN_NORMAL buttonHighlightColor:THEBUTTON_GREEN_HIGHLIGHT];
    [moveToWalletButton addTarget:self action:@selector(didClickMoveToWalletBtn) forControlEvents:UIControlEventTouchUpInside];
    return [moveToWalletButton systemLayoutSizeFittingSize:UILayoutFittingCompressedSize].height + height + edgeTopHeight;
}

//返回无底线按钮
-(CGFloat)moveToWudixian:(CGFloat)edgeTopHeight
{
    CGFloat height = 10;
    UIButton *moveToWudixianButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [self.view addSubview:moveToWudixianButton];
    moveToWudixianButton.translatesAutoresizingMaskIntoConstraints = NO;
    [moveToWudixianButton autoPinEdge:ALEdgeTop toEdge:ALEdgeTop ofView:self.view withOffset:edgeTopHeight + height];
    [moveToWudixianButton autoAlignAxis:ALAxisVertical toSameAxisOfView:self.view];
    [moveToWudixianButton autoSetDimensionsToSize:CGSizeMake(580 / 2, 90 / 2)];
    [moveToWudixianButton setTitle:@"返回无底线" forState:UIControlStateNormal];
    [moveToWudixianButton setButtonCustomStyleWithButtonSize:[moveToWudixianButton systemLayoutSizeFittingSize:UILayoutFittingCompressedSize] buttonNormalColor:THEBUTTON_YELLOW_NORMAL buttonHighlightColor:THEBUTTON_YELLOW_HIGHLIGHT];
    [moveToWudixianButton addTarget:self action:@selector(customBackMethod) forControlEvents:UIControlEventTouchUpInside];
    return [moveToWudixianButton systemLayoutSizeFittingSize:UILayoutFittingCompressedSize].height + height + edgeTopHeight;
}

//显示3秒后返回无底线label
-(void)autoTurnBackLabel:(CGFloat)edgeTopHeight
{
    CGFloat height = 14;
    NSInteger time = 3;
    UILabel *label = [UILabel newAutoLayoutView];
    label.textColor = THEME_COLOR_TEXT;
    label.font = [UIFont fontWithName:FONTNAME size:14];
    [self.view addSubview:label];
    label.tag = time;
    [label autoAlignAxis:ALAxisVertical toSameAxisOfView:self.view];
    [label autoPinEdge:ALEdgeTop toEdge:ALEdgeTop ofView:self.view withOffset:edgeTopHeight + height];
    [label autoSetDimension:ALDimensionHeight toSize:14];
    label.text = [NSString stringWithFormat:@"%d秒后返回无底线",time];
    [self performSelector:@selector(coldDown:) withObject:label afterDelay:1];
}

-(void)coldDown:(UILabel *)label
{
    label.tag = label.tag - 1;
    if (label.tag >= 0)
    {
        label.text = [NSString stringWithFormat:@"%d秒后返回无底线",label.tag];
    }
    else if (label.tag == -1)
    {
        [self customBackMethod];
    }
    [self performSelector:@selector(coldDown:) withObject:label afterDelay:1];
}

//前往我的钱包
-(void)didClickMoveToWalletBtn
{
    [self.navigationController pushViewController:[HWMoneyViewController new] animated:YES];
}

//返回无底线
-(void)customBackMethod
{
    [self.navigationController popToViewController:[self.navigationController.viewControllers pObjectAtIndex:self.navigationController.viewControllers.count - 3] animated:YES];
}

- (void)didReceiveMemoryWarning
{
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
