//
//  PayMethodFooterView.m
//  Community
//
//  Created by hw500028 on 14/12/10.
//  Copyright (c) 2014年 caijingpeng. All rights reserved.
//

#import "PayMethodFooterView.h"
#import "UIViewExt.h"
#define PayMethodViewTag 100
#define PayMethodButtonTag      1001

@implementation PayMethodFooterView
@synthesize payIndex;
@synthesize payMoney;

- (id)initWithFrame:(CGRect)frame titleArr:(NSArray *)titleArr money:(NSString *)money selectIndex:(int)selectedIndex
{
    self = [super initWithFrame:frame];
    if (self) {
        self.titleArr = titleArr;
        self.payMoney = money;
        [self initViews:selectedIndex];
    }
    return self;
}

- (id)initWithArr:(NSArray *)arr{
    self = [super init];
    if (self) {
        self.titleArr = arr;
    }
    return self;
}
- (void)initViews:(int)selectIndex
{
    self.backgroundColor = [UIColor whiteColor];
    
    UILabel *label = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, kScreenWidth, 44)];
    label.text = @"    支付方式";
    label.font = [UIFont systemFontOfSize:15.0f];
    [self addSubview:label];
    UIView *line = [[UIView alloc] initWithFrame:CGRectMake(0, 44.0f - 0.5f, kScreenWidth, 0.5f)];
    line.backgroundColor = THEME_COLOR_LINE;
    [label addSubview:line];
    
    for (NSInteger i = 0; i < _titleArr.count; i++)
    {
        [self payMethodViewWithFrame:CGRectMake(0, label.bottom + 20 + 50 * i,kScreenWidth, 25) Title:i selectIndex:selectIndex];
        if ([_titleArr[i] isEqualToString:@"账户余额"])
        {
         
            UILabel *MoneyLabel = [[UILabel alloc]initWithFrame:CGRectMake(150, 55, 100, 44)];
            MoneyLabel.text = [NSString stringWithFormat:@"￥%@",[HWUserLogin currentUserLogin].totalMoney];
            MoneyLabel.font = [UIFont systemFontOfSize:15.0f];
            MoneyLabel.textAlignment = NSTextAlignmentCenter;
            MoneyLabel.textColor = THEME_COLOR_MONEY;
            [self addSubview:MoneyLabel];
            
        }
//        else if([_titleArr[i] isEqualToString:@"支出金额"])
//        {
//            UILabel *MoneyLabel = [[UILabel alloc]initWithFrame:CGRectMake(150, 55, 100, 44)];
//            MoneyLabel.text = [NSString stringWithFormat:@"￥%@",self.payMoney];
//            MoneyLabel.font = [UIFont systemFontOfSize:15.0f];
//            MoneyLabel.textAlignment = NSTextAlignmentCenter;
//            MoneyLabel.textColor = THEME_COLOR_MONEY;
//            [self addSubview:MoneyLabel];
//        }
        self.userInteractionEnabled = YES;
    }
}

- (void)payMethodViewWithFrame:(CGRect)frame Title:(int)titleIndex selectIndex:(int)selectIndex
{
    UIView *view = [[UIView alloc]initWithFrame:frame];
    _payImageV = [[UIImageView alloc]init];
    _payImageV.frame = CGRectMake(20, 0, 25, 25);
    _payImageV.image = [UIImage imageNamed:@"type_unsel"];
    [view addSubview:_payImageV];
    if (titleIndex == selectIndex)
    {
        _payImageV.image = [UIImage imageNamed:@"gou"];
        if (selectIndex == 0) {
             self.payIndex = 0;
        }
        else
        {
             self.payIndex = 1;
        }
       
    }
    //end
    UILabel *label = [[UILabel alloc]initWithFrame:CGRectMake(_payImageV.right + 15,5, 100,15)];
    label.text = _titleArr[titleIndex];
    label.font = [UIFont systemFontOfSize:15];
    [view addSubview:label];
    [self addSubview:view];
    UIButton *btn = [UIButton buttonWithType: UIButtonTypeCustom];
    btn.backgroundColor = [UIColor clearColor];
    btn.frame = CGRectMake(20, 0, 140, 25);
    [btn addTarget:self action:@selector(btnClick:) forControlEvents:UIControlEventTouchUpInside];
    btn.tag = PayMethodButtonTag + titleIndex;
    [view addSubview:btn];
}

- (void)btnClick:(UIButton *)button{
    NSLog(@"点击");
    UIView *view = button.superview;
    UIView *superView = view.superview;
    for (UIView *subview in superView.subviews) {
        for (NSInteger i = 0; i < subview.subviews.count; i++) {
            if ([subview.subviews[i] isKindOfClass:[UIImageView class]]) {
                UIImageView *imgV = subview.subviews[i];
                imgV.image = [UIImage imageNamed:@"type_unsel"];
            }
        }
    }
    for (UIImageView *imagV in view.subviews) {
        if ([imagV isKindOfClass:[UIImageView class]]) {
            imagV.image = [UIImage imageNamed:@"gou"];
        }
    }
    self.payIndex = button.tag - PayMethodButtonTag;

}

#pragma mark - 计算高度

+ (CGFloat)getPayMenthodHeight
{
    NSInteger count = 2;
    CGFloat h = count*25 + (count-1)*25 + 40 +44;
    return h;
}

@end
