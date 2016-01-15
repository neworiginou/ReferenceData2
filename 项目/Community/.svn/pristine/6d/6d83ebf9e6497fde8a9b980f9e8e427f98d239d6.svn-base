//
//  HWPublishRemarkView.h
//  Community
//
//  Created by hw500027 on 15/6/12.
//  Copyright (c) 2015年 caijingpeng. All rights reserved.
//

#import "HWBaseRefreshView.h"
#import "HWPublichPicView.h"

@protocol HWPublishRemarkView <NSObject>

- (void)didSelectImageWithActionSheet:(NSInteger)index;
- (void)didSelectImageToEditWithPicArray:(NSMutableArray *)picArrcy andSelectIndex:(NSInteger)index;

@end

@interface HWPublishRemarkView : HWBaseRefreshView
@property (nonatomic , strong) id <HWPublishRemarkView> publishRemarkViewDelegate;
@property (nonatomic , copy) NSDictionary *selectImageDic;
@property (nonatomic , strong) HWPublichPicView *picView;
@property (nonatomic , strong) UITextView *textView;
- (instancetype)initWithFrame:(CGRect)frame withTextViewPlaceHolder:(NSString *)placeholder;
@end
