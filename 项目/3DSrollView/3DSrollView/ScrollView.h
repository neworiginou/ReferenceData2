//
//  ScrollView.h
//  3DSrollView
//
//  Created by lizhongqiang on 16/1/15.
//  Copyright © 2016年 lizhongqiang. All rights reserved.
//

#import <UIKit/UIKit.h>
typedef enum {
    Left=10,
    Right
}Direction;
@interface ScrollView : UIView<UIScrollViewDelegate>
@property (nonatomic, strong)UIScrollView *scrollView;
@property (nonatomic, assign)int currentPage;
@property (nonatomic, assign)int lastPage;
@property (nonatomic, assign)Direction direction;
@property (nonatomic, strong)NSArray *imagesArray;
@end
