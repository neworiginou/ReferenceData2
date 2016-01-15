//
//  HWCustomSiftView.h
//  Community
//
//  Created by hw500029 on 15/1/16.
//  Copyright (c) 2015年 caijingpeng. All rights reserved.
//  功能描述：自定义弹出筛选
//  修改记录
//      李中强 2015-01-21 添加代理
//

#import <UIKit/UIKit.h>

@protocol HWCustomSiftViewDelegate <NSObject>

- (void)hideSiftView;

@end

@interface HWCustomSiftView : UIView<UITableViewDelegate,UITableViewDataSource>

@property (nonatomic ,strong)UITableView *ListTableView;
@property (nonatomic ,strong)UIView *clearView;
@property (nonatomic ,strong)UIImageView *backImageView;
@property (nonatomic, strong)UIView *contentView;
@property (nonatomic ,strong)NSArray *titleArr;

@property (nonatomic, assign,getter=isSelcted) BOOL Selected;

@property (nonatomic, copy)void(^selectedInfo)(NSString *title);

@property (nonatomic, assign)id<HWCustomSiftViewDelegate>delegate;

- (id)initWithTitle:(NSArray *)titles andBtnFrame:(CGRect)frame;

@end
