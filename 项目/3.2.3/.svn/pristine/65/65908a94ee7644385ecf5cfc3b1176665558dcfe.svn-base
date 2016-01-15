//
//  HWCustomSiftView.m
//  Community
//
//  Created by hw500029 on 15/1/16.
//  Copyright (c) 2015年 caijingpeng. All rights reserved.
//  功能描述:点击导航栏右按钮时弹出的覆盖导航栏一下部分的筛选器 淡入淡出效果
//      姓名         日期               修改内容
//     马一平     2015-01-19           创建文件
//      李中强 2015-01-21 添加代理
//

#import "HWCustomSiftView.h"
#import "Define-OC.h"

#define WIDTH    [UIScreen mainScreen].bounds.size.width
#define HEIGHT    [UIScreen mainScreen].bounds.size.height
#define SIZE     ([UIScreen mainScreen].bounds.size.width / 320.0f)
#define BUTTON_WIDTH    150
#define MARGIN_RIGHT     15
#define BUTTON_HEIGHT   45
#define MARGIN_TOP      10
#define BUTTON_TAG      1000

@implementation HWCustomSiftView
@synthesize delegate;

- (id)initWithTitle:(NSArray *)titles image:(NSArray *)images andDependView:(UIView *)view
{
    self = [super initWithFrame:CGRectMake(0, 0, WIDTH, 0)];
    if (self) {
        
        _titleArr = titles;
        dependView = view;
        
        _clearView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, WIDTH, HEIGHT)];
        _clearView.backgroundColor = [UIColor clearColor];
        _clearView.userInteractionEnabled = YES;
        UITapGestureRecognizer *tapGas = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(hideView)];
        [_clearView addGestureRecognizer:tapGas];
        [self addSubview:_clearView];
        
        _backView = [[UIView alloc] initWithFrame:CGRectZero];
        _backView.backgroundColor = [UIColor clearColor];
        _backView.layer.masksToBounds = YES;
        [self addSubview:_backView];
        
        _backImageView = [[UIImageView alloc]initWithFrame:CGRectZero];
        UIImage *image = [UIImage imageNamed:@"editor_bg"];
        _backImageView.image = [image resizableImageWithCapInsets:UIEdgeInsetsMake(14, 5, 5, 30)];
        [_backView addSubview:_backImageView];
        
        for (int i = 0; i < _titleArr.count; i++)
        {
            NSString *title = [_titleArr objectAtIndex:i];
            
            UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
            [button setTitle:title forState:UIControlStateNormal];
            button.frame = CGRectMake(0, MARGIN_TOP + i * BUTTON_HEIGHT, BUTTON_WIDTH, BUTTON_HEIGHT);
            button.titleLabel.font = [UIFont systemFontOfSize:15];
            [button setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
            if (i < images.count)
            {
                [button setImage:[UIImage imageNamed:[images objectAtIndex:i]] forState:UIControlStateNormal];
            }
            [button setImageEdgeInsets:UIEdgeInsetsMake(0, -10, 0, 0)];
            [button setTitleEdgeInsets:UIEdgeInsetsMake(0, 10, 0, 0)];
            button.tag = BUTTON_TAG + i;
            [button addTarget:self action:@selector(toClickButton:) forControlEvents:UIControlEventTouchUpInside];
            [_backView addSubview:button];
            
            if (i != _titleArr.count - 1)
            {
                UIView *line = [[UIView alloc] initWithFrame:CGRectMake(0, CGRectGetMaxY(button.frame), BUTTON_WIDTH, 0.5f * (IPHONE6PLUS ? 1.5 : 1))];
                line.backgroundColor = UIColorFromRGB(0x5f5f5f);
                [_backView addSubview:line];
            }
        }
    }
    return self;
}

- (void)showInView:(UIView *)showView
{
    self.frame = showView.bounds;
    [showView addSubview:self];
    
    CGPoint pos = [showView convertPoint:dependView.frame.origin fromView:dependView.superview];
    _backView.frame = CGRectMake(self.frame.size.width - BUTTON_WIDTH - MARGIN_RIGHT, pos.y + dependView.frame.size.height - 10, BUTTON_WIDTH, BUTTON_HEIGHT * _titleArr.count + MARGIN_TOP);
    _backImageView.frame = _backView.bounds;
    
    _clearView.frame = showView.bounds;
    _backView.alpha = 0;
    [UIView animateWithDuration:0.3 animations:^{
        _backView.alpha = 1;
    }completion:^(BOOL finished) {
        
    }];
}

- (void)toClickButton:(UIButton *)sender
{
    if (delegate && [delegate respondsToSelector:@selector(siftView:didSelectedIndex:)])
    {
        [delegate siftView:self didSelectedIndex:sender.tag - BUTTON_TAG];
    }
    
    [self hideList];
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    
}

- (void)setInactiveButtonIndex:(NSInteger)index
{
    UIButton *button = (UIButton *)[_backView viewWithTag:BUTTON_TAG + index];
    if (button != nil)
    {
        button.userInteractionEnabled = NO;
        button.alpha = 0.5f;
    }
}

- (void)setActiveButtonIndex:(NSInteger)index
{
    UIButton *button = (UIButton *)[_backView viewWithTag:BUTTON_TAG + index];
    if (button != nil)
    {
        button.userInteractionEnabled = YES;
        button.alpha = 1.0f;
    }
}


- (void)hideView
{
    [self hideList];
}

- (void)hideList
{
    [UIView animateWithDuration:0.3 animations:^{
        self.frame = CGRectMake(0, 0, WIDTH,0);
        _backView.alpha = 0;
        //_ListTableView.alpha = 0;
    }completion:^(BOOL finished) {
        _clearView.frame = CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width,0);
        [self removeFromSuperview];
    }];
}


@end
