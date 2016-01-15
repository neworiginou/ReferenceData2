//
//  HWSelectionView.h
//  MoreHouse
//
//  Created by zhangxun on 14/11/21.
//  Copyright (c) 2014年 lizhongqiang. All rights reserved.
//

#import <UIKit/UIKit.h>
@class HWSelectionView;

@protocol HWSelectionViewDelegate <NSObject>

- (void)selected:(HWSelectionView *)selClass;

- (void)deSelected:(HWSelectionView *)selClass;

@end

@interface HWSelectionView : UIView

@property (nonatomic,assign)BOOL allowMore;

@property (nonatomic,assign)BOOL isSelected;

@property (nonatomic,assign)id <HWSelectionViewDelegate>delegate;

- (id)initWithTitle:(NSString *)title;

- (void)setSelected;

- (void)setDeselected;

@end
