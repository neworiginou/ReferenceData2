//
//  HWGuideMainView.m
//  HWIntroductionView
//
//  Created by lizhongqiang on 15/11/9.
//  Copyright © 2015年 lizhongqiang. All rights reserved.
//

#import "HWGuideMainView.h"
#import "HWGuideImageView.h"
@interface HWGuideMainView ()<UIScrollViewDelegate>
@property (nonatomic, strong)UIScrollView *scrollView;
@property (nonatomic, strong)NSArray *array;
@property (nonatomic, strong)UIButton *enterBtn;
@end
@implementation HWGuideMainView
- (instancetype)initWithFrame:(CGRect)frame
{
    if(self = [super initWithFrame:frame]){
        self.backgroundColor = [UIColor whiteColor];
        [self addSubview:self.scrollView];
        
        
        //[self initPageCtrl];
        self.array = @[[UIColor colorWithRed:252/255.0f green:183/255.0f blue:47/255.f alpha:1.0],[UIColor colorWithRed:248/255.0f green:90/255.0f blue:95/255.f alpha:1.0],[UIColor colorWithRed:96/255.0f green:194/255.0f blue:68/255.f alpha:1.0],[UIColor colorWithRed:100/255.0f green:189/255.0f blue:221/255.f alpha:1.0]];
        [self initImageViews];
    }
    return self;
}
- (UIScrollView *)scrollView{
    if(_scrollView==nil){
        _scrollView = [[UIScrollView alloc]initWithFrame:self.bounds];
        _scrollView.pagingEnabled = YES;
        _scrollView.delegate = self;
        _scrollView.showsHorizontalScrollIndicator = NO;
    }
    return _scrollView;
}
- (UIPageControl *)pageCtrl
{
    if(_pageCtrl == nil){
        _pageCtrl = [[UIPageControl alloc]init];
    }
    return _pageCtrl;
}
- (UIButton *)enterBtn{
    if(_enterBtn == nil){
        _enterBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [_enterBtn addTarget:self action:@selector(enterAction) forControlEvents:UIControlEventTouchUpInside];
        //_enterBtn.backgroundColor = [UIColor blackColor];
        //_enterBtn.layer.masksToBounds = NO;
        _enterBtn.imageView.contentMode = UIViewContentModeScaleAspectFill;
        [_enterBtn setImage:[UIImage imageNamed:@"enter"] forState:UIControlStateNormal];
    }
    return _enterBtn;
}
- (void)initImageViews{
    for(int i=0; i<4; i++){
        HWGuideImageView *imageView = [[HWGuideImageView alloc]initWithFrame:CGRectOffset(self.bounds, i*CGRectGetWidth(self.bounds), 0)];
        imageView.Guide = [NSString stringWithFormat:@"guide%d",i+1];
        imageView.Guide_Text = [NSString stringWithFormat:@"guide%d_text",i+1];
        [self.scrollView addSubview:imageView];
        imageView.backgroundColor = self.array[i];
        if(i == 3){
            [imageView addSubview:self.enterBtn];
        }
    }
    [self addSubview:self.pageCtrl];
    self.pageCtrl.numberOfPages = 4;
    _pageCtrl.center = CGPointMake(CGRectGetWidth(self.frame)/2.f, 970/2.f*(CGRectGetHeight(self.frame)/568));
    //_pageCtrl.backgroundColor = [UIColor blackColor];
    _pageCtrl.bounds = CGRectMake(0, 0, 200, 16);
    
    _enterBtn.center = CGPointMake(_pageCtrl.center.x, CGRectGetMaxY(_pageCtrl.frame)+23);
    _enterBtn.bounds = CGRectMake(0, 0, (217/2.f)*(CGRectGetWidth(self.frame)/320), (64/2.f)*(CGRectGetHeight(self.frame)/568));
    if(CGRectGetHeight(self.frame)>667){
        _enterBtn.center = CGPointMake(_enterBtn.center.x, _enterBtn.center.y+15);
        _enterBtn.bounds = CGRectMake(0, 0, 120, 44);
    }
    if(CGRectGetHeight(self.frame)<500){
        _pageCtrl.center = CGPointMake(_pageCtrl.center.x, _pageCtrl.center.y+10);
        _enterBtn.center = CGPointMake(_enterBtn.center.x, _enterBtn.center.y+5);
        _enterBtn.bounds = CGRectMake(0, 0, 100, 29);
    }
    
    self.scrollView.contentSize = CGSizeMake(4*CGRectGetWidth(self.frame), 0);
}
- (void)scrollViewDidScroll:(UIScrollView *)scrollView{
    CGFloat x = scrollView.contentOffset.x/CGRectGetWidth(scrollView.frame);
    self.pageCtrl.currentPage = (int)x;
    
}
- (void)enterAction{
    if(self.delegate){
        [self.delegate showStatusBar];
    }
}
/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
