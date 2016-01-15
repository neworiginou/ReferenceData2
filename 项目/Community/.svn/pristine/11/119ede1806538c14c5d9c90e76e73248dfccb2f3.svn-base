//
//  HWPraiseView.h
//  Community
//
//  Created by lizhongqiang on 15/1/15.
//  Copyright (c) 2015年 caijingpeng. All rights reserved.
//  点赞view
//  修改记录
//      李中强 2015-01-15 15:30:34 添加此类

#import <UIKit/UIKit.h>
#import "HWNeighbourItemClass.h"
//#import "HWDetailViewController.h"

@protocol HWPraiseViewDelegate <NSObject>

- (void)arrowClick;
- (void)siftClick;
- (void)praiseBefore;       //点赞后
- (void)changeLike:(NSDictionary *)dict;

@end


@interface HWPraiseView : UIView
{
    UIView *photoView;              //显示头像
    UIView *oldPhotoView;           //未点赞前头像
    UIImageView *newPhotoImg;       //点赞新加头像
    UIImageView *praiseImg;         //点赞 心
    UILabel *praiseLabel;           //点赞数
    int praiseNum;                  //点赞数
    
    UIImageView *arrowImg;
    UIButton *arrowBtn;
    
}
//
@property (nonatomic, strong) HWNeighbourItemClass *item;
@property (nonatomic, strong) NSMutableArray *praiseArr;        //点赞数组（网络+本地）
@property (nonatomic, assign) id <HWPraiseViewDelegate>delegate;
@property (nonatomic, strong) UIButton *selectBtn;              //
@property (nonatomic, strong) UILabel *siftLabel;               //筛选文字
@property (nonatomic, strong) UIImageView *siftArrowImg;        //筛选箭头
@property (nonatomic, assign) detailResource resourceType;
@property (nonatomic, strong) UILabel *commentLabel;            //评论数 label
@property (nonatomic,assign)detailResource detailType;
@property (nonatomic, strong) UIButton *praiseBtn;
@property (nonatomic, assign) BOOL chuanChuanMenCanNotHandle;   //串串门不可操作

- (id)initWithFrame:(CGRect)frame;

@end
