//
//  HWSearchViewModel.h
//  MoreHouse
//
//  Created by caijingpeng.haowu on 14-11-20.
//  Copyright (c) 2014年 lizhongqiang. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol HWSearchViewModelDelegate <NSObject>

//输入关键字
- (void)didSelectedSearchTitle:(NSString *)title;

//点击搜索栏进入编辑状态
- (void)didBeginEditing;

//结束编辑状态
- (void)didEndEditing;

@optional
-(void)didSelectedSearchBtn;

@end

@interface HWSearchViewModel : UIView<UITextFieldDelegate>
{
    NSString * titleStr;
    
}
@property (nonatomic, strong) id<HWSearchViewModelDelegate> delegate;
@property(nonatomic,strong)UITextField * searchTF;
@property(nonatomic,strong)UIView * views;
@property(nonatomic,strong)NSString * type;

- (id)initWithDelegate:(id)myDelegate type:(NSString *)atype;

@end
