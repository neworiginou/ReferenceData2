//
//  HeadView.m
//  模仿“什么都值得买”app我的头视图
//
//  Created by lizhongqiang on 16/1/21.
//  Copyright © 2016年 lizhongqiang. All rights reserved.
//

#import "HeadView.h"
@interface HeadView ()<UIScrollViewDelegate,UITableViewDataSource,UITableViewDelegate>
{
    CGFloat _headY;
    CGFloat _speedHead;
    CGFloat _redY;
    CGFloat _speedRed;
}
@property (nonatomic, strong)UITableView *bgScrollView;
@property (nonatomic, strong)PersonalAvatar *person;
@property (nonatomic, strong)UIView *segmentCtrl;
@property (nonatomic ,strong)UIView *redLayer;
@end
@implementation HeadView
- (UITableView *)bgScrollView{
    if (_bgScrollView == nil) {
        _bgScrollView = [[UITableView alloc]initWithFrame:self.bounds];
        _bgScrollView.backgroundColor =  [UIColor clearColor];//;
        _bgScrollView.bounces = YES;
        _bgScrollView.dataSource = self;
        _bgScrollView.delegate = self;
        _bgScrollView.separatorStyle = UITableViewCellSeparatorStyleNone;
        _bgScrollView.contentSize = _bgScrollView.bounds.size;
    }
    return _bgScrollView;
}
- (UIView *)segmentCtrl{
    if(_segmentCtrl == nil){
        _segmentCtrl = [[UIView alloc]initWithFrame:CGRectMake(0, 448/1.5, [UIScreen mainScreen].bounds.size.width, 439/2)];
        _segmentCtrl.backgroundColor = [UIColor whiteColor];
    }
    return _segmentCtrl;
}
- (UIView *)redLayer{
    if(_redLayer == nil){
        _redLayer = [UIView new];
        _redLayer.frame = CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, 133/1.6+45);
        _redLayer.backgroundColor = [UIColor colorWithRed:229/255.0 green:55/255.0 blue:62/255.0f alpha:1.0];
        _redY = CGRectGetHeight(_redLayer.frame);
    }
    return _redLayer;
}
- (PersonalAvatar *)person{
    if(_person == nil){
        _person = [[PersonalAvatar alloc]initWithFrame:CGRectZero];
    }
    return _person;
}
- (void)scrollViewDidScroll:(UIScrollView *)scrollView{
    self.person.frame = CGRectMake(0, _headY+_speedHead*scrollView.contentOffset.y, self.person.frame.size.width, self.person.frame.size.height);
    CGRect frame = self.redLayer.frame;
    frame.size.height = _redY - _speedRed*scrollView.contentOffset.y;
    self.redLayer.frame = frame;
}
- (instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        self.backgroundColor = [UIColor colorWithRed:233/255.0 green:233/255.0 blue:233/255.0 alpha:1.0];
        [self addSubview:self.redLayer];
        [self addSubview:self.bgScrollView];
        UIView *headView = [[UIView alloc]init];
        [headView addSubview:self.person];
        //headView.backgroundColor = [UIColor yellowColor];
        headView.frame = CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, CGRectGetMaxY(self.person.frame));
        [headView addSubview:self.segmentCtrl];
        self.bgScrollView.tableHeaderView = headView;
        [self.bgScrollView addObserver:self forKeyPath:@"contentOffset" options:NSKeyValueObservingOptionNew|NSKeyValueObservingOptionOld context:nil];
        _headY = CGRectGetMinY(self.person.frame);
        _speedHead = 0.7;
        _speedRed = 0.2;
    }
    return self;
}
- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary<NSString *,id> *)change context:(void *)context{
    UIScrollView *scrollView = (UIScrollView *)object;
    
}
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 0;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 0;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 200;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString* cellId = @"cellID";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellId];
    if(cell == nil){
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellId];
    }
    cell.backgroundColor = [UIColor whiteColor];
    return cell;
}
@end

@implementation PersonalAvatar
- (UIImageView *)headImageView{
    if(_headImageView == nil){
        CGFloat width = CGRectGetWidth(self.frame);
        CGFloat radius = 45;
        _headImageView = [[UIImageView alloc]initWithFrame:CGRectMake(width/2.0-radius, 0, radius*2, radius*2)];
        _headImageView.backgroundColor = [UIColor blackColor];
        _headImageView.contentMode = UIViewContentModeScaleAspectFill;
        _headImageView.image = [UIImage imageNamed:@"head12"];
        _headImageView.layer.cornerRadius = radius;
        _headImageView.layer.masksToBounds = YES;
    }
    return _headImageView;
}
- (instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        
        self.backgroundColor = [UIColor clearColor];
        self.frame = CGRectMake(0, 133/1.6, [UIScreen mainScreen].bounds.size.width, 500);
        
        CAShapeLayer *shapeLayer = [CAShapeLayer layer];
        shapeLayer.path = getPath(self.frame).CGPath;
        //shapeLayer.backgroundColor = [UIColor purpleColor].CGColor;
        shapeLayer.strokeColor = [UIColor yellowColor].CGColor;
        shapeLayer.lineWidth = 2;
        //[self.layer addSublayer:shapeLayer];
        self.layer.mask = shapeLayer;
        
        [self addSubview:self.headImageView];
    }
    return self;
}
UIBezierPath* getPath(CGRect frame){
    UIBezierPath *path = [UIBezierPath bezierPath];
    CGFloat width = CGRectGetWidth(frame);
    CGFloat height = CGRectGetHeight(frame);
    CGFloat radius = 45;
    CGPoint startPoint = CGPointMake(width/2.0, radius);
    [path moveToPoint:startPoint];
    [path addArcWithCenter:startPoint radius:radius startAngle:0 endAngle:M_PI clockwise:NO];
    [path addLineToPoint:CGPointMake(0, radius)];
    [path addLineToPoint:CGPointMake(0, height)];
    [path addLineToPoint:CGPointMake(width, height)];
    [path addLineToPoint:CGPointMake(width, radius)];
    [path addLineToPoint:CGPointMake(width/2.0+radius, radius)];
    return path;
}
@end