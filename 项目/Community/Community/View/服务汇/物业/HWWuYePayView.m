//
//  HWWuYePayView.m
//  Community
//
//  Created by niedi on 15/6/11.
//  Copyright (c) 2015年 caijingpeng. All rights reserved.
//

#import "HWWuYePayView.h"
#import "HWServiceIcon.h"
#import "HWWuYeFeeVC.h"

@interface HWWuYePayView ()
{
    BOOL _isOpenJF;
    
    UIView *_tableHeaderView;
    DView *_iconBackView;
    NSMutableArray *_iconModelArr;
}
@end

@implementation HWWuYePayView

- (instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame])
    {
        _isOpenJF = NO;
        [self queryListData];
        [self loadUI];
    }
    return self;
}

- (void)queryListData
{
    /*URL:/hw-sq-app-web/wyJF/findByIcon.do
     入参：
     key
     villageId
     出参：*/
    
    NSMutableDictionary *param = [[NSMutableDictionary alloc]init];
    [param setPObject:[HWUserLogin currentUserLogin].key forKey:@"key"];
    [param setPObject:[HWUserLogin currentUserLogin].villageId forKey:@"villageId"];
    
    HWHTTPRequestOperationManager *manager = [HWHTTPRequestOperationManager manager];
    [manager POST:KWuYeFeeIsOpen parameters:param queue:nil success:^(id responese)
     {
         NSLog(@"responese ========================= %@",responese);
         if (self.currentPage == 0)
         {
             [self.baseListArr removeAllObjects];
         }
         
         isLastPage = YES;
         
         _isOpenJF = YES;
         [self loadUI];
         
         [self.baseTable reloadData];
         [self doneLoadingTableViewData];
     } failure:^(NSString *code, NSString *error) {
         [self doneLoadingTableViewData];
         [Utility showToastWithMessage:error inView:self];
     }];
}


- (void)loadUI
{
    _tableHeaderView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, 480)];
    
    _iconBackView = [DView viewFrameX:0 y:0 w:kScreenWidth h:kScreenWidth / 3.0f * 2 + 2 * 0.5f];
    _iconBackView.backgroundColor = [UIColor whiteColor];
    [_tableHeaderView addSubview:_iconBackView];
    
    [self initIconData:_isOpenJF];
    
    [self initWithIconView];
    
    CGRect frame = _tableHeaderView.frame;
    frame.size.height = CGRectGetMaxY(_iconBackView.frame);
    _tableHeaderView.frame = frame;
    
    self.baseTable.tableHeaderView = _tableHeaderView;
}

- (void)initIconData:(BOOL)isOpenJF
{
    _iconModelArr = [NSMutableArray array];
    
    if (isOpenJF)
    {
        NSArray *titleArr = @[@"物业费", @"水费", @"电费", @"燃气费"];
        NSArray *imgArr = @[@"wuyefei_01", @"shuifei_02", @"dianfei_02", @"ranqifei_02"];
        NSArray *classTArr = @[@"物业费", @"水费", @"电费", @"燃气费"];
        NSArray *classArr = @[@"HWWuYeFeeVC", @"", @"", @""];
        for (int i = 0; i < titleArr.count; i++)
        {
            HWServiceIconModel *model = [[HWServiceIconModel alloc] initWithDict:@{@"name" : [titleArr pObjectAtIndex:i], @"iconImgName" : [imgArr pObjectAtIndex:i]}];
            for (int j = 0; j < classTArr.count; j++)
            {
                if ([model.name isEqualToString:classTArr[j]])
                {
                    model.classStr = [classArr pObjectAtIndex:j];
                    break;
                }
            }
            
            [_iconModelArr addObject:model];
        }
    }
    else
    {
        NSArray *titleArr = @[@"物业费", @"水费", @"电费", @"燃气费"];
        NSArray *imgArr = @[@"wuyefei_02", @"shuifei_02", @"dianfei_02", @"ranqifei_02"];
        NSArray *classTArr = @[@"物业费", @"水费", @"电费", @"燃气费"];
        NSArray *classArr = @[@"", @"", @"", @""];
        for (int i = 0; i < titleArr.count; i++)
        {
            HWServiceIconModel *model = [[HWServiceIconModel alloc] initWithDict:@{@"name" : [titleArr pObjectAtIndex:i], @"iconImgName" : [imgArr pObjectAtIndex:i]}];
            for (int j = 0; j < classTArr.count; j++)
            {
                if ([model.name isEqualToString:classTArr[j]])
                {
                    model.classStr = [classArr pObjectAtIndex:j];
                    break;
                }
            }
            
            [_iconModelArr addObject:model];
        }
    }
}

