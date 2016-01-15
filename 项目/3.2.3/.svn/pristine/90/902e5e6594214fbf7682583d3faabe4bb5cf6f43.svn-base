//
//  HWCustomerView.h
//  Partner-Swift
//
//  Created by gusheng on 15/8/24.
//  Copyright (c) 2015年 caijingpeng.haowu. All rights reserved.
//

#import <UIKit/UIKit.h>
@class HWCustomerView;

@protocol CustomerSearchViewDelegate <NSObject>
//index为标识，表示是第几个按钮对应的下拉控件，从0开始
//value为所选的值，只能回传是第几行从0开始，具体数据源自行绑定
@optional
- (void)customerSearchView:(HWCustomerView *)customerSearchView passValue:(NSString *)value withIndex:(NSString *)index;
@optional
- (void)customerSearchView:(HWCustomerView *)customerSearchView passZone:(NSString *)zoneId plateId:(NSString *)plateId;
//-(void)sendaTitle:(NSString *)aTitle;
//-(void)sendTitle:(NSString *)title;

@end

@interface HWCustomerView : UIView<UITableViewDataSource, UITableViewDelegate>
@property (nonatomic, strong) NSMutableArray *searchItems;
@property (nonatomic, strong) NSMutableArray *defaultTitles; // 默认第一个显示的title
@property (nonatomic, strong) NSArray *itemArray;
@property (nonatomic, strong) NSMutableArray *selIndexArr;
@property (nonatomic, strong) NSMutableArray *subTitlesArr;
@property (nonatomic, strong) NSString *plateName;
@property (nonatomic, assign) id <CustomerSearchViewDelegate>delegate1;


- (id)initWithItems:(NSArray *)items andCDefaultTitles:(NSArray *)dTitles;
- (id)initWithItems:(NSArray *)items andCDefaultTitles:(NSArray *)dTitles hasSubTitles:(BOOL)isHas;
- (id)initWithItems:(NSArray *)items andCCustomerDefaultTitles:(NSArray *)dTitles hasSubTitles:(BOOL)isHas height:(CGFloat)height;
- (void)removeBackView;
- (void)fillSubtitlesWithArray:(NSArray *)arr;
- (void)doSelect:(UIButton *)sender;
- (void)hideSearchBackView;
@end
