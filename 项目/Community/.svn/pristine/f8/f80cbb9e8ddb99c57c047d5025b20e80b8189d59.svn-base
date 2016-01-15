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

#define WIDTH    [UIScreen mainScreen].bounds.size.width
#define HEIGHT    [UIScreen mainScreen].bounds.size.height
#define SIZE     ([UIScreen mainScreen].bounds.size.width / 320.0f)

@implementation HWCustomSiftView
@synthesize delegate;

- (id)initWithTitle:(NSArray *)titles andBtnFrame:(CGRect)frame
{
    self = [super initWithFrame:CGRectMake(0, 0, WIDTH, 0)];
    if (self) {
        
        _Selected = YES;
        
        _titleArr = titles;
        
        _clearView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, WIDTH, HEIGHT)];
        _clearView.backgroundColor = [UIColor clearColor];
        _clearView.userInteractionEnabled = YES;
        UITapGestureRecognizer *tapGas = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(hideView)];
        [_clearView addGestureRecognizer:tapGas];
        [self addSubview:_clearView];
        
        _ListTableView = [[UITableView alloc]initWithFrame:CGRectMake(1*SIZE,6, 100*SIZE,40*_titleArr.count*SIZE)];
        _ListTableView.delegate = self;
        _ListTableView.dataSource = self;
        _ListTableView.backgroundColor = [UIColor whiteColor];
        _ListTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        _ListTableView.scrollEnabled = NO;
        //_ListTableView.hidden = YES;
        _backImageView = [[UIImageView alloc]initWithFrame:CGRectMake(WIDTH - (5 + 100) * SIZE - 1, (frame.origin.y + frame.size.height) * SIZE + 64 + 2, (100 + 2) * SIZE, 40 * SIZE * _titleArr.count + 6)];

        UIImage *image = [UIImage imageNamed:@"filter_bg"];
        _backImageView.image = [image resizableImageWithCapInsets:UIEdgeInsetsMake(10, 45, 10, 30)];
        [_backImageView addSubview:_ListTableView];
        _backImageView.userInteractionEnabled = YES;
        [self addSubview:_backImageView];
        [self showList];
    }
    return self;
}

- (void)setBackImageView:(UIImageView *)backImageView
{
    UIImage *image = [UIImage imageNamed:@"filter_bg_down"];
    _backImageView.image = [image resizableImageWithCapInsets:UIEdgeInsetsMake(100, 45, 10, 30)];
    _backImageView.userInteractionEnabled = YES;
}

#pragma mark -- UITableViewDelegate
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return _titleArr.count;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 40*SIZE;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *cellID = @"cellID";
    UITableViewCell *cell = [tableView dequeueReusableHeaderFooterViewWithIdentifier:cellID];
    if (!cell)
    {
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellID];
    }
    
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    
    UILabel *label = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, tableView.bounds.size.width, 40*SIZE)];
    label.font = [UIFont fontWithName:FONTNAME size:13];
    label.text = _titleArr[indexPath.row];
    label.textColor = THEME_COLOR_TEXT;
    label.backgroundColor = UIColorFromRGB(0xe5e5e5);
    //label.backgroundColor = BACKGROUND_COLOR;
    label.textAlignment = NSTextAlignmentCenter;
    [cell.contentView addSubview:label];
    
    
    UIView *line = [[UIView alloc] initWithFrame:CGRectMake(0, 40*SIZE - 1.0f, tableView.bounds.size.width, 1.0f)];
    line.backgroundColor = UIColorFromRGB(0xd1d1d1);
    [cell.contentView addSubview:line];
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:NO];
    _selectedInfo(_titleArr[indexPath.row]);
    
   // [[NSNotificationCenter defaultCenter]postNotificationName:@"ChangeSearchRange" object:[NSString stringWithFormat:@"%d",indexPath.row]];
    
    [self hideList];
    _Selected = !_Selected;
}

- (void)setSelected:(BOOL)Selected{
   
    _Selected = Selected;
    if (_Selected == NO) {
        dispatch_async(dispatch_get_main_queue(), ^{
            [self hideList];
        });
    }else{
        [self showList];
    }
}

- (void)hideView
{
    [delegate hideSiftView];
    _Selected = !_Selected;
    [self hideList];
}

- (void)hideList
{
    [UIView animateWithDuration:0.3 animations:^{
        self.frame = CGRectMake(0, 0, WIDTH,0);
        _backImageView.alpha = 0;
        //_ListTableView.alpha = 0;
    }completion:^(BOOL finished) {
        _ListTableView.frame = CGRectMake(WIDTH-(5+100)*SIZE, _ListTableView.frame.origin.y, 100*SIZE, 0);
        _clearView.frame = CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width,0);
        [self removeFromSuperview];
    }];
}

- (void)showList
{
    self.frame = CGRectMake(0, 0,WIDTH,HEIGHT);
    _clearView.frame = CGRectMake(0, 0, WIDTH, HEIGHT);
    //_ListTableView.frame = CGRectMake(WIDTH-(5+100)*SIZE, _ListTableView.frame.origin.y,  100 * SIZE,40 * _titleArr.count * SIZE);
    _backImageView.alpha = 0;
    _ListTableView.alpha = 0;
    [UIView animateWithDuration:0.3 animations:^{
        _ListTableView.alpha =1;
        _backImageView.alpha = 1;
    }completion:^(BOOL finished) {
        
    }];
}

@end