- (void)initWithIconView
{
    CGFloat width = (kScreenWidth / 3.0f - 0.5f);
    CGFloat height = width;
    NSInteger rowNum = (_iconModelArr.count % 3 != 0 ? 1 : 0) + _iconModelArr.count / 3;
    
    for (int i = 0; i < _iconModelArr.count; i++)
    {
        if (i == 0)
        {
            for (int j = 0; j < 2; j++)
            {
                UIImageView *line = [DImageV imagV:nil frameX:width * (j + 1) + j % 3 * 0.5f y:0.0f w:0.5f h:(height + 0.5f) * rowNum];
                line.backgroundColor = THEME_COLOR_LINE;
                [_iconBackView addSubview:line];
                
                UIImageView *line2 = [DImageV imagV:nil frameX:0 y:0.0f + height * j + (j - 1) * 0.5f w:kScreenWidth h:0.5f];
                line2.backgroundColor = THEME_COLOR_LINE;
                [_iconBackView addSubview:line2];
            }
        }
        else if (i % 3 == 0)
        {
            UIImageView *line3 = [DImageV imagV:nil frameX:0 y:0.0f + height * (i / 3 + 1) + 0.5 * (i / 3) w:kScreenWidth h:0.5f];
            line3.backgroundColor = THEME_COLOR_LINE;
            [_iconBackView addSubview:line3];
        }
        
        HWServiceIconModel *model = [_iconModelArr pObjectAtIndex:i];
        HWServiceIcon *icon = [[HWServiceIcon alloc] initWithFrame:CGRectMake(width * (i % 3) + i % 3 * 0.5f, height * (i / 3) + i / 3 * 0.5f, width, height) model:model isDelImg:NO];
        [icon addTarget:self action:@selector(tapAction:) forIconEvents:IconTap];
        [icon addTarget:self action:@selector(iconLongPressBegain:) forIconEvents:IconLongPressBegain];
        [icon addTarget:self action:@selector(iconLongPressEnd:) forIconEvents:IconLongPressEnd];
        [icon addTarget:self action:@selector(IconPanChange:) forIconEvents:IconPanChange];
        [icon addTarget:self action:@selector(iconPanEnd:) forIconEvents:IconPanEnd];
        [icon addTarget:self action:@selector(iconDelBtnClick:) forIconEvents:iconDel];
        [_iconBackView addSubview:icon];
    }
    _iconBackView.frame = CGRectMake(_iconBackView.frame.origin.x, _iconBackView.frame.origin.y, kScreenWidth, 2 * height + 2 * 0.5f);
}

#pragma mark - icon 相关

- (void)iconLongPressBegain:(UILongPressGestureRecognizer *)press
{
    //    NSLog(@"iconLongPressBegain");
    
}

- (void)iconLongPressEnd:(UILongPressGestureRecognizer *)press
{
    //    NSLog(@"iconLongPressEnd");
}

- (void)IconPanChange:(UIPanGestureRecognizer *)pan
{
    //    NSLog(@"拖动手势Change");
    
}

- (void)iconPanEnd:(UIPanGestureRecognizer *)pan
{
    
}

- (void)iconDelBtnClick:(HWServiceIcon *)icon
{
    NSLog(@"iconDelBtnClick");
}

- (void)tapAction:(UITapGestureRecognizer *)tap
{
    HWServiceIcon *icon = (HWServiceIcon *)tap.view;
    NSString *classStr = icon.model.classStr;
    if (classStr.length != 0)
    {
        Class clss = NSClassFromString(classStr);
        if (clss)
        {
            if ([classStr isEqualToString:@"HWWuYeFeeVC"])
            {
                if ([HWUserLogin verifyBindMobileWithPopVC:self.fatherVC showAlert:YES])
                {
                    HWBaseViewController *vc = [(HWBaseViewController *)[clss alloc] init];
                    if ([HWUserLogin verifyIsLoginWithPresentVC:self.fatherVC toViewController:vc])
                    {
                        [self pushVC:vc];
                    }
                }
            }
            else if ([clss isSubclassOfClass:[HWBaseViewController class]])
            {
                HWBaseViewController *vc = [(HWBaseViewController *)[clss alloc] init];
                [self pushVC:vc];
            }
        }
    }
}

- (void)pushVC:(UIViewController *)vc
{
    if (self.delegate && [self.delegate respondsToSelector:@selector(pushViewController:)])
    {
        [self.delegate pushViewController:vc];
    }
}


@end
