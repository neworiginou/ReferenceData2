//
//  HWImageScrollView.h
//  Test
//
//  Created by zhangxun on 14-9-4.
//  Copyright (c) 2014年 zhangxun. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol HWImageScrollViewDelegate <NSObject>

@optional
- (void)showPicker;
- (void)returnClickImage:(NSMutableArray *)arry currentIndex:(NSInteger)currentIndex gesture:(UITapGestureRecognizer *)tap;
-(void)deleLocalOnePic:(NSInteger)Deleteindex;


@end

@interface HWImageScrollView : UIScrollView<UIScrollViewDelegate,UIAlertViewDelegate>
{
    NSMutableArray *imageArray;
    BOOL _editingMode;
      NSInteger deleteIndex;//删图图片索引
    UIButton *saveDeletBtn;
    
}
@property (nonatomic,assign)id <HWImageScrollViewDelegate>del;
@property (nonatomic,strong)NSMutableArray *imageArray;;
@property (nonatomic,assign)BOOL submitShopFlag;
@property (nonatomic,strong)UIImageView *tempImageView;

- (void)addImage:(UIImage *)image;
- (id)initWithFrame:(CGRect)frame flag:(BOOL)submitShopFlag;

@end
