//
//  ViewController.m
//  BOSS刷新模拟
//
//  Created by lizhongqiang on 16/1/8.
//  Copyright © 2016年 lizhongqiang. All rights reserved.
//

#import "ViewController.h"
#import "MyHeader.h"
#import "AnimationView.h"
#import "AppDelegate.h"
#import "TableViewCell.h"
#import "UIButton+PopView.h"
#import "BOSS刷新模拟-Swift.h"
@interface ViewController ()
@property (strong, nonatomic) IBOutlet UITableView *mytableView;
@property (nonatomic, strong) UIButton *centerBtn;
@end

@implementation ViewController

- (UIButton *)centerBtn{
    if(_centerBtn == nil){
        _centerBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        _centerBtn.frame =CGRectMake(0, 0, 122/2, 53/2);
        _centerBtn.backgroundColor = [UIColor clearColor];
        [_centerBtn setAdjustsImageWhenHighlighted:NO];
        [_centerBtn setImage:[self arrowDirection:[UIColor whiteColor] direction:NO] forState:UIControlStateNormal];
        [_centerBtn setImage:[self arrowDirection:[UIColor whiteColor] direction:YES] forState:UIControlStateSelected];
        [_centerBtn addTarget:self action:@selector(BtnAction:) forControlEvents:UIControlEventTouchUpInside];
        [_centerBtn setTitle:@"iOS  " forState:UIControlStateNormal];
        _centerBtn.titleEdgeInsets = UIEdgeInsetsMake(0, -23, 0, 0);
        _centerBtn.imageEdgeInsets = UIEdgeInsetsMake(0, 0, 0, -73);
        UIButton.myFrame = CGRectMake(CGRectGetWidth(self.view.frame)/2.f-( _centerBtn.bounds.size.width+2*60)/2, 55, _centerBtn.bounds.size.width+2*60, 83);
        UIView *view = [[UIView alloc]init];
        _centerBtn.popView = view;
        _centerBtn.animated = NO;
    }
    return _centerBtn;
}

- (void)BtnAction:(UIButton *)btn{
    btn.selected = !btn.selected;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    [self.tableView registerNib:[UINib nibWithNibName:@"View" bundle:nil] forCellReuseIdentifier:@"CellID"];
    
    self.navigationItem.titleView = self.centerBtn;
    
    self.mytableView.backgroundColor = ((AppDelegate *)[UIApplication sharedApplication].delegate).backColor;
    self.mytableView.separatorStyle = UITableViewCellSeparatorStyleNone;
//    self.mytableView.mj_header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
//        
//    }];
    self.mytableView.mj_header = [MyHeader headerWithRefreshingBlock:^{
        [[NSNotificationCenter defaultCenter]postNotificationName:@"startAnimation" object:nil];
    }];
    //self.mytableView.mj_header.backgroundColor = [UIColor purpleColor];
    
//    AnimationView *animationView =[[AnimationView alloc]initWithFrame:CGRectMake(0, 0, <#CGFloat width#>, <#CGFloat height#>)];
//    animationView.backgroundColor = [UIColor greenColor];
//    [self.mytableView.mj_header addSubview:animationView];
    [self.mytableView addObserver:self forKeyPath:@"contentOffset" options:NSKeyValueObservingOptionNew context:nil];
    
    
}
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 10-5;
}
- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    UIView *view = [[UIView alloc]init];
    view.backgroundColor = [UIColor clearColor];
    return view;
}
- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary<NSString *,id> *)change context:(void *)context
{
    
    if ([keyPath isEqualToString:@"contentOffset"]) {
        UITableView *tableview = (UITableView *)object;
        MyHeader *header = (MyHeader *)self.mytableView.mj_header;
        [header refreshHeaderView:tableview.contentOffset.y];
    }
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 2;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 164;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *cellId = @"CellID";
    TableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellId];
    //if (cell == nil) {
       // cell = [[[NSBundle mainBundle]loadNibNamed:@"View" owner:nil options:nil]lastObject];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
   // }
    return cell;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    DetailVC *vc = [[DetailVC alloc]init];
    [self.navigationController pushViewController:vc animated:YES];
    
    
    
}
- (void)viewWillAppear:(BOOL)animated{
    UIButton *btn = (UIButton*)self.navigationItem.titleView;
    if(btn.selected){
        btn.popView.hidden = NO;
    }
    if (self.tableView.mj_header.state == MJRefreshStateRefreshing){
        MyHeader *header =  (MyHeader *)self.tableView.mj_header;
        [header startAnimations];
    }
}
- (void)viewWillDisappear:(BOOL)animated{
    UIButton *btn = (UIButton*)self.navigationItem.titleView;
    if(btn.selected){
        btn.popView.hidden = YES;
    }
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (UIImage *)arrowDirection:(UIColor *)color direction:(BOOL)up{
    UIImage *image = nil;
    UIGraphicsBeginImageContext(CGSizeMake(13, 7.2));
   
    CGContextRef context = UIGraphicsGetCurrentContext();
    if(up){
        CGContextTranslateCTM(context, 0, 7.2);
        CGContextScaleCTM(context, 1, -1);
    }else{
    }
    
    CGContextSetStrokeColorWithColor(context, color.CGColor);
    CGContextSetLineWidth(context, 1.3);
    CGContextMoveToPoint(context, 0, 0);
    CGContextAddLineToPoint(context, 13, 0);
    CGContextAddLineToPoint(context, 13/2, 7.2);
    //CGContextClosePath(context);
    CGContextAddLineToPoint(context, 2.3, 3.7);
    CGContextDrawPath(context, kCGPathStroke);
    image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return image;
}
@end
