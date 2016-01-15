//
//  HWPublichPicView.h
//  Community
//
//  Created by hw500027 on 15/6/12.
//  Copyright (c) 2015年 caijingpeng. All rights reserved.
//

#import "HWBaseRefreshView.h"

@protocol HWPublichPicViewDelegate <NSObject>

//去拍照或从相册选择图片
- (void)toSelectImage;

//编辑图片
- (void)toEditImage:(NSMutableArray *)picArray andSelectIndex:(NSInteger)index;

@end

@interface HWPublichPicView : HWBaseRefreshView

@property (nonatomic ,strong) id <HWPublichPicViewDelegate> picViewDelegate;
@property (nonatomic ,strong) NSMutableArray *picArray;
- (instancetype)initWithSingleLineFrame:(CGRect)frame withPicArray:(NSArray *)picArray;

//选完一张图片调用一次方法
- (void)fillWithPicDic:(NSMutableDictionary *)selectPic;

//编辑完图片 调用此方法 传入所有图片数组
- (void)fillWithFullPicArray:(NSMutableArray *)picArray;
@end
